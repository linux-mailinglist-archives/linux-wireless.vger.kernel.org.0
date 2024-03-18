Return-Path: <linux-wireless+bounces-4869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD8C87F18A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 21:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9413B281146
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4E938DD0;
	Mon, 18 Mar 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="iyHxCgOV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52326AF0
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794947; cv=none; b=ijb8pzNcOAlnu0GO5c5G/WfW59ph+i63aeCCj+MqabKtouRpg/aTKIB2yxt/0VCqMWtcfWBGYC1c5ok4es7rs1xEA4k3eGp/bBsj4smMqN1ccGtDMngp5nFEmA62fzEYfXGoolBig/8j04RjxS35fcIV+OJYsU3ywJHUao1wiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794947; c=relaxed/simple;
	bh=wdOHzEdHenoE+HfdktD9iSBsrTsyT7Z0cRa6nvRXDLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0jekAzsr08n6rg61/KQtd0p3ODa9fokGz4+EDqjGk8DYoDGYLhjimjibkHZIOwTVLIY+LZe2YOhgyejJ/zd1dtlpfI7Rcj2Y1cy5O4a1tMNZvNpYD/A936Mx5Hv9CKWVjY6j5I260A2hmkRtkxlVe5uV8wyubzXtBMFRAW1Qvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=iyHxCgOV; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 48EB8501E9F
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 20:49:04 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3DEFF340065;
	Mon, 18 Mar 2024 20:48:56 +0000 (UTC)
Received: from ct-eskewd.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPS id 85FA413C2B1;
	Mon, 18 Mar 2024 13:48:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 85FA413C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1710794935;
	bh=wdOHzEdHenoE+HfdktD9iSBsrTsyT7Z0cRa6nvRXDLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iyHxCgOVT3MKRhPboZ8FNA+9aCQ7h9bvXKM8wOcgfnxY3reh6T45BheKVeXimBujn
	 GCqv5zVTQIVnZFRJwuhm34rbiIqf0LBV4RmA7Cm3b73rlovbFgKqZketiUoRQHswVQ
	 LrUPToDoptJEl49cg88pQqvjl8AaGSAUdM+0QX4I=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] Update and add to the old EHT beacon info implementation to print EHT PHY and MAC capabilities as well as MCS/NSS information for WiFi-7 beacons.
Date: Mon, 18 Mar 2024 13:46:40 -0700
Message-ID: <20240318204849.73681-2-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318204849.73681-1-dylan.eskew@candelatech.com>
References: <20240318204849.73681-1-dylan.eskew@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MDID: 1710794937-e4unZB5CqHQM
X-MDID-O:
 us5;at1;1710794937;e4unZB5CqHQM;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

From: "Dylan E." <dylan.eskew@candelatech.com>

Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
---
 info.c |   2 +-
 iw.h   |   3 +-
 scan.c |  37 ++++++++++++++---
 util.c | 127 +++++++++++++++++++++++++++++++++++----------------------
 4 files changed, 114 insertions(+), 55 deletions(-)

diff --git a/info.c b/info.c
index 40dcc81..ef5b557 100644
--- a/info.c
+++ b/info.c
@@ -390,7 +390,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 						    tb_band[NL80211_BAND_ATTR_IFTYPE_DATA],
 						    rem_band) {
 					print_he_info(nl_iftype);
-					print_eht_info(nl_iftype, last_band);
+					print_eht_info(nl_iftype);
 				}
 			}
 			if (tb_band[NL80211_BAND_ATTR_FREQS]) {
diff --git a/iw.h b/iw.h
index 7e9107e..a95b4c4 100644
--- a/iw.h
+++ b/iw.h
@@ -223,7 +223,8 @@ void print_ht_capability(__u16 cap);
 void print_vht_info(__u32 capa, const __u8 *mcs);
 void print_he_capability(const uint8_t *ie, int len);
 void print_he_info(struct nlattr *nl_iftype);
-void print_eht_info(struct nlattr *nl_iftype, int band);
+void print_eht_capability(const uint8_t *ie, int len, const __u16 *he_phy_cap);
+void print_eht_info(struct nlattr *nl_iftype);
 void print_s1g_capability(const uint8_t *caps);
 
 char *channel_width_name(enum nl80211_chan_width width);
diff --git a/scan.c b/scan.c
index faf406d..5b22293 100644
--- a/scan.c
+++ b/scan.c
@@ -2384,12 +2384,40 @@ static void print_he_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 	print_he_capability(data, len);
 }
 
+static void print_eht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
+			   const struct print_ies_data *ie_buffer)
+{
+	bool is_he = false;
+	const __u16 he_phy_cap[6] = { 0 };
+	unsigned char *ie = ie_buffer->ie;
+	int ielen = ie_buffer->ielen;
+
+	while (ielen >= 2 && ielen >= ie[1]) {
+		if (ie[0] == 255 && ie[2] == 35) {
+			is_he = true;
+			break;
+		}
+		ielen -= ie[1] + 2;
+		ie += ie[1] + 2;
+	}
+
+	if (is_he) {
+		memcpy(&((__u8 *)he_phy_cap)[0],
+		       ie + 9, 12);
+	}
+
+	printf("\n");
+	print_eht_capability(data, len, he_phy_cap);
+}
+
 static const struct ie_print ext_printers[] = {
 	[35] = { "HE capabilities", print_he_capa, 21, 54, BIT(PRINT_SCAN), },
+	[108] = { "EHT capabilties", print_eht_capa, 13, 30, BIT(PRINT_SCAN), },
 };
 
 static void print_extension(unsigned char len, unsigned char *ie,
-			    bool unknown, enum print_ie_type ptype)
+			    bool unknown, enum print_ie_type ptype,
+			    const struct print_ies_data *ie_buffer)
 {
 	unsigned char tag;
 
@@ -2401,7 +2429,7 @@ static void print_extension(unsigned char len, unsigned char *ie,
 	tag = ie[0];
 	if (tag < ARRAY_SIZE(ext_printers) && ext_printers[tag].name &&
 	    ext_printers[tag].flags & BIT(ptype)) {
-		print_ie(&ext_printers[tag], tag, len - 1, ie + 1, NULL);
+		print_ie(&ext_printers[tag], tag, len - 1, ie + 1, ie_buffer);
 		return;
 	}
 
@@ -2435,7 +2463,7 @@ void print_ies(unsigned char *ie, int ielen, bool unknown,
 		} else if (ie[0] == 221 /* vendor */) {
 			print_vendor(ie[1], ie + 2, unknown, ptype);
 		} else if (ie[0] == 255 /* extension */) {
-			print_extension(ie[1], ie + 2, unknown, ptype);
+			print_extension(ie[1], ie + 2, unknown, ptype, &ie_buffer);
 		} else if (unknown) {
 			int i;
 
@@ -2639,8 +2667,7 @@ static int print_bss_handler(struct nl_msg *msg, void *arg)
 				       nla_len(ies)))))
 			printf("\tInformation elements from Probe Response "
 			       "frame:\n");
-		print_ies(nla_data(ies), nla_len(ies),
-			  params->unknown, params->type);
+		print_ies(nla_data(ies), nla_len(ies), params->unknown, params->type);
 	}
 	if (bss[NL80211_BSS_BEACON_IES] && show--) {
 		printf("\tInformation elements from Beacon frame:\n");
diff --git a/util.c b/util.c
index d36dbdc..fca76bb 100644
--- a/util.c
+++ b/util.c
@@ -1508,17 +1508,15 @@ void print_he_info(struct nlattr *nl_iftype)
 			true);
 }
 
-static void __print_eht_capa(int band,
-			     const __u8 *mac_cap,
+static void __print_eht_capa(const __u8 *mac_cap,
 			     const __u32 *phy_cap,
 			     const __u8 *mcs_set, size_t mcs_len,
 			     const __u8 *ppet, size_t ppet_len,
 			     const __u16 *he_phy_cap,
 			     bool indent)
 {
-	unsigned int i;
+	size_t i;
 	const char *pre = indent ? "\t" : "";
-	const char *mcs[] = { "0-7", "8-9", "10-11", "12-13"};
 
 	#define PRINT_EHT_CAP(_var, _idx, _bit, _str) \
 	do { \
@@ -1533,6 +1531,7 @@ static void __print_eht_capa(int band,
 	} while (0)
 
 	#define PRINT_EHT_MAC_CAP(...) PRINT_EHT_CAP(mac_cap, __VA_ARGS__)
+	#define PRINT_EHT_MAC_CAP_MASK(...) PRINT_EHT_CAP_MASK(mac_cap, __VA_ARGS__)
 	#define PRINT_EHT_PHY_CAP(...) PRINT_EHT_CAP(phy_cap, __VA_ARGS__)
 	#define PRINT_EHT_PHY_CAP_MASK(...) PRINT_EHT_CAP_MASK(phy_cap, __VA_ARGS__)
 
@@ -1541,10 +1540,19 @@ static void __print_eht_capa(int band,
 		printf("%02x", mac_cap[i]);
 	printf("):\n");
 
-	PRINT_EHT_MAC_CAP(0, 0, "NSEP priority access Supported");
+	PRINT_EHT_MAC_CAP(0, 0, "EPCS Priority Access Supported");
 	PRINT_EHT_MAC_CAP(0, 1, "EHT OM Control Supported");
-	PRINT_EHT_MAC_CAP(0, 2, "Triggered TXOP Sharing Supported");
-	PRINT_EHT_MAC_CAP(0, 3, "ARR Supported");
+	PRINT_EHT_MAC_CAP(0, 2, "Triggered TXOP Sharing Mode 1 Supported");
+	PRINT_EHT_MAC_CAP(0, 3, "Triggered TXOP Sharing Mode 2 Supported");
+	PRINT_EHT_MAC_CAP(0, 4, "Restricted TWP Supported");
+	PRINT_EHT_MAC_CAP(0, 5, "SCS Traffic Description Supported");
+	PRINT_EHT_MAC_CAP_MASK(0, 6, 0x3, "Maximum MPDU Length");
+
+	PRINT_EHT_MAC_CAP(1, 1, "Maximum A-MPDU Length Exponent Extension");
+	PRINT_EHT_MAC_CAP(1, 2, "EHT TRS Supported");
+	PRINT_EHT_MAC_CAP(1, 3, "TXOP Return In TXOP Sharing Mode 2 Supported");
+	PRINT_EHT_MAC_CAP(1, 4, "Two BQRs Supported");
+	PRINT_EHT_MAC_CAP_MASK(1, 5, 0x3, "EHT Link Adaptation Supported");
 
 	printf("%s\t\tEHT PHY Capabilities: (0x", pre);
 	for (i = 0; i < 8; i++)
@@ -1557,13 +1565,13 @@ static void __print_eht_capa(int band,
 	PRINT_EHT_PHY_CAP(0, 4, "Partial Bandwidth UL MU-MIMO");
 	PRINT_EHT_PHY_CAP(0, 5, "SU Beamformer");
 	PRINT_EHT_PHY_CAP(0, 6, "SU Beamformee");
-	PRINT_EHT_PHY_CAP_MASK(0, 7, 0x7, "Beamformee SS (80MHz)");
-	PRINT_EHT_PHY_CAP_MASK(0, 10, 0x7, "Beamformee SS (160MHz)");
-	PRINT_EHT_PHY_CAP_MASK(0, 13, 0x7, "Beamformee SS (320MHz)");
+	PRINT_EHT_PHY_CAP_MASK(0, 7, 0x7, "Beamformee SS <= 80MHz");
+	PRINT_EHT_PHY_CAP_MASK(0, 10, 0x7, "Beamformee SS = 160MHz");
+	PRINT_EHT_PHY_CAP_MASK(0, 13, 0x7, "Beamformee SS = 320MHz");
 
-	PRINT_EHT_PHY_CAP_MASK(0, 16, 0x7, "Number Of Sounding Dimensions (80MHz)");
-	PRINT_EHT_PHY_CAP_MASK(0, 19, 0x7, "Number Of Sounding Dimensions (160MHz)");
-	PRINT_EHT_PHY_CAP_MASK(0, 22, 0x7, "Number Of Sounding Dimensions (320MHz)");
+	PRINT_EHT_PHY_CAP_MASK(0, 16, 0x7, "Number Of Sounding Dimensions <= 80MHz");
+	PRINT_EHT_PHY_CAP_MASK(0, 19, 0x7, "Number Of Sounding Dimensions = 160MHz");
+	PRINT_EHT_PHY_CAP_MASK(0, 22, 0x7, "Number Of Sounding Dimensions = 320MHz");
 	PRINT_EHT_PHY_CAP(0, 25, "Ng = 16 SU Feedback");
 	PRINT_EHT_PHY_CAP(0, 26, "Ng = 16 MU Feedback");
 	PRINT_EHT_PHY_CAP(0, 27, "Codebook size (4, 2) SU Feedback");
@@ -1573,9 +1581,9 @@ static void __print_eht_capa(int band,
 	PRINT_EHT_PHY_CAP(0, 31, "Triggered CQI Feedback");
 
 	PRINT_EHT_PHY_CAP(1, 0, "Partial Bandwidth DL MU-MIMO");
-	PRINT_EHT_PHY_CAP(1, 1, "PSR-Based SR Support");
-	PRINT_EHT_PHY_CAP(1, 2, "Power Boost Factor Support");
-	PRINT_EHT_PHY_CAP(1, 3, "EHT MU PPDU With 4 EHT-LTF And 0.8 µs GI");
+	PRINT_EHT_PHY_CAP(1, 1, "EHT PSR-Based SR Supported");
+	PRINT_EHT_PHY_CAP(1, 2, "Power Boost Factor Supported");
+	PRINT_EHT_PHY_CAP(1, 3, "EHT MU PPDU With 4x EHT-LTF And 0.8 µs GI");
 	PRINT_EHT_PHY_CAP_MASK(1, 4, 0xf, "Max Nc");
 	PRINT_EHT_PHY_CAP(1, 8, "Non-Triggered CQI Feedback");
 
@@ -1584,48 +1592,52 @@ static void __print_eht_capa(int band,
 	PRINT_EHT_PHY_CAP(1, 11, "PPE Thresholds Present");
 	PRINT_EHT_PHY_CAP_MASK(1, 12, 0x3, "Common Nominal Packet Padding");
 	PRINT_EHT_PHY_CAP_MASK(1, 14, 0x1f, "Maximum Number Of Supported EHT-LTFs");
-	PRINT_EHT_PHY_CAP_MASK(1, 19, 0xf, "Support of MCS 15");
-	PRINT_EHT_PHY_CAP(1, 23, "Support Of EHT DUP In 6 GHz");
-	PRINT_EHT_PHY_CAP(1, 24, "Support For 20MHz Rx NDP With Wider Bandwidth");
-	PRINT_EHT_PHY_CAP(1, 25, "Non-OFDMA UL MU-MIMO (80MHz)");
-	PRINT_EHT_PHY_CAP(1, 26, "Non-OFDMA UL MU-MIMO (160MHz)");
-	PRINT_EHT_PHY_CAP(1, 27, "Non-OFDMA UL MU-MIMO (320MHz)");
-	PRINT_EHT_PHY_CAP(1, 28, "MU Beamformer (80MHz)");
-	PRINT_EHT_PHY_CAP(1, 29, "MU Beamformer (160MHz)");
-	PRINT_EHT_PHY_CAP(1, 30, "MU Beamformer (320MHz)");
+	PRINT_EHT_PHY_CAP_MASK(1, 19, 0xf, "MCS 15 Supported");
+	PRINT_EHT_PHY_CAP(1, 23, "EHT DUP (MCS 14) In 6 GHz Supported");
+	PRINT_EHT_PHY_CAP(1, 24, "20 MHz Operating STA Receiving NDP With Wider BW Supported");
+	PRINT_EHT_PHY_CAP(1, 25, "Non-OFDMA UL MU-MIMO <= 80MHz");
+	PRINT_EHT_PHY_CAP(1, 26, "Non-OFDMA UL MU-MIMO = 160MHz");
+	PRINT_EHT_PHY_CAP(1, 27, "Non-OFDMA UL MU-MIMO = 320MHz");
+	PRINT_EHT_PHY_CAP(1, 28, "MU Beamformer (BW <= 80MHz)");
+	PRINT_EHT_PHY_CAP(1, 29, "MU Beamformer (BW = 160MHz)");
+	PRINT_EHT_PHY_CAP(1, 30, "MU Beamformer (BW = 320MHz)");
+	PRINT_EHT_PHY_CAP(1, 31, "TB Sounding Feedback Rate Limit");
+
+	PRINT_EHT_PHY_CAP(2, 0, "Rx 1024-QAM In Wider Bandwidth DL OFDMA Supported");
+	PRINT_EHT_PHY_CAP(2, 1, "Rx 4096-QAM In Wider Bandwidth DL OFDMA Supported");
 
 	printf("%s\t\tEHT MCS/NSS: (0x", pre);
 	for (i = 0; i < mcs_len; i++)
 		printf("%02x", ((__u8 *)mcs_set)[i]);
 	printf("):\n");
 
-	if (!(he_phy_cap[0] & ((BIT(2) | BIT(3) | BIT(4)) << 8))){
+	/*if (!(he_phy_cap[0] & ((BIT(2) | BIT(3) | BIT(4)) << 8))){
 		for (i = 0; i < 4; i++)
 			printf("%s\t\tEHT bw=20 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
 			       pre, mcs[i],
 			       mcs_set[i] & 0xf, mcs_set[i] >> 4);
-	} else {
-		if (he_phy_cap[0] & (BIT(2) << 8)) {
-			for (i = 0; i < 3; i++)
-				printf("%s\t\tEHT bw <= 80 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-				       pre, mcs[i + 1],
-				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
-		}
-		mcs_set += 3;
+        }*/
 
-		if (he_phy_cap[0] & (BIT(3) << 8)) {
-			for (i = 0; i < 3; i++)
-				printf("%s\t\tEHT bw=160 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-				       pre, mcs[i + 1],
-				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
-		}
+	for (i = 0; i < 3; i++) {
+		char *bw[] = { "<= 80", "160", "320" };
+		char *mcs[] = { "0-9", "10-11", "12-13" };
+		int j;
+
+		if ((i * 3 + 2) * sizeof(mcs_set[0]) >= mcs_len)
+		   break;
+
+		printf("%s\t\tEHT MCS and NSS set %s MHz\n", pre, bw[i]);
+		for (j = 0; j < 6; j++) {
+			__u8 nss = mcs_set[(i * 3) + j / 2];
+			nss >>= (j % 2) * 4;
+			nss &= 0xF;
 
-		mcs_set += 3;
-		if (band == NL80211_BAND_6GHZ && (phy_cap[0] & BIT(1))) {
-			for (i = 0; i < 3; i++)
-				printf("%s\t\tEHT bw=320 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-				       pre, mcs[i + 1],
-				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
+			printf("%s\t\t\t%s Max NSS that supports MCS %s: ",
+			      pre, j % 2 ? "TX" : "RX", mcs[j / 2]);
+			if (nss == 0)
+				printf("not supported\n");
+			else
+			   printf("%d streams\n", nss);
 		}
 	}
 
@@ -1638,7 +1650,7 @@ static void __print_eht_capa(int band,
 	}
 }
 
-void print_eht_info(struct nlattr *nl_iftype, int band)
+void print_eht_info(struct nlattr *nl_iftype)
 {
 	struct nlattr *tb[NL80211_BAND_IFTYPE_ATTR_MAX + 1];
 	__u8 mac_cap[2] = { 0 };
@@ -1711,7 +1723,7 @@ void print_eht_info(struct nlattr *nl_iftype, int band)
 		       len);
 	}
 
-	__print_eht_capa(band, mac_cap, phy_cap, mcs_set, mcs_len, ppet, ppet_len,
+	__print_eht_capa(mac_cap, phy_cap, mcs_set, mcs_len, ppet, ppet_len,
 			 he_phy_cap, true);
 }
 
@@ -1733,6 +1745,25 @@ void print_he_capability(const uint8_t *ie, int len)
 	__print_he_capa(mac_cap, phy_cap - 1, mcs_set, mcs_len, NULL, 0, false);
 }
 
+void print_eht_capability(const uint8_t *ie, int len, const __u16 *he_phy_cap)
+{
+	const void *mac_cap, *phy_cap, *mcs_set;
+	int mcs_len;
+	int i = 0;
+
+	mac_cap = &ie[i];
+	i += 3;
+
+	phy_cap = &ie[i];
+	i += 8;
+
+	mcs_set = &ie[i];
+	mcs_len = len - i;
+
+	__print_eht_capa(mac_cap, phy_cap - 1, mcs_set, mcs_len, NULL, 0,
+			 he_phy_cap, false);
+}
+
 void iw_hexdump(const char *prefix, const __u8 *buf, size_t size)
 {
 	size_t i;
-- 
2.44.0


