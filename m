Return-Path: <linux-wireless+bounces-15600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA0F9D6210
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 17:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CA1160F08
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4740A1DF267;
	Fri, 22 Nov 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="reVFcEIS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA81DF250
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292388; cv=none; b=qTGB4TjheJMBDVcPnc0h6b3awJ+JdMKn/fk9vvZ5S/ZsQmtAuLDzDlDoDligCL8ZYc2fbjeSmRKfxDhKQ+GSGwiXH2JDFF0mOTNEgTOR6pgNzx57s3vnV3zgJ7E3A34D1dVfXojDOS4l69v3CRcV0fsFyLtUf+GsSey6vAMVoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292388; c=relaxed/simple;
	bh=ZUeda5+wsgCoyXO4oGpJVdYcRsuyvId6rlqRvmLwCc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G61zXUeW/Ju8he9woXyk5vIa2MIxtphdoN62KIRKwJGriHW4LjiW/7PzGyF/XXpc/RtJ8y3yUoeF5eF8c6ma/6JrHCpIWB2D5NOJD6QxPAhzDEPQZcVhmq55Voq8hebnBNbP7sHz3eDx7jTAbGpccjs3Qv4pGW7dxcsXapm0WZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=reVFcEIS; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A9073C00075;
	Fri, 22 Nov 2024 16:19:42 +0000 (UTC)
Received: from corvid-conspiracy.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id AF26F13C2B0;
	Fri, 22 Nov 2024 08:19:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AF26F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1732292380;
	bh=ZUeda5+wsgCoyXO4oGpJVdYcRsuyvId6rlqRvmLwCc8=;
	h=From:To:Cc:Subject:Date:From;
	b=reVFcEISHLHluSlsMOoSq+VueA67zoHNAV3ovfiTG4fdQlQNyhrsOinWCFi+QTHZP
	 h0f8WY1DPyArpiOoJvZOCXtOxU6xoZ053MVeX0kVdSJNweTZcaAYZmj/rLpvQG9ZS2
	 4vgViLNC8E/EXVG4fZ9CYLcreYqAr0IIYXM9kXn4=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH v2 2/3] iw: scan: replace passed ie buffer with ie context
Date: Fri, 22 Nov 2024 08:18:51 -0800
Message-ID: <20241122161851.647214-1-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1732292383-87nvSACQhpLA
X-MDID-O:
 us5;ut7;1732292383;87nvSACQhpLA;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

Since some ies require references to other ies, parse
the ie list once before to create a context and prevent
parsing more than the two times required.

Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
---
v2:
  - Replace in-place parsing with building a context in a first pass
---
 scan.c | 141 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 78 insertions(+), 63 deletions(-)

diff --git a/scan.c b/scan.c
index 3bc6fb4..de0dd38 100644
--- a/scan.c
+++ b/scan.c
@@ -554,13 +554,12 @@ static void tab_on_first(bool *first)
 		*first = false;
 }
 
-struct print_ies_data {
-	unsigned char *ie;
-	int ielen;
+struct ie_context {
+	bool is_vht_cap;
 };
 
 static void print_ssid(const uint8_t type, uint8_t len, const uint8_t *data,
-		       const struct print_ies_data *ie_buffer)
+		       const struct ie_context *ctx)
 {
 	printf(" ");
 	print_ssid_escaped(len, data);
@@ -572,7 +571,7 @@ static void print_ssid(const uint8_t type, uint8_t len, const uint8_t *data,
 
 static void print_supprates(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ie_context *ctx)
 {
 	int i;
 
@@ -595,7 +594,7 @@ static void print_supprates(const uint8_t type, uint8_t len,
 
 static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ie_context *ctx)
 {
 	__u64 capa = ((__u64) data[0]) |
 		     ((__u64) data[1]) << 8 |
@@ -649,7 +648,7 @@ static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
 }
 
 static void print_ds(const uint8_t type, uint8_t len, const uint8_t *data,
-		     const struct print_ies_data *ie_buffer)
+		     const struct ie_context *ctx)
 {
 	printf(" channel %d\n", data[0]);
 }
@@ -669,7 +668,7 @@ static const char *country_env_str(char environment)
 }
 
 static void print_country(const uint8_t type, uint8_t len, const uint8_t *data,
-			  const struct print_ies_data *ie_buffer)
+			  const struct ie_context *ctx)
 {
 	printf(" %.*s", 2, data);
 
@@ -716,21 +715,21 @@ static void print_country(const uint8_t type, uint8_t len, const uint8_t *data,
 
 static void print_powerconstraint(const uint8_t type, uint8_t len,
 				  const uint8_t *data,
-				  const struct print_ies_data *ie_buffer)
+				  const struct ie_context *ctx)
 {
 	printf(" %d dB\n", data[0]);
 }
 
 static void print_tpcreport(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ie_context *ctx)
 {
 	printf(" TX power: %d dBm\n", data[0]);
 	/* printf(" Link Margin (%d dB) is reserved in Beacons\n", data[1]); */
 }
 
 static void print_erp(const uint8_t type, uint8_t len, const uint8_t *data,
-		      const struct print_ies_data *ie_buffer)
+		      const struct ie_context *ctx)
 {
 	if (data[0] == 0x00)
 		printf(" <no flags>");
@@ -744,7 +743,7 @@ static void print_erp(const uint8_t type, uint8_t len, const uint8_t *data,
 }
 
 static void print_ap_channel_report(const uint8_t type, uint8_t len, const uint8_t *data,
-				    const struct print_ies_data *ie_buffer)
+				    const struct ie_context *ctx)
 {
 	uint8_t oper_class = data[0];
 	int i;
@@ -1084,13 +1083,13 @@ static void print_osen_ie(const char *defcipher, const char *defauth,
 }
 
 static void print_rsn(const uint8_t type, uint8_t len, const uint8_t *data,
-		      const struct print_ies_data *ie_buffer)
+		      const struct ie_context *ctx)
 {
 	print_rsn_ie("CCMP", "IEEE 802.1X", len, data);
 }
 
 static void print_ht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
-			  const struct print_ies_data *ie_buffer)
+			  const struct ie_context *ctx)
 {
 	printf("\n");
 	print_ht_capability(data[0] | (data[1] << 8));
@@ -1135,7 +1134,7 @@ static const char* vgroup_11u(uint8_t t)
 
 static void print_interworking(const uint8_t type, uint8_t len,
 			       const uint8_t *data,
-			       const struct print_ies_data *ie_buffer)
+			       const struct ie_context *ctx)
 {
 	/* See Section 7.3.2.92 in the 802.11u spec. */
 	printf("\n");
@@ -1168,7 +1167,7 @@ static void print_interworking(const uint8_t type, uint8_t len,
 
 static void print_11u_advert(const uint8_t type, uint8_t len,
 			     const uint8_t *data,
-			     const struct print_ies_data *ie_buffer)
+			     const struct ie_context *ctx)
 {
 	/* See Section 7.3.2.93 in the 802.11u spec. */
 	/* TODO: This code below does not decode private protocol IDs */
@@ -1201,7 +1200,7 @@ static void print_11u_advert(const uint8_t type, uint8_t len,
 }
 
 static void print_11u_rcon(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ie_context *ctx)
 {
 	/* See Section 7.3.2.96 in the 802.11u spec. */
 	int idx = 0;
@@ -1254,7 +1253,7 @@ static void print_11u_rcon(const uint8_t type, uint8_t len, const uint8_t *data,
 
 static void print_tx_power_envelope(const uint8_t type, uint8_t len,
 				    const uint8_t *data,
-				    const struct print_ies_data *ie_buffer)
+				    const struct ie_context *ctx)
 {
 	const uint8_t local_max_tx_power_count = data[0] & 7;
 	const uint8_t local_max_tx_power_unit_interp = (data[0] >> 3) & 7;
@@ -1290,7 +1289,7 @@ static const char *ht_secondary_offset[4] = {
 };
 
 static void print_ht_op(const uint8_t type, uint8_t len, const uint8_t *data,
-			const struct print_ies_data *ie_buffer)
+			const struct ie_context *ctx)
 {
 	static const char *protection[4] = {
 		"no",
@@ -1322,21 +1321,11 @@ static void print_ht_op(const uint8_t type, uint8_t len, const uint8_t *data,
 
 static void print_capabilities(const uint8_t type, uint8_t len,
 			       const uint8_t *data,
-			       const struct print_ies_data *ie_buffer)
+			       const struct ie_context *ctx)
 {
 	int i, base, bit, si_duration = 0, max_amsdu = 0;
-	bool s_psmp_support = false, is_vht_cap = false;
-	unsigned char *ie = ie_buffer->ie;
-	int ielen = ie_buffer->ielen;
+	bool s_psmp_support = false;
 
-	while (ielen >= 2 && ielen >= ie[1]) {
-		if (ie[0] == 191) {
-			is_vht_cap = true;
-			break;
-		}
-		ielen -= ie[1] + 2;
-		ie += ie[1] + 2;
-	}
 
 	for (i = 0; i < len; i++) {
 		base = i * 8;
@@ -1432,8 +1421,8 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 			CAPA(61, "TDLS Wider Bandwidth");
 			CAPA(62, "Operating Mode Notification");
 
-			ADD_BIT_VAL(63, is_vht_cap, max_amsdu, 1);
-			ADD_BIT_VAL(64, is_vht_cap, max_amsdu, 2);
+			ADD_BIT_VAL(63, ctx->is_vht_cap, max_amsdu, 1);
+			ADD_BIT_VAL(64, ctx->is_vht_cap, max_amsdu, 2);
 
 			CAPA(65, "Channel Schedule Management");
 			CAPA(66, "Geodatabase Inband Enabling Signal");
@@ -1462,7 +1451,7 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 		printf("\n\t\t * Service Interval Granularity is %d ms",
 		       (si_duration + 1) * 5);
 
-	if (is_vht_cap) {
+	if (ctx->is_vht_cap) {
 		printf("\n\t\t * Max Number Of MSDUs In A-MSDU is ");
 		switch (max_amsdu) {
 		case 0:
@@ -1486,7 +1475,7 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 }
 
 static void print_tim(const uint8_t type, uint8_t len, const uint8_t *data,
-		      const struct print_ies_data *ie_buffer)
+		      const struct ie_context *ctx)
 {
 	printf(" DTIM Count %u DTIM Period %u Bitmap Control 0x%x "
 	       "Bitmap[0] 0x%x",
@@ -1497,13 +1486,13 @@ static void print_tim(const uint8_t type, uint8_t len, const uint8_t *data,
 }
 
 static void print_ibssatim(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ie_context *ctx)
 {
 	printf(" %d TUs\n", (data[1] << 8) + data[0]);
 }
 
 static void print_vht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ie_context *ctx)
 {
 	printf("\n");
 	print_vht_info((__u32) data[0] | ((__u32)data[1] << 8) |
@@ -1512,7 +1501,7 @@ static void print_vht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 }
 
 static void print_vht_oper(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ie_context *ctx)
 {
 	const char *chandwidths[] = {
 		[0] = "20 or 40 MHz",
@@ -1531,7 +1520,7 @@ static void print_vht_oper(const uint8_t type, uint8_t len, const uint8_t *data,
 
 static void print_supp_op_classes(const uint8_t type, uint8_t len,
 				  const uint8_t *data,
-				  const struct print_ies_data *ie_buffer)
+				  const struct ie_context *ctx)
 {
 	uint8_t *p = (uint8_t*) data;
 	const uint8_t *next_data = p + len;
@@ -1565,7 +1554,7 @@ static void print_supp_op_classes(const uint8_t type, uint8_t len,
 
 static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 				       const uint8_t *data,
-				       const struct print_ies_data *ie_buffer)
+				       const struct ie_context *ctx)
 {
 	uint8_t *p, len_remaining;
 
@@ -1614,7 +1603,7 @@ static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 
 static void print_obss_scan_params(const uint8_t type, uint8_t len,
 				   const uint8_t *data,
-				   const struct print_ies_data *ie_buffer)
+				   const struct ie_context *ctx)
 {
 	printf("\n");
 	printf("\t\t * passive dwell: %d TUs\n", (data[1] << 8) | data[0]);
@@ -1629,7 +1618,7 @@ static void print_obss_scan_params(const uint8_t type, uint8_t len,
 
 static void print_secchan_offs(const uint8_t type, uint8_t len,
 			       const uint8_t *data,
-			       const struct print_ies_data *ie_buffer)
+			       const struct ie_context *ctx)
 {
 	if (data[0] < ARRAY_SIZE(ht_secondary_offset))
 		printf(" %s (%d)\n", ht_secondary_offset[data[0]], data[0]);
@@ -1638,7 +1627,7 @@ static void print_secchan_offs(const uint8_t type, uint8_t len,
 }
 
 static void print_bss_load(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ie_context *ctx)
 {
 	printf("\n");
 	printf("\t\t * station count: %d\n", (data[1] << 8) | data[0]);
@@ -1648,7 +1637,7 @@ static void print_bss_load(const uint8_t type, uint8_t len, const uint8_t *data,
 
 static void print_mesh_conf(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ie_context *ctx)
 {
 	printf("\n");
 	printf("\t\t * Active Path Selection Protocol ID: %d\n", data[0]);
@@ -1681,7 +1670,7 @@ static void print_mesh_conf(const uint8_t type, uint8_t len,
 
 static void print_s1g_capa(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ie_context *ctx)
 {
 	printf("\n");
 	print_s1g_capability(data);
@@ -1689,14 +1678,14 @@ static void print_s1g_capa(const uint8_t type, uint8_t len,
 
 static void print_short_beacon_int(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ie_context *ctx)
 {
 	printf(" %d\n", (data[1] << 8) | data[0]);
 }
 
 static void print_s1g_oper(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ie_context *ctx)
 {
 	int oper_ch_width, prim_ch_width;
 	int prim_ch_width_subfield = data[0] & 0x1;
@@ -1777,14 +1766,14 @@ static void print_s1g_oper(const uint8_t type, uint8_t len,
 struct ie_print {
 	const char *name;
 	void (*print)(const uint8_t type, uint8_t len, const uint8_t *data,
-		      const struct print_ies_data *ie_buffer);
+		      const struct ie_context *ctx);
 	uint8_t minlen, maxlen;
 	uint8_t flags;
 };
 
 static void print_ie(const struct ie_print *p, const uint8_t type, uint8_t len,
 		     const uint8_t *data,
-		     const struct print_ies_data *ie_buffer)
+		     const struct ie_context *ctx)
 {
 	int i;
 
@@ -1805,7 +1794,7 @@ static void print_ie(const struct ie_print *p, const uint8_t type, uint8_t len,
 		return;
 	}
 
-	p->print(type, len, data, ie_buffer);
+	p->print(type, len, data, ctx);
 }
 
 #define PRINT_IGN {		\
@@ -1867,14 +1856,14 @@ static const struct ie_print ieprinters[] = {
 };
 
 static void print_wifi_wpa(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ie_context *ctx)
 {
 	print_rsn_ie("TKIP", "IEEE 802.1X", len, data);
 }
 
 static void print_wifi_osen(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ie_context *ctx)
 {
 	print_osen_ie("OSEN", "OSEN", len, data);
 }
@@ -1922,7 +1911,7 @@ static bool print_wifi_wmm_param(const uint8_t *data, uint8_t len)
 }
 
 static void print_wifi_wmm(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ie_context *ctx)
 {
 	int i;
 
@@ -1965,7 +1954,7 @@ static const char * wifi_wps_dev_passwd_id(uint16_t id)
 }
 
 static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ie_context *ctx)
 {
 	bool first = true;
 	__u16 subtype, sublen;
@@ -2205,7 +2194,7 @@ static const struct ie_print wifiprinters[] = {
 
 static inline void print_p2p(const uint8_t type, uint8_t len,
 			     const uint8_t *data,
-			     const struct print_ies_data *ie_buffer)
+			     const struct ie_context *ctx)
 {
 	bool first = true;
 	__u8 subtype;
@@ -2287,7 +2276,7 @@ static inline void print_p2p(const uint8_t type, uint8_t len,
 
 static inline void print_hs20_ind(const uint8_t type, uint8_t len,
 				  const uint8_t *data,
-				  const struct print_ies_data *ie_buffer)
+				  const struct ie_context *ctx)
 {
 	/* I can't find the spec for this...just going off what wireshark uses. */
 	printf("\n");
@@ -2299,7 +2288,7 @@ static inline void print_hs20_ind(const uint8_t type, uint8_t len,
 
 static void print_wifi_owe_tarns(const uint8_t type, uint8_t len,
 				 const uint8_t *data,
-				 const struct print_ies_data *ie_buffer)
+				 const struct ie_context *ctx)
 {
 	char mac_addr[20];
 	int ssid_len;
@@ -2392,14 +2381,14 @@ static void print_vendor(unsigned char len, unsigned char *data,
 }
 
 static void print_he_capa(const uint8_t type, uint8_t len, const uint8_t *data,
-			  const struct print_ies_data *ie_buffer)
+			  const struct ie_context *ctx)
 {
 	printf("\n");
 	print_he_capability(data, len);
 }
 
 static void print_he_oper(const uint8_t type, uint8_t len, const uint8_t *data,
-			  const struct print_ies_data *ie_buffer)
+			  const struct ie_context *ctx)
 {
 	printf("\n");
 	print_he_operation(data, len);
@@ -2437,23 +2426,49 @@ static void print_extension(unsigned char len, unsigned char *ie,
 	}
 }
 
+static void set_context(unsigned char *ie, int ielen, struct ie_context *ctx)
+{
+	unsigned char *pos = ie;
+	int remaining = ielen;
+
+	if (ie == NULL || ielen == 0 || ctx == NULL)
+		return;
+
+	while (remaining >= 2 && remaining - 2 >= pos[1]) {
+		if (pos[0] == EID_EXTENSION) {
+			/*switch (pos[2]) {
+			 * for future use
+			}*/
+		} else {
+			switch (pos[0]) {
+			case EID_VHT_CAPABILITY:
+				ctx->is_vht_cap = true;
+				break;
+			}
+		}
+
+		remaining -= pos[1] + 2;
+		pos += pos[1] + 2;
+	}
+}
+
 void print_ies(unsigned char *ie, int ielen, bool unknown,
 	       enum print_ie_type ptype)
 {
-	struct print_ies_data ie_buffer = {
-		.ie = ie,
-		.ielen = ielen };
+	struct ie_context ctx = { 0 };
 
 	if (ie == NULL || ielen < 0)
 		return;
 
+	set_context(ie, ielen, &ctx);
+
 	while (ielen >= 2 && ielen - 2 >= ie[1]) {
 		if (ie[0] < ARRAY_SIZE(ieprinters) &&
 		    ieprinters[ie[0]].name &&
 		    ieprinters[ie[0]].flags & BIT(ptype) &&
 			    ie[1] > 0) {
 			print_ie(&ieprinters[ie[0]],
-				 ie[0], ie[1], ie + 2, &ie_buffer);
+				 ie[0], ie[1], ie + 2, &ctx);
 		} else if (ie[0] == 221 /* vendor */) {
 			print_vendor(ie[1], ie + 2, unknown, ptype);
 		} else if (ie[0] == 255 /* extension */) {
-- 
2.47.0


