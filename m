Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2636D7D7F4C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjJZJGW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 05:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjJZJGU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 05:06:20 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A47F187
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 02:06:16 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39Q93PLP02633100, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39Q93PLP02633100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 17:03:26 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 26 Oct 2023 17:03:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 26 Oct 2023 17:03:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 26 Oct 2023 17:03:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: RE: [PATCH 1/2] wifi: mt76: mt7915: enable mt7986 and mt7916 pre-calibration support
Thread-Topic: [PATCH 1/2] wifi: mt76: mt7915: enable mt7986 and mt7916
 pre-calibration support
Thread-Index: AQHaB5vWsEseFRZFm0aldYRiDcSFaLBbxG+Q
Date:   Thu, 26 Oct 2023 09:03:24 +0000
Message-ID: <7a3a38a0c8b54757a4ab090aa7422d6c@realtek.com>
References: <f21b261373fc221b8370264c44ee751fa85cf41c.1698274193.git.ryder.lee@mediatek.com>
In-Reply-To: <f21b261373fc221b8370264c44ee751fa85cf41c.1698274193.git.ryder.lee@mediatek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.71.113]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Ryder Lee <ryder.lee@mediatek.com>
> Sent: Thursday, October 26, 2023 7:34 AM
> To: Felix Fietkau <nbd@nbd.name>; linux-wireless@vger.kernel.org
> Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>; Shayne Chen <shayne.chen@mediatek.com>; Evelyn Tsai
> <evelyn.tsai@mediatek.com>; linux-mediatek@lists.infradead.org; Peter Chiu <chui-hao.chiu@mediatek.com>;
> Ryder Lee <ryder.lee@mediatek.com>
> Subject: [PATCH 1/2] wifi: mt76: mt7915: enable mt7986 and mt7916 pre-calibration support
> 
> From: Peter Chiu <chui-hao.chiu@mediatek.com>
> 
> Add pre-calibration for mt7986 and mt7916. Their group cal size are
> 54k and 94k for 2G + 5G and 2G + 6G, respectively. DPD size is 300k.

s/\([256]\)G/\1GHz/

> 
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt7915/eeprom.c    |  11 +-
>  .../wireless/mediatek/mt76/mt7915/eeprom.h    |  34 +++++-
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 100 ++++++++++++++----
>  3 files changed, 114 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
> b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
> index f3e56817d36e..84c1903b2a6c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h

[...]

> @@ -155,6 +164,27 @@ mt7915_tssi_enabled(struct mt7915_dev *dev, enum nl80211_band band)
>                 return val & MT_EE_WIFI_CONF7_TSSI0_5G;
>  }
> 
> +static inline u32
> +mt7915_get_cal_group_size(struct mt7915_dev *dev)
> +{
> +       if (is_mt7915(&dev->mt76)) {
> +               return MT_EE_CAL_GROUP_SIZE_7915;
> +       } else if (is_mt7916(&dev->mt76)) {
> +               u8 *eep = dev->mt76.eeprom.data;
> +               u32 val = eep[MT_EE_WIFI_CONF + 1];
> +
> +               val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);

val = u32_get_bits(val, MT_EE_WIFI_CONF0_BAND_SEL);

> +
> +               return (val == MT_EE_V2_BAND_SEL_6GHZ) ?
> +                       MT_EE_CAL_GROUP_SIZE_7916_6G :
> +                       MT_EE_CAL_GROUP_SIZE_7916;

shouldn't it align open parenthesis?

return val == MT_EE_V2_BAND_SEL_6GHZ ?
       MT_EE_CAL_GROUP_SIZE_7916_6G :
       MT_EE_CAL_GROUP_SIZE_7916;

> +       } else if (mt7915_check_adie(dev, false)) {
> +               return MT_EE_CAL_GROUP_SIZE_7976;
> +       } else {
> +               return MT_EE_CAL_GROUP_SIZE_7975;
> +       }
> +}
> +
>  extern const u8 mt7915_sku_group_len[MAX_SKU_RATE_GROUP_NUM];
> 
>  #endif
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index b22f06d4411a..da3ee9f91704 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -2904,9 +2904,10 @@ static int mt7915_mcu_set_pre_cal(struct mt7915_dev *dev, u8 idx,
>  int mt7915_mcu_apply_group_cal(struct mt7915_dev *dev)
>  {
>         u8 idx = 0, *cal = dev->cal, *eep = dev->mt76.eeprom.data;
> -       u32 total = MT_EE_CAL_GROUP_SIZE;
> +       u32 total = mt7915_get_cal_group_size(dev);
> +       u32 offs = is_mt7915(&dev->mt76) ? MT_EE_DO_PRE_CAL : MT_EE_DO_PRE_CAL_V2;

in reverse X'mas tree order?

> 
> -       if (!(eep[MT_EE_DO_PRE_CAL] & MT_EE_WIFI_CAL_GROUP))
> +       if (!(eep[offs] & MT_EE_WIFI_CAL_GROUP))
>                 return 0;
> 
>         /*
> @@ -2942,9 +2943,9 @@ static int mt7915_find_freq_idx(const u16 *freqs, int n_freqs, u16 cur)
>         return -1;
>  }
> 
> -static int mt7915_dpd_freq_idx(u16 freq, u8 bw)
> +static int mt7915_dpd_freq_idx(struct mt7915_dev *dev, u16 freq, u8 bw)
>  {
> -       static const u16 freq_list[] = {
> +       const u16 freq_list_v1[] = {

Without 'static', it will unnecessarily make a copy to stack at runtime.

>                 5180, 5200, 5220, 5240,
>                 5260, 5280, 5300, 5320,
>                 5500, 5520, 5540, 5560,
> @@ -2952,65 +2953,118 @@ static int mt7915_dpd_freq_idx(u16 freq, u8 bw)
>                 5660, 5680, 5700, 5745,
>                 5765, 5785, 5805, 5825
>         };
> -       int offset_2g = ARRAY_SIZE(freq_list);
> -       int idx;
> +       const u16 freq_list_v2[] = {

static const

> +               /* 6G BW20 */
> +               5955, 5975, 5995, 6015,
> +               6035, 6055, 6075, 6095,
> +               6115, 6135, 6155, 6175,
> +               6195, 6215, 6235, 6255,
> +               6275, 6295, 6315, 6335,
> +               6355, 6375, 6395, 6415,
> +               6435, 6455, 6475, 6495,
> +               6515, 6535, 6555, 6575,
> +               6595, 6615, 6635, 6655,
> +               6675, 6695, 6715, 6735,
> +               6755, 6775, 6795, 6815,
> +               6835, 6855, 6875, 6895,
> +               6915, 6935, 6955, 6975,
> +               6995, 7015, 7035, 7055,
> +               7075, 7095, 7115,
> +               /* 6G BW160 */
> +               6025, 6185, 6345, 6505,
> +               6665, 6825, 6985,
> +               /* 5G BW20 */
> +               5180, 5200, 5220, 5240,
> +               5260, 5280, 5300, 5320,
> +               5500, 5520, 5540, 5560,
> +               5580, 5600, 5620, 5640,
> +               5660, 5680, 5700, 5720,
> +               5745, 5765, 5785, 5805,
> +               5825, 5845, 5865, 5885,
> +               /* 5G BW160 */
> +               5250, 5570, 5815
> +       };

[...]

