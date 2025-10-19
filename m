Return-Path: <linux-wireless+bounces-28085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A76BEE90C
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 17:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4060C4E1756
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8982EB861;
	Sun, 19 Oct 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dN+InTtX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C662EBBB0;
	Sun, 19 Oct 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889486; cv=none; b=aF3pRbBhoH3QMtOmscNaqyJhd8o8hc1GkKPx3EBjDGucbxFC/oeBrvFqz3X7q59jXdHfDQzghE9xjxiFtUfc7TkILRUnRhHUyyb2uyAZgbKmV7YlGcLTuAU1KOcVHg8BGU/eVe25fFTKHBZIV5dpxqp2AdFKLAvwZPJmeRC/Rcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889486; c=relaxed/simple;
	bh=yQpcd6B8y1bqilGpUP9oP8k+ZSZB3SE6WNMkT0kB0ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YEthheD5PGZKYyi0q3KM5xp/xssXmHPF8W3o6sGBNcePtP5JDImBVhl6nJ1yA7LO+hpY0V/aYMWRUyniayxcLZ04VPZ4ZF9be/JT+7XVzHG4d+EJkwhHk4+GkAiVhIjWyDlMSt11gmtJRGuw0qhiQtUOsqNO49VMeOGgg5ZeB4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dN+InTtX; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id AVlyvBh0PDOeWAVlyvdeNf; Sun, 19 Oct 2025 17:56:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1760889410;
	bh=R5H+MaCr8Gp0YfRAgXVkenTGJLR59RzoE18KNDLcDYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dN+InTtXbEQFgpQGgwNWLk2rLIeP2eEX9Yt1WZuX7ggfe7c7i2PFQHh2dVAcVzOR/
	 GMYQPeRg8zYSYF7mD6y3TaYQ14z4vNy2GVUwM8SgspZ3go8NkpbN1t04Qp1iG4sY5C
	 3d7IBvbk/8aaHsOn/eKKbWctllnznhJLAwlfHu06hOR6buY8iD9GSCtJXgXRrV1eE0
	 wtOCrju4F3dg6zxDlfxefjwF5gYgStxRALOmCC0GgiGjM+xvFhpkGqyVqdQRhMnGfo
	 Vqw8/ds8sqrlhLoKoRqPIPPdKqMF2f0YzR7I8NIx6n8JV5kLA++dzhaL1CtebQHZN3
	 /Da6zRepGe+tA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 19 Oct 2025 17:56:50 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <c674e933-cf6f-412d-b83b-b225ff6365c9@wanadoo.fr>
Date: Sun, 19 Oct 2025 17:56:40 +0200
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
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20251019155316.3537185-1-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/10/2025 à 17:51, Aleksander Jan Bajkowski a écrit :
> Supports IPv4 and IPv6 TCP + UDP
> 
> In various tests between MT7986 and Intel BE200, I observed a performance
> boost ranging from 2 to 12%, with an average of 5.5%.
> 
> I did the tests on the MT7915, MT7981, MT7986, and MT7921 variants. The
> MT7922, MT7925, and MT799x are untouched for now and still have
> checksumming disabled.
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

This looks strange.

Maybe:
	netdev_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
?

CJ

> +
>   	hw->radiotap_timestamp.units_pos =
>   		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
>   


