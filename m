Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F846AD3B9
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Mar 2023 02:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCGBMC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Mar 2023 20:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCGBMA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Mar 2023 20:12:00 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9663D34F46
        for <linux-wireless@vger.kernel.org>; Mon,  6 Mar 2023 17:11:57 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3271B0sL4030882, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3271B0sL4030882
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 7 Mar 2023 09:11:00 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 09:11:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 7 Mar 2023 09:11:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Tue, 7 Mar 2023 09:11:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        "Lorenzo Bianconi" <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Shayne Chen" <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Neil Chen <yn.chen@mediatek.com>
Subject: RE: [PATCH] wifi: mt76: mt7921: use driver flags rather than mac80211 flags to mcu
Thread-Topic: [PATCH] wifi: mt76: mt7921: use driver flags rather than
 mac80211 flags to mcu
Thread-Index: AQHZTnDDuORaGrc0ok+pzt4yBeuUlK7uhgxg
Date:   Tue, 7 Mar 2023 01:11:08 +0000
Message-ID: <4df66aae6e6046d1ba207de47247a21b@realtek.com>
References: <fce2160648ed8a83248e8998cf76bbe05de0e8a0.1677912476.git.deren.wu@mediatek.com>
In-Reply-To: <fce2160648ed8a83248e8998cf76bbe05de0e8a0.1677912476.git.deren.wu@mediatek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Deren Wu <deren.wu@mediatek.com>
> Sent: Saturday, March 4, 2023 4:10 PM
> To: Felix Fietkau <nbd@nbd.name>; Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: Sean Wang <sean.wang@mediatek.com>; Soul Huang <Soul.Huang@mediatek.com>; YN Chen
> <YN.Chen@mediatek.com>; Leon Yen <Leon.Yen@mediatek.com>; Eric-SY Chang <Eric-SY.Chang@mediatek.com>;
> Deren Wu <Deren.Wu@mediatek.com>; KM Lin <km.lin@mediatek.com>; Robin Chiu <robin.chiu@mediatek.com>; CH
> Yeh <ch.yeh@mediatek.com>; Posh Sun <posh.sun@mediatek.com>; Stella Chang <Stella.Chang@mediatek.com>;
> Evelyn Tsai <evelyn.tsai@mediatek.com>; Ryder Lee <ryder.lee@mediatek.com>; Shayne Chen
> <shayne.chen@mediatek.com>; linux-wireless <linux-wireless@vger.kernel.org>; linux-mediatek
> <linux-mediatek@lists.infradead.org>; Neil Chen <yn.chen@mediatek.com>
> Subject: [PATCH] wifi: mt76: mt7921: use driver flags rather than mac80211 flags to mcu
> 
> From: Neil Chen <yn.chen@mediatek.com>
> 
> FIF_* flags from mac80211 is not ABI. mt7921 should not pass it into mcu
> directly. Remap FIF_* to driver defined flags as mcu command input.
> 
> Fixes: c222f77fd421 ("wifi: mt76: mt7921: fix rx filter incorrect by drv/fw inconsistent")
> Signed-off-by: Neil Chen <yn.chen@mediatek.com>

Miss your s-o-b, Deren?

> ---
>  .../net/wireless/mediatek/mt76/mt7921/main.c    | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index 75eaf86c6a78..f67b37d38dbc 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -703,10 +703,25 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
>                                     unsigned int *total_flags,
>                                     u64 multicast)
>  {
> +#define MT7921_FILTER_FCSFAIL    BIT(2)
> +#define MT7921_FILTER_CONTROL    BIT(5)
> +#define MT7921_FILTER_OTHER_BSS  BIT(6)
> +#define MT7921_FILTER_ENABLE     BIT(31)
> +
>         struct mt7921_dev *dev = mt7921_hw_dev(hw);
> +       u32 flags = MT7921_FILTER_ENABLE;
> +
> +#define MT7921_FILTER(_fif, _type) do {                        \
> +               if (*total_flags & (_fif))              \
> +                       flags |= MT7921_FILTER_##_type; \
> +       } while (0)
> +
> +       MT7921_FILTER(FIF_FCSFAIL, FCSFAIL);
> +       MT7921_FILTER(FIF_CONTROL, CONTROL);
> +       MT7921_FILTER(FIF_OTHER_BSS, OTHER_BSS);
> 
>         mt7921_mutex_acquire(dev);
> -       mt7921_mcu_set_rxfilter(dev, *total_flags, 0, 0);
> +       mt7921_mcu_set_rxfilter(dev, flags, 0, 0);
>         mt7921_mutex_release(dev);
> 
>         *total_flags &= (FIF_OTHER_BSS | FIF_FCSFAIL | FIF_CONTROL);
> --
> 2.18.0
> 
> 
> ------Please consider the environment before printing this e-mail.
