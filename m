Return-Path: <linux-wireless+bounces-36502-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Lc9AY+uB2pHCQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36502-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 01:38:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1E75595F3
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 01:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05BA530089AC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 23:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB9D3F86ED;
	Fri, 15 May 2026 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGrMtxRs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3F83F6C5C
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888330; cv=none; b=ft4XSySG2X9fC1UnKp22mQ82t99thWOkXPaANEPW+VdhEYPGetHZFadOpqqCo8vHQMO5xViYE90eBmTIF6K1cmoVecW4rM7O00TJ1vl7oVs+UwgzoEz51hF9KaxUscs74vtvNDYdqbiC12bDxNk0NNIrFYz7X0cWJ2HkJzJYoxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888330; c=relaxed/simple;
	bh=Qk/o8dm8gfP48zE+edda5l1hPQbwRwHPhqDncnQ4RJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jn4Rr29urituhSb43nIgtYI7hou1iABw01O0BNBCd/kRCGvdAS8POeA/DeJUclIcrZFOTLPNTg/BBBlDjgVFj6moArpADPYM7KYzYLbuIinR7GL9kr07zFuKaeWnubzeJr5DNmcNQkH5wgXnoNxbiGMpo0qb4zYRoxcjZrOTaQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGrMtxRs; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8027e876fcso134976a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 16:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778888328; x=1779493128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uM3naCc5Tgsif2ABS62NaMc6g/YYI4eXbtB+jDsNXo=;
        b=MGrMtxRssK2vcAXsJwHF0xo9vtu91BrCdKbhZIpLnZAsMGF6ldZnj6+6669ziYsJ7d
         A43oPlLt8+Jirv7lsUDNM56XXBevjbSz3IV8dxjpE+4pO0YuIzACsmr54SGTGJG9TxPp
         h8rrqXkcBZOkMa+rueZEJxn7q2DcFoWGUNhor5EMfFufnpkhn+5hpuCLtKdnn9gEIGD5
         F2KMm2f13kCAox6s4CD8+uSPAp4+BmcoDAEX68r1HE+IvpAwEuHslvTxbkNXGAmwOdY0
         TT//mFTZMsUMyvJohsKGOIQXJsotTi6JqEjLbZrOQ4iP6Kt5IAFyNA2u1kD8ToWui2FW
         2nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888328; x=1779493128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9uM3naCc5Tgsif2ABS62NaMc6g/YYI4eXbtB+jDsNXo=;
        b=LeI+aW6vKfICmzeOolMeTUr0gCyNYhx2T0LX0ZVRWx6eMcutCCkZFIzn2cCQAArvqU
         lNXJjWNGYkUVKEgAa9t1dwVZ6ZByA3liOkvCnxPcrAREZTmZQGFts07/txWsWYZIXgF6
         Cv8y445tuZhJIZ3HAr5plsKOvhfJKzloN/2V2SUDef1ddHUX9HCZQR7uMk5LbBdP7ajr
         +BhD80br70Ww8H+DecgMUEigqr9CrAOlfDhni9bOQkXG5iz2shUGNM1tV3qQIGMcjuj1
         tB3h67UM0c5IZBFskBZHno+R6FPNmya2PQTHXRJ5DgBGKg04/JLkiRHYDXed9oO0HwLo
         w75Q==
X-Gm-Message-State: AOJu0YzpGxnAbdGacNIkZofipxofPTNX3TCfZhK4kYK8sy/QNEANtkaf
	MByqOBSEEdLB/OivzJYNmZ+ZBKeJaCHb1Dzp25cPbotUrV2pis60yuyZpSAKTg==
X-Gm-Gg: Acq92OHqztR44TNGntdc+nT0M/PMBJEgRGkMhrXEipw0c6boLp1iRohwa0E+XWNi2nc
	JCy6F5zknxafJRFZigX/+LsxyLiVk1ScI3eZS1+P8Evym909TUggGUX04rQoWf2/X/RWAxdseGz
	QPtK861hduh4LBK2L/p/Ls7ycltECN4iTcodRk8JlSiDPsUJkFH01EtlDI6rC2Q1SrDlQwbKu4D
	ru8CZuFSR2rQPwwM9jafEeyHfTG2Fhmkg6ZVK76KN0/LB3i8Cr30uADSQo/IoG4DXOdx4zBQI2O
	8PrfXtQRNMTlWt6Zv/5haF1STNzsu3C+YyVfYUDEDH0G98kDjBPlp/G1Hm3Q+7bJafd2vD4ISL/
	1xpOac5dWhxstJLYiuD3yHtbhXfgoK2xZ5wUEasiOl+PGL2zMoL/sV6/KYSi60Fe+bExExs7tOQ
	4=
X-Received: by 2002:a05:6300:218e:b0:39b:fad0:6edc with SMTP id adf61e73a8af0-3b22e6682ecmr6457637637.6.1778888328046;
        Fri, 15 May 2026 16:38:48 -0700 (PDT)
Received: from ryzen9.. ([2001:ac8:40:25::15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb08d06csm6391265a12.14.2026.05.15.16.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:38:47 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v6 2/6] wifi: mac80211: Use struct instead of macro for PREP frame
Date: Sat, 16 May 2026 08:38:35 +0900
Message-ID: <20260515233839.86829-2-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515233839.86829-1-masashi.honma@gmail.com>
References: <20260515233839.86829-1-masashi.honma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8B1E75595F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36502-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 28 ++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 47 +++++++++++++++++-----------------
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 623894140300..093c6b80a983 100644
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
@@ -270,4 +288,14 @@ static inline struct ieee80211_mesh_hwmp_preq_bottom *
 			ETH_ALEN : 0];
 }
 
+static inline struct ieee80211_mesh_hwmp_prep_bottom *
+	ieee80211_mesh_hwmp_prep_get_bottom(const u8 *ie)
+{
+	struct ieee80211_mesh_hwmp_prep_top *top =
+		(struct ieee80211_mesh_hwmp_prep_top *)ie;
+	return (struct ieee80211_mesh_hwmp_prep_bottom *)
+		&top->variable[ieee80211_mesh_preq_prep_ae_enabled(ie) ?
+			ETH_ALEN : 0];
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index e0c8ba8cb1e0..d9394091cea9 100644
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
+			(struct ieee80211_mesh_hwmp_prep_top *)hwmp_ie;
+		struct ieee80211_mesh_hwmp_prep_bottom *prep_elem_bottom =
+			ieee80211_mesh_hwmp_prep_get_bottom(hwmp_ie);
+
+		orig_addr = prep_elem_top->target_addr;
+		orig_sn = get_unaligned_le32(&prep_elem_top->target_sn);
+		orig_lifetime = get_unaligned_le32(&prep_elem_bottom->lifetime);
+		orig_metric = get_unaligned_le32(&prep_elem_bottom->metric);
+		hopcount = prep_elem_top->hopcount + 1;
 		break;
 	default:
 		rcu_read_unlock();
@@ -715,6 +710,10 @@ static void hwmp_prep_frame_process(struct ieee80211_sub_if_data *sdata,
 				    const u8 *prep_elem, u32 metric)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct ieee80211_mesh_hwmp_prep_top *prep_elem_top =
+		(struct ieee80211_mesh_hwmp_prep_top *)prep_elem;
+	struct ieee80211_mesh_hwmp_prep_bottom *prep_elem_bottom =
+		ieee80211_mesh_hwmp_prep_get_bottom(prep_elem);
 	struct mesh_path *mpath;
 	const u8 *target_addr, *orig_addr;
 	u8 ttl, hopcount, flags;
@@ -722,9 +721,9 @@ static void hwmp_prep_frame_process(struct ieee80211_sub_if_data *sdata,
 	u32 target_sn, orig_sn, lifetime;
 
 	mhwmp_dbg(sdata, "received PREP from %pM\n",
-		  PREP_IE_TARGET_ADDR(prep_elem));
+		  prep_elem_top->target_addr);
 
-	orig_addr = PREP_IE_ORIG_ADDR(prep_elem);
+	orig_addr = prep_elem_bottom->orig_addr;
 	if (ether_addr_equal(orig_addr, sdata->vif.addr))
 		/* destination, no forwarding required */
 		return;
@@ -732,7 +731,7 @@ static void hwmp_prep_frame_process(struct ieee80211_sub_if_data *sdata,
 	if (!ifmsh->mshcfg.dot11MeshForwarding)
 		return;
 
-	ttl = PREP_IE_TTL(prep_elem);
+	ttl = prep_elem_top->ttl;
 	if (ttl <= 1) {
 		sdata->u.mesh.mshstats.dropped_frames_ttl++;
 		return;
@@ -751,12 +750,12 @@ static void hwmp_prep_frame_process(struct ieee80211_sub_if_data *sdata,
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
+	lifetime = get_unaligned_le32(&prep_elem_bottom->lifetime);
+	hopcount = prep_elem_top->hopcount + 1;
+	target_addr = prep_elem_top->target_addr;
+	target_sn = get_unaligned_le32(&prep_elem_top->target_sn);
+	orig_sn = get_unaligned_le32(&prep_elem_bottom->orig_sn);
 
 	mesh_path_sel_frame_tx(MPATH_PREP, flags, orig_addr, orig_sn, 0,
 			       target_addr, target_sn, next_hop, hopcount,
-- 
2.43.0


