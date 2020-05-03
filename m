Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036F11C2A91
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2020 09:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgECHcx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 May 2020 03:32:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:51483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgECHcx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 May 2020 03:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588491165;
        bh=uoob09LxJLs0gobxKyEW+QtzlTSyxelHj9VSxQ2F+3I=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HiMHS0lIx0/0O1SwaNLnYMlCmyWwr3H5snvsPBOCdFxRiIr9lNiA4fM/Jm6VPj/6e
         nwawRSCbaBjNFyH0916xk7x+GebGzAD8ykoyE0A88+MVzont9GJTuXK5ZDg5ibJK+W
         6PQZmJ7GvoEIvEjys3He7CK5pBpOedZZfyTJOB7A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQvD5-1jpgXC09Xr-00Nz7z; Sun, 03
 May 2020 09:32:45 +0200
Date:   Sun, 3 May 2020 09:32:33 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Ajay.Kathat@microchip.com
Cc:     oscar.carter@gmx.com, adham.abozaeid@microchip.com,
        gregkh@linuxfoundation.org, rachel.kim@atmel.com,
        johnny.kim@atmel.com, chris.park@atmel.com, dean.lee@atmel.com,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wilc1000: Increase the size of wid_list array
Message-ID: <20200503073232.GA3228@ubuntu>
References: <20200501170239.16917-1-oscar.carter@gmx.com>
 <555a8486-8a9f-44a6-3423-78981955765a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555a8486-8a9f-44a6-3423-78981955765a@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:1Fk6I+S2UPVYI2zrize4ngz6oBv54q9N7S4nJGLawbHJSt5ui0Y
 8M2hH+s/ELtXfIVx+pzJ0bQt5rCDjbtYKY/adVf2RriQKloHI6G7iLsrrCeNAgrWhXXgo84
 6MPd+xAOpIPsg7NycVOf/Shc1nat+2yKpPIOQVMVsBhLJMmq5nyiNqAKi799xclRSTbfcgh
 pFtLjNnskFcZNIQAPnDWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qkozY6zgPOo=:WSVdVn0EuuHnVuX3X/XSm6
 dXewnI1tbpGMn7qX466rUdAFps8i7II2TCVybSFZNLfJ0AiJdk2y/qHX0VuMmw0SPSuCiNhMo
 89M4eyr3O7+stK82zyTBp7U5y3O6fQckqzRLGkyxY7ztMjZ+UrdSBYRxJ4gjhI/SC+PUpAj4y
 S6iLZOZCA3yTj0Ytq0kAhDPflzc/UmUpt/iAPXavFzq2hILxFuMHrGR9btJTYnmL0OQcMpvhN
 0TPdWA088394HLOcwlrPQ5W63n3JawGxKBdhqtWICG3jgs8ujSb/2W7ZyrdEnfmPcqyPqiVPa
 IKlxZbGGP4fM/t/u4NKkFvUKvhIwAsyuqlI7kejmSh2JH4Clo6qlNzvPMAc5B/rQ2gBKvrfYY
 EUmqjnTf13aKLyvFhjbf4TLTeoYIP1dh2knfEdJRRTPRS/Egqho9DbTqNc01STMxKZq5sqULF
 qHc0hBkJh9nYc+aOJgd+DSlukjtJ5aRujclN6r59BVb3rbc/uKnUtLs4JgiJpjPvgCOHtdE1B
 Ull1LAA6+uXZqO9/VDJ3iC8gGPIAEdPJZKOkRF0k+bZiDwPd21xGbR2eHXBic9nsMOL2Hp9e5
 plbSfeQSYaUUkXVpHjbuZcK/L5B8w0E1dxzOtqrIG8Z4IX1qespAGRfaNfQNYu4eiFIPhxAqA
 jtE3esK+mJ2gjedNxNG3veupJSykKvgUBxAoHrXSPIy4j5gxsem+MK+jOMn9yfMJw/jwgmavq
 NKfA1OJ5GlYZfnlTPtJ1FMow26Cy5hdcJFGd99rBx9xkaOnsKOBpVWssN+b5XxbOi2SP8RUjB
 h8q/a40gpJdO805D1KWCSUT/0ApOkyRSgEjCkMWYIJyiCXaLlPx8Tyups/eJDoqsZma+evNJe
 fxAHfUYJch7LTzFJwt0CjjaT4AbhTBpoOJ9cD9O099n5o4ESoICI4rmKbM8vjQfSVhPObI3+M
 XRjBb6CfGWle2OeMXRuw8D++LtUfePg9lqbhGoU8zNfGsmzgh13nplmQYvuNILR3c2C6+o7JX
 lk6XD12gUy9eikQUkQNEz1gMCQQ+El8vvT/QU1nLUR4JUrExHEp+HO/GzBl0Mtwq5YHZVlIQM
 myEu7wf8NPX2yc+JEbsa9nRSylZ50e63CfA1vsgJ0bjQIvi3k7X9cq0isjZJvRECCgupFnInk
 sDOCCY1h4OKc6SD1RXgS/joY2EmheGVZ4q/sGw+m8CEsOC/EH3oN7zO2+gScYIsTMg+goO1LH
 RujQZHKhXe126NVXq
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 01, 2020 at 06:26:10PM +0000, Ajay.Kathat@microchip.com wrote:
>
> On 01/05/20 10:32 pm, Oscar Carter wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know=
 the content is safe
> >
> > Increase by one the size of wid_list array as index variable can reach=
 a
> > value of 5. If this happens, an out-of-bounds access is performed.
> >
> > Addresses-Coverity-ID: 1451981 ("Out-of-bounds access")
> > Fixes: c5c77ba18ea66 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
>
> The code changes are fine. But the correct commit for Fixes tag should b=
e
>
> Fixes: f5a3cb90b802d ("staging: wilc1000: add passive scan support")
>
Sorry for the mistake. I will make the change and I will send a new versio=
n.
>
> Regards,
> Ajay
>
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > ---
> >  drivers/staging/wilc1000/hif.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/wilc1000/hif.c b/drivers/staging/wilc1000=
/hif.c
> > index 6c7de2f8d3f2..128943c3be4f 100644
> > --- a/drivers/staging/wilc1000/hif.c
> > +++ b/drivers/staging/wilc1000/hif.c
> > @@ -151,7 +151,7 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source=
, u8 scan_type,
> >               void *user_arg, struct cfg80211_scan_request *request)
> >  {
> >         int result =3D 0;
> > -       struct wid wid_list[5];
> > +       struct wid wid_list[6];
> >         u32 index =3D 0;
> >         u32 i, scan_timeout;
> >         u8 *buffer;
> > --
> > 2.20.1
> >
Thanks,
Oscar
