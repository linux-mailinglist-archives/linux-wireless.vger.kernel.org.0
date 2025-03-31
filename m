Return-Path: <linux-wireless+bounces-20981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD5A75E65
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 06:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1629166AA8
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 04:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676B139579;
	Mon, 31 Mar 2025 04:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kR4VM82w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816BB2CCC5
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743396112; cv=none; b=QN8UtdYP3zUKLAnURxQKprOS24Zyq7ZPZAHMZoo6j7S/9Yv80Dt+uIC6AEv4ACbAS4N1pif3JxSxmcQ+8ifn5BUZEuMLCO4zQgIXSHkQ6lsFCb5eXVJrNEUfue4Uck+S47iIq00dtjVJAMfkHEk3XEKCnJw0ZNl1iIJPRBoOy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743396112; c=relaxed/simple;
	bh=vgqKAW6SGXnN7eA/rvG2mGBQN/Tij+p0oHVarZ3haoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JZeSgb/OpmbQ5pbP9xyV4niCBZRU6ch1OJt94fImzlfgdXx1VH1u5csbdpTQ0atqflu2DEWU7HB2/ocq6AZvTcKQzbZwGkPSAN+G8XBk+NJ5a68+wvNKRrTNJJKkJzNNZuwFFLG+zeco+3YWLwQ9EkVvG8KjcN+NuVgEWUdlSZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kR4VM82w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52V4erMH32763146, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743396053; bh=vgqKAW6SGXnN7eA/rvG2mGBQN/Tij+p0oHVarZ3haoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kR4VM82w77ZxGg9Q6R1Jkl5iANY7tyPy//YbZZYHsWqe+ixuMtgNo3lftIjI+LO4d
	 O0Pfsi0iMIOTNk1ppH1MmVjK0aXMb0EanMdXfhV2gAErHhHL+tzZiQjbvlbB9LbAZW
	 GHll56kynH3S4SF1mS5n/ujXm2lGmDsn4FT4nxce6Fd3wwbRzvVMMovBNkAdAf0CR2
	 NwVHj+hAel7ygUU54Y3bqxDGevrGCPREmm1Pg5VxNJcnkOtP/4ty8l7+Ao9ou9ofHM
	 2k0YyTLm+q/FucVc8yYuBAQt7b0tDbgCHEKYQZ3F7AUsa+7G+GZjB03K64kgKIewGS
	 JN3nKqKfbXQ1A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52V4erMH32763146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 12:40:53 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 31 Mar 2025 12:40:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 31 Mar 2025 12:40:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 31 Mar 2025 12:40:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shayne Chen <shayne.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai
	<evelyn.tsai@mediatek.com>,
        linux-mediatek
	<linux-mediatek@lists.infradead.org>,
        StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: RE: [PATCH 02/10] wifi: mt76: connac: add support to load firmware for mt7990
Thread-Topic: [PATCH 02/10] wifi: mt76: connac: add support to load firmware
 for mt7990
Thread-Index: AQHbn6Xg03cjcDOIHkCak0I8sGEc67OMrjLg
Date: Mon, 31 Mar 2025 04:40:52 +0000
Message-ID: <7ec7c486728d490caef7dcdac3c1c8e4@realtek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
 <20250328055058.1648755-3-shayne.chen@mediatek.com>
In-Reply-To: <20250328055058.1648755-3-shayne.chen@mediatek.com>
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

Shayne Chen <shayne.chen@mediatek.com> wrote:
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> @@ -232,9 +232,14 @@ static inline bool is_mt7992(struct mt76_dev *dev)
>         return mt76_chip(dev) =3D=3D 0x7992;
>  }
>=20
> +static inline bool is_mt7990(struct mt76_dev *dev)
> +{
> +       return mt76_chip(dev) =3D=3D 0x7993;

It seems like patch 01/10 want to avoid this kind of confusion.=20

Also, there are two IDs for MT7990:=20

#define MT7990_DEVICE_ID               0x7993
#define MT7990_DEVICE_ID_2             0x799b

> +}
> +
>  static inline bool is_mt799x(struct mt76_dev *dev)
>  {
> -       return is_mt7996(dev) || is_mt7992(dev);
> +       return is_mt7996(dev) || is_mt7992(dev) || is_mt7990(dev);
>  }
>=20

