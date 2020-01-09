Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1531356FE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2020 11:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgAIKeu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jan 2020 05:34:50 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40760 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgAIKeu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jan 2020 05:34:50 -0500
Received: by mail-oi1-f196.google.com with SMTP id c77so5432701oib.7
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2020 02:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4bHR8Igqv7fqN8UpWNLJPgjQ/fqfktYAaVH3dyHUyY=;
        b=CXIjeZkwETBPyFgRjijbT5m6KDKl0cOfHKHGZoWSO31h2ZaSK+LSOuw8gC171gNY4f
         xGDDd2g4U/A0VU/RWDG5TdsX7tPzFHrw2n9Rvg0KKuS0HZA6Sin4w94qcQ9m0DByMtTI
         5pnkbAtt9y32yfvE6lXHZbNlTh58mlp2wR367dvGxazj9v9YHPwHh9sKSYcCT7Q0uEgH
         ZZTfigGymlhhd6xF5g2KgvMoxJtmbYyv9Zfe6n6jowu87RbySYWwyB5OhwbTJNZeJKP7
         pGPPMZUCpJ30V6cRXqiKqvsKXpeScYFX4E47+IGdeJhZDAG1qsQTaGiJDLIIo+h0WA2e
         osDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4bHR8Igqv7fqN8UpWNLJPgjQ/fqfktYAaVH3dyHUyY=;
        b=mAI2Wqee0Lyli3z3giPkdTTcYKORMrqzYq8h+mujINWEgj4sM9VAbHON5LTrBZJmWv
         jChYskwLn/cXYW/0z+UoJIvGr6OHFE1BLaJnug9/v5cW019bO1mWl5AwCNic1imMr1R+
         h2i70/OleETBC1sqHsE+aDa0drVV1ajKBkyP3Dh1WTAxJYsvCN/oK8GblF8iCNHVbJfS
         nkU0oB4j+L1rlEZuFQnxv3fYEvhti0EeAE+ePsRNrmzxWynyygug+BvgL3Qg2XZ6RW8Y
         WLawRfSt9tIB0liP5yggdDG5hnU4+nM06X3PI+ZoY/tFL3xuMLcG37OEQrwEAFlv9XI2
         wqog==
X-Gm-Message-State: APjAAAVv8xlrIjA46zWCK3dRz7qpl0w3CE1c6lJM5XMvgv4dyXlzSvAA
        ctIba3p1FWEMApJfwMtnJPScp2y1sQs9+PMnDaehcJN7FxI=
X-Google-Smtp-Source: APXvYqwNxUjm+l1Qlr1El7NZPar57hQ66tZp6xgC2/8jIZwE4kNglmUvgxhXR9/nX3dsHwQB/tFDKKsCvOIhHxH0RZQ=
X-Received: by 2002:aca:4a87:: with SMTP id x129mr2435662oia.165.1578566089974;
 Thu, 09 Jan 2020 02:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20200107142729.17716-1-yhchuang@realtek.com>
In-Reply-To: <20200107142729.17716-1-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 9 Jan 2020 18:34:39 +0800
Message-ID: <CAB4CAwfmACpAF37rbgY7gLp=EKwOJBifSf7spNM+Qf++C1iZ_A@mail.gmail.com>
Subject: Re: [PATCH] rtw88: use shorter delay time to poll PS state
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jan 7, 2020 at 10:27 PM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> When TX packet arrives, driver should leave deep PS state to make
> sure the DMA is working. After requested to leave deep PS state,
> driver needs to poll the PS state to check if the mode has been
> changed successfully. The driver used to check the state of the
> hardware every 20 msecs, which means upon the first failure of
> state check, the CPU is delayed 20 msecs for next check. This is
> harmful for some time-sensitive applications such as media players.
>
> So, use shorter delay time each check from 20 msecs to 100 usecs.
> The state should be changed in several tries. But we still need
> to reserve ~15 msecs in total in case of the state just took too
> long to be changed successfully. If the states of driver and the
> hardware is not synchronized, the power state could be locked
> forever, which mean we could never enter/leave the PS state.
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
Reviewed-by: Chris Chiu <chiu@endlessm.com>
> ---
>  drivers/net/wireless/realtek/rtw88/ps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
> index 913e6f47130f..7a189a9926fe 100644
> --- a/drivers/net/wireless/realtek/rtw88/ps.c
> +++ b/drivers/net/wireless/realtek/rtw88/ps.c
> @@ -91,11 +91,11 @@ void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter)
>                         return;
>
>                 /* check confirm power mode has left power save state */
> -               for (polling_cnt = 0; polling_cnt < 3; polling_cnt++) {
> +               for (polling_cnt = 0; polling_cnt < 50; polling_cnt++) {
>                         polling = rtw_read8(rtwdev, rtwdev->hci.cpwm_addr);
>                         if ((polling ^ confirm) & BIT_RPWM_TOGGLE)
>                                 return;
> -                       mdelay(20);
> +                       udelay(100);
>                 }
>
>                 /* in case of fw/hw missed the request, retry */
> --
> 2.17.1
>
