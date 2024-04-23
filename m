Return-Path: <linux-wireless+bounces-6724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8F18AE751
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 15:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA39B26D27
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4885938;
	Tue, 23 Apr 2024 13:05:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D0134733
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877536; cv=none; b=gs40IGfX6stBlyPsdT1mUPnxl9bM23l8AMnkgegT3lxrXTyS+KDheCluCrbamleJyvIYP50H+Db3FVehbAP1Wwf1hVpNqB7F6YMvxtmw78rhFuV4yxM7JDYtJ/IgBi4OCdNpgEUorLycKJVe2kQERaEfzejRS/aeBRK4UC2oJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877536; c=relaxed/simple;
	bh=sMFzeZgynr7MZwfJHDP/GAVt7dikDEjHmnttQLpbnmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVOtQ5btZChx4WJWP/f0kdqiQxL1f1knc65hw9TIp8QgXFTCr9rikosnKBK1FJZfBvYtqHq6fqCrfqvUpir4uTVdk6YQicqNs1MGfaOknTAtrcLMUA30Rq1LyO4vD50doK21wCoLmlWEdE2lqiCJbNbRmm4yIevwVW1aV6lEt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43ND5S7S01251173, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43ND5S7S01251173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 21:05:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 21:05:29 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 21:05:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 1/8] wifi: rtw89: coex: Add Wi-Fi null data status version 7
Date: Tue, 23 Apr 2024 21:04:55 +0800
Message-ID: <20240423130502.32682-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423130502.32682-1-pkshih@realtek.com>
References: <20240423130502.32682-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

The mechanism will use Wi-Fi null packet to stop the packets from
access point to avoid the interference to Bluetooth when switch
to Bluetooth slot. The report can check whether the null packet is
working as expected or not.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 24 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 12 ++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 1649cb2e217f..e61af63090f7 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1379,6 +1379,9 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		} else if (ver->fcxnullsta == 2) {
 			pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo.v2;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo.v2);
+		} else if (ver->fcxnullsta == 7) {
+			pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo.v7;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo.v7);
 		} else {
 			goto err;
 		}
@@ -9186,6 +9189,27 @@ static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
 				   le32_to_cpu(ns->v1.max_t[i]) / 1000,
 				   le32_to_cpu(ns->v1.max_t[i]) % 1000);
 		}
+	} else if (ver->fcxnullsta == 7) {
+		for (i = 0; i < 2; i++) {
+			seq_printf(m, " %-15s : ", "[NULL-STA]");
+			seq_printf(m, "null-%d", i);
+			seq_printf(m, "[Tx:%d/",
+				   le32_to_cpu(ns->v7.result[i][4]));
+			seq_printf(m, "[ok:%d/",
+				   le32_to_cpu(ns->v7.result[i][1]));
+			seq_printf(m, "fail:%d/",
+				   le32_to_cpu(ns->v7.result[i][0]));
+			seq_printf(m, "on_time:%d/",
+				   le32_to_cpu(ns->v7.result[i][2]));
+			seq_printf(m, "retry:%d/",
+				   le32_to_cpu(ns->v7.result[i][3]));
+			seq_printf(m, "avg_t:%d.%03d/",
+				   le32_to_cpu(ns->v7.tavg[i]) / 1000,
+				   le32_to_cpu(ns->v7.tavg[i]) % 1000);
+			seq_printf(m, "max_t:%d.%03d]\n",
+				   le32_to_cpu(ns->v7.tmax[i]) / 1000,
+				   le32_to_cpu(ns->v7.tmax[i]) % 1000);
+		}
 	} else {
 		for (i = 0; i < 2; i++) {
 			seq_printf(m, " %-15s : ", "[NULL-STA]");
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 9da8be9927d3..d8f7eea7ae6e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2679,9 +2679,21 @@ struct rtw89_btc_fbtc_cynullsta_v2 { /* cycle null statistics */
 	__le32 result[2][5]; /* 0:fail, 1:ok, 2:on_time, 3:retry, 4:tx */
 } __packed;
 
+struct rtw89_btc_fbtc_cynullsta_v7 { /* cycle null statistics */
+	u8 fver;
+	u8 rsvd0;
+	u8 rsvd1;
+	u8 rsvd2;
+
+	__le32 tmax[2];
+	__le32 tavg[2];
+	__le32 result[2][5];
+} __packed;
+
 union rtw89_btc_fbtc_cynullsta_info {
 	struct rtw89_btc_fbtc_cynullsta_v1 v1; /* info from fw */
 	struct rtw89_btc_fbtc_cynullsta_v2 v2;
+	struct rtw89_btc_fbtc_cynullsta_v7 v7;
 };
 
 struct rtw89_btc_fbtc_btver {
-- 
2.25.1


