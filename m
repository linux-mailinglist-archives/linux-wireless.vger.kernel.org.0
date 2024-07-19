Return-Path: <linux-wireless+bounces-10377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75279373EF
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 08:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4081C20BD3
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 06:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0B83BBD8;
	Fri, 19 Jul 2024 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="UbNNVN3Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0721B86F8;
	Fri, 19 Jul 2024 06:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721369617; cv=none; b=sT2HUAoHM4ams/aCvh+7ap/DBuC770946KfojdSnGyiEpZs611CT7slli3nHMxmNXml0O3i6xeuUtXruxsJiTEXrpsgYwmTNQmeN04O8NuCRkGnXvCp8byXS+RX8NwBlVAVJeU+hC3fy2dSfnn8FmNQ/qZc0EgVb5w4pcYtN10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721369617; c=relaxed/simple;
	bh=keoKFt2WP3Sa5Bxh+D+xTWFV+1WFTFkoCdr7RqlVPI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iYyJbTMq0bZighWFkpo+pkJLzGODGmNL2VQM7Z8DSgoNA0RZj71Vwx3d7DanmjOXhxDI9XDYLzNWDYdaWehbBakpSGKB2L6UKFqHt3qnt39DsXk9bmowUHzeNxmQNBOQYrKjfrCv6e/rdgkZ6mVIb0+qoEEiAVIiQjDY/vBIRPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=UbNNVN3Q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46J6DRGI0175595, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721369607; bh=keoKFt2WP3Sa5Bxh+D+xTWFV+1WFTFkoCdr7RqlVPI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=UbNNVN3QlINw9pn3pKCH2sUGcSGchhyiE+evoesEzEsOR+GLZ8zE1NhjPpH9qmcE2
	 gZjllT70iTdQfU1yWH45Q++NnPBezB60r4issCJ1So5/EyMH1OegRKQxTRTpETRuq9
	 s3nuoc8a4QNupQzYu7NhIl4OamLXJsg+WWP6AOOkAoFBhDroV3IrppSg0aasWIoMKG
	 zQKga6r2+xlWPmju9JFGP/x+E/AArLTxGYx1p+zBQ3fpXClwjioUlZ/aeFhDZR5cbb
	 VM1Zaba65Rk2jOxU5KasBpMhQIbSEYIVJc0qkmFUk/SL1rT1h4XECXsSfiAEZKqMLb
	 vbDil4Mvm8gRw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46J6DRGI0175595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 14:13:27 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 14:13:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jul 2024 14:13:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 19 Jul 2024 14:13:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: kernel test robot <lkp@intel.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: RE: [PATCH 6/6] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig
Thread-Topic: [PATCH 6/6] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and
 Kconfig
Thread-Index: AQHa2L2YJFs38n3VwUucwKGfNCaTC7H9CNEAgACK26A=
Date: Fri, 19 Jul 2024 06:13:27 +0000
Message-ID: <08aab96c829643b5acaf4dd802890714@realtek.com>
References: <20240718025138.18777-7-pkshih@realtek.com>
 <202407191347.UQSKNzbG-lkp@intel.com>
In-Reply-To: <202407191347.UQSKNzbG-lkp@intel.com>
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

kernel test robot <lkp@intel.com> wrote:
>=20
> >> /usr/bin/ld: drivers/net/wireless/realtek/rtw89/rtw8852bte.o:(.rodata+=
0x50): undefined reference to
> `rtw8852bt_chip_info'
>    collect2: error: ld returned 1 exit status

I will add missing 'config RTW89_8852BT' to Kconfig by v2.
Thanks for finding.

Ping-Ke=20


