Return-Path: <linux-wireless+bounces-22768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF5AB0F53
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 11:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD214E76A8
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4102701AC;
	Fri,  9 May 2025 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUUM6z2V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063A201266;
	Fri,  9 May 2025 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783643; cv=none; b=XFpuqeQTBVIfVHf7+ffjmKwFwXp8l/BF51Ij5r+gtxHKqV6fUnTSRJvfiyIw3xR+WLzHO1xnqVlv8Gm6DWonQ18UwcNEltGwDGmEFBFPqFWfFBRDSp4qPQWJINjjl9MMl0hpk1SzBmovJi8bfVrdsFQKesLabpi1NmIavGDx5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783643; c=relaxed/simple;
	bh=zOi3E5QjZZzh6FbcXdbt+4r97uniOxVsMHgA5rk3t1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kMREWL/1+nbCGY1iTxGbhZEpMroS2HX0GWUTcM8icMllJSh2e/IvJHcvjrv+RyXhFi9AbQ64s++vUoCVjy4xBjR/RBINvVmeUJXVapjnLKJL3XE1iW3xfdlAsJEj59WUgmivbx1WrZ+2Ixt2MSELb4MXWGawSI5ZLuIFiUldVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUUM6z2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03E9C4CEE9;
	Fri,  9 May 2025 09:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746783642;
	bh=zOi3E5QjZZzh6FbcXdbt+4r97uniOxVsMHgA5rk3t1g=;
	h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
	b=EUUM6z2V+hU8XPPcWpu+Hgqk62TvIzPueE/vNsDfR++yS60wS3gLqvyF6b1ynhihi
	 M7Eo/WMpAZeDB2bucEQReUvEir/D8vpv73h7v8ukhZUloBZrCNJt5PLeSQmAsivm1Z
	 FaAafYJSr28UJxocLvAMy9ak7x4OdNrY5HZPaY8KoToqJls+03SaLt59+uBqhvoB3y
	 mDvCM+ajrjvbqCS2Fhx3pTspdk/gT4Pbv1tmdziu8+ijspkDp+UgVD7162NgPo5Vbs
	 k1H9+FhhZ9SVPe9TTN/ls1zS85thExo6i5t45XqqEx8GubCtbWEAEmUfxXS57PZ0bZ
	 3x9QW63rTs2wA==
Message-ID: <534b9a609564c8bb6d90805dca7fb1d3a45a3abf.camel@kernel.org>
Subject: Re: [PATCH v3] wifi: mt76: mt7925: fix missing hdr_trans_tlv
 command for broadcast wtbl
From: Niklas Schnelle <niks@kernel.org>
Reply-To: niks@kernel.org
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, nbd@nbd.name, 
	lorenzo@kernel.org
Cc: deren.wu@mediatek.com, Sean.Wang@mediatek.com, Leon.Yen@mediatek.com, 
	Michael.Lo@mediatek.com, allan.wang@mediatek.com,
 Eric-SY.Chang@mediatek.com, 	km.lin@mediatek.com, Quan.Zhou@mediatek.com,
 Ryder.Lee@mediatek.com, 	Shayne.Chen@mediatek.com,
 linux-wireless@vger.kernel.org, 	linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, Benjamin Xiao	 <fossben@pm.me>
Date: Fri, 09 May 2025 11:40:36 +0200
In-Reply-To: <20250509010421.403022-1-mingyen.hsieh@mediatek.com>
References: <20250509010421.403022-1-mingyen.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 09:04 +0800, Mingyen Hsieh wrote:
> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>=20
> Ensure that the hdr_trans_tlv command is included in the broadcast wtbl t=
o
> prevent the IPv6 and multicast packet from being dropped by the chip.
>=20
> Cc: stable@vger.kernel.org
> Fixes: cb1353ef3473 ("wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta=
_cmd")
> Reported-by: Benjamin Xiao <fossben@pm.me>
> Tested-by: Niklas Schnelle <niks@kernel.org>
> Link: https://lore.kernel.org/lkml/EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8_xMB=
aPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=3D@pm=
.me/
> ---
> v2:
>     add tested-by tag
> v3:
>     add more info in commit
> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mcu.c
> index a42b584634ab..fd756f0d18f8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -2183,14 +2183,14 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
>  			mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
>  			mt7925_mcu_sta_eht_mld_tlv(skb, info->vif, info->link_sta->sta);
>  		}
> -
> -		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
>  	}
> =20
>  	if (!info->enable) {
>  		mt7925_mcu_sta_remove_tlv(skb);
>  		mt76_connac_mcu_add_tlv(skb, STA_REC_MLD_OFF,
>  					sizeof(struct tlv));
> +	} else {
> +		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
>  	}
> =20
>  	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);

Thank you for picking up my suggestions so quickly! This looks much
better now.

