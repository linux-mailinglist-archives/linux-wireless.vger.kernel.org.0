Return-Path: <linux-wireless+bounces-6411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB58A7A36
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 03:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815031F21BDD
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 01:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A14690;
	Wed, 17 Apr 2024 01:40:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C946A4
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713318048; cv=none; b=snpSUZOkHkmybKFxUv6QLx5HajiuqCqMKYbkOgT9/45DH8HwBs2NhZMEP/A8n4rEwXHBGYxKzkUJUNpPi/b7K4PcDexDBl/YKFTlpFHxNhlK3ms7qkT0mj+nAE2D4QgPn8wKmjcBK5G0zxOUcDpvGKdJsTrK2rZ33+nXA8lMggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713318048; c=relaxed/simple;
	bh=X4RDF4UkXIqxFvUC7saWO7gIoegak0X4KYI/kUYAW8c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lkAOswC1HfXotZtrmht9YQyxiYk1PGqN2Qn5R6dWaxb8WWt34S0l5E0G4wREl7e7DZlpRquF9GmbEXsCfLuOoDJQEOb33iOFb8YmsNf9lWsKWw14wqgJYkd2XgipHf9O8wDoX8MKIDUK3aJB5QNOnQTjH/IqJS/e5DUMQizRDck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43H1efr972820312, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43H1efr972820312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 09:40:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 09:40:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 09:40:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <lewis.robbins2@gmail.com>
Subject: [PATCH] wifi: rtw88: suppress messages of failed to flush queue
Date: Wed, 17 Apr 2024 09:40:36 +0800
Message-ID: <20240417014036.11234-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Driver throws messages when scanning with a lot of traffic, because packets
in TX buffer can not be transmitted in time. Since this is a common
occurrence, change them to debug message with special debug mask that
developers can turn on this mask by default for further analysis.

Cc: Lewis Robbins <lewis.robbins2@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.h | 1 +
 drivers/net/wireless/realtek/rtw88/mac.c   | 3 ++-
 drivers/net/wireless/realtek/rtw88/pci.c   | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.h b/drivers/net/wireless/realtek/rtw88/debug.h
index f20c0471c82a..eb69006c463e 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.h
+++ b/drivers/net/wireless/realtek/rtw88/debug.h
@@ -26,6 +26,7 @@ enum rtw_debug_mask {
 	RTW_DBG_STATE		= 0x00020000,
 	RTW_DBG_SDIO		= 0x00040000,
 
+	RTW_DBG_UNEXP		= 0x80000000,
 	RTW_DBG_ALL		= 0xffffffff
 };
 
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 699ae3048c6b..1fa273012b9c 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -1046,7 +1046,8 @@ static void __rtw_mac_flush_prio_queue(struct rtw_dev *rtwdev,
 	 * And it requires like ~2secs to flush the full priority queue.
 	 */
 	if (!drop)
-		rtw_warn(rtwdev, "timed out to flush queue %d\n", prio_queue);
+		rtw_dbg(rtwdev, RTW_DBG_UNEXP,
+			"timed out to flush queue %d\n", prio_queue);
 }
 
 static void rtw_mac_flush_prio_queues(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 9986a4cb37eb..7a093f3d5f74 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -729,7 +729,8 @@ static void __pci_flush_queue(struct rtw_dev *rtwdev, u8 pci_q, bool drop)
 	}
 
 	if (!drop)
-		rtw_warn(rtwdev, "timed out to flush pci tx ring[%d]\n", pci_q);
+		rtw_dbg(rtwdev, RTW_DBG_UNEXP,
+			"timed out to flush pci tx ring[%d]\n", pci_q);
 }
 
 static void __rtw_pci_flush_queues(struct rtw_dev *rtwdev, u32 pci_queues,
-- 
2.25.1


