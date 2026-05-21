Return-Path: <linux-wireless+bounces-36754-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOlDD73ODmq7CQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36754-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:22:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DADD55A23A1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9963231C9338
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772DE361DBA;
	Thu, 21 May 2026 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju5ucXpz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56B364049
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353816; cv=none; b=jWggv/7VvB8WjgocUVP3D/9t5dXnb+4lWQ8dBoHfx7eBtEc85Lbd0nLWS5nGz1BZjXPS5XYnwU+WdhMDeH1qFiphDwQmdPQDVx/w+ilWCil3FJD2h3fkkFIXNN4uOo/RTsEXdF3LEE4yL/3h4gVu9S9Qs4Np2i9k5gU7KlysdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353816; c=relaxed/simple;
	bh=kcpDQIkt7FU273l98+jWGLJV+b6OISyhu7px4tPrTL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLKXcJ3d2eghggbznbSU52GknIYxsx+N0c9/UfUjgYmxhsokOb1stNY+eaVunFQ4255mKTA8jJlgpwl3a5nLmGaFF6MCnFf5+yxGYa49vmyrorwdz/ir7t1DUhKLHXMl00wKKCRavfo5dOFPWALORYqnYhdU3YiiUsBxcRPY5Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju5ucXpz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-83ef1d17904so5855003b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779353814; x=1779958614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjgTU/rDKCfDgG6/6B1J41mCWxUFpMNUCq2rw3Pxzlo=;
        b=ju5ucXpztpnOOxkAeXU+8bUbW5PAYjoR65A+6Yo/GHoWD9JZcAhFMLTvCKRkOWIS2v
         V79YfWiyu2QtcnkiYzTdmZWekMGAz8B5wjJiZDJEJYg83ImSqvWmXH6iILwvzvI9SE10
         vkTcVGrNQMuayy0VrNjil+zXWe/yp+XvFy1+GYgBamMY68SG0osMi5BChTAiH+JantAL
         iynAsAxxd3+sdYDm8+UbS5ptbYP7/44HOa99aLGaHc6bWVBEzdrLAqYlZc7dRHEKRqxR
         94rrWHtQwgNrVhcM8HJ1Kwk3YOJ41Jp3JzhpRk4iX9ndAIMJM67Sf12h3UWVy8De4szP
         ++pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353814; x=1779958614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QjgTU/rDKCfDgG6/6B1J41mCWxUFpMNUCq2rw3Pxzlo=;
        b=PyhH71BJeaX4+tv8Js2x6WO1yWJBt4dRKj7+jL7c36M8NKwVYgIC2AAi9/qzJDbKYm
         CPGACq0A5OJ8dPnZzbXDND3IqxFEV8YyL1A8wTamTf9xEQp4aAzVNLXaNk1STbK5xdev
         ukx+YKdUuPUm1zeiHwQ2+yx5f7hMChOr1BzL+wCaDcIYuqmziELuOlruJukLr6rPRmo4
         +r+wMNHY+NSjmV2HFLO1V/fw4odpnZr7m+rR4nXsQJHShQRLzrijahdozD1tmpTg6jDF
         U+tBcK8NdaNmhSEqRpUdTXiBrNF9CofkJdv7MQzPnp7O+XyVE1b7RDeuSeKrWfqtblfp
         s1XQ==
X-Gm-Message-State: AOJu0YxM1tfZ3/3keasdEckoZRai/oGRQn86ien31OuIijM7IPV5lWaG
	/I2KLJzKiPh/AckBfnGVGESN9AvyKKpVridQ5O1EVUmU+gM4JrqJQabQzQ+v3A==
X-Gm-Gg: Acq92OGlyjB3rpvsZ3H1cQyl5R59hdQa0xJtFUqh3WfP9xOnLj6I3OHjCpo/LZ+lZ6r
	8jKVWo67HHygw1rKBEjoWkvjn+Wx54RW+Z8HUNvucPqCI6KRtYMt+07qgk3t9GpZL5T2k8O437a
	mbAoEdZKZJyBEZ7DcXldc/y917Kk0yjMkhS6rNRyEO+k/dIHQlHGuajPkDsHostpzacvBHdMo5P
	61ZmsiyIChNF2q/QinpTbrX/QgtGjVEMVnGU5lBFhVuucaIY3tGV10rc4cUEZ43rDjFebIJA0rv
	OHlSVTg5W4xQEN9kEK+tBPjhV5rxmi/R2qHJmWX2eANWfuAYyaSulyXUzpDktKzS/V0E5RxCbzX
	+/FddaP/2nPeb+K5TMTcaBINTPGvnECR4x7s/37WBGR4OpJX7ToSiQVMIhmwbp0okZTTxsLjqeS
	Nd80nB4lKcazIo1+yJWHwymnZ79Zu9kiC9Dz45Nh2I25WAGAljpsnLhPkkoA==
X-Received: by 2002:a05:6a20:7f8d:b0:394:5513:ce5 with SMTP id adf61e73a8af0-3b308bbc950mr2337382637.51.1779353814356;
        Thu, 21 May 2026 01:56:54 -0700 (PDT)
Received: from ryzen9.. (11.9.30.125.dy.iij4u.or.jp. [125.30.9.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062695sm21463091a12.4.2026.05.21.01.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:56:54 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v7 3/6] wifi: mac80211: Use struct instead of macro for PERR frame
Date: Thu, 21 May 2026 17:56:44 +0900
Message-ID: <20260521085647.394151-3-masashi.honma@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-36754-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: DADD55A23A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation for subsequent patches.

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


