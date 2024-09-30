Return-Path: <linux-wireless+bounces-13335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E6398ABB3
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 20:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053C21C21442
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 18:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F541991B2;
	Mon, 30 Sep 2024 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="FuT/XNiV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF4A1990BB
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719921; cv=none; b=kUicMcX7eJx/3U+nRLKrHdKZWyAVNa/vN0HpL+6woDibHM034cBCfD6Qb8v3tKQDcEdcvm0SrVA4XHLst+BrnKKxG7aDUWKXsM9eH2u73FbbCoKgAGN2Ao3Oq/R4nffrx/zyRz2J9m0gbW4R8gO5bhtU+2y5ZO7CiZRRxDeuzv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719921; c=relaxed/simple;
	bh=Aj3/rplR8YG2RaFIf0qFHTLc3UKoWfvWXmznhhalgV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vf2wB5fTUnS/ZEEumpxGQc4I/aSMAJkwJP+uUPPLw3BOHJ1/pVdQazjYLXlc+/fxZWY3F1dpGYTHhE26+t9Yk4BrKIag9LodUy6aTZUXuXeIXIG1iH4+oljwohPdYuMLGoYX/62zyN+0LVUaoy+1oo2oFIzKvKrNK2jpa9Ru+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=FuT/XNiV; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B2241C0069;
	Mon, 30 Sep 2024 18:11:51 +0000 (UTC)
Received: from corvid-conspiracy.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 3325D13C2B1;
	Mon, 30 Sep 2024 11:11:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3325D13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1727719911;
	bh=Aj3/rplR8YG2RaFIf0qFHTLc3UKoWfvWXmznhhalgV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FuT/XNiV3wpqNltpQXF583CjG7F1SfcsX4m/g9teDbCpjpxOUbcT5juQ1PDezTGtM
	 VELjGXl/XtZk3e20v65zB57XtWrjbMoo6DlirphbPBF+Bb4737Y2fKDAr5mOSOTmJB
	 huhqoqDq4E4NnmeEYe4S2bInI0WdzfYHs9s6TYIw=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH 1/3] iw: scan: add enum for ie ids
Date: Mon, 30 Sep 2024 11:11:43 -0700
Message-ID: <20240930181145.1043048-2-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240930181145.1043048-1-dylan.eskew@candelatech.com>
References: <20240930181145.1043048-1-dylan.eskew@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1727719912-dq0VvaAhFcae
X-MDID-O:
 us5;ut7;1727719912;dq0VvaAhFcae;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

Formerly, ie ids were hardcoded. This change will improve
readability of logic which may explicitly reference an ie id.

Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
---
 ieee80211.h | 43 +++++++++++++++++++++++++++
 scan.c      | 84 +++++++++++++++++++++++++++++++----------------------
 2 files changed, 92 insertions(+), 35 deletions(-)

diff --git a/ieee80211.h b/ieee80211.h
index 3713a4d..96d5c52 100644
--- a/ieee80211.h
+++ b/ieee80211.h
@@ -58,6 +58,49 @@ struct ieee80211_vht_cap {
 	struct ieee80211_vht_mcs_info mcs;
 } __attribute__ ((packed));
 
+#define NUM_IES 256
+enum elem_id {
+	EID_SSID			= 0,
+	EID_SUPP_RATES			= 1,
+	EID_DS_PARAMS			= 3,
+	EID_TIM				= 5,
+	EID_IBSS_TIM_PARAMS		= 6,
+	EID_COUNTRY			= 7,
+	EID_BSS_LOAD			= 11,
+	EID_POWER_CONSTRAINT		= 32,
+	EID_TPC_REPORT			= 35,
+	EID_ERP_INFO			= 42,
+	EID_HT_CAPABILITY		= 45,
+	EID_ERP_D4_0			= 47,
+	EID_RSN				= 48,
+	EID_EXT_SUPP_RATES		= 50,
+	EID_AP_CHAN_REPORT		= 51,
+	EID_SUPP_OP_CLASSES		= 59,
+	EID_HT_OPERATION		= 61,
+	EID_SECONDARY_CH_OFFSET		= 62,
+	EID_MEASUREMENT_PILOT_TX	= 66,
+	EID_RM_ENABLED_CAPABILITIES	= 70,
+	EID_OVERLAP_BSS_SCAN_PARAM	= 74,
+	EID_INTERWORKING		= 107,
+	EID_ADVERTISEMENT		= 108,
+	EID_ROAMING_CONSORTIUM		= 111,
+	EID_MESH_CONFIG			= 113,
+	EID_MESH_ID			= 114,
+	EID_EXT_CAPABILITY		= 127,
+	EID_VHT_CAPABILITY		= 191,
+	EID_VHT_OPERATION		= 192,
+	EID_TRANSMIT_POWER_ENVELOPE	= 195,
+	EID_SHORT_BEACON_INTERVAL	= 214,
+	EID_S1G_CAPABILITY		= 217,
+	EID_VENDOR			= 221,
+	EID_S1G_OPERATION		= 232,
+	EID_EXTENSION			= 255,
+};
+
+enum elem_id_ext {
+	EID_EXT_HE_CAPABILITY = 35,
+};
+
 #define SUITE(oui, id)  (((oui) << 8) | (id))
 
 /* cipher suite selectors */
diff --git a/scan.c b/scan.c
index faf406d..83b7f58 100644
--- a/scan.c
+++ b/scan.c
@@ -1816,40 +1816,54 @@ static void print_ie(const struct ie_print *p, const uint8_t type, uint8_t len,
 }
 
 static const struct ie_print ieprinters[] = {
-	[0] = { "SSID", print_ssid, 0, 32,
-		 BIT(PRINT_SCAN) | BIT(PRINT_LINK) | BIT(PRINT_LINK_MLO_MLD), },
-	[1] = { "Supported rates", print_supprates, 0, 255, BIT(PRINT_SCAN), },
-	[3] = { "DS Parameter set", print_ds, 1, 1, BIT(PRINT_SCAN), },
-	[5] = { "TIM", print_tim, 4, 255, BIT(PRINT_SCAN), },
-	[6] = { "IBSS ATIM window", print_ibssatim, 2, 2, BIT(PRINT_SCAN), },
-	[7] = { "Country", print_country, 3, 255, BIT(PRINT_SCAN), },
-	[11] = { "BSS Load", print_bss_load, 5, 5, BIT(PRINT_SCAN), },
-	[32] = { "Power constraint", print_powerconstraint, 1, 1, BIT(PRINT_SCAN), },
-	[35] = { "TPC report", print_tpcreport, 2, 2, BIT(PRINT_SCAN), },
-	[42] = { "ERP", print_erp, 1, 255, BIT(PRINT_SCAN), },
-	[45] = { "HT capabilities", print_ht_capa, 26, 26, BIT(PRINT_SCAN), },
-	[47] = { "ERP D4.0", print_erp, 1, 255, BIT(PRINT_SCAN), },
-	[51] = { "AP Channel Report", print_ap_channel_report, 1, 255, BIT(PRINT_SCAN), },
-	[59] = { "Supported operating classes", print_supp_op_classes, 1, 255, BIT(PRINT_SCAN), },
-	[66] = { "Measurement Pilot Transmission", print_measurement_pilot_tx, 1, 255, BIT(PRINT_SCAN), },
-	[74] = { "Overlapping BSS scan params", print_obss_scan_params, 14, 255, BIT(PRINT_SCAN), },
-	[61] = { "HT operation", print_ht_op, 22, 22, BIT(PRINT_SCAN), },
-	[62] = { "Secondary Channel Offset", print_secchan_offs, 1, 1, BIT(PRINT_SCAN), },
-	[191] = { "VHT capabilities", print_vht_capa, 12, 255, BIT(PRINT_SCAN), },
-	[192] = { "VHT operation", print_vht_oper, 5, 255, BIT(PRINT_SCAN), },
-	[48] = { "RSN", print_rsn, 2, 255, BIT(PRINT_SCAN), },
-	[50] = { "Extended supported rates", print_supprates, 0, 255, BIT(PRINT_SCAN), },
-	[70] = { "RM enabled capabilities", print_rm_enabled_capabilities, 5, 5, BIT(PRINT_SCAN), },
-	[113] = { "MESH Configuration", print_mesh_conf, 7, 7, BIT(PRINT_SCAN), },
-	[114] = { "MESH ID", print_ssid, 0, 32, BIT(PRINT_SCAN) | BIT(PRINT_LINK), },
-	[127] = { "Extended capabilities", print_capabilities, 0, 255, BIT(PRINT_SCAN), },
-	[107] = { "802.11u Interworking", print_interworking, 0, 255, BIT(PRINT_SCAN), },
-	[108] = { "802.11u Advertisement", print_11u_advert, 0, 255, BIT(PRINT_SCAN), },
-	[111] = { "802.11u Roaming Consortium", print_11u_rcon, 2, 255, BIT(PRINT_SCAN), },
-	[195] = { "Transmit Power Envelope", print_tx_power_envelope, 2, 5, BIT(PRINT_SCAN), },
-	[214] = { "Short beacon interval", print_short_beacon_int, 2, 2, BIT(PRINT_SCAN), },
-	[217] = { "S1G capabilities", print_s1g_capa, 15, 15, BIT(PRINT_SCAN), },
-	[232] = { "S1G operation", print_s1g_oper, 6, 6, BIT(PRINT_SCAN), },
+	[EID_SSID] = { "SSID", print_ssid, 0, 32,
+		       BIT(PRINT_SCAN) | BIT(PRINT_LINK) | BIT(PRINT_LINK_MLO_MLD), },
+	[EID_SUPP_RATES] = { "Supported rates", print_supprates, 0, 255, BIT(PRINT_SCAN), },
+	[EID_DS_PARAMS] = { "DS Parameter set", print_ds, 1, 1, BIT(PRINT_SCAN), },
+	[EID_TIM] = { "TIM", print_tim, 4, 255, BIT(PRINT_SCAN), },
+	[EID_IBSS_TIM_PARAMS] = { "IBSS ATIM window", print_ibssatim, 2, 2, BIT(PRINT_SCAN), },
+	[EID_COUNTRY] = { "Country", print_country, 3, 255, BIT(PRINT_SCAN), },
+	[EID_BSS_LOAD] = { "BSS Load", print_bss_load, 5, 5, BIT(PRINT_SCAN), },
+	[EID_POWER_CONSTRAINT] = { "Power constraint", print_powerconstraint,
+				   1, 1, BIT(PRINT_SCAN), },
+	[EID_TPC_REPORT] = { "TPC report", print_tpcreport, 2, 2, BIT(PRINT_SCAN), },
+	[EID_ERP_INFO] = { "ERP", print_erp, 1, 255, BIT(PRINT_SCAN), },
+	[EID_HT_CAPABILITY] = { "HT capabilities", print_ht_capa, 26, 26, BIT(PRINT_SCAN), },
+	[EID_ERP_D4_0] = { "ERP D4.0", print_erp, 1, 255, BIT(PRINT_SCAN), },
+	[EID_AP_CHAN_REPORT] = { "AP Channel Report", print_ap_channel_report,
+				 1, 255, BIT(PRINT_SCAN), },
+	[EID_SUPP_OP_CLASSES] = { "Supported operating classes",
+				  print_supp_op_classes, 1, 255, BIT(PRINT_SCAN), },
+	[EID_MEASUREMENT_PILOT_TX] = { "Measurement Pilot Transmission",
+				       print_measurement_pilot_tx, 1, 255, BIT(PRINT_SCAN), },
+	[EID_OVERLAP_BSS_SCAN_PARAM] = { "Overlapping BSS scan params",
+					 print_obss_scan_params, 14, 255, BIT(PRINT_SCAN), },
+	[EID_HT_OPERATION] = { "HT operation", print_ht_op, 22, 22, BIT(PRINT_SCAN), },
+	[EID_SECONDARY_CH_OFFSET] = { "Secondary Channel Offset",
+				      print_secchan_offs, 1, 1, BIT(PRINT_SCAN), },
+	[EID_VHT_CAPABILITY] = { "VHT capabilities", print_vht_capa, 12, 255, BIT(PRINT_SCAN), },
+	[EID_VHT_OPERATION] = { "VHT operation", print_vht_oper, 5, 255, BIT(PRINT_SCAN), },
+	[EID_RSN] = { "RSN", print_rsn, 2, 255, BIT(PRINT_SCAN), },
+	[EID_EXT_SUPP_RATES] = { "Extended supported rates", print_supprates,
+				 0, 255, BIT(PRINT_SCAN), },
+	[EID_RM_ENABLED_CAPABILITIES] = { "RM enabled capabilities",
+					  print_rm_enabled_capabilities, 5, 5, BIT(PRINT_SCAN), },
+	[EID_MESH_CONFIG] = { "MESH Configuration", print_mesh_conf, 7, 7, BIT(PRINT_SCAN), },
+	[EID_MESH_ID] = { "MESH ID", print_ssid, 0, 32, BIT(PRINT_SCAN) | BIT(PRINT_LINK), },
+	[EID_EXT_CAPABILITY] = { "Extended capabilities", print_capabilities,
+				 0, 255, BIT(PRINT_SCAN), },
+	[EID_INTERWORKING] = { "802.11u Interworking", print_interworking,
+			       0, 255, BIT(PRINT_SCAN), },
+	[EID_ADVERTISEMENT] = { "802.11u Advertisement", print_11u_advert,
+				0, 255, BIT(PRINT_SCAN), },
+	[EID_ROAMING_CONSORTIUM] = { "802.11u Roaming Consortium",
+				     print_11u_rcon, 2, 255, BIT(PRINT_SCAN), },
+	[EID_TRANSMIT_POWER_ENVELOPE] = { "Transmit Power Envelope",
+					  print_tx_power_envelope, 2, 5, BIT(PRINT_SCAN), },
+	[EID_SHORT_BEACON_INTERVAL] = { "Short beacon interval",
+					print_short_beacon_int, 2, 2, BIT(PRINT_SCAN), },
+	[EID_S1G_CAPABILITY] = { "S1G capabilities", print_s1g_capa, 15, 15, BIT(PRINT_SCAN), },
+	[EID_S1G_OPERATION] = { "S1G operation", print_s1g_oper, 6, 6, BIT(PRINT_SCAN), },
 };
 
 static void print_wifi_wpa(const uint8_t type, uint8_t len, const uint8_t *data,
@@ -2385,7 +2399,7 @@ static void print_he_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 }
 
 static const struct ie_print ext_printers[] = {
-	[35] = { "HE capabilities", print_he_capa, 21, 54, BIT(PRINT_SCAN), },
+	[EID_EXT_HE_CAPABILITY] = { "HE capabilities", print_he_capa, 21, 54, BIT(PRINT_SCAN), },
 };
 
 static void print_extension(unsigned char len, unsigned char *ie,
-- 
2.46.0


