Return-Path: <linux-wireless+bounces-26019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9976BB11F4F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 15:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2D4AA25F2
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610BC2ED179;
	Fri, 25 Jul 2025 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="OkmzCeNS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F980246780
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449769; cv=none; b=rI2NZ74FgU0+gRsb2vXeTfsVT49L1evARMtcRgfg2YSALTSIcrVS6i4AB8w4og3DbdoQHNPHSZfViRjdspuoabTGDVu+rTMex7FBCMQMMA/cXLuepmSss2BFqowfG0ls3TDVC+4RdlSzy1aZg6RSIjC9t8uIWUFtNNMJpb9Jt+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449769; c=relaxed/simple;
	bh=2q27ldN8BIT9azq458xT5KqD+qaSxnQvCXA4PUt1JTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVUYJb6Ix4o6MxRAjStHYF0i4Zhnv/J4S416N6c215FUtuSvMp4GD03fGfGJZ722YmknGmEcHgNbEgjm1tumjqwOjwyvjkSh+I80ezt10g95LOhTTh/gj3+bRYHTEnhhezJOUrszObepVhH1fjzvKVGt/PLew001xrDJ5Tf05pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=OkmzCeNS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23c8a5053c2so17791365ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753449766; x=1754054566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90JvpcMnvkIXPxlzMSsisxS9E7Wbzy5zPAkkMIe4QnY=;
        b=OkmzCeNSxyN/Td+hnxGTQMYSVf0SFCkY8S1YCK0dStFxkjN+uAiZ3BSqDgt/9R9omk
         IGVALAsS4Ll+SGXKH0NpguOfc+PbCkwPalgvpv6snpltcY3tTDeZqjuiFBgNX9/J6aMT
         Y5/AZm2FCo0JeqloXjwELIqxqU3+UyFCpwJtzeSD+XVugwiGgs1tqonf2+u5mVaOfOqc
         qRBCNWD0a+YLvFdpFnZRaEvvhki08Cacgq2pS5mUJZ+CH45NunWjpOYvnA83CoX6mBNW
         fx7FE97zS57BuXE7onsCS2e7nEm4KAZKRFBeCZsphUo6t0Gue/QKbw9RD0wpOtAShYX2
         CXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753449766; x=1754054566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90JvpcMnvkIXPxlzMSsisxS9E7Wbzy5zPAkkMIe4QnY=;
        b=vFglYsqH4ti7avpJOqAPTYY2vlazrjA3HqRPI879dqu6gMwIghQhGiYMmCr+ECyzg4
         TvHRxKfKNEtfZw4MK49qP6pKSi6jz06wayQzuVd9qVWHWDkfpvV4auI2oDrY8XRyw2QX
         z4LFjv3nRKDhIcsKiMenT0xi+/CiJIO1nNxqP+Oe0LxZFjbB+mpApgTmOB5V83/Tsyk8
         +GNerVEeXJiAXwPIHiYsYosGgOo5O2c1AU1U6xiSD31Fo12rlE2qgkR5SVKZi9WfeUsJ
         w8gYYrueQ1t3noqhkwBwrUXRBnisz766gdCwhNHMowVLM+5aag/jdup01pJHD6yvQWmG
         oMlQ==
X-Gm-Message-State: AOJu0YwFMh8/s6BTKkU3Pm/dkWbeXCpCZI0hiMovOG+V2lGSQxSKSVnS
	u4blSlM2ak6yxCx3wSXbXiBaAUMeukZ758GwNPJhMtFqgfFAsYmCJI96MORfZh+98rM=
X-Gm-Gg: ASbGncvKB5FqfJCN+fPHlh+2xCZR2lFzR/StVU615btsJNXdQrkYbr6wBkmQTXYKz13
	56jNa8XtzU0H+50Sh5c/W4lyuw+Iycd24i9CCSIQ2j8jchJW7rYN34HhkNLZNB0TU0qknHNBZVb
	6dpbsE++40KcFqSldhU18e3L1V9oeIyFx3ksa1WSGMuY+rZIafLvDXZkfjj0u6Nk+Cfd+AVhItS
	IiZbQaqwJl3mtA45NljX1d6s2ZhVb4+lrQ3S4FPglVkVuXvQRsMhetQZN5TXbdyrn9xkyHW/i35
	dn6VJ1cXbRwdgSanaY8jA+ESOfL+mXDpYNj5xyG/jbSCFZw0GkeKlg9y6OPKzL2apagtZ0Jf5SZ
	qSyVMbpeWCYxE/OWG+W+LsULmOOqt74aPsWIu68c=
X-Google-Smtp-Source: AGHT+IFmKBGB7wzn1+Ur7w6iR74eXkc9/NX9b0IsQjlQNjMJ8v3cULhNbeNO3C0TICCUVeb+vZz1cg==
X-Received: by 2002:a17:903:94b:b0:234:c8f6:1b03 with SMTP id d9443c01a7336-23fb317a022mr29450945ad.47.1753449766316;
        Fri, 25 Jul 2025 06:22:46 -0700 (PDT)
Received: from mma-H9MHD44.lan ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bd625sm37117665ad.122.2025.07.25.06.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:22:46 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v2 2/3] wifi: mac80211: support parsing S1G TIM PVB
Date: Fri, 25 Jul 2025 23:22:20 +1000
Message-ID: <20250725132221.258217-3-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725132221.258217-1-lachlan.hodges@morsemicro.com>
References: <20250725132221.258217-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An S1G TIM PVB has 3 mandatory encoding modes, that being
block bitmap, single AID and OBL alongside the ability for
each encoding mode to be inverted. Introduce the ability to
parse the 3 encoding formats. The implementation specification
for the encoding formats can be found in IEEE80211-2024 9.4.2.5.

Signed-off-by: Arien Judge <arien.judge@morsemicro.com>
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---

v1 -> v2:

- Implement the other 2 non-optional encoding modes, single AID
  and OLB. This also meant some code refactoring was done in the
  block bitmap mode code from v1.

---
 drivers/net/wireless/ath/carl9170/rx.c        |   2 +-
 drivers/net/wireless/intersil/p54/txrx.c      |   2 +-
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    |   2 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c     |   2 +-
 include/linux/ieee80211.h                     | 265 +++++++++++++++++-
 net/mac80211/mesh_ps.c                        |   2 +-
 net/mac80211/mlme.c                           |   3 +-
 7 files changed, 263 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 908c4c8b7f82..6833430130f4 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -555,7 +555,7 @@ static void carl9170_ps_beacon(struct ar9170 *ar, void *data, unsigned int len)
 	/* Check whenever the PHY can be turned off again. */
 
 	/* 1. What about buffered unicast traffic for our AID? */
-	cam = ieee80211_check_tim(tim_ie, tim_len, ar->common.curaid);
+	cam = ieee80211_check_tim(tim_ie, tim_len, ar->common.curaid, false);
 
 	/* 2. Maybe the AP wants to send multicast/broadcast data? */
 	cam |= !!(tim_ie->bitmap_ctrl & 0x01);
diff --git a/drivers/net/wireless/intersil/p54/txrx.c b/drivers/net/wireless/intersil/p54/txrx.c
index 2deb1bb54f24..1294a1d6528e 100644
--- a/drivers/net/wireless/intersil/p54/txrx.c
+++ b/drivers/net/wireless/intersil/p54/txrx.c
@@ -317,7 +317,7 @@ static void p54_pspoll_workaround(struct p54_common *priv, struct sk_buff *skb)
 	tim_len = tim[1];
 	tim_ie = (struct ieee80211_tim_ie *) &tim[2];
 
-	new_psm = ieee80211_check_tim(tim_ie, tim_len, priv->aid);
+	new_psm = ieee80211_check_tim(tim_ie, tim_len, priv->aid, false);
 	if (new_psm != priv->powersave_override) {
 		priv->powersave_override = new_psm;
 		p54_set_ps(priv);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 432ddfac2c33..963c1e0af8b8 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -679,7 +679,7 @@ static void rt2x00lib_rxdone_check_ps(struct rt2x00_dev *rt2x00dev,
 	/* Check whenever the PHY can be turned off again. */
 
 	/* 1. What about buffered unicast traffic for our AID? */
-	cam = ieee80211_check_tim(tim_ie, tim_len, rt2x00dev->aid);
+	cam = ieee80211_check_tim(tim_ie, tim_len, rt2x00dev->aid, false);
 
 	/* 2. Maybe the AP wants to send multicast/broadcast data? */
 	cam |= (tim_ie->bitmap_ctrl & 0x01);
diff --git a/drivers/net/wireless/realtek/rtlwifi/ps.c b/drivers/net/wireless/realtek/rtlwifi/ps.c
index 6241e4fed4f6..bcab12c3b4c1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/ps.c
+++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
@@ -519,7 +519,7 @@ void rtl_swlps_beacon(struct ieee80211_hw *hw, void *data, unsigned int len)
 
 	/* 1. What about buffered unicast traffic for our AID? */
 	u_buffed = ieee80211_check_tim(tim_ie, tim_len,
-				       rtlpriv->mac80211.assoc_id);
+				       rtlpriv->mac80211.assoc_id, false);
 
 	/* 2. Maybe the AP wants to send multicast/broadcast data? */
 	m_buffed = tim_ie->bitmap_ctrl & 0x01;
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 32c34b8ed583..ba1fa7e14b2e 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -220,6 +220,12 @@ static inline u16 ieee80211_sn_sub(u16 sn1, u16 sn2)
 #define IEEE80211_MAX_AID_S1G		8191
 #define IEEE80211_MAX_TIM_LEN		251
 #define IEEE80211_MAX_MESH_PEERINGS	63
+
+/* S1G encoding types */
+#define IEEE80211_S1G_TIM_ENC_MODE_BLOCK	0
+#define IEEE80211_S1G_TIM_ENC_MODE_SINGLE	1
+#define IEEE80211_S1G_TIM_ENC_MODE_OLB		2
+
 /* Maximum size for the MA-UNITDATA primitive, 802.11 standard section
    6.2.1.1.2.
 
@@ -4758,15 +4764,8 @@ static inline unsigned long ieee80211_tu_to_usec(unsigned long tu)
 	return 1024 * tu;
 }
 
-/**
- * ieee80211_check_tim - check if AID bit is set in TIM
- * @tim: the TIM IE
- * @tim_len: length of the TIM IE
- * @aid: the AID to look for
- * Return: whether or not traffic is indicated in the TIM for the given AID
- */
-static inline bool ieee80211_check_tim(const struct ieee80211_tim_ie *tim,
-				       u8 tim_len, u16 aid)
+static inline bool __ieee80211_check_tim(const struct ieee80211_tim_ie *tim,
+					 u8 tim_len, u16 aid)
 {
 	u8 mask;
 	u8 index, indexn1, indexn2;
@@ -4789,6 +4788,254 @@ static inline bool ieee80211_check_tim(const struct ieee80211_tim_ie *tim,
 	return !!(tim->virtual_map[index] & mask);
 }
 
+struct s1g_tim_aid {
+	u16 aid;
+	u8 target_blk; /* Target block index */
+	u8 target_subblk; /* Target subblock index */
+	u8 target_subblk_bit; /* Target subblock bit */
+};
+
+struct s1g_tim_enc_block {
+	u8 enc_mode;
+	bool inverse;
+	const u8 *ptr;
+	u8 len;
+
+	/*
+	 * For an OLB encoded block that spans multiple blocks, this
+	 * is the offset into the span described by that encoded block.
+	 */
+	u8 olb_blk_offset;
+};
+
+/*
+ * Helper routines to quickly extract the length of an encoded block. Validation
+ * is also performed to ensure the length extracted lies within the TIM.
+ */
+
+static inline int ieee80211_s1g_len_bitmap(const u8 *ptr, const u8 *end)
+{
+	u8 blkmap;
+	u8 n_subblks;
+
+	if (ptr >= end)
+		return -EINVAL;
+
+	blkmap = *ptr;
+	n_subblks = hweight8(blkmap);
+
+	if (ptr + 1 + n_subblks > end)
+		return -EINVAL;
+
+	return 1 + n_subblks;
+}
+
+static inline int ieee80211_s1g_len_single(const u8 *ptr, const u8 *end)
+{
+	return (ptr + 1 > end) ? -EINVAL : 1;
+}
+
+static inline int ieee80211_s1g_len_olb(const u8 *ptr, const u8 *end)
+{
+	if (ptr >= end)
+		return -EINVAL;
+
+	return (ptr + 1 + *ptr > end) ? -EINVAL : 1 + *ptr;
+}
+
+/*
+ * Enumerate all encoded blocks until we find the encoded block that describes
+ * our target AID. OLB is a special case as a single encoded block can describe
+ * multiple blocks as a single encoded block.
+ */
+static inline int ieee80211_s1g_find_target_block(struct s1g_tim_enc_block *enc,
+						  const struct s1g_tim_aid *aid,
+						  const u8 *ptr, const u8 *end)
+{
+	/* need at least block-control octet */
+	while (ptr + 1 <= end) {
+		u8 ctrl = *ptr++;
+		u8 mode = ctrl & 0x03;
+		bool contains, inverse = ctrl & BIT(2);
+		u8 span, blk_off = ctrl >> 3;
+		int len;
+
+		switch (mode) {
+		case IEEE80211_S1G_TIM_ENC_MODE_BLOCK:
+			len = ieee80211_s1g_len_bitmap(ptr, end);
+			contains = blk_off == aid->target_blk;
+			break;
+		case IEEE80211_S1G_TIM_ENC_MODE_SINGLE:
+			len = ieee80211_s1g_len_single(ptr, end);
+			contains = blk_off == aid->target_blk;
+			break;
+		case IEEE80211_S1G_TIM_ENC_MODE_OLB:
+			len = ieee80211_s1g_len_olb(ptr, end);
+			/*
+			 * An OLB encoded block can describe more then one
+			 * block, meaning an encoded OLB block can span more
+			 * then a single block.
+			 */
+			if (len > 0) {
+				/* Minus one for the length octet */
+				span = DIV_ROUND_UP(len - 1, 8);
+				/*
+				 * Check if our target block lies within the
+				 * block span described by this encoded block.
+				 */
+				contains = (aid->target_blk >= blk_off) &&
+					   (aid->target_blk < blk_off + span);
+			}
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+		if (len < 0)
+			return len;
+
+		if (contains) {
+			enc->enc_mode = mode;
+			enc->inverse = inverse;
+			enc->ptr = ptr;
+			enc->len = (u8)len;
+			enc->olb_blk_offset = blk_off;
+			return 0;
+		}
+
+		ptr += len;
+	}
+
+	return -ENOENT;
+}
+
+static inline bool ieee80211_s1g_parse_bitmap(struct s1g_tim_enc_block *enc,
+					      struct s1g_tim_aid *aid)
+{
+	const u8 *ptr = enc->ptr;
+	u8 blkmap = *ptr++;
+
+	/*
+	 * If our block bitmap does not contain a set bit that corresponds
+	 * to our AID, it could mean a variety of things depending on if
+	 * the encoding mode is inverted or not.
+	 *
+	 * 1. If inverted, it means the entire subblock is present and hence
+	 *    our AID has been set.
+	 * 2. If not inverted, it means our subblock is not present and hence
+	 *    it is all zero meaning our AID is not set.
+	 */
+	if (!(blkmap & BIT(aid->target_subblk)))
+		return enc->inverse;
+
+	/*
+	 * Increment ptr by the number of set subblocks that appear before our
+	 * target subblock. If our target subblock is 0, do nothing as ptr
+	 * already points to our target subblock.
+	 */
+	if (aid->target_subblk)
+		ptr += hweight8(blkmap & GENMASK(aid->target_subblk - 1, 0));
+
+	return !!(*ptr & BIT(aid->target_subblk_bit)) ^ enc->inverse;
+}
+
+static inline bool ieee80211_s1g_parse_single(struct s1g_tim_enc_block *enc,
+					      struct s1g_tim_aid *aid)
+{
+	/*
+	 * Single AID mode describes, as the name suggests, a single AID
+	 * within the block described by the encoded block. The octet
+	 * contains the 6 LSBs of the AID described in the block. The other
+	 * 2 bits are reserved. When inversed, every single AID described
+	 * by the current block have buffered traffic except for the AID
+	 * described in the single AID octet.
+	 */
+	return ((*enc->ptr & 0x3f) == (aid->aid & 0x3f)) ^ enc->inverse;
+}
+
+static inline bool ieee80211_s1g_parse_olb(struct s1g_tim_enc_block *enc,
+					   struct s1g_tim_aid *aid)
+{
+	const u8 *ptr = enc->ptr;
+	u8 blk_len = *ptr++;
+	/*
+	 * Given an OLB encoded block that describes multiple blocks,
+	 * calculate the offset into the span. Then calculate the
+	 * subblock location normally.
+	 */
+	u16 span_offset = aid->target_blk - enc->olb_blk_offset;
+	u16 subblk_idx = span_offset * 8 + aid->target_subblk;
+
+	if (subblk_idx >= blk_len)
+		return enc->inverse;
+
+	return !!(ptr[subblk_idx] & BIT(aid->target_subblk_bit)) ^ enc->inverse;
+}
+
+/*
+ * An S1G PVB has 3 non optional encoding types, each that can be inverted.
+ * An S1G PVB is constructed with zero or more encoded block subfields. Each
+ * encoded block represents a single "block" of AIDs (64), and each encoded
+ * block can contain one of the 3 encoding types alongside a single bit for
+ * whether the bits should be inverted.
+ *
+ * As the standard makes no guarantee about the ordering of encoded blocks,
+ * we must parse every encoded block in the worst case scenario given an
+ * AID that lies within the last block.
+ */
+static inline bool ieee80211_s1g_check_tim(const struct ieee80211_tim_ie *tim,
+					   u8 tim_len, u16 aid)
+{
+	int err;
+	struct s1g_tim_aid target_aid;
+	struct s1g_tim_enc_block enc_blk;
+
+	if (tim_len < 3)
+		return false;
+
+	target_aid.aid = aid;
+	target_aid.target_blk = (aid >> 6) & 0x1f;
+	target_aid.target_subblk = (aid >> 3) & 0x7;
+	target_aid.target_subblk_bit = aid & 0x7;
+
+	/*
+	 * Find our AIDs target encoded block and fill &enc_blk with the
+	 * encoded blocks information. If no entry is found or an error
+	 * occurs return false.
+	 */
+	err = ieee80211_s1g_find_target_block(&enc_blk, &target_aid,
+					      tim->virtual_map,
+					      (const u8 *)tim + tim_len + 2);
+	if (err)
+		return false;
+
+	switch (enc_blk.enc_mode) {
+	case IEEE80211_S1G_TIM_ENC_MODE_BLOCK:
+		return ieee80211_s1g_parse_bitmap(&enc_blk, &target_aid);
+	case IEEE80211_S1G_TIM_ENC_MODE_SINGLE:
+		return ieee80211_s1g_parse_single(&enc_blk, &target_aid);
+	case IEEE80211_S1G_TIM_ENC_MODE_OLB:
+		return ieee80211_s1g_parse_olb(&enc_blk, &target_aid);
+	default:
+		return false;
+	}
+}
+
+/**
+ * ieee80211_check_tim - check if AID bit is set in TIM
+ * @tim: the TIM IE
+ * @tim_len: length of the TIM IE
+ * @aid: the AID to look for
+ * @s1g: whether the TIM is from an S1G PPDU
+ * Return: whether or not traffic is indicated in the TIM for the given AID
+ */
+static inline bool ieee80211_check_tim(const struct ieee80211_tim_ie *tim,
+				       u8 tim_len, u16 aid, bool s1g)
+{
+	return s1g ? ieee80211_s1g_check_tim(tim, tim_len, aid) :
+		     __ieee80211_check_tim(tim, tim_len, aid);
+}
+
 /**
  * ieee80211_get_tdls_action - get TDLS action code
  * @skb: the skb containing the frame, length will not be checked
diff --git a/net/mac80211/mesh_ps.c b/net/mac80211/mesh_ps.c
index 20e022a03933..ebab1f0a0138 100644
--- a/net/mac80211/mesh_ps.c
+++ b/net/mac80211/mesh_ps.c
@@ -586,7 +586,7 @@ void ieee80211_mps_frame_release(struct sta_info *sta,
 
 	if (sta->mesh->plink_state == NL80211_PLINK_ESTAB)
 		has_buffered = ieee80211_check_tim(elems->tim, elems->tim_len,
-						   sta->mesh->aid);
+						   sta->mesh->aid, false);
 
 	if (has_buffered)
 		mps_dbg(sta->sdata, "%pM indicates buffered frames\n",
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 107a0aaf0a9d..eee842b36bec 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7436,7 +7436,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	ncrc = elems->crc;
 
 	if (ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK) &&
-	    ieee80211_check_tim(elems->tim, elems->tim_len, vif_cfg->aid)) {
+	    ieee80211_check_tim(elems->tim, elems->tim_len, vif_cfg->aid,
+				vif_cfg->s1g)) {
 		if (local->hw.conf.dynamic_ps_timeout > 0) {
 			if (local->hw.conf.flags & IEEE80211_CONF_PS) {
 				local->hw.conf.flags &= ~IEEE80211_CONF_PS;
-- 
2.43.0


