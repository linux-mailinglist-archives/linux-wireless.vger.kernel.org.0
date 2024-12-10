Return-Path: <linux-wireless+bounces-16124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B131E9EA3AE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 01:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CF31887F6B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F4311CBA;
	Tue, 10 Dec 2024 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OdWQEeVd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C6111A8;
	Tue, 10 Dec 2024 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733790621; cv=none; b=DL4FMdSD1lUU+vIpoGylaKOT0ai030xxMPRmyvYqmRLryFDbfnZL6SMnBzX7ejhzOzxZwC+vfpptcZw+7WBRBtvki7tzsjGD/MSjtU7mW1QbNwaSsiDeMr3vM+fAUjSqz8zG1/G1qBgW6ZmYWHLzIYHe9AoPdKu1pUN4ryvLqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733790621; c=relaxed/simple;
	bh=uKLyr/jk/WVRbeBKud2kVo0DJTj9s3mF1BmwR3HvMv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LZUT2xa/gf6WuQTf1H5dmRT8q5cTo7scw7So99B4kvXKkFK0lkeK7WxykBx8baq6unBPVn1HvGlUu+WAqOu0h6Pd0A3We/s8rvPE9gfWyAPN5Jz615fAgTLPLtg6br8+j9ZK1z9nGxf1z3xZgjnvDly0AVBlAr8dgue7/0zg/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OdWQEeVd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BA0UEcsC1291922, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733790614; bh=uKLyr/jk/WVRbeBKud2kVo0DJTj9s3mF1BmwR3HvMv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=OdWQEeVdNv2nSTSAtd1yQewGIzJt0qI/qTu49RdOWe5cGMmMF9CZIwdlS1awbWUfg
	 X7HOMacODG+S+mAcy/CbHj5PytmV0RDPhv3Qz6m0qKhzVD7mSNViWK5HXjYC3+16bX
	 E/tgqGbAUpXripGWIKAlTq1hf+uRCMQLLg2/YZpAdlWhM6QyHfAh2RHw4V51P8l5/T
	 kQQnB+5CTxJ6DEzUPkKgsFpuatwDLGY9edzGcw6z0Ym2kEuhArRL9QB/KbFY5COdKG
	 wCMqizywvylvePVbfnTirPv2uIkIzRzad419dZkpqm2PAU2XUGEynf5QN1mFIquAxt
	 nyMiFSCbIlAzw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BA0UEcsC1291922
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 08:30:14 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 08:30:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 10 Dec 2024 08:30:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 10 Dec 2024 08:30:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?iso-8859-2?Q?Micha=B3_Pecio?= <michal.pecio@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: rtw88: missing device IDs in v6.13
Thread-Topic: rtw88: missing device IDs in v6.13
Thread-Index: AQHbSiuRS6GXb/siRk+U2hzrP9sqf7LeoBuQ
Date: Tue, 10 Dec 2024 00:30:14 +0000
Message-ID: <610cce6b33ef4c6b83d2e0be212c62bb@realtek.com>
References: <20241209121441.304a9e8b@foxbook>
In-Reply-To: <20241209121441.304a9e8b@foxbook>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Micha=B3 Pecio <michal.pecio@gmail.com> wrote:
>=20
> Hi,
>=20
> v6.13 gained support for several new RTL88xx variants, but most patches
> with device IDs haven't made it to -rc1, so the drivers are unusable.
>=20
> Would it be possible to forward these rtw-next commits for the next RC?
>=20
> 7b5ce65d9018 ("wifi: rtw88: 8821au: Add additional devices to the USB_DEV=
ICE list")
> 1ee6ff9ae3c1 ("wifi: rtw88: 8812au: Add more device IDs")
> d4c4903508f9 ("wifi: rtw88: Add additional USB IDs for RTL8812BU")
>=20

The patches missed the merge window of v6.13, so apparently v6.14 will have=
 them.
Next time you submit urgent patches, please reference [1] Kalle mentioned.

[1] https://lore.kernel.org/linux-wireless/5736c7a2cf7843fab0b491d1482bb292=
@realtek.com/T/#ma50f80cf9c815b78ee483ee3cbe9b987dc5120a9



