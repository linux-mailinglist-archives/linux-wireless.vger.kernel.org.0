Return-Path: <linux-wireless+bounces-16120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6E19EA2D1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 00:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89182829A4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 23:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557BA1F709A;
	Mon,  9 Dec 2024 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="q2XR4fmP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C41BEF97
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786885; cv=none; b=Nl4XXt+A65nWsyHI8kYOYn7YpNq9DMbSS8D0ahII0UShFLaNL5z4ZGxS4SLBXy8w8nLqdDdnyMxv7c3pyQb6SbqXAR5ylFhYYib45LK44rV+JhW+H/HlINxkquRKjYYOMhTbtxi/7u+MyAO6y8ePi0wmGbwmbiShppiW2WAt3F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786885; c=relaxed/simple;
	bh=LAJTxltQOCkfCzsFFsgyOAfGCMwZwPGsCBlrLueBfjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4p5a/RRj/dFmtHD/gTspgE6mPcYUGLCHyRpQppbH9NqvGyqZad462l8A18ZYYABdX9KQ5uHDI/W+GqnUJrl1d7QiMHXXh8fEWuG0fo/In5gghVpwxR9VfkxcbSNh3seOaMnO1/RmLXOLsJ5gGW6nUgNBF6DY8LicuTK0QPC12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=q2XR4fmP; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 31C342C0078;
	Mon,  9 Dec 2024 23:27:55 +0000 (UTC)
Received: from corvid-conspiracy.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 8505113C2B3;
	Mon,  9 Dec 2024 15:27:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8505113C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1733786874;
	bh=LAJTxltQOCkfCzsFFsgyOAfGCMwZwPGsCBlrLueBfjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2XR4fmPXMcAHP8WwmzlLAcSJks40RNwzPWmEYVFyzrwE4+IYIS+FwHQ7R3+sRjyL
	 oHNkuV/qQikx66J5okdzHwDdyUsFbIeO3tWh/fALBSlxhab/zech4321mJ0x7iIifl
	 xLaEADVFGUyJQb3KJwed4rKUMZf2GyavFbzz/yIg=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH v5 2/2] iw: scan: add eht capability parsing
Date: Mon,  9 Dec 2024 15:27:50 -0800
Message-ID: <20241209232750.416604-3-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209232750.416604-1-dylan.eskew@candelatech.com>
References: <20241209232750.416604-1-dylan.eskew@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1733786876-XDRhfBs0tt0W
X-MDID-O:
 us5;at1;1733786876;XDRhfBs0tt0W;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

Add ability to print out EHT capabilities from
AP beacons.

Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
---
 ieee80211.h |  1 +
 scan.c      | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

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
diff --git a/scan.c b/scan.c
index 6cf44d2..395c7cb 100644
--- a/scan.c
+++ b/scan.c
@@ -556,6 +556,7 @@ static void tab_on_first(bool *first)
 
 struct ie_context {
 	bool is_vht_cap;
+	const uint8_t *he_cap;
 };
 
 static void print_ssid(const uint8_t type, uint8_t len, const uint8_t *data,
@@ -2393,12 +2394,21 @@ static void print_he_oper(const uint8_t type, uint8_t len, const uint8_t *data,
 	print_he_operation(data, len);
 }
 
+static void print_eht_capa(const uint8_t type, uint8_t len,
+			   const uint8_t *data, const struct ie_context *ctx)
+{
+	printf("\n");
+	print_eht_capability(data, len, ctx->he_cap);
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
@@ -2411,7 +2421,7 @@ static void print_extension(unsigned char len, unsigned char *ie,
 	tag = ie[0];
 	if (tag < ARRAY_SIZE(ext_printers) && ext_printers[tag].name &&
 	    ext_printers[tag].flags & BIT(ptype)) {
-		print_ie(&ext_printers[tag], tag, len - 1, ie + 1, NULL);
+		print_ie(&ext_printers[tag], tag, len - 1, ie + 1, ctx);
 		return;
 	}
 
@@ -2441,6 +2451,13 @@ static void init_context(struct ie_context *ctx,
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
@@ -2468,7 +2485,7 @@ void print_ies(unsigned char *ie, int ielen, bool unknown,
 		} else if (ie[0] == 221 /* vendor */) {
 			print_vendor(ie[1], ie + 2, unknown, ptype);
 		} else if (ie[0] == 255 /* extension */) {
-			print_extension(ie[1], ie + 2, unknown, ptype);
+			print_extension(ie[1], ie + 2, &ctx, unknown, ptype);
 		} else if (unknown) {
 			int i;
 
-- 
2.47.0


