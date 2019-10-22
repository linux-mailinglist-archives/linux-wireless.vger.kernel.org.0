Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582C5E042A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 14:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbfJVMtj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 08:49:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43923 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388655AbfJVMti (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 08:49:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id a194so11987930qkg.10
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVF1a4sqfTg/qvlmXrv43POYUsL2YuC6+2CUMmBXnEA=;
        b=jxTKricf4UGdQP8/+NpAKTS9l6cT5QXnIvCA6kvJaB1Ft3ITDjS2AzHclemTuux7e3
         aNlE1wAqV0ut4k0bzKths0CRjrZ/1dbX2NPCQrA4QiYW+5SEox9QYHqCH4G+f09ugZNf
         LaJyMT6QRfM+VsVVEh1ThMDmfkILMCPfBT0EjAkIwcBjx0AUggYgM2fEAlbg96yuxrv0
         /eF0I6GnrWRX+sGNNqE5/XUJ+CXyZOwhP3SG5WpEugTwdE4NGn52lXEy42tl0NgNYBwU
         838TsbeH2caUVrW1qy+PSr1+S8yTTTmPXjMr7S6nMnZoYX+YobNeaRliAy75chJlPsb+
         oGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVF1a4sqfTg/qvlmXrv43POYUsL2YuC6+2CUMmBXnEA=;
        b=OxnWvRMLI8Qkgd6XiohboxlSB/QAih3FZHF8OqpGsIkUa9jUdBYdkc6yXB0kFCb8do
         WiZOnY/2otLgcwbt1lz1Hy/VjrvXCN4xJkXM95yDUS7tuUQkcB9kNUkg+0HpK6ZBdLFZ
         wG//iLpCwXLorv1rbIEq8aMCJfmpmxm6fU2K+eoHVOZYMN9V17n9ZMix0Dlm3D2Tbh+p
         6TNB1AL+rIKuqgyA0jbuUGjYt+6V4hr8vDpw+o9qOyAkKrj8JpGVz0oF5hosOYyZVyEy
         xQ6iXDiGPOS4jV4Pz9oR/oiz9npMEbgvljXy9WfqiahekUD/9uDrpHBHwVWz+ud8tpwE
         L3zQ==
X-Gm-Message-State: APjAAAXJCTrt6G6BmzweQ3maIO5sYBRWvIUeWuaTc2F+8PIhM+KqYYB/
        VdV/JLLys4Zg2Rn6H3l6Mo+iWTDyvZ94cDaGVnYbTQ==
X-Google-Smtp-Source: APXvYqypmO0Q6APoDbpi3gMpQEkLypaUOGDOq0VJykYYY3t58/7KI8l/fRVIHvovcfgh/PR/GRS7vNEwShcMxlLlzIc=
X-Received: by 2002:a37:5f46:: with SMTP id t67mr2634677qkb.220.1571748577648;
 Tue, 22 Oct 2019 05:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191022100420.25116-1-yhchuang@realtek.com> <20191022100420.25116-5-yhchuang@realtek.com>
In-Reply-To: <20191022100420.25116-5-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 22 Oct 2019 20:49:26 +0800
Message-ID: <CAB4CAwcBUHMR3btH9LGd=GzqU1mRmfmL0o4EOY4E8H1OxfpvMg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] rtw88: add set_bitrate_mask support
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
> Support setting bit rate from upper layer.
> After configuring the original rate control result in the driver, the
> result is then masked by the bit rate mask received from the ops
> set_bitrate_mask. Lastly, the masked result will be sent to firmware.
>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>
> v1 -> v2
>   * No change
>
> v2 -> v3
>   * use u64_encode_bits
>
>  drivers/net/wireless/realtek/rtw88/mac80211.c | 53 +++++++++++++
>  drivers/net/wireless/realtek/rtw88/main.c     | 78 +++++++++++++++----
>  drivers/net/wireless/realtek/rtw88/main.h     |  3 +
>  3 files changed, 118 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
> index bc04cc280a96..2247bd61e716 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac80211.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
> @@ -684,6 +686,56 @@ static void rtw_ops_flush(struct ieee80211_hw *hw,
>         mutex_unlock(&rtwdev->mutex);
>  }
>
> +struct rtw_iter_bitrate_mask_data {
> +       struct rtw_dev *rtwdev;
> +       struct ieee80211_vif *vif;
> +       const struct cfg80211_bitrate_mask *mask;
> +};
> +
> +static void rtw_ra_mask_info_update_iter(void *data, struct ieee80211_sta *sta)
> +{
> +       struct rtw_iter_bitrate_mask_data *br_data = data;
> +       struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
> +
> +       if (si->vif != br_data->vif)
> +               return;
> +
> +       /* free previous mask setting */
> +       kfree(si->mask);

You may want to do NULL check for si->mask before kfree.

> +       si->mask = kmemdup(br_data->mask, sizeof(struct cfg80211_bitrate_mask),
> +                          GFP_ATOMIC);
> +       if (!si->mask) {
> +               si->use_cfg_mask = false;
> +               return;
> +       }
> +
> +       si->use_cfg_mask = true;
> +       rtw_update_sta_info(br_data->rtwdev, si);
> +}
> +
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index 47e74f0aec06..e53143132a9b 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -612,12 +612,71 @@ static u8 get_rate_id(u8 wireless_set, enum rtw_bandwidth bw_mode, u8 tx_num)
>  #define RA_MASK_OFDM_IN_HT_2G  0x00010
>  #define RA_MASK_OFDM_IN_HT_5G  0x00030
>
> +static u64 rtw_update_rate_mask(struct rtw_dev *rtwdev,
> +                               struct rtw_sta_info *si,
> +                               u64 ra_mask, bool is_vht_enable,
> +                               u8 wireless_set)
> +{
> +       struct rtw_hal *hal = &rtwdev->hal;
> +       const struct cfg80211_bitrate_mask *mask = si->mask;
> +       u64 cfg_mask = GENMASK(63, 0);
> +       u8 rssi_level, band;
> +
> +       if (wireless_set != WIRELESS_CCK) {
> +               rssi_level = si->rssi_level;
> +               if (rssi_level == 0)
> +                       ra_mask &= 0xffffffffffffffffULL;
> +               else if (rssi_level == 1)
> +                       ra_mask &= 0xfffffffffffffff0ULL;
> +               else if (rssi_level == 2)
> +                       ra_mask &= 0xffffffffffffefe0ULL;
> +               else if (rssi_level == 3)
> +                       ra_mask &= 0xffffffffffffcfc0ULL;
> +               else if (rssi_level == 4)
> +                       ra_mask &= 0xffffffffffff8f80ULL;
> +               else if (rssi_level >= 5)
> +                       ra_mask &= 0xffffffffffff0f00ULL;
> +       }

Would be better to enumerate rssi_level instead of 0 to 5. Does level
0 means bad rssi or good?

> --
> 2.17.1
>
