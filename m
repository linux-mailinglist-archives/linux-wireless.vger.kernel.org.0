Return-Path: <linux-wireless+bounces-27777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECE3BB3652
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 11:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFC33B9C61
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8762E2FF655;
	Thu,  2 Oct 2025 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LkiGaNpv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13042F28FA
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395780; cv=none; b=tTisss64klurmgpctw65Bf1r8vy4Bj0ItOTCfMM6NS8S8Yxj8hatOf7rGyA6Gy9Hlzg17hf8RIqRPnqrlwmJTlf9YGvPV6TcfIaRznpMKGoBzuVnaiz6d8Yd9erklWiK3bFZkRRsuqKL//iegDRR6Pq/jshlHGuU205E/zydaw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395780; c=relaxed/simple;
	bh=fClv+PEi6LBpSIQdSH9cU68BB0dKPEdyzqwHkqw7lf4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=euFFrtf05GWWhyadz2pCL0BEKbeZ5YggASMffI4B5QfClBRm0O/WMrZqJx1BnRFqzEtzF8+ZsGsEjsISj32hX7Nv6F6CsQmI8XDDl3TSci8uEL2J1Z3tUVtbAPimvKj6LaqNEqYpN9UEP4AaRJ2wpwv+wme/oWzqXj69n+A6kXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LkiGaNpv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59290Ab74156310, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759395610; bh=/uLNTYgq++xMFTZCUKAtlgpHIez29xrz2qgThwGMJEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LkiGaNpvrkTol7a2luKYdESROx/LbzEcunqJdA14lclPb2zrQuox0Vw1z05pkWQl7
	 DelBZelMKTfLWn1slnJvfKxNy5TA3PdQoAlAOXNCUDE2+bPWajgauc8UZH5ztv9qGt
	 A9AvpzoTDly5sN1ZQm6wnXPHUBwVfYvUIjbxSDbTeiSVBLuWFSiz8jpDQ677Ky9F7F
	 u5EmsAR8XmH8P5Yq/ZPd1+lPVtEkF6YkET53w/ynkgyctEdq8NIfmeGLe0onxTqGKS
	 ld1gDMcF+Gk6D1IGW0Szaac1K27s4TFMgvqnCt4C2oTTq7rYVRHe+abXcT93O5Ty8e
	 Ir1dPOz66mYMA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59290Ab74156310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 17:00:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 2 Oct 2025 17:00:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 2 Oct 2025 17:00:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
        "Sean.Wang@mediatek.com"
	<Sean.Wang@mediatek.com>,
        "Leon.Yen@mediatek.com" <Leon.Yen@mediatek.com>,
        "Michael.Lo@mediatek.com" <Michael.Lo@mediatek.com>,
        "allan.wang@mediatek.com" <allan.wang@mediatek.com>,
        "Eric-SY.Chang@mediatek.com" <Eric-SY.Chang@mediatek.com>,
        "km.lin@mediatek.com" <km.lin@mediatek.com>,
        "Quan.Zhou@mediatek.com"
	<Quan.Zhou@mediatek.com>,
        "Ryder.Lee@mediatek.com" <Ryder.Lee@mediatek.com>,
        "Shayne.Chen@mediatek.com" <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
        Michael Lo <michael.lo@mediatek.com>
Subject: RE: [PATCH] wifi: mt76: mt7921: Add PCIe AER handler support to prevent system crash
Thread-Topic: [PATCH] wifi: mt76: mt7921: Add PCIe AER handler support to
 prevent system crash
Thread-Index: AQHcM0bFMwfObIU+IE6WawiB/E+qXrSujulQ
Date: Thu, 2 Oct 2025 09:00:10 +0000
Message-ID: <2a6c3c8d2ae7442cb9923521bfe0a6f2@realtek.com>
References: <20251002024610.2840198-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20251002024610.2840198-1-mingyen.hsieh@mediatek.com>
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

Mingyen Hsieh <mingyen.hsieh@mediatek.com> wrote:
> Activating AER ensures that enhanced error reporting feature are
> properly initialized, enabling more effective error management
> and helping to prevent system crashes caused by PCIe errors.
>=20
> [ 2932.266976] Unable to handle kernel paging request at virtual address =
ffffffc01099eac0
> [ 2932.267800] pc : mt76_dma_add_buf+0x124/0x188 [mt76]
> [ 2932.267831] lr : mt76_dma_rx_fill+0x11c/0x1d8 [mt76]
> [ 2932.267845] sp : ffffffc016d9bbf0
> [ 2932.267859] x29: ffffffc016d9bc10 x28: 0000000000000000
> [ 2932.267885] x27: 0000000000000000 x26: ffffffb7855e50b8
> [ 2932.267911] x25: ffffffb80d04f000 x24: 0000000000000000
> [ 2932.267936] x23: 0000000000000ec0 x22: ffffffb796803648
> [ 2932.267962] x21: ffffffb796801f80 x20: ffffffb7968035f8
> [ 2932.267987] x19: 0000000000000ec0 x18: 0000000000000000
> [ 2932.268012] x17: 000000004ec00000 x16: 000000000ec00000
> [ 2932.268037] x15: ffffffc01099eac0 x14: 000000004ec00000
> [ 2932.268063] x13: 00000000ffc5a000 x12: ffffffc016d9bc32
> [ 2932.268088] x11: 00000000ffffffff x10: 0000000000000002
> [ 2932.268113] x9 : 0000000000000000 x8 : 000000000000b4ac
> [ 2932.268138] x7 : 0000000000000a20 x6 : ffffffb6c1806400
> [ 2932.268163] x5 : 0000000000000000 x4 : ffffffb80d04f000
> [ 2932.268188] x3 : 0000000000000000 x2 : 0000000000000001
> [ 2932.268213] x1 : 000000000ec04000 x0 : ffffffb7968035f8
> [ 2932.268238] Call trace:
> [ 2932.268275]  mt76_dma_add_buf+0x124/0x188 [mt76 (HASH:1029 4)]
> [ 2932.268309]  mt76_dma_rx_reset+0xe8/0xfc [mt76 (HASH:1029 4)]
> [ 2932.268342]  mt7921_wpdma_reset+0x188/0x1b0 [mt7921e (HASH:ee48 5)]
> [ 2932.268371]  mt7921e_mac_reset+0x128/0x418 [mt7921e (HASH:ee48 5)]
> [ 2932.268403]  mt7921_mac_reset_work+0xac/0x1a8 [mt7921_common (HASH:f72=
1 6)]
> [ 2932.268427]  process_one_work+0x188/0x514
> [ 2932.268445]  worker_thread+0x12c/0x300
> [ 2932.268465]  kthread+0x140/0x1fc
> [ 2932.268483]  ret_from_fork+0x10/0x30

As documentation, timestamp isn't preferred.=20


