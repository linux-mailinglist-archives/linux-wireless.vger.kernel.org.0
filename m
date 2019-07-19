Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD0C36E52A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 13:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfGSLqq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jul 2019 07:46:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33933 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSLqp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jul 2019 07:46:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so34273567edb.1;
        Fri, 19 Jul 2019 04:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RjARzg5zR4sNqCAhyFcjLu7rxBT3p+rIlkvUc8rVhiQ=;
        b=VY1552WQZvzoYZD3sBE9lelYE1UUAT8pSls5ltVkFgiiKPvJwyyr/CO1R//xyW5lYd
         fTZcrayyM/nu1HzDZjL/0MXfoZdJ3H/rcaUM+/jNFaLvURUH4S0NwgaS3Ad/DiofeqY+
         aQB36SR+ZQgIq4t4blzSKClgCK6ORqPlKjQPe6rYFVaqPOCZ3sv/wRXxz0BEy9Dm/WuW
         O4p0f+hcDiooDtPMrDzM3iwfJXpVRYxjDjMgWSly++3KQQBmYvHrAoNg4xwJGhvBfUlj
         UTiuQfj7I3D+s+bgBUCpz7wQNB+nbhEZZqwHiC1dQEzji06qmcnbJSPNAhbuLOs0w/lB
         oNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RjARzg5zR4sNqCAhyFcjLu7rxBT3p+rIlkvUc8rVhiQ=;
        b=NhMubGH1t4WjUtMYJQxl9mDoTU8+ItVYHbnQjD+u2CWYi7hiruhFqfVwn50d3a/Xc8
         Bip/C090SAfI9Momw6Vex6irAf/Dpq42Yf26yoXXnHxaVPcr5Lx69ZGSNr2oIZkufOtI
         cqnMTj56GTAm3OIxxHSfbjBgrJdg4PTh5vk6vGsPxpgxU2BsHnklQhTY6PBu76WDSjFK
         xKo0HWYob4QRR2cGyQi92sdAFGSrAbJDg6IO7P4Af4qcLGJgrEavk3C66pohsjkL51Rf
         6cei/P8TgbAgjR7Rh9rQhLhj4znDi9g23PcSVpR60XTsOgGOkI7VtTJFpt5QVNCUlzFh
         ONVw==
X-Gm-Message-State: APjAAAWRwa5Ai5j9WoLhVIYgeXr4MRz5LGmJwZvN5glXBk0BuX2cHv4S
        k/yaHxZFjHTwUDOvYHP59Q+27hfsi7GT+q4C4KwarXmr
X-Google-Smtp-Source: APXvYqzFIa0nGMa7OtRKqltr8DL6AJ3i87J6kwCMguH1ncVbWI/3NZw3JX8SKFgbNzycb1Q9eUrYZQPActnDwyvjj0k=
X-Received: by 2002:a05:6402:896:: with SMTP id e22mr42009941edy.202.1563536804148;
 Fri, 19 Jul 2019 04:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190719081005.4598-1-hslester96@gmail.com> <8c14743d-efe1-3e3a-0419-bde22f848751@microchip.com>
In-Reply-To: <8c14743d-efe1-3e3a-0419-bde22f848751@microchip.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Fri, 19 Jul 2019 19:46:32 +0800
Message-ID: <CANhBUQ3knUV44GiaB-xZMD8F6y8dcZQdznSmpk3E9ZKoakkBRQ@mail.gmail.com>
Subject: Re: [PATCH] staging: wilc1000: Merge memcpy + le32_to_cpus to get_unaligned_le32
To:     Ajay Singh <Ajay.Kathat@microchip.com>
Cc:     Adham Abozaeid <Adham.Abozaeid@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=8819=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=887:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On 7/19/2019 1:40 PM, Chuhong Yuan wrote:
> >
> > Merge the combo use of memcpy and le32_to_cpus.
> > Use get_unaligned_le32 instead.
> > This simplifies the code.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/driver=
s/staging/wilc1000/wilc_wfi_cfgoperations.c
> > index d72fdd333050..12fb4add05ec 100644
> > --- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> > +++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> > @@ -1038,8 +1038,7 @@ void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *bu=
ff, u32 size)
> >       s32 freq;
> >       __le16 fc;
> >
> > -     memcpy(&header, (buff - HOST_HDR_OFFSET), HOST_HDR_OFFSET);
> > -     le32_to_cpus(&header);
> > +     header =3D get_unaligned_le32(buff - HOST_HDR_OFFSET);
> >       pkt_offset =3D GET_PKT_OFFSET(header);
> >
> >       if (pkt_offset & IS_MANAGMEMENT_CALLBACK) {
> >
>
> Thanks for sending the patches.
>
> The code change looks okay to me. Just a minor comment, avoid the use of
> same subject line for different patches.

These two patches are in the same subsystem and solve the same problem.
I splitted them into two patches by mistake since I did not notice the prob=
lems
in the second patch when I sent the first one.
Should I merge the two patches and resend?

>
> Regards,
> Ajay
