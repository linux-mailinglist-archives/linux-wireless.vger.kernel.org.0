Return-Path: <linux-wireless+bounces-21594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21BA8B307
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 10:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA0F190591C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFAB22FE06;
	Wed, 16 Apr 2025 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nBASj8om"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B089822DF80
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791207; cv=none; b=goLrB6k2vmi953kRFMIK/epTnf6htqfBgm5afUv/i0cnVouPp/RavF7lrlL9X24fDi3HTN+IBDUWB4KONCklafG3qLDOu4cOkkpYG5GPTHy25LAhkoneFMVfvIaIR5XgtIVLbz8Q2S9nz7DYbYID2qhIDrOUxsq1YW8A+EpPsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791207; c=relaxed/simple;
	bh=xekqQMc3xD4P9U1MW2vmFtRJQYjW06CDfxu1AIaYt20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLuC+m9fHIZQXXFB1a6O9BtrsnAreIyYb4017tCldJ94p2gVIhEEIB6H64PLPWMcuvIrJaUSYsGZDusSTvGvCKUUvV/zLixGoUUJBpNsFR/G99V/YL9WR3hbnxFRGrV8wVaT/3JaBGH6t2FOr/sW+K7sV4HaXICo3qJ7npyo2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nBASj8om; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53G8DGLr82935254, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744791196; bh=xekqQMc3xD4P9U1MW2vmFtRJQYjW06CDfxu1AIaYt20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nBASj8omt/6ElzHzuuajvkbCj6i8eOqgEVBK+FVM1N/Yr4DIHIeqf5mNRiyDU6HJL
	 4n9MrSQaVLjJ/mRFWKS2FDBUjrmcKPhJN53fDDh+kGCI+TqPSoDad/Be+UY2xiG41W
	 42B/fQPXIG2UlUkBGWyXS4kd338O/9yMXCWYl5BkRAWmKjSrNxP3g6h708asymClNh
	 SUltkfz2BBjQiv2EEMTxGXM8V8Ig7Ys3sQZ4RqCbhxcMEOoBZ2rnNUBIvx381P/hG5
	 4d8oQjuOlADXrTibsPUTD89EGhdr1JD6v2kNr8Aff+4RWYHyGj4s+/fjLgL4w/KQ82
	 N9AswGw6Jq4ag==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53G8DGLr82935254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 16:13:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 16:13:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Apr
 2025 16:13:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 1/4] wifi: rtw89: 8852c: update supported firmware format to 2
Date: Wed, 16 Apr 2025 16:12:38 +0800
Message-ID: <20250416081241.36138-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250416081241.36138-1-pkshih@realtek.com>
References: <20250416081241.36138-1-pkshih@realtek.com>
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

After firmware 0.27.125.0, it adds more fields to support firmware secure
boot. Though current driver has supported the format, old driver can't
recognize the new format, increase firmware format to 2 to avoid failed
to load the firmware by old driver.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index a8fd573d5048..9a2235f28e24 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -15,7 +15,7 @@
 #include "sar.h"
 #include "util.h"
 
-#define RTW8852C_FW_FORMAT_MAX 1
+#define RTW8852C_FW_FORMAT_MAX 2
 #define RTW8852C_FW_BASENAME "rtw89/rtw8852c_fw"
 #define RTW8852C_MODULE_FIRMWARE \
 	RTW8852C_FW_BASENAME "-" __stringify(RTW8852C_FW_FORMAT_MAX) ".bin"
-- 
2.25.1


