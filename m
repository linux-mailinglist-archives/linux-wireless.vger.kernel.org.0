Return-Path: <linux-wireless+bounces-13599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F46992AFA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1691A1C22254
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463861D2F48;
	Mon,  7 Oct 2024 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gq7Y96J/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF31D2F6F
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302495; cv=none; b=HtLB4cWHo+O5auiQTuGo94+vf1/128jyG/33IeO08U9N1exrE0F9Oibso0OE7abe/kgO3Oib5I5S6pnrBgvyY4bOyl28Tz5X1ji8BUQMRmWQI+cBVNPDnmXi4RzA4uV3QNt4QksjqBRiFvrorZRqxrXn0DhhL0XHJbh1duu45u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302495; c=relaxed/simple;
	bh=jJDNL2benmMytKWXJ3lvW8RJWBf/uml2YXNi6MCdBfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZYV1B/XfffhkbquGaO8DlZYbu98K2axt+bF0VragUPUGvLOqwyV0n3Ez/gRouCFFdpkirwhCVE1T6y5aC21U4FErrOdCss1Qncu3mT3jZUUkJVqLE4028b1oLr7OsahdAVArSvGWxjQC7zwCJR4xMIu1vPU1f+WpVSjuXOgC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gq7Y96J/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302493; x=1759838493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jJDNL2benmMytKWXJ3lvW8RJWBf/uml2YXNi6MCdBfI=;
  b=Gq7Y96J/URIAeKiFXVTYfeuZWKagcXr4CaXAa3ErFt5XlDYWk8Ko4SdA
   27sCsvBv2u/WifjdCYkvWTz9mppNHXBxQqMI18vaK7dlyKelyvlwlXEt2
   /P7OQFFWNfvxe8kkMCzFozeP1zJ6SY7QKpMzklX7xiY5YEkfzv7rbwVjf
   lPyI8MmXTFoqm68ZodHHFhIRpyIy3hoMKG7m2IzwtVj3vKW+Z/1cWAFma
   /vcPQwtLnSZFVRdSdIKkxlbyMERkeKOWE6Spp6rmdV4MUigeY6jC359+w
   UetmLYnF2/L+Tofb4bap2xXkeWS7TTGZpc8Pym/7vGtUkbZWhpkA2DC6D
   A==;
X-CSE-ConnectionGUID: VT+a21r/Ta+q9KN7Am8OFQ==
X-CSE-MsgGUID: tD9wytiITBecgCm8oGHsXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099449"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099449"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:33 -0700
X-CSE-ConnectionGUID: zdTWibY9S96LpiwncKRmWg==
X-CSE-MsgGUID: 8v+D7JmoQp+SJtTFxtaZdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019288"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/14] wifi: mac80211: expose ieee80211_chan_width_to_rx_bw() to drivers
Date: Mon,  7 Oct 2024 15:00:58 +0300
Message-Id: <20241007144851.af003cb4a088.I8b5d29504b726caae24af6013c65b3daebe842a2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
References: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Drivers might need to also do this calculation, no point in
them duplicating the code. Since it's so simple, just make
it an inline.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h     | 27 +++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  2 --
 net/mac80211/vht.c         | 22 ----------------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index af70ad504cf2..7062638cec2f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7704,6 +7704,33 @@ void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
  */
 void ieee80211_send_teardown_neg_ttlm(struct ieee80211_vif *vif);
 
+/**
+ * ieee80211_chan_width_to_rx_bw - convert channel width to STA RX bandwidth
+ * @width: the channel width value to convert
+ * Return: the STA RX bandwidth value for the channel width
+ */
+static inline enum ieee80211_sta_rx_bandwidth
+ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width)
+{
+	switch (width) {
+	default:
+		WARN_ON_ONCE(1);
+		fallthrough;
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		return IEEE80211_STA_RX_BW_20;
+	case NL80211_CHAN_WIDTH_40:
+		return IEEE80211_STA_RX_BW_40;
+	case NL80211_CHAN_WIDTH_80:
+		return IEEE80211_STA_RX_BW_80;
+	case NL80211_CHAN_WIDTH_160:
+	case NL80211_CHAN_WIDTH_80P80:
+		return IEEE80211_STA_RX_BW_160;
+	case NL80211_CHAN_WIDTH_320:
+		return IEEE80211_STA_RX_BW_320;
+	}
+}
+
 /* for older drivers - let's not document these ... */
 int ieee80211_emulate_add_chanctx(struct ieee80211_hw *hw,
 				  struct ieee80211_chanctx_conf *ctx);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index edb2d55a5126..4248e299a331 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2194,8 +2194,6 @@ ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta)
 	return _ieee80211_sta_cur_vht_bw(link_sta, NULL);
 }
 void ieee80211_sta_init_nss(struct link_sta_info *link_sta);
-enum ieee80211_sta_rx_bandwidth
-ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width);
 enum nl80211_chan_width
 ieee80211_sta_cap_chan_bw(struct link_sta_info *link_sta);
 void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 7c878fb69f9a..2432d3bee7ce 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -479,28 +479,6 @@ ieee80211_sta_rx_bw_to_chan_width(struct link_sta_info *link_sta)
 	}
 }
 
-enum ieee80211_sta_rx_bandwidth
-ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width)
-{
-	switch (width) {
-	case NL80211_CHAN_WIDTH_20_NOHT:
-	case NL80211_CHAN_WIDTH_20:
-		return IEEE80211_STA_RX_BW_20;
-	case NL80211_CHAN_WIDTH_40:
-		return IEEE80211_STA_RX_BW_40;
-	case NL80211_CHAN_WIDTH_80:
-		return IEEE80211_STA_RX_BW_80;
-	case NL80211_CHAN_WIDTH_160:
-	case NL80211_CHAN_WIDTH_80P80:
-		return IEEE80211_STA_RX_BW_160;
-	case NL80211_CHAN_WIDTH_320:
-		return IEEE80211_STA_RX_BW_320;
-	default:
-		WARN_ON_ONCE(1);
-		return IEEE80211_STA_RX_BW_20;
-	}
-}
-
 /* FIXME: rename/move - this deals with everything not just VHT */
 enum ieee80211_sta_rx_bandwidth
 _ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
-- 
2.34.1


