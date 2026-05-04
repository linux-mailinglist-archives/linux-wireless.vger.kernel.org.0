Return-Path: <linux-wireless+bounces-35819-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e3FxIn9J+GlMsQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35819-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:23:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DD04B94BA
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3ADC3015E10
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 07:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9525D2DEA74;
	Mon,  4 May 2026 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YeQ8Mnrg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07C2DB7BE
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879291; cv=none; b=HmvEBWYcFLForIJ+UEh7bdur/14yHDMaithSOtVGzYbYM5zqhviWNfZOjpqb5jGceFkziDrb08n0s/ZpGWuB0qhqLWBEW4FyVj2Xv5jYTwYvjyCQoqIErrqA+6/Ggp0TicH7QrK62FziqJ1VJxQqeeUkhl2pwCYMuOG1VByEQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879291; c=relaxed/simple;
	bh=bvVSoWbmVX8hEz4sUSz+J78YC7+cKs8BWcq6a7J7WwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UFAc8ZJCj30fVk6MHnUBE/VOxdtNu+wdVo3WV8O8IBkV5f533FYP07RuVUZLzjL0kRM1LtD5kdqCCEwHjitYu5IhWs3uD520Bhv9+S9wp6Da/37Qudyhff4gDLtNvaYvU8lBfgz6f/+tX+S33tmNXSLRy7pP1COZoAHoBcBzg7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YeQ8Mnrg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777879288; x=1809415288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bvVSoWbmVX8hEz4sUSz+J78YC7+cKs8BWcq6a7J7WwI=;
  b=YeQ8MnrgwN//BTMRiFb5mKocySDAZ5yZH/O5DkpBG6cf5iHU84aPiugl
   A41IYu4Wl7mIl/3Is9f1VrJjSWiIxMudB+Sntaho1k+z8bm69vWqe6Pyf
   AYiSOy1RFNDMwr6XTsQS4kcqJj6kx9sHzzR0n630aWCzFjO+cX/KI1AXY
   TGcxLaxrRKxJbT0z3SSZchlI1nNrPKSxhh/UoUP8jJB/I8rB074NWo+6Q
   KZYq+FLhpErwG3INamGOt2RBWSqkOrNvKjLie7dlCWx34bLSoUYfKINrB
   GudKrFiETHT5sJpoSDFMR49XIO8vTr3VeJGLG4LDLcFx0VuLSP8dCU+c5
   w==;
X-CSE-ConnectionGUID: YTYuDBWRTVu2uNWRT4ANpQ==
X-CSE-MsgGUID: YGbpLl01SmahzjM2h2kWvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101398333"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="101398333"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:26 -0700
X-CSE-ConnectionGUID: vU/EfXfURbSHTUrOVgOEBA==
X-CSE-MsgGUID: fNXUqp5XTkWivWZHVHRenA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273555275"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 wireless-next 13/15] wifi: mac80211_hwsim: register beacon timer by calculating TBTT
Date: Mon,  4 May 2026 10:20:53 +0300
Message-Id: <20260504101829.cc6f099ae2ac.Iccf6164f3feeb5350fcfe0df666248c686b226ae@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
References: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 24DD04B94BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35819-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

From: Benjamin Berg <benjamin.berg@intel.com>

It is easy to calculate the next target beacon transmission time (TBTT)
based on the current TSF and the beacon interval. Use this method to
calculate the time to the next beacon.

With this, the bcn_delta variable can be removed and drift over time due
to the timer firing late is fully avoided.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   |  1 -
 .../wireless/virtual/mac80211_hwsim_main.c    | 39 ++++++++++++-------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index b4d0a3869619..d345595ca588 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -103,7 +103,6 @@ struct mac80211_hwsim_data {
 
 	/* difference between this hw's clock and the real clock, in usecs */
 	s64 tsf_offset;
-	s64 bcn_delta;
 
 	/* Stats */
 	u64 tx_pkts;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 5bf6541498ec..ba2aa09b37cb 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1216,6 +1216,12 @@ static inline u64 mac80211_hwsim_get_sim_tsf(void)
 	return ktime_to_us(ktime_get_boottime());
 }
 
+static ktime_t mac80211_hwsim_tsf_to_boottime(struct mac80211_hwsim_data *data,
+					      u64 tsf)
+{
+	return us_to_ktime(tsf - data->tsf_offset);
+}
+
 u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif)
 {
@@ -1237,8 +1243,6 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 	u64 now = mac80211_hwsim_get_tsf(hw, vif);
-	/* MLD not supported here */
-	u32 bcn_int = data->link_data[0].beacon_int;
 	u64 delta = abs(tsf - now);
 	struct ieee80211_bss_conf *conf;
 
@@ -1247,13 +1251,10 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 		return;
 
 	/* adjust after beaconing with new timestamp at old TBTT */
-	if (tsf > now) {
+	if (tsf > now)
 		data->tsf_offset += delta;
-		data->bcn_delta = do_div(delta, bcn_int);
-	} else {
+	else
 		data->tsf_offset -= delta;
-		data->bcn_delta = -(s64)do_div(delta, bcn_int);
-	}
 }
 
 static void mac80211_hwsim_monitor_rx(struct ieee80211_hw *hw,
@@ -2410,7 +2411,9 @@ mac80211_hwsim_beacon(struct hrtimer *timer)
 		container_of(link_data, struct mac80211_hwsim_data,
 			     link_data[link_data->link_id]);
 	struct ieee80211_hw *hw = data->hw;
-	u64 bcn_int = link_data->beacon_int;
+	u32 remainder;
+	u64 tsf_now;
+	u64 tbtt;
 
 	if (!data->started)
 		return HRTIMER_NORESTART;
@@ -2419,13 +2422,19 @@ mac80211_hwsim_beacon(struct hrtimer *timer)
 		hw, IEEE80211_IFACE_ITER_NORMAL,
 		mac80211_hwsim_beacon_tx, link_data);
 
-	/* beacon at new TBTT + beacon interval */
-	if (data->bcn_delta) {
-		bcn_int -= data->bcn_delta;
-		data->bcn_delta = 0;
-	}
-	hrtimer_forward_now(&link_data->beacon_timer,
-			    ns_to_ktime(bcn_int * NSEC_PER_USEC));
+	/* TSF is the same for all VIFs, parameter is unused */
+	tsf_now = mac80211_hwsim_get_tsf(hw, NULL);
+
+	/* Wrap value to be after the next TBTT */
+	tbtt = tsf_now + link_data->beacon_int;
+
+	/* Round TBTT down to the correct time */
+	div_u64_rem(tbtt, link_data->beacon_int, &remainder);
+	tbtt = tbtt - remainder;
+
+	hrtimer_set_expires(&link_data->beacon_timer,
+			    mac80211_hwsim_tsf_to_boottime(data, tbtt));
+
 	return HRTIMER_RESTART;
 }
 
-- 
2.34.1


