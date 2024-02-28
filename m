Return-Path: <linux-wireless+bounces-4149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EB486AA6A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299B91F24224
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7857B1F608;
	Wed, 28 Feb 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ECnj++LN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B02E645
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110153; cv=none; b=Md0DUAYgw9cpJlum8BaM0fOUV35miR8plY4Plc3MeeMJaYgwqBX7AhBxcM1IlZ2AeW8rq3D6FsxV4BoGcCzBF9SMpoehPsyXMVDl5oSYM5FAuDNMtB5+QqqtYFHfx7LXZJEtsdGiqvLVNbGfuG5csas3V4WA1Haym44Jw29FRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110153; c=relaxed/simple;
	bh=5GLVSC06hdTgmKYD7ptGjvB2NStnUMElXHaKdFIjb68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1D0APNR40smIx0zergWIv5jo5W9QIOcC097DmdrI5ITExEHCnofgOCMsEso6LGCof4Yr5ohu0aXr74KxobmthCFZaF1eZyr5iMircW4FlWvnBI8Kwi+OU8XhixJ3nukobdUr3YdBcThVW1FR3IhPp/bq2iCgY+A3MnJpFOyFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ECnj++LN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=t/w5p9Ddd7KWaBeviRr03DEa6DuT8tU/8RU+wi9yKDQ=;
	t=1709110151; x=1710319751; b=ECnj++LNeJ3gUvqJKrcDRvQhvkWSaFi0mW8YXbS92muxibT
	WIO7Emw+7jcEfMvRLbpF/AWDZenVaCfUcrCNvp64+BFHZwp8mS/o8Dut/wpacDImnHgEqROw0cH8R
	bapDpYBCehhoMrafQe9/H0Rluj4WX4f2TMeYD7OL0eRS/bGEPW/ZEGqHYz0iyVS7UiGaexgEeZE7n
	+2NtRNXY8bWvzxFeyEpi0cyIYEyb14xiqAD5xtilIbPgRp32t0PHxeqieU7vnGnS9iJCZCBntESwL
	08p1P+1FoEI4BoU1gAp35gpVCAP9QPVO8cgWN0emRnm6GTTWx/w0zp/XJOERJyMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFci-0000000C0BC-3tq1;
	Wed, 28 Feb 2024 09:49:09 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 6/8] wifi: mac80211: defragment reconfiguration MLE when parsing
Date: Wed, 28 Feb 2024 09:48:14 +0100
Message-ID: <20240228094902.92936a3ce216.I4b736ce4fdc199fa1d6b00d00032f448c873a8b4@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228084901.18661-10-johannes@sipsolutions.net>
References: <20240228084901.18661-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Using the scratch buffer (without advancing it) here in the
mlme.c code seems somewhat wrong, defragment the reconfig
multi-link element already when parsing. This might be a bit
more work in certain cases, but makes the whole thing more
regular.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mlme.c        | 19 +++----------------
 net/mac80211/parse.c       | 22 ++++++++++++++++++++++
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e8ca9ad12e62..768f614731a7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1736,6 +1736,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_eht_cap_elem *eht_cap;
 	const struct ieee80211_eht_operation *eht_operation;
 	const struct ieee80211_multi_link_elem *ml_basic;
+	const struct ieee80211_multi_link_elem *ml_reconf;
 	const struct ieee80211_bandwidth_indication *bandwidth_indication;
 	const struct ieee80211_ttlm_elem *ttlm[IEEE80211_TTLM_MAX_CNT];
 
@@ -1763,6 +1764,7 @@ struct ieee802_11_elems {
 
 	/* mult-link element can be de-fragmented and thus u8 is not sufficient */
 	size_t ml_basic_len;
+	size_t ml_reconf_len;
 
 	/* The basic Multi-Link element in the original elements */
 	const struct element *ml_basic_elem;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f4544f167005..e6a82f28a7c6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5752,33 +5752,20 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 					 struct ieee802_11_elems *elems)
 {
-	const struct ieee80211_multi_link_elem *ml;
 	const struct element *sub;
-	ssize_t ml_len;
 	unsigned long removed_links = 0;
 	u16 link_removal_timeout[IEEE80211_MLD_MAX_NUM_LINKS] = {};
 	u8 link_id;
 	u32 delay;
 
-	if (!ieee80211_vif_is_mld(&sdata->vif) || !elems->ml_reconf_elem)
+	if (!ieee80211_vif_is_mld(&sdata->vif) || !elems->ml_reconf)
 		return;
 
-	ml_len = cfg80211_defragment_element(elems->ml_reconf_elem,
-					     elems->ie_start,
-					     elems->total_len,
-					     elems->scratch_pos,
-					     elems->scratch + elems->scratch_len -
-					     elems->scratch_pos,
-					     WLAN_EID_FRAGMENT);
-	if (ml_len < 0)
-		return;
-
-	ml = (const void *)elems->scratch_pos;
-
 	/* Directly parse the sub elements as the common information doesn't
 	 * hold any useful information.
 	 */
-	for_each_mle_subelement(sub, (u8 *)ml, ml_len) {
+	for_each_mle_subelement(sub, (const u8 *)elems->ml_reconf,
+				elems->ml_reconf_len) {
 		struct ieee80211_mle_per_sta_profile *prof = (void *)sub->data;
 		u8 *pos = prof->variable;
 		u16 control;
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 8bdf6e7efa58..804323858977 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -819,6 +819,26 @@ static void ieee80211_mle_parse_link(struct ieee802_11_elems *elems,
 	_ieee802_11_parse_elems_full(&sub, elems, non_inherit);
 }
 
+static void
+ieee80211_mle_defrag_reconf(struct ieee802_11_elems *elems)
+{
+	ssize_t ml_len;
+
+	ml_len = cfg80211_defragment_element(elems->ml_reconf_elem,
+					     elems->ie_start,
+					     elems->total_len,
+					     elems->scratch_pos,
+					     elems->scratch +
+					     elems->scratch_len -
+					     elems->scratch_pos,
+					     WLAN_EID_FRAGMENT);
+	if (ml_len < 0)
+		return;
+	elems->ml_reconf = (void *)elems->scratch_pos;
+	elems->ml_reconf_len = ml_len;
+	elems->scratch_pos += ml_len;
+}
+
 struct ieee802_11_elems *
 ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 {
@@ -864,6 +884,8 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 
 	ieee80211_mle_parse_link(elems, params);
 
+	ieee80211_mle_defrag_reconf(elems);
+
 	if (elems->tim && !elems->parse_error) {
 		const struct ieee80211_tim_ie *tim_ie = elems->tim;
 
-- 
2.43.2


