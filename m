Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7EC464E17
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 13:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbhLAMnv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 07:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbhLAMnv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 07:43:51 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB33C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 04:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gVQYc331BGMCR+nRup6YV5FstprzmHrINE+dZ7VscZg=; b=fx68SFt6PktzpzbsrOkwn0AZTY
        t8VV0OXOJ3eIP7/W41p/KQ6Tck5RHwd78S7enRnjsc+3YUnX3t0CDLefJLINoulQ0cbrkVflP2WBR
        9P2tjNiqdwMcB9/MUDnlRxIB2kuF0HDoQQQYaVLYqw4Mxtxz98ITV7C8VhTP9phCtDgg=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1msOuS-0003Cr-5t; Wed, 01 Dec 2021 13:40:28 +0100
Message-ID: <6999d2e5-a2c5-0247-83c3-f27a0fae157e@nbd.name>
Date:   Wed, 1 Dec 2021 13:40:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v3 08/11] mt76: mt7915: update rx rate reporting for
 mt7916
Content-Language: en-US
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <cover.1637652742.git.Bo.Jiao@mediatek.com>
 <c3519b5f2ed307b18bd0c23e3185ee5d894aa5ca.1637652742.git.Bo.Jiao@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <c3519b5f2ed307b18bd0c23e3185ee5d894aa5ca.1637652742.git.Bo.Jiao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-11-23 08:49, Bo Jiao wrote:
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> index 057ab27..0650140 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -969,11 +969,14 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
>   	struct mt7915_phy *phy = mt7915_hw_phy(hw);
>   	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
>   	struct rate_info *txrate = &msta->wcid.rate;
> -	struct rate_info rxrate = {};
>   
> -	if (!mt7915_mcu_get_rx_rate(phy, vif, sta, &rxrate)) {
> -		sinfo->rxrate = rxrate;
> -		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
> +	if (is_mt7915(&phy->dev->mt76)) {
> +		struct rate_info rxrate = {};
> +
> +		if (!mt7915_mcu_get_rx_rate(phy, vif, sta, &rxrate)) {
> +			sinfo->rxrate = rxrate;
> +			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
> +		}
>   	}
>   
>   	if (!txrate->legacy && !txrate->flags)

You can simplify this part by leaving the code as-is and only changing 
the if condition like this:

if (is_mt7915(&phy->dev->mt76) &&
     !mt7915_mcu_get_rx_rate(phy, vif, sta, &rxrate) {
	...
}
