Return-Path: <linux-wireless+bounces-30642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 557DDD0F7C8
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283D63062918
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B246234D38F;
	Sun, 11 Jan 2026 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hK3eoln+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C4500963
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151045; cv=none; b=MVD1H8g8hp5UR7pLa5QKLpZLWfi0U/g0UkA8qLxApD1CXP8W85eqDLiP42lbr5hP6dmckbBSeAVCcb65fE0+s/8qWtgGMpT29uKBuq5UcH9sVB77BsTn38MTTyq8WuwvpWpnSFK0DwiqZfrSeLtt/dhmu9W6LwThmocL3IY8enM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151045; c=relaxed/simple;
	bh=FAwq6mysiztgzrARnWExXP95e9UB6THkB4EcN2+1z3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0LkxfUsbtNH8crOHO8QUryjYXcHh8ILMruHgIv1khHx1KSGYOJyl/RWPbQZpjuhOBEAl8jHXX+yQga8HK3I5R3fFRQMRjdod11bkhbucNLx8AvPIyKWZYzkgR7bA6tpIFKvEMCa6ug+3pXI3Z4rjz0xO8h6i5jPfeUKUyR9mQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hK3eoln+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768151044; x=1799687044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FAwq6mysiztgzrARnWExXP95e9UB6THkB4EcN2+1z3Y=;
  b=hK3eoln+OA9/WpTrgB9mg6Z1x39Az5Za9afXk1KxOmYiGZLB8aGjE1xj
   c/0rQZ1mtL4vAMXTX4u2nU3FRClw8i7bRDDzSf41IaX94Pf6kj8CvPrGY
   X5UrTyRIApAeFN6+BADTVm/S44Gmdf17ertS/tSkGVTcvFlLjz7ZXrTNH
   2Zr07Nj7oMkUV+F8b4MVeUnH2/ridhFJgCzI1rdrCah+mdinl5bfRE4l1
   aeJUyc5k4tqau0fh9SjG+2h4I/eYMQGn5auoMYfZ39Hbo5QHEJG1ZOQGB
   JsrlG9vqljpJw3lpnEwFa+eXsI2tzOHhve+ufj0HOID37NBpWK07Cuuo4
   Q==;
X-CSE-ConnectionGUID: 71rag3lCQpWE66FyZS0moQ==
X-CSE-MsgGUID: euY0fmaOShCIosbYG7+wZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="68650778"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="68650778"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:04:02 -0800
X-CSE-ConnectionGUID: bhxBqBWTRHiHkKmEGKBlzg==
X-CSE-MsgGUID: Lt4U6IR7RvqdaOaAJLLYbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208433281"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:04:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next 1/4] wifi: nl80211/cfg80211: add new FTM capabilities
Date: Sun, 11 Jan 2026 19:03:48 +0200
Message-Id: <20260111190221.bf43785c18f6.Ic98cf9790ddee84bf88e5720b93c46c23af3c96c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111170351.2093318-1-miriam.rachel.korenblit@intel.com>
References: <20260111170351.2093318-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Add new capabilities to the PMSR FTM capabilities list. The new
capabilities include 6 GHz support, supported number of spatial streams
and supported number of LTF repetitions.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Tested-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
tested: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 20 +++++++++++++++++++-
 include/uapi/linux/nl80211.h | 29 +++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 23 +++++++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 126d3cf97eba..9c80ee0c0357 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5641,6 +5641,17 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	not limited)
  * @ftm.trigger_based: trigger based ranging measurement is supported
  * @ftm.non_trigger_based: non trigger based ranging measurement is supported
+ * @ftm.support_6ghz: supports ranging in 6 GHz band
+ * @ftm.max_tx_ltf_rep: maximum number of TX LTF repetitions supported (0 means
+ *	only one LTF, no repetitions)
+ * @ftm.max_rx_ltf_rep: maximum number of RX LTF repetitions supported (0 means
+ *	only one LTF, no repetitions)
+ * @ftm.max_tx_sts: maximum number of TX STS supported (zero based)
+ * @ftm.max_rx_sts: maximum number of RX STS supported (zero based)
+ * @ftm.max_total_ltf_tx: maximum total number of LTFs that can be transmitted
+ *	(0 means unknown)
+ * @ftm.max_total_ltf_rx: maximum total number of LTFs that can be received
+ *	(0 means unknown)
  */
 struct cfg80211_pmsr_capabilities {
 	unsigned int max_peers;
@@ -5658,7 +5669,14 @@ struct cfg80211_pmsr_capabilities {
 		   request_lci:1,
 		   request_civicloc:1,
 		   trigger_based:1,
-		   non_trigger_based:1;
+		   non_trigger_based:1,
+		   support_6ghz:1;
+		u8 max_tx_ltf_rep;
+		u8 max_rx_ltf_rep;
+		u8 max_tx_sts;
+		u8 max_rx_sts;
+		u8 max_total_ltf_tx;
+		u8 max_total_ltf_rx;
 	} ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8134f10e4e6c..34dc047a172f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7766,6 +7766,28 @@ enum nl80211_peer_measurement_attrs {
  *	trigger based ranging measurement is supported
  * @NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED: flag attribute indicating
  *	if non-trigger-based ranging measurement is supported
+ * @NL80211_PMSR_FTM_CAPA_ATTR_6GHZ_SUPPORT: flag attribute indicating if
+ *	ranging on the 6 GHz band is supported
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_TX_LTF_REP: u32 attribute indicating
+ *	the maximum number of LTF repetitions the device can transmit in the
+ *	preamble of the ranging NDP (zero means only one LTF, no repetitions)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_RX_LTF_REP: u32 attribute indicating
+ *	the maximum number of LTF repetitions the device can receive in the
+ *	preamble of the ranging NDP (zero means only one LTF, no repetitions)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_TX_STS: u32 attribute indicating
+ *	the maximum number of space-time streams supported for ranging NDP TX
+ *	(zero-based)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_RX_STS: u32 attribute indicating
+ *	the maximum number of space-time streams supported for ranging NDP RX
+ *	(zero-based)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_TX: u32 attribute indicating the
+ *	maximum total number of LTFs the device can transmit. The total number
+ *	of LTFs is (number of LTF repetitions) * (number of space-time streams).
+ *	This limits the allowed combinations of LTF repetitions and STS.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_RX: u32 attribute indicating the
+ *	maximum total number of LTFs the device can receive. The total number
+ *	of LTFs is (number of LTF repetitions) * (number of space-time streams).
+ *	This limits the allowed combinations of LTF repetitions and STS.
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -7783,6 +7805,13 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_FTMS_PER_BURST,
 	NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED,
 	NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED,
+	NL80211_PMSR_FTM_CAPA_ATTR_6GHZ_SUPPORT,
+	NL80211_PMSR_FTM_CAPA_ATTR_MAX_TX_LTF_REP,
+	NL80211_PMSR_FTM_CAPA_ATTR_MAX_RX_LTF_REP,
+	NL80211_PMSR_FTM_CAPA_ATTR_MAX_TX_STS,
+	NL80211_PMSR_FTM_CAPA_ATTR_MAX_RX_STS,
+	NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_TX,
+	NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_RX,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c961cd42a832..106db6991d97 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2307,6 +2307,29 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	if (cap->ftm.non_trigger_based &&
 	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED))
 		return -ENOBUFS;
+	if (cap->ftm.support_6ghz &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_6GHZ_SUPPORT))
+		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_TX_LTF_REP,
+			cap->ftm.max_tx_ltf_rep))
+		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_RX_LTF_REP,
+			cap->ftm.max_rx_ltf_rep))
+		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_TX_STS,
+			cap->ftm.max_tx_sts))
+		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_RX_STS,
+			cap->ftm.max_rx_sts))
+		return -ENOBUFS;
+	if (cap->ftm.max_total_ltf_tx > 0 &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_TX,
+			cap->ftm.max_total_ltf_tx))
+		return -ENOBUFS;
+	if (cap->ftm.max_total_ltf_rx > 0 &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_RX,
+			cap->ftm.max_total_ltf_rx))
+		return -ENOBUFS;
 
 	nla_nest_end(msg, ftm);
 	return 0;
-- 
2.34.1


