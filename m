Return-Path: <linux-wireless+bounces-20577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63328A69832
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 19:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDEF8A80CB
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 18:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0256B20D4EA;
	Wed, 19 Mar 2025 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="NEBOmKjH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E1207DF1
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409572; cv=none; b=ucsfXj9U+uktYJG/tBu4eY7sEMiQ84Iw69Fjh2tv2k8sTQx4nYXgyxax1O1VJbtCUYGOnS3vlfqwxNj3JBidBeSBtJS/XbvdmFO9vMjFa9f1MWwWA6dfq/LEr8d+RcPLKmRTfBh9mHLOb6fQbs9xDOJNmLj0OtKmB7XlZfiTTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409572; c=relaxed/simple;
	bh=2ubWtw5Ij9/BJ3/5+2dsxukzEGfcln0TpU73iE7BI8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixaAkAVAZYtL9bUeQHJ4Kcfx4FyJVRtVmUM0mo4zt3jbN7JpmnP9YUhxcbBVbp3lY8H2mCmzST1foP+jcLBgnVkBNzISMxZlzavhvSOEin+0x26cr3ktAJlNMYHvmMzEv+cc1kUNdFP2YzvZTHKKRE/o1IBIW5ouDlkpyvLt9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=NEBOmKjH; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C87422C00A2;
	Wed, 19 Mar 2025 18:39:28 +0000 (UTC)
Received: from corvid-conspiracy.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 203B213C2B1;
	Wed, 19 Mar 2025 11:39:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 203B213C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1742409568;
	bh=2ubWtw5Ij9/BJ3/5+2dsxukzEGfcln0TpU73iE7BI8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NEBOmKjHdXnVZaW0HVh2R8FVk52gKC6GDp4tH+vE0HDqj/L4g1oG2RlvGodjzw/8X
	 OOewyHGY3zS26Ur/aBDZRPmCF2u7gN8vtZVIhbvtTPbI7LCIMSUT647BAEc+3WrIIh
	 NddQITSrIRAJWP9GB2exZYgLKPh+tXkZmvh+AjXA=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH iw v6 2/2] iw: scan: add eht capability parsing
Date: Wed, 19 Mar 2025 11:39:18 -0700
Message-ID: <20250319183918.1215853-3-dylan.eskew@candelatech.com>
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
X-MDID: 1742409569-aK_Z01e8i73M
X-MDID-O:
 us5;at1;1742409569;aK_Z01e8i73M;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

Add ability to print out EHT capabilities from
AP beacons.

Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
---
 ieee80211.h |  1 +
 iw.h        |  2 +-
 link.c      |  5 +++--
 scan.c      | 34 +++++++++++++++++++++++++++-------
 4 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/ieee80211.h b/ieee80211.h
index de05844..1e29371 100644
--- a/ieee80211.h
+++ b/ieee80211.h
@@ -99,6 +99,7 @@ enum elem_id {
 enum elem_id_ext {
 	EID_EXT_HE_CAPABILITY		= 35,
 	EID_EXT_HE_OPERATION		= 36,
+	EID_EXT_EHT_CAPABILITY		= 108,
 };
 
 #define SUITE(oui, id)  (((oui) << 8) | (id))
diff --git a/iw.h b/iw.h
index 8cbb971..b8caccd 100644
--- a/iw.h
+++ b/iw.h
@@ -277,7 +277,7 @@ enum print_ie_type {
 #define BIT(x) (1ULL<<(x))
 
 void print_ies(unsigned char *ie, int ielen, bool unknown,
-	       enum print_ie_type ptype);
+	       enum print_ie_type ptype, bool from_ap);
 
 void parse_bitrate(struct nlattr *bitrate_attr, char *buf, int buflen);
 void iw_hexdump(const char *prefix, const __u8 *data, size_t len);
diff --git a/link.c b/link.c
index a7ee963..20ab927 100644
--- a/link.c
+++ b/link.c
@@ -93,7 +93,7 @@ static int link_bss_handler(struct nl_msg *msg, void *arg)
 			if (bss[NL80211_BSS_INFORMATION_ELEMENTS])
 				print_ies(nla_data(bss[NL80211_BSS_INFORMATION_ELEMENTS]),
 					  nla_len(bss[NL80211_BSS_INFORMATION_ELEMENTS]),
-					  false, PRINT_LINK_MLO_MLD);
+					  false, PRINT_LINK_MLO_MLD, false);
 		}
 	} else {
 		memcpy(result->sta_addr, nla_data(bss[NL80211_BSS_BSSID]), 6);
@@ -121,7 +121,8 @@ static int link_bss_handler(struct nl_msg *msg, void *arg)
 	if (bss[NL80211_BSS_INFORMATION_ELEMENTS])
 		print_ies(nla_data(bss[NL80211_BSS_INFORMATION_ELEMENTS]),
 			  nla_len(bss[NL80211_BSS_INFORMATION_ELEMENTS]),
-			  false, result->mld ? PRINT_LINK_MLO_LINK : PRINT_LINK);
+			  false, result->mld ? PRINT_LINK_MLO_LINK : PRINT_LINK,
+			  false);
 
 	if (bss[NL80211_BSS_FREQUENCY_OFFSET])
 		freq_offset = nla_get_u32(bss[NL80211_BSS_FREQUENCY_OFFSET]);
diff --git a/scan.c b/scan.c
index 6cf44d2..a366184 100644
--- a/scan.c
+++ b/scan.c
@@ -555,7 +555,9 @@ static void tab_on_first(bool *first)
 }
 
 struct ie_context {
+	bool from_ap;
 	bool is_vht_cap;
+	const uint8_t *he_cap;
 };
 
 static void print_ssid(const uint8_t type, uint8_t len, const uint8_t *data,
@@ -2393,12 +2395,21 @@ static void print_he_oper(const uint8_t type, uint8_t len, const uint8_t *data,
 	print_he_operation(data, len);
 }
 
+static void print_eht_capa(const uint8_t type, uint8_t len,
+			   const uint8_t *data, const struct ie_context *ctx)
+{
+	printf("\n");
+	print_eht_capability(data, len, ctx->he_cap, ctx->from_ap);
+}
+
 static const struct ie_print ext_printers[] = {
 	[EID_EXT_HE_CAPABILITY] = { "HE capabilities", print_he_capa, 21, 54, BIT(PRINT_SCAN), },
 	[EID_EXT_HE_OPERATION] = { "HE Operation", print_he_oper, 6, 15, BIT(PRINT_SCAN), },
+	[EID_EXT_EHT_CAPABILITY] = { "EHT capabilities", print_eht_capa, 13, 30, BIT(PRINT_SCAN), },
 };
 
 static void print_extension(unsigned char len, unsigned char *ie,
+			    const struct ie_context *ctx,
 			    bool unknown, enum print_ie_type ptype)
 {
 	unsigned char tag;
@@ -2411,7 +2422,7 @@ static void print_extension(unsigned char len, unsigned char *ie,
 	tag = ie[0];
 	if (tag < ARRAY_SIZE(ext_printers) && ext_printers[tag].name &&
 	    ext_printers[tag].flags & BIT(ptype)) {
-		print_ie(&ext_printers[tag], tag, len - 1, ie + 1, NULL);
+		print_ie(&ext_printers[tag], tag, len - 1, ie + 1, ctx);
 		return;
 	}
 
@@ -2426,7 +2437,7 @@ static void print_extension(unsigned char len, unsigned char *ie,
 }
 
 static void init_context(struct ie_context *ctx,
-			 unsigned char *ie, int ielen)
+			 unsigned char *ie, int ielen, bool from_ap)
 {
 	unsigned char *pos = ie;
 	int remaining = ielen;
@@ -2436,11 +2447,20 @@ static void init_context(struct ie_context *ctx,
 	if (!ie || !ielen)
 		return;
 
+	ctx->from_ap = from_ap;
+
 	while (remaining >= 2 && remaining - 2 >= pos[1]) {
 		switch (pos[0]) {
 		case EID_VHT_CAPABILITY:
 			ctx->is_vht_cap = true;
 			break;
+		case EID_EXTENSION:
+			switch (pos[2]) {
+			case EID_EXT_HE_CAPABILITY:
+				ctx->he_cap = pos + 3;
+				break;
+			}
+			break;
 		}
 
 		remaining -= pos[1] + 2;
@@ -2449,14 +2469,14 @@ static void init_context(struct ie_context *ctx,
 }
 
 void print_ies(unsigned char *ie, int ielen, bool unknown,
-	       enum print_ie_type ptype)
+	       enum print_ie_type ptype, bool from_ap)
 {
 	struct ie_context ctx;
 
 	if (!ie)
 		return;
 
-	init_context(&ctx, ie, ielen);
+	init_context(&ctx, ie, ielen, from_ap);
 
 	while (ielen >= 2 && ielen - 2 >= ie[1]) {
 		if (ie[0] < ARRAY_SIZE(ieprinters) &&
@@ -2468,7 +2488,7 @@ void print_ies(unsigned char *ie, int ielen, bool unknown,
 		} else if (ie[0] == 221 /* vendor */) {
 			print_vendor(ie[1], ie + 2, unknown, ptype);
 		} else if (ie[0] == 255 /* extension */) {
-			print_extension(ie[1], ie + 2, unknown, ptype);
+			print_extension(ie[1], ie + 2, &ctx, unknown, ptype);
 		} else if (unknown) {
 			int i;
 
@@ -2673,13 +2693,13 @@ static int print_bss_handler(struct nl_msg *msg, void *arg)
 			printf("\tInformation elements from Probe Response "
 			       "frame:\n");
 		print_ies(nla_data(ies), nla_len(ies),
-			  params->unknown, params->type);
+			  params->unknown, params->type, true);
 	}
 	if (bss[NL80211_BSS_BEACON_IES] && show--) {
 		printf("\tInformation elements from Beacon frame:\n");
 		print_ies(nla_data(bss[NL80211_BSS_BEACON_IES]),
 			  nla_len(bss[NL80211_BSS_BEACON_IES]),
-			  params->unknown, params->type);
+			  params->unknown, params->type, true);
 	}
 
 	return NL_SKIP;
-- 
2.48.1


