Return-Path: <linux-wireless+bounces-36774-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKVYIzuOD2pdNQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36774-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:59:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC7E5AC825
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63A29300C593
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 22:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012FE228CB0;
	Thu, 21 May 2026 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYdIjQYc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7836683B
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404334; cv=none; b=USJMiBZwPNzx/nBMtQMfDjV+Nq7lVIuRED2CTGaDr2d1DBv5sQX715V7y/XIHwfSdY7kLGVoJWwo64zCj4FkHc5AfbE3funA8a/SP+ODSu2B0iHiy7qlP2LSpyP+xy33q02FgB5DJS8ls0h8gFIWnm5b+yEJGYVAhAQ5vYhufsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404334; c=relaxed/simple;
	bh=Mt0bLOHVhWtYguS4/DgwOPlG8GGkseohVz+50JwkdXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSskZUf9LoeYLvAdeqHpb+LewmdLyYGL3vPnUxO5nemByzkKKDFjjN5E17/3wuDtxtk/W4+BmOa3kiGZG5SiKZim/Y/bPX+QVqJe1PoLYgW2fAOBNLdgWvXggJHE/o2XXDBAyfGLGrNze2gj3kKxZlyjOaz9LrY8l/DXyj3H/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYdIjQYc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bd2c147abaso40449685ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 15:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779404333; x=1780009133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8P161aakKClsFW4uh8+Wpz4UIsEpsM7nhIxAGgLd/A=;
        b=UYdIjQYc73zOjkc+zQBJ4FXKOD2s5eDbmcb9TfLHO8ZvYSzAli4c4bG3UsnzExZ6UQ
         xrSJabQtSZ/tvKJrm2UxmRHvoqbTLDxAIAlM5zL+G224TbARqDbCEfj5Zeni4n0j1iSi
         tyDXiUu0kfW1YWl0Vbm7AqEbRIwy6m0Uv5aOxHX56WXdeI5CBLevi6YfZtvraNZnTVSz
         I3tovAKtDgOraAksJ+HGO+X/5cNL+Zafh2qfgG08kTldkzyKMSnODyF8QClRvORGUv4k
         h9fLjd97NWVZj50QCZT/G2PCsZvmNktRxXpcrYXoqUKAxM1it8dXgCjIUax9L4ekkcP0
         LmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779404333; x=1780009133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K8P161aakKClsFW4uh8+Wpz4UIsEpsM7nhIxAGgLd/A=;
        b=IQ6MheyMXcHaVz6SJiFNqSzMiB6Vjl1kzOWDYlHkeV1smRe6xsM/nJOTPwXlVlOrBG
         /F0xh7hHz1PWeEV58bfS94LMdPhrwwMTVOzCUDbjdI8VF7G2oOlG66nEC+4zoxktu1ut
         vMgRVyWaCK/BbXjfECtYH5HQhgL3QCJ6zMXEfBZkGJpsBsau421YVz9HnEpaCe1RzIRF
         OmPzxpxCLP1ehStj2nZrOR2dqY5pblFIthR1BaDDRbLny+s5iPSfMc8rU3qqnfHQPc2n
         WiVBv48iCSnjoeU7YrlUZFbdoAQX7a8G1RjX9GTOSNbJHEAYeuGG1f0e9whYcAtfALas
         hScg==
X-Gm-Message-State: AOJu0YwoWMs2cUx8xMQh2yIQQQT2wIcTUuBGdjpsL8tVRKhWsxAAS0co
	yX9j4f1Ub9uGpcSWI+cYadFMBi8RqHF4V5ONcSkt2ft884c9pdJrGIFukwR49w==
X-Gm-Gg: Acq92OE2XlKpDuE0zkby8bpErPABjLDO53eWK2ykX4OafRxtO4v6+9Eq14W9fiyugjp
	HUFx4eZDN8Vbkfx96AgHgJqHOD+Vs0VUHykw/ClTaTEA701V+6RejIY5m4DMqJh/h87TGkCnuCt
	t6fcxB5TpGJD8udfv4n4REbNmBHPe/YVkpwBKqat3Ij44+8ZlpkpWHRyY8IaVsdi/MtTAtXZM3A
	iqJhrk3jIzM7Y/9IHWbSOju+Qan3JNq3A+JMnWRqifMXN9kJe89YQwhnpf5vSq+FmIQ9GbMuGMw
	4p/ngDoM9e8EHeWuTAdp4gR0GA3ey2dodstL0u5C9Gyzs/kOfVnAXq76V08juv3PMNAjIwcETCP
	X3SaNPRH8wTmbM++ypmzeyOKd+VvvIYsnGQm88EoS6y5EvzG4JFmHlNt3kploC6KE5Qsr2r/4Oe
	YXeLlRY8qTsw==
X-Received: by 2002:a17:903:46cb:b0:2bc:f3c5:ff0a with SMTP id d9443c01a7336-2beb060dda9mr9069235ad.30.1779404332776;
        Thu, 21 May 2026 15:58:52 -0700 (PDT)
Received: from ryzen9.. ([2001:ac8:40:25::19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb13d4c55sm2857855ad.70.2026.05.21.15.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:58:52 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v8 3/6] wifi: mac80211: Use struct instead of macro for PERR frame
Date: Fri, 22 May 2026 07:58:39 +0900
Message-ID: <20260521225842.31815-3-masashi.honma@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-36774-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 1EC7E5AC825
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
 include/linux/ieee80211-mesh.h | 25 +++++++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 31 +++++--------------------------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 4ce4e47d6d01..0e9bd56b54f2 100644
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
@@ -296,4 +310,15 @@ ieee80211_mesh_hwmp_prep_get_bottom(const u8 *ie)
 		ieee80211_mesh_preq_prep_ae_enabled(ie) ? ETH_ALEN : 0];
 }
 
+static inline u16
+ieee80211_mesh_hwmp_perr_get_rcode(const u8 *ie, u8 dst_idx)
+{
+	struct ieee80211_mesh_hwmp_perr *perr_ie = (void *)ie;
+	struct ieee80211_mesh_hwmp_perr_dst *dst =
+		&perr_ie->dsts[dst_idx];
+
+	return get_unaligned_le16(&dst->variable[
+		(dst->flags & AE_F) ? ETH_ALEN : 0]);
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 39b782370df0..fa144a187fe2 100644
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
+	target_addr = perr_elem_s->dsts[0].addr;
+	target_sn = le32_to_cpu(perr_elem_s->dsts[0].sn);
+	target_rcode = ieee80211_mesh_hwmp_perr_get_rcode(perr_elem, 0);
 
 	rcu_read_lock();
 	mpath = mesh_path_lookup(sdata, target_addr);
-- 
2.43.0


