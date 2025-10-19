Return-Path: <linux-wireless+bounces-28046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4128EBEDFCB
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 09:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA1764E1D19
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 07:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BE91F5437;
	Sun, 19 Oct 2025 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAQPN4Qh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4243597A
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760859995; cv=none; b=qpigIl+J8mtgmWT8c2S8KYKI7HXNRQGeZpfuRCVU3ONhHP12bXRikRtAKaYgerKMVltFmO9edYFR65z8dcf6hOq1UoQ8Xp6Hl8SFCC0lfjXei/A/L6912k0b1ImP+tXOqrBEHyT2nb2OKH9DCrhvrlhtMmDAmDcCYdeHJ4VcymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760859995; c=relaxed/simple;
	bh=yQVEhvA1CDOD74YNGv4O2hqxgYpfemiAZAye/+UPbsY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bh4xm3DKPP0ujnZ56I8Fhys7CgSJ/S59jZF63XEGLHE7Ziu1KebTbORSDv1ldMH4Yz7n85BL/syG8bZ7NeV04RJwPKXgR7Qc5+bfKsWxTPimK5zGVQHBhpHM2zOyyyMTgaauemZW2lAzOUWZXnr0I/irZMv4z+yH0dKib08ZDRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAQPN4Qh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760859994; x=1792395994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yQVEhvA1CDOD74YNGv4O2hqxgYpfemiAZAye/+UPbsY=;
  b=kAQPN4QhMmyceRiwROZmXdZUVHwkTfIEyMCcbh+i5eunMpECOH+lR2lh
   lS0aBC5rI9+e6MOibst9mI+n9qMf0POU7fzOQD8JIYYfky+MMvtZGDpNG
   8Gqk2YQ5rAJj67gldhTXPB1bnChngBBGmNLNous8Hu/FT59m5pzH/iRbm
   L9Mi9EkUuhJK2F4C7L2A4MFPS634VOJry+ESrYPEGUlapLDDTxekIJa7S
   XrBX4qATcZJYwaQx8x6S3acyZ+TOMJ1TlQfu1a3cclbcqgcsikxlUxTns
   MSNoOYdyZktewFNeZRBDruZGtzZ9I+GMcfnSmYic0xDwLfLClYeRTKtDk
   A==;
X-CSE-ConnectionGUID: v8PtfFnqSdefqU6oaxngCg==
X-CSE-MsgGUID: dungEG2ZRVaGvPanmQ6L5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74130923"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74130923"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 00:46:33 -0700
X-CSE-ConnectionGUID: NTUN8xxYRYOVbabI467Iew==
X-CSE-MsgGUID: ID2z2OAJQ+6PujTV2FOr4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="213693142"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 00:46:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: add RX flag to report radiotap VHT information
Date: Sun, 19 Oct 2025 10:46:25 +0300
Message-Id: <20251019104612.ed4d3e630b70.I2cf285c20a822698039603f2af00ed9c548f2ee0@changeid>
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
 include/net/ieee80211_radiotap.h |  20 +++++-
 include/net/mac80211.h           |   1 +
 net/mac80211/rx.c                | 104 ++++++++++++++++++++-----------
 3 files changed, 88 insertions(+), 37 deletions(-)

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
index a55085cf4ec4..f41df8e0327e 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1564,6 +1564,7 @@ enum mac80211_rx_flags {
 	RX_FLAG_RADIOTAP_LSIG		= BIT(28),
 	RX_FLAG_NO_PSDU			= BIT(29),
 	RX_FLAG_8023			= BIT(30),
+	RX_FLAG_RADIOTAP_VHT		= BIT(31),
 };
 
 /**
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6af43dfefdd6..387e69e0f180 100644
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
@@ -789,6 +818,9 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 		return NULL;
 	}
 
+	if (status->flag & RX_FLAG_RADIOTAP_VHT)
+		rtap_space += sizeof(struct ieee80211_radiotap_vht);
+
 	if (status->flag & RX_FLAG_RADIOTAP_HE)
 		rtap_space += sizeof(struct ieee80211_radiotap_he);
 
-- 
2.34.1


