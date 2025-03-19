Return-Path: <linux-wireless+bounces-20576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCF1A69831
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 19:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990DF188D59D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E21A187FEC;
	Wed, 19 Mar 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="EWHTnJLV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A51E2834
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409572; cv=none; b=QIHq6BoA3wBu/c2PGxjQnpWwUa8VE6vwL0uifudl6wOQR42gfjT1jufDSML9AjJddfoZgWpNsr1EyHQU1LcQQ80lD0Q+btg5//89jzh+cPGcwGQlYyjy0wBImd44C+8WuwomsWwkMTuUsnGORfzVRVqJ70C/eMn7HlA0m/UEw/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409572; c=relaxed/simple;
	bh=0Lv2cH2yGjyhyRDoMRwLBPww8vBEkeagvIRbdmvr+I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlsQb3i08tgTh0pdzKRWRY1cJAqf824OmYzXeuLJ+6IbIGdWG2ebeMphSqEWxyuEzuqmKBC8LbthlCjBI2VBbdQnX4LZYndSEkjVn77HMJgXusQSdtV+mBuGCCH6OQgBLKgGnZmCSaRKasMpCRNl/HZ0hXzceIVf+xZ7IcvSllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=EWHTnJLV; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 23ED5240098;
	Wed, 19 Mar 2025 18:39:28 +0000 (UTC)
Received: from corvid-conspiracy.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 70E2313C2B0;
	Wed, 19 Mar 2025 11:39:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 70E2313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1742409567;
	bh=0Lv2cH2yGjyhyRDoMRwLBPww8vBEkeagvIRbdmvr+I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWHTnJLVnHGs+CRj7s/x5FXL6+JpmpT039dh3J35YSkRdqPLqn02UigEJuuZkIDvC
	 mcmn2zEmAWW34hoc8+Uo3/SLAZTLiMUmBmGPYKJLKogi14nFGMPOk9p7nI9Lt71pTP
	 2gaLJUxyaQd28B+UCayGSnhe/5m2znHMYsFSnxVw=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH iw v6 1/2] iw: util: update and clean up eht capa printing
Date: Wed, 19 Mar 2025 11:39:17 -0700
Message-ID: <20250319183918.1215853-2-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319183918.1215853-1-dylan.eskew@candelatech.com>
References: <20250319183918.1215853-1-dylan.eskew@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1742409569-TFk-lKPw9Mvi
X-MDID-O:
 us5;at1;1742409569;TFk-lKPw9Mvi;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

A number of fields were either missing or incorrect, so
update to more aligned with 802.11be spec. Also clean up
printout formatting.

Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
---
 iw.h   |   2 +
 util.c | 124 ++++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 99 insertions(+), 27 deletions(-)

diff --git a/iw.h b/iw.h
index dc11d2b..8cbb971 100644
--- a/iw.h
+++ b/iw.h
@@ -245,6 +245,8 @@ void print_vht_info(__u32 capa, const __u8 *mcs);
 void print_he_capability(const uint8_t *ie, int len);
 void print_he_operation(const uint8_t *ie, int len);
 void print_he_info(struct nlattr *nl_iftype);
+void print_eht_capability(const uint8_t *ie, int len, const uint8_t *he_cap,
+			  bool from_ap);
 void print_eht_info(struct nlattr *nl_iftype, int band);
 void print_s1g_capability(const uint8_t *caps);
 
diff --git a/util.c b/util.c
index dc84886..ee0fd7a 100644
--- a/util.c
+++ b/util.c
@@ -1531,11 +1531,11 @@ static void __print_eht_capa(int band,
 			     const __u8 *mcs_set, size_t mcs_len,
 			     const __u8 *ppet, size_t ppet_len,
 			     const __u16 *he_phy_cap,
+			     bool from_ap,
 			     bool indent)
 {
 	unsigned int i;
 	const char *pre = indent ? "\t" : "";
-	const char *mcs[] = { "0-7", "8-9", "10-11", "12-13"};
 
 	#define PRINT_EHT_CAP(_var, _idx, _bit, _str) \
 	do { \
@@ -1550,6 +1550,7 @@ static void __print_eht_capa(int band,
 	} while (0)
 
 	#define PRINT_EHT_MAC_CAP(...) PRINT_EHT_CAP(mac_cap, __VA_ARGS__)
+	#define PRINT_EHT_MAC_CAP_MASK(...) PRINT_EHT_CAP_MASK(mac_cap, __VA_ARGS__)
 	#define PRINT_EHT_PHY_CAP(...) PRINT_EHT_CAP(phy_cap, __VA_ARGS__)
 	#define PRINT_EHT_PHY_CAP_MASK(...) PRINT_EHT_CAP_MASK(phy_cap, __VA_ARGS__)
 
@@ -1558,13 +1559,22 @@ static void __print_eht_capa(int band,
 		printf("%02x", mac_cap[i]);
 	printf("):\n");
 
-	PRINT_EHT_MAC_CAP(0, 0, "NSEP priority access Supported");
+	PRINT_EHT_MAC_CAP(0, 0, "EPCS Priority Access Supported");
 	PRINT_EHT_MAC_CAP(0, 1, "EHT OM Control Supported");
-	PRINT_EHT_MAC_CAP(0, 2, "Triggered TXOP Sharing Supported");
-	PRINT_EHT_MAC_CAP(0, 3, "ARR Supported");
-
-	printf("%s\t\tEHT PHY Capabilities: (0x", pre);
-	for (i = 0; i < 8; i++)
+	PRINT_EHT_MAC_CAP(0, 2, "Triggered TXOP Sharing Mode 1 Supported");
+	PRINT_EHT_MAC_CAP(0, 3, "Triggered TXOP Sharing Mode 2 Supported");
+	PRINT_EHT_MAC_CAP(0, 4, "Restricted TWP Supported");
+	PRINT_EHT_MAC_CAP(0, 5, "SCS Traffic Description Supported");
+	PRINT_EHT_MAC_CAP_MASK(0, 6, 0x3, "Maximum MPDU Length");
+
+	PRINT_EHT_MAC_CAP(1, 1, "Maximum A_MPDU Length Exponent Extension");
+	PRINT_EHT_MAC_CAP(1, 2, "EHT TRS Supported");
+	PRINT_EHT_MAC_CAP(1, 3, "TXOP Return In TXOP Sharing Mode 2 Supported");
+	PRINT_EHT_MAC_CAP(1, 4, "Two BQRs Supported");
+	PRINT_EHT_MAC_CAP_MASK(1, 5, 0x3, "EHT Link Adaptation Supported");
+
+	printf("%s\t\tEHT PHY Capabilities (0x", pre);
+	for (i = 0; i < 9; i++)
 		printf("%02x", ((__u8 *)phy_cap)[i]);
 	printf("):\n");
 
@@ -1610,39 +1620,77 @@ static void __print_eht_capa(int band,
 	PRINT_EHT_PHY_CAP(1, 28, "MU Beamformer (80MHz)");
 	PRINT_EHT_PHY_CAP(1, 29, "MU Beamformer (160MHz)");
 	PRINT_EHT_PHY_CAP(1, 30, "MU Beamformer (320MHz)");
+	PRINT_EHT_PHY_CAP(1, 31, "TB Sounding Feedback Rate Limit");
 
-	printf("%s\t\tEHT MCS/NSS: (0x", pre);
-	for (i = 0; i < mcs_len; i++)
-		printf("%02x", ((__u8 *)mcs_set)[i]);
-	printf("):\n");
+	PRINT_EHT_PHY_CAP(2, 0, "Rx 1024-QAM In Wider Bandwidth DL OFDMA Supported");
+	PRINT_EHT_PHY_CAP(2, 1, "Rx 4096-QAM In Wider Bandwidth DL OFDMA Supported");
+
+	if (!from_ap &&
+	    !(he_phy_cap[0] & ((BIT(1) | BIT(2) | BIT(3) | BIT(4)) << 8))) {
+		static const char * const mcs[] = { "0-7", "8-9", "10-11", "12-13" };
 
-	if (!(he_phy_cap[0] & ((BIT(2) | BIT(3) | BIT(4)) << 8))){
-		for (i = 0; i < 4; i++)
-			printf("%s\t\tEHT bw=20 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-			       pre, mcs[i],
-			       mcs_set[i] & 0xf, mcs_set[i] >> 4);
+		printf("%s\t\tEHT-MCS Map (20 Mhz Non-AP STA) (0x", pre);
+		for (i = 0; i < mcs_len; i++)
+			printf("%02x", ((__u8 *)mcs_set)[i]);
+		printf("):\n");
+
+		for (i = 0; i < 4; i++) {
+			printf("%s\t\t\tRx Max NSS for MCS %s: %u\n",
+			       pre, mcs[i], mcs_set[i] & 0xf);
+			printf("%s\t\t\tTx Max NSS for MCS %s: %u\n",
+			       pre, mcs[i], mcs_set[i] >> 4);
+		}
 	} else {
-		if (he_phy_cap[0] & (BIT(2) << 8)) {
+		static const char * const mcs[] = { "0-9", "10-11", "12-13"};
+
+		/* Bit 1 corresponds to 2.4Ghz 40Mhz support
+		 * Bit 2 corresponds to 5/6Ghz 40 and 80Mhz support
+		 * If no Channel Width bits are set, but we are an AP, we use
+		 * this MCS logic also.
+		 */
+		if (he_phy_cap[0] & ((BIT(1) | BIT(2)) << 8) ||
+		    (from_ap && !(he_phy_cap[0] & ((BIT(1) | BIT(2) | BIT(3) | BIT(4)) << 8)))) {
+			printf("%s\t\tEHT-MCS Map (BW <= 80) (0x", pre);
 			for (i = 0; i < 3; i++)
-				printf("%s\t\tEHT bw <= 80 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-				       pre, mcs[i + 1],
-				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
+				printf("%02x", ((__u8 *)mcs_set)[i]);
+			printf("):\n");
+
+			for (i = 0; i < 3; i++) {
+				printf("%s\t\t\tRx Max NSS for MCS %s: %u\n",
+				       pre, mcs[i], mcs_set[i] & 0xf);
+				printf("%s\t\t\tTx Max NSS for MCS %s: %u\n",
+				       pre, mcs[i], mcs_set[i] >> 4);
+			}
 		}
 		mcs_set += 3;
 
 		if (he_phy_cap[0] & (BIT(3) << 8)) {
+			printf("%s\t\tEHT-MCS Map (BW = 160) (0x", pre);
 			for (i = 0; i < 3; i++)
-				printf("%s\t\tEHT bw=160 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-				       pre, mcs[i + 1],
-				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
+				printf("%02x", ((__u8 *)mcs_set)[i]);
+			printf("):\n");
+
+			for (i = 0; i < 3; i++) {
+				printf("%s\t\t\tRx Max NSS for MCS %s: %u\n",
+				       pre, mcs[i], mcs_set[i] & 0xf);
+				printf("%s\t\t\tTx Max NSS for MCS %s: %u\n",
+				       pre, mcs[i], mcs_set[i] >> 4);
+			}
 		}
 
 		mcs_set += 3;
 		if (band == NL80211_BAND_6GHZ && (phy_cap[0] & BIT(1))) {
+			printf("%s\t\tEHT-MCS Map (BW = 320) (0x", pre);
 			for (i = 0; i < 3; i++)
-				printf("%s\t\tEHT bw=320 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-				       pre, mcs[i + 1],
-				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
+				printf("%02x", ((__u8 *)mcs_set)[i]);
+			printf("):\n");
+
+			for (i = 0; i < 3; i++) {
+				printf("%s\t\t\tRx Max NSS for MCS %s: %u\n",
+				       pre, mcs[i], mcs_set[i] & 0xf);
+				printf("%s\t\t\tTx Max NSS for MCS %s: %u\n",
+				       pre, mcs[i], mcs_set[i] >> 4);
+			}
 		}
 	}
 
@@ -1729,7 +1777,29 @@ void print_eht_info(struct nlattr *nl_iftype, int band)
 	}
 
 	__print_eht_capa(band, mac_cap, phy_cap, mcs_set, mcs_len, ppet, ppet_len,
-			 he_phy_cap, true);
+			 he_phy_cap, false, true);
+}
+
+void print_eht_capability(const uint8_t *ie, int len, const uint8_t *he_cap,
+			  bool from_ap)
+{
+	const void *mac_cap, *phy_cap, *mcs_set, *he_phy_cap;
+	int mcs_len;
+	int i = 0;
+
+	mac_cap = &ie[i];
+	i += 2;
+
+	phy_cap = &ie[i];
+	i += 9;
+
+	mcs_set = &ie[i];
+	mcs_len = len - i;
+
+	he_phy_cap = &he_cap[6];
+
+	__print_eht_capa(NL80211_BAND_6GHZ, mac_cap, phy_cap, mcs_set, mcs_len,
+			 NULL, 0, he_phy_cap - 1, from_ap, false);
 }
 
 void print_he_capability(const uint8_t *ie, int len)
-- 
2.48.1


