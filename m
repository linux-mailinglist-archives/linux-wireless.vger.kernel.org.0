Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C251814F1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 10:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgCKJcD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 05:32:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33893 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbgCKJcC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 05:32:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id j16so1242012otl.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2020 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZh96yJwqjs2m1eB1RacsZAnXZ32p2ExnRSpQLXaoog=;
        b=PjhU5IB1fMx6ztjT9Kc3aYf9MWDILjjpi6o2wlTtH7gasKgNbk2f8bPappYFl8bx90
         0w3eHT0l0e1J5hhplW0Nk2TM6WjoLnBie1Yu8loUBFmZwHWW/ZVJAwlTeej/Why3dgoJ
         JQCfr1woJFd0D0bv1Zid7KNHiBa83mhoCDpVreTlnJ0BxvPOS+DlvlVUFdKXddzzlH7Q
         MBwCtEp3s8iJ1PQkrRohIuNkLP738ivbxuepau7tYyHys75dqdmVABuv4SZd2NYafJkP
         /tC9l1nXz+FM4BFO88fwLiArNBNofZH/n3Pl/U7x6PGTxMYZ26VPSesz/6Sjuw+mnjho
         gE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZh96yJwqjs2m1eB1RacsZAnXZ32p2ExnRSpQLXaoog=;
        b=lS3de9rLadLnUQnS/x1YYmYqjUfkxLCBSdAbT1JTAXBegoQLd46eE3hfqC3NIUomc0
         2Nru7s8s0vOLDQ9QP6DbGPMtzH9QFz2E1SZR+8VyCY8YmMPXCRXgOFuuKP6TUfqFLMXL
         jdBq5YKyMnVMRyrZtVd+WzUeWbGuAZrIq03y7rLIH9jh+xwxsMna3ykxwXSPd+a5dhvh
         B76HO36gpV30d/XhJkSuv3eZSJoREq0VAUtTxicgoV0Xa5XMsJC27U5KYcxvPfV/BtWD
         07VEvkIgwuckpvZ6FnGoG9fhtelwwuD+F7n9CDsZEBkvlChlet533zfjkNLMJDyPtlKQ
         2MUQ==
X-Gm-Message-State: ANhLgQ0Q6tFpllxs42GTqpIiPRfbo51aP8jI584oaIyqHXVxpEeFEMLW
        8LGWCfz5qRG4V20ic6YlVuPXByy2/JDhpKw+mD5QhA==
X-Google-Smtp-Source: ADFU+vsW5ROFBbCtsftj+JN9Vk1O4nSbA63ymrFlk49e2we8YTjg2uqCmV0PDApeXk7xfmTmDi1//uAXgWYtmw/7dKQ=
X-Received: by 2002:a9d:6750:: with SMTP id w16mr1597459otm.33.1583919120090;
 Wed, 11 Mar 2020 02:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200309075852.11454-1-yhchuang@realtek.com> <20200309075852.11454-2-yhchuang@realtek.com>
In-Reply-To: <20200309075852.11454-2-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 11 Mar 2020 17:31:48 +0800
Message-ID: <CAB4CAwe5kmOOPiw-WBzLMKsXteNgnGzVPsH3pyakg6NfB57Emw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rtw88: add a debugfs entry to dump coex's info
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 9, 2020 at 3:59 PM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> Add a new entry "coex_info" in debugfs to dump coex's states for
> us to debug on coex's issues.
>
> The basic concept for co-existence (coex, usually for WiFi + BT)
> is to decide a strategy based on the current status of WiFi and
> BT. So, it means the WiFi driver requires to gather information
> from BT side and choose a strategy (TDMA/table/HW settings).
>
> Althrough we can easily check the current status of WiFi, e.g.,
> from kernel log or just dump the hardware registers, it is still
> very difficult for us to gather so many different types of WiFi
> states (such as RFE config, antenna, channel/band, TRX, Power
> save). Also we will need BT's information that is stored in
> "struct rtw_coex". So it is necessary for us to have a debugfs
> that can dump all of the WiFi/BT information required.
>
> Note that to debug on coex related issues, we usually need a
> longer period of time of coex_info dump every 2 seconds (for
> example, 30 secs, so we should have 15 times of coex_info's
> dump).
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>
> v1 -> v2
>  * don't ignore "ignore wlan command"
>
>  drivers/net/wireless/realtek/rtw88/coex.c     | 492 ++++++++++++++++++
>  drivers/net/wireless/realtek/rtw88/coex.h     |  10 +
>  drivers/net/wireless/realtek/rtw88/debug.c    |  17 +
>  drivers/net/wireless/realtek/rtw88/main.h     |  18 +
>  drivers/net/wireless/realtek/rtw88/rtw8822b.c |  30 ++
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c |  28 +
>  6 files changed, 595 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
> index f91dc21a8bf1..2dd95c8acd93 100644
> --- a/drivers/net/wireless/realtek/rtw88/coex.c
> +++ b/drivers/net/wireless/realtek/rtw88/coex.c
> +#ifdef CONFIG_RTW88_DEBUGFS
> +#define INFO_SIZE      80
> +
> +static int rtw_coex_addr_info(struct rtw_dev *rtwdev,
> +                             const struct rtw_reg_domain *reg,
> +                             char addr_info[], int n)
> +{
> +       const char *rf_prefix = "";
> +       const char *sep = n == 0 ? "" : "/ ";
> +       int ffs, fls;
> +       int max_fls;
> +
> +       if (INFO_SIZE - n <= 0)
> +               return 0;
> +
> +       switch (reg->domain) {
> +       case RTW_REG_DOMAIN_MAC32:
> +               max_fls = 31;
> +               break;
> +       case RTW_REG_DOMAIN_MAC16:
> +               max_fls = 15;
> +               break;
> +       case RTW_REG_DOMAIN_MAC8:
> +               max_fls = 7;
> +               break;
> +       case RTW_REG_DOMAIN_RF_A:
> +       case RTW_REG_DOMAIN_RF_B:
> +               rf_prefix = "RF_";
> +               max_fls = 19;
> +               break;
> +       default:
> +               return 0;
> +       }
> +
> +       ffs = __ffs(reg->mask);
> +       fls = __fls(reg->mask);
> +
> +       if (ffs == 0 && fls == max_fls)
> +               return snprintf(addr_info + n, INFO_SIZE - n, "%s%s%x",
> +                               sep, rf_prefix, reg->addr);
> +       else if (ffs == fls)
> +               return snprintf(addr_info + n, INFO_SIZE - n, "%s%s%x[%d]",
> +                               sep, rf_prefix, reg->addr, ffs);
> +       else
> +               return snprintf(addr_info + n, INFO_SIZE - n, "%s%s%x[%d:%d]",
> +                               sep, rf_prefix, reg->addr, fls, ffs);
> +}
> +
> +static int rtw_coex_val_info(struct rtw_dev *rtwdev,
> +                            const struct rtw_reg_domain *reg,
> +                            char val_info[], int n)
> +{
> +       const char *sep = n == 0 ? "" : "/ ";
> +       u8 rf_path;
> +
> +       if (INFO_SIZE - n <= 0)
> +               return 0;
> +
> +       switch (reg->domain) {
> +       case RTW_REG_DOMAIN_MAC32:
> +               return snprintf(val_info + n, INFO_SIZE - n, "%s0x%x", sep,
> +                               rtw_read32_mask(rtwdev, reg->addr, reg->mask));
> +       case RTW_REG_DOMAIN_MAC16:
> +               return snprintf(val_info + n, INFO_SIZE - n, "%s0x%x", sep,
> +                               rtw_read16_mask(rtwdev, reg->addr, reg->mask));
> +       case RTW_REG_DOMAIN_MAC8:
> +               return snprintf(val_info + n, INFO_SIZE - n, "%s0x%x", sep,
> +                               rtw_read8_mask(rtwdev, reg->addr, reg->mask));
> +       case RTW_REG_DOMAIN_RF_A:
> +               rf_path = RF_PATH_A;
> +               break;
> +       case RTW_REG_DOMAIN_RF_B:
> +               rf_path = RF_PATH_B;
> +               break;
> +       default:
> +               return 0;
> +       }
> +
> +       /* only RF go through here */
> +       return snprintf(val_info + n, INFO_SIZE - n, "%s0x%x", sep,
> +                       rtw_read_rf(rtwdev, rf_path, reg->addr, reg->mask));
> +}
> +
> +static void rtw_coex_set_coexinfo_hw(struct rtw_dev *rtwdev, struct seq_file *m)
> +{
> +       struct rtw_chip_info *chip = rtwdev->chip;
> +       const struct rtw_reg_domain *reg;
> +       char addr_info[INFO_SIZE];
> +       int n_addr = 0;
> +       char val_info[INFO_SIZE];
> +       int n_val = 0;
> +       int i;
> +
> +       for (i = 0; i < chip->coex_info_hw_regs_num; i++) {
> +               reg = &chip->coex_info_hw_regs[i];
> +
> +               n_addr += rtw_coex_addr_info(rtwdev, reg, addr_info, n_addr);
> +               n_val += rtw_coex_val_info(rtwdev, reg, val_info, n_val);
> +
> +               if (reg->domain == RTW_REG_DOMAIN_NL) {
> +                       seq_printf(m, "%-40s = %s\n", addr_info, val_info);
> +                       n_addr = 0;
> +                       n_val = 0;
> +               }
> +       }
> +
> +       if (n_addr != 0 && n_val != 0)
> +               seq_printf(m, "%-40s = %s\n", addr_info, val_info);
> +}
> +

Looks good to me. But I strongly suggest using scnprintf instead of
snprintf to prevent
potential buffer overflow.

Chris
