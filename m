Return-Path: <linux-wireless+bounces-36503-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEesFZKuB2pHCQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36503-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 01:38:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2F5595FA
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 01:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9ED3F300B1C8
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 23:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4486B3F58EB;
	Fri, 15 May 2026 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ituz7fW2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1B374721
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888333; cv=none; b=F4YJO24efdIkPVY2HMNS/+CMHGNwX+LX8iU92EvaWBoNFlV+2qODOAwK4Uixu2GFOAOTVsglG5uLHonb987a6z53cEKrDiW3r3f/29Y8HnDMXS3wKpBKg6zBMKeyur7BeT8NFo7haOnsneYf3zfJh1d4XxEObebQZHDfKFtoYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888333; c=relaxed/simple;
	bh=m0erGi4/Pml/qHYmO5hNOIcgl4w20V+re6rb7r4sBcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTBSWdj3i2g8TBIcPUexQZdwV/fZjHN8k8CO8m8T5Rtqn7I82tB85tmIIjU5nCqIZ5Tmegxglepr8E8GrjS8a677p31lgUYYvdhQZzcVzbvizM053HMQwj6qC3tlkdv1Ys6elWiNDI+nMigPzAdXDPhabFv0DoBfbNNKz0zpzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ituz7fW2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so154734a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778888331; x=1779493131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59fn6nATlVwlG9I294TK3H1335wKkNw4nJ1NBj4fzHo=;
        b=ituz7fW2W++2nHqfnly8dWlak2qiui697WqWNrinkvxSs2VdmXsYEvENtUeK+psoh1
         1gLlYFwK8FiEgdIkHTaB+W0PlcqxQZ3OwWR5vT3/5q4PoyxXFlp0BU3R4nBb4F9cIbHX
         P9MOpUrvE92jYx3usHIjyNq3QLYmqaP3+Am1/GuWliVlfIGb4X8ekSEnLoH91Ks83QxE
         aCByDvx9JtSg4TCECco1+lQhQx6Xg19uZHBOdQ/NoJOnXtmPWhakZQK8L8H3IdnJ9V9F
         PQIg5f+CPF2w7yWmFYhxtEwBNjAzrzz/BJVT3u5LHDpBwxUo2PtA2ZsORq8UUnyBLGez
         wNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888331; x=1779493131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=59fn6nATlVwlG9I294TK3H1335wKkNw4nJ1NBj4fzHo=;
        b=Tc1wqrHhd6sPRFtbLS6orLxTUhnLhgWOkLTTdw/NKfmV6OGtpiz7Gq0dfBabFDn1H7
         BWU3ucnbYtG4kDbdeIu7XsoOyKVK89dOflXSNi7PAgbnj6XoHKVFHlfWkbEmi0+h4W2E
         9F/ejvTaWFgPeD38ytyHHRtukvCa7+JJAp/Eh8nMbkuxtrXjKhDeM1vUSH+E8s9k0cHW
         41jT6HG+4wzDFg6G9EO640rI7XZQJEPH3sFkV/bMUxP2Y6GQLs3cHxcCUKXvER8/rQln
         6W6UZAc6M5svQj3nUu0GxCOq1JyqxlB6IfrKxh9zpUP2JORuFq8XOW5nT5AxO10E/xPE
         AHDQ==
X-Gm-Message-State: AOJu0YxFKchntobzxYiAhqJsHpWl2MfEW05RbEO5pKpO0NdVdYPRWI+D
	/1ISZ3CvZnInK7ecmwht5Xj0HNlMF1eyYgTafDI+dkRYOmBQ0EghrAF+nrn17w==
X-Gm-Gg: Acq92OFUArdrfmW9EQwcqTnaSi5g9oG7vNeil0YyYzfxntKLoJhpn9Ot0nXwyrA/MUw
	5JzvG0tniTXaDD2UVRodUVb0WPTP26x6QRegv4wiMdXTDwl3aAqdYxObFPslywhuRJn52J2XHhL
	DGiEtuWKymWCEUemTdK8MSJ9Q/0FrR9p+Va7FdhEMoluq9sbi7fYtMdRYvCuVuaPUBQrKMbe4zf
	cMZ+CNebl0RzoROe+yuQhXXIy0zrqvYvAnfMnblIQaVJD7G+G32KOEhV9pKyq/4bcKoMtYiQzk1
	PRL7piONv3GVlvZfDexD9BlQo0jkPy0isX0TEPJk5m83u3TFHoh+aaeVOLMgHHqzWWKIdMj+8IC
	pgrZTyZl+h/pHznxA5N1RgywaTLxnNxRKrxjKirGarsbgpvJogqT/IrdT7oryM2CSjrJhUFxbeC
	4=
X-Received: by 2002:a17:90b:2549:b0:366:4782:1389 with SMTP id 98e67ed59e1d1-36951b8208dmr5762450a91.14.1778888331004;
        Fri, 15 May 2026 16:38:51 -0700 (PDT)
Received: from ryzen9.. ([2001:ac8:40:25::15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb08d06csm6391265a12.14.2026.05.15.16.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:38:49 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v6 3/6] wifi: mac80211: Use struct instead of macro for PERR frame
Date: Sat, 16 May 2026 08:38:36 +0900
Message-ID: <20260515233839.86829-3-masashi.honma@gmail.com>
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
X-Rspamd-Queue-Id: ECD2F5595FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36503-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
 include/linux/ieee80211-mesh.h | 26 ++++++++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 32 ++++++--------------------------
 2 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 093c6b80a983..6b56f462fc21 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -71,6 +71,20 @@ struct ieee80211_mesh_hwmp_prep_bottom {
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
+	struct ieee80211_mesh_hwmp_perr_dst dsts[];
+} __packed;
+
 /* Mesh flags */
 #define MESH_FLAGS_AE_A4 	0x1
 #define MESH_FLAGS_AE_A5_A6	0x2
@@ -298,4 +312,16 @@ static inline struct ieee80211_mesh_hwmp_prep_bottom *
 			ETH_ALEN : 0];
 }
 
+static inline __le16 ieee80211_mesh_hwmp_perr_get_rcode(
+	const u8 *ie, u8 dst_idx)
+{
+	struct ieee80211_mesh_hwmp_perr *perr_ie =
+		(struct ieee80211_mesh_hwmp_perr *)ie;
+	struct ieee80211_mesh_hwmp_perr_dst *dst =
+		&perr_ie->dsts[dst_idx];
+
+	return get_unaligned_le16(&dst->variable[
+		(dst->flags & AE_F) ? ETH_ALEN : 0]);
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index d9394091cea9..044555c42a86 100644
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
@@ -776,6 +754,8 @@ static void hwmp_perr_frame_process(struct ieee80211_sub_if_data *sdata,
 				    const u8 *perr_elem)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct ieee80211_mesh_hwmp_perr *perr_elem_s =
+		(struct ieee80211_mesh_hwmp_perr *)perr_elem;
 	struct mesh_path *mpath;
 	u8 ttl;
 	const u8 *ta, *target_addr;
@@ -783,15 +763,15 @@ static void hwmp_perr_frame_process(struct ieee80211_sub_if_data *sdata,
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
+	target_addr = perr_elem_s->dsts[0].addr;
+	target_sn = get_unaligned_le32(&perr_elem_s->dsts[0].sn);
+	target_rcode = ieee80211_mesh_hwmp_perr_get_rcode(perr_elem, 0);
 
 	rcu_read_lock();
 	mpath = mesh_path_lookup(sdata, target_addr);
-- 
2.43.0


