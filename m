Return-Path: <linux-wireless+bounces-36772-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePWaGi2OD2pdNQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36772-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:58:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD75AC809
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 870E7300A3AC
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 22:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B56305E3B;
	Thu, 21 May 2026 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHRX2JOh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A220228CB0
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404331; cv=none; b=CqagAOy7gkYPrEiSQX/Dz+jwjPye7FJ2hNR3F7vv/eqnDdvTFGKTqlTXc3cLudB7FdOy9XyIrHOKveoCy0LBRiUaheqaM++c+uOoxyuwlL6wmXux451cresHsXlPt0fs3Haeo3ZSs0IuBlZjZJBgRTDqaJwhFXQ9jrSqOeWZrNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404331; c=relaxed/simple;
	bh=yZ7YD1RNqsG/o+o+xw5GYoW00J+X5r2COLBnsC85AtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/ru8rpPvSPqzaOORCp+IW6cho9XIyqcfoXIZ3cz0coynLMB+wynx6RqzUr+f6kKyty6zjdnUHEQBhYubIZGyuh9sJphugplAdzssLMM80G5qhtwMZWR8jQ/9wY1b00bvpRI7Wz+WYEVyDAqlA1BmAYcucLGFhi9igW//E6w9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHRX2JOh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b4583f0a1aso44123865ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 15:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779404329; x=1780009129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I87uRSw06X54uI5j8wWz6YkM6lWMVDeytbkVwWicYj0=;
        b=NHRX2JOhOE80E8PBDni06sngM/8MZC+59M4ZjZCcwElGhjnH9FKAsD5BXssjHKCRBN
         RYOPQAFifgmbad3apeMMB4bC6HyhcX+9LzGPUV7zbZguQLG6x6L/SNTqPgKdmMh473xr
         RcdlPcYg7Q5HeObnN4uc8wP0gE5n2eZV06jPw4PW2DqY2gTZT+wPDzijf72npUMdq718
         P1qbHD2ZCXuUQcQFYFceSqFiUJLiRGSbuFNoRRgdQfxAyxNJ0OSFhORbHsG5iOsBFU/7
         QpHkUIGB0lNlRLne2VZjC4Sd5VaTA0oC5OzAs5Uk1dMe975n038NZ3TCu/p4WDW9jgs0
         Pj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779404329; x=1780009129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I87uRSw06X54uI5j8wWz6YkM6lWMVDeytbkVwWicYj0=;
        b=gmTRSSglbosmRXOy0mxdq33T7rLHKhSPL3aNuUBkcsgUE1A2yU+hlytewl1oZ5S5CB
         yZ2SiNBhRlFDqCFMLqYJ+rFlglbf1rksjfRP5cHyCGT/qz5rTLCWnsFbZlK5WzLevQmu
         fziv1hFHJLK42owYSl4oZa5tyrDdTw78zC8BlNhI9I02TQSNuOZ9pBO+oN/iTn92Nusz
         r8Pe+ajAXoDTiqZRUqi05AkOnBiYkuRAXuhicpKONMKQRCzF2OuwnIUS/grrlPJ1ghPl
         YKpdp/tuFqsFhwKUxtvxLHEsKq0jhFq8B6iVnn8AkY4Q+4aebyobKovAf7a16hqNcszn
         jdbg==
X-Gm-Message-State: AOJu0YyFpwGqiy0viPFb7nhtkg7bnCkbV5l1ZC5QbXrTAXpKTU5xnhh5
	d/4DBtKv3oSqjiYbPazjTYg+34CLd0pb1lPspVzmDNcOXWgUAEc0AsWWIHvylw==
X-Gm-Gg: Acq92OEjcnZfwcp5oORT54v1SzfYl+iwkIsRRKfACovN4mgSCf8dNhJOtbE0JJKUhDL
	iE2Fbj25l64gn3CnYF/6tRSDG+JJVsmQtX7JAErQJS3H4J2yqsQdQ+KP4AeHqVKcWNVQa+ZG6fM
	Rw9TCMi1t5bm8LjNytgIugzTuWSu50v6VgVDpakAIyly5B0Wpn7A2jq7B9oMdDNBpocWlhaPcrp
	dmzl1mLneEYQL54Itev0UjWkBfJ7jO4ghSbP/G2jvXH83mEYaNs5JAPE6wuGJaqdGWcSlNnWrtL
	5lcj0Y4dMGTxN+nZgD/qCQdQjaa5ViJqtMwqjSzfOOlzN4XBE0YHs61A2LOrF78m7zaSvAhK8RP
	a4RL+LddUazmh4hDS6Yh4tP3Wh1BxHB1+HQh8TFZu96xU2y9C7ojv+hw0FYCL/4Tn4+GBtRmgN7
	Y=
X-Received: by 2002:a17:903:b84:b0:2bc:db35:96c7 with SMTP id d9443c01a7336-2beb07ed803mr7859715ad.28.1779404328925;
        Thu, 21 May 2026 15:58:48 -0700 (PDT)
Received: from ryzen9.. ([2001:ac8:40:25::19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb13d4c55sm2857855ad.70.2026.05.21.15.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:58:48 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v8 1/6] wifi: mac80211: Use struct instead of macro for PREQ frame
Date: Fri, 22 May 2026 07:58:37 +0900
Message-ID: <20260521225842.31815-1-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36772-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C3BD75AC809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing PREQ_IE_* macros access HWMP PREQ frame fields via hardcoded
byte offsets. When the AE (Address Extension) flag is set, an additional
6 bytes appear mid-frame, and the macros handle this with conditional
arithmetic (e.g., AE_F_SET(x) ? x + N+6 : x + N). This approach
obscures the frame layout and is prone to miscalculation.

Introduce typed packed C structs to represent the PREQ frame layout:
  - ieee80211_mesh_hwmp_preq_top: fixed fields before the optional AE
    address
  - ieee80211_mesh_hwmp_preq_bottom: fields after the optional AE address
  - ieee80211_mesh_hwmp_preq_target: per-target fields

Add ieee80211_mesh_hwmp_preq_get_bottom() to locate the bottom struct
correctly based on whether the AE flag is set.

This preparatory refactoring is needed to fix a 2-byte overread of
target_addr in hwmp_preq_frame_process() when AE is enabled, which is
addressed in a subsequent patch.

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 42 +++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 67 ++++++++++++++++------------------
 2 files changed, 74 insertions(+), 35 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 4b829bcb38b6..bf4a544aed00 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -28,12 +28,40 @@ struct ieee80211s_hdr {
 	u8 eaddr2[ETH_ALEN];
 } __packed __aligned(2);
 
+struct ieee80211_mesh_hwmp_preq_target {
+	u8 flags;
+	u8 addr[ETH_ALEN];
+	__le32 sn;
+} __packed;
+
+struct ieee80211_mesh_hwmp_preq_top {
+	u8 flags;
+	u8 hopcount;
+	u8 ttl;
+	__le32 preq_id;
+	u8 orig_addr[ETH_ALEN];
+	__le32 orig_sn;
+
+	/* optional AE, lifetime, metric, target */
+	u8 variable[];
+} __packed;
+
+struct ieee80211_mesh_hwmp_preq_bottom {
+	__le32 lifetime;
+	__le32 metric;
+	u8 target_count;
+	struct ieee80211_mesh_hwmp_preq_target targets[];
+} __packed;
+
 /* Mesh flags */
 #define MESH_FLAGS_AE_A4 	0x1
 #define MESH_FLAGS_AE_A5_A6	0x2
 #define MESH_FLAGS_AE		0x3
 #define MESH_FLAGS_PS_DEEP	0x4
 
+/* HWMP IE processing macros */
+#define AE_F			(1<<6)
+
 /**
  * enum ieee80211_preq_flags - mesh PREQ element flags
  *
@@ -227,4 +255,18 @@ enum ieee80211_root_mode_identifier {
 	IEEE80211_PROACTIVE_RANN = 4,
 };
 
+static inline bool ieee80211_mesh_preq_prep_ae_enabled(const u8 *ie)
+{
+	return ie[0] & AE_F;
+}
+
+static inline struct ieee80211_mesh_hwmp_preq_bottom *
+ieee80211_mesh_hwmp_preq_get_bottom(const u8 *ie)
+{
+	struct ieee80211_mesh_hwmp_preq_top *top = (void *)ie;
+
+	return (void *)&top->variable[
+		ieee80211_mesh_preq_prep_ae_enabled(ie) ? ETH_ALEN : 0];
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 9d89ebcce1c1..1a6a22b185d9 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -35,24 +35,11 @@ static inline u16 u16_field_get(const u8 *preq_elem, int offset, bool ae)
 }
 
 /* HWMP IE processing macros */
-#define AE_F			(1<<6)
 #define AE_F_SET(x)		(*x & AE_F)
-#define PREQ_IE_FLAGS(x)	(*(x))
-#define PREQ_IE_HOPCOUNT(x)	(*(x + 1))
-#define PREQ_IE_TTL(x)		(*(x + 2))
-#define PREQ_IE_PREQ_ID(x)	u32_field_get(x, 3, 0)
-#define PREQ_IE_ORIG_ADDR(x)	(x + 7)
-#define PREQ_IE_ORIG_SN(x)	u32_field_get(x, 13, 0)
-#define PREQ_IE_LIFETIME(x)	u32_field_get(x, 17, AE_F_SET(x))
-#define PREQ_IE_METRIC(x) 	u32_field_get(x, 21, AE_F_SET(x))
-#define PREQ_IE_TARGET_F(x)	(*(AE_F_SET(x) ? x + 32 : x + 26))
-#define PREQ_IE_TARGET_ADDR(x) 	(AE_F_SET(x) ? x + 33 : x + 27)
-#define PREQ_IE_TARGET_SN(x) 	u32_field_get(x, 33, AE_F_SET(x))
-
-
-#define PREP_IE_FLAGS(x)	PREQ_IE_FLAGS(x)
-#define PREP_IE_HOPCOUNT(x)	PREQ_IE_HOPCOUNT(x)
-#define PREP_IE_TTL(x)		PREQ_IE_TTL(x)
+
+#define PREP_IE_FLAGS(x)	(*(x))
+#define PREP_IE_HOPCOUNT(x)	(*(x + 1))
+#define PREP_IE_TTL(x)		(*(x + 2))
 #define PREP_IE_ORIG_ADDR(x)	(AE_F_SET(x) ? x + 27 : x + 21)
 #define PREP_IE_ORIG_SN(x)	u32_field_get(x, 27, AE_F_SET(x))
 #define PREP_IE_LIFETIME(x)	u32_field_get(x, 13, AE_F_SET(x))
@@ -415,11 +402,16 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 
 	switch (action) {
 	case MPATH_PREQ:
-		orig_addr = PREQ_IE_ORIG_ADDR(hwmp_ie);
-		orig_sn = PREQ_IE_ORIG_SN(hwmp_ie);
-		orig_lifetime = PREQ_IE_LIFETIME(hwmp_ie);
-		orig_metric = PREQ_IE_METRIC(hwmp_ie);
-		hopcount = PREQ_IE_HOPCOUNT(hwmp_ie) + 1;
+		struct ieee80211_mesh_hwmp_preq_top *preq_elem_top =
+			(void *)hwmp_ie;
+		struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =
+			ieee80211_mesh_hwmp_preq_get_bottom(hwmp_ie);
+
+		orig_addr = preq_elem_top->orig_addr;
+		orig_sn = le32_to_cpu(preq_elem_top->orig_sn);
+		orig_lifetime = le32_to_cpu(preq_elem_bottom->lifetime);
+		orig_metric = le32_to_cpu(preq_elem_bottom->metric);
+		hopcount = preq_elem_top->hopcount + 1;
 		break;
 	case MPATH_PREP:
 		/* Originator here refers to the MP that was the target in the
@@ -579,6 +571,11 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 				    const u8 *preq_elem, u32 orig_metric)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct ieee80211_mesh_hwmp_preq_top *preq_elem_top = (void *)preq_elem;
+	struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =
+		ieee80211_mesh_hwmp_preq_get_bottom(preq_elem);
+	struct ieee80211_mesh_hwmp_preq_target *target =
+		preq_elem_bottom->targets;
 	struct mesh_path *mpath = NULL;
 	const u8 *target_addr, *orig_addr;
 	const u8 *da;
@@ -589,13 +586,13 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 	bool root_is_gate;
 
 	/* Update target SN, if present */
-	target_addr = PREQ_IE_TARGET_ADDR(preq_elem);
-	orig_addr = PREQ_IE_ORIG_ADDR(preq_elem);
-	target_sn = PREQ_IE_TARGET_SN(preq_elem);
-	orig_sn = PREQ_IE_ORIG_SN(preq_elem);
-	target_flags = PREQ_IE_TARGET_F(preq_elem);
+	target_addr = target[0].addr;
+	orig_addr = preq_elem_top->orig_addr;
+	target_sn = le32_to_cpu(target[0].sn);
+	orig_sn = le32_to_cpu(preq_elem_top->orig_sn);
+	target_flags = target[0].flags;
 	/* Proactive PREQ gate announcements */
-	flags = PREQ_IE_FLAGS(preq_elem);
+	flags = preq_elem_top->flags;
 	root_is_gate = !!(flags & RANN_FLAG_IS_GATE);
 
 	mhwmp_dbg(sdata, "received PREQ from %pM\n", orig_addr);
@@ -655,7 +652,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (reply) {
-		lifetime = PREQ_IE_LIFETIME(preq_elem);
+		lifetime = le32_to_cpu(preq_elem_bottom->lifetime);
 		ttl = ifmsh->mshcfg.element_ttl;
 		if (ttl != 0) {
 			mhwmp_dbg(sdata, "replying to the PREQ\n");
@@ -673,22 +670,22 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 		u32 preq_id;
 		u8 hopcount;
 
-		ttl = PREQ_IE_TTL(preq_elem);
-		lifetime = PREQ_IE_LIFETIME(preq_elem);
+		ttl = preq_elem_top->ttl;
+		lifetime = le32_to_cpu(preq_elem_bottom->lifetime);
 		if (ttl <= 1) {
 			ifmsh->mshstats.dropped_frames_ttl++;
 			return;
 		}
 		mhwmp_dbg(sdata, "forwarding the PREQ from %pM\n", orig_addr);
 		--ttl;
-		preq_id = PREQ_IE_PREQ_ID(preq_elem);
-		hopcount = PREQ_IE_HOPCOUNT(preq_elem) + 1;
+		preq_id = le32_to_cpu(preq_elem_top->preq_id);
+		hopcount = preq_elem_top->hopcount + 1;
 		da = (mpath && mpath->is_root) ?
 			mpath->rann_snd_addr : broadcast_addr;
 
 		if (flags & IEEE80211_PREQ_PROACTIVE_PREP_FLAG) {
-			target_addr = PREQ_IE_TARGET_ADDR(preq_elem);
-			target_sn = PREQ_IE_TARGET_SN(preq_elem);
+			target_addr = target[0].addr;
+			target_sn = le32_to_cpu(target[0].sn);
 		}
 
 		mesh_path_sel_frame_tx(MPATH_PREQ, flags, orig_addr,
-- 
2.43.0


