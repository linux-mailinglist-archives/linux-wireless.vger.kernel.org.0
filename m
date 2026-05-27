Return-Path: <linux-wireless+bounces-37022-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE7dEK5LF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37022-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 21:53:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 232835E9BF0
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 21:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29BFC303217A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715833B2FDF;
	Wed, 27 May 2026 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FahBzuIR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05443B19B4
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911525; cv=none; b=k0+iBjMjLKx8BCN8zuQQdputmK2HNzVFMWCTYYTGy6BtgZelta1yI/FR7MZLWjrG86ffaoZuGlzFExk4gBw1zMPb6r/StVrNLXbpzzgFyIcCD3NthUA46vocmE/rVzmUFQrL8FrR+YiJ2FTr5TzTlmUN7k5zeO7iSZs4GNX9TVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911525; c=relaxed/simple;
	bh=oZFDoS06SSLGsRFkh088FqFTFfRDydwtEZMxnWjdzho=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kF4E1cM7zIZ0H9iPqqOsbSIzrGk8y/RIFKaiRIE3W8MiAmrqhAYFn3fr7WP3HHbWpKypkbrN5++FtrW5e6FG4VS01H/kkNhdggb0Ze6PZKBHxaK54Aeh1pnR2of7y1h7SlGUn7txPX3Oyxv8k4x4+jPcSuL0Fzsf2uPmlS4sfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FahBzuIR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779911524; x=1811447524;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=oZFDoS06SSLGsRFkh088FqFTFfRDydwtEZMxnWjdzho=;
  b=FahBzuIRg3TAPtKTLcCNOABmquc0KtE7EtqGAtYgm1fCR/rbDtknQcw6
   ymCtdUmA3QvSge5wtnEXeZT0eXi33Z68zhk1k04vqA25jx7k0EDnWQzOx
   IluTXMO8gmsSYosxu28z2YBgj5w7XD2iBZJi2OUgd8qlbnG3Uedh+GxND
   XqV8Y3OQ9Pw5a7x6dgpNmADtkr4DqRB11BTPHcThzJVUo4TORaKuRtI9B
   m0qHDDQ6OUHaTKBdfDqjcmNfUGl8pGlkqhLZ9uwsT1M/X7EFKGCnCORuj
   qHZTg03ZR0a1iRR9Flgz395f2jvcSFCgbU/jfV/Kz1SPAaKexJAqghmkH
   Q==;
X-CSE-ConnectionGUID: 0ebkBQYeQYO80XOY+UPW9A==
X-CSE-MsgGUID: Btx1TdqOS9KSH2DwbzbjUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80784725"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80784725"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:52:02 -0700
X-CSE-ConnectionGUID: +ydZ7u9kQPe154J7hAe0hg==
X-CSE-MsgGUID: 7u+wFqd7QWiaFBdPXJ/UPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="280465111"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:52:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 2/3] wifi: mac80211: refactor ieee80211_nan_try_evacuate
Date: Wed, 27 May 2026 22:51:44 +0300
Message-Id: <20260527224745.589503562912.I9e266da48ceaf85bd0fe1b0487c3fdbeaaf9baaa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527195145.468037-1-miriam.rachel.korenblit@intel.com>
References: <20260527195145.468037-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37022-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 232835E9BF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract the logic that finds a NAN channel which makes a good evacuation
candidate into a separate function. It will be used in a later patch.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h | 27 +++++++++++++++----
 net/mac80211/nan.c         | 53 +++++++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 1ac92e005763..29ae3004655c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1946,6 +1946,11 @@ ieee80211_vif_get_num_mcast_if(struct ieee80211_sub_if_data *sdata)
 	return -1;
 }
 
+static inline bool ieee80211_sdata_running(struct ieee80211_sub_if_data *sdata)
+{
+	return test_bit(SDATA_STATE_RUNNING, &sdata->state);
+}
+
 int ieee80211_hw_config(struct ieee80211_local *local, int radio_idx,
 			u32 changed);
 int ieee80211_hw_conf_chan(struct ieee80211_local *local);
@@ -2055,6 +2060,23 @@ int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
 void ieee80211_nan_free_peer_sched(struct ieee80211_nan_peer_sched *sched);
 void ieee80211_nan_update_ndi_carrier(struct ieee80211_sub_if_data *ndi_sdata);
 
+static inline struct ieee80211_sub_if_data *
+ieee80211_find_nan_sdata(struct ieee80211_local *local)
+{
+	struct ieee80211_sub_if_data *sdata;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	/* Find the NAN interface - there can only be one */
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		if (ieee80211_sdata_running(sdata) &&
+		    sdata->vif.type == NL80211_IFTYPE_NAN)
+			return sdata;
+	}
+
+	return NULL;
+}
+
 /* scan/BSS handling */
 void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work);
 int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
@@ -2155,11 +2177,6 @@ void ieee80211_recalc_txpower(struct ieee80211_link_data *link,
 			      bool update_bss);
 void ieee80211_recalc_offload(struct ieee80211_local *local);
 
-static inline bool ieee80211_sdata_running(struct ieee80211_sub_if_data *sdata)
-{
-	return test_bit(SDATA_STATE_RUNNING, &sdata->state);
-}
-
 /* link handling */
 void ieee80211_link_setup(struct ieee80211_link_data *link);
 void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/nan.c b/net/mac80211/nan.c
index cea620aaee6a..44b6e298d94d 100644
--- a/net/mac80211/nan.c
+++ b/net/mac80211/nan.c
@@ -754,33 +754,20 @@ ieee80211_nan_evacuate_channel(struct ieee80211_sub_if_data *sdata,
 		ieee80211_free_chanctx(sdata->local, ctx, false);
 }
 
-bool ieee80211_nan_try_evacuate(struct ieee80211_hw *hw,
-				struct ieee80211_chanctx_conf *conf)
+static struct ieee80211_nan_channel *
+ieee80211_nan_find_evac_chan(struct ieee80211_local *local,
+			     struct ieee80211_sub_if_data *sdata,
+			     struct ieee80211_chanctx *ctx)
 {
-	struct ieee80211_sub_if_data *sdata = NULL, *tmp;
-	struct ieee80211_local *local = hw_to_local(hw);
-	struct ieee80211_nan_channel *evac_chan = NULL;
 	struct ieee80211_nan_sched_cfg *sched_cfg;
-	struct ieee80211_chanctx *ctx = NULL;
+	struct ieee80211_nan_channel *evac_chan = NULL;
 	int min_slot_count = INT_MAX;
 	int usable_channels = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (conf)
-		ctx = container_of(conf, struct ieee80211_chanctx, conf);
-
-	/* Find the NAN interface - there can only be one */
-	list_for_each_entry(tmp, &local->interfaces, list) {
-		if (ieee80211_sdata_running(tmp) &&
-		    tmp->vif.type == NL80211_IFTYPE_NAN) {
-			sdata = tmp;
-			break;
-		}
-	}
-
-	if (!sdata)
-		return false;
+	if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_NAN))
+		return NULL;
 
 	sched_cfg = &sdata->vif.cfg.nan_sched;
 
@@ -823,10 +810,34 @@ bool ieee80211_nan_try_evacuate(struct ieee80211_hw *hw,
 
 	/* No suitable NAN channel found */
 	if (!evac_chan)
-		return false;
+		return NULL;
 
 	/* NAN needs at least one remaining usable channel after evacuation */
 	if (usable_channels < 2)
+		return NULL;
+
+	return evac_chan;
+}
+
+bool ieee80211_nan_try_evacuate(struct ieee80211_hw *hw,
+				struct ieee80211_chanctx_conf *conf)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_sub_if_data *sdata =
+		ieee80211_find_nan_sdata(local);
+	struct ieee80211_nan_channel *evac_chan;
+	struct ieee80211_chanctx *ctx = NULL;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (!sdata)
+		return false;
+
+	if (conf)
+		ctx = container_of(conf, struct ieee80211_chanctx, conf);
+
+	evac_chan = ieee80211_nan_find_evac_chan(local, sdata, ctx);
+	if (!evac_chan)
 		return false;
 
 	ieee80211_nan_evacuate_channel(sdata, evac_chan);
-- 
2.34.1


