Return-Path: <linux-wireless+bounces-28768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B301C46BFF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D893B5D3E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3B51A704B;
	Mon, 10 Nov 2025 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mrb6ftw1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7A1E9905
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779756; cv=none; b=Qzga6k3VGDWa77XuuhVUZFt8fx+2INomMVC8SEQEEYpPBViIRulyxYZJZA8oqQcrr+tk3Za9jzNpjFk+1/+dtXkIwbApCc7Q09QLyavVRibfOiOvZL6J0zOUZYMTXf5LyIwQUJcimpHvb7fnY8xCFrkWnpj9R2FLcN9IJi4cf50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779756; c=relaxed/simple;
	bh=tdQmITbtCN1jHHN0MabBKoIAK0upMf0WecnUVzsgosE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imxGyZvS48GXxGAKvRSGfgOAnVN9zvoL6kXcgRC64yhPmCQnWYhE7AmahoQsXMIu1WAcX4YOHg0SuTgBCB0BHTQjq3Ud0G+4RMWe3012L6Id5Ot/ebpmTXXjdau4Y2g2mEDEDIe1hR69iNetkNMHaRa9PtU2IXRv3ZkEI3GX7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mrb6ftw1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779754; x=1794315754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tdQmITbtCN1jHHN0MabBKoIAK0upMf0WecnUVzsgosE=;
  b=Mrb6ftw1QOx2j0UW2elxq1yE8dNa5v/sofn0xKwmxQ+CYMWtSgTTEy0L
   7dzRF+/KvcG2xFpEPebVOFM1QuerXoijSHJ4iHXxVzr4j9QEkH8NBu0OM
   d/nwVV8Os6wB8kkdUEB2qrjW3X3p1CuoOm6ejtCWSrXT8wLARB6fVjrCn
   tEJUVizwhak6QlQKfhLa+/+MxFR1VCyVniuR0ZE47kKqE05VzcTzJqUjw
   PZKBofr066RmcISFmtV1kTWfXTHsla/1syK6uX/gcY6+HLU1s9/S/FdCv
   3r49UHGoLQ6+tpQ34S1pYwX6bxekF9A/JY4E6XrDDp8/k2Mr//rM+p0w4
   A==;
X-CSE-ConnectionGUID: pZX9P6JgRLeH62ZPVZafRg==
X-CSE-MsgGUID: FbifjkmRSJiW42drV6pR8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454869"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454869"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:34 -0800
X-CSE-ConnectionGUID: ZnwVPj5kTfa9pxUN0j4EJA==
X-CSE-MsgGUID: pQsDSHepRqy/BHv3hMiGsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928490"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: decode VHT information for sniffer
Date: Mon, 10 Nov 2025 15:02:12 +0200
Message-Id: <20251110150012.6751d1d0b31d.I927cb0767667f2c03ee41f2ba417f3b94bba6d91@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
References: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The available VHT information may be useful, so decode it and include it
in the generated radiotap headers.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  24 +++-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 132 ++++++++++++++++++
 2 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 3ed7e0807b90..6d0523497663 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -1062,7 +1062,29 @@ struct iwl_vht_sigs {
 #define OFDM_RX_FRAME_VHT_NUM_OF_DATA_SYM		0x000007ff
 #define OFDM_RX_FRAME_VHT_NUM_OF_DATA_SYM_VALID		0x80000000
 	__le32 a0;
-	__le32 a1, a2;
+#define OFDM_RX_FRAME_VHT_BANDWIDTH			0x00000003
+#define OFDM_RX_FRAME_VHT_STBC				0x00000008
+#define OFDM_RX_FRAME_VHT_GRP_ID			0x000003f0
+#define OFDM_RX_FRAME_VHT_STS_USER0			0x00001c00
+#define OFDM_RX_FRAME_VHT_MU_STS_USER1			0x0000e000
+#define OFDM_RX_FRAME_VHT_MU_STS_USER2			0x00070000
+#define OFDM_RX_FRAME_VHT_MU_STS_USER3			0x00380000
+#define OFDM_RX_FRAME_VHT_PARTIAL_AID_OR_MU_STS		0x003fe000
+#define OFDM_RX_FRAME_VHT_MU_MIMO_USER_POSITION		0x03000000
+#define OFDM_RX_FRAME_VHT_NO_STREAMS			0x04000000
+#define OFDM_RX_FRAME_VHT_STS				0x38000000
+	__le32 a1;
+#define OFDM_RX_FRAME_VHT_SHORT_GI			0x00000001
+#define OFDM_RX_FRAME_VHT_SHORT_GI_AMBIG		0x00000002
+#define OFDM_RX_FRAME_VHT_CODING			0x00000004
+#define OFDM_RX_FRAME_VHT_CODING_EXTRA_SYM		0x00000008
+#define OFDM_RX_FRAME_VHT_MCS_OR_MU_CODING		0x000000f0
+#define OFDM_RX_FRAME_VHT_BF_OR_MU_RESERVED		0x00000100
+#define OFDM_RX_FRAME_VHT_CRC				0x0003fc00
+#define OFDM_RX_FRAME_VHT_CRC_OK_BIT			0x00040000
+#define OFDM_RX_FRAME_VHT_CUR_USER_CODING		0x00080000
+#define OFDM_RX_FRAME_VHT_CUR_USER_STS			0x00700000
+	__le32 a2;
 };
 
 struct iwl_he_sigs {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 6a76e3fcb581..817181e74d6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -207,6 +207,134 @@ static void iwl_mld_fill_signal(struct iwl_mld *mld, int link_id,
 	rx_status->chain_signal[1] = energy_b;
 }
 
+static void
+iwl_mld_decode_vht_phy_data(struct iwl_mld_rx_phy_data *phy_data,
+			    struct ieee80211_radiotap_vht *vht,
+			    struct ieee80211_rx_status *rx_status)
+{
+	bool stbc;
+
+	vht->known = cpu_to_le16(IEEE80211_RADIOTAP_VHT_KNOWN_BANDWIDTH |
+				 IEEE80211_RADIOTAP_VHT_KNOWN_GROUP_ID |
+				 IEEE80211_RADIOTAP_VHT_KNOWN_STBC |
+				 IEEE80211_RADIOTAP_VHT_KNOWN_GI |
+				 IEEE80211_RADIOTAP_VHT_KNOWN_SGI_NSYM_DIS |
+				 IEEE80211_RADIOTAP_VHT_KNOWN_LDPC_EXTRA_OFDM_SYM |
+				 IEEE80211_RADIOTAP_VHT_KNOWN_BEAMFORMED);
+
+	switch (le32_get_bits(phy_data->ntfy->sigs.vht.a1,
+			      OFDM_RX_FRAME_VHT_BANDWIDTH)) {
+	case 0:
+		vht->bandwidth = IEEE80211_RADIOTAP_VHT_BW_20;
+		break;
+	case 1:
+		vht->bandwidth = IEEE80211_RADIOTAP_VHT_BW_40;
+		break;
+	case 2:
+		vht->bandwidth = IEEE80211_RADIOTAP_VHT_BW_80;
+		break;
+	case 3:
+		vht->bandwidth = IEEE80211_RADIOTAP_VHT_BW_160;
+		break;
+	}
+
+	vht->group_id = le32_get_bits(phy_data->ntfy->sigs.vht.a1,
+				      OFDM_RX_FRAME_VHT_GRP_ID);
+
+	stbc = le32_get_bits(phy_data->ntfy->sigs.vht.a1,
+			     OFDM_RX_FRAME_VHT_STBC);
+	if (stbc)
+		vht->flags |= IEEE80211_RADIOTAP_VHT_FLAG_STBC;
+
+	if (le32_get_bits(phy_data->ntfy->sigs.vht.a2,
+			  OFDM_RX_FRAME_VHT_SHORT_GI))
+		vht->flags |= IEEE80211_RADIOTAP_VHT_FLAG_SGI;
+
+	if (le32_get_bits(phy_data->ntfy->sigs.vht.a2,
+			  OFDM_RX_FRAME_VHT_SHORT_GI_AMBIG))
+		vht->flags |= IEEE80211_RADIOTAP_VHT_FLAG_SGI_NSYM_M10_9;
+
+	if (le32_get_bits(phy_data->ntfy->sigs.vht.a2,
+			  OFDM_RX_FRAME_VHT_CODING_EXTRA_SYM))
+		vht->flags |= IEEE80211_RADIOTAP_VHT_FLAG_LDPC_EXTRA_OFDM_SYM;
+
+	if (vht->group_id != 0 && vht->group_id != 63) {
+		/* MU frame */
+		int user = le32_get_bits(phy_data->ntfy->sigs.vht.a1,
+					 OFDM_RX_FRAME_VHT_MU_MIMO_USER_POSITION);
+		int nsts;
+
+		/* Always beamformed */
+		vht->flags |= IEEE80211_RADIOTAP_VHT_FLAG_BEAMFORMED;
+
+		/* No MCS information in the a1/a2 data for MU frames */
+		nsts = le32_get_bits(phy_data->ntfy->sigs.vht.a1,
+				      OFDM_RX_FRAME_VHT_STS_USER0);
+		vht->mcs_nss[0] = (stbc ? nsts / 2 : nsts) | 0xf0;
+
+		nsts = le32_get_bits(phy_data->ntfy->sigs.vht.a1,
+				      OFDM_RX_FRAME_VHT_MU_STS_USER1);
+		vht->mcs_nss[1] = (stbc ? nsts / 2 : nsts) | 0xf0;
+
+		nsts = le32_get_bits(phy_data->ntfy->sigs.vht.a1,
+				      OFDM_RX_FRAME_VHT_MU_STS_USER2);
+		vht->mcs_nss[2] = (stbc ? nsts / 2 : nsts) | 0xf0;
+
+		nsts = le32_get_bits(phy_data->ntfy->sigs.vht.a1,
+				      OFDM_RX_FRAME_VHT_MU_STS_USER3);
+		vht->mcs_nss[3] = (stbc ? nsts / 2 : nsts) | 0xf0;
+
+		/* Report current user MCS from rate_n_flags via rx_status */
+		vht->mcs_nss[user] &= 0x0f;
+		vht->mcs_nss[user] |= rx_status->rate_idx << 4;
+
+		/* Report LDPC for current user */
+		if (rx_status->enc_flags & RX_ENC_FLAG_LDPC)
+			vht->coding = 0x1 << user;
+	} else {
+		int nsts;
+
+		/* SU frame */
+		vht->known |= cpu_to_le16(IEEE80211_RADIOTAP_VHT_KNOWN_PARTIAL_AID);
+
+		if (le32_get_bits(phy_data->ntfy->sigs.vht.a2,
+				  OFDM_RX_FRAME_VHT_BF_OR_MU_RESERVED))
+			vht->flags |= IEEE80211_RADIOTAP_VHT_FLAG_BEAMFORMED;
+
+		vht->partial_aid =
+			cpu_to_le16(le32_get_bits(phy_data->ntfy->sigs.vht.a1,
+						  OFDM_RX_FRAME_VHT_PARTIAL_AID_OR_MU_STS));
+
+		nsts = le32_get_bits(phy_data->ntfy->sigs.vht.a1,
+				      OFDM_RX_FRAME_VHT_STS) + 1;
+		vht->mcs_nss[0] =
+			(stbc ? nsts / 2 : nsts) |
+			le32_get_bits(phy_data->ntfy->sigs.vht.a2,
+				      OFDM_RX_FRAME_VHT_MCS_OR_MU_CODING) << 4;
+		vht->mcs_nss[1] = 0;
+		vht->mcs_nss[2] = 0;
+		vht->mcs_nss[3] = 0;
+
+		if (rx_status->enc_flags & RX_ENC_FLAG_LDPC)
+			vht->coding = 0x1;
+	}
+}
+
+static void iwl_mld_rx_vht(struct sk_buff *skb,
+			  struct iwl_mld_rx_phy_data *phy_data)
+{
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+	struct ieee80211_radiotap_vht *vht;
+
+	if (likely(!phy_data->ntfy))
+		return;
+
+	vht = skb_put_zero(skb, sizeof(*vht));
+	rx_status->flag |= RX_FLAG_RADIOTAP_VHT;
+
+	iwl_mld_decode_vht_phy_data(phy_data, vht, rx_status);
+}
+
 static void
 iwl_mld_he_set_ru_alloc(struct ieee80211_rx_status *rx_status,
 			struct ieee80211_radiotap_he *he,
@@ -1377,6 +1505,10 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, int link_id,
 
 	iwl_mld_set_rx_rate(mld, phy_data, rx_status);
 
+	/* must be before HE data (radiotap field order) */
+	if (format == RATE_MCS_MOD_TYPE_VHT)
+		iwl_mld_rx_vht(skb, phy_data);
+
 	/* must be before L-SIG data (radiotap field order) */
 	if (format == RATE_MCS_MOD_TYPE_HE)
 		iwl_mld_rx_he(skb, phy_data);
-- 
2.34.1


