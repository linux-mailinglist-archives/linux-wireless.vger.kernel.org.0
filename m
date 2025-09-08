Return-Path: <linux-wireless+bounces-27087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4B9B48BD3
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21EE1B26F3E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDCA301466;
	Mon,  8 Sep 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrEim6p2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013153009CD
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330028; cv=none; b=D+ROMAME6Ffk6Npk0ve2QQxG+e/RTrWkux8GOUq24QrdQCFx+KLZjbxrrGlLT9TEhMXpQNBEBQxhx9WXxHbhWK00mqNQ1VOjOIxWTLy1GB2F6ednJktFUbZfjdjcQzV8a8mGbvc33RcgL46rVE6PBY60ChA2+9+3hETkbPHUf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330028; c=relaxed/simple;
	bh=pXVsTOkEvXQ4bq9yYKkRDwFJphzDx+yWyelR5GzGhpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4Sqxo24TtdXTxrrV1aPpvUkZd/Qh2uzMtjH6LLua/S3iwUhanZq2yroEpOOldrUca2Kz2TbeDVPpaXTHIn3xf8LfmBxlrYOGGG9QlD1lDmJYSixEuASpOuoDka40nFuFAJJTf8ESVUEByJ5rILE81ffEN1a4sx3+hgiDQt/Xvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrEim6p2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330026; x=1788866026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pXVsTOkEvXQ4bq9yYKkRDwFJphzDx+yWyelR5GzGhpE=;
  b=QrEim6p2a3Nd7pIEUUPBTJP4hwa9dN9iazy96E7aR7R3rXIINar9GItY
   eKUb920XsoaWuOEgFtXlJdfA8Cr4ISgs6j/kxpdX1WWSNyaeaUg004ncA
   Iz7TX4L1jfxZG9DeRvBDbtb7Kg42hLH5z+Fw/c+7Wcgz268L4/D1fbKRx
   9s4XCuAtppVl67Q7jJ8T93Lr7IXtShK7REdq67lJuaLT7THcHIuKxZCZu
   4Ud9d5zXnP87uaQG79mLbyNoCKSvRJwQZCNIpWRXPC7piBFgcqf3FTiC0
   h9rZXB02sG15MWt68Wv8YqP67k85/kHYarkWdxxjNOamxWLOMmJTWKQ7R
   Q==;
X-CSE-ConnectionGUID: jWlI87omS5CYL9qgGJ+avg==
X-CSE-MsgGUID: 5Es+cNDZRt2iLaTRYRrsmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037893"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037893"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:44 -0700
X-CSE-ConnectionGUID: XtkAgDIjTJ68U1oaSllS4Q==
X-CSE-MsgGUID: WIPW8swjSi2l0nsC3mBSPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126571"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 05/14] wifi: cfg80211: Advertise supported NAN capabilities
Date: Mon,  8 Sep 2025 14:12:59 +0300
Message-Id: <20250908140015.2976966556f5.Ic6e43b10049573180c909dad806f279cfb31143e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
References: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Allow drivers to specify the supported NAN capabilities and support
advertising the NAN capabilities to user space.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 17 ++++++++++++++++
 include/net/cfg80211.h    | 38 ++++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c    | 41 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index d350263f23f3..2110345de8ef 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -6065,4 +6065,21 @@ static inline u32 ieee80211_eml_trans_timeout_in_us(u16 eml_cap)
 				 _data + ieee80211_mle_common_size(_data),\
 				 _len - ieee80211_mle_common_size(_data))
 
+/* NAN operation mode, as defined in Wi-Fi Aware (TM) specification Table 81 */
+#define NAN_OP_MODE_PHY_MODE_VHT	0x01
+#define NAN_OP_MODE_PHY_MODE_HE		0x10
+#define NAN_OP_MODE_PHY_MODE_MASK	0x11
+#define NAN_OP_MODE_80P80MHZ		0x02
+#define NAN_OP_MODE_160MHZ		0x04
+#define NAN_OP_MODE_PNDL_SUPPRTED	0x08
+
+/* NAN Device capabilities, as defined in Wi-Fi Aware (TM) specification
+ * Table 79
+ */
+#define NAN_DEV_CAPA_DFS_OWNER			0x01
+#define NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED	0x02
+#define NAN_DEV_CAPA_SIM_NDP_RX_SUPPORTED	0x04
+#define NAN_DEV_CAPA_NDPE_SUPPORTED		0x08
+#define NAN_DEV_CAPA_S3_SUPPORTED		0x10
+
 #endif /* LINUX_IEEE80211_H */
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1b10bd31bdd6..e30c1886c530 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5711,6 +5711,42 @@ struct wiphy_radio {
 	u32 antenna_mask;
 };
 
+/**
+ * enum wiphy_nan_flags - NAN capabilities
+ *
+ * @WIPHY_NAN_FLAGS_CONFIGURABLE_SYNC: Device supports NAN configurable
+ *     synchronization.
+ * @WIPHY_NAN_FLAGS_USERSPACE_DE: Device doesn't support DE offload.
+ */
+enum wiphy_nan_flags {
+	WIPHY_NAN_FLAGS_CONFIGURABLE_SYNC = BIT(0),
+	WIPHY_NAN_FLAGS_USERSPACE_DE   = BIT(1),
+};
+
+/**
+ * struct wiphy_nan_capa - NAN capabilities
+ *
+ * This structure describes the NAN capabilities of a wiphy.
+ *
+ * @flags: NAN capabilities flags, see &enum wiphy_nan_flags
+ * @op_mode: NAN operation mode, as defined in Wi-Fi Aware (TM) specification
+ *     Table 81.
+ * @n_antennas: number of antennas supported by the device for Tx/Rx. Lower
+ *     nibble indicates the number of TX antennas and upper nibble indicates the
+ *     number of RX antennas. Value 0 indicates the information is not
+ *     available.
+ * @max_channel_switch_time: maximum channel switch time in milliseconds.
+ * @dev_capabilities: NAN device capabilities as defined in Wi-Fi Aware (TM)
+ *     specification Table 79 (Capabilities field).
+ */
+struct wiphy_nan_capa {
+	u32 flags;
+	u8 op_mode;
+	u8 n_antennas;
+	u16 max_channel_switch_time;
+	u8 dev_capabilities;
+};
+
 #define CFG80211_HW_TIMESTAMP_ALL_PEERS	0xffff
 
 /**
@@ -5884,6 +5920,7 @@ struct wiphy_radio {
  *	bitmap of &enum nl80211_band values.  For instance, for
  *	NL80211_BAND_2GHZ, bit 0 would be set
  *	(i.e. BIT(NL80211_BAND_2GHZ)).
+ * @nan_capa: NAN capabilities
  *
  * @txq_limit: configuration of internal TX queue frame limit
  * @txq_memory_limit: configuration internal TX queue memory limit
@@ -6065,6 +6102,7 @@ struct wiphy {
 	u32 bss_select_support;
 
 	u8 nan_supported_bands;
+	struct wiphy_nan_capa nan_capa;
 
 	u32 txq_limit;
 	u32 txq_memory_limit;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2f93454de1da..0e246e166f74 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2605,6 +2605,41 @@ static int nl80211_put_radios(struct wiphy *wiphy, struct sk_buff *msg)
 	return -ENOBUFS;
 }
 
+static int nl80211_put_nan_capa(struct wiphy *wiphy, struct sk_buff *msg)
+{
+	struct nlattr *nan_caps;
+
+	nan_caps = nla_nest_start(msg, NL80211_ATTR_NAN_CAPABILITIES);
+	if (!nan_caps)
+		return -ENOBUFS;
+
+	if (wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_CONFIGURABLE_SYNC &&
+	    nla_put_flag(msg, NL80211_NAN_CAPA_CONFIGURABLE_SYNC))
+		goto fail;
+
+	if ((wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE) &&
+	    nla_put_flag(msg, NL80211_NAN_CAPA_USERSPACE_DE))
+		goto fail;
+
+	if (nla_put_u8(msg, NL80211_NAN_CAPA_OP_MODE,
+		       wiphy->nan_capa.op_mode) ||
+	    nla_put_u8(msg, NL80211_NAN_CAPA_NUM_ANTENNAS,
+		       wiphy->nan_capa.n_antennas) ||
+	    nla_put_u16(msg, NL80211_NAN_CAPA_MAX_CHANNEL_SWITCH_TIME,
+			wiphy->nan_capa.max_channel_switch_time) ||
+	    nla_put_u8(msg, NL80211_NAN_CAPA_CAPABILITIES,
+		       wiphy->nan_capa.dev_capabilities))
+		goto fail;
+
+	nla_nest_end(msg, nan_caps);
+
+	return 0;
+
+fail:
+	nla_nest_cancel(msg, nan_caps);
+	return -ENOBUFS;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -3257,6 +3292,12 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (nl80211_put_radios(&rdev->wiphy, msg))
 			goto nla_put_failure;
 
+		state->split_start++;
+		break;
+	case 18:
+		if (nl80211_put_nan_capa(&rdev->wiphy, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
-- 
2.34.1


