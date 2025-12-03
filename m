Return-Path: <linux-wireless+bounces-29467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C1EC9E981
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 10:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD863A47F7
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 09:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6F72E091D;
	Wed,  3 Dec 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j983jPnj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6E2DEA72
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755587; cv=none; b=nsVN2C1HdfiCFyF5UTJVN0LPqMnOZLJvL1skvslU55O8bFAxYkqufGmp9URw/PnFcpY0ZYU6XuwFsbAmT2pcI241L9LB/Y+FRDjrrF6g3mdTbV0Nida11CIXK/qI/f8n0YdbPs45oun7kTWUvfk82ZoPTuVN68q91CwR2LKXkj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755587; c=relaxed/simple;
	bh=UgXQlXX0i955UrZbBvbqtFlZmPhUnIVAiHMlKtX/Ifk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8AVEaU42JYmhBFSI0t4H70g8DSv35uXOX0kpPHLp7ljga4qlEPpeu8xAHkyR0omw8xnwblmEFtRfOoQxoTkgo3QNWORc0CN1gqDKscw5DegACj4R2XZVIoPnaSfSQt5dCbyOC32H9bjWjETvXdts1JUqZ3r/Jpz/aMrGUlZ2fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j983jPnj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764755585; x=1796291585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UgXQlXX0i955UrZbBvbqtFlZmPhUnIVAiHMlKtX/Ifk=;
  b=j983jPnjDInOT9FS4JpfBZfffeydU5hniBan8CXWSj8MAqBK/AkPFIuh
   Hqm60H85i35aNOvHI2cnCglGsllO5QHX6Jt/y1CexyuB7b4DTUORpRPWL
   6AksgXavg84V6h1UQW6X/F437eJm1/Bpf/8fCy8AfAfNjqGthoJ+iXZZc
   k+KPa4GB4WNJqSniW0O3vnBFd0AmWZGhko4funxEqX5yjpHTyG6seun7U
   EFQ2QbCogi2oURen0liEUqMwct5xUCYqrGJihjrvQ3+kyazDXLADZUMFk
   Dl9y12/x31fZ4+sKX51AhhlDLBNijXpC2IcxfEMsSZZ+82b6NiAwuAAji
   Q==;
X-CSE-ConnectionGUID: 30Tq6krORxCTrQd+2BoADA==
X-CSE-MsgGUID: CW/5gJfkQDuaqzVAWuGc/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="65931520"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="65931520"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:53:01 -0800
X-CSE-ConnectionGUID: avmBQhc+SKCRkoLSJ8/c+A==
X-CSE-MsgGUID: 4SCaToC5TC+YkPve5mm8LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="193916140"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:53:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 1/4] wifi: nl80211/cfg80211: add new FTM capabilities
Date: Wed,  3 Dec 2025 11:52:35 +0200
Message-Id: <20251203115155.458e17c728d1.Ic98cf9790ddee84bf88e5720b93c46c23af3c96c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203095238.3121859-1-miriam.rachel.korenblit@intel.com>
References: <20251203095238.3121859-1-miriam.rachel.korenblit@intel.com>
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
index 899f267b7cf9..50a1737e3382 100644
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


