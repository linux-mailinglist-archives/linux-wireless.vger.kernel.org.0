Return-Path: <linux-wireless+bounces-36501-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3bR8KIyuB2pHCQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36501-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 01:38:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCD45595EC
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 01:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D80A300D709
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 23:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8C43B9928;
	Fri, 15 May 2026 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj6ylv9f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE6374721
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888328; cv=none; b=Stz/3FktPdungYiL+1+nSenzQXu1WsiaVPO1rqCcpqa9w5JN9hECFJWM4PwT6frmmg4oQB4x/vcPHMrwT+c3JW3qd1zHTyEK/B+NLst70z9JOm2KWFTfv/GToY0FQq9LotlpHJ4HkSIrFrkdZQcoHp3XnzWTPtrZ/Di1u2ApCvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888328; c=relaxed/simple;
	bh=LoRCfLg0AHZ2MYa3ebdbkSAEcqh6hm8Ag9kJbAl7UNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLbblXB+ho8MKlwGdqKE6eFi2YMpYupvSDRRZdeCKGvXshd8toGHsrSAKdioGB7rtK94bsH+J7y9ct9Mi9PcpCxvKN8sTMwstc5i/tjd3YGvBJeB1nbDsDtiQvKyNkBIVeWaI2BEJ/VbkD8L33MVm8DfRbRnsee8lNpWTU1p7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj6ylv9f; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8021c8c42fso120958a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 16:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778888326; x=1779493126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6sOUdLvatoO+bd4UQMfPTkzDueoPEbHYCs1AXCRRaT0=;
        b=gj6ylv9f1Oc0a0F1eqbofxawIshVnrz1bTmzitA1SIHiZzN7K9lfdIlvglXiUEO/Ts
         gc7ls/7olugtbtxaBvaM+69JL3uAi0u76cV/sXGsLLj+rTgfrJCu6et0P+tdBeGQ0EnM
         eWLreB8K2E0kyyvp4mq1en7BejHqV8oEv9j4RVXm2Kr2Zky/IqPI3YbHFkY8KAZTaDE1
         cJgOMRibU5lIk+gFHd1+XlW84+dZsoNXPKW7J/zKn3ft8x8jkodfBgL7bucw59jRW7mi
         Dw26PwqjrzOx2kaE1ohQyOBvJdnCTCIg2Zt642hFInHvl7NrTh7B0nWuAQ4qojL4r14k
         2hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888326; x=1779493126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sOUdLvatoO+bd4UQMfPTkzDueoPEbHYCs1AXCRRaT0=;
        b=ByzCRQDYM1FYah4ZOh6HG+nJ9jDfYKKoaqfD9v0AUXqqF7EZsTlgKwhGz4epfnHc1k
         1ejttWC4FNq7nyiq0nn5U6S97u/h2+L5kKoOmPK8IyKgXSzXqrlXQiUErNytyvvwSAV/
         ftgtoA58vCtX2nIzHMrtGj/WmKymp6dKNwLS1C1xUIrVTF2W/ah777+eipP0Qu2bjZ5W
         oJqrCgRfcm/C2RvH3DxgKH+ey++3Vl3dsZuidPpw5sPF9yoqNaHxSnN58jc4DZVvNFuO
         gSANO8zBvDYGZhTuxXq3A+PMv6oJesoe3gH8Chp/334qYCKwOq0eJCaYaSHavAjyBrmB
         7GNg==
X-Gm-Message-State: AOJu0YxVMQ60+VGj9MkJfmVGjEUhuPorDWIGra3wAx5W8mbELtldV9om
	/SSzKmcMNljBk84K47p4fcLF1dDwi3QBmeO/RYvgD/R5zQj/TIGxca4Ao0b7jw==
X-Gm-Gg: Acq92OHe0C0jw7+bmCFjB6JiK42XzZlbTiu8sKK5D1sDxP0vgXnA3Ka9UQrQLpUs/2u
	rvaFt7TGQ31eBUnJ0fW/tnCM73eZ1ZVJSUkODXguXP5Ga00Jrg8RoO39HHJRfbe1fES0y9hOCdm
	4JDJCr7hG05KklSloO9+1ZJpmsxDbm9ZsnFojpmxUT1UVCcXCSIzQNATae/Dwm5qulAIXV8Ys1o
	DVNcmjy1tkx35rujFdDnfAr716AQ+Dw6FznzjuMErdGzg3J+PSM7zAb5li8/owbaz9+y3nxTHSp
	84d+D0vTl2KwPw/6OgQeegwXOrbh9BFVkx9TBT8X3Qa01IiB8n/hUS1WjRncBSll49cgh6yKxx4
	yuunNMlMg7aBuAV11nLc7HuM5NM30eUgHSTI0qBNR06RO6a+0QDP8V4GBPGvYWgAmTQL4D0r2WC
	mqqWxmViNk1w==
X-Received: by 2002:a05:6a20:734a:b0:39b:949d:6078 with SMTP id adf61e73a8af0-3b22e65291emr6709877637.6.1778888326148;
        Fri, 15 May 2026 16:38:46 -0700 (PDT)
Received: from ryzen9.. ([2001:ac8:40:25::15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb08d06csm6391265a12.14.2026.05.15.16.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:38:45 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v6 1/6] wifi: mac80211: Use struct instead of macro for PREQ frame
Date: Sat, 16 May 2026 08:38:34 +0900
Message-ID: <20260515233839.86829-1-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1BCD45595EC
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36501-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 43 +++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 68 +++++++++++++++++-----------------
 2 files changed, 76 insertions(+), 35 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 4b829bcb38b6..623894140300 100644
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
@@ -227,4 +255,19 @@ enum ieee80211_root_mode_identifier {
 	IEEE80211_PROACTIVE_RANN = 4,
 };
 
+static inline bool ieee80211_mesh_preq_prep_ae_enabled(const u8 *ie)
+{
+	return ie[0] & AE_F;
+}
+
+static inline struct ieee80211_mesh_hwmp_preq_bottom *
+	ieee80211_mesh_hwmp_preq_get_bottom(const u8 *ie)
+{
+	struct ieee80211_mesh_hwmp_preq_top *top =
+		(struct ieee80211_mesh_hwmp_preq_top *)ie;
+	return (struct ieee80211_mesh_hwmp_preq_bottom *)
+		&top->variable[ieee80211_mesh_preq_prep_ae_enabled(ie) ?
+			ETH_ALEN : 0];
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 9d89ebcce1c1..e0c8ba8cb1e0 100644
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
+			(struct ieee80211_mesh_hwmp_preq_top *)hwmp_ie;
+		struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =
+			ieee80211_mesh_hwmp_preq_get_bottom(hwmp_ie);
+
+		orig_addr = preq_elem_top->orig_addr;
+		orig_sn = get_unaligned_le32(&preq_elem_top->orig_sn);
+		orig_lifetime = get_unaligned_le32(&preq_elem_bottom->lifetime);
+		orig_metric = get_unaligned_le32(&preq_elem_bottom->metric);
+		hopcount = preq_elem_top->hopcount + 1;
 		break;
 	case MPATH_PREP:
 		/* Originator here refers to the MP that was the target in the
@@ -579,6 +571,12 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 				    const u8 *preq_elem, u32 orig_metric)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct ieee80211_mesh_hwmp_preq_top *preq_elem_top =
+		(struct ieee80211_mesh_hwmp_preq_top *)preq_elem;
+	struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =
+		ieee80211_mesh_hwmp_preq_get_bottom(preq_elem);
+	struct ieee80211_mesh_hwmp_preq_target *target =
+		preq_elem_bottom->targets;
 	struct mesh_path *mpath = NULL;
 	const u8 *target_addr, *orig_addr;
 	const u8 *da;
@@ -589,13 +587,13 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 	bool root_is_gate;
 
 	/* Update target SN, if present */
-	target_addr = PREQ_IE_TARGET_ADDR(preq_elem);
-	orig_addr = PREQ_IE_ORIG_ADDR(preq_elem);
-	target_sn = PREQ_IE_TARGET_SN(preq_elem);
-	orig_sn = PREQ_IE_ORIG_SN(preq_elem);
-	target_flags = PREQ_IE_TARGET_F(preq_elem);
+	target_addr = target[0].addr;
+	orig_addr = preq_elem_top->orig_addr;
+	target_sn = get_unaligned_le32(&target[0].sn);
+	orig_sn = get_unaligned_le32(&preq_elem_top->orig_sn);
+	target_flags = target[0].flags;
 	/* Proactive PREQ gate announcements */
-	flags = PREQ_IE_FLAGS(preq_elem);
+	flags = preq_elem_top->flags;
 	root_is_gate = !!(flags & RANN_FLAG_IS_GATE);
 
 	mhwmp_dbg(sdata, "received PREQ from %pM\n", orig_addr);
@@ -655,7 +653,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (reply) {
-		lifetime = PREQ_IE_LIFETIME(preq_elem);
+		lifetime = get_unaligned_le32(&preq_elem_bottom->lifetime);
 		ttl = ifmsh->mshcfg.element_ttl;
 		if (ttl != 0) {
 			mhwmp_dbg(sdata, "replying to the PREQ\n");
@@ -673,22 +671,22 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 		u32 preq_id;
 		u8 hopcount;
 
-		ttl = PREQ_IE_TTL(preq_elem);
-		lifetime = PREQ_IE_LIFETIME(preq_elem);
+		ttl = preq_elem_top->ttl;
+		lifetime = get_unaligned_le32(&preq_elem_bottom->lifetime);
 		if (ttl <= 1) {
 			ifmsh->mshstats.dropped_frames_ttl++;
 			return;
 		}
 		mhwmp_dbg(sdata, "forwarding the PREQ from %pM\n", orig_addr);
 		--ttl;
-		preq_id = PREQ_IE_PREQ_ID(preq_elem);
-		hopcount = PREQ_IE_HOPCOUNT(preq_elem) + 1;
+		preq_id = get_unaligned_le32(&preq_elem_top->preq_id);
+		hopcount = preq_elem_top->hopcount + 1;
 		da = (mpath && mpath->is_root) ?
 			mpath->rann_snd_addr : broadcast_addr;
 
 		if (flags & IEEE80211_PREQ_PROACTIVE_PREP_FLAG) {
-			target_addr = PREQ_IE_TARGET_ADDR(preq_elem);
-			target_sn = PREQ_IE_TARGET_SN(preq_elem);
+			target_addr = target[0].addr;
+			target_sn = get_unaligned_le32(&target[0].sn);
 		}
 
 		mesh_path_sel_frame_tx(MPATH_PREQ, flags, orig_addr,
-- 
2.43.0


