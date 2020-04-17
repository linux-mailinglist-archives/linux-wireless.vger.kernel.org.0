Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51EC1ADA71
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 11:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDQJw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 05:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgDQJw2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 05:52:28 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC3AC061A0C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2020 02:52:26 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k133so1551622oih.12
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2020 02:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWcz0Yp2Ck9uXq9KmuKB7uj1ch1oN2IvV6pSf4WvLzw=;
        b=BsvEVDYl2M7Mti22dYk7vpc+mkMiXgEmaVJQkq/cv2uI+0wb25ZEUhJdGtYnrciaQ8
         u0fejA2KF0qJHrIXxLP2NSyH98wC5Op2YSJM1qhx/3Pq7lG3st2eCbO4suB6QxL/zvay
         qpHV3gjdMvP0Csxvea2y543eEIj3z8FaWFqy52McvImwCt/zORD+9Byv3TPeF8k+teY+
         QpmwXUR2oi2oL4ZoBfhikB9zKXg1EK0yNoKCweymfcOU9IBZeHraaYd7YDuUd3VsMBgv
         hx7hYWToPtuJe1CONU5YZwCahQrPtqgIh70qjitEk4R4TuB0KWFPQ/DTK7KPTIWH23BE
         9UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWcz0Yp2Ck9uXq9KmuKB7uj1ch1oN2IvV6pSf4WvLzw=;
        b=NVmW9no+y7KVM44bsMhRuoCz/6bPSUn8ECn6nlkpu4hrW9Pj/hjP0RfcDP9LkKx5I2
         HZHLaqQ4BYROIgGlZT2LKcxVmgqr80vuBKH3H52PrlX48zwJIIrZic9OTD81gOcTd99C
         fRfaj4GNk5Z3ojhQLxFR9CwjTT7KLc0cvtLPOdx0ofdD83Ozyq5gI6DQk8M9xPbEPFhP
         voR+POvc3yKnNiHoqFShevOnSbubKOsFNsT8D5Q3iz2+HSvtDWuzGHhoRe/nNk5WYZEb
         thLTDcCXLC8LcL290PCIhBGtXZ4FT/r55rEWDJBsmntgToERgEv/5d2+Ejx8LYdQc13V
         pECQ==
X-Gm-Message-State: AGi0PuabOQIgbhzO6IWhhOqJ2EU//ldTa3S8rs65Srua0ZrfzxBzcjLC
        0IwdgKoL25dlArm9sEH8z6Tg4p0NvsHnfvFOs8ITDw==
X-Google-Smtp-Source: APiQypJ2fgGD6dBMa2xBtuCAmOmuubG28TzSKGnwAKuxsLUEKcwO7WVxLXr1VpHUoZw5k2xzkXmbUbwTrZGtpRX2wU4=
X-Received: by 2002:aca:c6ca:: with SMTP id w193mr1470633oif.165.1587117146005;
 Fri, 17 Apr 2020 02:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200417062758.2100-1-yhchuang@realtek.com>
In-Reply-To: <20200417062758.2100-1-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 17 Apr 2020 17:51:46 +0800
Message-ID: <CAB4CAwcuGNmy1Dp4fTB2cuec8vjFi=Rr-+q5g2KDPK2u=JkpyA@mail.gmail.com>
Subject: Re: [PATCH v3] rtw88: set power trim according to efuse PG values
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 17, 2020 at 2:28 PM <yhchuang@realtek.com> wrote:
>
> From: Tzu-En Huang <tehuang@realtek.com>
>
> 8822C devices have power trim, thermal and PA bias values
> programmed in efuse. Driver should configure the RF components
> according to the values.
>
> If the power trim is not configured, then the devices might have
> distortion on the output tx power.
>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
Reviewed-by: Chris Chiu <chiu@endlessm.com>

>
> v1 -> v2
>   * disable DPD low rates
>
> v2 -> v3
>   * use read_poll_timeout()
>
>  drivers/net/wireless/realtek/rtw88/efuse.c    |  20 ++++
>  drivers/net/wireless/realtek/rtw88/efuse.h    |   3 +
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 113 ++++++++++++++++++
>  drivers/net/wireless/realtek/rtw88/rtw8822c.h |  28 +++++
>  4 files changed, 164 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/efuse.c b/drivers/net/wireless/realtek/rtw88/efuse.c
> index 212c8376a8c9..54b01360a9b8 100644
> --- a/drivers/net/wireless/realtek/rtw88/efuse.c
> +++ b/drivers/net/wireless/realtek/rtw88/efuse.c
> @@ -116,6 +116,26 @@ static int rtw_dump_physical_efuse_map(struct rtw_dev *rtwdev, u8 *map)
>         return 0;
>  }
>
> +int rtw_read8_physical_efuse(struct rtw_dev *rtwdev, u16 addr, u8 *data)
> +{
> +       u32 efuse_ctl;
> +       int ret;
> +
> +       rtw_write32_mask(rtwdev, REG_EFUSE_CTRL, 0x3ff00, addr);
> +       rtw_write32_clr(rtwdev, REG_EFUSE_CTRL, BIT_EF_FLAG);
> +
> +       ret = read_poll_timeout(rtw_read32, efuse_ctl, efuse_ctl & BIT_EF_FLAG,
> +                               1000, 100000, false, rtwdev, REG_EFUSE_CTRL);
> +       if (ret) {
> +               *data = EFUSE_READ_FAIL;
> +               return ret;
> +       }
> +
> +       *data = rtw_read8(rtwdev, REG_EFUSE_CTRL);
> +
> +       return 0;
> +}
> +
>  int rtw_parse_efuse_map(struct rtw_dev *rtwdev)
>  {
>         struct rtw_chip_info *chip = rtwdev->chip;
> diff --git a/drivers/net/wireless/realtek/rtw88/efuse.h b/drivers/net/wireless/realtek/rtw88/efuse.h
> index 115bbe85946a..97a51f0b0e46 100644
> --- a/drivers/net/wireless/realtek/rtw88/efuse.h
> +++ b/drivers/net/wireless/realtek/rtw88/efuse.h
> @@ -10,6 +10,8 @@
>  #define EFUSE_HW_CAP_SUPP_BW80         7
>  #define EFUSE_HW_CAP_SUPP_BW40         6
>
> +#define EFUSE_READ_FAIL                        0xff
> +
>  #define GET_EFUSE_HW_CAP_HCI(hw_cap)                                          \
>         le32_get_bits(*((__le32 *)(hw_cap) + 0x01), GENMASK(3, 0))
>  #define GET_EFUSE_HW_CAP_BW(hw_cap)                                           \
> @@ -22,5 +24,6 @@
>         le32_get_bits(*((__le32 *)(hw_cap) + 0x01), GENMASK(27, 26))
>
>  int rtw_parse_efuse_map(struct rtw_dev *rtwdev);
> +int rtw_read8_physical_efuse(struct rtw_dev *rtwdev, u16 addr, u8 *data);
>
>  #endif
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> index c99b1de54bfc..ee0d39135617 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> @@ -15,6 +15,7 @@
>  #include "debug.h"
>  #include "util.h"
>  #include "bf.h"
> +#include "efuse.h"
>
>  static void rtw8822c_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
>                                      u8 rx_path, bool is_tx2_path);
> @@ -1000,10 +1001,122 @@ static void rtw8822c_rf_x2_check(struct rtw_dev *rtwdev)
>         }
>  }
>
> +static void rtw8822c_set_power_trim(struct rtw_dev *rtwdev, s8 bb_gain[2][8])
> +{
> +#define RF_SET_POWER_TRIM(_path, _seq, _idx)                                   \
> +               do {                                                            \
> +                       rtw_write_rf(rtwdev, _path, 0x33, RFREG_MASK, _seq);    \
> +                       rtw_write_rf(rtwdev, _path, 0x3f, RFREG_MASK,           \
> +                                    bb_gain[_path][_idx]);                     \
> +               } while (0)
> +       u8 path;
> +
> +       for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
> +               rtw_write_rf(rtwdev, path, 0xee, BIT(19), 1);
> +               RF_SET_POWER_TRIM(path, 0x0, 0);
> +               RF_SET_POWER_TRIM(path, 0x1, 1);
> +               RF_SET_POWER_TRIM(path, 0x2, 2);
> +               RF_SET_POWER_TRIM(path, 0x3, 2);
> +               RF_SET_POWER_TRIM(path, 0x4, 3);
> +               RF_SET_POWER_TRIM(path, 0x5, 4);
> +               RF_SET_POWER_TRIM(path, 0x6, 5);
> +               RF_SET_POWER_TRIM(path, 0x7, 6);
> +               RF_SET_POWER_TRIM(path, 0x8, 7);
> +               RF_SET_POWER_TRIM(path, 0x9, 3);
> +               RF_SET_POWER_TRIM(path, 0xa, 4);
> +               RF_SET_POWER_TRIM(path, 0xb, 5);
> +               RF_SET_POWER_TRIM(path, 0xc, 6);
> +               RF_SET_POWER_TRIM(path, 0xd, 7);
> +               RF_SET_POWER_TRIM(path, 0xe, 7);
> +               rtw_write_rf(rtwdev, path, 0xee, BIT(19), 0);
> +       }
> +#undef RF_SET_POWER_TRIM
> +}
> +
> +static void rtw8822c_power_trim(struct rtw_dev *rtwdev)
> +{
> +       u8 pg_pwr = 0xff, i, path, idx;
> +       s8 bb_gain[2][8] = {0};
> +       u16 rf_efuse_2g[3] = {PPG_2GL_TXAB, PPG_2GM_TXAB, PPG_2GH_TXAB};
> +       u16 rf_efuse_5g[2][5] = {{PPG_5GL1_TXA, PPG_5GL2_TXA, PPG_5GM1_TXA,
> +                                 PPG_5GM2_TXA, PPG_5GH1_TXA},
> +                                {PPG_5GL1_TXB, PPG_5GL2_TXB, PPG_5GM1_TXB,
> +                                 PPG_5GM2_TXB, PPG_5GH1_TXB} };
> +       bool set = false;
> +
> +       for (i = 0; i < ARRAY_SIZE(rf_efuse_2g); i++) {
> +               rtw_read8_physical_efuse(rtwdev, rf_efuse_2g[i], &pg_pwr);
> +               if (pg_pwr == EFUSE_READ_FAIL)
> +                       continue;
> +               set = true;
> +               bb_gain[RF_PATH_A][i] = FIELD_GET(PPG_2G_A_MASK, pg_pwr);
> +               bb_gain[RF_PATH_B][i] = FIELD_GET(PPG_2G_B_MASK, pg_pwr);
> +       }
> +
> +       for (i = 0; i < ARRAY_SIZE(rf_efuse_5g[0]); i++) {
> +               for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
> +                       rtw_read8_physical_efuse(rtwdev, rf_efuse_5g[path][i],
> +                                                &pg_pwr);
> +                       if (pg_pwr == EFUSE_READ_FAIL)
> +                               continue;
> +                       set = true;
> +                       idx = i + ARRAY_SIZE(rf_efuse_2g);
> +                       bb_gain[path][idx] = FIELD_GET(PPG_5G_MASK, pg_pwr);
> +               }
> +       }
> +       if (set)
> +               rtw8822c_set_power_trim(rtwdev, bb_gain);
> +
> +       rtw_write32_mask(rtwdev, REG_DIS_DPD, DIS_DPD_MASK, DIS_DPD_RATEALL);
> +}
> +
> +static void rtw8822c_thermal_trim(struct rtw_dev *rtwdev)
> +{
> +       u16 rf_efuse[2] = {PPG_THERMAL_A, PPG_THERMAL_B};
> +       u8 pg_therm = 0xff, thermal[2] = {0}, path;
> +
> +       for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
> +               rtw_read8_physical_efuse(rtwdev, rf_efuse[path], &pg_therm);
> +               if (pg_therm == EFUSE_READ_FAIL)
> +                       return;
> +               /* Efuse value of BIT(0) shall be move to BIT(3), and the value
> +                * of BIT(1) to BIT(3) should be right shifted 1 bit.
> +                */
> +               thermal[path] = FIELD_GET(GENMASK(3, 1), pg_therm);
> +               thermal[path] |= FIELD_PREP(BIT(3), pg_therm & BIT(0));
> +               rtw_write_rf(rtwdev, path, 0x43, RF_THEMAL_MASK, thermal[path]);
> +       }
> +}
> +
> +static void rtw8822c_pa_bias(struct rtw_dev *rtwdev)
> +{
> +       u16 rf_efuse_2g[2] = {PPG_PABIAS_2GA, PPG_PABIAS_2GB};
> +       u16 rf_efuse_5g[2] = {PPG_PABIAS_5GA, PPG_PABIAS_5GB};
> +       u8 pg_pa_bias = 0xff, path;
> +
> +       for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
> +               rtw_read8_physical_efuse(rtwdev, rf_efuse_2g[path],
> +                                        &pg_pa_bias);
> +               if (pg_pa_bias == EFUSE_READ_FAIL)
> +                       return;
> +               pg_pa_bias = FIELD_GET(PPG_PABIAS_MASK, pg_pa_bias);
> +               rtw_write_rf(rtwdev, path, 0x60, RF_PABIAS_2G_MASK, pg_pa_bias);
> +       }
> +       for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
> +               rtw_read8_physical_efuse(rtwdev, rf_efuse_5g[path],
> +                                        &pg_pa_bias);
> +               pg_pa_bias = FIELD_GET(PPG_PABIAS_MASK, pg_pa_bias);
> +               rtw_write_rf(rtwdev, path, 0x60, RF_PABIAS_5G_MASK, pg_pa_bias);
> +       }
> +}
> +
>  static void rtw8822c_rf_init(struct rtw_dev *rtwdev)
>  {
>         rtw8822c_rf_dac_cal(rtwdev);
>         rtw8822c_rf_x2_check(rtwdev);
> +       rtw8822c_thermal_trim(rtwdev);
> +       rtw8822c_power_trim(rtwdev);
> +       rtw8822c_pa_bias(rtwdev);
>  }
>
>  static void rtw8822c_pwrtrack_init(struct rtw_dev *rtwdev)
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
> index dfd8662a0c0e..32b4771e04d0 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
> @@ -309,4 +309,32 @@ const struct rtw_table name ## _tbl = {                    \
>  #define BIT_GS_PWSF            GENMASK(27, 0)
>  #define BIT_RPT_DGAIN          GENMASK(27, 16)
>  #define BIT_TX_CFIR            GENMASK(31, 30)
> +
> +#define PPG_THERMAL_A 0x1ef
> +#define PPG_THERMAL_B 0x1b0
> +#define RF_THEMAL_MASK GENMASK(19, 16)
> +#define PPG_2GL_TXAB 0x1d4
> +#define PPG_2GM_TXAB 0x1ee
> +#define PPG_2GH_TXAB 0x1d2
> +#define PPG_2G_A_MASK GENMASK(3, 0)
> +#define PPG_2G_B_MASK GENMASK(7, 4)
> +#define PPG_5GL1_TXA 0x1ec
> +#define PPG_5GL2_TXA 0x1e8
> +#define PPG_5GM1_TXA 0x1e4
> +#define PPG_5GM2_TXA 0x1e0
> +#define PPG_5GH1_TXA 0x1dc
> +#define PPG_5GL1_TXB 0x1eb
> +#define PPG_5GL2_TXB 0x1e7
> +#define PPG_5GM1_TXB 0x1e3
> +#define PPG_5GM2_TXB 0x1df
> +#define PPG_5GH1_TXB 0x1db
> +#define PPG_5G_MASK GENMASK(4, 0)
> +#define PPG_PABIAS_2GA 0x1d6
> +#define PPG_PABIAS_2GB 0x1d5
> +#define PPG_PABIAS_5GA 0x1d8
> +#define PPG_PABIAS_5GB 0x1d7
> +#define PPG_PABIAS_MASK GENMASK(3, 0)
> +#define RF_PABIAS_2G_MASK GENMASK(15, 12)
> +#define RF_PABIAS_5G_MASK GENMASK(19, 16)
> +
>  #endif
> --
> 2.17.1
>
