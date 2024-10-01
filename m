Return-Path: <linux-wireless+bounces-13387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943F898C637
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 21:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED301C219BF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 19:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD71CDA16;
	Tue,  1 Oct 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI4YvA7W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC2C1CDA11
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812014; cv=none; b=FhhNLGqdfYApm/pZUoUUxGyD3zkI04Sewut3MfgvHgpZzWIPcpyYkyw0ol6dvqlSbdWYJq3ehzj2FZa7AOtKi7BoUQOqYYM/3/R45IvEHib3X+QjlWnGMdLoioKVsomjigmly+jurk/1FsybsrszuDNtjcnQWVngo5Pwp3NMgtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812014; c=relaxed/simple;
	bh=NnBcHNhXe80YzxafWTsh8tN5x2sluT8Gy5kfBJJBbn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLg+Ea0OX7/y/EVxaQvgrL9KbPNGyNsn0Wc2Bo1iWOL31sbW1DW2Xanfel5gbSv1BGb/DHvrrIQtQ/570qPlF31vbVOJEC7BmdB46UAZSRd5+PyagZZ1OJ+j0D5J0W3N3zpeM8SwlcSy/UWl1YZ/wiGDCS9UZ07BnNwH98/tslE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI4YvA7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A44C4CEC6;
	Tue,  1 Oct 2024 19:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727812013;
	bh=NnBcHNhXe80YzxafWTsh8tN5x2sluT8Gy5kfBJJBbn4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KI4YvA7Wzh3uxBFsoQjS6URsjEJ8GNEuiB/S+LT2yGMZ/m67wEYX4DRAryAtSFl9U
	 iRJXYSGF5UV+NQ4tDPpw5nYLZfftflsdU/YGKmTyLMB/mBAFSX7+1ArWiNqczuhoja
	 Eh2uMOUV2jmi7g2twpJT5QFnrN4eFQvPjrmqfvyedfK+zVDe2F1xOv7zMH4sqvnPEs
	 +FhrrJDfjLleWklOEDMdM3tVMq90KD+oaeauvghWmQKAmLxplOBfHoyIvzaMRYN88p
	 aPQ6z079WKNPzQkTWJsWN2T/TPDCZ89P7vl6WIEJvlbvEuZi1mtl5m+z9tLcXSCZQ/
	 BxAMVYJx6ZLQQ==
Message-ID: <3e40513c-3c58-4d25-8dc7-1d9bfc38fcf5@kernel.org>
Date: Tue, 1 Oct 2024 21:46:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: Fix NULL Pointer Dereference caused by
 mt76_connac_get_he_phy_cap()
To: Gax-c <zichenxie0106@gmail.com>, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 kvalo@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, johannes.berg@intel.com,
 quic_adisi@quicinc.com, deren.wu@mediatek.com, chui-hao.chiu@mediatek.com,
 meichia.chiu@mediatek.com, mingyen.hsieh@mediatek.com,
 howard-yh.hsu@mediatek.com, StanleyYP.Wang@mediatek.com,
 allen.ye@mediatek.com, benjamin-jw.lin@mediatek.com, Bo.Jiao@mediatek.com,
 Money.Wang@mediatek.com
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Zijie Zhao <zzjas98@gmail.com>,
 Chenyuan Yang <chenyuan0y@gmail.com>
References: <20240930212014.30607-1-zichenxie0106@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240930212014.30607-1-zichenxie0106@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/09/2024 23:20, Gax-c wrote:
> like commit f503ae90c735 ("wifi: mt76: mt7996: fix NULL pointer dereference in mt7996_mcu_sta_bfer_he"), mt76_connac_get_he_phy_cap() may return a NULL pointer, leading to NULL Pointer Dereference.
> Add a null check for the returned pointer.
> 
> Fixes: a5c372f77aa7 ("wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS")
> Fixes: e6d557a78b60 ("mt76: mt7915: rely on mt76_connac_get_phy utilities")
> Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> Reported-by: Zichen Xie <zichenxie0106@gmail.com>
> Reported-by: Zijie Zhao <zzjas98@gmail.com>
> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>

Same comments as in other patches.

> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 6 ++++++
>  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 3 +++
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 +++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index 87d0dd040001..941a6e40e94c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -552,6 +552,9 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
>  
>  	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
>  

Same problem as in other patches - drop unnecessary blank line.

> +	if (!cap)
> +		return;
> +
>  	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, sizeof(*he));
>  
>  	he = (struct bss_info_he *)tlv;
> @@ -1145,6 +1148,9 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
>  	u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
>  	u8 snd_dim, sts;
>  
> +	if (!vc)
> +		return;
> +
>  	bf->tx_mode = MT_PHY_TYPE_HE_SU;
>  
>  	mt7915_mcu_sta_sounding_rate(bf);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> index 748ea6adbc6b..1caf3e3e0e87 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -2509,6 +2509,9 @@ mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
>  
>  	cap = mt76_connac_get_he_phy_cap(phy->mt76, link_conf->vif);
>  
> +	if (!cap)
> +		return;
> +
>  	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
>  
>  	he = (struct bss_info_uni_he *)tlv;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> index 6c445a9dbc03..e547729701b7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -799,6 +799,9 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
>  
>  	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
>  
> +	if (!cap)
> +		return;

Don't you need to handle the error? Cleanup?


Best regards,
Krzysztof


