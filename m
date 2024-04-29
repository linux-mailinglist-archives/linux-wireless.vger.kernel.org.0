Return-Path: <linux-wireless+bounces-6955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DA68B4F58
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 04:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805261C208BA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 02:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F5B63E;
	Mon, 29 Apr 2024 02:08:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006797F
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714356492; cv=none; b=LIQFRwQSbKKPmp1dmA0p9rQ2xjF+9OYbXAvDWrlSzKOfx+etVkeZI0s6TcmvDtskcMRs71axUImbOG+KpRq8Ah7WStySXsCKYwHuYnEueUN5DgMTRp74iKWDgpNlrZiNFsYp3ABs0zm/kzUQFoXSU1MDoh4mMa/yFD6KcbQXFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714356492; c=relaxed/simple;
	bh=2cHzbQnZ8P5rfhgkkdfVldg9IegxgDky17cx65iff8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UisNAm9xOnFuluqA/SaPnohJ8oOrL/0T7VKGpxlC0qcJj83zXuRK0Suwtj7WLmTnVrH6lVNR2YCsW2DhyXVS52ilkmKLsauTdEcRm3gDP9lW7cHQIMOnfESTG62jvjSroJEcOiBumickbB1Ksh2OKONSzs7iFSB8Jv1SoXaQz3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43T285fzC2936347, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43T285fzC2936347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 10:08:05 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 10:08:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 10:08:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 29 Apr 2024 10:08:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: rtl8xxxu: remove some unused includes
Thread-Topic: [PATCH 1/2] wifi: rtl8xxxu: remove some unused includes
Thread-Index: AQHal+TKjpgPPiYrQUiGyEHZzIn5BLF+gaLg
Date: Mon, 29 Apr 2024 02:08:04 +0000
Message-ID: <76b9ba19dd4642ed98975e62bc3ebca4@realtek.com>
References: <20240426141939.3881678-1-kvalo@kernel.org>
In-Reply-To: <20240426141939.3881678-1-kvalo@kernel.org>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Kalle Valo <kvalo@kernel.org> wrote:
> I noticed by random that rtl8xxxu includes linux/wireless.h even though i=
t
> doesn't need it. While investigating a bit more I found even more unused
> include files:
>=20
> #include <linux/init.h>
> #include <linux/sched.h>
> #include <linux/ethtool.h>
>=20
> It looks like that the includes are just copied to every file without che=
cking
> if the file really needs the include. So more includes could be removed b=
ut
> that would need more careful analysis per each file.

I can do that. My ways will be to create an empty (new) C file to examine
every driver's header file can be included individually, and then try-and-e=
rror
to remove includes from existing C files.=20

However, this driver uses #ifdef. I will check if autoconf.h is included.

>=20
> No functional changes, compile tested only.
>=20
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>



