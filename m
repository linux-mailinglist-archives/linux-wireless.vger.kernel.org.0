Return-Path: <linux-wireless+bounces-36449-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKe6J8Z6BmqFkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36449-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:45:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0457B548835
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B859530277C3
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362B6CA52;
	Fri, 15 May 2026 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mejwByLZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8582B1E9B3A
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809539; cv=none; b=U5ClMH3c+FHEwdjzNvm/LAQQvrC7YrK5WQHD9VnICOY/fgGRt+s+4wvCnLbPAFYVrbfYVy96E07D/7uQ8wB9whIGvFiNKaQPuhgm0RtbHhY6U1lgAuD67rM3E3gdXGoLzEIAZX7e5CRCUnCnC0noXGNG6hooGjiKUNd+qq9VlEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809539; c=relaxed/simple;
	bh=wVxUnkGdsLzuBnSxukyeqMTEBLzSO84+HKLxJ74/7n4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrw7Ww9MYolFmpG5hhlpH6LuZZ+QO3/pS8ttG9pE4BC8smt99aAM11CQIZuc7wIEdx1lm7olWaHcN1V7wG2CzdNrpoSI0YHd+1GRWtLmp1sTK8d02s/e+gYHDhglvbce9v9kTLnQDCP3liqR9XYcbhPOxBTLACcEFn4gfAdFRKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mejwByLZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64F1jZS212587301, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778809535; bh=ufGXJAzE1geBDjNIFUQRqpW7w1U+SRJvsqTcBXMv/qY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mejwByLZ98eDm2/R34VvNdN3Hi8/U3Ww/iRKWiUd0/NC5cIkfBKZebOwL0aoTdXWm
	 VSq4coqNwmJm7kkr2EzsatTuKgoKWfSAK12tY5gT10luV1jXtefDEip+c6n0ux7Y3n
	 msjftF6Y42pCRWfFvlp7NybvAF9IiQNxP92ptkt6hUzcSvEDx7FhsftMByLWttFMgD
	 TdTJtefd91sB770jXyN4Xvgra6s5hDqlBxSPrKm2rETarjJ0P6Gyp0spUg2oDCz9WZ
	 N1/11ldVN65vKRDBA4rCFCji67r6wmqHxMrY6xj4eO088w+brbiieDMmk2rviHLHpN
	 c9jel+c/vM2CQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64F1jZS212587301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 09:45:35 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:45:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:45:34 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 15 May 2026 09:45:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/13] wifi: rtw89: 8922d: change naming number and update values for WDE/PLE quota
Date: Fri, 15 May 2026 09:44:30 +0800
Message-ID: <20260515014433.16168-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515014433.16168-1-pkshih@realtek.com>
References: <20260515014433.16168-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 0457B548835
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36449-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:mid,realtek.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The WDE/PLE quota are to configure memory size for TX/RX. Some quota are
renamed, and some values are changed. Update them accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      |  7 ++++---
 drivers/net/wireless/realtek/rtw89/mac.h      |  7 ++++---
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 18 ++++++++----------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 6153162ad9b0..8df1b9af719d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1847,18 +1847,19 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt28 = {1040, 0, 32, 48, 43, 13, 208, 0, 62, 14, 24, 0,},
 	/* USB 52C USB3.0 */
 	.ple_qt42 = {1068, 0, 16, 48, 4, 13, 178, 0, 16, 1, 8, 16, 0,},
-	.ple_qt42_v2 = {91, 91, 32, 16, 19, 13, 91, 91, 44, 18, 1, 4, 0, 0,},
 	/* USB 52C USB3.0 */
 	.ple_qt43 = {3068, 0, 32, 48, 4, 13, 178, 0, 16, 1, 8, 16, 0,},
-	.ple_qt43_v2 = {645, 645, 32, 16, 2062, 2056, 2134, 2134, 2087, 2061, 1, 2047, 0, 0,},
 	/* DLFW 52C */
 	.ple_qt44 = {0, 0, 16, 256, 0, 0, 0, 0, 0, 0, 0, 0,},
+	.ple_qt44_v2 = {91, 91, 32, 16, 19, 13, 91, 91, 44, 18, 1, 4, 0, 0,},
 	/* DLFW 52C */
 	.ple_qt45 = {0, 0, 32, 256, 0, 0, 0, 0, 0, 0, 0, 0,},
+	.ple_qt45_v2 = {645, 645, 32, 2055, 2058, 2052, 2132, 2132, 2083, 2057, 1, 2043, 0, 0,},
 	/* 8852C PCIE SCC */
 	.ple_qt46 = {525, 0, 16, 20, 13, 13, 178, 0, 32, 62, 8, 16,},
 	/* 8852C PCIE SCC */
 	.ple_qt47 = {525, 0, 32, 20, 1034, 13, 1199, 0, 1053, 62, 160, 1037,},
+	.ple_qt47_v2 = {0, 0, 32, 2703, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,},
 	.ple_qt57 = {147, 0, 16, 20, 13, 13, 178, 0, 32, 14, 8, 0,},
 	/* PCIE 64 */
 	.ple_qt58 = {147, 0, 16, 20, 157, 13, 229, 0, 172, 14, 24, 0,},
@@ -1889,7 +1890,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.rsvd1_size0 = {587776, 2048,},
 	.rsvd1_size2 = {391168, 2048,},
 	.dle_input3 = {0, 0, 0, 16384, 0, 2048, 0, 0,},
-	.dle_input18 = {128, 128, 11454, 2048, 0, 2048, 24, 24,},
+	.dle_input20 = {128, 128, 11454, 2048, 0, 2048, 24, 24,},
 };
 EXPORT_SYMBOL(rtw89_mac_size);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 69f8d7d818a0..3d57f0acfba1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1007,13 +1007,14 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt27;
 	const struct rtw89_ple_quota ple_qt28;
 	const struct rtw89_ple_quota ple_qt42;
-	const struct rtw89_ple_quota ple_qt42_v2;
 	const struct rtw89_ple_quota ple_qt43;
-	const struct rtw89_ple_quota ple_qt43_v2;
 	const struct rtw89_ple_quota ple_qt44;
+	const struct rtw89_ple_quota ple_qt44_v2;
 	const struct rtw89_ple_quota ple_qt45;
+	const struct rtw89_ple_quota ple_qt45_v2;
 	const struct rtw89_ple_quota ple_qt46;
 	const struct rtw89_ple_quota ple_qt47;
+	const struct rtw89_ple_quota ple_qt47_v2;
 	const struct rtw89_ple_quota ple_qt57;
 	const struct rtw89_ple_quota ple_qt58;
 	const struct rtw89_ple_quota ple_qt59;
@@ -1037,7 +1038,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_rsvd_size rsvd1_size0;
 	const struct rtw89_dle_rsvd_size rsvd1_size2;
 	const struct rtw89_dle_input dle_input3;
-	const struct rtw89_dle_input dle_input18;
+	const struct rtw89_dle_input dle_input20;
 };
 
 extern const struct rtw89_mac_size_set rtw89_mac_size;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index b8b75fca0a1b..baa9ead64aa2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -37,9 +37,7 @@ static const struct rtw89_hfc_ch_cfg rtw8922d_hfc_chcfg_pcie[] = {
 	{0, 601, 0}, /* B0HIQ */
 	{2, 603, 0}, /* B1MGQ */
 	{0, 601, 0}, /* B1HIQ */
-	{0, 0, 0}, /* FWCMDQ */
-	{0, 0, 0}, /* BMC */
-	{0, 0, 0}, /* H2D */
+	{0, 0, 0}, /* GCQ */
 };
 
 static const struct rtw89_hfc_pub_cfg rtw8922d_hfc_pubcfg_pcie = {
@@ -62,20 +60,20 @@ static const struct rtw89_hfc_param_ini rtw8922d_hfc_param_ini_pcie[] = {
 static const struct rtw89_dle_mem rtw8922d_dle_mem_pcie[] = {
 	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size16_v1,
 			   &rtw89_mac_size.ple_size20_v1, &rtw89_mac_size.wde_qt19_v1,
-			   &rtw89_mac_size.wde_qt19_v1, &rtw89_mac_size.ple_qt42_v2,
-			   &rtw89_mac_size.ple_qt43_v2, &rtw89_mac_size.ple_rsvd_qt9,
+			   &rtw89_mac_size.wde_qt19_v1, &rtw89_mac_size.ple_qt44_v2,
+			   &rtw89_mac_size.ple_qt45_v2, &rtw89_mac_size.ple_rsvd_qt9,
 			   &rtw89_mac_size.rsvd0_size6, &rtw89_mac_size.rsvd1_size2,
-			   &rtw89_mac_size.dle_input18},
+			   &rtw89_mac_size.dle_input20},
 	[RTW89_QTA_DBCC] = {RTW89_QTA_DBCC, &rtw89_mac_size.wde_size16_v1,
 			   &rtw89_mac_size.ple_size20_v1, &rtw89_mac_size.wde_qt19_v1,
-			   &rtw89_mac_size.wde_qt19_v1, &rtw89_mac_size.ple_qt42_v2,
-			   &rtw89_mac_size.ple_qt43_v2, &rtw89_mac_size.ple_rsvd_qt9,
+			   &rtw89_mac_size.wde_qt19_v1, &rtw89_mac_size.ple_qt44_v2,
+			   &rtw89_mac_size.ple_qt45_v2, &rtw89_mac_size.ple_rsvd_qt9,
 			   &rtw89_mac_size.rsvd0_size6, &rtw89_mac_size.rsvd1_size2,
-			   &rtw89_mac_size.dle_input18},
+			   &rtw89_mac_size.dle_input20},
 	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size18_v1,
 			    &rtw89_mac_size.ple_size22_v1, &rtw89_mac_size.wde_qt3,
 			    &rtw89_mac_size.wde_qt3, &rtw89_mac_size.ple_qt5_v2,
-			    &rtw89_mac_size.ple_qt5_v2, &rtw89_mac_size.ple_rsvd_qt1,
+			    &rtw89_mac_size.ple_qt47_v2, &rtw89_mac_size.ple_rsvd_qt1,
 			    &rtw89_mac_size.rsvd0_size6, &rtw89_mac_size.rsvd1_size2,
 			    &rtw89_mac_size.dle_input3},
 	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
-- 
2.25.1


