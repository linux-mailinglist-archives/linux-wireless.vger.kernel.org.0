Return-Path: <linux-wireless+bounces-23450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AC6AC60C4
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 06:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4B81BA23FA
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 04:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE00E1922F4;
	Wed, 28 May 2025 04:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Nl6B++Vu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9431805E
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 04:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748406048; cv=none; b=NDBLRsZcq/1gA5/sJvaInF7gTEcX8SqLzOvcJ58dwql68nnhExwVWZ2IodTtdetQIEGt5uMt/mu4JV5TPtjLdVq6tUh7yNU8aV7Z4opHZwlXeor7jpZ/hIAWYOyskABufKrfs2AypnE+NAkwcklr0U+CsyVXJOO8+4YEOVcvVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748406048; c=relaxed/simple;
	bh=W58m0UjH9H/un1KSald9t5umxlIycG8QHnQIc81UfLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHogQF2oKqDGQ/5KF/0hwi9P2/nhhyqVn9EwFzx0EwQg42a05WRWzagCIYpGKuDhd3SanYJnoL/NjHSeT5TgmLdyjwuQIocExK1HhMCY+E50oKmb4RfUTjcYT4+SQbEqyg5Y7zJIc6Cxwavm+GcbGtcK9l6KLndnnKHL4DiJSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Nl6B++Vu; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 35DE23038FB
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 04:13:48 +0000 (UTC)
Received: from engine.ppe-hosted.com (unknown [10.110.50.113])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B0ED8600BB;
	Wed, 28 May 2025 04:13:41 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 838038006C;
	Wed, 28 May 2025 04:13:40 +0000 (UTC)
Received: from caracara.lan (71-212-32-17.tukw.qwest.net [71.212.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id DFE8913C2B0;
	Tue, 27 May 2025 21:13:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DFE8913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1748405619;
	bh=W58m0UjH9H/un1KSald9t5umxlIycG8QHnQIc81UfLI=;
	h=From:To:Cc:Subject:Date:From;
	b=Nl6B++VuLZThXu/SIChgwa1pnijKtEkmz7qd0xglHM7i/fWKn6nPzzL8UkSfvsD4/
	 ZQZmei6DP0TnR5DyOpkaDqjgZpia+zhIq8mzUhv/RGzBzZ3am3VLlLC/Ik4epgJ2qE
	 +2vcllwKlcm4Y7YacnHUUwHomd/U1ML426+2+6Tw=
From: Alex Gavin <alex.gavin@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Alex Gavin <alex.gavin@candelatech.com>
Subject: [PATCH] iw: scan: Add partial Multi-Link element printing
Date: Tue, 27 May 2025 21:13:30 -0700
Message-ID: <20250528041330.83464-1-alex.gavin@candelatech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1748405621-fU2G4E-dSEN8
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1748405621;fU2G4E-dSEN8;<alex.gavin@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

Only print some basic items to start.

Minimum and maximum length values are computed from the
specification. Maximum only includes Common Info and
does not consider Link Info.

Signed-off-by: Alex Gavin <alex.gavin@candelatech.com>
---
 ieee80211.h |  1 +
 iw.h        |  1 +
 scan.c      |  8 ++++++++
 util.c      | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/ieee80211.h b/ieee80211.h
index c31041e..2e6b68b 100644
--- a/ieee80211.h
+++ b/ieee80211.h
@@ -100,6 +100,7 @@ enum elem_id_ext {
 	EID_EXT_HE_CAPABILITY		= 35,
 	EID_EXT_HE_OPERATION		= 36,
 	EID_EXT_EHT_OPERATION		= 106,
+	EID_EXT_MULTI_LINK     		= 107,
 	EID_EXT_EHT_CAPABILITY		= 108,
 };
 
diff --git a/iw.h b/iw.h
index a423431..145b058 100644
--- a/iw.h
+++ b/iw.h
@@ -247,6 +247,7 @@ void print_he_operation(const uint8_t *ie, int len);
 void print_he_info(struct nlattr *nl_iftype);
 void print_eht_capability(const uint8_t *ie, int len, const uint8_t *he_cap,
 			  bool from_ap);
+void print_multi_link(const uint8_t *ie, int len);
 void print_eht_operation(const uint8_t *ie, int len);
 void print_eht_info(struct nlattr *nl_iftype, int band);
 void print_s1g_capability(const uint8_t *caps);
diff --git a/scan.c b/scan.c
index 263d2e3..c1255f7 100644
--- a/scan.c
+++ b/scan.c
@@ -2426,6 +2426,13 @@ static void print_eht_capa(const uint8_t type, uint8_t len,
 	print_eht_capability(data, len, ctx->he_cap, ctx->from_ap);
 }
 
+static void _print_multi_link(const uint8_t type, uint8_t len, const uint8_t *data,
+			   const struct ie_context *ctx)
+{
+	printf("\n");
+	print_multi_link(data, len);
+}
+
 static void print_eht_oper(const uint8_t type, uint8_t len, const uint8_t *data,
 			   const struct ie_context *ctx)
 {
@@ -2437,6 +2444,7 @@ static const struct ie_print ext_printers[] = {
 	[EID_EXT_HE_CAPABILITY] = { "HE capabilities", print_he_capa, 21, 54, BIT(PRINT_SCAN), },
 	[EID_EXT_HE_OPERATION] = { "HE Operation", print_he_oper, 6, 15, BIT(PRINT_SCAN), },
 	[EID_EXT_EHT_CAPABILITY] = { "EHT capabilities", print_eht_capa, 13, 30, BIT(PRINT_SCAN), },
+	[EID_EXT_MULTI_LINK] = { "Multi-Link", _print_multi_link, 5, 23, BIT(PRINT_SCAN), },
 	[EID_EXT_EHT_OPERATION] = { "EHT Operation", print_eht_oper, 5, 10, BIT(PRINT_SCAN), },
 };
 
diff --git a/util.c b/util.c
index 3345d95..34acf48 100644
--- a/util.c
+++ b/util.c
@@ -1934,6 +1934,65 @@ void print_he_operation(const uint8_t *ie, int len)
 	}
 }
 
+void print_multi_link(const uint8_t *ie, int len)
+{
+	uint16_t eml_capa = 0;
+	uint16_t mld_capa = 0;
+
+	uint16_t presence_bitmap = (ie[1] << 8) | ie[0];
+	bool link_id_info_present      = presence_bitmap & 0x0010;
+	bool bss_param_change_present  = presence_bitmap & 0x0020;
+	bool medium_sync_delay_present = presence_bitmap & 0x0040;
+	bool eml_capabilities_present  = presence_bitmap & 0x0080;
+	bool mld_capabilities_present  = presence_bitmap & 0x0100;
+
+	uint8_t common_info_len = ie[2] - 1;  // Account for length value includes byte storing length
+	uint8_t offset = 3;
+
+	char mld_mac[20];
+	mac_addr_n2a(mld_mac, (void*)ie+offset);
+	printf("\t\tMLD MAC: %s\n", mld_mac);
+	offset += 6;
+
+	// Link ID Info
+	if (offset < common_info_len && link_id_info_present) {
+		printf("\t\tLink ID: %d\n", ie[offset] & 0xF);
+		offset += 1;
+	}
+
+	// BSS Parameters Change Count
+	if (offset < common_info_len && bss_param_change_present)
+		offset += 1;
+
+	// Medium Synchronization Delay Information
+	if (offset < common_info_len && medium_sync_delay_present)
+		offset += 2;
+
+	// EML Capabilities
+	if (offset < common_info_len && eml_capabilities_present) {
+		eml_capa = (ie[offset+1] << 8) | ie[offset];
+		printf("\t\t\tEML Capabilities: 0x%04x\n", eml_capa);
+
+		if (eml_capa & 0x0001)
+			printf("\t\t\t\tEMLSR Support\n");
+		if (eml_capa & 0x0080)
+			printf("\t\t\t\tEMLMR Support\n");
+
+		offset += 2;
+	}
+
+	// MLD Capabilities and Operations
+	if (offset < common_info_len && mld_capabilities_present) {
+		mld_capa = (ie[offset+1] << 8) | ie[offset];
+		printf("\t\t\tMLD Capabilities and Operations: 0x%04x\n", mld_capa);
+
+		// This is zero-indexed (i.e. 0 means 1 simulataneous link, 1 means 2, etc)
+		printf("\t\t\t\tMaximum Number of Simulatenous Links: %d\n", mld_capa & 0xF);
+
+		offset += 2;
+	}
+}
+
 void print_eht_operation(const uint8_t *ie, int len)
 {
 	uint8_t oper_parameters = ie[0];
-- 
2.47.2


