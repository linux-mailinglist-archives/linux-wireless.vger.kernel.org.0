Return-Path: <linux-wireless+bounces-36752-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N5CIyvNDmpoCQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36752-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:15:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FEE5A20EA
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 541FC3029A52
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5693603EC;
	Thu, 21 May 2026 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRyxhKDx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A12DB7BF
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353814; cv=none; b=g+oWG1YRk5q5WmlZeCps2GUWvfXON56cTn4m8iPqojlTy7pozR/l4mTmFsDOe7Dy9JzFv2Oa2sf58sr8Q0dDIv/iUhWNeAP7EqLxc6co3RuFO8uZgSAEDG4LdeG15+7Em7hQDV4GUxMwzT2ETyUWGPLXOakejOpFwurB8+BNAQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353814; c=relaxed/simple;
	bh=y2b6+gu/N8NJ1tSWrPTcZfUNIXdNC/z1gwF19w+o10Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udgREqQR5CLAnv6OQjuV/VlWe5hVuAqQSfI0IGus+o4AUxALJspuvBCgX8ogMm9o4jCpFfHP19BEVX8OLL5mz/V6KQB9d3Mg8fhLvFdTi2RvroXbgkVmYx/2KPqm1zK8LmDM26mCop1yO4Lg9KKRlzVjKXChe96NZp4jpubx5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRyxhKDx; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8025aecc40so2944134a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 01:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779353812; x=1779958612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88KX2FZ/PwR2YN0u/Jl9KcapB87WTNI/MjzE2T39KHg=;
        b=fRyxhKDxjXuZWjN3O5OWGs3QlIwp31kRSinh4Mtm62IFb9gtRgLE1aHvQHd7crdTbZ
         xpFvC4rpZwB6L+9c/jQxSTyrMi4FQTGr8SGz6l0dLb29zAIpRvKO0CGN0IcT/gbk0AFG
         pW6quSM4ZT8hVItf9eHgo+oCKpKkM/aSdd3da7Ygviy8eMlQLAimP5eHPXC/jTxi82Fe
         n3WzSRtUcInuWdxD6Cye+RHrMikXKO7J0xplI6UG7ASJDELj9RHGdQvAa0oF+ZY3QsCe
         oQ4QOF+4BM7jDaN78hWHLbxvxkT1ulGazG1jVFTgbk4SsW3Ixa+TbSY5C+VX78qgyd1u
         zj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353812; x=1779958612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88KX2FZ/PwR2YN0u/Jl9KcapB87WTNI/MjzE2T39KHg=;
        b=J9awQvB7WMAoiuCpivsTBudeex25kDnvH59d1RqZ96VoUmSxoz7XBa2lQRlqKKkIgg
         wGYeaUDiDtAI6Sm1e4P69pQtw6qytdLJcIg9twH+sd7DyfeSezbgfteNl34kTLvOTUuW
         dIoXeNbuSq2fRN282vhnLIOzPJsIUdpUQd/sh4AcNDEmus6TRyLQVB2TlRRlLJXePHqX
         sncX15J9iCMS62d95XnJ46quKpmIvUGem3e9mVbAhgZ9TsrIpUH77aIzhfg3U9WDXEgl
         +Z7c+Y4aioILLxbMRDb2R+AgOP1ED7SBs4pocoNO0y/EgRk9Xrxm4fI5OB7Yzezsa/0W
         a7+g==
X-Gm-Message-State: AOJu0Yzmyrc8WWdyi7ROQn7GHlOAwMKccEljt2rUeZarfBIG/v+uGa58
	noMrrXpvLpn5mw/L8ObBWTpeMoAyKHCMXcp7XEpqlttjfmknuW06RMW5WOj0xQ==
X-Gm-Gg: Acq92OH7+BXNaJJlTAtKJ6aq33EsVL2Jtj5V3cfWPfCP/qPtYUmIOQLL01zO7akykKZ
	NawNtO/d+5yN6idPVrKRH+idJEcCXJXQcpF7ANHzEvIurWFsQnrKzzx65fX9xCIZxeJx27hitkL
	55XPWEOKwVLYa50bc64gl9OHH/hlNIf65JKiFQK/bw/9krIvCCW9WezyPPhCre+5IHPGZXY9o8k
	LKAr5FvUGyEf1X6m5YtQ+PlB46M3968s/HpK9GnMBZ74icBFtbv2Efs17E184gRVdKGx7bMM6oz
	w5Uac8VGHP7YW1PzKZODySDUXOmug7RkIJzKKHUSnczB6GzpKNPgx4JLKEsTLzReJysvwQDf20U
	ZUdjp0ANrl1hcP/ZNqZ4lPEdJE6iPM5hL7fNiz0ny0gmSRuPtXYvQaTvgQn9XymmBhRjmRYKL6K
	B9DVN7X7d8VCxc7ZdSw+M7V6aObplI9Iteb0wRaQKwjmiUfio=
X-Received: by 2002:a05:6300:6d84:20b0:39f:2af3:e8ee with SMTP id adf61e73a8af0-3b308301a46mr1146711637.13.1779353811964;
        Thu, 21 May 2026 01:56:51 -0700 (PDT)
Received: from ryzen9.. (11.9.30.125.dy.iij4u.or.jp. [125.30.9.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062695sm21463091a12.4.2026.05.21.01.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:56:51 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v7 1/6] wifi: mac80211: Use struct instead of macro for PREQ frame
Date: Thu, 21 May 2026 17:56:42 +0900
Message-ID: <20260521085647.394151-1-masashi.honma@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36752-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 03FEE5A20EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation for subsequent patches.

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


