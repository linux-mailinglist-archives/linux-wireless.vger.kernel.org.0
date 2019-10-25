Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C702E48ED
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502585AbfJYKwG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 06:52:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41651 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390265AbfJYKwF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 06:52:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id p10so1285593qkg.8
        for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2019 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJyEnzvWjh6BqwEAaRaKIbFDEVVjj/sLXsvP5ADxiIw=;
        b=Q08xE32DjaLpJrddMuK3TyV4KtzsbCnYs2/VcxHlDDSDap2vALbY8pYkMKEBIALD9i
         XyP88p+UizhCM0RfhBi3GqgeqS0SpghiPoDyhWKhoSmsklIMD67A70mS1ZGXwDYmSVz5
         KNw1JJIR6rycliKAw/1VT0kRXYX07zGep+WQK0J0CLjKWFEg/SfspT/EJTrNbKnWW8RH
         kk30gcqkO6PorBrGhtCtNJrcOL5XnonRADqBt7+YSf4ftrYZtbX8ZBS28Y2uTWRUhsx2
         qRLxqmk2jj6kmU5X8j3fOnEmfiY/rNj5dRONQv0W1KTFUrmKyHjgoBkomaVN4OB1G1zO
         1XZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJyEnzvWjh6BqwEAaRaKIbFDEVVjj/sLXsvP5ADxiIw=;
        b=mPHM47DlxY7DoOcOAX0R0jP6SVECm29rGS8AnjcXBPHBFT8hPgTNNoLni+guQPwCA1
         LThqSCIbPWkrc9IljFk2oPMWOj4DjBtZpSUZ56qI+5hAIRdK4ESyd8WsIGEvpqy+zoWT
         5zvHbkGhdekW5ZH4reXdZ1jnGHo0HgOUZ/R4lnKQqg2j4Wt1S8PGUCtfC/7etvMlxvIY
         57Zohz1p3zIehlRWH++lV9FSj+HBZYYrEOyTR7HBsys8d1oV5Vs/ue6lp49LFLqcVYO6
         cJig2LodFrGKlcB1v4RwVWFLtxzLo5znjavqX7H01KTmNID5o2+REE/PwpA5vG6v5La7
         VLHA==
X-Gm-Message-State: APjAAAVWd4aL+5czR8W5BHyWcVqtUY2ACJfyqmlMwXR9z4hSUlJYYe6S
        yJ938arCUmCMJgo4A0cYrf4I2M3ev4AEPMIhpbYV5g==
X-Google-Smtp-Source: APXvYqyaW8nvrp3eYaqjxGJLzXyS5U6VGe6zMMOVX6JTZlQ3GucYk/dQCgB7YXMZdlufZNIzvDDB956nRtWXgmVF8yw=
X-Received: by 2002:a37:847:: with SMTP id 68mr2092452qki.366.1572000706203;
 Fri, 25 Oct 2019 03:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191025093345.22643-1-yhchuang@realtek.com> <20191025093345.22643-4-yhchuang@realtek.com>
In-Reply-To: <20191025093345.22643-4-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 25 Oct 2019 18:51:34 +0800
Message-ID: <CAB4CAwf_Y0tMG37nZDtsU9FmACaOB=eALCNCazVk1kbAvOE26Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] rtw88: use a module parameter to control LPS enter
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        g.schlmm@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 25, 2019 at 5:33 PM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> If the number of packets is less than the LPS threshold, driver
> can then enter LPS mode.
> And driver used to take RTW_LPS_THRESHOLD as the threshold. As
> the macro can not be changed after compiled, use a parameter
> instead.
>
> The larger of the threshold, the more traffic required to leave
> power save mode, responsive time could be longer, but also the
> power consumption could be lower.
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/main.c | 7 +++++--
>  drivers/net/wireless/realtek/rtw88/ps.h   | 2 --
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index 7c1b89c4fb6c..bff8a0b129d9 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c

> @@ -199,8 +202,8 @@ static void rtw_watch_dog_work(struct work_struct *work)
>         if (busy_traffic != test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags))
>                 rtw_coex_wl_status_change_notify(rtwdev);
>
> -       if (stats->tx_cnt > RTW_LPS_THRESHOLD ||
> -           stats->rx_cnt > RTW_LPS_THRESHOLD)
> +       if (stats->tx_cnt > rtw_lps_threshold ||
> +           stats->rx_cnt > rtw_lps_threshold)
>                 ps_active = true;
>         else
>                 ps_active = false;

The naming of 'ps_active' is a bit confusing. Per the commit message,
it will leave LPS
it tx/rx count > threshold. But I'll be misled by the name ps_active.
Does it mean the
current condition is PS active and ready to power sleep? I'd like to
rename it to old-fashioned
'lps_enter' to represent the action that would be taken. It would be
easier for me to understand.

Chris

> --
> 2.17.1
>
