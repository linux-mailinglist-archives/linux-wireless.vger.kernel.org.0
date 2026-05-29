Return-Path: <linux-wireless+bounces-37159-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNmtOjwdGmqx1ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37159-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:11:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E99F609A7D
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB320304B6B8
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E7439FCBC;
	Fri, 29 May 2026 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXsat0cB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9ED36C5BB
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096200; cv=none; b=XvE9BFQZczDnB/5syNpNdhyaWQoLlRFmD0r8I1WH60zhz88KaHI5Ij6nl6fZCtnt1//CyoOozXXnzSh+TGycFFkw/9qaUKt8CbRVbA49J3elnCNoPTGK3lSFW+/wKcODYO2q/DR9hISdG8CqWllt+wB5bxou7VgHHRGbk62ohtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096200; c=relaxed/simple;
	bh=VvqF4T/8EEcgBzyT0BnIQpz/KDUj27IH3LU9uBv+XFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lh2x/4Ja4GP8xcQRBdkwjcrRSEDO9lAtYkrYS0cAuzRQGRpNrvZ28zoI8nCJE7+ADZlbJ3wTLHayt2QU/9wIxWIEAfKNHvJKXj/51kUe5yL+O03eRbluDRrd+da9YOuwmbYX+Zrg1TCjt2nfjCG1Q25DrHs67c54zVP/+eh4dHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXsat0cB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b900f350fso1864904a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096198; x=1780700998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlwonV3zkCmR7hyDyzrRyAolPyY5W/RQUTKxjPsR+x4=;
        b=JXsat0cBq+WfLDRfe2vVvPnmZdp6IRFRZgiv5zIuLLWFpe1LARsPcUEVqOy/GCpgMu
         6jYQNxwvzPO9l8+NErqbnv7Yd/fedNZ1UmJ7vsmkBxGVadUdGlO4e/LnPuYGsPGzm1AN
         8dDisNgX/pY0+vvj3Nf8CAqaWYdtFx+dNpbo/xqOmtCu2vIRtC1A79QmobZy7xvcY2fX
         RsO6MO6i+gb5tu4CAsHMLDv4MSwdZi04qjDLZTPs9Cz5QJBHJi21lFmYY0xhP2jexD58
         I4Wv7RmRDUyxKaKkZowfiHcNZEPW/ZMOSOEXsRMfy2Cd8WIf9JZmZvofKbtKp2qnrdts
         w5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096198; x=1780700998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FlwonV3zkCmR7hyDyzrRyAolPyY5W/RQUTKxjPsR+x4=;
        b=U40fvs0R5S9ee8GgyFKzhuVOTYKhcTNBYm7diwPUxYO88vLoVjwjl88uOWfZLW0BeH
         fMA6KzoC/BsbhQf+tODBRAqFGWD5mDJmTAxYlp97z5k04X1pgpiy4IRwWtZRc2oCTSwK
         gQOOlTqLD9XtG12fl/JuvaulHjb+VKyZ//hV80U7Rlons/Sk4WoiTAUsjEBP1D/w4GuR
         gNKrOlbv5Q7i3WNvrQ2ExiBu64NgCwDQRmjtdJHfCdFIF47Sd6yZUN7UpfXlKc83L6WY
         qspknQKu6ix76VrgAiCwqSa5w2a1Wdv4kKh+D//SDNSGLpdtPPpkeEs2+mVvfE2tj75O
         h4YA==
X-Gm-Message-State: AOJu0YzGEUAA/djAITjs6QST3MRPvJdRwDClcpra2fEhEmFZmRoxSdEo
	RR3zFwk+IDNlw1LxroDDicl5fG0PNovhrDXQvmope1yT3Q8uZ9JA7CpW44uQqQ==
X-Gm-Gg: Acq92OFEWzVXDgvKH87Qz6Uixqx2rSsUdYiFpV7h7Q9SXsGhcSMMw6yFdR/c2InA3tY
	DHO2KY+9XhhWvgi11XV9seacQusyy3ueeSrI1l2kcIn6Xo4B+raKciM7WvwAyiCLCM/kck/lSmH
	2zl9Bl07Ir1IsrrKOxNj43DpTN2uuoF2gYQn5SVmcfERY0BhxS9xnnJWs6coAm2uVaQaZTnn5HF
	zef39v64l1l+sl0K/1ou5vYdt36n3WYOBVM85yrt6IK5HGlCAEmFdhEobjdQ3PBeGl6COdaf6R5
	/1heVav6HtbU4ytPFnnzAgWLMjmGAXb9xHyqTkxtlCuAdU2FLfA5kX9pqNSFPPrlXUVvvOQ5pme
	nMTxNh2bFkkUzPT2yR6nZyK8BBkXYOkZYX81rXYy4jMKs2ifsuCh/ZTijrJK3fjsqD2nf65aY6a
	hlT3dcoKK7vgfqPfmA
X-Received: by 2002:a17:90b:5748:b0:36b:93e6:1184 with SMTP id 98e67ed59e1d1-36c6847f81fmr1053002a91.27.1780096198547;
        Fri, 29 May 2026 16:09:58 -0700 (PDT)
Received: from ryzen9.. ([2a02:6ea0:d33b:6275::18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc10c8746sm2512632a91.0.2026.05.29.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 16:09:58 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v9 2/9] wifi: mac80211: Use struct instead of macro for PREP frame
Date: Sat, 30 May 2026 08:09:44 +0900
Message-ID: <20260529230952.124754-2-masashi.honma@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37159-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 4E99F609A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing PREP_IE_* macros access HWMP PREP frame fields via hardcoded
byte offsets. When the AE (Address Extension) flag is set, an additional
6 bytes appear mid-frame, making the offset arithmetic error-prone.

Introduce typed packed C structs to represent the PREP frame layout:
  - ieee80211_mesh_hwmp_prep_top: fixed fields before the optional AE
    address
  - ieee80211_mesh_hwmp_prep_bottom: fields after the optional AE address

Add ieee80211_mesh_hwmp_prep_get_bottom() to locate the bottom struct
correctly based on whether the AE flag is set.

This preparatory refactoring is needed to fix a 2-byte overread of
orig_addr in hwmp_prep_frame_process() when AE is enabled, which is
addressed in a subsequent patch.

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 27 ++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 46 ++++++++++++++++------------------
 2 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index bf4a544aed00..4ce4e47d6d01 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -53,6 +53,24 @@ struct ieee80211_mesh_hwmp_preq_bottom {
 	struct ieee80211_mesh_hwmp_preq_target targets[];
 } __packed;
 
+struct ieee80211_mesh_hwmp_prep_top {
+	u8 flags;
+	u8 hopcount;
+	u8 ttl;
+	u8 target_addr[ETH_ALEN];
+	__le32 target_sn;
+
+	/* optional Target External Address */
+	u8 variable[];
+} __packed;
+
+struct ieee80211_mesh_hwmp_prep_bottom {
+	__le32 lifetime;
+	__le32 metric;
+	u8 orig_addr[ETH_ALEN];
+	__le32 orig_sn;
+} __packed;
+
 /* Mesh flags */
 #define MESH_FLAGS_AE_A4 	0x1
 #define MESH_FLAGS_AE_A5_A6	0x2
@@ -269,4 +287,13 @@ ieee80211_mesh_hwmp_preq_get_bottom(const u8 *ie)
 		ieee80211_mesh_preq_prep_ae_enabled(ie) ? ETH_ALEN : 0];
 }
 
+static inline struct ieee80211_mesh_hwmp_prep_bottom *
+ieee80211_mesh_hwmp_prep_get_bottom(const u8 *ie)
+{
+	struct ieee80211_mesh_hwmp_prep_top *top = (void *)ie;
+
+	return (void *)&top->variable[
+		ieee80211_mesh_preq_prep_ae_enabled(ie) ? ETH_ALEN : 0];
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 1a6a22b185d9..39b782370df0 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -37,16 +37,6 @@ static inline u16 u16_field_get(const u8 *preq_elem, int offset, bool ae)
 /* HWMP IE processing macros */
 #define AE_F_SET(x)		(*x & AE_F)
 
-#define PREP_IE_FLAGS(x)	(*(x))
-#define PREP_IE_HOPCOUNT(x)	(*(x + 1))
-#define PREP_IE_TTL(x)		(*(x + 2))
-#define PREP_IE_ORIG_ADDR(x)	(AE_F_SET(x) ? x + 27 : x + 21)
-#define PREP_IE_ORIG_SN(x)	u32_field_get(x, 27, AE_F_SET(x))
-#define PREP_IE_LIFETIME(x)	u32_field_get(x, 13, AE_F_SET(x))
-#define PREP_IE_METRIC(x)	u32_field_get(x, 17, AE_F_SET(x))
-#define PREP_IE_TARGET_ADDR(x)	(x + 3)
-#define PREP_IE_TARGET_SN(x)	u32_field_get(x, 9, 0)
-
 #define PERR_IE_TTL(x)		(*(x))
 #define PERR_IE_TARGET_FLAGS(x)	(*(x + 2))
 #define PERR_IE_TARGET_ADDR(x)	(x + 3)
@@ -419,11 +409,16 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 		 * so that we can easily use a single function to gather path
 		 * information from both PREQ and PREP frames.
 		 */
-		orig_addr = PREP_IE_TARGET_ADDR(hwmp_ie);
-		orig_sn = PREP_IE_TARGET_SN(hwmp_ie);
-		orig_lifetime = PREP_IE_LIFETIME(hwmp_ie);
-		orig_metric = PREP_IE_METRIC(hwmp_ie);
-		hopcount = PREP_IE_HOPCOUNT(hwmp_ie) + 1;
+		struct ieee80211_mesh_hwmp_prep_top *prep_elem_top =
+			(void *)hwmp_ie;
+		struct ieee80211_mesh_hwmp_prep_bottom *prep_elem_bottom =
+			ieee80211_mesh_hwmp_prep_get_bottom(hwmp_ie);
+
+		orig_addr = prep_elem_top->target_addr;
+		orig_sn = le32_to_cpu(prep_elem_top->target_sn);
+		orig_lifetime = le32_to_cpu(prep_elem_bottom->lifetime);
+		orig_metric = le32_to_cpu(prep_elem_bottom->metric);
+		hopcount = prep_elem_top->hopcount + 1;
 		break;
 	default:
 		rcu_read_unlock();
@@ -714,6 +709,9 @@ static void hwmp_prep_frame_process(struct ieee80211_sub_if_data *sdata,
 				    const u8 *prep_elem, u32 metric)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct ieee80211_mesh_hwmp_prep_top *prep_elem_top = (void *)prep_elem;
+	struct ieee80211_mesh_hwmp_prep_bottom *prep_elem_bottom =
+		ieee80211_mesh_hwmp_prep_get_bottom(prep_elem);
 	struct mesh_path *mpath;
 	const u8 *target_addr, *orig_addr;
 	u8 ttl, hopcount, flags;
@@ -721,9 +719,9 @@ static void hwmp_prep_frame_process(struct ieee80211_sub_if_data *sdata,
 	u32 target_sn, orig_sn, lifetime;
 
 	mhwmp_dbg(sdata, "received PREP from %pM\n",
-		  PREP_IE_TARGET_ADDR(prep_elem));
+		  prep_elem_top->target_addr);
 
-	orig_addr = PREP_IE_ORIG_ADDR(prep_elem);
+	orig_addr = prep_elem_bottom->orig_addr;
 	if (ether_addr_equal(orig_addr, sdata->vif.addr))
 		/* destination, no forwarding required */
 		return;
@@ -731,7 +729,7 @@ static void hwmp_prep_frame_process(struct ieee80211_sub_if_data *sdata,
 	if (!ifmsh->mshcfg.dot11MeshForwarding)
 		return;
 
-	ttl = PREP_IE_TTL(prep_elem);
+	ttl = prep_elem_top->ttl;
 	if (ttl <= 1) {
 		sdata->u.mesh.mshstats.dropped_frames_ttl++;
 		return;
@@ -750,12 +748,12 @@ static void hwmp_prep_frame_process(struct ieee80211_sub_if_data *sdata,
 	memcpy(next_hop, next_hop_deref_protected(mpath)->sta.addr, ETH_ALEN);
 	spin_unlock_bh(&mpath->state_lock);
 	--ttl;
-	flags = PREP_IE_FLAGS(prep_elem);
-	lifetime = PREP_IE_LIFETIME(prep_elem);
-	hopcount = PREP_IE_HOPCOUNT(prep_elem) + 1;
-	target_addr = PREP_IE_TARGET_ADDR(prep_elem);
-	target_sn = PREP_IE_TARGET_SN(prep_elem);
-	orig_sn = PREP_IE_ORIG_SN(prep_elem);
+	flags = prep_elem_top->flags;
+	lifetime = le32_to_cpu(prep_elem_bottom->lifetime);
+	hopcount = prep_elem_top->hopcount + 1;
+	target_addr = prep_elem_top->target_addr;
+	target_sn = le32_to_cpu(prep_elem_top->target_sn);
+	orig_sn = le32_to_cpu(prep_elem_bottom->orig_sn);
 
 	mesh_path_sel_frame_tx(MPATH_PREP, flags, orig_addr, orig_sn, 0,
 			       target_addr, target_sn, next_hop, hopcount,
-- 
2.43.0


