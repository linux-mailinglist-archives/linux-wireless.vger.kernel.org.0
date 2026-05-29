Return-Path: <linux-wireless+bounces-37160-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PLXMc0cGmo+1ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37160-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:10:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A9E609A17
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 364E430094F7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 23:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA1377023;
	Fri, 29 May 2026 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8zO87yV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918CA368D42
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096201; cv=none; b=Y4+tzK6m4N+k9QF/w/QH4L8rBDXrtVkyUZmNdUvRD2be3fm/+8NeXYBZqTqgS+UwJy9rIgjdxtyhbaDLzdGDy4HDF3MW7sw14G0+0DcOSVgKr+65yochG+TubrT898dl+enN2vUdu9JNRs36xrIQp/ldmYq028gLtWim/2bMHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096201; c=relaxed/simple;
	bh=+pBcasRET159BrHqRKvtad23IZvPmH8Gz9pzYQzgil8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvAPgT4+xWTSFQJzUypMCPros6aD58qmmE3PNMUbXRbExmbuu8WwtV55qXmq+XQs3vG5B/B1jr6HJTp2RcvLrYQDKLMldUl0YuG3xjy2jstDCANJuy8ZhfGs4Gp6S0pHI2JYO4/mwB8f027cGqyHAY0ohnVzWiFOCRsYRE8P8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8zO87yV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36b900f350fso1864917a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096200; x=1780701000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTwXWT9AFAg2xO0yG/i2y3xCcqpykRP3lNJWbcxtkGk=;
        b=K8zO87yVdQV14bO7L1n42Vyyfzer3gP7c2VjRO1DHqggWQ9CBFDJqOHsVdeTDreR4Y
         /o+3i00o32+7YtqlSzQJ18MbJYC/xnONFKA//vv5hPoTKGwZzV3W3SmDxpfvdr/YnaZi
         U78d4clNUSJym66ssCI+Oq5dr+PsQ43IhiIFYls5pnhSXnHiAV5c8OC+xup97bZog+u8
         vmx3k1F7+harvRzpi7LC1P1PF53j5qQPwc1Dlb+JX7OmvssXKlZ+7MEHi0Lw+Mv8eF+4
         j0rla3Fvtg0VsqKWZV/EGw4qlp3IxmvN7SjnFNhTpzotSv9zJgCkOUbzMgFLlYNzl0tZ
         7OhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096200; x=1780701000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTwXWT9AFAg2xO0yG/i2y3xCcqpykRP3lNJWbcxtkGk=;
        b=QGt8M68oF5FOA9fQwJWNlgnL/VUT4ire/nqeKNbxySUiJTnJnfEE9l1lMN/dEuDhLM
         0NSZAUcWCgdecAl9Sa9CF89sU989WJ9XjPwbFlyRNWyxZncULP3aqhAlykP5/BPc8BqV
         SwBavHFV1Pb2VsFpKG9SHHkBzvQZYXisI0+hGTolMNtjON5pJwtBkzRB7yfaDHbtwrZz
         BqxCjpQexv3N9/PTYC1oZ9RTwv0abYz/HQCoOCllrSr1FYv8fi8wcXM319+/Efj3KXmi
         yYB1177joYEE9p/oAF4HcIWOI7jda3pzyQkOVmF9YyUVJRuKfEWM1OT0B3qOR/+2z3BS
         zkpQ==
X-Gm-Message-State: AOJu0Yw0sBzLPJwb74r7YC/q8yVoJDdeqhtH7CehzuCxy949C6CCSetO
	CeBojyTQApBgI25otWqzpdYhtue5kmwYRgOlGxUa/LyE+6kYNWtiWPU2yMOqdw==
X-Gm-Gg: Acq92OHHNtr428ss6tShJc13QKBfAojUO5kzorOQ23dyO9L2nfVZwKcZf5rG57fd+6A
	y8+iLsTjQTDEtfBEc5R9ML6dwqDbZHdJnmOWeFsM8/v7HqM4KuxWLchEjH45So+IJxkTXxGdzRP
	Owxo6eVbuKlL8vNI8cfRoCurqOBc27cWYKGlF8nGiF+2IYU6Zslq6Ar/dhuw5Iu88YYRj/8vP0g
	YvgjaEnBbq182WvavzGhpGmnGHG2E46TdHFqlMrQcqf7/ECD9o0gHT2M5jnPTTy7+BKqsTySMth
	m9u3hDxM9FiSyssq75E9AtSuukhSbGf59hoAnawt/2tjW6rqYtFzKzCCX/hUV24Wr+x0K8V3P88
	0Lgnadf28A0Itr8XDwLzX0CY26leBXuTVwK8fQ/ieMZlEYn/vG85Ay3PT6evJW9xysdQbXHoH1L
	x4j9+farJbhX97q5el
X-Received: by 2002:a17:90b:4fca:b0:36a:bfe3:3d7 with SMTP id 98e67ed59e1d1-36c501b8fcamr1084998a91.14.1780096199828;
        Fri, 29 May 2026 16:09:59 -0700 (PDT)
Received: from ryzen9.. ([2a02:6ea0:d33b:6275::18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc10c8746sm2512632a91.0.2026.05.29.16.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 16:09:59 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v9 3/9] wifi: mac80211: Use struct instead of macro for PERR frame
Date: Sat, 30 May 2026 08:09:45 +0900
Message-ID: <20260529230952.124754-3-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529230952.124754-1-masashi.honma@gmail.com>
References: <20260529230952.124754-1-masashi.honma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37160-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 47A9E609A17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing PERR_IE_* macros access HWMP PERR frame fields via hardcoded
byte offsets. Each PERR destination entry contains an optional 6-byte AE
(Address Extension) address followed by a reason code, making offset-based
access error-prone.

Introduce typed packed C structs to represent the PERR frame layout:
  - ieee80211_mesh_hwmp_perr: top-level frame containing TTL and
    destination count
  - ieee80211_mesh_hwmp_perr_dst: per-destination entry with optional AE
    address and variable-position reason code

Add ieee80211_mesh_hwmp_perr_get_rcode() to locate the reason code in
each destination entry depending on whether the AE flag is set.

This refactoring makes the PERR processing code consistent with the
struct-based approach adopted for PREQ and PREP in preceding patches.

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 62 ++++++++++++++++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 31 +++--------------
 2 files changed, 67 insertions(+), 26 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 4ce4e47d6d01..f709263c310b 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -71,6 +71,21 @@ struct ieee80211_mesh_hwmp_prep_bottom {
 	__le32 orig_sn;
 } __packed;
 
+struct ieee80211_mesh_hwmp_perr_dst {
+	u8 flags;
+	u8 addr[ETH_ALEN];
+	__le32 sn;
+	/* optional Destination External Address */
+	u8 variable[];
+} __packed;
+
+struct ieee80211_mesh_hwmp_perr {
+	u8 ttl;
+	u8 number_of_dst;
+	/* Destinations */
+	u8 variable[];
+} __packed;
+
 /* Mesh flags */
 #define MESH_FLAGS_AE_A4 	0x1
 #define MESH_FLAGS_AE_A5_A6	0x2
@@ -296,4 +311,51 @@ ieee80211_mesh_hwmp_prep_get_bottom(const u8 *ie)
 		ieee80211_mesh_preq_prep_ae_enabled(ie) ? ETH_ALEN : 0];
 }
 
+static inline struct ieee80211_mesh_hwmp_perr_dst *
+ieee80211_mesh_hwmp_perr_get_dst(const u8 *ie, u8 dst_idx)
+{
+	struct ieee80211_mesh_hwmp_perr *perr_ie = (void *)ie;
+	struct ieee80211_mesh_hwmp_perr_dst *dst;
+	u8 *pos = perr_ie->variable;
+	int i;
+
+	for (i = 0; i < dst_idx + 1; i++) {
+		dst = (void *)pos;
+		pos += sizeof(struct ieee80211_mesh_hwmp_perr_dst) +
+			  ((dst->flags & AE_F) ? ETH_ALEN : 0)
+			  /* Destination External Address */ +
+			  2 /* Reason Code */;
+	}
+
+	return dst;
+}
+
+static inline u8 *
+ieee80211_mesh_hwmp_perr_get_addr(const u8 *ie, u8 dst_idx)
+{
+	struct ieee80211_mesh_hwmp_perr_dst *dst =
+		ieee80211_mesh_hwmp_perr_get_dst(ie, dst_idx);
+
+	return dst->addr;
+}
+
+static inline u32
+ieee80211_mesh_hwmp_perr_get_sn(const u8 *ie, u8 dst_idx)
+{
+	struct ieee80211_mesh_hwmp_perr_dst *dst =
+		ieee80211_mesh_hwmp_perr_get_dst(ie, dst_idx);
+
+	return le32_to_cpu(dst->sn);
+}
+
+static inline u16
+ieee80211_mesh_hwmp_perr_get_rcode(const u8 *ie, u8 dst_idx)
+{
+	struct ieee80211_mesh_hwmp_perr_dst *dst =
+		ieee80211_mesh_hwmp_perr_get_dst(ie, dst_idx);
+
+	return get_unaligned_le16(&dst->variable[
+		(dst->flags & AE_F) ? ETH_ALEN : 0]);
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 39b782370df0..378338778a23 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -20,29 +20,7 @@
 
 static void mesh_queue_preq(struct mesh_path *, u8);
 
-static inline u32 u32_field_get(const u8 *preq_elem, int offset, bool ae)
-{
-	if (ae)
-		offset += 6;
-	return get_unaligned_le32(preq_elem + offset);
-}
-
-static inline u16 u16_field_get(const u8 *preq_elem, int offset, bool ae)
-{
-	if (ae)
-		offset += 6;
-	return get_unaligned_le16(preq_elem + offset);
-}
-
 /* HWMP IE processing macros */
-#define AE_F_SET(x)		(*x & AE_F)
-
-#define PERR_IE_TTL(x)		(*(x))
-#define PERR_IE_TARGET_FLAGS(x)	(*(x + 2))
-#define PERR_IE_TARGET_ADDR(x)	(x + 3)
-#define PERR_IE_TARGET_SN(x)	u32_field_get(x, 9, 0)
-#define PERR_IE_TARGET_RCODE(x)	u16_field_get(x, 13, 0)
-
 #define MSEC_TO_TU(x) (x*1000/1024)
 #define SN_GT(x, y) ((s32)(y - x) < 0)
 #define SN_LT(x, y) ((s32)(x - y) < 0)
@@ -774,6 +752,7 @@ static void hwmp_perr_frame_process(struct ieee80211_sub_if_data *sdata,
 				    const u8 *perr_elem)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct ieee80211_mesh_hwmp_perr *perr_elem_s = (void *)perr_elem;
 	struct mesh_path *mpath;
 	u8 ttl;
 	const u8 *ta, *target_addr;
@@ -781,15 +760,15 @@ static void hwmp_perr_frame_process(struct ieee80211_sub_if_data *sdata,
 	u16 target_rcode;
 
 	ta = mgmt->sa;
-	ttl = PERR_IE_TTL(perr_elem);
+	ttl = perr_elem_s->ttl;
 	if (ttl <= 1) {
 		ifmsh->mshstats.dropped_frames_ttl++;
 		return;
 	}
 	ttl--;
-	target_addr = PERR_IE_TARGET_ADDR(perr_elem);
-	target_sn = PERR_IE_TARGET_SN(perr_elem);
-	target_rcode = PERR_IE_TARGET_RCODE(perr_elem);
+	target_addr = ieee80211_mesh_hwmp_perr_get_addr(perr_elem, 0);
+	target_sn = ieee80211_mesh_hwmp_perr_get_sn(perr_elem, 0);
+	target_rcode = ieee80211_mesh_hwmp_perr_get_rcode(perr_elem, 0);
 
 	rcu_read_lock();
 	mpath = mesh_path_lookup(sdata, target_addr);
-- 
2.43.0


