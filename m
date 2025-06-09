Return-Path: <linux-wireless+bounces-23889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE91AD25BA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606803B1782
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D6019258E;
	Mon,  9 Jun 2025 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgDeyaEr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AF21D599
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494166; cv=none; b=E/AzMeakvw467qLEwncBOGIu3kDVen15aJWnaBzYqiUw7GgJ2J53OjGCkY2miaSmZoaPWS34UMrNhops7rI77A/0WQaQJnD+qx9sejtVd+XykkNdcRQBAkqfTG4G+RiBOR7G5jSc5rXohCxpQNJ9AoZxKg7WbLfbXjYu9F+ygEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494166; c=relaxed/simple;
	bh=3Reg1Ll+x+fdYrIVJBZLSBhXRA+h19jTP3LVk5/Vs+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7PlqVrEX2wtwd2ZJfRff0RoXHUYaCGbfRLc3yg73TWUrey3oSj2jw+4n+t/hAPMN/6qAtSaexw9yGM4rTaousNZcxX3elElTequG0U+R1FiKVdXOsqGK8R4NygcFHUb+cebagayonCtlTQatrhd3xE/pYGVpx5UP9tdH6vG3mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgDeyaEr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494165; x=1781030165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Reg1Ll+x+fdYrIVJBZLSBhXRA+h19jTP3LVk5/Vs+4=;
  b=hgDeyaErKxIyO64mD5KAMqHP+NkFEP9KV4nMnM6PepU93HFQfjJbxjg3
   9PyQNAOZmQsKJiHbh09icZogZvJwHyHWyM5wkvtFNqXpguiphogCrkeHE
   ShXvDlcw8Uy+7M3gz7o6F4oYc/hblZUQBaxxjVl3fnUjBxyxyK1dax83U
   Ry1TXSPvxDfOJg++Cimp8o69VNnke9gBl+jjlM9rjcgBjtoLyJaEn2NB6
   IqYVUfKkqbYKDq/H27g1lrRGB9b3uZaUwcfnuD98+zkJbDRuRyF8cKAUH
   I3jyAF9TtbKXY/YlaN1bw4PDR0Lx0UjlN4VHwwi8XakNf/elD0RAf1sqf
   g==;
X-CSE-ConnectionGUID: 4UQRj9GeTwSt2JPX3FqsFQ==
X-CSE-MsgGUID: en7E5WLkQHiaR+TnurJBGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249782"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249782"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:36:04 -0700
X-CSE-ConnectionGUID: LJpJqtLyQpyMGCAgZ6jHYA==
X-CSE-MsgGUID: gX1p+OwdRq6Dmxi6OrrZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732567"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:36:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 14/15] wifi: cfg80211/mac80211: implement dot11ExtendedRegInfoSupport
Date: Mon,  9 Jun 2025 21:35:26 +0300
Message-Id: <20250609213232.90cdef116aad.I85da390fbee59355e3855691933e6a5e55c47ac4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
References: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>

Implement dot11ExtendedRegInfoSupport to advertise non-AP station
regulatory power capability as part of regulatory connectivity
element in (Re)Association request frames so that AP can achieve
maximum client connectivity. Control field which was interpreted
using value of 3-bits B5 to B3, now uses value of 4-bits B6 to B3 to
interpret the type of AP. Hence update IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO
to parse 4-bits control field. If older AP still updates only 3-bits
value of control field, station can still interpret the value as per
section E.2.7 of IEEE 802.11 REVme D7.0 and support the appropriate
AP type.

Also update IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP as the value of
standard power AP is changed to 8 instead of 4 so that AP can support both
LPI AP and SP AP to maximize the connectivity with stations. For backward
compatibility, keeping value 4 as old AP by limiting it to SP AP only.

Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h  | 34 +++++++++++++++++++++++++------
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mlme.c        | 41 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/util.c        | 17 ++++++++++++++++
 net/wireless/scan.c        |  1 +
 5 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 599137c2c091..1d9bcceb746a 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2778,11 +2778,12 @@ static inline bool ieee80211_he_capa_size_ok(const u8 *data, u8 len)
 #define IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR		0x40000000
 #define IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED		0x80000000
 
-#define IEEE80211_6GHZ_CTRL_REG_LPI_AP		0
-#define IEEE80211_6GHZ_CTRL_REG_SP_AP		1
-#define IEEE80211_6GHZ_CTRL_REG_VLP_AP		2
-#define IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP	3
-#define IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP	4
+#define IEEE80211_6GHZ_CTRL_REG_LPI_AP			0
+#define IEEE80211_6GHZ_CTRL_REG_SP_AP			1
+#define IEEE80211_6GHZ_CTRL_REG_VLP_AP			2
+#define IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP		3
+#define IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD	4
+#define IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP		8
 
 /**
  * struct ieee80211_he_6ghz_oper - HE 6 GHz operation Information field
@@ -2800,13 +2801,31 @@ struct ieee80211_he_6ghz_oper {
 #define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ	2
 #define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ	3
 #define IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON	0x4
-#define IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO	0x38
+#define IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO	0x78
 	u8 control;
 	u8 ccfs0;
 	u8 ccfs1;
 	u8 minrate;
 } __packed;
 
+/**
+ * enum ieee80211_reg_conn_bits - represents Regulatory connectivity field bits.
+ *
+ * This enumeration defines bit flags used to represent regulatory connectivity
+ * field bits.
+ *
+ * @IEEE80211_REG_CONN_LPI_BIT_VALID: Indicates whether the LPI bit is valid.
+ * @IEEE80211_REG_CONN_LPI_BIT_VALUE: Represents the value of the LPI bit.
+ * @IEEE80211_REG_CONN_SP_BIT_VALID: Indicates whether the SP bit is valid.
+ * @IEEE80211_REG_CONN_SP_BIT_VALUE: Represents the value of the SP bit.
+ */
+enum ieee80211_reg_conn_bits {
+	IEEE80211_REG_CONN_LPI_VALID = BIT(0),
+	IEEE80211_REG_CONN_LPI_VALUE = BIT(1),
+	IEEE80211_REG_CONN_SP_VALID = BIT(2),
+	IEEE80211_REG_CONN_SP_VALUE = BIT(3),
+};
+
 /* transmit power interpretation type of transmit power envelope element */
 enum ieee80211_tx_power_intrpt_type {
 	IEEE80211_TPE_LOCAL_EIRP,
@@ -3788,6 +3807,7 @@ enum ieee80211_eid_ext {
 	WLAN_EID_EXT_FILS_PUBLIC_KEY = 12,
 	WLAN_EID_EXT_FILS_NONCE = 13,
 	WLAN_EID_EXT_FUTURE_CHAN_GUIDANCE = 14,
+	WLAN_EID_EXT_DH_PARAMETER = 32,
 	WLAN_EID_EXT_HE_CAPABILITY = 35,
 	WLAN_EID_EXT_HE_OPERATION = 36,
 	WLAN_EID_EXT_UORA = 37,
@@ -3811,6 +3831,8 @@ enum ieee80211_eid_ext {
 	WLAN_EID_EXT_EHT_CAPABILITY = 108,
 	WLAN_EID_EXT_TID_TO_LINK_MAPPING = 109,
 	WLAN_EID_EXT_BANDWIDTH_INDICATION = 135,
+	WLAN_EID_EXT_KNOWN_STA_IDENTIFCATION = 136,
+	WLAN_EID_EXT_NON_AP_STA_REG_CON = 137,
 };
 
 /* Action category code */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 30809f0b35f7..b4c42095a46a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2638,6 +2638,8 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
 			  struct ieee80211_sub_if_data *sdata,
 			  const struct ieee80211_supported_band *sband,
 			  const struct ieee80211_conn_settings *conn);
+int ieee80211_put_reg_conn(struct sk_buff *skb,
+			   enum ieee80211_channel_flags flags);
 
 /* channel management */
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d18a7a7e33c3..8a86e5bc152b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1641,6 +1641,30 @@ static size_t ieee80211_add_before_he_elems(struct sk_buff *skb,
 	return noffset;
 }
 
+static size_t ieee80211_add_before_reg_conn(struct sk_buff *skb,
+					    const u8 *elems, size_t elems_len,
+					    size_t offset)
+{
+	static const u8 before_reg_conn[] = {
+		/*
+		 * no need to list the ones split off before HE
+		 * or generated here
+		 */
+		WLAN_EID_EXTENSION, WLAN_EID_EXT_DH_PARAMETER,
+		WLAN_EID_EXTENSION, WLAN_EID_EXT_KNOWN_STA_IDENTIFCATION,
+	};
+	size_t noffset;
+
+	if (!elems_len)
+		return offset;
+
+	noffset = ieee80211_ie_split(elems, elems_len, before_reg_conn,
+				     ARRAY_SIZE(before_reg_conn), offset);
+	skb_put_data(skb, elems + offset, noffset - offset);
+
+	return noffset;
+}
+
 #define PRESENT_ELEMS_MAX	8
 #define PRESENT_ELEM_EXT_OFFS	0x100
 
@@ -1801,6 +1825,22 @@ ieee80211_add_link_elems(struct ieee80211_sub_if_data *sdata,
 		ieee80211_put_he_6ghz_cap(skb, sdata, smps_mode);
 	}
 
+	/*
+	 * if present, add any custom IEs that go before regulatory
+	 * connectivity element
+	 */
+	offset = ieee80211_add_before_reg_conn(skb, extra_elems,
+					       extra_elems_len, offset);
+
+	if (sband->band == NL80211_BAND_6GHZ) {
+		/*
+		 * as per Section E.2.7 of IEEE 802.11 REVme D7.0, non-AP STA
+		 * capable of operating on the 6 GHz band shall transmit
+		 * regulatory connectivity element.
+		 */
+		ieee80211_put_reg_conn(skb, chan->flags);
+	}
+
 	/*
 	 * careful - need to know about all the present elems before
 	 * calling ieee80211_assoc_add_ml_elem(), so add this one if
@@ -5924,6 +5964,7 @@ ieee80211_ap_power_type(u8 control)
 		return IEEE80211_REG_LPI_AP;
 	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
 	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
 		return IEEE80211_REG_SP_AP;
 	case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
 		return IEEE80211_REG_VLP_AP;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 27d414efa3fd..85722e206b54 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2548,6 +2548,23 @@ int ieee80211_put_he_cap(struct sk_buff *skb,
 	return 0;
 }
 
+int ieee80211_put_reg_conn(struct sk_buff *skb,
+			   enum ieee80211_channel_flags flags)
+{
+	u8 reg_conn = IEEE80211_REG_CONN_LPI_VALID |
+		      IEEE80211_REG_CONN_LPI_VALUE |
+		      IEEE80211_REG_CONN_SP_VALID;
+
+	if (!(flags & IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT))
+		reg_conn |= IEEE80211_REG_CONN_SP_VALUE;
+
+	skb_put_u8(skb, WLAN_EID_EXTENSION);
+	skb_put_u8(skb, 1 + sizeof(reg_conn));
+	skb_put_u8(skb, WLAN_EID_EXT_NON_AP_STA_REG_CON);
+	skb_put_u8(skb, reg_conn);
+	return 0;
+}
+
 int ieee80211_put_he_6ghz_cap(struct sk_buff *skb,
 			      struct ieee80211_sub_if_data *sdata,
 			      enum ieee80211_smps_mode smps_mode)
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 6143be6bbd5e..a24b43a44746 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2231,6 +2231,7 @@ cfg80211_get_6ghz_power_type(const u8 *elems, size_t elems_len)
 		return IEEE80211_REG_LPI_AP;
 	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
 	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
 		return IEEE80211_REG_SP_AP;
 	case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
 		return IEEE80211_REG_VLP_AP;
-- 
2.34.1


