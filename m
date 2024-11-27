Return-Path: <linux-wireless+bounces-15745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABDE9DA272
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 07:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1345FB2239D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 06:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3431C13C9A6;
	Wed, 27 Nov 2024 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BhrMSVrn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF74D1494A6
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689907; cv=none; b=uW18GoDCq3TS0oWSuDst7+TiQ2tvR/T50b74XNmSu8/4Qx7awJzET7lfBFb5nGynEd5E4rTnFFFwSZD4Y3qPGkxKm05zuda2ly0fP0XB/5UYjtM1mpgELZ1s6OS+5qVeCdxT3Xg59qHSy+zc+0zfuFpgDr1gEWpzjSbIwdcI4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689907; c=relaxed/simple;
	bh=hbOXhEI23/u0bL9IyJD1YDviglHUjYNqL6HHe0AFf8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ud7fC9AkdaOiOg+F9Qrw0WYJLR2aCUZzp8yH5+avaHfPawSl3pqcfg/8YxsOZWnxesO2qerYIrOujhkRHjpIEHw3JdbQNJ0nEEfxu8AVfTPD52CloiuK/eY8pMM7yzd37U8vRhq5PncDeWm5pe+0PMkJYvTDIy6dJEHOOy8d9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BhrMSVrn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AR6iiNeB2315888, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732689884; bh=hbOXhEI23/u0bL9IyJD1YDviglHUjYNqL6HHe0AFf8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BhrMSVrnquBdrKyQOYMWyow6pa//FPFO9dsLLlAvE/6TX5FEe5KPrEs7rKpoPOcAh
	 Sn629E6Mdk8ulyLL6s65zGDfV7fuMqUiLsy5zEH/PqiEFsO5zP/s9FfIH4dFO76ElT
	 +cB3j3fTN9Q07Xu5eUFBKYgLKe8lnql54me2RskaxY2p58wcY6PXfqK/w98FiwDGCt
	 OvhemGY7GZGjFGPLBdIobE0ykPleSFYq1v01txG1Fisq/bUPhfVNKxRPdWLW57dh8P
	 qCNhY3uNC9rtnnpTnAAsi4vnGHYAdkc/yQe/KprBaEeiJ0aDGXAdPw82B1PpP4+DbS
	 Tilvbl2P2p98w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AR6iiNeB2315888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 14:44:44 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 14:44:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Nov 2024 14:44:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 27 Nov 2024 14:44:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH 0/4] wifi: rtlwifi probe error path fixes
Thread-Topic: [PATCH 0/4] wifi: rtlwifi probe error path fixes
Thread-Index: AQHbPQPt8AQNM9mpGUqBMTA/7pfKnbLKtFNQ
Date: Wed, 27 Nov 2024 06:44:44 +0000
Message-ID: <b2b4bf1246054c9a97d56893c3dd4371@realtek.com>
References: <20241122172718.465539-1-cascardo@igalia.com>
In-Reply-To: <20241122172718.465539-1-cascardo@igalia.com>
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

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> These fix different bugs when the probe fails. One of them is the additio=
n
> to a global list, which is not removed during the error path. That list h=
as
> been removed.
>=20
> Then, some memory leaks are fixed, which require a change in where the
> workqueue is destroyed.
>=20
> Finally, the firmware completion is waited to prevent its callback from
> accessing freed data.
>=20
> These were tested against an "emulated" rtl8192se. It was a changed rtl81=
39
> device under qemu with the rtl8192se PCI ID.

Interesting. Does it mean qemu can support PCI pass-through to work with
real hardware?=20

> Memory allocation failures
> were injected over 4 different places: init_sw_vars, rtl_pci_init,
> rtl_init_core and ieee80211_register_hw.
>=20

For the Fixes tag of cleanup patches, I'm not sure if it should be or not.
We can keep them and leave maintainers to decide taking to stable tree or n=
ot.
If that happens, please carefully check the dependency of these patches.=20



