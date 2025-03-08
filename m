Return-Path: <linux-wireless+bounces-20022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4444AA577C7
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 03:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFC21742E1
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 02:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F4C16A95B;
	Sat,  8 Mar 2025 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ev/Hh43Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA91624CE
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741402749; cv=none; b=V/y9PzmhXPq3CFUa5Z0JCPdKWsPFcJEoNwlRIXbMBje6+IYPEOLX7qncgtQgjcg/+6jzJo9IvOZiDrmLjAS8r5YnYtqa4phVDuxP4eZFXcMk+x2HLWemQYnb3F5NpOMor+nmqxpk0qjNehcjm6jU5Y8S5j3qcQE321fjdyoAVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741402749; c=relaxed/simple;
	bh=sADAdYbXlzlSZYHTKzM1br0G5QNg/RcLMy3qssvEJ8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nw2r6W3id+GVXoNaogZpS3onermAV6df+w5/72wDgTwjPnCLA2Jt/446wA/4zsC8bumB0dKVPeq5soC/72YC/u+HOuNOxWsCCEC54vNW79EMKaKU2cVgzGwdjYyLsvqlwGyd5sPvbL656F8L2WmiE+OVOCqmKMivzG3diR/mVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ev/Hh43Y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5282x4T612568410, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741402745; bh=sADAdYbXlzlSZYHTKzM1br0G5QNg/RcLMy3qssvEJ8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ev/Hh43Y8WRYjzFxPkmZFOM1ovnC7euG4PzqritzgWPU65dmjndJGTRWq/iPVXMJd
	 jqKkf9IHL3TTbZYM/tPjfSGPydkln4IdJO7Aa1sq1v01+ggj4COSEY8LDSM4rCWn5+
	 as6LbTOw/4xSDArmC58ppeXoGyemSRrYyASku9j1dCPVCI3Cj/GE1wUZqxLl3NIKfW
	 kCiLIM+vN9MbDRDF8/+zk0TSMnlpDDJr/LitIPay4ZsJ0ScC7dG8uZwPFBAiSAyEH0
	 y98poRaXAeXQSWA4GV87UY6Dh0bas0Sl8+onxEE3e0tZoG8ziBJnO3sqwCg5fAa7nL
	 TxXKRgR7QYKbQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5282x4T612568410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 8 Mar 2025 10:59:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 8 Mar 2025 10:59:00 +0800
Received: from [127.0.1.1] (172.16.23.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 8 Mar
 2025 10:58:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 4/4] wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.4
Date: Sat, 8 Mar 2025 10:58:32 +0800
Message-ID: <20250308025832.10400-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250308025832.10400-1-pkshih@realtek.com>
References: <20250308025832.10400-1-pkshih@realtek.com>
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

RTL8852BE-VT support for firmware 29.122. Add parser for Bluetooth channel
map report version 7.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 659b92b14d88..5ccf0cbaed2f 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -10,7 +10,7 @@
 #include "ps.h"
 #include "reg.h"
 
-#define RTW89_COEX_VERSION 0x07000313
+#define RTW89_COEX_VERSION 0x07000413
 #define FCXDEF_STEP 50 /* MUST <= FCXMAX_STEP and match with wl fw*/
 #define BTC_E2G_LIMIT_DEF 80
 
-- 
2.25.1


