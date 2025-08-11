Return-Path: <linux-wireless+bounces-26256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E8BB208F7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDDD7AAA7D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8802D8398;
	Mon, 11 Aug 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="C6NKkrkl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C602D8396
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915936; cv=none; b=tMmAur31YvXiK2cmSNE3/TOEQk1I/C7cqGmMOFNILPb+WyvcrS2FrfBphOFgkREBzla+7Uit3hjX1uiVuPTTtJvDMxOHXYp1wP260+Wo1GyPx0mctZyahpT3Ko78t/Z6c61P6ro+0Rx+UqVh3zTbjRvivhXf30aX8rVV/MVIzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915936; c=relaxed/simple;
	bh=CVpvjF26rDVPpcvqJYakbqNo2VXBPcuZ2tvXN9Ntf+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxVn+Cs9Jr2d2j6QI0arUDiTcQmxzgvy128DAR+OQDEnhiQ+pOtsthTMeLh6p/IrQq7CJi0A6/QIhTSJCc9jS+fMr5s4XP6IDGUhzZ/JA6RKKHZHiQFqZzgxrbS9zr2uUiqrzbAMvZBKtSKgdjxFprZOQ+/0oEUCJNych72DL6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=C6NKkrkl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57BCcogfF073205, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754915930; bh=zJNhMQo+UsSoS4Ez4VkuKZrbjm2tL99PT++17V3wrI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=C6NKkrklHMjn/u+cFtFwrEdMcC45QeT7mbsCtgjPvzwufaMowYAKm4GwrYZXeX6gP
	 gjJgMcMxo3Q24jP8weA5Z0+raV7GsaIEh9T0jPZNCVmtVLdwQAzTV93R48MKFAWpG1
	 L+Q4SjcETP2CmoIgGZP47m7G63opiLETOxzGfrLKCF3DGvDOQGlc9LTqmxowVwab96
	 LPjkGUiBuPjoRWu+N2GGc9/AdPJorfSleYDvv8YcGS9KjGtxQ4cHeSrk3mTverJqsF
	 X0IXSy5qDWbgWv9UEMU3HFw56BmuRPksPNYHa3EOTtKfLqQZx3jm+ZkIEtf9y3nTYs
	 Cm2HeysnW2QTQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57BCcogfF073205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 20:38:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 20:38:50 +0800
Received: from [127.0.1.1] (10.22.225.179) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 Aug
 2025 20:38:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 3/8] wifi: rtw89: wow: remove notify during WoWLAN net-detect
Date: Mon, 11 Aug 2025 20:37:39 +0800
Message-ID: <20250811123744.15361-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811123744.15361-1-pkshih@realtek.com>
References: <20250811123744.15361-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Kuan-Chung Chen <damon.chen@realtek.com>

In WoWLAN net-detect mode, the firmware periodically performs scans
and sends scan reports via C2H, which driver does not need. These
unnecessary C2H events cause firmware watchdog timeout, leading
to unexpected wakeups and SER 0x2599 on 8922AE.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index cc1956245f9b..398d8ab98f63 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7213,7 +7213,6 @@ static void rtw89_pno_scan_add_chan_ax(struct rtw89_dev *rtwdev,
 	struct rtw89_pktofld_info *info;
 	u8 probe_count = 0;
 
-	ch_info->notify_action = RTW89_SCANOFLD_DEBUG_MASK;
 	ch_info->dfs_ch = chan_type == RTW89_CHAN_DFS;
 	ch_info->bw = RTW89_SCAN_WIDTH;
 	ch_info->tx_pkt = true;
@@ -7354,7 +7353,6 @@ static void rtw89_pno_scan_add_chan_be(struct rtw89_dev *rtwdev, int chan_type,
 	struct rtw89_pktofld_info *info;
 	u8 probe_count = 0, i;
 
-	ch_info->notify_action = RTW89_SCANOFLD_DEBUG_MASK;
 	ch_info->dfs_ch = chan_type == RTW89_CHAN_DFS;
 	ch_info->bw = RTW89_SCAN_WIDTH;
 	ch_info->tx_null = false;
-- 
2.25.1


