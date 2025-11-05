Return-Path: <linux-wireless+bounces-28607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2CCC361B1
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 15:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33DF44F823D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D396F32ED43;
	Wed,  5 Nov 2025 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dwG6iC2g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4329732E6AE
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353534; cv=none; b=M2+kZl4YvYPsFhUPMDMCStDG9FY5vh/kjWmzAud6T568UDw6ph/H3ieYvGochknogRhu2YhJRvBtd2kAsF9/UD9xNPVRa8grOoplF1mGF0W/kNd8FKBuxx84Vwoi1IEPZKL/V1ndd0QFjwj2UqE6AINeZkSGJA1izoZkTHGHlWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353534; c=relaxed/simple;
	bh=1k1HAkvXx3xPN0G+6184D93cOyOiaF0LvNVCSGJbRck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUc7/ElQzqAkgeAo3HQ6d31yZXKyuVqrCJw9ZOtV21IzNhYJTXrmwFTtEth2hlL8VUa6pF6nhd/gaNuLtM2ZgvUuNpTLZixbsHMox3U7YnKcTDHWvVRY6oGtlzZYcYDna1TbupiSbj5qfhIAmeU4p8vVIanaHH08gqdK+jNf95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dwG6iC2g; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Pt5bSTNUpsz4I6O0kf7BiYvlGyTRUR4gfApmuOzoFMo=;
	t=1762353532; x=1763563132; b=dwG6iC2gdE1n9nnWiR7KUgAJviE0Gu8+HBHdU2STFk/0G/F
	LW9R1RmcsW9IjCHfn5rjaefTfd/iUmKPrl3FluTa7k0AKXZtJEXpCuM55Uc0HYbTnlOLgbMU76Rk+
	hh6OzBPdiGMoHCvAOeiQe1RiaEyFg7CZOBQUGa6H8jHjVNsG97bs2km5BBp1+uuxtPMTsvHtvr9cS
	/nDHYit7ICHneBIkGNWqGWF9LPkgZMDMJVewLff6p3I19tNOnfACqVFl3HTwqFcg++xaOOPCcBU6h
	neBkoxMqcYVoswRL2Quua2bIUAt5qfN5rfx1QPri4HlswV3UyrPAdhwD4U051hng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGeev-0000000FDcs-1bvG;
	Wed, 05 Nov 2025 15:38:49 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 3/8] wifi: ieee80211: split VHT definitions out
Date: Wed,  5 Nov 2025 15:36:51 +0100
Message-ID: <20251105153843.c31cb771a250.I787a13064db7d80440101de3445be17881daf1b6@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105143843.46279-10-johannes@sipsolutions.net>
References: <20251105143843.46279-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The ieee80211.h file has gotten very long, continue splitting
it by putting VHT definitions into a separate file.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211-vht.h | 236 ++++++++++++++++++++++++++++++++++
 include/linux/ieee80211.h     | 216 +------------------------------
 2 files changed, 237 insertions(+), 215 deletions(-)
 create mode 100644 include/linux/ieee80211-vht.h

diff --git a/include/linux/ieee80211-vht.h b/include/linux/ieee80211-vht.h
new file mode 100644
index 000000000000..898dfb561fef
--- /dev/null
+++ b/include/linux/ieee80211-vht.h
@@ -0,0 +1,236 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * IEEE 802.11 VHT definitions
+ *
+ * Copyright (c) 2001-2002, SSH Communications Security Corp and Jouni Malinen
+ * <jkmaline@cc.hut.fi>
+ * Copyright (c) 2002-2003, Jouni Malinen <jkmaline@cc.hut.fi>
+ * Copyright (c) 2005, Devicescape Software, Inc.
+ * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
+ * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
+ * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright (c) 2018 - 2025 Intel Corporation
+ */
+
+#ifndef LINUX_IEEE80211_VHT_H
+#define LINUX_IEEE80211_VHT_H
+
+#include <linux/types.h>
+#include <linux/if_ether.h>
+
+#define IEEE80211_MAX_MPDU_LEN_VHT_3895		3895
+#define IEEE80211_MAX_MPDU_LEN_VHT_7991		7991
+#define IEEE80211_MAX_MPDU_LEN_VHT_11454	11454
+
+/**
+ * enum ieee80211_vht_opmode_bits - VHT operating mode field bits
+ * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK: channel width mask
+ * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_20MHZ: 20 MHz channel width
+ * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_40MHZ: 40 MHz channel width
+ * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_80MHZ: 80 MHz channel width
+ * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_160MHZ: 160 MHz or 80+80 MHz channel width
+ * @IEEE80211_OPMODE_NOTIF_BW_160_80P80: 160 / 80+80 MHz indicator flag
+ * @IEEE80211_OPMODE_NOTIF_RX_NSS_MASK: number of spatial streams mask
+ *	(the NSS value is the value of this field + 1)
+ * @IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT: number of spatial streams shift
+ * @IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF: indicates streams in SU-MIMO PPDU
+ *	using a beamforming steering matrix
+ */
+enum ieee80211_vht_opmode_bits {
+	IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK	= 0x03,
+	IEEE80211_OPMODE_NOTIF_CHANWIDTH_20MHZ	= 0,
+	IEEE80211_OPMODE_NOTIF_CHANWIDTH_40MHZ	= 1,
+	IEEE80211_OPMODE_NOTIF_CHANWIDTH_80MHZ	= 2,
+	IEEE80211_OPMODE_NOTIF_CHANWIDTH_160MHZ	= 3,
+	IEEE80211_OPMODE_NOTIF_BW_160_80P80	= 0x04,
+	IEEE80211_OPMODE_NOTIF_RX_NSS_MASK	= 0x70,
+	IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT	= 4,
+	IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF	= 0x80,
+};
+
+/*
+ * Maximum length of AMPDU that the STA can receive in VHT.
+ * Length = 2 ^ (13 + max_ampdu_length_exp) - 1 (octets)
+ */
+enum ieee80211_vht_max_ampdu_length_exp {
+	IEEE80211_VHT_MAX_AMPDU_8K = 0,
+	IEEE80211_VHT_MAX_AMPDU_16K = 1,
+	IEEE80211_VHT_MAX_AMPDU_32K = 2,
+	IEEE80211_VHT_MAX_AMPDU_64K = 3,
+	IEEE80211_VHT_MAX_AMPDU_128K = 4,
+	IEEE80211_VHT_MAX_AMPDU_256K = 5,
+	IEEE80211_VHT_MAX_AMPDU_512K = 6,
+	IEEE80211_VHT_MAX_AMPDU_1024K = 7
+};
+
+/**
+ * struct ieee80211_vht_mcs_info - VHT MCS information
+ * @rx_mcs_map: RX MCS map 2 bits for each stream, total 8 streams
+ * @rx_highest: Indicates highest long GI VHT PPDU data rate
+ *	STA can receive. Rate expressed in units of 1 Mbps.
+ *	If this field is 0 this value should not be used to
+ *	consider the highest RX data rate supported.
+ *	The top 3 bits of this field indicate the Maximum NSTS,total
+ *	(a beamformee capability.)
+ * @tx_mcs_map: TX MCS map 2 bits for each stream, total 8 streams
+ * @tx_highest: Indicates highest long GI VHT PPDU data rate
+ *	STA can transmit. Rate expressed in units of 1 Mbps.
+ *	If this field is 0 this value should not be used to
+ *	consider the highest TX data rate supported.
+ *	The top 2 bits of this field are reserved, the
+ *	3rd bit from the top indiciates VHT Extended NSS BW
+ *	Capability.
+ */
+struct ieee80211_vht_mcs_info {
+	__le16 rx_mcs_map;
+	__le16 rx_highest;
+	__le16 tx_mcs_map;
+	__le16 tx_highest;
+} __packed;
+
+/* for rx_highest */
+#define IEEE80211_VHT_MAX_NSTS_TOTAL_SHIFT	13
+#define IEEE80211_VHT_MAX_NSTS_TOTAL_MASK	(7 << IEEE80211_VHT_MAX_NSTS_TOTAL_SHIFT)
+
+/* for tx_highest */
+#define IEEE80211_VHT_EXT_NSS_BW_CAPABLE	(1 << 13)
+
+/**
+ * enum ieee80211_vht_mcs_support - VHT MCS support definitions
+ * @IEEE80211_VHT_MCS_SUPPORT_0_7: MCSes 0-7 are supported for the
+ *	number of streams
+ * @IEEE80211_VHT_MCS_SUPPORT_0_8: MCSes 0-8 are supported
+ * @IEEE80211_VHT_MCS_SUPPORT_0_9: MCSes 0-9 are supported
+ * @IEEE80211_VHT_MCS_NOT_SUPPORTED: This number of streams isn't supported
+ *
+ * These definitions are used in each 2-bit subfield of the @rx_mcs_map
+ * and @tx_mcs_map fields of &struct ieee80211_vht_mcs_info, which are
+ * both split into 8 subfields by number of streams. These values indicate
+ * which MCSes are supported for the number of streams the value appears
+ * for.
+ */
+enum ieee80211_vht_mcs_support {
+	IEEE80211_VHT_MCS_SUPPORT_0_7	= 0,
+	IEEE80211_VHT_MCS_SUPPORT_0_8	= 1,
+	IEEE80211_VHT_MCS_SUPPORT_0_9	= 2,
+	IEEE80211_VHT_MCS_NOT_SUPPORTED	= 3,
+};
+
+/**
+ * struct ieee80211_vht_cap - VHT capabilities
+ *
+ * This structure is the "VHT capabilities element" as
+ * described in 802.11ac D3.0 8.4.2.160
+ * @vht_cap_info: VHT capability info
+ * @supp_mcs: VHT MCS supported rates
+ */
+struct ieee80211_vht_cap {
+	__le32 vht_cap_info;
+	struct ieee80211_vht_mcs_info supp_mcs;
+} __packed;
+
+/**
+ * enum ieee80211_vht_chanwidth - VHT channel width
+ * @IEEE80211_VHT_CHANWIDTH_USE_HT: use the HT operation IE to
+ *	determine the channel width (20 or 40 MHz)
+ * @IEEE80211_VHT_CHANWIDTH_80MHZ: 80 MHz bandwidth
+ * @IEEE80211_VHT_CHANWIDTH_160MHZ: 160 MHz bandwidth
+ * @IEEE80211_VHT_CHANWIDTH_80P80MHZ: 80+80 MHz bandwidth
+ */
+enum ieee80211_vht_chanwidth {
+	IEEE80211_VHT_CHANWIDTH_USE_HT		= 0,
+	IEEE80211_VHT_CHANWIDTH_80MHZ		= 1,
+	IEEE80211_VHT_CHANWIDTH_160MHZ		= 2,
+	IEEE80211_VHT_CHANWIDTH_80P80MHZ	= 3,
+};
+
+/**
+ * struct ieee80211_vht_operation - VHT operation IE
+ *
+ * This structure is the "VHT operation element" as
+ * described in 802.11ac D3.0 8.4.2.161
+ * @chan_width: Operating channel width
+ * @center_freq_seg0_idx: center freq segment 0 index
+ * @center_freq_seg1_idx: center freq segment 1 index
+ * @basic_mcs_set: VHT Basic MCS rate set
+ */
+struct ieee80211_vht_operation {
+	u8 chan_width;
+	u8 center_freq_seg0_idx;
+	u8 center_freq_seg1_idx;
+	__le16 basic_mcs_set;
+} __packed;
+
+/* 802.11ac VHT Capabilities */
+#define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895			0x00000000
+#define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991			0x00000001
+#define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454			0x00000002
+#define IEEE80211_VHT_CAP_MAX_MPDU_MASK				0x00000003
+#define IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ		0x00000004
+#define IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ	0x00000008
+#define IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK			0x0000000C
+#define IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_SHIFT			2
+#define IEEE80211_VHT_CAP_RXLDPC				0x00000010
+#define IEEE80211_VHT_CAP_SHORT_GI_80				0x00000020
+#define IEEE80211_VHT_CAP_SHORT_GI_160				0x00000040
+#define IEEE80211_VHT_CAP_TXSTBC				0x00000080
+#define IEEE80211_VHT_CAP_RXSTBC_1				0x00000100
+#define IEEE80211_VHT_CAP_RXSTBC_2				0x00000200
+#define IEEE80211_VHT_CAP_RXSTBC_3				0x00000300
+#define IEEE80211_VHT_CAP_RXSTBC_4				0x00000400
+#define IEEE80211_VHT_CAP_RXSTBC_MASK				0x00000700
+#define IEEE80211_VHT_CAP_RXSTBC_SHIFT				8
+#define IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE			0x00000800
+#define IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE			0x00001000
+#define IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT                  13
+#define IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK			\
+		(7 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT)
+#define IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT		16
+#define IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK		\
+		(7 << IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT)
+#define IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE			0x00080000
+#define IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE			0x00100000
+#define IEEE80211_VHT_CAP_VHT_TXOP_PS				0x00200000
+#define IEEE80211_VHT_CAP_HTC_VHT				0x00400000
+#define IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT	23
+#define IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK	\
+		(7 << IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT)
+#define IEEE80211_VHT_CAP_VHT_LINK_ADAPTATION_VHT_UNSOL_MFB	0x08000000
+#define IEEE80211_VHT_CAP_VHT_LINK_ADAPTATION_VHT_MRQ_MFB	0x0c000000
+#define IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN			0x10000000
+#define IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN			0x20000000
+#define IEEE80211_VHT_CAP_EXT_NSS_BW_SHIFT			30
+#define IEEE80211_VHT_CAP_EXT_NSS_BW_MASK			0xc0000000
+
+/**
+ * ieee80211_get_vht_max_nss - return max NSS for a given bandwidth/MCS
+ * @cap: VHT capabilities of the peer
+ * @bw: bandwidth to use
+ * @mcs: MCS index to use
+ * @ext_nss_bw_capable: indicates whether or not the local transmitter
+ *	(rate scaling algorithm) can deal with the new logic
+ *	(dot11VHTExtendedNSSBWCapable)
+ * @max_vht_nss: current maximum NSS as advertised by the STA in
+ *	operating mode notification, can be 0 in which case the
+ *	capability data will be used to derive this (from MCS support)
+ * Return: The maximum NSS that can be used for the given bandwidth/MCS
+ *	combination
+ *
+ * Due to the VHT Extended NSS Bandwidth Support, the maximum NSS can
+ * vary for a given BW/MCS. This function parses the data.
+ *
+ * Note: This function is exported by cfg80211.
+ */
+int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
+			      enum ieee80211_vht_chanwidth bw,
+			      int mcs, bool ext_nss_bw_capable,
+			      unsigned int max_vht_nss);
+
+/* VHT action codes */
+enum ieee80211_vht_actioncode {
+	WLAN_VHT_ACTION_COMPRESSED_BF = 0,
+	WLAN_VHT_ACTION_GROUPID_MGMT = 1,
+	WLAN_VHT_ACTION_OPMODE_NOTIF = 2,
+};
+
+#endif /* LINUX_IEEE80211_VHT_H */
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 0a9b4a8025cd..0b247b28c661 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -239,10 +239,6 @@ static inline u16 ieee80211_sn_sub(u16 sn1, u16 sn2)
 /* 30 byte 4 addr hdr, 2 byte QoS, 2304 byte MSDU, 12 byte crypt, 4 byte FCS */
 #define IEEE80211_MAX_FRAME_LEN		2352
 
-#define IEEE80211_MAX_MPDU_LEN_VHT_3895		3895
-#define IEEE80211_MAX_MPDU_LEN_VHT_7991		7991
-#define IEEE80211_MAX_MPDU_LEN_VHT_11454	11454
-
 #define IEEE80211_MAX_SSID_LEN		32
 
 #define IEEE80211_FIRST_TSPEC_TSID	8
@@ -988,32 +984,6 @@ struct ieee80211_tim_ie {
 	};
 } __packed;
 
-/**
- * enum ieee80211_vht_opmode_bits - VHT operating mode field bits
- * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK: channel width mask
- * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_20MHZ: 20 MHz channel width
- * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_40MHZ: 40 MHz channel width
- * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_80MHZ: 80 MHz channel width
- * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_160MHZ: 160 MHz or 80+80 MHz channel width
- * @IEEE80211_OPMODE_NOTIF_BW_160_80P80: 160 / 80+80 MHz indicator flag
- * @IEEE80211_OPMODE_NOTIF_RX_NSS_MASK: number of spatial streams mask
- *	(the NSS value is the value of this field + 1)
- * @IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT: number of spatial streams shift
- * @IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF: indicates streams in SU-MIMO PPDU
- *	using a beamforming steering matrix
- */
-enum ieee80211_vht_opmode_bits {
-	IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK	= 0x03,
-	IEEE80211_OPMODE_NOTIF_CHANWIDTH_20MHZ	= 0,
-	IEEE80211_OPMODE_NOTIF_CHANWIDTH_40MHZ	= 1,
-	IEEE80211_OPMODE_NOTIF_CHANWIDTH_80MHZ	= 2,
-	IEEE80211_OPMODE_NOTIF_CHANWIDTH_160MHZ	= 3,
-	IEEE80211_OPMODE_NOTIF_BW_160_80P80	= 0x04,
-	IEEE80211_OPMODE_NOTIF_RX_NSS_MASK	= 0x70,
-	IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT	= 4,
-	IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF	= 0x80,
-};
-
 /**
  * enum ieee80211_s1g_chanwidth - S1G channel widths
  * These are defined in IEEE802.11-2016ah Table 10-20
@@ -1663,119 +1633,6 @@ struct ieee80211_p2p_noa_attr {
 #define IEEE80211_P2P_OPPPS_ENABLE_BIT		BIT(7)
 #define IEEE80211_P2P_OPPPS_CTWINDOW_MASK	0x7F
 
-/*
- * Maximum length of AMPDU that the STA can receive in VHT.
- * Length = 2 ^ (13 + max_ampdu_length_exp) - 1 (octets)
- */
-enum ieee80211_vht_max_ampdu_length_exp {
-	IEEE80211_VHT_MAX_AMPDU_8K = 0,
-	IEEE80211_VHT_MAX_AMPDU_16K = 1,
-	IEEE80211_VHT_MAX_AMPDU_32K = 2,
-	IEEE80211_VHT_MAX_AMPDU_64K = 3,
-	IEEE80211_VHT_MAX_AMPDU_128K = 4,
-	IEEE80211_VHT_MAX_AMPDU_256K = 5,
-	IEEE80211_VHT_MAX_AMPDU_512K = 6,
-	IEEE80211_VHT_MAX_AMPDU_1024K = 7
-};
-
-/**
- * struct ieee80211_vht_mcs_info - VHT MCS information
- * @rx_mcs_map: RX MCS map 2 bits for each stream, total 8 streams
- * @rx_highest: Indicates highest long GI VHT PPDU data rate
- *	STA can receive. Rate expressed in units of 1 Mbps.
- *	If this field is 0 this value should not be used to
- *	consider the highest RX data rate supported.
- *	The top 3 bits of this field indicate the Maximum NSTS,total
- *	(a beamformee capability.)
- * @tx_mcs_map: TX MCS map 2 bits for each stream, total 8 streams
- * @tx_highest: Indicates highest long GI VHT PPDU data rate
- *	STA can transmit. Rate expressed in units of 1 Mbps.
- *	If this field is 0 this value should not be used to
- *	consider the highest TX data rate supported.
- *	The top 2 bits of this field are reserved, the
- *	3rd bit from the top indiciates VHT Extended NSS BW
- *	Capability.
- */
-struct ieee80211_vht_mcs_info {
-	__le16 rx_mcs_map;
-	__le16 rx_highest;
-	__le16 tx_mcs_map;
-	__le16 tx_highest;
-} __packed;
-
-/* for rx_highest */
-#define IEEE80211_VHT_MAX_NSTS_TOTAL_SHIFT	13
-#define IEEE80211_VHT_MAX_NSTS_TOTAL_MASK	(7 << IEEE80211_VHT_MAX_NSTS_TOTAL_SHIFT)
-
-/* for tx_highest */
-#define IEEE80211_VHT_EXT_NSS_BW_CAPABLE	(1 << 13)
-
-/**
- * enum ieee80211_vht_mcs_support - VHT MCS support definitions
- * @IEEE80211_VHT_MCS_SUPPORT_0_7: MCSes 0-7 are supported for the
- *	number of streams
- * @IEEE80211_VHT_MCS_SUPPORT_0_8: MCSes 0-8 are supported
- * @IEEE80211_VHT_MCS_SUPPORT_0_9: MCSes 0-9 are supported
- * @IEEE80211_VHT_MCS_NOT_SUPPORTED: This number of streams isn't supported
- *
- * These definitions are used in each 2-bit subfield of the @rx_mcs_map
- * and @tx_mcs_map fields of &struct ieee80211_vht_mcs_info, which are
- * both split into 8 subfields by number of streams. These values indicate
- * which MCSes are supported for the number of streams the value appears
- * for.
- */
-enum ieee80211_vht_mcs_support {
-	IEEE80211_VHT_MCS_SUPPORT_0_7	= 0,
-	IEEE80211_VHT_MCS_SUPPORT_0_8	= 1,
-	IEEE80211_VHT_MCS_SUPPORT_0_9	= 2,
-	IEEE80211_VHT_MCS_NOT_SUPPORTED	= 3,
-};
-
-/**
- * struct ieee80211_vht_cap - VHT capabilities
- *
- * This structure is the "VHT capabilities element" as
- * described in 802.11ac D3.0 8.4.2.160
- * @vht_cap_info: VHT capability info
- * @supp_mcs: VHT MCS supported rates
- */
-struct ieee80211_vht_cap {
-	__le32 vht_cap_info;
-	struct ieee80211_vht_mcs_info supp_mcs;
-} __packed;
-
-/**
- * enum ieee80211_vht_chanwidth - VHT channel width
- * @IEEE80211_VHT_CHANWIDTH_USE_HT: use the HT operation IE to
- *	determine the channel width (20 or 40 MHz)
- * @IEEE80211_VHT_CHANWIDTH_80MHZ: 80 MHz bandwidth
- * @IEEE80211_VHT_CHANWIDTH_160MHZ: 160 MHz bandwidth
- * @IEEE80211_VHT_CHANWIDTH_80P80MHZ: 80+80 MHz bandwidth
- */
-enum ieee80211_vht_chanwidth {
-	IEEE80211_VHT_CHANWIDTH_USE_HT		= 0,
-	IEEE80211_VHT_CHANWIDTH_80MHZ		= 1,
-	IEEE80211_VHT_CHANWIDTH_160MHZ		= 2,
-	IEEE80211_VHT_CHANWIDTH_80P80MHZ	= 3,
-};
-
-/**
- * struct ieee80211_vht_operation - VHT operation IE
- *
- * This structure is the "VHT operation element" as
- * described in 802.11ac D3.0 8.4.2.161
- * @chan_width: Operating channel width
- * @center_freq_seg0_idx: center freq segment 0 index
- * @center_freq_seg1_idx: center freq segment 1 index
- * @basic_mcs_set: VHT Basic MCS rate set
- */
-struct ieee80211_vht_operation {
-	u8 chan_width;
-	u8 center_freq_seg0_idx;
-	u8 center_freq_seg1_idx;
-	__le16 basic_mcs_set;
-} __packed;
-
 /**
  * struct ieee80211_he_cap_elem - HE capabilities element
  * @mac_cap_info: HE MAC Capabilities Information
@@ -2045,71 +1902,6 @@ struct ieee80211_eht_operation_info {
 	u8 optional[];
 } __packed;
 
-/* 802.11ac VHT Capabilities */
-#define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895			0x00000000
-#define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991			0x00000001
-#define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454			0x00000002
-#define IEEE80211_VHT_CAP_MAX_MPDU_MASK				0x00000003
-#define IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ		0x00000004
-#define IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ	0x00000008
-#define IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK			0x0000000C
-#define IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_SHIFT			2
-#define IEEE80211_VHT_CAP_RXLDPC				0x00000010
-#define IEEE80211_VHT_CAP_SHORT_GI_80				0x00000020
-#define IEEE80211_VHT_CAP_SHORT_GI_160				0x00000040
-#define IEEE80211_VHT_CAP_TXSTBC				0x00000080
-#define IEEE80211_VHT_CAP_RXSTBC_1				0x00000100
-#define IEEE80211_VHT_CAP_RXSTBC_2				0x00000200
-#define IEEE80211_VHT_CAP_RXSTBC_3				0x00000300
-#define IEEE80211_VHT_CAP_RXSTBC_4				0x00000400
-#define IEEE80211_VHT_CAP_RXSTBC_MASK				0x00000700
-#define IEEE80211_VHT_CAP_RXSTBC_SHIFT				8
-#define IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE			0x00000800
-#define IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE			0x00001000
-#define IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT                  13
-#define IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK			\
-		(7 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT)
-#define IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT		16
-#define IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK		\
-		(7 << IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT)
-#define IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE			0x00080000
-#define IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE			0x00100000
-#define IEEE80211_VHT_CAP_VHT_TXOP_PS				0x00200000
-#define IEEE80211_VHT_CAP_HTC_VHT				0x00400000
-#define IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT	23
-#define IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK	\
-		(7 << IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT)
-#define IEEE80211_VHT_CAP_VHT_LINK_ADAPTATION_VHT_UNSOL_MFB	0x08000000
-#define IEEE80211_VHT_CAP_VHT_LINK_ADAPTATION_VHT_MRQ_MFB	0x0c000000
-#define IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN			0x10000000
-#define IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN			0x20000000
-#define IEEE80211_VHT_CAP_EXT_NSS_BW_SHIFT			30
-#define IEEE80211_VHT_CAP_EXT_NSS_BW_MASK			0xc0000000
-
-/**
- * ieee80211_get_vht_max_nss - return max NSS for a given bandwidth/MCS
- * @cap: VHT capabilities of the peer
- * @bw: bandwidth to use
- * @mcs: MCS index to use
- * @ext_nss_bw_capable: indicates whether or not the local transmitter
- *	(rate scaling algorithm) can deal with the new logic
- *	(dot11VHTExtendedNSSBWCapable)
- * @max_vht_nss: current maximum NSS as advertised by the STA in
- *	operating mode notification, can be 0 in which case the
- *	capability data will be used to derive this (from MCS support)
- * Return: The maximum NSS that can be used for the given bandwidth/MCS
- *	combination
- *
- * Due to the VHT Extended NSS Bandwidth Support, the maximum NSS can
- * vary for a given BW/MCS. This function parses the data.
- *
- * Note: This function is exported by cfg80211.
- */
-int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
-			      enum ieee80211_vht_chanwidth bw,
-			      int mcs, bool ext_nss_bw_capable,
-			      unsigned int max_vht_nss);
-
 /* 802.11ax HE MAC capabilities */
 #define IEEE80211_HE_MAC_CAP0_HTC_HE				0x01
 #define IEEE80211_HE_MAC_CAP0_TWT_REQ				0x02
@@ -3561,13 +3353,6 @@ enum ieee80211_spectrum_mgmt_actioncode {
 	WLAN_ACTION_SPCT_CHL_SWITCH = 4,
 };
 
-/* VHT action codes */
-enum ieee80211_vht_actioncode {
-	WLAN_VHT_ACTION_COMPRESSED_BF = 0,
-	WLAN_VHT_ACTION_GROUPID_MGMT = 1,
-	WLAN_VHT_ACTION_OPMODE_NOTIF = 2,
-};
-
 /* Self Protected Action codes */
 enum ieee80211_self_protected_actioncode {
 	WLAN_SP_RESERVED = 0,
@@ -5619,6 +5404,7 @@ static inline u32 ieee80211_eml_trans_timeout_in_us(u16 eml_cap)
 #define NAN_DEV_CAPA_S3_SUPPORTED		0x10
 
 #include "ieee80211-ht.h"
+#include "ieee80211-vht.h"
 #include "ieee80211-mesh.h"
 
 #endif /* LINUX_IEEE80211_H */
-- 
2.51.1


