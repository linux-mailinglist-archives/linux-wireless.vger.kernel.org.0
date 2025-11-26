Return-Path: <linux-wireless+bounces-29349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B261C879F5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 01:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E954E4E11D5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 00:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67DE2F12C3;
	Wed, 26 Nov 2025 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="teR4GGgJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965FE189F20;
	Wed, 26 Nov 2025 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764118042; cv=none; b=HeAMys5sI/y/Jy9ECrdzOvvLkZWyqkLOh17uyHPjv6u4wSsU5gcqx7bzqksQ2FB4hx7enSwAj+DtC1iVlPJAdh/RYe4UPG+SF0kDauqyj9aOfVT3oXB6xtqmahwDuYYxOzDQN3xkkquOyBc1DEdqn+TcoiJLTKVSgEJauXzkRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764118042; c=relaxed/simple;
	bh=qo+U82Je3WyUkMCkOOj4oJnaquT6qPTopcK2n4Uwo3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IeKBK2V2bphZ8YIjMbYd+ftWznRlzQtpl5uUZmQ22dlWMLE34FH8liT7VlLRtJad85pvF0BsnSOp0D6UytaFSePnC4c3hPbAtn/cwirrGPaOdUaznlH2or9H+XXF920AB2D3I8920lfQWWyrR9im+L5h1Dvx8JTnU+lr/r0DDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=teR4GGgJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AQ0lDhaD4044545, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764118033; bh=/FAjPM80yfF7Il6eBtt66dfRpI5tupNUZDSdk9gP6+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=teR4GGgJMhjwAQdaTruE1SSdFDrO3fi5YEs/k3gwal0hPdsZiNu1Y1V7Ho2sriAYj
	 TWFnjsR9i+L4ekXhuuK68vCeoU3dTuRnJl2V2xaab8QuYoPLwaRbOgtwQCP+zKpmQR
	 1dHxHDL+Fw69mjVvj60Ys37kc1Y57kRYLtf7d0vOwgxhVWWA27F0RLzsWhaXn8NQHT
	 ImInh+L1xbKWrE/kiBtUdLq5OZYS2+O4xZNe3LZgYcmkNgSFHaXUPpnMSk8etGmk5M
	 4nS5vK7a9fcmnaDv8B8+IPfYbzqbjjUWufqXB9R8hvKuMJpLNRvvgyp3nAD9U2TV3B
	 CpdblS55BvbVA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AQ0lDhaD4044545
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 08:47:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 26 Nov 2025 08:47:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 26 Nov 2025 08:47:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Les Boys <lesboyspp43@outlook.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3] realtek/rtlwifi: remove unused two if blocks
 and put unicast  set inner if and else block
Thread-Topic: [PATCH rtw-next v3] realtek/rtlwifi: remove unused two if blocks
 and put unicast  set inner if and else block
Thread-Index: AQHcXgC3xM3pXMy0D0ybisYYzyyvpbUEH4zg
Date: Wed, 26 Nov 2025 00:47:13 +0000
Message-ID: <ab5c8bb1f6f443c9a08882be5a1ba24d@realtek.com>
References: <SA2PR10MB44609AAC5888DC0334D140E0A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <d664a966f7754e879948039189aba8e8@realtek.com>
 <SA2PR10MB44605A853386FE1BB7174498A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <SA2PR10MB4460861A8224AA99EE5ACF6BA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <731806e542f245b3b3ae6d2429c499e5@realtek.com>
 <SA2PR10MB44606485C05B0FC57402C40FA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
In-Reply-To: <SA2PR10MB44606485C05B0FC57402C40FA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


Les Boys <lesboyspp43@outlook.com> wrote:


Not sure why you remove entire commit message?

>=20
> ---
> CHANGE:
> 1. Ensure used the origin as base
> 2. Format fixings

Still wrong place.=20

There are many examples in public. One of them is [1] I sent before.

[1] https://lore.kernel.org/linux-wireless/910a0ce4bf9c47d89f0da8399ef3927e=
@realtek.com/T/#md11d111fbdaaa8b37787c7f2197d41b500456f38

>=20
> Signed-off-by: Les Boys <lesboyspp43@outlook.com>
> ---
>  drivers/net/wireless/realtek/rtlwifi/pci.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wir=
eless/realtek/rtlwifi/pci.c
> index d08046926..a07de6b57 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -752,14 +752,13 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_=
hw *hw)

I meant you need changes like this.

- bool unicast =3D false;
+ bool unicast;

>                         memcpy(IEEE80211_SKB_RXCB(skb), &rx_status,
>                                sizeof(rx_status));
>=20
> -                       if (is_broadcast_ether_addr(hdr->addr1)) {
> -                               ;/*TODO*/
> -                       } else if (is_multicast_ether_addr(hdr->addr1)) {
> -                               ;/*TODO*/
> -                       } else {
> +                       if (is_unicast_ether_addr(hdr->addr1)) {
>                                 unicast =3D true;
>                                 rtlpriv->stats.rxbytesunicast +=3D skb->l=
en;
> +                       } else {
> +                               unicast =3D false;
>                         }
> +
>                         rtl_is_special_data(hw, skb, false, true);
>=20
>                         if (ieee80211_is_data(fc)) {
> --
> 2.44.0

