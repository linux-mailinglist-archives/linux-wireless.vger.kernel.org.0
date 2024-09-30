Return-Path: <linux-wireless+bounces-13336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E64198ABB4
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 20:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4038F1C2136E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93571990BB;
	Mon, 30 Sep 2024 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="kIOvc0/v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685F1991A4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719922; cv=none; b=S/YlLa2qQHLZvKBzTgLLF30QLryn/haI1jc6sYpUaNs5TpqTUmK8pgLoT62jUX2dvRt4484+kHw2g1vqH0OoG005bn5NumlSYdB9VY8n3CRxgCw4xiZswyshSwuSAX/hLHhX21MBOv10Ovo7U4gzIBG7bun9oRkprG8WUiteiAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719922; c=relaxed/simple;
	bh=vRnJwljawtfPv8ouyNb1H3nDmXV3KiPvy610bsOshYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdqIhIUUt7id/EfNww4fgRM5NrQQz0Nv4sFgIA4kr0jMRqxKjlroJ9iXOhAzdRo2oxbhn7mZWoCkWCMGJB6yeu5fEQrGFpnacUTUSJmvFT8kOuMPgepSpt9E3SbNLkLXdj2d5/0wJxCYy4lU0iAmFNnsxCeJ5YOe6KMUUYXegYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=kIOvc0/v; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8EBD8B00071;
	Mon, 30 Sep 2024 18:11:52 +0000 (UTC)
Received: from corvid-conspiracy.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2414B13C2B0;
	Mon, 30 Sep 2024 11:11:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2414B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1727719912;
	bh=vRnJwljawtfPv8ouyNb1H3nDmXV3KiPvy610bsOshYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kIOvc0/vGZEwYfLkenV97ifl2snZZRQvOyDcsywBTgYwPI8dZbj1MEAvkDgXj+jcG
	 sf0eNYd4QIgHZhYxMayiPv8dS9iCJmy8hZuHMJFXTrFthFxGHhWQgUOEhBjPijzeb9
	 jkf+dbhlO4q9QI0U/Df2h5EtOT0hL5nn2KSGVghY=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH 2/3] iw: scan: change parsing from in-place to cached
Date: Mon, 30 Sep 2024 11:11:44 -0700
Message-ID: <20240930181145.1043048-3-dylan.eskew@candelatech.com>
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
X-MDID: 1727719913-f4tLvD-GswC8
X-MDID-O:
 us5;ut7;1727719913;f4tLvD-GswC8;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

Since some ies require references to other ies, this
introduces the infrastructure to prevent double parsing
the ie buffer by caching the ie data rather than reading
it in-place.

Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
---
 ieee80211.h |  39 +++++++++++++++
 scan.c      | 138 +++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 142 insertions(+), 35 deletions(-)

diff --git a/ieee80211.h b/ieee80211.h
index 96d5c52..dc14096 100644
--- a/ieee80211.h
+++ b/ieee80211.h
@@ -101,6 +101,45 @@ enum elem_id_ext {
 	EID_EXT_HE_CAPABILITY = 35,
 };
 
+struct ieee80211_elems {
+	const __u8 *ie_start;
+	size_t total_length;
+
+	__u8 seen[32];
+	__u8 seen_ext[32];
+
+	const __u8 *ies[NUM_IES];
+	const __u8 *ies_ext[NUM_IES];
+
+	/* payload lengths of each ie */
+	__u8 lengths[NUM_IES];
+	__u8 lengths_ext[NUM_IES];
+};
+
+static inline void set_seen(struct ieee80211_elems *elems,
+			    const uint8_t type)
+{
+	elems->seen[type / 8] |= 1 << (type % 8);
+}
+
+static inline void set_seen_ext(struct ieee80211_elems *elems,
+				const uint8_t type)
+{
+	elems->seen_ext[type / 8] |= 1 << (type % 8);
+}
+
+static inline int was_seen(struct ieee80211_elems *elems,
+			   const uint8_t type)
+{
+	return elems->seen[type / 8] & (1 << (type % 8));
+}
+
+static inline int was_seen_ext(struct ieee80211_elems *elems,
+			       const uint8_t type)
+{
+	return elems->seen_ext[type / 8] & (1 << (type % 8));
+}
+
 #define SUITE(oui, id)  (((oui) << 8) | (id))
 
 /* cipher suite selectors */
diff --git a/scan.c b/scan.c
index 83b7f58..6fdaf0b 100644
--- a/scan.c
+++ b/scan.c
@@ -1782,6 +1782,12 @@ struct ie_print {
 	uint8_t flags;
 };
 
+struct element {
+	__u8 id;
+	__u8 datalen;
+	__u8 data[];
+} __attribute__ ((packed));
+
 static void print_ie(const struct ie_print *p, const uint8_t type, uint8_t len,
 		     const uint8_t *data,
 		     const struct print_ies_data *ie_buffer)
@@ -2332,7 +2338,7 @@ static const struct ie_print wfa_printers[] = {
 	[28] = { "OWE Transition Mode", print_wifi_owe_tarns, 7, 255, BIT(PRINT_SCAN), },
 };
 
-static void print_vendor(unsigned char len, unsigned char *data,
+static void print_vendor(unsigned char len, const unsigned char *data,
 			 bool unknown, enum print_ie_type ptype)
 {
 	int i;
@@ -2402,31 +2408,88 @@ static const struct ie_print ext_printers[] = {
 	[EID_EXT_HE_CAPABILITY] = { "HE capabilities", print_he_capa, 21, 54, BIT(PRINT_SCAN), },
 };
 
-static void print_extension(unsigned char len, unsigned char *ie,
-			    bool unknown, enum print_ie_type ptype)
+
+static void print_extension(bool unknown, struct ieee80211_elems *elems,
+			    enum print_ie_type ptype)
 {
-	unsigned char tag;
+	unsigned i;
 
-	if (len < 1) {
-		printf("\tExtension IE: <empty>\n");
+	if (elems == NULL)
 		return;
+
+	for (i = 0; i < NUM_IES; i++) {
+		if (!was_seen_ext(elems, i))
+			continue;
+
+		if (elems->lengths_ext[i] < 1) {
+			printf("\tExtension IE %u: <empty>\n", i);
+			continue;
+		}
+
+		if (i < ARRAY_SIZE(ext_printers) &&
+		    ext_printers[i].name &&
+		    ext_printers[i].flags & BIT(ptype) &&
+		    elems->lengths_ext[i] > 0) {
+			print_ie(&ext_printers[i], i, elems->lengths_ext[i] - 1,
+				 elems->ies_ext[i], NULL);
+		} else if (unknown) {
+			int j;
+
+			printf("\tUnknown Extension ID (%d):", i);
+			for (j = 1; j < elems->lengths_ext[i]; j++)
+				printf(" %.2x", elems->ies_ext[i][j]);
+			printf("\n");
+		}
 	}
+}
 
-	tag = ie[0];
-	if (tag < ARRAY_SIZE(ext_printers) && ext_printers[tag].name &&
-	    ext_printers[tag].flags & BIT(ptype)) {
-		print_ie(&ext_printers[tag], tag, len - 1, ie + 1, NULL);
+static void parse_ie_ext(const struct element *elem,
+			 struct ieee80211_elems *elems)
+{
+	const uint8_t type = elem->data[0];
+	const uint8_t *data = elem->data + 1;
+
+	if (!elem->datalen)
 		return;
-	}
 
-	if (unknown) {
-		int i;
+	set_seen_ext(elems, type);
 
-		printf("\tUnknown Extension ID (%d):", ie[0]);
-		for (i = 1; i < len; i++)
-			printf(" %.2x", ie[i]);
-		printf("\n");
+	elems->lengths_ext[type] = elem->datalen;
+
+	if (elem->datalen)
+		elems->ies_ext[type] = data;
+}
+
+static int parse_ies(unsigned char *ie, int ielen, bool unknown,
+		     struct ieee80211_elems *elems)
+{
+	const struct element *elem;
+
+	if (ie == NULL || ielen < 0 || elems == NULL)
+		return 1;
+
+	elems->ie_start = ie;
+	elems->total_length = ielen;
+
+	elem = (const struct element *)ie;
+	while (ielen >= 2 && ielen - 2 > elem->datalen) {
+		uint8_t id = elem->id;
+		uint8_t elen = elem->datalen;
+		const uint8_t *data = elem->data;
+
+		set_seen(elems, id);
+
+		if (id == EID_EXTENSION) {
+			parse_ie_ext(elem, elems);
+		} else if (elen) {
+			elems->lengths[id] = elen;
+			elems->ies[id] = data;
+		}
+
+		ielen -= elem->datalen + 2;
+		elem = (const struct element *)(elem->data + elem->datalen);
 	}
+	return 0;
 }
 
 void print_ies(unsigned char *ie, int ielen, bool unknown,
@@ -2435,31 +2498,36 @@ void print_ies(unsigned char *ie, int ielen, bool unknown,
 	struct print_ies_data ie_buffer = {
 		.ie = ie,
 		.ielen = ielen };
+	struct ieee80211_elems elems = { };
+	unsigned i;
 
-	if (ie == NULL || ielen < 0)
+	if (parse_ies(ie, ielen, unknown, &elems))
 		return;
 
-	while (ielen >= 2 && ielen - 2 >= ie[1]) {
-		if (ie[0] < ARRAY_SIZE(ieprinters) &&
-		    ieprinters[ie[0]].name &&
-		    ieprinters[ie[0]].flags & BIT(ptype) &&
-			    ie[1] > 0) {
-			print_ie(&ieprinters[ie[0]],
-				 ie[0], ie[1], ie + 2, &ie_buffer);
-		} else if (ie[0] == 221 /* vendor */) {
-			print_vendor(ie[1], ie + 2, unknown, ptype);
-		} else if (ie[0] == 255 /* extension */) {
-			print_extension(ie[1], ie + 2, unknown, ptype);
+	for (i = 0; i < NUM_IES; i++) {
+		if (!was_seen(&elems, i))
+			continue;
+
+		if (i < ARRAY_SIZE(ieprinters) &&
+		    ieprinters[i].name &&
+		    ieprinters[i].flags & BIT(ptype) &&
+		    elems.lengths[i] > 0) {
+			print_ie(&ieprinters[i], i, elems.lengths[i],
+				 elems.ies[i], &ie_buffer);
+		}
+		else if (i == EID_VENDOR) {
+			print_vendor(elems.lengths[i], elems.ies[i],
+				     unknown, ptype);
+		} else if (i == EID_EXTENSION) {
+			print_extension(unknown, &elems, ptype);
 		} else if (unknown) {
-			int i;
+			int j;
 
-			printf("\tUnknown IE (%d):", ie[0]);
-			for (i=0; i<ie[1]; i++)
-				printf(" %.2x", ie[2+i]);
+			printf("\tUnknown IE (%d):", i);
+			for (j = 0; j < elems.lengths[i]; j++)
+				printf("  %.2x", elems.ies[i][j]);
 			printf("\n");
 		}
-		ielen -= ie[1] + 2;
-		ie += ie[1] + 2;
 	}
 }
 
-- 
2.46.0


