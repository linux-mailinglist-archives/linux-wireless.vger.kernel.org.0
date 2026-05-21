Return-Path: <linux-wireless+bounces-36773-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDLLHTWOD2pdNQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36773-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:59:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D044C5AC817
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797E0300A75B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20478305E3B;
	Thu, 21 May 2026 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii/AcMnv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F0367B64
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404333; cv=none; b=kc6xuQBbzvxnGUma71/PNANrFuDWWFyMavo0vPBc2NfTpqm5/3RyEK27BkhIWeQc67AxrC4aSyW2I8rgiS5TnYh+KlQ3jmfQYmdmVPN9dBGXGf9iwHLSGXz93BW9KiDaURd+9d1sVIH3HoujSQax7LHtnf0Toxlj3CwI8svEOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404333; c=relaxed/simple;
	bh=VvqF4T/8EEcgBzyT0BnIQpz/KDUj27IH3LU9uBv+XFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNCHQKec/bpsSqzkqvCarfDVn9JZpu4nBka+g07pkAiip4Rvv5A/ZKVahcq3yYgcNGBwgXAyjPinJRb3psyUxdHadX3tEFFS25Mql31kvl5/svuAQ1QG6maVzvhiQ28A0WYcJF6cN+aa+foBkdjUpgmZPzCEe3Fc/tXiAeVQsrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii/AcMnv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bc763e2ba8so32746485ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 15:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779404331; x=1780009131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlwonV3zkCmR7hyDyzrRyAolPyY5W/RQUTKxjPsR+x4=;
        b=Ii/AcMnvQ1Piw4llNK/4KqY6/+E2dsQzTik2saZZLIgxMy5w66AVMeQmUQvibGkdXy
         /VGpgRlmXornTxW0XVzANYGXgOf0uy1BNcsQVcZxjvZ4uJie5lE1aiKzx1VI4cqcKVsc
         rUezBpZ05iF6cO32q4ABahYWkVG/BajUQRrBW5Xre6YSy38/gLe6t/9VfdEuUEB58oZL
         sa8LWBzaykO3VTViqD+8LUZJgws+1qQ8u9xdQXzzw8bF4r23WN94bQuleRBrShyZ6Ld/
         bzmFfZu23U/AogdDIoaVVQMtmbInudqcTbbMc6/c5K7BzkAcavYFncyL4os1n1pMqD9X
         jBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779404331; x=1780009131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FlwonV3zkCmR7hyDyzrRyAolPyY5W/RQUTKxjPsR+x4=;
        b=R1pzfyVNG2ltoWeY3pPwOGPOA1ehEsCKD+WDxKKB6PZt2bEZJav/rf/pVHEk2pE5Lj
         Q39eOFut9H8QJBubJLN0CCDlbjx+Pq6Wi2UV1ttn3OslYnfRX8I/hmmHIdaIypchYviQ
         vyMZJA+E1ehxjB/cWiJZ2QU1XIZfhmwWypYSMJyLdYbrU0tgiqEkFosXv94o3Cna4ux5
         5WOq+0AwH+tvJf3oYVx49y4ErHZQeS9abAVTKPWHnNMQFDEPDS9cZuh6as+uMhHic70q
         Fi5avwbyTmHxisLIELcH+5JhwURviGsnOC+RbWpXLSFIBbmZNT+jmhGz1oXx5xZEYo75
         iVVw==
X-Gm-Message-State: AOJu0Yx1CSP9Z4eFYGuZGxP0cd0KJU48vMX8nTaXhK5D+MrHDgrOb6Te
	9cy4pP/QHUA36684PmQ1NHUkEQZvjb067g32gaUYBjLftMqgAjKpO0t2zD7sEQ==
X-Gm-Gg: Acq92OFuHrPEU41PHnTwjYRrsaXEBOu5uAOgNH7mBizU37Z4NTbK4uVKzl9YCmvb8ic
	JdHsqDESUYoD6+OYmU90gYQ8+jnJx/yaM9JPiYDUueIx5TKfVQjRZamOkb1kC+/0N9qmO6dSL2d
	Y36hVMZi3e5anajMIAJl+A0OVNG45+0dtNxwNExwS8pIzmnZ0ckj9QP8utV89oDH1TVlq+RT7c3
	PB3WdoEQxXk/CSvNwvEv3EggL0eAn6SEQvrUsO9QEKTMHn3eNuo1chDx1wvxi4yJndnPA6D2EwH
	9kbthmg7w0cPf3KLiq/kNmzdwx4xGgP01rodYzvijlGC+PfRoq0HK5Tbudh4Ojt3gVCXu8h63SG
	OllZNEby4dF+q3Pf2gQ0IioF4VJFPX2YfovM26ZXPzorfBpQZd01t+fjE2DY50sGLtgvz6e45mL
	A=
X-Received: by 2002:a17:902:f543:b0:2b2:57f3:8d07 with SMTP id d9443c01a7336-2beb069c06bmr7690155ad.7.1779404330838;
        Thu, 21 May 2026 15:58:50 -0700 (PDT)
Received: from ryzen9.. ([2001:ac8:40:25::19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb13d4c55sm2857855ad.70.2026.05.21.15.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:58:50 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v8 2/6] wifi: mac80211: Use struct instead of macro for PREP frame
Date: Fri, 22 May 2026 07:58:38 +0900
Message-ID: <20260521225842.31815-2-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521225842.31815-1-masashi.honma@gmail.com>
References: <20260521225842.31815-1-masashi.honma@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36773-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D044C5AC817
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


