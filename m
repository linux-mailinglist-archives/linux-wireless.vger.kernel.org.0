Return-Path: <linux-wireless+bounces-8150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943418D1190
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 04:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A755B1C217C7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 02:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD81C2E;
	Tue, 28 May 2024 02:03:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D25139D
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716861804; cv=none; b=RAIakQqfqGfriby/+eqT6abPdCiOyrOHT/A+TLvjtznN+nxbPPS1a/+4Kg9JDyXj/ciL+U+2m9LnxQjLXDIv7RN0a/ODrNS+RDXoH2GF9rs2JtQP1VFwtlyxniRwvsE2ZfsRDgrkTPYPo4AlFrY0V/N7l1+1cJJJ3NFWyanLFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716861804; c=relaxed/simple;
	bh=WjKDY/33S0vq8P9kgBoubkLMk8gmJJsa2uvFMFPRNqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHGJcT68Q7QBxhUXt+Rr0lle/40XSy8qozwkox0x5LaQqy357BtJZp9MXKoskHIZE0ZYblv1q0ZQwHhMSRxxZWTmIiWyfzDll818dv3D9MEcuiIGqmmUjMeEA0l33ODvL/XmnX+c3y7dYUggbhJqjWVvz3QKCgxpywARX27OI50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44S22vEgA1819970, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44S22vEgA1819970
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 10:02:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 10:02:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 May 2024 10:02:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 28 May 2024 10:02:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry
 Finger" <Larry.Finger@lwfinger.net>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v7 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
Thread-Topic: [PATCH v7 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
Thread-Index: AQHarSBdbyWf9lKLLkKgqAnWSxDd/bGquXUA//+V1QCAAZxGIA==
Date: Tue, 28 May 2024 02:02:57 +0000
Message-ID: <ad363b11d2bb44adb5a3764bf973b6b5@realtek.com>
References: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
	<5f2da7ee-876a-42fc-8fec-ec5386fa8c26@gmail.com>
	<0002749a3b584bc39fa18b3137153fdf@realtek.com> <20240527112534.4dbcdf75@mir>
In-Reply-To: <20240527112534.4dbcdf75@mir>
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

Stefan Lippers-Hollmann <s.l-h@gmx.de> wrote:
>=20
> Again, rtl8192du v7 itself is 'fine' and could (can) achieve 180/100
> MBit/s before the chanctx changes, so merging v7 might be okay - but
> there needs to be a fix for rtlwifi as a whole (and maybe even other
> drivers) for v6.9+ and the chanctx changes that came with it (not
> every chipset supported by rtlwifi might be affected equally badly,
> e.g. rtl8192cu might not noticeably be, according to Bitterblue's
> testing).
>=20
> So with the (performance/ packet loss) caveat above:
>=20
> Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>

Thanks for your test and additional information. I will merge v7.



