Return-Path: <linux-wireless+bounces-25800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA316B0D26B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 09:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A6B1AA4CE2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DE34414;
	Tue, 22 Jul 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="KB/p2emT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDF1581F8
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168644; cv=none; b=MgYUmu6aLjRb1q9+SeTvZDIJEI6DvVq/z4vlIzlfSnwtmmPb+RMdtQrGonJISVA8q7WNO1vN51eSzKYnRcy4svB8PuXZGPhhIDZ9eJ3qIT0t0V0hp/kjEyDP3I8BdIgp5uh9CRX+IKFX5VP6K55YtkCmotoflGA2III98neB7no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168644; c=relaxed/simple;
	bh=qSAQCKWARbQwO3fCI3Sot2sAlokrPLOIjkti1TxyFLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4wS69ufF+ExeiPdMY59/TtL454vRsninqBORA3kZlaRqYsS7P4NJ3jSG8DiQqP7o2N4xbqbOqDdIXkn9mbwi/hKV1momAqrjc8HupY/j5p0K8lOF7kzTF2qmWepta5uucx/+2KNMnO3+6wVp+FqquXvN1isUlvxokYLyyovTE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=KB/p2emT; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b31e076f714so4349847a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 00:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753168641; x=1753773441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20w5ScnOW3Gac/Q6fzOfqQgEuXN/A/rsd9NFbc0sR/0=;
        b=KB/p2emTrL03Xu/TtxjTb8w1uIiS2XGqp2I4aQ62eG6tGZe6SLodbLlWEXAi+ta42V
         M+NRtvMWvbLoWNJNpZrkH0Pon+MI7DsQe6+RtAXJ6K+3YzzpU/63qCP+TL0Kxnajqsju
         ueG2KqXs+fVPOxjZfnXM0J/boTRoW5Qg75e15v9GwI7+vIgW+Gfq2sQVXJDQQngO7GI/
         tQsruTyrF4cbtBe+fiVhaa/m4Hz5BMEUxFxhTmGYkgAYjTfujVw8gCRbLotnMnqMLww3
         /651vhej/Thrsaw218K3gLwwV+pAYT8A4nk70ZWPnadnkMaM6Z+3q9WcOjt7tOXMTKFq
         fhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753168641; x=1753773441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20w5ScnOW3Gac/Q6fzOfqQgEuXN/A/rsd9NFbc0sR/0=;
        b=w8rEYKEJBDW7D4P78SlBO7b2sM4FkFf4gD5EGtNZpRTvX1ZWlWBQ6uTpe65hvqWRaJ
         ts//iYP9j4TPhqiShjYrQxAd8vvlyRjyrRxxMGOYVW/M5lcrQCedBE65DgdvJ+6Vv+Si
         nRdsrVNSN7FViYaY0TCKhK2rvVbQj9LW09Dos34rc6wQbdTUe+i4k90RVWqSak/2GSix
         jtUAxjgPoVBA6ncyQaHzJW+QW/siTn5GEXzil0wok0BfBX0D3Faybsm5pLLJ8R5opH1s
         M3xu3F86DjPcMBZTfc3j/VfHC9JHyZRfrfhmUqWQA28EPvHhD14V1tMbhZCe1NBu0uk7
         BE3A==
X-Gm-Message-State: AOJu0Yx527iGPWwU59V9bfQEYyidQrAM1rR0CwPN9pcI2vyM/8B6T1gb
	uuSc/qJULKIVUOTx7R9i1KzX3bQ8lhCWJU21oFxusBqxdnUEfGzYfkwH+V6sLrr0bdS9BQPBpR9
	ccXB8yWc=
X-Gm-Gg: ASbGncuy6cOxCgYfpKYFLAcpGtHXLL+J4pHr7QhX1HVXL9CNBh2kLg4rQNQ7AVYi8Xi
	QvtJFLA+gfrNwpOzEgpI+q4PSTz1oNpcRHmZMJ2rPu0qTOR4+3P2SyN1+D/Wd1QjRgg4crwN5gX
	vSlK+NiXuM7juHKRCkpbbnElcKv5qrfH6Z0rinDtRQQey97EMdEt1PmnDreS5IrcwOj75nvem/M
	F/vLtnFo0IZIXJufDHEyAIc+7qN1b8Ho0ZpsgVYv5B0loNgzH5l0jgRWdl23KKtoaBF7s5wph0v
	c5TvvtUrcO23qXBYvycj47S6K4EbjAh04gMZCk63XJbUAaBJFw1BNXYqyI2myAJ9A3Q8CATRmYg
	iMOw1rFNrdy+UtzAt439qhHMKrUWulUnAFOfw3uefsi9rNRUbtcvovXUwbv1oceMg5zzw7XMATT
	DeouU=
X-Google-Smtp-Source: AGHT+IEwPgI2PMyh36TsB4cFQ6nVxGyr7VjhrmUJOuruhuGk2ewv9KZrs/y7ut/zER0wIRyQQ75R1w==
X-Received: by 2002:a17:90b:4d0b:b0:312:dbcd:b93d with SMTP id 98e67ed59e1d1-31e3e1f0a8fmr3292875a91.14.1753168641015;
        Tue, 22 Jul 2025 00:17:21 -0700 (PDT)
Received: from localhost.localdomain (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1fa8f1sm11099772a91.22.2025.07.22.00.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:17:20 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next 2/2] wifi: mac80211: support parsing S1G TIM PVB
Date: Tue, 22 Jul 2025 17:16:40 +1000
Message-ID: <20250722071642.875875-3-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing a TIM element from an S1G AP, ensure we correctly
parse based on the S1G PPDU TIM PVB format, allowing an S1G STA
to correctly enter/exit power save states to receive buffered
unicast traffic. Also make sure we don't allocate over the
mac80211 supported S1G PPDU AID count.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/ath/carl9170/rx.c        |  2 +-
 drivers/net/wireless/intersil/p54/txrx.c      |  2 +-
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    |  2 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c     |  2 +-
 include/linux/ieee80211.h                     | 96 +++++++++++++++++--
 net/mac80211/mesh_ps.c                        |  2 +-
 net/mac80211/mlme.c                           | 15 +--
 7 files changed, 101 insertions(+), 20 deletions(-)

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
index 2a73f9e4b0ac..acf59ae631a7 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -234,6 +234,9 @@ static inline u16 ieee80211_sn_sub(u16 sn1, u16 sn2)
 #define IEEE80211_MAX_AID_S1G_NO_PS	1600
 #define IEEE80211_MAX_S1G_TIM_BLOCKS	25
 
+/* IEEE80211-2024 Block Control Encoding */
+#define IEEE80211_S1G_TIM_ENC_MODE_BLOCK	0x00
+
 /* Maximum size for the MA-UNITDATA primitive, 802.11 standard section
    6.2.1.1.2.
 
@@ -4771,15 +4774,8 @@ static inline unsigned long ieee80211_tu_to_usec(unsigned long tu)
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
@@ -4802,6 +4798,88 @@ static inline bool ieee80211_check_tim(const struct ieee80211_tim_ie *tim,
 	return !!(tim->virtual_map[index] & mask);
 }
 
+/* See ieee80211_s1g_beacon_add_tim_pvb for implementation documentation. */
+static inline bool ieee80211_s1g_check_tim(const struct ieee80211_tim_ie *tim,
+					   u8 tim_len, u16 aid)
+{
+	u8 bit_idx = aid & 0x7;
+	u8 sub_idx = (aid >> 3) & 0x7;
+	u8 blk_idx_target = (aid >> 6) & 0x1f;
+	u8 blk_bmap = 0;
+	const u8 *ptr = tim->virtual_map;
+	const u8 *end = (const u8 *)tim + tim_len + 2;
+
+	/*
+	 * When an S1G AP has no buffered unicast traffic, bitmap control and
+	 * PVB are not present.
+	 */
+	if (tim_len < 3)
+		return false;
+
+	/*
+	 * Enumerate each encoded block, for which we need at least block
+	 * control and block bitmap.
+	 */
+	while (ptr + 2 <= end) {
+		u8 blk_ctrl = *ptr++;
+		u8 enc_mode = blk_ctrl & 0x3;
+		u8 blk_idx = blk_ctrl >> 3;
+
+		/* If we are past our target block index, exit */
+		if (blk_idx > blk_idx_target)
+			break;
+
+		/* mac80211 only supports block bitmap encoding */
+		if (enc_mode != IEEE80211_S1G_TIM_ENC_MODE_BLOCK)
+			break;
+
+		/*
+		 * If our target block doesn't exist within the block
+		 * that the current encoded block represents, move to the
+		 * next encoded block.
+		 */
+		blk_bmap = *ptr++;
+		if (blk_idx < blk_idx_target) {
+			ptr += hweight8(blk_bmap);
+			continue;
+		}
+
+		/* Ensure our subblock is present */
+		if (!(blk_bmap & BIT(sub_idx)))
+			break;
+
+		/*
+		 * Count the number of subblocks that appear before our target
+		 * subblock, increment ptr by number of set subblocks.
+		 */
+		if (sub_idx)
+			ptr += hweight8(blk_bmap & GENMASK(sub_idx - 1, 0));
+
+		if (ptr >= end)
+			break;
+
+		/* Check our AID is present in the subblock */
+		return *ptr & BIT(bit_idx);
+	}
+
+	return false;
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
index b4b7ea52c65e..2f893fb6d188 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6348,6 +6348,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	};
 	u8 ap_mld_addr[ETH_ALEN] __aligned(2);
 	unsigned int link_id;
+	u16 max_aid = IEEE80211_MAX_AID;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -6374,10 +6375,12 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	reassoc = ieee80211_is_reassoc_resp(mgmt->frame_control);
 	capab_info = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
 	status_code = le16_to_cpu(mgmt->u.assoc_resp.status_code);
-	if (assoc_data->s1g)
+	if (assoc_data->s1g) {
 		elem_start = mgmt->u.s1g_assoc_resp.variable;
-	else
+		max_aid = IEEE80211_MAX_AID_S1G_NO_PS;
+	} else {
 		elem_start = mgmt->u.assoc_resp.variable;
+	}
 
 	/*
 	 * Note: this may not be perfect, AP might misbehave - if
@@ -6401,8 +6404,6 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 
 	if (elems->aid_resp)
 		aid = le16_to_cpu(elems->aid_resp->aid);
-	else if (assoc_data->s1g)
-		aid = 0; /* TODO */
 	else
 		aid = le16_to_cpu(mgmt->u.assoc_resp.aid);
 
@@ -6447,7 +6448,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		event.u.mlme.reason = status_code;
 		drv_event_callback(sdata->local, sdata, &event);
 	} else {
-		if (aid == 0 || aid > IEEE80211_MAX_AID) {
+		if (aid == 0 || aid > max_aid) {
 			sdata_info(sdata,
 				   "invalid AID value %d (out of range), turn off PS\n",
 				   aid);
@@ -6485,6 +6486,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		}
 
 		sdata->vif.cfg.aid = aid;
+		sdata->vif.cfg.s1g = assoc_data->s1g;
 
 		if (!ieee80211_assoc_success(sdata, mgmt, elems,
 					     elem_start, elem_len)) {
@@ -7432,7 +7434,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
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


