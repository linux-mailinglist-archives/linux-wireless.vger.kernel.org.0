Return-Path: <linux-wireless+bounces-37158-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBvEMzMdGmqx1ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37158-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:11:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FA3609A75
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3141F3026F09
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8690A36C580;
	Fri, 29 May 2026 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZOAPTVb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EE8368D42
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096199; cv=none; b=ulooR9vPI4KmEnevCvnP4NSKfMWeEfN33m2p4BblxIixQco6z6cFyefnV+IjWdRMtZ2IPXVSfdKvagQVLRy+ldwF71DmGASS1j8nHOs878faGWS6WTwj2Nn3qhQrNZRA6ULk9U6QunepRt8+y+SJgZYTWA2pw1REUjbrDbJQ2wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096199; c=relaxed/simple;
	bh=yZ7YD1RNqsG/o+o+xw5GYoW00J+X5r2COLBnsC85AtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ml8VydEca+b2BwVjI7YRtjQXs98KRBWzo2HiN8mczFFyh2V4R4jw4cE9k6QA3G4FvWqwkfGb1C9ksAAWLWgbvsz/MytsUmEiHSDFlQUt7R07lWrWU2aMe/S8tMhClW2sTu5gcW/SvhnOINsrnL60H+1ZTErEtE/C9laHXvQCkzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZOAPTVb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b900f350fso1864896a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096197; x=1780700997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I87uRSw06X54uI5j8wWz6YkM6lWMVDeytbkVwWicYj0=;
        b=qZOAPTVbCTzD/h5mBJA5D75puPsV68UmPRywAIdK9TOjtkPUqLpocP/5TojkR46K+T
         QWqKLDURr2oVnDko4CVEWCBr88q+MGsHBai2bb3HX/xiB1n7LI1JEqtF4WmSIl6gk9cG
         Tay7AokvrPR00hf3IunkiY5ntz4+miCn9qb4XJ0UDVisAQmMmev1YfTSRomBHp5sU2tb
         jFk+0B60ZU/8WrVBHs4LGyZzn/t92YVYcA7GLatZMqLOPOpuPrxvEplxFB+tbfMp8rZV
         cTxGUlaEngI9T68BVv2DPFdCad1d5nuxp+rIkUiWiuZOXco7jpncRbdfj6OdAS1WYCmw
         r/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096197; x=1780700997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I87uRSw06X54uI5j8wWz6YkM6lWMVDeytbkVwWicYj0=;
        b=shuTlKgjXxjHDQ6NVQRm8RITm3Ix6Uq47XIBAho+ZIU34iOrBpFFEopafJmt5m0rvg
         BLNwIMBAm/n5zQ7fN7QkHwhqoU9iiHpM34GOhP/dtwthlVx7EJlc/ikfGddD/5X9O5bE
         f/PiUvneM0IR7KbGAaAVhU7jFWFg4nLc81bCWmEThE/7FOt9zngLB+D2GZkHaVPM9sfA
         yXP8YQVQdM5ZeShVeLtHTnpJZHHvFsQS68DMbO1ZSmWyNTuJedTHwogFrkHjXMC2sWhi
         KQo8aNSxK4wGnMHY6kR6hewJxnryY1PBkT32Cxn75ZfnZuphx1LsMmwb/pcI6yC092Lf
         y1ZQ==
X-Gm-Message-State: AOJu0YxSm+xfdEsjdPKEr2A4NysMA7OdFQBAP6T44mCWJbO5sX8gJ1qm
	ObLqQLQFdgj2VF0mhEvS1hxOyZHjAd4bdKvJlfk1PCN7PZVZuBAnfqw4PMiXSg==
X-Gm-Gg: Acq92OFaIbgA0BznQRPdxrnMDBa9KPF1mgLtM2ynKdwgiZW1UlbqKhrsxdUqqW1761D
	3omw2Wc2yo6KW2ki8U+S81AMguAviGxc6iKju165hWLWSP1yZjwqJtAGdxcr2iJAy2E7t2/+mcs
	Ym9ipclY7d/MxGwdKziYW/xOUSbNueJcJ0hPZ4V68vULVtaGHYdzp1MsRXqSwkXfWF3gpQ1dPZf
	Tk9Y3ybQmSYQqwW3SFFk64stIPbltip0DXTITTF/likSTHRY/zbN2WSXhV+Lmbmo1oLWTs++cWT
	TIuq9bfVBQ8jbNdxNkNWbshORVi3FsI3l2nNrmICvJI7LXtb72+1ZU5Rd5LFt4xXDxgkt0LEVXu
	kNwlNGzbzZpLdV1N/kpiofKfsk/HBc44Y79q/srb/KlQL2Vyb3/rCga1G1p8GdS7nDraBVJGvzV
	iTn93PDZjnYpsTMIGb
X-Received: by 2002:a17:90b:4ec5:b0:368:b724:6d53 with SMTP id 98e67ed59e1d1-36c4feebcb6mr1122501a91.4.1780096197263;
        Fri, 29 May 2026 16:09:57 -0700 (PDT)
Received: from ryzen9.. ([2a02:6ea0:d33b:6275::18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc10c8746sm2512632a91.0.2026.05.29.16.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 16:09:56 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v9 1/9] wifi: mac80211: Use struct instead of macro for PREQ frame
Date: Sat, 30 May 2026 08:09:43 +0900
Message-ID: <20260529230952.124754-1-masashi.honma@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37158-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 54FA3609A75
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


