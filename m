Return-Path: <linux-wireless+bounces-36452-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KafKtZ6BmqFkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36452-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:45:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF7454884C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A82D3009CF3
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB79A2472A2;
	Fri, 15 May 2026 01:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jXxY23gK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2531A680E
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809554; cv=none; b=Qugv5c0HyO3hPVVUS6eJtwDetiyR/nWHxgiajXYN28F82Iutow+95tL3KMbdbco60+RgiFMY4WUtcvVmGXomyaPQKajrbYG83h03jMgeH5DmvsFzr1QVSqfE307a4aSDzB8sY5SWmD8+iW++EBqvVfGbKikVOX6UehlrDDlIUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809554; c=relaxed/simple;
	bh=t9yYdx49Zfd7sqnze/IDB6y0CJ/OOCmFy5rHhEhKxwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAvAvoRjVcDiFVMmGQ7uoGE+k2n672PuaC2Eem3sXtOWw/quUuxdn/9A9dhRBvPnsexAZb19Ic9671AUTrozmN7hjQ6bLQr0aypllXZT3E3z7cXXIrpaI+ApptFuqSsr92e0LXSN/foLkm1Dw5ZrPwf6zCogfKvZ0bHH0AH01HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jXxY23gK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64F1jowbF2587357, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778809550; bh=pEQ2BRLdEPCmdlG6ywoc06oXzeF5bNYtNkOwCRa2jHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jXxY23gKSuVi0GOnSCa60O5QdISAWfQQjZzRj7ZBdzEqXFxWzs3Mc7D27/0hMLE0C
	 MKdQo0kKi+yjCaRzIUlxIvBgKi2uu6VgwWLKJ6Nqg2CZl6nI5UStQCWXVWpaAPcuNH
	 bws2bAw5Oh9vDpZXxiB8+BXcP6W140o4/WG79yh4b7QPSVWyv1mpyy5Fm9sKMM3nQr
	 5zucpfmVxWJ26JP0+OfxNqkt5lodWUsW9XaiuKSekBPrtFE2enAtCGEP9lX0GSnlee
	 6lBV991qWkAMgAj9CZrtZRfu5qr4wAYtsTg7shZzNLYAUVJBsIUvfc4CLLpGzJQP9k
	 lFSxVN8o6HU0Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64F1jowbF2587357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 09:45:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:45:50 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 15 May 2026 09:45:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 13/13] wifi: rtw89: 8922d: add quota for RTL8922DE variant
Date: Fri, 15 May 2026 09:44:33 +0800
Message-ID: <20260515014433.16168-14-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: 6EF7454884C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36452-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:mid,realtek.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The existing quota set is for RTL8922DE-VS, so rename the existing tables.
Add new quota set for RTL8922DE, containing more memory to yield better
performance, so rearrange quota accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      |  8 ++
 drivers/net/wireless/realtek/rtw89/mac.h      |  8 ++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 73 +++++++++++++++++--
 3 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index bd606d1da634..8c395517bd2f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1748,6 +1748,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size18_v1 = {RTW89_WDE_PG_64, 0, 640, 0,},
 	/* 8852C PCIE SCC */
 	.wde_size19 = {RTW89_WDE_PG_64, 3328, 0,},
+	.wde_size22_v1 = {RTW89_WDE_PG_128, 384, 0, 0,},
 	.wde_size23 = {RTW89_WDE_PG_64, 1022, 2,},
 	/* 8852B USB2.0/USB3.0 SCC turbo */
 	.wde_size30 = {RTW89_WDE_PG_64, 220, 36,},
@@ -1781,6 +1782,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_size22_v1 = {RTW89_PLE_PG_128, 2736, 0, 40960,},
 	/* 8851B USB2.0 SCC turbo */
 	.ple_size27 = {RTW89_PLE_PG_128, 1396, 12,},
+	.ple_size29_v1 = {RTW89_PLE_PG_128, 1895, 182, 49152,},
 	/* 8852B USB3.0 SCC turbo */
 	.ple_size31 = {RTW89_PLE_PG_128, 1392, 16,},
 	/* 8852C USB2.0 */
@@ -1811,6 +1813,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt18 = {3228, 60, 0, 40,},
 	.wde_qt19_v1 = {613, 6, 0, 20,},
 	.wde_qt23 = {958, 48, 0, 16,},
+	.wde_qt23_v1 = {371, 3, 0, 10,},
 	/* 8852B USB2.0/USB3.0 SCC turbo */
 	.wde_qt30 = {210, 2, 0, 8,},
 	/* 8852C USB2.0 */
@@ -1868,6 +1871,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* 8851B USB2.0 SCC turbo */
 	.ple_qt61 = {858, 0, 16, 48, 4, 13, 370, 0, 32, 14, 8, 0, 0,},
 	.ple_qt62 = {858, 0, 32, 48, 37, 13, 403, 0, 65, 14, 24, 0, 0,},
+	.ple_qt64_v2 = {91, 91, 32, 16, 19, 13, 93, 93, 44, 34, 1, 4, 0, 0,},
+	.ple_qt65_v2 = {645, 645, 32, 1380, 1383, 1377, 1457, 1457, 1408, 1398, 1, 1368,},
 	/* USB2.0 52C */
 	.ple_qt78 = {1560, 0, 16, 48, 13, 13, 390, 0, 32, 38, 8, 16, 0,},
 	/* USB2.0 52C */
@@ -1888,10 +1893,13 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.rsvd0_size3 = {57344, 0,},
 	.rsvd0_size5 = {32768, 0,},
 	.rsvd0_size6 = {40960, 0,},
+	.rsvd0_size17 = {49152, 0,},
 	.rsvd1_size0 = {587776, 2048,},
 	.rsvd1_size2 = {391168, 2048,},
+	.rsvd1_size3 = {315008, 78208,},
 	.dle_input3 = {0, 0, 0, 16384, 0, 2048, 0, 0, 0,},
 	.dle_input20 = {128, 128, 11454, 2048, 0, 2048, 1024, 24, 24,},
+	.dle_input28 = {128, 128, 11454, 2048, 0, 2048, 2048, 24, 24,},
 };
 EXPORT_SYMBOL(rtw89_mac_size);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 3d57f0acfba1..539061fc15e8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -946,6 +946,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size18;
 	const struct rtw89_dle_size wde_size18_v1;
 	const struct rtw89_dle_size wde_size19;
+	const struct rtw89_dle_size wde_size22_v1;
 	const struct rtw89_dle_size wde_size23;
 	const struct rtw89_dle_size wde_size30;
 	const struct rtw89_dle_size wde_size31;
@@ -966,6 +967,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size ple_size20_v1;
 	const struct rtw89_dle_size ple_size22_v1;
 	const struct rtw89_dle_size ple_size27;
+	const struct rtw89_dle_size ple_size29_v1;
 	const struct rtw89_dle_size ple_size31;
 	const struct rtw89_dle_size ple_size34;
 	const struct rtw89_wde_quota wde_qt0;
@@ -984,6 +986,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_wde_quota wde_qt18;
 	const struct rtw89_wde_quota wde_qt19_v1;
 	const struct rtw89_wde_quota wde_qt23;
+	const struct rtw89_wde_quota wde_qt23_v1;
 	const struct rtw89_wde_quota wde_qt30;
 	const struct rtw89_wde_quota wde_qt31;
 	const struct rtw89_ple_quota ple_qt0;
@@ -1020,6 +1023,8 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt59;
 	const struct rtw89_ple_quota ple_qt61;
 	const struct rtw89_ple_quota ple_qt62;
+	const struct rtw89_ple_quota ple_qt64_v2;
+	const struct rtw89_ple_quota ple_qt65_v2;
 	const struct rtw89_ple_quota ple_qt78;
 	const struct rtw89_ple_quota ple_qt79;
 	const struct rtw89_ple_quota ple_qt_52a_wow;
@@ -1035,10 +1040,13 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_rsvd_size rsvd0_size3;
 	const struct rtw89_dle_rsvd_size rsvd0_size5;
 	const struct rtw89_dle_rsvd_size rsvd0_size6;
+	const struct rtw89_dle_rsvd_size rsvd0_size17;
 	const struct rtw89_dle_rsvd_size rsvd1_size0;
 	const struct rtw89_dle_rsvd_size rsvd1_size2;
+	const struct rtw89_dle_rsvd_size rsvd1_size3;
 	const struct rtw89_dle_input dle_input3;
 	const struct rtw89_dle_input dle_input20;
+	const struct rtw89_dle_input dle_input28;
 };
 
 extern const struct rtw89_mac_size_set rtw89_mac_size;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 2f0c3a5d937c..a453b220d7ae 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -25,6 +25,62 @@
 	RTW89_GEN_MODULE_FWNAME(RTW8922DS_FW_BASENAME, RTW8922DS_FW_FORMAT_MAX)
 
 static const struct rtw89_hfc_ch_cfg rtw8922d_hfc_chcfg_pcie[] = {
+	{2, 732, 0}, /* ACH 0 */
+	{0, 730, 0}, /* ACH 1 */
+	{2, 732, 0}, /* ACH 2 */
+	{0, 730, 0}, /* ACH 3 */
+	{2, 732, 0}, /* ACH 4 */
+	{0, 730, 0}, /* ACH 5 */
+	{2, 732, 0}, /* ACH 6 */
+	{0, 730, 0}, /* ACH 7 */
+	{2, 732, 0}, /* B0MGQ */
+	{0, 730, 0}, /* B0HIQ */
+	{2, 732, 0}, /* B1MGQ */
+	{0, 730, 0}, /* B1HIQ */
+	{0, 0, 0}, /* GCQ */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8922d_hfc_pubcfg_pcie = {
+	742, /* Group 0 */
+	0, /* Group 1 */
+	742, /* Public Max */
+	0, /* WP threshold */
+};
+
+static const struct rtw89_hfc_param_ini rtw8922d_hfc_param_ini_pcie[] = {
+	[RTW89_QTA_SCC] = {rtw8922d_hfc_chcfg_pcie, &rtw8922d_hfc_pubcfg_pcie,
+			   &rtw89_mac_size.hfc_prec_cfg_c0, RTW89_HCIFC_POH},
+	[RTW89_QTA_DBCC] = {rtw8922d_hfc_chcfg_pcie, &rtw8922d_hfc_pubcfg_pcie,
+			    &rtw89_mac_size.hfc_prec_cfg_c0, RTW89_HCIFC_POH},
+	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_mac_size.hfc_prec_cfg_c2,
+			    RTW89_HCIFC_POH},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
+static const struct rtw89_dle_mem rtw8922d_dle_mem_pcie[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size22_v1,
+			   &rtw89_mac_size.ple_size29_v1, &rtw89_mac_size.wde_qt23_v1,
+			   &rtw89_mac_size.wde_qt23_v1, &rtw89_mac_size.ple_qt64_v2,
+			   &rtw89_mac_size.ple_qt65_v2, &rtw89_mac_size.ple_rsvd_qt9,
+			   &rtw89_mac_size.rsvd0_size17, &rtw89_mac_size.rsvd1_size3,
+			   &rtw89_mac_size.dle_input28},
+	[RTW89_QTA_DBCC] = {RTW89_QTA_DBCC, &rtw89_mac_size.wde_size22_v1,
+			    &rtw89_mac_size.ple_size29_v1, &rtw89_mac_size.wde_qt23_v1,
+			    &rtw89_mac_size.wde_qt23_v1, &rtw89_mac_size.ple_qt64_v2,
+			    &rtw89_mac_size.ple_qt65_v2, &rtw89_mac_size.ple_rsvd_qt9,
+			    &rtw89_mac_size.rsvd0_size17, &rtw89_mac_size.rsvd1_size3,
+			    &rtw89_mac_size.dle_input28},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size18_v1,
+			    &rtw89_mac_size.ple_size22_v1, &rtw89_mac_size.wde_qt3,
+			    &rtw89_mac_size.wde_qt3, &rtw89_mac_size.ple_qt5_v2,
+			    &rtw89_mac_size.ple_qt47_v2, &rtw89_mac_size.ple_rsvd_qt1,
+			    &rtw89_mac_size.rsvd0_size6, &rtw89_mac_size.rsvd1_size2,
+			    &rtw89_mac_size.dle_input3},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
+static const struct rtw89_hfc_ch_cfg rtw8922ds_hfc_chcfg_pcie[] = {
 	{2, 603, 0}, /* ACH 0 */
 	{0, 601, 0}, /* ACH 1 */
 	{2, 603, 0}, /* ACH 2 */
@@ -40,24 +96,24 @@ static const struct rtw89_hfc_ch_cfg rtw8922d_hfc_chcfg_pcie[] = {
 	{0, 0, 0}, /* GCQ */
 };
 
-static const struct rtw89_hfc_pub_cfg rtw8922d_hfc_pubcfg_pcie = {
+static const struct rtw89_hfc_pub_cfg rtw8922ds_hfc_pubcfg_pcie = {
 	613, /* Group 0 */
 	0, /* Group 1 */
 	613, /* Public Max */
 	0, /* WP threshold */
 };
 
-static const struct rtw89_hfc_param_ini rtw8922d_hfc_param_ini_pcie[] = {
-	[RTW89_QTA_SCC] = {rtw8922d_hfc_chcfg_pcie, &rtw8922d_hfc_pubcfg_pcie,
+static const struct rtw89_hfc_param_ini rtw8922ds_hfc_param_ini_pcie[] = {
+	[RTW89_QTA_SCC] = {rtw8922ds_hfc_chcfg_pcie, &rtw8922ds_hfc_pubcfg_pcie,
 			   &rtw89_mac_size.hfc_prec_cfg_c0, RTW89_HCIFC_POH},
-	[RTW89_QTA_DBCC] = {rtw8922d_hfc_chcfg_pcie, &rtw8922d_hfc_pubcfg_pcie,
+	[RTW89_QTA_DBCC] = {rtw8922ds_hfc_chcfg_pcie, &rtw8922ds_hfc_pubcfg_pcie,
 			   &rtw89_mac_size.hfc_prec_cfg_c0, RTW89_HCIFC_POH},
 	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_mac_size.hfc_prec_cfg_c2,
 			    RTW89_HCIFC_POH},
 	[RTW89_QTA_INVALID] = {NULL},
 };
 
-static const struct rtw89_dle_mem rtw8922d_dle_mem_pcie[] = {
+static const struct rtw89_dle_mem rtw8922ds_dle_mem_pcie[] = {
 	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size16_v1,
 			   &rtw89_mac_size.ple_size20_v1, &rtw89_mac_size.wde_qt19_v1,
 			   &rtw89_mac_size.wde_qt19_v1, &rtw89_mac_size.ple_qt44_v2,
@@ -3148,11 +3204,16 @@ static const struct rtw89_fw_def rtw8922de_vs_fw_def = {
 	.fw_b_aid		= RTL8922D_AID7060,
 };
 
+static const struct rtw89_qta_def rtw8922ds_qta_def = {
+	.hfc_param_ini		= {rtw8922ds_hfc_param_ini_pcie, NULL, NULL},
+	.dle_mem		= {rtw8922ds_dle_mem_pcie, NULL, NULL, NULL},
+};
+
 const struct rtw89_chip_variant rtw8922de_vs_variant = {
 	.no_mcs_12_13 = true,
 	.fw_min_ver_code = RTW89_FW_VER_CODE(0, 0, 0, 0),
 	.fw_def_override = &rtw8922de_vs_fw_def,
-	.qta_def_override = NULL,
+	.qta_def_override = &rtw8922ds_qta_def,
 };
 EXPORT_SYMBOL(rtw8922de_vs_variant);
 
-- 
2.25.1


