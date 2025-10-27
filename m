Return-Path: <linux-wireless+bounces-28309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFEAC0D7CB
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 13:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 409CD4F49EC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014D82FD7DD;
	Mon, 27 Oct 2025 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzJvY46V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE063019AD
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567744; cv=none; b=FSAwsqwTSuRqdmG2NrF8gBnrLBZ4dk/HTD7sVLcVHz0qOBNLjuI+WtjdNyYWUg+AWgQFnZUEB0wxs1uNM6dzlfD6i+5yRqsg0HTJ5vu0wh0pn21pkvmrD5MCpZrqIteqbgIB5+wrSp2KHnfGYdb4TqO73jO/xm3hLNcPo1//9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567744; c=relaxed/simple;
	bh=jmX1VxW/MtEjn2MXwdGjdsbv+CJiyUlsR6BosOubk64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IIC4agX/LE/wBMEgSqdAHuBbAEOfXPQWMWOlqx29LWuX5TA/S0KXvhTcCqhr8auAZPwypEkESlqmUsdm921aK4ivxXVtSETgVTtvD+HAe/r5CziQv17nggJJjTSVqjTsQ6yIYAglkcOc4bemP/8L+/3XBScS9t8Kxpvwudmu5ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzJvY46V; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761567743; x=1793103743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jmX1VxW/MtEjn2MXwdGjdsbv+CJiyUlsR6BosOubk64=;
  b=fzJvY46VnlNVBgIzBYGqbg6WCk89H/y4G5vCkGJgffKT+PHTNfCdcMb6
   OBxmfq7kS+54MbroRgkKLuZIGulo1XDAPtcG2gLZrvdi9mpB50KH/kWpq
   olbu4ACv3xKdDyH79YVZLkGF6G1Ra2TNq4CZUDleBlbFGq7/Z3Cmd/Z6K
   BHfz3+1PWggXf+tOZ1r/VWKkikb0Ekbptvr4DhdGzoK4QzY0AXmK7tReg
   D91mSJJqusgmUgAYE/8mNjw/DxYWWXMpd6NlJ8JDnE4WIu3tqN55u29si
   +qdvHJckjZrmpWLPwDcCzVBY+6ymmNiQZkiWzMVmsgjiulke9H47yU3We
   A==;
X-CSE-ConnectionGUID: qMHYLCIjQCaFEVcrbiXtwQ==
X-CSE-MsgGUID: NWzM1yxtS6CrIZ6KV41ekg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63794357"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63794357"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:22:22 -0700
X-CSE-ConnectionGUID: M4zKhbeWT/meaXhXZYGEkw==
X-CSE-MsgGUID: XK9jYZJETaqIyD6MWP3Lxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="189343042"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:22:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v3] wifi: mac80211: add RX flag to report radiotap VHT information
Date: Mon, 27 Oct 2025 14:22:14 +0200
Message-Id: <20251027142118.0bad1c307a21.I2cf285c20a822698039603f2af00ed9c548f2ee0@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

mac80211 already reports some basic information in the radiotap header
with the known fields declared by the driver. However, drivers may want
to report more accurate information and in that case the full VHT
radiotap structure needs to be provided.

Add a new RX_FLAG_RADIOTAP_VHT which is set when the VHT information
should be pulled from the skb. Update the code to fill in the VHT fields
to only do so when requested by the driver or if the information has not
yet been set. This way the driver can fully control the information if
it chooses so.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: add the destination tree to the subject
v3: fix kernel documentation

 include/net/ieee80211_radiotap.h |  20 +++++-
 include/net/mac80211.h           |   2 +
 net/mac80211/rx.c                | 104 ++++++++++++++++++++-----------
 3 files changed, 89 insertions(+), 37 deletions(-)

diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 813e163ce27c..c60867e7e43c 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (c) 2017		Intel Deutschland GmbH
- * Copyright (c) 2018-2019, 2021-2022 Intel Corporation
+ * Copyright (c) 2018-2019, 2021-2022, 2025 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -202,6 +202,24 @@ enum ieee80211_radiotap_vht_coding {
 	IEEE80211_RADIOTAP_CODING_LDPC_USER3 = 0x08,
 };
 
+enum ieee80211_radiotap_vht_bandwidth {
+	/* Note: more values are defined but can't really be used */
+	IEEE80211_RADIOTAP_VHT_BW_20		= 0,
+	IEEE80211_RADIOTAP_VHT_BW_40		= 1,
+	IEEE80211_RADIOTAP_VHT_BW_80		= 4,
+	IEEE80211_RADIOTAP_VHT_BW_160		= 11,
+};
+
+struct ieee80211_radiotap_vht {
+	__le16 known;
+	u8 flags;
+	u8 bandwidth;
+	u8 mcs_nss[4];
+	u8 coding;
+	u8 group_id;
+	__le16 partial_aid;
+} __packed;
+
 /* for IEEE80211_RADIOTAP_TIMESTAMP */
 enum ieee80211_radiotap_timestamp_unit_spos {
 	IEEE80211_RADIOTAP_TIMESTAMP_UNIT_MASK = 0x000F,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a55085cf4ec4..c326243e1f01 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1529,6 +1529,7 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
  *	known the frame shouldn't be reported.
  * @RX_FLAG_8023: the frame has an 802.3 header (decap offload performed by
  *	hardware or driver)
+ * @RX_FLAG_RADIOTAP_VHT: VHT radiotap data is present
  */
 enum mac80211_rx_flags {
 	RX_FLAG_MMIC_ERROR		= BIT(0),
@@ -1564,6 +1565,7 @@ enum mac80211_rx_flags {
 	RX_FLAG_RADIOTAP_LSIG		= BIT(28),
 	RX_FLAG_NO_PSDU			= BIT(29),
 	RX_FLAG_8023			= BIT(30),
+	RX_FLAG_RADIOTAP_VHT		= BIT(31),
 };
 
 /**
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4641a2a80856..b59aeed340b3 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -59,7 +59,8 @@ static struct sk_buff *ieee80211_clean_skb(struct sk_buff *skb,
 	status->flag &= ~(RX_FLAG_RADIOTAP_TLV_AT_END |
 			  RX_FLAG_RADIOTAP_LSIG |
 			  RX_FLAG_RADIOTAP_HE_MU |
-			  RX_FLAG_RADIOTAP_HE);
+			  RX_FLAG_RADIOTAP_HE |
+			  RX_FLAG_RADIOTAP_VHT);
 
 	hdr = (void *)skb->data;
 	fc = hdr->frame_control;
@@ -151,8 +152,10 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 	}
 
 	if (status->encoding == RX_ENC_VHT) {
+		/* Included even if RX_FLAG_RADIOTAP_VHT is not set */
 		len = ALIGN(len, 2);
 		len += 12;
+		BUILD_BUG_ON(sizeof(struct ieee80211_radiotap_vht) != 12);
 	}
 
 	if (local->hw.radiotap_timestamp.units_pos >= 0) {
@@ -195,6 +198,9 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 		 * The position to look at depends on the existence (or non-
 		 * existence) of other elements, so take that into account...
 		 */
+		if (status->flag & RX_FLAG_RADIOTAP_VHT)
+			tlv_offset +=
+				sizeof(struct ieee80211_radiotap_vht);
 		if (status->flag & RX_FLAG_RADIOTAP_HE)
 			tlv_offset +=
 				sizeof(struct ieee80211_radiotap_he);
@@ -319,10 +325,17 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 	u32 tlvs_len = 0;
 	int mpdulen, chain;
 	unsigned long chains = status->chains;
+	struct ieee80211_radiotap_vht vht = {};
 	struct ieee80211_radiotap_he he = {};
 	struct ieee80211_radiotap_he_mu he_mu = {};
 	struct ieee80211_radiotap_lsig lsig = {};
 
+	if (status->flag & RX_FLAG_RADIOTAP_VHT) {
+		vht = *(struct ieee80211_radiotap_vht *)skb->data;
+		skb_pull(skb, sizeof(vht));
+		WARN_ON_ONCE(status->encoding != RX_ENC_VHT);
+	}
+
 	if (status->flag & RX_FLAG_RADIOTAP_HE) {
 		he = *(struct ieee80211_radiotap_he *)skb->data;
 		skb_pull(skb, sizeof(he));
@@ -530,45 +543,61 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 	}
 
 	if (status->encoding == RX_ENC_VHT) {
-		u16 known = local->hw.radiotap_vht_details;
+		u16 fill = local->hw.radiotap_vht_details;
 
-		rthdr->it_present |= cpu_to_le32(BIT(IEEE80211_RADIOTAP_VHT));
-		put_unaligned_le16(known, pos);
-		pos += 2;
-		/* flags */
-		if (status->enc_flags & RX_ENC_FLAG_SHORT_GI)
-			*pos |= IEEE80211_RADIOTAP_VHT_FLAG_SGI;
+		/* Leave driver filled fields alone */
+		fill &= ~le16_to_cpu(vht.known);
+		vht.known |= cpu_to_le16(fill);
+
+		if (fill & IEEE80211_RADIOTAP_VHT_KNOWN_GI &&
+		    status->enc_flags & RX_ENC_FLAG_SHORT_GI)
+			vht.flags |= IEEE80211_RADIOTAP_VHT_FLAG_SGI;
 		/* in VHT, STBC is binary */
-		if (status->enc_flags & RX_ENC_FLAG_STBC_MASK)
-			*pos |= IEEE80211_RADIOTAP_VHT_FLAG_STBC;
-		if (status->enc_flags & RX_ENC_FLAG_BF)
+		if (fill & IEEE80211_RADIOTAP_VHT_KNOWN_STBC &&
+		    status->enc_flags & RX_ENC_FLAG_STBC_MASK)
+			vht.flags |= IEEE80211_RADIOTAP_VHT_FLAG_STBC;
+		if (fill & IEEE80211_RADIOTAP_VHT_KNOWN_BEAMFORMED &&
+		    status->enc_flags & RX_ENC_FLAG_BF)
 			*pos |= IEEE80211_RADIOTAP_VHT_FLAG_BEAMFORMED;
-		pos++;
-		/* bandwidth */
-		switch (status->bw) {
-		case RATE_INFO_BW_80:
-			*pos++ = 4;
-			break;
-		case RATE_INFO_BW_160:
-			*pos++ = 11;
-			break;
-		case RATE_INFO_BW_40:
-			*pos++ = 1;
-			break;
-		default:
-			*pos++ = 0;
+
+		if (fill & IEEE80211_RADIOTAP_VHT_KNOWN_BANDWIDTH) {
+			switch (status->bw) {
+			case RATE_INFO_BW_40:
+				vht.bandwidth = IEEE80211_RADIOTAP_VHT_BW_40;
+				break;
+			case RATE_INFO_BW_80:
+				vht.bandwidth = IEEE80211_RADIOTAP_VHT_BW_80;
+				break;
+			case RATE_INFO_BW_160:
+				vht.bandwidth = IEEE80211_RADIOTAP_VHT_BW_160;
+				break;
+			default:
+				vht.bandwidth = IEEE80211_RADIOTAP_VHT_BW_20;
+				break;
+			}
 		}
-		/* MCS/NSS */
-		*pos = (status->rate_idx << 4) | status->nss;
-		pos += 4;
-		/* coding field */
-		if (status->enc_flags & RX_ENC_FLAG_LDPC)
-			*pos |= IEEE80211_RADIOTAP_CODING_LDPC_USER0;
-		pos++;
-		/* group ID */
-		pos++;
-		/* partial_aid */
-		pos += 2;
+
+		/*
+		 * If the driver filled in mcs_nss[0], then do not touch it.
+		 *
+		 * Otherwise, put some information about MCS/NSS into the
+		 * user 0 field. Note that this is not technically correct for
+		 * an MU frame as we might have decoded a different user.
+		 */
+		if (!vht.mcs_nss[0]) {
+			vht.mcs_nss[0] = (status->rate_idx << 4) | status->nss;
+
+			/* coding field */
+			if (status->enc_flags & RX_ENC_FLAG_LDPC)
+				vht.coding |= IEEE80211_RADIOTAP_CODING_LDPC_USER0;
+		}
+
+		/* ensure 2 byte alignment */
+		while ((pos - (u8 *)rthdr) & 1)
+			pos++;
+		rthdr->it_present |= cpu_to_le32(BIT(IEEE80211_RADIOTAP_VHT));
+		memcpy(pos, &vht, sizeof(vht));
+		pos += sizeof(vht);
 	}
 
 	if (local->hw.radiotap_timestamp.units_pos >= 0) {
@@ -834,6 +863,9 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 		return NULL;
 	}
 
+	if (status->flag & RX_FLAG_RADIOTAP_VHT)
+		rtap_space += sizeof(struct ieee80211_radiotap_vht);
+
 	if (status->flag & RX_FLAG_RADIOTAP_HE)
 		rtap_space += sizeof(struct ieee80211_radiotap_he);
 
-- 
2.34.1


