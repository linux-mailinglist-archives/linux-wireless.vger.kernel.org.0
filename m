Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED63DAA1B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502016AbfJQKcc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 06:32:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33814 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501977AbfJQKcc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 06:32:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id f18so756288qkm.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2019 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vRwCO9XAqd/fessmQbp6e+hqmtBFcDTjY06QiOHWJ4=;
        b=odw5PTN/l1EAtM+JtnMJAeeJPhKsi62vTdsmDoQSUkG4hCesP1w/kg4EmPyZIJzwfu
         C6IAYUoIj4FeVLFSHnvV2RcCAJUOncaW+X09Ma3hBJpZT4O1f9tckMkNdGwxhkwi1Onb
         gQH9eQzuB3nqXw8/OHTiKZ3nV4IcN4xXUWjuTFLVZrdEVyX+HiMpjaNCSrV15szr4XO5
         fZaJslla1hnt26HDPZMqj3JiNOiV+lCzCtCEhdvyQZw36JHM0D6WMc7SEvilXBeGEUXB
         iRGP6qDhGl/8BWZYWXLCGcT7wsN6zClp40PrgusS+Q1CwgJhPBocMMrNJElG+i5jqSnW
         qILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vRwCO9XAqd/fessmQbp6e+hqmtBFcDTjY06QiOHWJ4=;
        b=Jkf8LSfICDv/uA9I4Ac7Tm4lK4S0nCbDQMkc7c697HftSH6u//8Pyechp55UMgZ314
         cCnDzsBotmMAjh1h4jWbIKq4/ddelb79Lk1IUHtXZWRmFCd86ydRrtDMaEEjcfsieGbU
         /hBiZ3DCQHePliqYUa3EbvW1AWZLdFLkttiTfLhnV3T/qZbhThm6hWXham8zvQ1lhpxJ
         OKapzy1nD6WQE7KmTPeS5aRE+UdxjzNBPRyXfQZ1FTgw53QvIdQdETnTLUhIthNFK+rA
         rShHXiqFSNqv5bdh4eBKGDedAzoRz30fdzmBQBUrA4F1oqqa4SIpap+5FmOjxo/a+ncq
         BVyQ==
X-Gm-Message-State: APjAAAW2XSePk2SQViNU3KDnoG8BXRwHk4PUuRJZrucpdn90oICsGnMx
        inlJM/AZhPl5Dol3hSh7N7mvvMmt5SfbxqWTGi3LFg==
X-Google-Smtp-Source: APXvYqwCxS+LYgY6V0nxJtNareUXq9W7pe5jsypfUtDFHN164JYZdw0DufYkijnIexMiTOoGw6bnp6ZUP083g0wxhSI=
X-Received: by 2002:a37:644f:: with SMTP id y76mr2583183qkb.369.1571308351035;
 Thu, 17 Oct 2019 03:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191016123301.2649-1-yhchuang@realtek.com> <20191016123301.2649-3-yhchuang@realtek.com>
In-Reply-To: <20191016123301.2649-3-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 17 Oct 2019 18:32:20 +0800
Message-ID: <CAB4CAwfFUibbZT9G8Y9Afx4fbGaXpnTVqM9-Z+vgjMVKSPUDQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] rtw88: add power tracking support
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 16, 2019 at 8:33 PM <yhchuang@realtek.com> wrote:
>
> From: Tzu-En Huang <tehuang@realtek.com>
>
> The temperature of the chip can affect the output power
> of the RF components. Hence driver requires to compensate
> the power by adjusting the power index recorded in the
> power swing table.
>
> And if the difference of current thermal value to the
> default thermal value exceeds a threshold, the RF IQK
> should be triggered to re-calibrate the characteristics
> of the RF components, to keep the output IQ vectors of
> the RF components orthogonal enough.
>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>
> v1 -> v2
>   * Use macros to check current band
>   * Some coding style refinement
>   * Not casting "const" pointers
>

> @@ -1220,7 +1265,9 @@ struct rtw_efuse {
>         u8 country_code[2];
>         u8 rf_board_option;
>         u8 rfe_option;
> -       u8 thermal_meter;
> +       u8 power_track_type;
> +       u8 thermal_meter[2];

The '2' is related to RTW_RF_PATH_MAX or something else? Please have a
descriptive macro for this.

> +       u8 thermal_meter_k;
>         u8 crystal_cap;
>         u8 ant_div_cfg;
>         u8 ant_div_type;
> +
> +bool rtw_phy_pwrtrack_thermal_changed(struct rtw_dev *rtwdev, u8 thermal,
> +                                     u8 path)
> +{
> +       struct rtw_dm_info *dm_info = &rtwdev->dm_info;
> +       u8 avg = ewma_thermal_read(&dm_info->avg_thermal[path]);
> +
> +       if (avg == thermal)
> +               return false;
> +
> +       return true;
> +}

Why not simplify this as pure if-else? It's a bit confusing.

> +bool rtw_phy_pwrtrack_need_iqk(struct rtw_dev *rtwdev)
> +{
> +       struct rtw_dm_info *dm_info = &rtwdev->dm_info;
> +       u8 delta_iqk;
> +
> +       delta_iqk = abs(dm_info->thermal_avg[0] - dm_info->thermal_meter_k);
> +       if (delta_iqk >= rtwdev->chip->iqk_threshold) {
> +               dm_info->thermal_meter_k = dm_info->thermal_avg[0];
> +               return true;
> +       }
> +       return false;
> +}

Is 'thermal_avg[0]' for RF_PATH_A? Or it means something else?
And it's also good to simplify it as a simple if-else.


> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> index baf5091fa253..8a018aefbe16 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> @@ -43,6 +43,8 @@ static int rtw8822b_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
>         efuse->country_code[1] = map->country_code[1];
>         efuse->bt_setting = map->rf_bt_setting;
>         efuse->regd = map->rf_board_option & 0x7;
> +       efuse->thermal_meter[0] = map->thermal_meter;
> +       efuse->thermal_meter_k = map->thermal_meter;
>
>         for (i = 0; i < 4; i++)
>                 efuse->txpwr_idx_table[i] = map->txpwr_idx_table[i];
> @@ -75,6 +77,49 @@ static void rtw8822b_phy_rfe_init(struct rtw_dev *rtwdev)
>         rtw_write32_mask(rtwdev, 0x974, (BIT(11) | BIT(10)), 0x3);
>  }
>

Is 'thermal_meter[0]' for RF_PATH_A, 1 for PATH_B?
Dose the '4' refer to RTW_RF_PATH_MAX or totally irrelevant? Same
question for the rtw8822c.c


- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -40,6 +40,11 @@ static int rtw8822c_read_efuse(struct rtw_dev
*rtwdev, u8 *log_map)
        efuse->country_code[1] = map->country_code[1];
        efuse->bt_setting = map->rf_bt_setting;
        efuse->regd = map->rf_board_option & 0x7;
+       efuse->thermal_meter[0] = map->path_a_thermal;
+       efuse->thermal_meter[1] = map->path_b_thermal;
+       efuse->thermal_meter_k =
+                       (map->path_a_thermal + map->path_b_thermal) >> 1;
+       efuse->power_track_type = (map->tx_pwr_calibrate_rate >> 4) & 0xf;

        for (i = 0; i < 4; i++)
                efuse->txpwr_idx_table[i] = map->txpwr_idx_table[i];

Same as above.

> +
> 2.17.1
>
