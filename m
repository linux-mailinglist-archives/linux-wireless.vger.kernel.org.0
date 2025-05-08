Return-Path: <linux-wireless+bounces-22758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C1FAB05C8
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 00:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4774E7E3D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 22:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8680A2222CF;
	Thu,  8 May 2025 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN+DE+wu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65B1A2390;
	Thu,  8 May 2025 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741964; cv=none; b=B7dRSltsi54BpPpGjES5iVYIrgsHI80qi1/c+9Y/snXkcSnU1GTC6+66an2TWpOvlMCS4j61tkKsk/3GJ4KxZ21sPP28rnnPa+iXg19t68b4HCyemfUDoIqIP63dQVV8afUjMJjn6o4odFoPYmjcGBmQy/QqwNyPfPj11eSrpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741964; c=relaxed/simple;
	bh=nJGSya3nk9fSTp7YpGyO3JhSqO1gXL/uAOoUiq4UGgo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XESMJdBz/fnZJGZl+iMvIzarMUjARdt/TIOm8R3dvxFOzwluwdCgFKR+oae5BnFRopWg3dqb+qKMDVPCdIIocSByjP32E9v+5CiD/4Jl3zR+GriF32HbSrPlR9BXuOUXzI17Fr732bvPIqRni0uw02pq8hLfSRunTzVxrvwhtPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN+DE+wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE5DC4CEE7;
	Thu,  8 May 2025 22:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746741963;
	bh=nJGSya3nk9fSTp7YpGyO3JhSqO1gXL/uAOoUiq4UGgo=;
	h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
	b=IN+DE+wuCAWPAELs5oW0EpKs5ORy43kC+oE1Q2vW0wWTQQwY29Op9abjDOt6onAQt
	 6Ut9bUmgXFuh+1IXL/m7ysUpkC/rhe6i7MrxqhnuU/+TzfpMMtkV28rrryI86j18RF
	 e3Cc3+28GQ2WCy0U/Rous0UTwRv/vo4y5PXoaO8zeV0rmPmRzAfwq/SqVTdoyKq+MY
	 dbXI/tF95dqosOSSmgIHom4Frq2mcOWUFPcGIME4Q4u62aPY/OnxzzDv9eoQarkt5Z
	 b1/2jIYRuD1IOX9x8F0skh/+az+G/LbnTZlnmanbtiH9tIf5mUmdGrnieIPwHOHkQ6
	 nRNNo290L6UZA==
Message-ID: <18a80b20916b2f7d73ea29cc67d1389662f9836b.camel@kernel.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7925: fix missing hdr_trans_tlv
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
 stable@vger.kernel.org, fossben@pm.me
Date: Fri, 09 May 2025 00:05:57 +0200
In-Reply-To: <20250508085534.305242-1-mingyen.hsieh@mediatek.com>
References: <20250508085534.305242-1-mingyen.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-08 at 16:55 +0800, Mingyen Hsieh wrote:
> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>=20
> The hdr_trans_tlv function call has been moved inside the conditional blo=
ck
> to ensure it is executed when info->enable is true.
>=20
> Cc: stable@vger.kernel.org
> Fixes: cb1353ef3473 ("wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta=
_cmd")
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> Tested-by: Niklas Schnelle <niks@kernel.org>
> ---
> v2:
>     add tested-by tag
>=20

Thanks for adding the tag, appreciate it. If I may add some stylistic
comments. I saw that this is one of your first independent upstream
patches so congratulations on that and even better it's an actual
proper fix. Well done!

One thing, I noticed though is that your commit message lacks context,
like this affecting IPv6 and multicast. Basically it just re-iterates
what I can already see in the code. It also doesn't use the recommended
imperative tone (see [0]). Moreover, I think this would be a good case
for using a Link: tag pointing to the thread[1] of Ben's bisect result.
Relatedly one could also add a Reported-by tag for Ben, I still fondly
remember getting a Reported-by mention long before I did my first
kernel contribution. This stuff is hard to balance with getting fixes
out there and I still screw up some detail with mails sometimes, but
we're all learning so wanted to give my 5 cents.

Thanks,
Niklas

[0]
https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#descr=
ibe-your-changes
[1]
https://lore.kernel.org/lkml/EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8_xMBaPMwexCn=
fkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=3D@pm.me/

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

