Return-Path: <linux-wireless+bounces-18482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A224A28157
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 02:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB6318837AC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 01:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCC2F5A;
	Wed,  5 Feb 2025 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GjVKgQhZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3B25A63B
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738719196; cv=none; b=JfDX0nYkqW8qBVO+/Mim+W9ms8izmK1jPcl7mCE5GSCRnOw/ixhhL6LhzOdhFaMNaRN19t0nAe0JpeX5Tw3ZMGAVgPVQIu3ii1nq+Tr9zZhGp7klSix12bXMog1pN66FNnGoSIVZM0C7XYeXVk4I9q3PxhARrh4R54bpfuxUDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738719196; c=relaxed/simple;
	bh=tJrHN2h0zpKCSS3qg4MkS6/EgjulfpSKA779hlS7Jco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0iTHuQPN1mWecSAsIi6dx78CjBijgvlFl+o5Juqf4C/Mhv8vye9v4H8DZ6KvfuslPbI45nwn1Rp5Z7WsnxDnVRJm1Eb/vNdlMyz0mbRE7gPWkANpgBsulpoLzTwyYRu5roECY4PFd+JCketaQzm9l3EPmcnqKmZLaVvCecpCQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GjVKgQhZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5151XCeP4761251, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738719192; bh=tJrHN2h0zpKCSS3qg4MkS6/EgjulfpSKA779hlS7Jco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GjVKgQhZPG38NwbmK1bjJv8Xw0UJN13IBjJFxP9ESDtuFehJfrfkIOL1ziVL0Akd/
	 FUVkPH5Bu1St4oCOcRKSxcueGSvQF3mNLKwePhTlQmyw7jSgSirdbJKBCrNvmR6IjG
	 61W4r+xGZZg2I7c7pL8x2jIYy9vmG6IULnLDSiuScTjGj/4n+fMWO/2wqrG23PHQym
	 AwzqBpHvG7UGjBBVkHQtVXXoODQt0/IE1Zg2DKKbn6eEkZAhAbsrmd3d8/+XANG2FE
	 zXWCfRk4QK7DR88iowhOqvznVVVtSazmHUpDwDE1WSxC7CkPXAJbwGfu14k3IQ6CkM
	 p3o0SFe05UpPQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5151XCeP4761251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 5 Feb 2025 09:33:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Feb 2025 09:33:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 5 Feb
 2025 09:33:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 1/3] wifi: rtw89: coex: Assign value over than 0 to avoid firmware timer hang
Date: Wed, 5 Feb 2025 09:32:31 +0800
Message-ID: <20250205013233.10945-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205013233.10945-1-pkshih@realtek.com>
References: <20250205013233.10945-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Ching-Te Ku <ku920601@realtek.com>

If the slot duration is 0, the firmware timer will trigger timer hang at
the timer initializing state in a low rate due to hardware algorithm.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 2c0ccf2f8bd9..806a51782467 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -89,10 +89,10 @@ static const struct rtw89_btc_fbtc_slot s_def[] = {
 	[CXST_B4]	= __DEF_FBTC_SLOT(50,  0xe5555555, SLOT_MIX),
 	[CXST_LK]	= __DEF_FBTC_SLOT(20,  0xea5a5a5a, SLOT_ISO),
 	[CXST_BLK]	= __DEF_FBTC_SLOT(500, 0x55555555, SLOT_MIX),
-	[CXST_E2G]	= __DEF_FBTC_SLOT(0,   0xea5a5a5a, SLOT_MIX),
-	[CXST_E5G]	= __DEF_FBTC_SLOT(0,   0xffffffff, SLOT_ISO),
+	[CXST_E2G]	= __DEF_FBTC_SLOT(5,   0xea5a5a5a, SLOT_MIX),
+	[CXST_E5G]	= __DEF_FBTC_SLOT(5,   0xffffffff, SLOT_ISO),
 	[CXST_EBT]	= __DEF_FBTC_SLOT(5,   0xe5555555, SLOT_MIX),
-	[CXST_ENULL]	= __DEF_FBTC_SLOT(0,   0xaaaaaaaa, SLOT_ISO),
+	[CXST_ENULL]	= __DEF_FBTC_SLOT(5,   0xaaaaaaaa, SLOT_ISO),
 	[CXST_WLK]	= __DEF_FBTC_SLOT(250, 0xea5a5a5a, SLOT_MIX),
 	[CXST_W1FDD]	= __DEF_FBTC_SLOT(50,  0xffffffff, SLOT_ISO),
 	[CXST_B1FDD]	= __DEF_FBTC_SLOT(50,  0xffffdfff, SLOT_ISO),
-- 
2.25.1


