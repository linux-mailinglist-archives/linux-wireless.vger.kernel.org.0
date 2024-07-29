Return-Path: <linux-wireless+bounces-10643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B709400D2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 00:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BE528337D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 22:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D231422C8;
	Mon, 29 Jul 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="JbDgMuPR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421A1B86D6
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290708; cv=none; b=l0wSR6+iciA5CBww3XopWa9gMdCjH30W0AIjMT0HKj/rOGE2AeETMqvY2koyjalZHk9CV/xYxw0WLjRiXpj6SXuXx/i3u59YEbdhTNv+C3ncQ2yOzNmOUwf7StB4ryIPTMDmrrNXrd0udOL3S6q3CbFBam+c1sk/IQFIbkiIkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290708; c=relaxed/simple;
	bh=HUzD7ay0zb9yXSNT8emcx+4NlOxNg/sRb84hu978nms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxz5dR1tX2iI0RD1U3Vwm2oWMYsUyOTcXxsjnFDHLaIU8MuBc4cz60UDUBP68+uqDbbsGn3PDSJNkY6M4t5/9ZywHOCpWXCCUCagQWvcx3gAlOPKGCLSoWhBuzA8dTKY3iQdD8jDXtT/6PNMbCsRWp6oLE05nD61nbSpM/DdwL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=JbDgMuPR; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 56AA55038A8
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 22:05:05 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 831092C0073;
	Mon, 29 Jul 2024 22:04:56 +0000 (UTC)
Received: from corvid-conspiracy.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id F263013C2B0;
	Mon, 29 Jul 2024 15:04:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F263013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1722290695;
	bh=HUzD7ay0zb9yXSNT8emcx+4NlOxNg/sRb84hu978nms=;
	h=From:To:Cc:Subject:Date:From;
	b=JbDgMuPRRWx+8p2HQcnVUFvIgrnPC0WDLoozuCU/lzc3b3oydP9VUWDhR2vaNWwVJ
	 ljgsGu6YbPa4gLw9/xZjPWrAil8es8YDW9EHlnrH1TEADuH42jpFBr2zneo1+hjiUJ
	 bthDj2MJqmeCVa5Ul36EvoR+wKegzPv3wNZt+C/A=
From: "Dylan E." <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	"Dylan E." <dylan.eskew@candelatech.com>
Subject: [PATCH v3] iw: scan: add EHT beacon info support
Date: Mon, 29 Jul 2024 15:04:22 -0700
Message-ID: <20240729220421.2030748-2-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1722290697-JHcJ0Ss0Q1EQ
X-MDID-O:
 us5;at1;1722290697;JHcJ0Ss0Q1EQ;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

Update and add to the old EHT beacon info implementation to print
EHT PHY and MAC capabilities as well as MCS/NSS information for WiFi-7
beacons.

Signed-off-by: Dylan E. <dylan.eskew@candelatech.com>
---
v3:
- Clean up changes and drop he logic Johannes commented on
v2:
- Fix subject

 info.c |   2 +-
 iw.h   |   3 +-
 scan.c |  18 +++++++---
 util.c | 105 +++++++++++++++++++++++++++++++--------------------------
 4 files changed, 74 insertions(+), 54 deletions(-)

diff --git a/info.c b/info.c
index c5e863f..79a2a71 100644
--- a/info.c
+++ b/info.c
@@ -391,7 +391,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 						    tb_band[NL80211_BAND_ATTR_IFTYPE_DATA],
 						    rem_band) {
 					print_he_info(nl_iftype);
-					print_eht_info(nl_iftype, last_band);
+					print_eht_info(nl_iftype);
 				}
 			}
 			if (tb_band[NL80211_BAND_ATTR_FREQS]) {
diff --git a/iw.h b/iw.h
index f416d6d..eda9a3a 100644
--- a/iw.h
+++ b/iw.h
@@ -237,7 +237,8 @@ void print_ht_capability(__u16 cap);
 void print_vht_info(__u32 capa, const __u8 *mcs);
 void print_he_capability(const uint8_t *ie, int len);
 void print_he_info(struct nlattr *nl_iftype);
-void print_eht_info(struct nlattr *nl_iftype, int band);
+void print_eht_capability(const uint8_t *ie, int len);
+void print_eht_info(struct nlattr *nl_iftype);
 void print_s1g_capability(const uint8_t *caps);
 
 char *channel_width_name(enum nl80211_chan_width width);
diff --git a/scan.c b/scan.c
index faf406d..3c8d6ee 100644
--- a/scan.c
+++ b/scan.c
@@ -2384,12 +2384,21 @@ static void print_he_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 	print_he_capability(data, len);
 }
 
+static void print_eht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
+			   const struct print_ies_data *ie_buffer)
+{
+	printf("\n");
+	print_eht_capability(data, len);
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
 
@@ -2401,7 +2410,7 @@ static void print_extension(unsigned char len, unsigned char *ie,
 	tag = ie[0];
 	if (tag < ARRAY_SIZE(ext_printers) && ext_printers[tag].name &&
 	    ext_printers[tag].flags & BIT(ptype)) {
-		print_ie(&ext_printers[tag], tag, len - 1, ie + 1, NULL);
+		print_ie(&ext_printers[tag], tag, len - 1, ie + 1, ie_buffer);
 		return;
 	}
 
@@ -2435,7 +2444,7 @@ void print_ies(unsigned char *ie, int ielen, bool unknown,
 		} else if (ie[0] == 221 /* vendor */) {
 			print_vendor(ie[1], ie + 2, unknown, ptype);
 		} else if (ie[0] == 255 /* extension */) {
-			print_extension(ie[1], ie + 2, unknown, ptype);
+			print_extension(ie[1], ie + 2, unknown, ptype, &ie_buffer);
 		} else if (unknown) {
 			int i;
 
@@ -2639,8 +2648,7 @@ static int print_bss_handler(struct nl_msg *msg, void *arg)
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
index 1341a22..b5a92db 100644
--- a/util.c
+++ b/util.c
@@ -1525,17 +1525,14 @@ void print_he_info(struct nlattr *nl_iftype)
 			true);
 }
 
-static void __print_eht_capa(int band,
-			     const __u8 *mac_cap,
+static void __print_eht_capa(const __u8 *mac_cap,
 			     const __u32 *phy_cap,
 			     const __u8 *mcs_set, size_t mcs_len,
 			     const __u8 *ppet, size_t ppet_len,
-			     const __u16 *he_phy_cap,
 			     bool indent)
 {
-	unsigned int i;
+	size_t i;
 	const char *pre = indent ? "\t" : "";
-	const char *mcs[] = { "0-7", "8-9", "10-11", "12-13"};
 
 	#define PRINT_EHT_CAP(_var, _idx, _bit, _str) \
 	do { \
@@ -1550,6 +1547,7 @@ static void __print_eht_capa(int band,
 	} while (0)
 
 	#define PRINT_EHT_MAC_CAP(...) PRINT_EHT_CAP(mac_cap, __VA_ARGS__)
+	#define PRINT_EHT_MAC_CAP_MASK(...) PRINT_EHT_CAP_MASK(mac_cap, __VA_ARGS__)
 	#define PRINT_EHT_PHY_CAP(...) PRINT_EHT_CAP(phy_cap, __VA_ARGS__)
 	#define PRINT_EHT_PHY_CAP_MASK(...) PRINT_EHT_CAP_MASK(phy_cap, __VA_ARGS__)
 
@@ -1558,10 +1556,19 @@ static void __print_eht_capa(int band,
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
@@ -1610,39 +1617,36 @@ static void __print_eht_capa(int band,
 	PRINT_EHT_PHY_CAP(1, 28, "MU Beamformer (80MHz)");
 	PRINT_EHT_PHY_CAP(1, 29, "MU Beamformer (160MHz)");
 	PRINT_EHT_PHY_CAP(1, 30, "MU Beamformer (320MHz)");
+	PRINT_EHT_PHY_CAP(1, 31, "TB Sounding Feedback Rate Limit");
+
+	PRINT_EHT_PHY_CAP(2, 0, "Rx 1024-QAM In Wider Bandwidth DL OFDMA Supported");
+	PRINT_EHT_PHY_CAP(2, 1, "Rx 4096-QAM In Wider Bandwidth DL OFDMA Supported");
 
 	printf("%s\t\tEHT MCS/NSS: (0x", pre);
 	for (i = 0; i < mcs_len; i++)
 		printf("%02x", ((__u8 *)mcs_set)[i]);
 	printf("):\n");
 
-	if (!(he_phy_cap[0] & ((BIT(2) | BIT(3) | BIT(4)) << 8))){
-		for (i = 0; i < 4; i++)
-			printf("%s\t\tEHT bw=20 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-			       pre, mcs[i],
-			       mcs_set[i] & 0xf, mcs_set[i] >> 4);
-	} else {
-		if (he_phy_cap[0] & (BIT(2) << 8)) {
-			for (i = 0; i < 3; i++)
-				printf("%s\t\tEHT bw <= 80 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-				       pre, mcs[i + 1],
-				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
-		}
-		mcs_set += 3;
+	for (i = 0; i < 3; i++) {
+		char *bw[] = { "<= 80", "160", "320" };
+		char *mcs[] = { "0-9", "10-11", "12-13" };
+		int j;
 
-		if (he_phy_cap[0] & (BIT(3) << 8)) {
-			for (i = 0; i < 3; i++)
-				printf("%s\t\tEHT bw=160 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-				       pre, mcs[i + 1],
-				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
-		}
+		if ((i * 3 + 2) * sizeof(mcs_set[0]) >= mcs_len)
+		   break;
 
-		mcs_set += 3;
-		if (band == NL80211_BAND_6GHZ && (phy_cap[0] & BIT(1))) {
-			for (i = 0; i < 3; i++)
-				printf("%s\t\tEHT bw=320 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-				       pre, mcs[i + 1],
-				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
+		printf("%s\t\tEHT MCS and NSS set %s MHz\n", pre, bw[i]);
+		for (j = 0; j < 6; j++) {
+			__u8 nss = mcs_set[(i * 3) + j / 2];
+			nss >>= (j % 2) * 4;
+			nss &= 0xF;
+
+			printf("%s\t\t\t%s Max NSS that supports MCS %s: ",
+			      pre, j % 2 ? "TX" : "RX", mcs[j / 2]);
+			if (nss == 0)
+				printf("not supported\n");
+			else
+			   printf("%d streams\n", nss);
 		}
 	}
 
@@ -1655,14 +1659,13 @@ static void __print_eht_capa(int band,
 	}
 }
 
-void print_eht_info(struct nlattr *nl_iftype, int band)
+void print_eht_info(struct nlattr *nl_iftype)
 {
 	struct nlattr *tb[NL80211_BAND_IFTYPE_ATTR_MAX + 1];
 	__u8 mac_cap[2] = { 0 };
 	__u32 phy_cap[2] = { 0 };
 	__u8 mcs_set[13] = { 0 };
 	__u8 ppet[31] = { 0 };
-	__u16 he_phy_cap[6] = { 0 };
 	size_t len, mcs_len = 0, ppet_len = 0;
 
 	nla_parse(tb, NL80211_BAND_IFTYPE_ATTR_MAX,
@@ -1718,18 +1721,8 @@ void print_eht_info(struct nlattr *nl_iftype, int band)
 		ppet_len = len;
 	}
 
-	if (tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY]) {
-		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY]);
-
-		if (len > sizeof(he_phy_cap) - 1)
-			len = sizeof(he_phy_cap) - 1;
-		memcpy(&((__u8 *)he_phy_cap)[1],
-		       nla_data(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY]),
-		       len);
-	}
-
-	__print_eht_capa(band, mac_cap, phy_cap, mcs_set, mcs_len, ppet, ppet_len,
-			 he_phy_cap, true);
+	__print_eht_capa(mac_cap, phy_cap, mcs_set, mcs_len, ppet, ppet_len,
+			 true);
 }
 
 void print_he_capability(const uint8_t *ie, int len)
@@ -1750,6 +1743,24 @@ void print_he_capability(const uint8_t *ie, int len)
 	__print_he_capa(mac_cap, phy_cap - 1, mcs_set, mcs_len, NULL, 0, false);
 }
 
+void print_eht_capability(const uint8_t *ie, int len)
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
+	__print_eht_capa(mac_cap, phy_cap - 1, mcs_set, mcs_len, NULL, 0, false);
+}
+
 void iw_hexdump(const char *prefix, const __u8 *buf, size_t size)
 {
 	size_t i;
-- 
2.45.2


