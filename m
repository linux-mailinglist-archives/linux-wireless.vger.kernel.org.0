Return-Path: <linux-wireless+bounces-36753-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GZENDHNDmpoCQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36753-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:15:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 461D65A20F5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 091653085D2A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475F535F191;
	Thu, 21 May 2026 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5+5p8GK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA835F5FB
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353815; cv=none; b=FjLC5ffBoA9kOFP8TWudZfPvJUz8AZTTvfyAJABlfgKTVpByHxMGBpXJ9mdXyR2AQMkDHnCW7nPf/0443apAbaPnhAdii9wac8coDGeNY/USOfC+m3FiXngNpsJv1qxhv61L5UABqTqMGgWyfp+qocgigmcBzNoR3aPvSEtvEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353815; c=relaxed/simple;
	bh=EgtF3cmhXDbFCQr7JowEKWdfQ5laS+hJGscijtnSoIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Em3iR49gOaM2M2tbtJ9hLDZKmDRP7kdbihb3uz6PHY/vus7vBd2FqkLZTElPJb5Cx68u5yZDLze7AWxrig63A6mPby1gRcBexHpu5VgJH3zlx2ey9xUz96MW+VkiUlZ3yz2b4rXLxnGND/BSRzdka4Gkl0HtU0t6VySkK7KJE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5+5p8GK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3697f25d26eso2989532a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779353813; x=1779958613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfrCZgB2bUuLsaPtDUVExJvqbQht1QIu8U0ZhAFYHIo=;
        b=a5+5p8GKwaTofKG4V9cL9vpxsLLfI+hUsJ2xGv/6WS72U0CyKbl2Mxc7HW2MTt04nd
         asPn9NaPMoxnQbvQL4aSJLYVwyk7mNm4tgE0j5thVJRzSjy/vD1172Hog0RMQNrwTpWK
         o++Pek41dQTrAYMCcaR2sNigcZki1tuAspuLiF9d42fHm39SARG8oqJ1S5UpJfQS1NCu
         ueTAj1wEmU1aZkpNOfxxeNjWs7i5YGAVCFLmJzG9NLKsN9LIeeTx/grHVl08iF1ngQ9V
         nM8oNYU8me2RHZJcSV2voobowmJdLwcPaemOWnKm6vZK/zaxwqU/RVNtxmWh5cIztODY
         iW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353813; x=1779958613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DfrCZgB2bUuLsaPtDUVExJvqbQht1QIu8U0ZhAFYHIo=;
        b=buFgXjwBkVSOTkiAAjqBgfdlz5zCSf0pN0EssA3coxcC/gHFxcImJuaU6yqKR6ikln
         rC8re3kf3r7RwfdupgEBtk5JKqXDokY5n/RswLvC5g904RApE00arhdEjkGtQE/n8XXU
         /dxuy+R1+p6FH1lZI7CdxoeYiqN64DoIgRF001vLnLvii4xdw9ie5GnYimcMPRchLOl8
         xtVeq9JEwARXQ8Ctcdbo7gHJWmdjh+yAOVf5/2sS02VcYJCUunpJYTcI0rXPRqg6onG1
         43uH1XKTbdrwDn8JW60UweEtyWx92a22CHsW2CzT8nI1gd7YpGJFchK3TAa4kg5zKpCb
         Z4Iw==
X-Gm-Message-State: AOJu0YwTIlYluUtBHpsv7Vi1rOe6uxCAfvGyIlmKXFr1Hb0zhC6x/wrr
	JfelNFy62W+MGXxsj78+yAuBeuCgBJmB/uO+3o91Fvqx6qXj66H5/9j7zCqBJg==
X-Gm-Gg: Acq92OGakyKk/WWagwFtJg9/xb4DpjvElYWD8piuFid8Iszfr7jLzXYWiRuhvPnTWC1
	6LehNm2nxl7JQsktZXx8cOaWljl5l7KF2SxWR1++ZYlVUGPB8WKxl8V6sOOLBEsLEjljkE2tmqo
	f4PxnOMuGl0X/xTy7NWGNa0zyRq5Jp2PpxTMzG9u/18QK8RV14fT/5FurbqvWB6sFO+TFx3EnMl
	jOHErgxdZ847ItIEz6Ak7ONI2l79rWu9BrPcoCG6wPpIjEWIJ4Sbac41B3BtCaiBaCi9JtxpjAH
	iB5bQdsDyz8rgnfeI9AruxI/3ilGcE3ZSFsNAZVO+bCWgEOFoHSwHOu91/GbltzeJuTMlL66Etu
	9W1MLobBjJ+UUlMIBG+W9e+09YrSe+KQenBLBGyd2bJJ6T40n7MMQQr9oB5+MRr2RBnH3IjnKv5
	b7I1TFp7EqP6MUOqSCLxoOYkR9NPxYWrHn4tokjLj3PPo9u34rjA86ejIZGw==
X-Received: by 2002:a17:90b:4b08:b0:368:a27f:9083 with SMTP id 98e67ed59e1d1-36a4515eb03mr2010639a91.7.1779353813190;
        Thu, 21 May 2026 01:56:53 -0700 (PDT)
Received: from ryzen9.. (11.9.30.125.dy.iij4u.or.jp. [125.30.9.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062695sm21463091a12.4.2026.05.21.01.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:56:52 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v7 2/6] wifi: mac80211: Use struct instead of macro for PREP frame
Date: Thu, 21 May 2026 17:56:43 +0900
Message-ID: <20260521085647.394151-2-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521085647.394151-1-masashi.honma@gmail.com>
References: <20260521085647.394151-1-masashi.honma@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36753-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 461D65A20F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation for subsequent patches.

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


