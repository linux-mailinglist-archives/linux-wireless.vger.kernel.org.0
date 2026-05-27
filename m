Return-Path: <linux-wireless+bounces-37021-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Kp4LudMF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37021-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 21:58:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BC25E9D18
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 21:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AA1A3105BAE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF533B3BE3;
	Wed, 27 May 2026 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOaaFhrR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD73B2D18
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911524; cv=none; b=fFssbFs6To/SxUgumIQH88HzPveXhVT6CGsdPaJMqpoDNjPaEmUziizJFRSbogoYYbPVAlYUrN66He+VqJDgXcrx1/sj7PYiKFSIJkheO0bksNx3kq+JYdwEy2PPbAUeVK/BeNhcfynDdFXHHOdPQHsovRFyIMhk3p6imKuRUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911524; c=relaxed/simple;
	bh=YLLu/d+nhSs+Yv314sg70kiu5Mtg2c97Uz8cHMHqWao=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fD2GpU9FL4qCDQS6xX0U4GcP+2yEJjdQRei/t9tyeQox8dwkTlmw9tl8HPUa1qFOtD8lByM/Z6u7FjjGB7517upD8SNioOHOW/Dnx3riPCOcskARVcIlUiMXdlUyHmLREQrx6CNrf4KBAQSxCk7YAvkGL+U7Ip9gvmCEjPfXDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOaaFhrR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779911522; x=1811447522;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=YLLu/d+nhSs+Yv314sg70kiu5Mtg2c97Uz8cHMHqWao=;
  b=KOaaFhrR6YRKR2livmabEFF6PAyPr/qYY+QS2e4W2z/acKUqhvG7NEAC
   EnquxFDGiMPFWGP0Y02oapbfabXdqwWuIR0OPjVbyGkPHbolzBIr5jQZm
   UQbiUSYik0LMpUsa5/3r4tS7fvPUVLrIAaAfbtdfjtRP5lDTdI/HFlnhy
   FxsXKjph3xircktkvjMmFiyIiAtvgOPYAJShCOs2UgBPR/8efsJVgKUID
   WHzrpheYycSQ+4VyLf7EpB6CxJWhwx0DZ4QOWZWCF88Z4TkcMg3MOeC+g
   wK2Fbqu6LTqCgjuDO0Tdyt8KcrBxWVDyQNp1l6GShUj8pqZp2L0A2IBxL
   w==;
X-CSE-ConnectionGUID: YtVdFIBTQKSMIYMhFzqJ0w==
X-CSE-MsgGUID: 00kZRnlHRsSK4E/Qy/p7zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80784722"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80784722"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:52:01 -0700
X-CSE-ConnectionGUID: yOSkNtxuQ/eG+RLXQa4PDQ==
X-CSE-MsgGUID: gDx0cxPKTCWxMs4FhOQ3Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="280465110"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:52:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 1/3] wifi: mac80211: add an option to filter out a channel in combinations check
Date: Wed, 27 May 2026 22:51:43 +0300
Message-Id: <20260527224745.0042232f996e.I5d323125e34f3b253510e85ceb7a770d59f689fb@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37021-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 38BC25E9D18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sometimes, ieee80211_check_combinations fails, but it is hard to know
why exactly. We will have to return an array of reasons, one per
combination.

In cases where we want to check if it failed because there are not
enough chanctxs (and maybe remove one if needed), we can just not fill
in that chanctx(s) in iface_combination_params::num_different_channels
in ieee80211_fill_ifcomb_params, so that chanctx(s) won't be taken into
account.

To allow that, add an option to pass a callback to
ieee80211_fill_ifcomb_params. This callback will be called for each
chanctx we consider to count in num_different_channels and will return
whether or not this chanctx should be skipped and not counted.

This mechanism will be used later.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h | 34 ++++++++++++++++++++++++++++++----
 net/mac80211/util.c        | 34 +++++++++++++++++++++-------------
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index fc4424b125c1..1ac92e005763 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2818,10 +2818,36 @@ int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
 			      struct cfg80211_csa_settings *csa_settings);
 void ieee80211_recalc_sb_count(struct ieee80211_sub_if_data *sdata, u64 tsf);
 void ieee80211_recalc_dtim(struct ieee80211_sub_if_data *sdata, u64 tsf);
-int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
-				 const struct cfg80211_chan_def *chandef,
-				 enum ieee80211_chanctx_mode chanmode,
-				 u8 radar_detect, int radio_idx);
+
+struct ieee80211_check_combinations_data {
+	const struct cfg80211_chan_def *chandef;
+	enum ieee80211_chanctx_mode chanmode;
+	u8 radar_detect;
+	int radio_idx;
+	bool (*chanctx_filter)(struct ieee80211_chanctx *ctx,
+			       void *filter_data);
+	void *filter_data;
+};
+
+int ieee80211_check_combinations_ext(struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_check_combinations_data *data);
+
+static inline int
+ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
+			     const struct cfg80211_chan_def *chandef,
+			     enum ieee80211_chanctx_mode chanmode,
+			     u8 radar_detect, int radio_idx)
+{
+	struct ieee80211_check_combinations_data data = {
+		.chandef = chandef,
+		.chanmode = chanmode,
+		.radar_detect = radar_detect,
+		.radio_idx = radio_idx,
+	};
+
+	return ieee80211_check_combinations_ext(sdata, &data);
+}
+
 int ieee80211_max_num_channels(struct ieee80211_local *local, int radio_idx);
 u32 ieee80211_get_radio_mask(struct wiphy *wiphy, struct net_device *dev);
 void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 255905f971c8..2a7ab269687a 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4260,7 +4260,10 @@ static int
 ieee80211_fill_ifcomb_params(struct ieee80211_local *local,
 			     struct iface_combination_params *params,
 			     const struct cfg80211_chan_def *chandef,
-			     struct ieee80211_sub_if_data *sdata)
+			     struct ieee80211_sub_if_data *sdata,
+			     bool (*chanctx_filter)(struct ieee80211_chanctx *ctx,
+						    void *filter_data),
+			     void *filter_data)
 {
 	struct ieee80211_sub_if_data *sdata_iter;
 	struct ieee80211_chanctx *ctx;
@@ -4281,6 +4284,10 @@ ieee80211_fill_ifcomb_params(struct ieee80211_local *local,
 		    cfg80211_chandef_compatible(chandef, &ctx->conf.def))
 			continue;
 
+		if (chanctx_filter &&
+		    chanctx_filter(ctx, filter_data))
+			continue;
+
 		params->num_different_channels++;
 	}
 
@@ -4305,26 +4312,25 @@ ieee80211_fill_ifcomb_params(struct ieee80211_local *local,
 	return total;
 }
 
-int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
-				 const struct cfg80211_chan_def *chandef,
-				 enum ieee80211_chanctx_mode chanmode,
-				 u8 radar_detect, int radio_idx)
+int ieee80211_check_combinations_ext(struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_check_combinations_data *data)
 {
-	bool shared = chanmode == IEEE80211_CHANCTX_SHARED;
+	const struct cfg80211_chan_def *chandef = data->chandef;
+	bool shared = data->chanmode == IEEE80211_CHANCTX_SHARED;
 	struct ieee80211_local *local = sdata->local;
 	enum nl80211_iftype iftype = sdata->wdev.iftype;
 	struct iface_combination_params params = {
-		.radar_detect = radar_detect,
-		.radio_idx = radio_idx,
+		.radar_detect = data->radar_detect,
+		.radio_idx = data->radio_idx,
 	};
 	int total;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (WARN_ON(hweight32(radar_detect) > 1))
+	if (WARN_ON(hweight32(data->radar_detect) > 1))
 		return -EINVAL;
 
-	if (WARN_ON(chandef && chanmode == IEEE80211_CHANCTX_SHARED &&
+	if (WARN_ON(chandef && data->chanmode == IEEE80211_CHANCTX_SHARED &&
 		    !chandef->chan))
 		return -EINVAL;
 
@@ -4343,7 +4349,7 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 
 	/* Always allow software iftypes */
 	if (cfg80211_iftype_allowed(local->hw.wiphy, iftype, 0, 1)) {
-		if (radar_detect)
+		if (data->radar_detect)
 			return -EINVAL;
 		return 0;
 	}
@@ -4356,7 +4362,9 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 
 	total = ieee80211_fill_ifcomb_params(local, &params,
 					     shared ? chandef : NULL,
-					     sdata);
+					     sdata,
+					     data->chanctx_filter,
+					     data->filter_data);
 	if (total == 1 && !params.radar_detect)
 		return 0;
 
@@ -4383,7 +4391,7 @@ int ieee80211_max_num_channels(struct ieee80211_local *local, int radio_idx)
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	ieee80211_fill_ifcomb_params(local, &params, NULL, NULL);
+	ieee80211_fill_ifcomb_params(local, &params, NULL, NULL, NULL, NULL);
 
 	err = cfg80211_iter_combinations(local->hw.wiphy, &params,
 					 ieee80211_iter_max_chans,
-- 
2.34.1


