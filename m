Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3B9E03F3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 14:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbfJVMg0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 08:36:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35760 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388405AbfJVMg0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 08:36:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15so26535802qtq.2
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 05:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zhu1KAZtQ1HS7peE9QZSsxQtKrNQtq4iPWiX2BndB0=;
        b=lAJ4djXQ/PKAR7vSyJ9vy6K+Bjm6ggru74pwakLmlGsjaeEVUFNpldWwMdxgkY0YKD
         +Fd3v1+zfpHnMqA1KoNfVndWK44tH+kmEZwVBDX+0EniN/4MuhoY8ZqlCLCDewWLk7K4
         ZY1Ghb3G4RbF4BEWCIpEBbDN0+MftuAonEYyrZekdlZGCjkJIgT/tG34duwjzQxeZHEo
         XrDTOsaDu2KMiVhzLu9mo6jv1QBi+OM8YXyB/8xqmbBeOk3CGGOzkC1A637iiBqKgm1Z
         PDj796bFMJGuHlQStbeQX6uxbiu3ZpQD+rzhTsWoB7B7gQzu04SQygxg6ZdJJaI837xx
         D/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zhu1KAZtQ1HS7peE9QZSsxQtKrNQtq4iPWiX2BndB0=;
        b=KKNGmOLThjri1y2Pbd2oNzVeQVaFm9qdtMcd5bxX8nBLoe6Lvgyi22PJAgmXWXxUxi
         32/RYjjv+kZZDELwOFu/87pg/3eviUEERdnyLrWRGExDT0/+7ntTWkXsqgM0AekXVOpm
         EYH6NxE3jo9BLkXjGxPo2mIVZ7izj8c17i9YKYWo3Q/0VGdGFaFrTvl00Fdcavb5E5+k
         4wLKc6z9NuRmDqAQJ3ohvYJdXGFEs6UQ5bmu8mqULQRAHeRiWpIMqm8bbHBQ2CTt2zJq
         zd91pWTkLqBMiLO2sq4TxRhIjPyNtV6gLZWuICLD2s23wpBPn2g2WMKvCxgNYUOV/AC3
         Jpuw==
X-Gm-Message-State: APjAAAW5d7GodDakdKKhz966X7EdXsHDsIaKhHkAL8/aKsTS8wi7sNz/
        diK/mDf35YSly6cEHcLlepUM+CEFIagIpUGy8YCVTg==
X-Google-Smtp-Source: APXvYqwWHthuheS675fvsdV4qAIG7Vh7LQAG699SVgZgMoE2m4bf37RMvFlu0R2AyRhDWvUEx5d0CAvSpzAPbnRT1bA=
X-Received: by 2002:ac8:488b:: with SMTP id i11mr2839724qtq.95.1571747785252;
 Tue, 22 Oct 2019 05:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191022100420.25116-1-yhchuang@realtek.com> <20191022100420.25116-3-yhchuang@realtek.com>
In-Reply-To: <20191022100420.25116-3-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 22 Oct 2019 20:36:14 +0800
Message-ID: <CAB4CAwes6r17gCGF-WKB=i9cN8dz6evA_g9SGzNdmJXsNcmTxQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] rtw88: add power tracking support
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 22, 2019 at 6:04 PM <yhchuang@realtek.com> wrote:
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
> v2 -> v3
>   * Use RF_PATH_* for thermal values
>
>  drivers/net/wireless/realtek/rtw88/fw.c       |   1 +
>  drivers/net/wireless/realtek/rtw88/main.h     |  49 ++-
>  drivers/net/wireless/realtek/rtw88/phy.c      | 126 +++++++
>  drivers/net/wireless/realtek/rtw88/phy.h      |  12 +
>  drivers/net/wireless/realtek/rtw88/rtw8822b.c | 330 ++++++++++++++++++
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 228 ++++++++++++
>  6 files changed, 745 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
> index 492a2bfc0d5a..757b0ce2bbee 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.h
> +++ b/drivers/net/wireless/realtek/rtw88/main.h
> +/* This table stores the values of TX power that will be adjusted by power
> + * tracking.
> + *
> + * For 5G bands, there are 3 different settings.
> + * For 2G there are cck rate and ofdm rate with different settings.
> + */
> +struct rtw_pwr_track_tbl {
> +       const u8 *pwrtrk_5gb_n[RTW_PWR_TRK_5G_NUM];
> +       const u8 *pwrtrk_5gb_p[RTW_PWR_TRK_5G_NUM];
> +       const u8 *pwrtrk_5ga_n[RTW_PWR_TRK_5G_NUM];
> +       const u8 *pwrtrk_5ga_p[RTW_PWR_TRK_5G_NUM];
> +       const u8 *pwrtrk_2gb_n;
> +       const u8 *pwrtrk_2gb_p;
> +       const u8 *pwrtrk_2ga_n;
> +       const u8 *pwrtrk_2ga_p;
> +       const u8 *pwrtrk_2g_cckb_n;
> +       const u8 *pwrtrk_2g_cckb_p;
> +       const u8 *pwrtrk_2g_ccka_n;
> +       const u8 *pwrtrk_2g_ccka_p;
> +};
> +
>  /* hardware configuration for each IC */
>  struct rtw_chip_info {
>         struct rtw_chip_ops *ops;
> @@ -1171,6 +1202,11 @@ struct rtw_phy_cck_pd_reg {
>  #define DACK_MSBK_BACKUP_NUM   0xf
>  #define DACK_DCK_BACKUP_NUM    0x2
>
> +struct rtw_swing_table {
> +       const u8 *p[RTW_RF_PATH_MAX];
> +       const u8 *n[RTW_RF_PATH_MAX];
> +};
> +
>  struct rtw_dm_info {
>         u32 cck_fa_cnt;
>         u32 ofdm_fa_cnt;
> @@ -1197,6 +1233,15 @@ struct rtw_dm_info {
>         u8 cck_gi_u_bnd;
>         u8 cck_gi_l_bnd;
>
> +       u8 tx_rate;
> +       u8 thermal_avg[RTW_RF_PATH_MAX];
> +       u8 thermal_meter_k;
> +       s8 delta_power_index[RTW_RF_PATH_MAX];

I don't see any chance that delta_power_index[] will be < 0. Either from
rtw_phy_pwrtrack_get_pwridx() or swing_table.

Maybe just use u8 instead of s8?

> +s8 rtw_phy_pwrtrack_get_pwridx(struct rtw_dev *rtwdev,
> +                              struct rtw_swing_table *swing_table,
> +                              u8 tbl_path, u8 therm_path, u8 delta)
> +{

Same as above.

> --
> 2.17.1
>

Then I think I have no problem other than above.

Chris
