Return-Path: <linux-wireless+bounces-969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4407D81838B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20641F250A0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEF14283;
	Tue, 19 Dec 2023 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jthkgkxN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442AE14277
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975072; x=1734511072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=43C+AAjP77cLzMR7X6bXnmvppdh+stryactiRm+QgL4=;
  b=jthkgkxNbdu4pn8k3kX3OvRWpACo0BSkdB11fkd2sf1sTmaPIMWozdL4
   uNEQUV61z051nnQRR0JO0NGOF2US4AG49A969iY97N/CVmm6tRBbumXMw
   cvaJmacSl/1GNHhzAROfyA7JOFbP+1pwWFvHgXL0EurYr+aMY+3A7hsvY
   ilTLkgZFbBF07iv9j4t50ziwE6YATD0i9rHgqZv1KSEmv6i/IhH1AlRtK
   TOKaCer1A7xm5Oc6KjAai9Ers/INTP8gyYFgyfq/FKdFNc4OMIRKyLb6m
   evflKHQ71kJ9LMFDdH3DLhDd+smPApESnQ5OJISef5gXrCtbKwsaCNDRW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969206"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969206"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846266331"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846266331"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Greenman@web.codeaurora.org, Gregory <gregory.greenman@intel.com>
Subject: [PATCH 05/15] wifi: cfg80211: handle UHB AP and STA power type
Date: Wed, 20 Dec 2023 04:37:53 +0200
Message-Id: <20231220043149.1cb06b8555f3.I432f78438de18aa9f5c9006be12e41dc34cc47c5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

UHB AP send supported power type(LPI, SP, VLP)
in beacon and probe response IE and STA should
connect to these AP only if their regulatory support
the AP power type.

Beacon/Probe response are reported to userspace
with reason "STA regulatory not supporting to connect to AP
based on transmitted power type" and it should
not connect to AP.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h    |  1 +
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h | 13 ++++++++++++
 net/wireless/nl80211.c       |  6 ++++++
 net/wireless/reg.c           |  4 ++++
 net/wireless/scan.c          | 38 ++++++++++++++++++++++++++++++++++++
 6 files changed, 68 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 5e5ea216f341..e484d9d10630 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2720,6 +2720,7 @@ static inline bool ieee80211_he_capa_size_ok(const u8 *data, u8 len)
 
 #define IEEE80211_6GHZ_CTRL_REG_LPI_AP	0
 #define IEEE80211_6GHZ_CTRL_REG_SP_AP	1
+#define IEEE80211_6GHZ_CTRL_REG_VLP_AP	2
 
 /**
  * struct ieee80211_he_6ghz_oper - HE 6 GHz operation Information field
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d8150d8b13e5..427a83c78c8c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -118,6 +118,10 @@ struct wiphy;
  *	restrictions.
  * @IEEE80211_CHAN_NO_EHT: EHT operation is not permitted on this channel.
  * @IEEE80211_CHAN_DFS_CONCURRENT: See %NL80211_RRF_DFS_CONCURRENT
+ * @IEEE80211_CHAN_NO_UHB_VLP_CLIENT: Client connection with VLP AP
+ *	not permitted using this channel
+ * @IEEE80211_CHAN_NO_UHB_AFC_CLIENT: Client connection with AFC AP
+ *	not permitted using this channel
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED		= 1<<0,
@@ -142,6 +146,8 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_NO_320MHZ	= 1<<19,
 	IEEE80211_CHAN_NO_EHT		= 1<<20,
 	IEEE80211_CHAN_DFS_CONCURRENT	= 1<<21,
+	IEEE80211_CHAN_NO_UHB_VLP_CLIENT= 1<<22,
+	IEEE80211_CHAN_NO_UHB_AFC_CLIENT= 1<<23,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 466da830e65f..1ccdcae24372 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4260,6 +4260,10 @@ enum nl80211_wmm_rule {
  *	allowed for peer-to-peer or adhoc communication under the control
  *	of a DFS master which operates on the same channel (FCC-594280 D01
  *	Section B.3). Should be used together with %NL80211_RRF_DFS only.
+ * @NL80211_FREQUENCY_ATTR_NO_UHB_VLP_CLIENT: Client connection to VLP AP
+ *	not allowed using this channel
+ * @NL80211_FREQUENCY_ATTR_NO_UHB_AFC_CLIENT: Client connection to AFC AP
+ *	not allowed using this channel
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4300,6 +4304,8 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_EHT,
 	NL80211_FREQUENCY_ATTR_PSD,
 	NL80211_FREQUENCY_ATTR_DFS_CONCURRENT,
+	NL80211_FREQUENCY_ATTR_NO_UHB_VLP_CLIENT,
+	NL80211_FREQUENCY_ATTR_NO_UHB_AFC_CLIENT,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4509,6 +4515,8 @@ enum nl80211_sched_scan_match_attr {
 	peer-to-peer or adhoc communication under the control of a DFS master
 	which operates on the same channel (FCC-594280 D01 Section B.3).
 	Should be used together with %NL80211_RRF_DFS only.
+ * @NL80211_RRF_NO_UHB_VLP_CLIENT: Client connection to VLP AP not allowed
+ * @NL80211_RRF_NO_UHB_AFC_CLIENT: Client connection to AFC AP not allowed
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -4531,6 +4539,8 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_EHT		= 1<<19,
 	NL80211_RRF_PSD			= 1<<20,
 	NL80211_RRF_DFS_CONCURRENT	= 1<<21,
+	NL80211_RRF_NO_UHB_VLP_CLIENT	= 1<<22,
+	NL80211_RRF_NO_UHB_AFC_CLIENT	= 1<<23,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
@@ -5086,9 +5096,12 @@ enum nl80211_bss_use_for {
  *	BSS isn't possible
  * @NL80211_BSS_CANNOT_USE_NSTR_NONPRIMARY: NSTR nonprimary links aren't
  *	supported by the device, and this BSS entry represents one.
+ * @NL80211_BSS_CANNOT_USE_UHB_PWR_MISMATCH: STA is not supporting
+ *	the AP power type (SP, VLP, AP) that the AP uses.
  */
 enum nl80211_bss_cannot_use_reasons {
 	NL80211_BSS_CANNOT_USE_NSTR_NONPRIMARY	= 1 << 0,
+	NL80211_BSS_CANNOT_USE_UHB_PWR_MISMATCH	= 1 << 1,
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f64005d62b19..299f2622b00d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1204,6 +1204,12 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_DFS_CONCURRENT) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_DFS_CONCURRENT))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_NO_UHB_VLP_CLIENT) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_UHB_VLP_CLIENT))
+			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_NO_UHB_AFC_CLIENT) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_UHB_AFC_CLIENT))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 44684df64734..2741b626919a 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1595,6 +1595,10 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_EHT;
 	if (rd_flags & NL80211_RRF_DFS_CONCURRENT)
 		channel_flags |= IEEE80211_CHAN_DFS_CONCURRENT;
+	if (rd_flags & NL80211_RRF_NO_UHB_VLP_CLIENT)
+		channel_flags |= IEEE80211_CHAN_NO_UHB_VLP_CLIENT;
+	if (rd_flags & NL80211_RRF_NO_UHB_AFC_CLIENT)
+		channel_flags |= IEEE80211_CHAN_NO_UHB_AFC_CLIENT;
 	if (rd_flags & NL80211_RRF_PSD)
 		channel_flags |= IEEE80211_CHAN_PSD;
 	return channel_flags;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 3d260c99c348..a601f1c7f835 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2848,6 +2848,36 @@ cfg80211_inform_bss_data(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_inform_bss_data);
 
+static bool cfg80211_uhb_power_type_valid(const u8 *ie,
+					  size_t ielen,
+					  const u32 flags)
+{
+	const struct element *tmp;
+	struct ieee80211_he_operation *he_oper;
+
+	tmp = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ie, ielen);
+	if (tmp && tmp->datalen >= sizeof(*he_oper) + 1) {
+		const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+
+		he_oper = (void *)&tmp->data[1];
+		he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
+
+		if (!he_6ghz_oper)
+			return false;
+
+		switch (u8_get_bits(he_6ghz_oper->control,
+				    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
+		case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
+			return true;
+		case IEEE80211_6GHZ_CTRL_REG_SP_AP:
+			return !(flags & IEEE80211_CHAN_NO_UHB_AFC_CLIENT);
+		case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
+			return !(flags & IEEE80211_CHAN_NO_UHB_VLP_CLIENT);
+		}
+	}
+	return false;
+}
+
 /* cfg80211_inform_bss_width_frame helper */
 static struct cfg80211_bss *
 cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
@@ -2906,6 +2936,14 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 	if (!channel)
 		return NULL;
 
+	if (channel->band == NL80211_BAND_6GHZ &&
+	    !cfg80211_uhb_power_type_valid(variable, ielen, channel->flags)) {
+		data->restrict_use = 1;
+		data->use_for = 0;
+		data->cannot_use_reasons =
+			NL80211_BSS_CANNOT_USE_UHB_PWR_MISMATCH;
+	}
+
 	if (ext) {
 		const struct ieee80211_s1g_bcn_compat_ie *compat;
 		const struct element *elem;
-- 
2.34.1


