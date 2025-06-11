Return-Path: <linux-wireless+bounces-23949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18117AD47ED
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C087918969B7
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 01:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309F64437A;
	Wed, 11 Jun 2025 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="d3BuXNCS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257F81ACA
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605757; cv=none; b=WyCM7YTMq07Qpxl8ATCZ+MieuHRdG6S1/yXgmGsltSBWGMOpJibE4DEcxHnX5Pb1vD5WVuMh4mZ8LrYtODxEjjNRIlmUAzPwqRQLuvI2+jpTidu1fzF6E7P/cPAxV3cqjHn4oZ56mQh1tMYU+uVn+0HHBfLSALoJBFhNX/2P4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605757; c=relaxed/simple;
	bh=mau+wfU72CXpCf0ySwHSopvaOTu8DGijhcWEGXQBQrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZRFYbzA8WouC8Fj1qJP5BuYPAGYZsOPGCgVXOE1NxufZu5lq+DDOdK7P7+1mVTY89/bive+PO30lLdRdyQyvta8fWmVdTZpT1OvSu3Go2NmbMiwlgXn+jRsXZspPCLSC6JUrua0UerQWnvq5VjTRDyWJTjsnRIKGxkHjG4NgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=d3BuXNCS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B1ZrLxA3938102, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749605753; bh=Xj8rGcKsCbn4wOPseAKTLGB0FnUwRIuiEAidfO1Itus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=d3BuXNCSvq07Pjzz5YJk247rQIRGbwk8RGC90gpmJxkxb5mZOqeZa/ZEuDph7PPFz
	 MMgKcTSe/Ma91uThJgHJVpMyPj96HAkA2tLN4N4gQtzrGKr/qbPVSm7lC21Nx2e37w
	 8sZWwUAl3YB1km8NJ7J1uCn1dFtGR1HWFA6W9KXE5Ec30ZzbxcfjWqgL5Yw8g8PqU0
	 M978cDaoMlodCGRRp7BVmvY75yuz51KwtWwP5xbB7I4MvwIErE0jyfQZQ8JMjJVDcf
	 xsW+wdNgkkJKuyAAtzWfsPfy0JRVrSsPU8U0GVjcAfY2J6Etk1J/7SJSaYekySRdXa
	 35o+GrKd9phig==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B1ZrLxA3938102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:35:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 09:35:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 09:35:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/10] wifi: rtw89: coex: Update Wi-Fi status logic for WiFi 7
Date: Wed, 11 Jun 2025 09:35:04 +0800
Message-ID: <20250611013510.15519-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611013510.15519-1-pkshih@realtek.com>
References: <20250611013510.15519-1-pkshih@realtek.com>
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

Because WiFi 7 generation has dual MAC, logic need to assign & save
the information to correct index. Update the related logic.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 73801c84ec6f..34455badc650 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -8156,7 +8156,11 @@ void __rtw89_btc_ntfy_wl_sta_iter(struct rtw89_vif_link *rtwvif_link,
 	rssi = ewma_rssi_read(&rtwsta_link->avg_rssi) >> RSSI_FACTOR;
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], rssi=%d\n", rssi);
 
-	link_info = &wl->link_info[port];
+	if (btc->ver->fwlrole != 8)
+		link_info = &wl->link_info[port];
+	else
+		link_info = &wl->rlink_info[port][rtwvif_link->mac_idx];
+
 	link_info->stat.traffic = *stats;
 	link_info_t = &link_info->stat.traffic;
 
@@ -8237,13 +8241,12 @@ void __rtw89_btc_ntfy_wl_sta_iter(struct rtw89_vif_link *rtwvif_link,
 		r1->active_role_v1[port].rx_lvl = stats->rx_tfc_lv;
 		r1->active_role_v1[port].tx_rate = rtwsta_link->ra_report.hw_rate;
 		r1->active_role_v1[port].rx_rate = rtwsta_link->rx_hw_rate;
-	} else if (ver->fwlrole == 2) {
-		dm->trx_info.tx_lvl = stats->tx_tfc_lv;
-		dm->trx_info.rx_lvl = stats->rx_tfc_lv;
-		dm->trx_info.tx_rate = rtwsta_link->ra_report.hw_rate;
-		dm->trx_info.rx_rate = rtwsta_link->rx_hw_rate;
 	}
 
+	dm->trx_info.tx_lvl = stats->tx_tfc_lv;
+	dm->trx_info.rx_lvl = stats->rx_tfc_lv;
+	dm->trx_info.tx_rate = rtwsta_link->ra_report.hw_rate;
+	dm->trx_info.rx_rate = rtwsta_link->rx_hw_rate;
 	dm->trx_info.tx_tp = link_info_t->tx_throughput;
 	dm->trx_info.rx_tp = link_info_t->rx_throughput;
 
-- 
2.25.1


