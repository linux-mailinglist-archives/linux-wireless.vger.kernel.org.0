Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26393EB474
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 13:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbhHMLOG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 07:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbhHMLOG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 07:14:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDC8C061756
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 04:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+/1tQqP/sJultKM2BV10PrVyLZA+ZRykdD2MMKCHP28=; b=i3KptsEmHfkwgniiithdN03T/P
        ORrmT2bCqFHXx3YkzQHiGoDCpfBVGH0yRNPblKo8F0t3Oq9Ni+MlSn+LSKJKYKSYYftOCRp84dpbr
        6P5qa+3bCbrDAj3nilJw1SgS9jZjdR77KEd/6vqMoMf70E7Zyn71R58D0YtgBRWv+40g=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mEV82-0000zx-LE; Fri, 13 Aug 2021 13:13:34 +0200
Subject: Re: [PATCH v2 2/3] mt76: mt7915: rework .set_bitrate_mask() to
 support more options
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <1c3fc7ff6d5ab129a58160cd878787d9fbeba9c2.1628821139.git.ryder.lee@mediatek.com>
 <4b6784457d6d08ea405cd2db70e39d5f56e39e1d.1628821139.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <aa1486b5-51c2-6482-80a0-4b914033aa3e@nbd.name>
Date:   Fri, 13 Aug 2021 13:13:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4b6784457d6d08ea405cd2db70e39d5f56e39e1d.1628821139.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-08-13 04:32, Ryder Lee wrote:
> With this patch, driver can support single rate, (HE)GI and HE_LTF
> configuration through .set_bitrate_mask().
> 
> Tested-by: MeiChia Chiu <meichia.chiu@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> v2: fix an enum warning
> ---
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   |   2 +-
>  .../net/wireless/mediatek/mt76/mt7915/main.c  |  32 ++--
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 148 +++++++++++++++++-
>  .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  16 +-
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |   5 +
>  5 files changed, 175 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index 028ee5bb0532..74f08e1c2f55 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -2042,6 +2042,128 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
>  	return 0;
>  }
>  
> +int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
> +				   struct ieee80211_vif *vif,
> +				   struct ieee80211_sta *sta,
> +				   void *data, u32 field)
> +{
> +	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
> +	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
> +	struct sta_phy *phy = data;
> +	struct sta_rec_ra_fixed *ra;
> +	struct sk_buff *skb;
> +	struct tlv *tlv;
> +	int len = sizeof(struct sta_req_hdr) + sizeof(*ra);
> +
> +	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	tlv = mt7915_mcu_add_tlv(skb, STA_REC_RA_UPDATE, sizeof(*ra));
> +	ra = (struct sta_rec_ra_fixed *)tlv;
> +
> +	switch (field) {
> +	case RATE_PARAM_AUTO:
> +		break;
> +	case RATE_PARAM_FIXED_MCS:
> +	case RATE_PARAM_FIXED_GI:
> +	case RATE_PARAM_FIXED_HE_LTF:
> +		ra->phy = *phy;
> +		break;
> +	default:
> +		break;
> +	}
> +	ra->field = cpu_to_le32(field);
> +
> +	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
> +				     MCU_EXT_CMD(STA_REC_UPDATE), true);
> +}
> +
> +static int
> +mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
> +			       struct ieee80211_vif *vif,
> +			       struct ieee80211_sta *sta)
> +{
> +	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
> +	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
> +	struct cfg80211_bitrate_mask *mask = &mvif->bitrate_mask;
> +	enum nl80211_band band = chandef->chan->band;
> +	struct sta_phy phy = {};
> +	int ret, nrates;
> +
> +#define __sta_phy_bitrate_mask_set(_mcs, _gi, _he)				\
> +	do {									\
> +		u8 i, gi = mask->control[band]._gi;				\
> +		gi = (_he) ? gi : gi == NL80211_TXRATE_FORCE_SGI;		\
> +		for (i = 0; i <= sta->bandwidth; i++) {				\
> +			phy.sgi |= gi << (i << (_he));				\
> +			phy.he_ltf |= mask->control[band].he_ltf << (i << (_he));\
> +		}								\
> +		for (i = 0; i < ARRAY_SIZE(mask->control[band]._mcs); i++) 	\
> +			nrates += hweight16(mask->control[band]._mcs[i]);  	\
> +		phy.mcs = ffs(mask->control[band]._mcs[0]) - 1;			\
> +	} while (0)
> +
> +	if (sta->he_cap.has_he) {
> +		__sta_phy_bitrate_mask_check(he_mcs, he_gi, 1);
This does not compile because of a wrong macro name (_set vs _check).

- Felix
