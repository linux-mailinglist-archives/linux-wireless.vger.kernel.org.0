Return-Path: <linux-wireless+bounces-26018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AC2B11F4E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 15:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB247567A4B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9C02ED856;
	Fri, 25 Jul 2025 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="dA530Ug0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D591246780
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449765; cv=none; b=IqCge37FsY7oAlFKzNB31fNGsdK0y1H1DF0uC1KPIpXOFB3Yutj+bIhW761zfnT8OUM6Zr0EfwRkphNq3WZGVlJvXhDFbAIEXjtI7g8njipK6iYFic8UwJLo9QuqYoAzeEnuYXsDlAopgbcGqOv4y3yzl3of4dtLS5lhKJMIBqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449765; c=relaxed/simple;
	bh=syM/7tj9hyF2SzW2Tlku9Qo8RmsRlR8tWHEombqbyzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLcTuXetZPeI3zdJ+V8Ier56xxJmzStQXS0hzA1iif8knaNmyLn60pAV0FbCuc7MOtUbhQOvfQP3WTUrcBmhfj9xRtA0CVmtJmlpgARiq107jK6OMur1AwyxRfhKXRx3O1NanzXsXxgLk89JlAyvZD7ZqtRLgx/99PGjto9I8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=dA530Ug0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so1820868a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753449763; x=1754054563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+KZJ9BEklHHlnu6TCJMdeA1Nduht+vd44UXPpKdDTo=;
        b=dA530Ug0agOps4LjBOwav9WSfLy89L8Yg+3Mq6LTOxAxOcJnl8lPOpoAKsq6y8HLrk
         m44JX4HHHX6w4D5ZzHkfadczI3ANGeg5yIWxKJ4pgnd5WOG4R3/nCiUtklp+4+Zfd58L
         wWMAWuhzIvllQRM15FeWa3aFpdLKcU5j4msME7vAx/0BFujvllJbSM8uns1nf0aFpFTj
         TEyEyz7QnQd7Fbml2cc4SBmIGP+OVQO5U8QbQOihrwYqcZ2nbcaqhDXzV28K5TxYZiCp
         ViqkdPZXN6UUa2PPQpnJ9Wc6qklRHaVuPSZW7iuLs4CjwUg1/clU9kudpz/sI2MtuS/d
         4CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753449763; x=1754054563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+KZJ9BEklHHlnu6TCJMdeA1Nduht+vd44UXPpKdDTo=;
        b=VfMVs5C08OT7MnhrwMdDSwrvwiAYV8btX37Qe6I+yyYk2cEhXesDbJIQFJWL6nz6/L
         OJpIGPL+yksS6f5T3AtFuQqLQSwpLlSxA3u8fzHTCrP1TlpA9XLFWsWGPs+n4K5xWLxL
         dFtMVtiNtyx2wZDUAoo2gk2bSXCRbglWOjrnxAX31VK38Td/KzVDunuX7J8V3QeoFoc4
         DrNXsuJA3iSSNzXQbGL/Y9H7yP5FBKqlgcoRSx8vq46NjOKZe8jUTDEmDxnT5kkI/2xc
         qfWDARhLNokcMZ+eLr53TgdQofjRXQT5zDqeayvMDRPa4dDxhDSijbO+eKs/B+Gkmr4E
         rR0w==
X-Gm-Message-State: AOJu0YwyoWAUzf0XqAWxU1AneAe+RKnpyD08r6zol3cgkLPNhsMTd7PT
	T9fBKzlwlLWdcw0CCq1U0Yp83cSz0JrHBRTpA4WEMJWo9RqJV41Pk75HsRrPUH8lST4=
X-Gm-Gg: ASbGnctmkocWnjOer+G19f9JHjCT+oenwyHkLEDmrHm8oSzdBfNtZISmmctIlj96Jwt
	S7/UWj3/Q6U/M9/6kLo92af1l2GrU+lAw8pTS+gnYWVV2OE87hF7lOjlHUimiCorNHkyD0Loh1L
	k8l1RNryKALJZuRHC4pvDUT4EA0BWPaZQNQ5fE3jrvBknPikmvQ/sZPBPj5jo8DVvCKwryjiQRN
	ouBDdxn1+eRKsKH4lvVN9iUCrmrlG5QKTl1UoKoxVTCin3VTTAtRSYO4sdBp4UiLuTc54bWLahG
	NHoLlZ+OSzwXsrsQwHy6j7aBy2nY1Wqb/jfTazTKbJvfL3YrCZG84QVgqxzuFydgDTBsI48Pfo8
	eG8wivWrueu64q7BDtiPEDHZTaNNK+Ls4WYy8r2g=
X-Google-Smtp-Source: AGHT+IHZUMCA+mG7O6R9zp+dGS07h2We0me8+xxPHaIAC17TMVimY/NFq61aDtmvsAFS6dV3ebpYYg==
X-Received: by 2002:a17:902:ef03:b0:235:e8da:8d1 with SMTP id d9443c01a7336-23fb3050826mr24684555ad.8.1753449762176;
        Fri, 25 Jul 2025 06:22:42 -0700 (PDT)
Received: from mma-H9MHD44.lan ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bd625sm37117665ad.122.2025.07.25.06.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:22:41 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v2 1/3] wifi: mac80211: support block bitmap S1G TIM encoding
Date: Fri, 25 Jul 2025 23:22:19 +1000
Message-ID: <20250725132221.258217-2-lachlan.hodges@morsemicro.com>
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

An S1G TIM PVB is encoded differently compared to a non-s1g TIM PVB.
As the AP dictates which encoding mode it uses, here we only implement
block bitmap encoding. This is the default encoding mode used by
all current vendor implementations.

Additionally, S1G has a maximum AID count of 8192, however we are
limiting the current implementation to 1600. This has no resemblence
to the standard and is purely an implementation detail. The reason for
this is due to the TIM elements maximum length of 255. This allows for,
at most, 25 encoded blocks for a PVB encoded with block bitmap. Support
for the maximum of 8192 AIDs will require an implementation of page slicing
to be added to mac80211.

As a result, we perform extra validation on both the STA and AP side
when receiving an AID as an S1G interface.

Add support for block bitmap encoding for an S1G AP and limit the
maximum AID count to 1600 for the current mac80211 implementations.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---

v1 -> v2:

- Validate the AID for an S1G interface on both the client and AP
- Specify this limitation in the peer AID netlink documentation
- Remove redundant bounds checking in the block bitmap generation
- Cleanup the various TIM functions, use struct element, make caller
  set the length, variable name cleanup etc.
- Move the MAX_AID S1G variables out of the ieee80211.h file and into
  the private ieee80211_i.h file as this is mac80211 specific

---
 include/uapi/linux/nl80211.h |   3 +-
 net/mac80211/cfg.c           |  10 ++-
 net/mac80211/ieee80211_i.h   |   8 ++
 net/mac80211/mlme.c          |  19 ++--
 net/mac80211/tx.c            | 166 +++++++++++++++++++++++++++--------
 5 files changed, 156 insertions(+), 50 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 94360c8f248c..1df99394e140 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2283,7 +2283,8 @@ enum nl80211_commands {
  * @NL80211_ATTR_PEER_AID: Association ID for the peer TDLS station (u16).
  *	This is similar to @NL80211_ATTR_STA_AID but with a difference of being
  *	allowed to be used with the first @NL80211_CMD_SET_STATION command to
- *	update a TDLS peer STA entry.
+ *	update a TDLS peer STA entry. For S1G interfaces, this is limited to
+ *	1600 for the current mac80211 implementation.
  *
  * @NL80211_ATTR_COALESCE_RULE: Coalesce rule information.
  *
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 934b9e3a5088..0f22063529a2 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2193,10 +2193,16 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 
 	/*
 	 * cfg80211 validates this (1-2007) and allows setting the AID
-	 * only when creating a new station entry
+	 * only when creating a new station entry. For S1G APs, the current
+	 * implementation supports a maximum of 1600 AIDs.
 	 */
-	if (params->aid)
+	if (params->aid) {
+		if (sdata->vif.cfg.s1g &&
+		    params->aid > IEEE80211_MAX_SUPPORTED_S1G_AID)
+			return -EINVAL;
+
 		sta->sta.aid = params->aid;
+	}
 
 	/*
 	 * Some of the following updates would be racy if called on an
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8afa2404eaa8..07f5fb11569b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -86,6 +86,14 @@ extern const u8 ieee80211_ac_to_qos_mask[IEEE80211_NUM_ACS];
 
 #define IEEE80211_MAX_NAN_INSTANCE_ID 255
 
+/*
+ * Current mac80211 implementation supports a maximum of 1600 AIDS
+ * for S1G interfaces. With regards to an S1G TIM, this covers 25 blocks
+ * as each block is 64 AIDs.
+ */
+#define IEEE80211_MAX_SUPPORTED_S1G_AID	1600
+#define IEEE80211_MAX_SUPPORTED_S1G_TIM_BLOCKS 25
+
 enum ieee80211_status_data {
 	IEEE80211_STATUS_TYPE_MASK	= 0x00f,
 	IEEE80211_STATUS_TYPE_INVALID	= 0,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cafdbd9fb65f..107a0aaf0a9d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6349,6 +6349,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	};
 	u8 ap_mld_addr[ETH_ALEN] __aligned(2);
 	unsigned int link_id;
+	u16 max_aid = IEEE80211_MAX_AID;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -6375,10 +6376,12 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	reassoc = ieee80211_is_reassoc_resp(mgmt->frame_control);
 	capab_info = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
 	status_code = le16_to_cpu(mgmt->u.assoc_resp.status_code);
-	if (assoc_data->s1g)
+	if (assoc_data->s1g) {
 		elem_start = mgmt->u.s1g_assoc_resp.variable;
-	else
+		max_aid = IEEE80211_MAX_SUPPORTED_S1G_AID;
+	} else {
 		elem_start = mgmt->u.assoc_resp.variable;
+	}
 
 	/*
 	 * Note: this may not be perfect, AP might misbehave - if
@@ -6402,16 +6405,15 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 
 	if (elems->aid_resp)
 		aid = le16_to_cpu(elems->aid_resp->aid);
-	else if (assoc_data->s1g)
-		aid = 0; /* TODO */
 	else
 		aid = le16_to_cpu(mgmt->u.assoc_resp.aid);
 
 	/*
-	 * The 5 MSB of the AID field are reserved
-	 * (802.11-2016 9.4.1.8 AID field)
+	 * The 5 MSB of the AID field are reserved for a non-S1G STA. For
+	 * an S1G STA the 3 MSBs are reserved.
+	 * (802.11-2016 9.4.1.8 AID field).
 	 */
-	aid &= 0x7ff;
+	aid &= assoc_data->s1g ? 0x1fff : 0x7ff;
 
 	sdata_info(sdata,
 		   "RX %sssocResp from %pM (capab=0x%x status=%d aid=%d)\n",
@@ -6448,7 +6450,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		event.u.mlme.reason = status_code;
 		drv_event_callback(sdata->local, sdata, &event);
 	} else {
-		if (aid == 0 || aid > IEEE80211_MAX_AID) {
+		if (aid == 0 || aid > max_aid) {
 			sdata_info(sdata,
 				   "invalid AID value %d (out of range), turn off PS\n",
 				   aid);
@@ -6486,6 +6488,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		}
 
 		sdata->vif.cfg.aid = aid;
+		sdata->vif.cfg.s1g = assoc_data->s1g;
 
 		if (!ieee80211_assoc_success(sdata, mgmt, elems,
 					     elem_start, elem_len)) {
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 00671ae45b2f..0ece8d89e094 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4882,15 +4882,114 @@ void ieee80211_tx_pending(struct tasklet_struct *t)
 
 /* functions for drivers to get certain frames */
 
+static void ieee80211_beacon_add_tim_pvb(struct ps_data *ps,
+					 struct sk_buff *skb,
+					 bool mcast_traffic)
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
+	skb_put_u8(skb, n1 | mcast_traffic);
+	/* Part Virt Bitmap */
+	skb_put_data(skb, ps->tim + n1, n2 - n1 + 1);
+}
+
+/*
+ * mac80211 currently supports encoding using block bitmap mode, non
+ * inversed. The current implementation supports up to 1600 AIDs.
+ *
+ * Block bitmap encoding breaks down the AID bitmap into blocks of 64
+ * AIDs. Each block contains between 0 and 8 subblocks. Each subblock
+ * describes 8 AIDs and the presence of a subblock is determined by
+ * the block bitmap.
+ */
+static void ieee80211_s1g_beacon_add_tim_pvb(struct ps_data *ps,
+					     struct sk_buff *skb,
+					     bool mcast_traffic)
+{
+	int blk;
+
+	/*
+	 * Emit a bitmap control block with a page slice number of 31 and a
+	 * page index of 0 which indicates as per IEEE80211-2024 9.4.2.5.1
+	 * that the entire page (2048 bits) indicated by the page index
+	 * is encoded in the partial virtual bitmap.
+	 */
+	skb_put_u8(skb, mcast_traffic | (31 << 1));
+
+	/* Emit an encoded block for each non-zero sub-block */
+	for (blk = 0; blk < IEEE80211_MAX_SUPPORTED_S1G_TIM_BLOCKS; blk++) {
+		u8 blk_bmap = 0;
+		int sblk;
+
+		for (sblk = 0; sblk < 8; sblk++) {
+			int sblk_idx = blk * 8 + sblk;
+
+			/*
+			 * If the current subblock is non-zero, increase the
+			 * number of subblocks to emit for the current block.
+			 */
+			if (ps->tim[sblk_idx])
+				blk_bmap |= BIT(sblk);
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
+			int sblk_idx = blk * 8 + sblk;
+
+			if (!(blk_bmap & BIT(sblk)))
+				continue;
+
+			skb_put_u8(skb, ps->tim[sblk_idx]);
+		}
+	}
+}
+
 static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 				       struct ieee80211_link_data *link,
 				       struct ps_data *ps, struct sk_buff *skb,
 				       bool is_template)
 {
-	u8 *pos, *tim;
-	int aid0 = 0;
-	int i, have_bits = 0, n1, n2;
+	struct element *tim;
+	bool mcast_traffic = false, have_bits = false;
 	struct ieee80211_bss_conf *link_conf = link->conf;
+	bool s1g = ieee80211_get_link_sband(link)->band == NL80211_BAND_S1GHZ;
 
 	/* Generate bitmap for TIM only if there are any STAs in power save
 	 * mode. */
@@ -4898,7 +4997,8 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 		/* in the hope that this is faster than
 		 * checking byte-for-byte */
 		have_bits = !bitmap_empty((unsigned long *)ps->tim,
-					  IEEE80211_MAX_AID+1);
+					  IEEE80211_MAX_AID + 1);
+
 	if (!is_template) {
 		if (ps->dtim_count == 0)
 			ps->dtim_count = link_conf->dtim_period - 1;
@@ -4906,51 +5006,39 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 			ps->dtim_count--;
 	}
 
-	tim = pos = skb_put(skb, 5);
-	*pos++ = WLAN_EID_TIM;
-	*pos++ = 3;
-	*pos++ = ps->dtim_count;
-	*pos++ = link_conf->dtim_period;
+	/* Length is set after parsing the AID bitmap */
+	tim = skb_put(skb, sizeof(struct element));
+	tim->id = WLAN_EID_TIM;
+	skb_put_u8(skb, ps->dtim_count);
+	skb_put_u8(skb, link_conf->dtim_period);
 
 	if (ps->dtim_count == 0 && !skb_queue_empty(&ps->bc_buf))
-		aid0 = 1;
+		mcast_traffic = true;
 
-	ps->dtim_bc_mc = aid0 == 1;
+	ps->dtim_bc_mc = mcast_traffic;
 
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
+			ieee80211_s1g_beacon_add_tim_pvb(ps, skb,
+							 mcast_traffic);
+		else
+			ieee80211_beacon_add_tim_pvb(ps, skb, mcast_traffic);
 	} else {
-		*pos++ = aid0; /* Bitmap control */
-
-		if (ieee80211_get_link_sband(link)->band != NL80211_BAND_S1GHZ) {
-			tim[1] = 4;
+		/*
+		 * If there is no buffered unicast traffic for an S1G
+		 * interface, we can exclude the bitmap control. This is in
+		 * contrast to other phy types as they do include the bitmap
+		 * control and pvb even when there is no buffered traffic.
+		 */
+		if (!s1g) {
+			/* Bitmap control */
+			skb_put_u8(skb, mcast_traffic);
 			/* Part Virt Bitmap */
 			skb_put_u8(skb, 0);
 		}
 	}
+
+	tim->datalen = skb_tail_pointer(skb) - tim->data;
 }
 
 static int ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
-- 
2.43.0


