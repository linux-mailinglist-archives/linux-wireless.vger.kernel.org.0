Return-Path: <linux-wireless+bounces-25799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F33FB0D26A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 09:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D043AC6CD
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 07:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46111288C8F;
	Tue, 22 Jul 2025 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="1ytJ/wNl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31A4414
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168638; cv=none; b=laEstw32iLQlCautFCLVOB4WoCYQccgJxkWFT7xExjc2nCa8XnAIiCgozctiFn2uvs+18Rc+vKyF5cwpEmkTPjHysXBld4Qg3NUmerRa8CVv72w60TgDMPkLzVD4YXFXEnD8dsfbdI8k21hnuzIf0SNFuYRCCmO/gdqxAt8Ye+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168638; c=relaxed/simple;
	bh=1IKgOFE61YWE4cDMOXlC6Z6vmmIbiP3HuYp747vnQgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnYDC1GJKrbF+ReDoCGiUeFzveOKqXKvdYUrFFYIDefmZ9viDFZkfUq3X1tgzBu2Ov/FnA9eWG7L0tggsrHcnZUnwlMLuK2xnyunWZhCF9Hb7ADuZ1+LCikjKHXBQd1DJCUaOjlfR5X2yjzEb0YVGtH2bZt6ceXWEdVVONcrv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=1ytJ/wNl; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b350704f506so4104572a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 00:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753168636; x=1753773436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsbAvx4iRFrikJAqCWd2Ydt39ap9zjZ1WY3Jyw76zxw=;
        b=1ytJ/wNlgIajxzuVtPF2LTgGfK5tbosjDZOZrsz7g3ijEwr/xgwTuKJKYcLKMF9M96
         O0VHho2z1ILtC76mulk7taQg2TBE2y6k7vBKgUPSemCaRmIoRHEDu3Is2JDuGCguNFgq
         eWVP49eB27netFd+IUAcxI0vYvgCEzsPg9TzKWXyivFp/VpUkWekm7oF5h3jdTnQXmuf
         2X7ru4hW9VUvg4hYv0TfkJY/W251h0HO/IRZX0oSBEq2cuvvQHVcJKYkCmVvllTc34S/
         g5NBt/C5rvG/HY2x9m7SznZLfZkEmgiyrUKgFjMEatOxjn1+nzQ5BIlDtHrt6v9XYTdu
         I0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753168636; x=1753773436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsbAvx4iRFrikJAqCWd2Ydt39ap9zjZ1WY3Jyw76zxw=;
        b=UwXH9YaaFZ0TeNzDGpH6Kk14lb09ooZ1sATmnvmqn71VrEsfBZQzPbgabkiTHqHU+j
         LrOw6BcCDldLgJX6OIXu9kZhtPCOZOopvtL6BCgTgBgkpdYAgRe3hF/g7faWTHu8BVWJ
         EM2Ss4nXCJ7J/Q0sqNEjQKBWg9URZdhvJOsJNsZsUrk7hTl5ndSm4nkQ5pDA+9Otznem
         2s7w0g6G3TbiBo6fOhYOLz2EGoCRrAGG9Q4G1bNHIL3FyrK1xxmloZQJJuevLZmQ1avQ
         f15lrXaDQ/3ZksgXgTgkvoX1AkchR/0q85Tgoe1Wim6W/oZ6fKLzHV/t7FjD6fTxdQJ/
         Bblw==
X-Gm-Message-State: AOJu0YxJUXa3A7cN/ErSVef363UPTR4EB2a29ucPZpwlHyu1R/vI6N9g
	XmbK6wBuNtUAGL023BYK8qNyEPn3iKEY/6uaWHH2jfbVmZxJPyzFK8w/5YCiMwv/JlQoJO7+Dn7
	WUVSEJ8E=
X-Gm-Gg: ASbGncufV5v1bqscIu9AwI+IN6hvehZUywSN9GeL3GsEQgNrDGSjS8YPEz/bv7S/kMG
	7U/rdEa4WEagTZ7FguhtsSQtPSDYLeii5E4GGMxJOFSbEcmVqVh7EkCFUbheydEyv7dzcz+rMqs
	S/ZFl6RB95A/+5V0Ia+k+3y/9FcrpXmqx269UFvSgv5QiPdA5jPOkhMzhpiEl5FBJN/268mXhay
	86e064ejBgkd97WhYI4NnGiHi/eg7BCW9yOTbwvHxSv3pNsxtxQ2+9TMD2VhXhMdEw4hkp/gzQh
	dh/31kHVvZC0K4gKlUYWOcrMjmd052HkYibE14KaqW3gF2Hikq1o9He3bDHbvjxeNa5LhZb3i9L
	fhMspspzw2w8N4i/3maX4MSHBIktbFiGrKJn9/1XZmMeroEWACltkoIUSHLTEoEETACRuuaBEKO
	pa02M=
X-Google-Smtp-Source: AGHT+IG15R9DaLpo1Ld9Xxgiav5yyaPb9RltBIXcG/iezQO8FSNs4cl1fV2M1/2VKnBUYn7Zab7ETg==
X-Received: by 2002:a17:90b:1b11:b0:312:e73e:cded with SMTP id 98e67ed59e1d1-31e3e1f6ef1mr3125732a91.16.1753168635473;
        Tue, 22 Jul 2025 00:17:15 -0700 (PDT)
Received: from localhost.localdomain (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1fa8f1sm11099772a91.22.2025.07.22.00.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:17:15 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next 1/2] wifi: mac80211: support encoding S1G TIM PVB
Date: Tue, 22 Jul 2025 17:16:39 +1000
Message-ID: <20250722071642.875875-2-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An S1G PPDU TIM PVB (Partial Virtual Bitmap) follows a different
format to non-S1G PPDU's. An S1G TIM PVB breaks down the contiguous
AID bitmap into encoded blocks and only sends an encoded block if
there is at least one AID with buffered unicast traffic.

An S1G PPDU TIM represents groups of AIDS with an array of encoded
blocks. Each encoded block represents 64 AIDs and is only present if
at least one AID within the group of 64 is present. Each encoded
block can contain 0 to 8 subblocks, where each subblock represents 8
AIDs. Similarly to the encoded blocks, sublocks are only added if there
is at least 1 AID set within that subblock. If a subblock is present,
the subblocks bit is set in the block bitmap which precedes the
sublock bitmap.

As page slicing is currently not supported by mac80211, we limit the
S1G max AID to 1600. This is due to the fact that the TIM element has
a maximum length of 255, such that we have DTIM count + DTIM period +
bitmap control = 3 bytes, leaving us with 252 bytes for encoded
blocks. Each encoded block has a maximum size of 10 bytes (assuming
every AID is set) leaving us with 25 * 10 + 3 = 253 bytes.

Correctly encode the S1G PPDU TIM PVB utilising the TIM bitmap.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/linux/ieee80211.h |  14 +++
 net/mac80211/tx.c         | 173 +++++++++++++++++++++++++++++++-------
 2 files changed, 156 insertions(+), 31 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index e5a2096e022e..2a73f9e4b0ac 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -220,6 +220,20 @@ static inline u16 ieee80211_sn_sub(u16 sn1, u16 sn2)
 #define IEEE80211_MAX_AID_S1G		8191
 #define IEEE80211_MAX_TIM_LEN		251
 #define IEEE80211_MAX_MESH_PEERINGS	63
+
+/*
+ * An S1G PPDU TIM PVB uses the notion of pages. Each page can reference
+ * 2048 AIDs, however since mac80211 does not support page slicing we
+ * are reusing the existing TIM bitmap, which supports up to 2008 AIDs.
+ * As the TIM element has a maximum length of 255 bytes, and each encoded
+ * block has a maximum length of 10 bytes at most we can support 25 blocks,
+ * as 1 + 1 + 1 + 25 * 10 = 253 bytes, leaving our maximum AID count for
+ * an S1G PPDU at 25 * 64 = 1600. If page slicing is introduced in the
+ * future, this will need to be modified.
+ */
+#define IEEE80211_MAX_AID_S1G_NO_PS	1600
+#define IEEE80211_MAX_S1G_TIM_BLOCKS	25
+
 /* Maximum size for the MA-UNITDATA primitive, 802.11 standard section
    6.2.1.1.2.
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 00671ae45b2f..26f45d32d4a1 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4882,15 +4882,139 @@ void ieee80211_tx_pending(struct tasklet_struct *t)
 
 /* functions for drivers to get certain frames */
 
+static void ieee80211_beacon_add_tim_pvb(struct ps_data *ps,
+					 struct sk_buff *skb, u8 aid0, u8 *tim)
+{
+	int i, n1 = 0, n2;
+
+	/*
+	 * Find largest even number N1 so that bits numbered 1 through
+	 * (N1 x 8) - 1 in the bitmap are 0 and number N2 so that bits
+	 * (N2 + 1) x 8 through 2007 are 0.
+	 */
+	for (i = 0; i < IEEE80211_MAX_TIM_LEN; i++) {
+		if (ps->tim[i]) {
+			n1 = i & 0xfe;
+			break;
+		}
+	}
+	n2 = n1;
+	for (i = IEEE80211_MAX_TIM_LEN - 1; i >= n1; i--) {
+		if (ps->tim[i]) {
+			n2 = i;
+			break;
+		}
+	}
+
+	/* Bitmap control */
+	skb_put_u8(skb, n1 | aid0);
+	/* Part Virt Bitmap */
+	skb_put_data(skb, ps->tim + n1, n2 - n1 + 1);
+
+	tim[1] = n2 - n1 + 4;
+}
+
+/*
+ * Unlike the non-S1G TIM, which encodes the contiguous range n_first‥n_last,
+ * an S1G TIM transmits the bitmap as a sequence of encoded blocks. Each
+ * encoded block contains the following:
+ *  - one block-control byte,
+ *  - one block-bitmap byte,
+ *  - zero to eight sub-block bytes (one per set bit in the bitmap).
+ *
+ * Each encoded block covers 64 AIDs (8 * 8). mac80211 does not implement
+ * page slicing, so we treat the whole PVB as belonging to a single page
+ * (bitmap-control: page-slice 31, page-index 0) and support at most
+ * 1600 AIDs (25 blocks * 64). We do this to reuse the existing bitmap
+ * and allow for the worst case scenario where every single AID is set to
+ * fit within the TIM maximum length of 255. If page slicing is to be added
+ * a separate bitmap will need to be added to allow up to 8192 AIDs.
+ *
+ * Only encoding-mode 0 (block bitmap, non-inverse) is generated or
+ * recognised; other encoding modes are not supported.
+ */
+static void ieee80211_s1g_beacon_add_tim_pvb(struct ps_data *ps,
+					     struct sk_buff *skb, u8 aid0,
+					     u8 *tim)
+{
+	int blk;
+
+	/*
+	 * Emit a bitmap control block with a page slice number of 31 and a
+	 * page index of 0 which indicates as per IEEE80211-2024 9.4.2.5.1
+	 * that the entire page (2048 bits) indicated by the page index
+	 * is encoded in the partial virtual bitmap.
+	 */
+	skb_put_u8(skb, aid0 | (31 << 1));
+	tim[1]++;
+
+	/* Emit an encoded block for each non-zero sub-block */
+	for (blk = 0; blk < IEEE80211_MAX_S1G_TIM_BLOCKS; blk++) {
+		u8 blk_bmap = 0;
+		int sblk, subcnt = 0;
+
+		for (sblk = 0; sblk < 8; sblk++) {
+			int idx = blk * 8 + sblk;
+
+			if (idx >= IEEE80211_MAX_AID_S1G_NO_PS)
+				break;
+
+			/*
+			 * If the current subblock is non-zero, increase the
+			 * number of subblocks to emit for the current block.
+			 */
+			if (ps->tim[idx]) {
+				blk_bmap |= BIT(sblk);
+				subcnt++;
+			}
+		}
+
+		/* If the current block contains no non-zero sublocks */
+		if (!blk_bmap)
+			continue;
+
+		/*
+		 * Emit a block control byte for the current encoded block
+		 * with an encoding mode of block bitmap (0x0), not inverse
+		 * (0x0) and the current block offset (5 bits)
+		 */
+		skb_put_u8(skb, blk << 3);
+
+		/*
+		 * Emit the block bitmap for the current encoded block which
+		 * contains the present subblocks.
+		 */
+		skb_put_u8(skb, blk_bmap);
+
+		/* Emit the present subblocks */
+		for (sblk = 0; sblk < 8; sblk++) {
+			int idx = blk * 8 + sblk;
+
+			if (!(blk_bmap & BIT(sblk)))
+				continue;
+
+			skb_put_u8(skb, ps->tim[idx]);
+		}
+
+		/*
+		 * Increase the tim length by the current encoded block
+		 * length by block control + block bitmap + n_subblocks where
+		 * n_subblocks represents the number of subblock bytes to emit
+		 * for the current block.
+		 */
+		tim[1] += 1 + 1 + subcnt;
+	}
+}
+
 static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 				       struct ieee80211_link_data *link,
 				       struct ps_data *ps, struct sk_buff *skb,
 				       bool is_template)
 {
 	u8 *pos, *tim;
-	int aid0 = 0;
-	int i, have_bits = 0, n1, n2;
+	int aid0 = 0, have_bits = 0;
 	struct ieee80211_bss_conf *link_conf = link->conf;
+	bool s1g = ieee80211_get_link_sband(link)->band == NL80211_BAND_S1GHZ;
 
 	/* Generate bitmap for TIM only if there are any STAs in power save
 	 * mode. */
@@ -4906,9 +5030,10 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 			ps->dtim_count--;
 	}
 
-	tim = pos = skb_put(skb, 5);
+	pos = skb_put(skb, 4);
+	tim = pos;
 	*pos++ = WLAN_EID_TIM;
-	*pos++ = 3;
+	*pos++ = 2;
 	*pos++ = ps->dtim_count;
 	*pos++ = link_conf->dtim_period;
 
@@ -4918,34 +5043,20 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 	ps->dtim_bc_mc = aid0 == 1;
 
 	if (have_bits) {
-		/* Find largest even number N1 so that bits numbered 1 through
-		 * (N1 x 8) - 1 in the bitmap are 0 and number N2 so that bits
-		 * (N2 + 1) x 8 through 2007 are 0. */
-		n1 = 0;
-		for (i = 0; i < IEEE80211_MAX_TIM_LEN; i++) {
-			if (ps->tim[i]) {
-				n1 = i & 0xfe;
-				break;
-			}
-		}
-		n2 = n1;
-		for (i = IEEE80211_MAX_TIM_LEN - 1; i >= n1; i--) {
-			if (ps->tim[i]) {
-				n2 = i;
-				break;
-			}
-		}
-
-		/* Bitmap control */
-		*pos++ = n1 | aid0;
-		/* Part Virt Bitmap */
-		skb_put_data(skb, ps->tim + n1, n2 - n1 + 1);
-
-		tim[1] = n2 - n1 + 4;
+		if (s1g)
+			ieee80211_s1g_beacon_add_tim_pvb(ps, skb, aid0, tim);
+		else
+			ieee80211_beacon_add_tim_pvb(ps, skb, aid0, tim);
 	} else {
-		*pos++ = aid0; /* Bitmap control */
-
-		if (ieee80211_get_link_sband(link)->band != NL80211_BAND_S1GHZ) {
+		/*
+		 * If there is no buffered unicast traffic for an S1G
+		 * interface, we can exclude the bitmap control. This is in
+		 * contrast to other phy types as they do include the bitmap
+		 * control and pvb even when there is no buffered traffic.
+		 */
+		if (!s1g) {
+			/* Bitmap control */
+			skb_put_u8(skb, aid0);
 			tim[1] = 4;
 			/* Part Virt Bitmap */
 			skb_put_u8(skb, 0);
-- 
2.43.0


