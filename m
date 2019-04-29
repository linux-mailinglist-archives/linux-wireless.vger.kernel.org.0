Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F929E184
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 13:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfD2Lnp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 07:43:45 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:41453 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbfD2Lno (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 07:43:44 -0400
Received: by mail-vs1-f51.google.com with SMTP id g187so5669550vsc.8
        for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2019 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TvwnhKHTg6HCl6sNwzulye0OOmMFajcVKCgGOCuLFA=;
        b=ZoCDGIuWMyHDtUk5r34kPa+RCBU0+pcASq1+zoNjUBzr1ehfE0mEMNsr11CGSqAYti
         WSMjMbbFyRx1R22tQMJ6gzlza/C91cQLhqUSm6Jda61VhFZu9KCAGRc06T3nYjs5sV8T
         EKUTpVtpYHBpCofti5cO0sRmF4RIeQ4/O9vHpwP5yo0QsVoNFm1/PLsDPDUtxkmNlNYA
         WGMSk4pu2aq/Q/qfW3SJFhtpbGD5XaMPksfGbxqXfA7vu/LPUChfexGJDYIBq5xdSFY3
         zfjeSpoy9vzHq0uTQb1TmmBrmiBijck/v3EOowEPkhi4FcQZwckvjBkyjDDYwvD50dTL
         HVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TvwnhKHTg6HCl6sNwzulye0OOmMFajcVKCgGOCuLFA=;
        b=LCtEvI8r5TczHo1tmkr+6uXmdD2XRUZnIcw+W4Hxc0OQvJbrleKYUzqeZtlYovw92X
         JqGeya+T7mZ1b+UTt6yCAxClHUTTDPo6EW1fDVEcn9LaLj5978TSkIWDE5qGQTVlDU8u
         0JL+O5EuYII4BHPw9B3Nad2yu6ZmwOX5ydJAyI7BrPhBiqzNmQZtnAa0cxh5JtMhGkgM
         fHYVZ4lTHakqHbiijrus9kZYG5cK4CPWciXqoeJ6nQrlQIHH0hfBoHEa7Wu1UbtW8wX9
         xl++JTnAuvgkSBOtunFCye3Oowib+I35Xfrd3nsCpYv3/FaRkTdCPS9BHj93qmTwIidO
         WM1A==
X-Gm-Message-State: APjAAAWb58u+MFLMK4xlGmlagGgQ14IpCFyckZCMZTGkulHzco7jMcJ4
        tt6dP7T2h6L4vaLA0n3Vt18mgJBjzaQgDBO5V3g=
X-Google-Smtp-Source: APXvYqxtF6xRo0nvdDoaOnoNJBZHfO7v+e1aQuym6mvYvJm4fP9hNcJWu0xVTf1ScVqwVkCddxa/ENYA56IHeadcd5g=
X-Received: by 2002:a67:8155:: with SMTP id c82mr2682987vsd.200.1556538223486;
 Mon, 29 Apr 2019 04:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.20.1904261625060.21912@hadrien> <871s1ovmo4.fsf@kamboji.qca.qualcomm.com>
 <CANGSkXSYfzn5oxsRvCrAWiS0itY-aVVC+=Qea506kkjq6TfYjg@mail.gmail.com> <87r29ou6td.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87r29ou6td.fsf@kamboji.qca.qualcomm.com>
From:   Siva Rebbagondla <siva8118@gmail.com>
Date:   Mon, 29 Apr 2019 17:13:32 +0530
Message-ID: <CANGSkXQUsqaT-OuLZfgMOrK5jTw7QAaDh9T=B0452hmw=_5wRQ@mail.gmail.com>
Subject: Re: [wireless-drivers-next:master 21/45] drivers/net/wireless/rsi/rsi_91x_usb.c:774:17-26:
 ERROR: id is NULL but dereferenced. (fwd)
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Julia Lawall <julia.lawall@lip6.fr>, kbuild-all@01.org,
        Linux Wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi kalle,

On Fri, Apr 26, 2019 at 8:55 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Siva Rebbagondla <siva8118@gmail.com> writes:
>
> > On Fri, Apr 26, 2019 at 8:28 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> >
> >> Julia Lawall <julia.lawall@lip6.fr> writes:
> >>
> >> > The ifs starting on line 766 can fail because id is NULL.
> >
> > I don't think id will be NULL here. id is coming from probe.
> > Is there any other opinions?.
>
> The code in question:
>
>         if (id && id->idProduct == RSI_USB_PID_9113) {
>                 rsi_dbg(INIT_ZONE, "%s: 9113 module detected\n", __func__);
>                 adapter->device_model = RSI_DEV_9113;
>         } else if (id && id->idProduct == RSI_USB_PID_9116) {
>                 rsi_dbg(INIT_ZONE, "%s: 9116 module detected\n", __func__);
>                 adapter->device_model = RSI_DEV_9116;
>         } else {
>                 rsi_dbg(ERR_ZONE, "%s: Unsupported RSI device id 0x%x\n",
>                         __func__, id->idProduct);
>                 goto err1;
>         }
>
> I think the fact that you are checking if id is NULL is confusing the
> static checkers. If it's never NULL why check for that anyway? So if
> it's guaranteed that id is never NULL (I didn't check that from USB
> core) I would recommend to remove the NULL checks from the driver.
Yes Kalle. I agree. I will make the change and send you for the review.

---
Siva Rebbagondla
