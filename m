Return-Path: <linux-wireless+bounces-28086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A2BEE9F7
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 18:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7D9E4E29A1
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4862D2E613C;
	Sun, 19 Oct 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="clqctUPT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499824676A;
	Sun, 19 Oct 2025 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760891239; cv=none; b=P6HHZwdu3tyG8EDIU24V0rDNogqSLQ03TBrnDuIxuTe4lTcB1rR3Fr0SJkejcy0nV8NEq9lyna9HvyD8q1jU1UEXPRYqL2CYoBp0H6/a0/YL8We5yQPZfYccEX1LL3CDOl6y7kh36K/Kmt1hEUOQhyeVVpn6kJtfVU+5L218/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760891239; c=relaxed/simple;
	bh=BJmOPFG38eK0SQjYH7HJARC0SJdnqD67ngX0T+67GTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DvY778phf88nqxXW7xTaJMp8QoeybImdXMa+mKoEylo1feS/B49/abi3d4hKXn6jg9r4rcpTJfSG2ZI2qJDHuV0Sl4hiX+jsW0R1V3WnHyeFHiOaaoxWrhovErcS5JbkrBstWw9//tR/LtAL4zysAnNabC04gVkBdqD2VDGrOSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=clqctUPT; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B5E5FC00063;
	Sun, 19 Oct 2025 16:27:04 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.32.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 9D2B513C2B0;
	Sun, 19 Oct 2025 09:26:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9D2B513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1760891222;
	bh=BJmOPFG38eK0SQjYH7HJARC0SJdnqD67ngX0T+67GTA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=clqctUPTKzP1E+Q6/vsaq33wdwavDRqx0lN7mQQg3rVaeGoQ7ttwFl0FFv9KkQdYh
	 F6oSDhZPdku7Wcrqr4ercqiQPlc15qFsoPOMMHl51T0U4WHKUBbI65JV8WF8tN/pAs
	 VeT9Dv2x2qqBfNKV19u3z0j6PUgMXdDrl26MnGZc=
Message-ID: <fa7befd5-b2c7-4277-ad57-a1577216ba83@candelatech.com>
Date: Sun, 19 Oct 2025 09:26:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: add tx checksum offload for mt7915, mt7921,
 mt7981 and mt7986
To: Aleksander Jan Bajkowski <olek2@wp.pl>, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 howard-yh.hsu@mediatek.com, StanleyYP.Wang@mediatek.com, rosenp@gmail.com,
 luoxueqin@kylinos.cn, chad@monroe.io, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20251019155316.3537185-1-olek2@wp.pl>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20251019155316.3537185-1-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1760891226-AlOZrs4LaPdf
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1760891226;AlOZrs4LaPdf;<greearb@candelatech.com>;d5c215dcae166280e85b20da571dd1ee
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/19/25 08:51, Aleksander Jan Bajkowski wrote:
> Supports IPv4 and IPv6 TCP + UDP
> 
> In various tests between MT7986 and Intel BE200, I observed a performance
> boost ranging from 2 to 12%, with an average of 5.5%.
> 
> I did the tests on the MT7915, MT7981, MT7986, and MT7921 variants. The
> MT7922, MT7925, and MT799x are untouched for now and still have
> checksumming disabled.

At least with  7996, tcp csum only worked on the first few vdevs
created in our testing, so we had to add logic to disable that flag
on subsequent vdevs.

Have you tried creating a bunch of station and/or vap vdevs to see if
all of them can still transmit TCP traffic?

Thanks,
Ben


> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> [rebased and resolved conflicts]
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 5 +++++
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c     | 3 ++-
>   drivers/net/wireless/mediatek/mt76/mt792x_core.c     | 3 +++
>   3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> index 0db00efe88b0..e31b3e7e2038 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> @@ -372,6 +372,9 @@ mt76_connac2_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
>   		wmm = sta->wme;
>   	}
>   
> +	val = FIELD_PREP(MT_TXD0_ETH_TYPE_OFFSET, 10);
> +	txwi[0] |= cpu_to_le32(val);
> +
>   	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
>   	      FIELD_PREP(MT_TXD1_TID, tid);
>   
> @@ -391,6 +394,8 @@ mt76_connac2_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
>   
>   	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
>   	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
> +	if (skb->ip_summed == CHECKSUM_PARTIAL)
> +		val |= MT_TXD7_IP_SUM | MT_TXD7_UDP_TCP_SUM;
>   
>   	txwi[7] |= cpu_to_le32(val);
>   }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> index 5ea8b46e092e..a3bab240afb7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -359,7 +359,8 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
>   	hw->queues = 4;
>   	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
>   	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
> -	hw->netdev_features = NETIF_F_RXCSUM;
> +	hw->netdev_features = NETIF_F_RXCSUM |
> +			      NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
>   
>   	if (mtk_wed_device_active(&mdev->mmio.wed))
>   		hw->netdev_features |= NETIF_F_HW_TC;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> index c0e56541a954..fe138d2e8e62 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> @@ -632,6 +632,9 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
>   	}
>   	hw->netdev_features = NETIF_F_RXCSUM;
>   
> +	if (is_mt7921(&dev->mt76))
> +		NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
> +
>   	hw->radiotap_timestamp.units_pos =
>   		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
>   

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


