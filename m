Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E01A9F91
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 14:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368682AbgDOMOi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 08:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409315AbgDOLqm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 07:46:42 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF24C061A0C
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2020 04:46:41 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f52so3045586otf.8
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2020 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7rpIRxSlxq6ZrndBi3jdsN7ZE7OLYgVylzaGdjaDoU=;
        b=x+D/vaN/FRnWzN5mUafFF7nFszteo6CdW8G+UqinFWYTBzZYABR3FTC/oOqCmim7CF
         3S4QIeDhKjqaKMZi5xmdOHSFNIgZ0gHgbaMErjUXi3goUGheMVlDzR6rh9Z7vK2TbmqG
         bSBQyRVEAgvIEf9UBuVEh3o1SVSzysSQQOwYS+F/Tx2WquAaPaKvTfvajfSH9o+8nX3d
         l/pzK2RcTnkASSot1dciuP0ituPV7pmDgPbe2ZSJSrbD3iexOVgY+sI3/F44hpuQz3RY
         YJSRJm00POcSFGVI4VmfEKBsUoiV3pCAZyyJq0gAb8hz1FSJh/QvIcMwqwdauIdZ7zYf
         FVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7rpIRxSlxq6ZrndBi3jdsN7ZE7OLYgVylzaGdjaDoU=;
        b=OFSA4e/pPRRI71hu2ktAgxX0HUGYvy1GCZMNI4GtBqZrmbY+VMxWURCZxPT7KOxWzM
         GqqkkJYV8d/B0feQYDxwU7Rsqmf/3aunYkf11G9Gd6Nu0wKx9wpjsLsX3l1liXYDgPjC
         /vdwmHt7+XnDpcNoYHlpVlV5eHr4RITyek0E31gkqDbT0WlFaqW+BqLvcX9fRk9m5nsd
         bCgzFrGfq0yy1GM76CgA+4jird76Co8pIg8Vl3vgKdjK7GLtHV71mpmzq8Z6bbd7it95
         tQllPKKAnlcwpbXln2EOxFVDT31c6Eo3bDdq3F5Wm5tB0bGgqz2KEIq+E6f7wT9D4cZm
         nl3g==
X-Gm-Message-State: AGi0PuYNL1iw96yeA8s1QkkmaTkxAr0YvzXOvWHQl+D2BAwfuHH8AKK+
        2cr57PZDq94krFy+6uNsxolOb35zD4/Z1WodnajUoQ==
X-Google-Smtp-Source: APiQypI5KRT2Y8f/7bxZUqvtMJuG+D7GxZyuH//ZhainYjtNDYgAa8Ajq4y7B6eCwXNGKX7SiV697AxjlZ3N9Nzd0Bc=
X-Received: by 2002:a9d:c61:: with SMTP id 88mr22923751otr.144.1586951200986;
 Wed, 15 Apr 2020 04:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200415095912.18194-1-yhchuang@realtek.com>
In-Reply-To: <20200415095912.18194-1-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 15 Apr 2020 19:46:30 +0800
Message-ID: <CAB4CAwfc+ABsNte5BYqmMjU5epX7LViW7HPxir5xUXhuuHsddQ@mail.gmail.com>
Subject: Re: [PATCH] rtw88: set power trim according to efuse PG values
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Apr 15, 2020 at 5:59 PM <yhchuang@realtek.com> wrote:
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
>  drivers/net/wireless/realtek/rtw88/efuse.c    |  21 ++++
>  drivers/net/wireless/realtek/rtw88/efuse.h    |   3 +
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 111 ++++++++++++++++++
>  drivers/net/wireless/realtek/rtw88/rtw8822c.h |  28 +++++
>  4 files changed, 163 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/efuse.c b/drivers/net/wireless/realtek/rtw88/efuse.c
> index 212c8376a8c9..f037fa586915 100644
> --- a/drivers/net/wireless/realtek/rtw88/efuse.c
> +++ b/drivers/net/wireless/realtek/rtw88/efuse.c
> @@ -116,6 +116,27 @@ static int rtw_dump_physical_efuse_map(struct rtw_dev *rtwdev, u8 *map)
>         return 0;
>  }
>
> +int rtw_read8_physical_efuse(struct rtw_dev *rtwdev, u16 addr, u8 *data)
> +{
> +       u32 efuse_ctl, cnt;
> +
> +       rtw_write32_mask(rtwdev, REG_EFUSE_CTRL, 0x3ff00, addr);
> +       rtw_write32_clr(rtwdev, REG_EFUSE_CTRL, BIT_EF_FLAG);
> +       cnt = 1000;
> +       do {
> +               mdelay(1);
> +               efuse_ctl = rtw_read32(rtwdev, REG_EFUSE_CTRL);
> +               if (--cnt == 0) {
> +                       *data = EFUSE_READ_FAIL;
> +                       return -EBUSY;
> +               }
> +       } while (!(efuse_ctl & BIT_EF_FLAG));

I believe this can be replaced by read_poll_timeout().

The rest of the patch looks OK to me.

> +
> +       *data = rtw_read8(rtwdev, REG_EFUSE_CTRL);
> +
> +       return 0;
> +}
> +
>  int rtw_parse_efuse_map(struct rtw_dev *rtwdev)
>  {
>         struct rtw_chip_info *chip = rtwdev->chip;
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
> 2.17.1
>
