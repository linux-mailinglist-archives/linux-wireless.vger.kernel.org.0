Return-Path: <linux-wireless+bounces-13333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A6A98ABB1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 20:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B454281952
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 18:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474DB2B9A5;
	Mon, 30 Sep 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ZLfp+yNs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898321990BB
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719918; cv=none; b=H9ay2/MKiRc7oNR/+mYFk39+ljGNinzbqp3WmXykOe47yTS8PPpde6scZYtSyDhV1hO4gIaExOtUNj+K+0PFdsWI2yoEt5648NjRMkh2094f8V49iY5I98hW8ojxVUzpTODUUkcHoDWhq7Orv2GLgK32X98rkTt5UiMhF4hoadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719918; c=relaxed/simple;
	bh=ZTE8Id1JYuGYMpWje0yiqJi5JpmraZU/LWju1e31m+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNUhNxf++CWQjpcLep9H/ezaZTKrwDIi3nja5ejW6Mf0qPOanu5DPQ/cg7BVAQWESsx0wx17+jJYtaizOG3abwW96Wc7ErjTPDoKlksfYIHB8RxmouDDOVznXGw4LypfDKT7j291sQ/qBmsYf6dzIiM1fJygB3IEMyp/YXQtqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ZLfp+yNs; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A4B7CB0008A;
	Mon, 30 Sep 2024 18:11:53 +0000 (UTC)
Received: from corvid-conspiracy.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 4671913C2B0;
	Mon, 30 Sep 2024 11:11:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4671913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1727719913;
	bh=ZTE8Id1JYuGYMpWje0yiqJi5JpmraZU/LWju1e31m+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLfp+yNsxATGS6uDYkGrZ6DdzppPkUtmCrmQaB5C0GXoj3thcxfOXiuf+5AF/QYR4
	 falIy7PudgeGp+ayGpfL+vyqz27OomwDYHqIOfG8cJ6BU4LddL2g0wbbH1ZSPFBebd
	 1REcAx1NUDottDIZf9SEB9pF3IyBEIEITZ0cpJNU=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH 3/3] iw: scan: replace passed ie buffer with alias struct
Date: Mon, 30 Sep 2024 11:11:45 -0700
Message-ID: <20240930181145.1043048-4-dylan.eskew@candelatech.com>
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
X-MDID: 1727719914-Z06gr4gvGMVi
X-MDID-O:
 us5;ut7;1727719914;Z06gr4gvGMVi;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

Prevent needing to reparse the ie buffer by passing
the ieee80211_elems struct containing the alias ie
pointers.

Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
---
 scan.c | 106 ++++++++++++++++++++++++---------------------------------
 1 file changed, 44 insertions(+), 62 deletions(-)

diff --git a/scan.c b/scan.c
index 6fdaf0b..3210ccc 100644
--- a/scan.c
+++ b/scan.c
@@ -554,13 +554,8 @@ static void tab_on_first(bool *first)
 		*first = false;
 }
 
-struct print_ies_data {
-	unsigned char *ie;
-	int ielen;
-};
-
 static void print_ssid(const uint8_t type, uint8_t len, const uint8_t *data,
-		       const struct print_ies_data *ie_buffer)
+		       const struct ieee80211_elems *elems)
 {
 	printf(" ");
 	print_ssid_escaped(len, data);
@@ -572,7 +567,7 @@ static void print_ssid(const uint8_t type, uint8_t len, const uint8_t *data,
 
 static void print_supprates(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ieee80211_elems *elems)
 {
 	int i;
 
@@ -595,7 +590,7 @@ static void print_supprates(const uint8_t type, uint8_t len,
 
 static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ieee80211_elems *elems)
 {
 	__u64 capa = ((__u64) data[0]) |
 		     ((__u64) data[1]) << 8 |
@@ -649,7 +644,7 @@ static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
 }
 
 static void print_ds(const uint8_t type, uint8_t len, const uint8_t *data,
-		     const struct print_ies_data *ie_buffer)
+		     const struct ieee80211_elems *elems)
 {
 	printf(" channel %d\n", data[0]);
 }
@@ -669,7 +664,7 @@ static const char *country_env_str(char environment)
 }
 
 static void print_country(const uint8_t type, uint8_t len, const uint8_t *data,
-			  const struct print_ies_data *ie_buffer)
+			  const struct ieee80211_elems *elems)
 {
 	printf(" %.*s", 2, data);
 
@@ -716,21 +711,21 @@ static void print_country(const uint8_t type, uint8_t len, const uint8_t *data,
 
 static void print_powerconstraint(const uint8_t type, uint8_t len,
 				  const uint8_t *data,
-				  const struct print_ies_data *ie_buffer)
+				  const struct ieee80211_elems *elems)
 {
 	printf(" %d dB\n", data[0]);
 }
 
 static void print_tpcreport(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ieee80211_elems *elems)
 {
 	printf(" TX power: %d dBm\n", data[0]);
 	/* printf(" Link Margin (%d dB) is reserved in Beacons\n", data[1]); */
 }
 
 static void print_erp(const uint8_t type, uint8_t len, const uint8_t *data,
-		      const struct print_ies_data *ie_buffer)
+		      const struct ieee80211_elems *elems)
 {
 	if (data[0] == 0x00)
 		printf(" <no flags>");
@@ -744,7 +739,7 @@ static void print_erp(const uint8_t type, uint8_t len, const uint8_t *data,
 }
 
 static void print_ap_channel_report(const uint8_t type, uint8_t len, const uint8_t *data,
-				    const struct print_ies_data *ie_buffer)
+				    const struct ieee80211_elems *elems)
 {
 	uint8_t oper_class = data[0];
 	int i;
@@ -1084,13 +1079,13 @@ static void print_osen_ie(const char *defcipher, const char *defauth,
 }
 
 static void print_rsn(const uint8_t type, uint8_t len, const uint8_t *data,
-		      const struct print_ies_data *ie_buffer)
+		      const struct ieee80211_elems *elems)
 {
 	print_rsn_ie("CCMP", "IEEE 802.1X", len, data);
 }
 
 static void print_ht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
-			  const struct print_ies_data *ie_buffer)
+			  const struct ieee80211_elems *elems)
 {
 	printf("\n");
 	print_ht_capability(data[0] | (data[1] << 8));
@@ -1135,7 +1130,7 @@ static const char* vgroup_11u(uint8_t t)
 
 static void print_interworking(const uint8_t type, uint8_t len,
 			       const uint8_t *data,
-			       const struct print_ies_data *ie_buffer)
+			       const struct ieee80211_elems *elems)
 {
 	/* See Section 7.3.2.92 in the 802.11u spec. */
 	printf("\n");
@@ -1168,7 +1163,7 @@ static void print_interworking(const uint8_t type, uint8_t len,
 
 static void print_11u_advert(const uint8_t type, uint8_t len,
 			     const uint8_t *data,
-			     const struct print_ies_data *ie_buffer)
+			     const struct ieee80211_elems *elems)
 {
 	/* See Section 7.3.2.93 in the 802.11u spec. */
 	/* TODO: This code below does not decode private protocol IDs */
@@ -1201,7 +1196,7 @@ static void print_11u_advert(const uint8_t type, uint8_t len,
 }
 
 static void print_11u_rcon(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ieee80211_elems *elems)
 {
 	/* See Section 7.3.2.96 in the 802.11u spec. */
 	int idx = 0;
@@ -1254,7 +1249,7 @@ static void print_11u_rcon(const uint8_t type, uint8_t len, const uint8_t *data,
 
 static void print_tx_power_envelope(const uint8_t type, uint8_t len,
 				    const uint8_t *data,
-				    const struct print_ies_data *ie_buffer)
+				    const struct ieee80211_elems *elems)
 {
 	const uint8_t local_max_tx_power_count = data[0] & 7;
 	const uint8_t local_max_tx_power_unit_interp = (data[0] >> 3) & 7;
@@ -1290,7 +1285,7 @@ static const char *ht_secondary_offset[4] = {
 };
 
 static void print_ht_op(const uint8_t type, uint8_t len, const uint8_t *data,
-			const struct print_ies_data *ie_buffer)
+			const struct ieee80211_elems *elems)
 {
 	static const char *protection[4] = {
 		"no",
@@ -1322,21 +1317,11 @@ static void print_ht_op(const uint8_t type, uint8_t len, const uint8_t *data,
 
 static void print_capabilities(const uint8_t type, uint8_t len,
 			       const uint8_t *data,
-			       const struct print_ies_data *ie_buffer)
+			       const struct ieee80211_elems *elems)
 {
 	int i, base, bit, si_duration = 0, max_amsdu = 0;
-	bool s_psmp_support = false, is_vht_cap = false;
-	unsigned char *ie = ie_buffer->ie;
-	int ielen = ie_buffer->ielen;
-
-	while (ielen >= 2 && ielen >= ie[1]) {
-		if (ie[0] == 191) {
-			is_vht_cap = true;
-			break;
-		}
-		ielen -= ie[1] + 2;
-		ie += ie[1] + 2;
-	}
+	bool is_vht_cap = (elems->lengths[EID_VHT_CAPABILITY] > 0);
+	bool s_psmp_support = false;
 
 	for (i = 0; i < len; i++) {
 		base = i * 8;
@@ -1486,7 +1471,7 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 }
 
 static void print_tim(const uint8_t type, uint8_t len, const uint8_t *data,
-		      const struct print_ies_data *ie_buffer)
+		      const struct ieee80211_elems *elems)
 {
 	printf(" DTIM Count %u DTIM Period %u Bitmap Control 0x%x "
 	       "Bitmap[0] 0x%x",
@@ -1497,13 +1482,13 @@ static void print_tim(const uint8_t type, uint8_t len, const uint8_t *data,
 }
 
 static void print_ibssatim(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ieee80211_elems *elems)
 {
 	printf(" %d TUs\n", (data[1] << 8) + data[0]);
 }
 
 static void print_vht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ieee80211_elems *elems)
 {
 	printf("\n");
 	print_vht_info((__u32) data[0] | ((__u32)data[1] << 8) |
@@ -1512,7 +1497,7 @@ static void print_vht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 }
 
 static void print_vht_oper(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ieee80211_elems *elems)
 {
 	const char *chandwidths[] = {
 		[0] = "20 or 40 MHz",
@@ -1531,7 +1516,7 @@ static void print_vht_oper(const uint8_t type, uint8_t len, const uint8_t *data,
 
 static void print_supp_op_classes(const uint8_t type, uint8_t len,
 				  const uint8_t *data,
-				  const struct print_ies_data *ie_buffer)
+				  const struct ieee80211_elems *elems)
 {
 	uint8_t *p = (uint8_t*) data;
 	const uint8_t *next_data = p + len;
@@ -1565,7 +1550,7 @@ static void print_supp_op_classes(const uint8_t type, uint8_t len,
 
 static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 				       const uint8_t *data,
-				       const struct print_ies_data *ie_buffer)
+				       const struct ieee80211_elems *elems)
 {
 	uint8_t *p, len_remaining;
 
@@ -1614,7 +1599,7 @@ static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 
 static void print_obss_scan_params(const uint8_t type, uint8_t len,
 				   const uint8_t *data,
-				   const struct print_ies_data *ie_buffer)
+				   const struct ieee80211_elems *elems)
 {
 	printf("\n");
 	printf("\t\t * passive dwell: %d TUs\n", (data[1] << 8) | data[0]);
@@ -1629,7 +1614,7 @@ static void print_obss_scan_params(const uint8_t type, uint8_t len,
 
 static void print_secchan_offs(const uint8_t type, uint8_t len,
 			       const uint8_t *data,
-			       const struct print_ies_data *ie_buffer)
+			       const struct ieee80211_elems *elems)
 {
 	if (data[0] < ARRAY_SIZE(ht_secondary_offset))
 		printf(" %s (%d)\n", ht_secondary_offset[data[0]], data[0]);
@@ -1638,7 +1623,7 @@ static void print_secchan_offs(const uint8_t type, uint8_t len,
 }
 
 static void print_bss_load(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ieee80211_elems *elems)
 {
 	printf("\n");
 	printf("\t\t * station count: %d\n", (data[1] << 8) | data[0]);
@@ -1648,7 +1633,7 @@ static void print_bss_load(const uint8_t type, uint8_t len, const uint8_t *data,
 
 static void print_mesh_conf(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ieee80211_elems *elems)
 {
 	printf("\n");
 	printf("\t\t * Active Path Selection Protocol ID: %d\n", data[0]);
@@ -1681,7 +1666,7 @@ static void print_mesh_conf(const uint8_t type, uint8_t len,
 
 static void print_s1g_capa(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ieee80211_elems *elems)
 {
 	printf("\n");
 	print_s1g_capability(data);
@@ -1689,14 +1674,14 @@ static void print_s1g_capa(const uint8_t type, uint8_t len,
 
 static void print_short_beacon_int(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ieee80211_elems *elems)
 {
 	printf(" %d\n", (data[1] << 8) | data[0]);
 }
 
 static void print_s1g_oper(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ieee80211_elems *elems)
 {
 	int oper_ch_width, prim_ch_width;
 	int prim_ch_width_subfield = data[0] & 0x1;
@@ -1777,7 +1762,7 @@ static void print_s1g_oper(const uint8_t type, uint8_t len,
 struct ie_print {
 	const char *name;
 	void (*print)(const uint8_t type, uint8_t len, const uint8_t *data,
-		      const struct print_ies_data *ie_buffer);
+		      const struct ieee80211_elems *elems);
 	uint8_t minlen, maxlen;
 	uint8_t flags;
 };
@@ -1790,7 +1775,7 @@ struct element {
 
 static void print_ie(const struct ie_print *p, const uint8_t type, uint8_t len,
 		     const uint8_t *data,
-		     const struct print_ies_data *ie_buffer)
+		     const struct ieee80211_elems *elems)
 {
 	int i;
 
@@ -1811,7 +1796,7 @@ static void print_ie(const struct ie_print *p, const uint8_t type, uint8_t len,
 		return;
 	}
 
-	p->print(type, len, data, ie_buffer);
+	p->print(type, len, data, elems);
 }
 
 #define PRINT_IGN {		\
@@ -1873,14 +1858,14 @@ static const struct ie_print ieprinters[] = {
 };
 
 static void print_wifi_wpa(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ieee80211_elems *elems)
 {
 	print_rsn_ie("TKIP", "IEEE 802.1X", len, data);
 }
 
 static void print_wifi_osen(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
-			    const struct print_ies_data *ie_buffer)
+			    const struct ieee80211_elems *elems)
 {
 	print_osen_ie("OSEN", "OSEN", len, data);
 }
@@ -1928,7 +1913,7 @@ static bool print_wifi_wmm_param(const uint8_t *data, uint8_t len)
 }
 
 static void print_wifi_wmm(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ieee80211_elems *elems)
 {
 	int i;
 
@@ -1971,7 +1956,7 @@ static const char * wifi_wps_dev_passwd_id(uint16_t id)
 }
 
 static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
-			   const struct print_ies_data *ie_buffer)
+			   const struct ieee80211_elems *elems)
 {
 	bool first = true;
 	__u16 subtype, sublen;
@@ -2211,7 +2196,7 @@ static const struct ie_print wifiprinters[] = {
 
 static inline void print_p2p(const uint8_t type, uint8_t len,
 			     const uint8_t *data,
-			     const struct print_ies_data *ie_buffer)
+			     const struct ieee80211_elems *elems)
 {
 	bool first = true;
 	__u8 subtype;
@@ -2293,7 +2278,7 @@ static inline void print_p2p(const uint8_t type, uint8_t len,
 
 static inline void print_hs20_ind(const uint8_t type, uint8_t len,
 				  const uint8_t *data,
-				  const struct print_ies_data *ie_buffer)
+				  const struct ieee80211_elems *elems)
 {
 	/* I can't find the spec for this...just going off what wireshark uses. */
 	printf("\n");
@@ -2305,7 +2290,7 @@ static inline void print_hs20_ind(const uint8_t type, uint8_t len,
 
 static void print_wifi_owe_tarns(const uint8_t type, uint8_t len,
 				 const uint8_t *data,
-				 const struct print_ies_data *ie_buffer)
+				 const struct ieee80211_elems *elems)
 {
 	char mac_addr[20];
 	int ssid_len;
@@ -2398,7 +2383,7 @@ static void print_vendor(unsigned char len, const unsigned char *data,
 }
 
 static void print_he_capa(const uint8_t type, uint8_t len, const uint8_t *data,
-			  const struct print_ies_data *ie_buffer)
+			  const struct ieee80211_elems *elems)
 {
 	printf("\n");
 	print_he_capability(data, len);
@@ -2495,9 +2480,6 @@ static int parse_ies(unsigned char *ie, int ielen, bool unknown,
 void print_ies(unsigned char *ie, int ielen, bool unknown,
 	       enum print_ie_type ptype)
 {
-	struct print_ies_data ie_buffer = {
-		.ie = ie,
-		.ielen = ielen };
 	struct ieee80211_elems elems = { };
 	unsigned i;
 
@@ -2513,7 +2495,7 @@ void print_ies(unsigned char *ie, int ielen, bool unknown,
 		    ieprinters[i].flags & BIT(ptype) &&
 		    elems.lengths[i] > 0) {
 			print_ie(&ieprinters[i], i, elems.lengths[i],
-				 elems.ies[i], &ie_buffer);
+				 elems.ies[i], &elems);
 		}
 		else if (i == EID_VENDOR) {
 			print_vendor(elems.lengths[i], elems.ies[i],
-- 
2.46.0


