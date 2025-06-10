Return-Path: <linux-wireless+bounces-23934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24039AD388E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD381BA033C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2732E3395;
	Tue, 10 Jun 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GMKT35Y0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD32E62D3
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560491; cv=none; b=Bl9JYiuRM/z9MIckB8IiCDI46UWLWNIb3qyZe0am6QFi57JtlRUfLtrCyCvwg/dnPNguL3+cgNXksySLLvJJRAuiQ41dSvyqmp0ysP4mU9AtXqM2S482oG8N81fauJvOo/Q2sQuEvEJaYqrSqeFeDw4IZgouO2pEX92Z3QN4+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560491; c=relaxed/simple;
	bh=LQxrChd0Tk65RFiCkyTsXxpAeXdqT9oO2KL7mU5d1eQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqaeqxkzqk78XeCWxLyuLDHeG2AwB51/NuN1DjJZRQ2vBu6Vzyh0XX67MBaWBTWbPgPhjovJ4NkZQaEv6GTj7z9A3vehv5SaMV6oyN8vennXGmFjxGWl8pq82aI9sEjQfDH3bi8zkylU0kVzjBDWE4RYORGo7xSVov8T4381vHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GMKT35Y0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD1Rs542995493, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560487; bh=/tFuGMrmO3c4XLNUp0N5HMbL9rAAu3n+pfdqyJ3ljyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GMKT35Y0CpHXGcEyC5ICS7tNETO8lF/LZ0UyF4W2n2/1oGHADxs+32ezzutKtMNEr
	 WQEjUIeJl4auSOrqQTbe83SFZxQyvAhlM5rJGq5AY20ngRsAma4E3/xzfseyxbXyLZ
	 PW9eBtMLIJ9WEQAmlEC+jy0aqfYNVtQx4vN/9ZQUvx9skPMmgsO+LXy2TifAeh1rhF
	 xi1tibXq0IsJDPa+Ebez8yucz540syas6I1utZiLm4t3/sKPsL9AnoHrHT4njF/Y98
	 uSSc1cK7cM4sigMZAzrX5/D87DDPe6SqdhWw/iKQ6OgBPnMzTQehtH982dNCS/QY3f
	 jAxA8P2j9ckBg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD1Rs542995493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:01:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:01:27 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:01:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 07/12] wifi: rtw89: mcc: adjust TX nulldata early time from 3ms to 7ms
Date: Tue, 10 Jun 2025 21:00:29 +0800
Message-ID: <20250610130034.14692-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610130034.14692-1-pkshih@realtek.com>
References: <20250610130034.14692-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

Adjust TX nulldata early time to let nulldata have more contention time
to TX. Otherwise, AP is hard to receive nulldata 1, which causes the
throughput test failed due to packet drops.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 5f10f3955e5c..e0e1fb844304 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -31,7 +31,7 @@
 #define RTW89_MCC_DFLT_GROUP 0
 #define RTW89_MCC_NEXT_GROUP(cur) (((cur) + 1) % 4)
 
-#define RTW89_MCC_DFLT_TX_NULL_EARLY 3
+#define RTW89_MCC_DFLT_TX_NULL_EARLY 7
 #define RTW89_MCC_DFLT_COURTESY_SLOT 3
 
 #define RTW89_MCC_REQ_COURTESY_TIME 5
-- 
2.25.1


