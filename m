Return-Path: <linux-wireless+bounces-20684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CF5A6C2C8
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 19:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB5D188F449
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B55F1E766F;
	Fri, 21 Mar 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="pP1rG9bB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ksmg02.maxima.ru (ksmg02.mt-integration.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE869B664;
	Fri, 21 Mar 2025 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583213; cv=none; b=oTZbL4intldjdSl0hfFNi2nFLfxAslQtMH92nFlt+jiPVpdaNozrtW9/1w6lGgzjM3lPoklUdrgcbZLbSDZSMCW82N1ExNGrzRSlo1BeDl3/fXQayzZ4yif86wr5R5tNAWX8wpfgOOJ9oPYNutCOKRd3+aSediplGPRjz6hkEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583213; c=relaxed/simple;
	bh=qvYGATRHvmurx6T/dwbugyrnFwdJ2Gxcyzi7EU81Ia0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QOmltt3PkH/qDa2cw1dFclhC2TgL1NSTmacGat/tKwGELhNrP/Kq6qgx1NCijkls0R2dVoZlF3ntZlx9mrl5udgoudK0/Hp7vWvPJRWMN3mkog5mJvXNEt4wCaZU8t0P/jnJ1vn8vyFjN2aVRPQ020ZOhmlIHJ+UI5BUg6p5BhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=pP1rG9bB; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 586AB1E000E;
	Fri, 21 Mar 2025 21:53:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 586AB1E000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1742583199; bh=14mPebvyhkJEga64dviTcByCuIzfjpKl4JeDtI8EFFA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=pP1rG9bBuzW9Zd9ewT+xFnK08ynPw8aeyAwGQ2pOWXZWBmFBwHY+1xaFWfFo7Yk67
	 0+o5w9XPNbqqNUYdHoyu67B8hOM22PHqFLjff1uloRs5p4AtwKnnXXpxA1+2xg0xpD
	 jskfu5Z1WkMiDCzelMfGhA6r7fAGb3b8NAFFF0f+4z6ZMINGQHeUmJn/9u84K4IDuB
	 bujqxszSxcOEracW37mVbhBcFtr5EHbDnHwZjOzNDHybwcbCtWc38ujoMBJljH/peI
	 mAHeR7HC0uFxYDhn7UUoNI9RDyjlGO1WHpThOOGIiNKyXDK4gqTApeJt4wN1FRtkO5
	 7Q1he34VSoO7Q==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Fri, 21 Mar 2025 21:53:19 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.178) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Fri, 21 Mar
 2025 21:53:15 +0300
From: Murad Masimov <m.masimov@mt-integration.ru>
To: Srinivasan Raju <srini.raju@purelifi.com>
CC: Murad Masimov <m.masimov@mt-integration.ru>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, Emmanuel Grumbach
	<emmanuel.grumbach@intel.com>, Johannes Berg <johannes.berg@intel.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Kalle Valo <kvalo@kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 0/2] wifi: plfxlc: Fix usb device interface deinitialization
Date: Fri, 21 Mar 2025 21:52:24 +0300
Message-ID: <20250321185226.71-1-m.masimov@mt-integration.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.200.124.62:7.1.2;ksmg02.maxima.ru:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192024 [Mar 21 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/21 15:38:00 #27810206
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

These patches fix issues during the process of deinitialization that is
done when a device is disconnected or when probe fails.

Murad Masimov (2):
  wifi: plfxlc: Remove erroneous assert in plfxlc_mac_release
  wifi: plfxlc: Fix error handling in usb driver probe

 drivers/net/wireless/purelifi/plfxlc/mac.c | 12 ++++-----
 drivers/net/wireless/purelifi/plfxlc/mac.h |  2 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c | 29 +++++++++++-----------
 3 files changed, 21 insertions(+), 22 deletions(-)

--
2.39.2


