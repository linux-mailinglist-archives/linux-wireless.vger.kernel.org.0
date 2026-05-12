Return-Path: <linux-wireless+bounces-36339-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFU4LzaBA2pB6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36339-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3419E528B47
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89A643005169
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887CC36F8E5;
	Tue, 12 May 2026 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/JXGrt1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB5335CB6E
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614510; cv=none; b=kNMgPnCynFwynhRzByK461gX6pgPfi6K5YjpzFKeQw9SCU8N2eRCT2nzqIW97WRLtojpxyzgXzMwSdyvjxQtlIRKWGWUtXwoEJlkm6wxVBWKWN9JaWiOdbWwHaK8nNfI4hrF0G0UxOrfERo/WwuO/Ns3jg5AXqw9sbx285xOa7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614510; c=relaxed/simple;
	bh=Xix1oHWAG0X+5Lq5R8g5RPaUqX0+2w0AHc09C1FJvhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bI1jhJuSxjW0Tx3y5Q5wU2DHZHB5fMd0GWrWzlU93s8t1A3tXYwA0oRP/VE6liJ5x2NuZWsQ1Eml1sJbyClJEvaC+cWL+zPPKru3twl2zNbkNeJc4/tW9VA3wSb9wYybHVo8MSITlqC6L9JPPSFxhuvD5Aug47Lsygn71GQGCcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/JXGrt1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614509; x=1810150509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xix1oHWAG0X+5Lq5R8g5RPaUqX0+2w0AHc09C1FJvhk=;
  b=e/JXGrt1FtiYM2b3iDj+ZeUJlVTPXGkx/dANBa/mqDsqe4Pg7mqqm3lm
   UQKgAPfMFgKGZT1VN37BdzlfsSiK/9ojfkptp/bLTQBNBH/JnyV3eE07q
   WcKycVzBLMsD/y3DSbTZielbQ5zQW/ttECDyg1mZzf2qEUQIOAkuIDj2M
   UBdz23yfeDzJhB4mcNVZPRJJ7tNdaD22QNyB4SDWEDWHGrRAuAEZh1dUt
   wyZMUMhoququcudu9TgugSP2+ux5zAnrw7FwNPR2wedYyk44yB5xKUEvZ
   +cI6G9YFshhVKo+0AfAo6nAW+SWggz9eoHPMvsHpUSFxpBap6nGh36YD2
   g==;
X-CSE-ConnectionGUID: yMPvC/oZQW+a39RXlwdOcA==
X-CSE-MsgGUID: voTEbim4R5+TvjvkVhw30w==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148801"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148801"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:09 -0700
X-CSE-ConnectionGUID: 6eBETmL9TXOmwq8CWNM8VQ==
X-CSE-MsgGUID: PJOeGmkiSCKuKplRDSoPVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471811"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mld: add duplicated beacon RSSI adjustment
Date: Tue, 12 May 2026 22:34:38 +0300
Message-Id: <20260512222731.a4c873e63054.Iea8e8a5f3b384622308dd8d03c5881ff75f1908c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
References: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3419E528B47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36339-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Avinash Bhatt <avinash.bhatt@intel.com>

For 6 GHz duplicated beacons, the RSSI is measured only on the 20 MHz
primary channel while the actual beacon energy spans the full
operational bandwidth. This leads to underestimated link quality.

Detect duplicated beacons and apply bandwidth-based RSSI adjustments.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 67 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index a8d146edc4bd..c07a0d6b0bd4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -894,6 +894,60 @@ iwl_mld_get_avail_chan_load(struct iwl_mld *mld,
 	return MAX_CHAN_LOAD - iwl_mld_get_chan_load(mld, link_conf);
 }
 
+static s8
+iwl_mld_get_dup_beacon_rssi_adjust(struct iwl_mld *mld,
+				   struct ieee80211_bss_conf *link_conf)
+{
+	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+	const struct cfg80211_bss_ies *beacon_ies;
+	const struct element *elem;
+
+	/* Duplicated beacon feature is only specific to 6 GHz */
+	if (WARN_ONCE(link_conf->chanreq.oper.chan->band != NL80211_BAND_6GHZ,
+		      "Unexpected band %d\n",
+		      link_conf->chanreq.oper.chan->band))
+		return 0;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	beacon_ies = wiphy_dereference(mld->wiphy, link_conf->bss->beacon_ies);
+	if (!beacon_ies)
+		return 0;
+
+	elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION,
+				      beacon_ies->data, beacon_ies->len);
+	if (!elem ||
+	    elem->datalen < sizeof(struct ieee80211_he_operation) + 1 ||
+	    elem->datalen < ieee80211_he_oper_size(&elem->data[1]))
+		return 0;
+
+	he_6ghz_oper = ieee80211_he_6ghz_oper((const void *)&elem->data[1]);
+	if (!he_6ghz_oper)
+		return 0;
+
+	if (!(he_6ghz_oper->control & IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON))
+		return 0;
+
+	/* Apply adjustment based on operational bandwidth */
+	switch (link_conf->chanreq.oper.width) {
+	case NL80211_CHAN_WIDTH_20:
+	case NL80211_CHAN_WIDTH_20_NOHT:
+		return 0;
+	case NL80211_CHAN_WIDTH_40:
+		return 3;
+	case NL80211_CHAN_WIDTH_80:
+		return 6;
+	case NL80211_CHAN_WIDTH_160:
+		return 9;
+	case NL80211_CHAN_WIDTH_320:
+		return 12;
+	default:
+		WARN_ONCE(1, "Unexpected channel width: %d\n",
+			  link_conf->chanreq.oper.width);
+		return 0;
+	}
+}
+
 /* This function calculates the grade of a link. Returns 0 in error case */
 unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
 				    struct ieee80211_bss_conf *link_conf)
@@ -903,7 +957,7 @@ unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
 	s32 link_rssi;
 	unsigned int grade = MAX_GRADE;
 
-	if (WARN_ON_ONCE(!link_conf))
+	if (WARN_ON_ONCE(!link_conf || !link_conf->bss))
 		return 0;
 
 	band = link_conf->chanreq.oper.chan->band;
@@ -918,8 +972,15 @@ unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
 	 * For 6 GHz the RSSI of the beacons is lower than
 	 * the RSSI of the data.
 	 */
-	if (band == NL80211_BAND_6GHZ && link_rssi)
-		link_rssi += 4;
+	if (band == NL80211_BAND_6GHZ && link_rssi) {
+		s8 rssi_adj_6g =
+			iwl_mld_get_dup_beacon_rssi_adjust(mld, link_conf);
+
+		if (!rssi_adj_6g)
+			rssi_adj_6g = 4;
+
+		link_rssi += rssi_adj_6g;
+	}
 
 	rssi_idx = band == NL80211_BAND_2GHZ ? 0 : 1;
 
-- 
2.34.1


