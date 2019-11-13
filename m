Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66568FAA11
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 07:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfKMGNu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 01:13:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35687 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfKMGNu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 01:13:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id n4so1402070qte.2
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 22:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8egHlGJMjuuAuvMnmcFtMV/J2mUbLVKD3E2DqthPlU=;
        b=OwJXuc73jTzk14sdBN824SNS4sKvOibNrgXrqSYHFmtvOFRFxSl8LFar5L1fjLWdUU
         fCYafm0aA9vw4up+xsWDZEDhJ55EoePEsrGdaaIPUv86KYZocWKhrwuB3gJg+BFz2lBc
         +4PwpeKbk0VouC+Qv0WgwYEdgwFCy4ZCkok1LWErdxvFODZxra6vpf9Nh9xnXFYUxL82
         mYXgVBj42BOiGZQPgczYtZ44HArYpbFzk2vp6vld1J8ehO4t3tg6aaSbJrySNsrGSISp
         tF3+jbUx5Hdk5wlu1wspJxXXZhut7gTAFrZ/BbwxBufpYqVPaqKFB5FqBkdcVMdF/8El
         JiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8egHlGJMjuuAuvMnmcFtMV/J2mUbLVKD3E2DqthPlU=;
        b=NIdPIpz8ja79sEGgtnkNs3A73+F44+8tCcGsqqGiWrcsdtltIXayIns3MdntyRpMVd
         Zp5c5B5PFvOKmr4MlBPZK9Npc127x7eACuhzGcxZO5DLoC+2s3K1DSte7RfAwKpRKgkk
         6lUZ4TVpaiQzSeT0kYE6ZkRHfQzKUigRZ3GpfW+lhuyVvM1FYVkw5TCB7X8jPjKTT2vB
         +3j7NTDKKC3AFdUvKCDI/Hr797FIji04yHi5PiUKgACJOQFrNDpimqMJRcaUqiEfcX7p
         qX+EY5Y6b1VTX9HgFvgTYXiXFZBfVrcIA18AlxlzVYg+myu3ADdIqMQ98b3iMEWGkfxk
         pr6g==
X-Gm-Message-State: APjAAAWh3LtU1ShtyfOKI5R6pvgnO5FfUOPJwB+98IV6BqD9z73HoM5z
        8hPArfdJNYl7st+wFmWVYF0Rd6GzHs8BSlGkwGiQkw==
X-Google-Smtp-Source: APXvYqw7ChBqvENqLqiVyQ4WVXX6Qz8Zw3Xv7qBNH7BmCaNdO7fUpjeOWwENm7ct/bunA8HL0YNwWPtuWCPLaEvf3C4=
X-Received: by 2002:ac8:3968:: with SMTP id t37mr1134372qtb.37.1573625627541;
 Tue, 12 Nov 2019 22:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20191107111603.12317-1-yhchuang@realtek.com> <20191107111603.12317-4-yhchuang@realtek.com>
In-Reply-To: <20191107111603.12317-4-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 13 Nov 2019 14:13:36 +0800
Message-ID: <CAB4CAwd6MDSyPTVGr-3T6nNTpJiJy1jEfNWtyriqoMJyV83jdw@mail.gmail.com>
Subject: Re: [PATCH 3/4] rtw88: pci: enable CLKREQ function if host supports it
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 7, 2019 at 7:16 PM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> By Realtek's design, there are two HW modules associated for CLKREQ,
> one is responsible to follow the PCIE host settings, and another
> is to actually working on it. But the module that is actually working
> on it is default disabled, and driver should enable that module if
> host and device have successfully sync'ed with each other.
>
> The module is default disabled because sometimes the host does not
> support it, and if there is any incorrect settings (ex. CLKREQ# is
> not Bi-Direction), device can be lost and disconnected to the host.
>
> So driver should first check after host and device are sync'ed, and
> the host does support the function and set it in configuration
> space, then driver can turn on the HW module to working on it.
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/pci.c | 83 ++++++++++++++++++++++++
>  drivers/net/wireless/realtek/rtw88/pci.h |  5 ++
>  2 files changed, 88 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
> index 6d1aa6f41e84..4fcef8a6fc42 100644
> --- a/drivers/net/wireless/realtek/rtw88/pci.c
> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> @@ -1081,6 +1081,33 @@ static void rtw_dbi_write8(struct rtw_dev *rtwdev, u16 addr, u8 data)
>         WARN(flag, "failed to write to DBI register, addr=0x%04x\n", addr);
>  }
>
> +static int rtw_dbi_read8(struct rtw_dev *rtwdev, u16 addr, u8 *value)
> +{
> +       u16 read_addr = addr & BITS_DBI_ADDR_MASK;
> +       u8 flag;
> +       u8 cnt;
> +
> +       rtw_write16(rtwdev, REG_DBI_FLAG_V1, read_addr);
> +       rtw_write8(rtwdev, REG_DBI_FLAG_V1 + 2, BIT_DBI_RFLAG >> 16);
> +
> +       for (cnt = 0; cnt < RTW_PCI_WR_RETRY_CNT; cnt++) {
> +               flag = rtw_read8(rtwdev, REG_DBI_FLAG_V1 + 2);
> +               if (flag == 0)
> +                       break;
Why not just doing ' rtw_read8(rtwdev, read_addr);' and return here?
Then you don't need to check the flag != 0 at the following. It would
make the code cleaner and same expressive.

> +
> +               udelay(10);
> +       }
> +
> +       if (flag != 0) {
> +               WARN(1, "failed to read DBI register, addr=0x%04x\n", addr);
> +               return -EIO;
> +       }
> +
> +       read_addr = REG_DBI_RDATA_V1 + (addr & 3);
> +       *value = rtw_read8(rtwdev, read_addr);
> +       return 0;
> +}
> +
> --
> 2.17.1
>
