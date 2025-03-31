Return-Path: <linux-wireless+bounces-20985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7E5A75EAE
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 07:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086EB166B77
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 05:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF9DBE67;
	Mon, 31 Mar 2025 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="o7gAnKxe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCB258A
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743400542; cv=none; b=UjLGBpPuRAgqjBC2nIOVQ4Xkn+nFHTpo3QH7w9+LhwrHAlKzwH2vEH2G4GR8UZ6f6qVoy/wSNFRlKoediRpYMfpW7CJ9QwZicfaj6glYVvxp7r+Xt2SFKTCqPqJ+NzflUlL8NkTZ5eVsAy8T/BvcQbhfZyMbPVQD7djaJiTt7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743400542; c=relaxed/simple;
	bh=9bP08Lt3hN3Qe1kOIDNtLTWN5iWgMi0iAd0Gho3FgcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iRx4ejpdaTne9etYV2deKRweyoaWUkJuJFfDIk4/sj4iquX1XsxQVbXwGj6+iRzu8GrBKiW1oMWegHDHtTzLOQV1sLt24qqNkP+etqyFjvVKT1WYaxikgaCczXV+kWc2om0/3lVYFOM1yVSlIw4xUEe7TJ+rfdkfsrarUUxaRCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=o7gAnKxe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52V5tNUw92857083, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743400524; bh=9bP08Lt3hN3Qe1kOIDNtLTWN5iWgMi0iAd0Gho3FgcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=o7gAnKxevBLOWPU0P8fVX/qTb/QjwI+VYzSZ08+Ugkw5GVBEdSB8sCiGdBFK3dV2G
	 b6hiIf8U1GlAioF4EyQX768wry/5vun3dGxFjIcFGODJCVxxxagkH5Xu5P+2X3JSl5
	 T8wUP849/KRo/LMVVTH+pyFIlCM/9XYR3cjlwnFB+AEwHcWWvvn2UFLfXzG36WB4gT
	 BkLA1K5xTnBisPiiSSqB8bzJgaTerJTh5WFNnpAESc8XeRSYthvfxuztMeFigdDJGG
	 ChM8yCpAsm2fyq38BnQoCUq63GYty4UtiQG+0/81lhv6dSVXNfhdBxwPvuI7iOs4pU
	 8DcoZxNjIb/Jg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52V5tNUw92857083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 13:55:23 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 31 Mar 2025 13:55:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 31 Mar 2025 13:55:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 31 Mar 2025 13:55:24 +0800
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
	<StanleyYP.Wang@mediatek.com>
Subject: RE: [PATCH 09/10] wifi: mt76: mt7996: rework background radar check for mt7990
Thread-Topic: [PATCH 09/10] wifi: mt76: mt7996: rework background radar check
 for mt7990
Thread-Index: AQHbn6XvD6dY9NzS8E2HfbUbQJUEZrOMwhhg
Date: Mon, 31 Mar 2025 05:55:23 +0000
Message-ID: <59abf964667144b0ab10220e41b6b821@realtek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
 <20250328055058.1648755-10-shayne.chen@mediatek.com>
In-Reply-To: <20250328055058.1648755-10-shayne.chen@mediatek.com>
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

[...]

> +
> +bool mt7996_eeprom_has_background_radar(struct mt7996_dev *dev)
> +{
> +       switch (mt76_chip(&dev->mt76)) {
> +       case MT7996_DEVICE_ID:
> +               if (dev->var.type =3D=3D MT7996_VAR_TYPE_233)
> +                       return false;
> +               break;
> +       case MT7992_DEVICE_ID:
> +               if (dev->var.type =3D=3D MT7992_VAR_TYPE_23)
> +                       return false;
> +               break;
> +       case MT7990_DEVICE_ID: {
> +               u8 path, rx_path, nss, *eeprom =3D dev->mt76.eeprom.data;
> +
> +               mt7996_eeprom_parse_stream(eeprom, MT_BAND1, &path, &rx_p=
ath, &nss);
> +               /* Disable background radar capability in 3T3R */
> +               if (path =3D=3D 3 || rx_path =3D=3D 3)
> +                       return false;
> +               break;
> +       }

The indentation of close brace looks weird.=20

Since -Wdeclaration-after-statement is dropped, I think compilers will not
warn without the braces. But note that it is still not recommended to=20
put declarations in the middle.

> +       default:
> +               return false;
> +       }
> +
> +       return true;
> +}




