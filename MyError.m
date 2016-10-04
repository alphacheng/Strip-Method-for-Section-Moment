function [Err,M]=MyError(b,h,a1,a2,As1,As2,ec,phi,ctype,rtype1,rtype2,pull_limit)
% 1������������2������ѹ��
if nargin<12
    pull_limit=2*10^(-4);
    if nargin<11
        rtype2=335;
        if nargin<10
            rtype1=335;
            if nargin<9
                ctype=30;
            end
        end
    end
end
if phi~=0
    xn=ec/phi;
    es1=phi*(h-a1-xn);
    es2=phi*(xn-a2);
    y=0:xn/1000:xn;
    e=phi*y;
    %% ��ѹ��������
    C=trapz(y,Concrete_c(e,ctype))*b;
    yc=trapz(y,y.*Concrete_c(e,ctype))*b/C;

    %% ������������
    xt=pull_limit/phi;
%     if xt<h0-xn
%         y=0:xt/1000:xt;
%         e=phi*y;
%         Tc=trapz(y,Concrete_t(e,ctype,pull_limit))*b;
%         yt=trapz(y,y.*Concrete_t(e,ctype,pull_limit))*b/Tc;
%     else
        y=0:((h-a1)-xn)/1000:(h-a1)-xn;
        e=phi*y;
        Tc=trapz(y,Concrete_t(e,ctype,pull_limit))*b;
        yt=trapz(y,y.*Concrete_t(e,ctype,pull_limit))*b/Tc;
%     end

    %% �������ֽ�
%     e=phi*(h0-xn);
    Ts1=As1*Rebar(es1,rtype1);

    %% ��ѹ���ֽ�
    Ts2=As2*Rebar(es2,rtype2);
    %% �������
    Err=C+Ts2-Tc-Ts1;
    M=C*yc+Tc*yt+Ts1*(h-a1-xn)+Ts2*(xn-a2);
else
    Err=0;
    M=0;
end
end
