Return-Path: <linux-wireless+bounces-13592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADA8992AF1
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A731F2351D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3DC1D2229;
	Mon,  7 Oct 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYvhfO/B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9961BA285
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302484; cv=none; b=BMUN1qa+Qazyjm8NAKkdCCedePEL4wAJaj0j9qvfOJjxg4lY/vkmx0MKWiJd6hOyHCVP3KRRf/HXrRzMueTHrmAcBz6V/aRh8J14Qze7LXEUfh6AaK/cKhhwBfQ92Xw1/+XvijiNtA7nGeswlFfBVZksDFneiSr3yNCi+HzcNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302484; c=relaxed/simple;
	bh=TfM0galE5R1gNxhnJhmMReDupVt8kepLFhptsS4yPWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZpvQDKhtSvciUuk65Ddc/JYwlWhTboWsC9OZG4pEseIMFyf+savzFbapOMWRp1nZPRUdKsBo7IvWHX+ndeXP4kCkl2pE4fyMx/1Jc6ARd1nPGSDtxVRGxuAgcc8ZnWHI/ocjKq4THB/33N8xH7StgbybJsXy/o4/fHB5f/I/G0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYvhfO/B; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302483; x=1759838483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TfM0galE5R1gNxhnJhmMReDupVt8kepLFhptsS4yPWk=;
  b=jYvhfO/BUrsYpz5zQ1NO3ucV7ZQSlwkZuxAQv/QYn/T0zbOtwg319x+M
   luW6VliQzbz4MZiRjcv+jd/eMrIRRP3C796E4F7Gmx7nzb/tDI/wgBqnS
   hrH3cWwJt3h59OXMuBJ49PbYDvba10r3Xvr3bV2EJoJcD1C6K6jG8tnDu
   jI+3lnP+NDKVojhZ0hGjk7a+nkEZJkwd2w7IgRt2+DBTy9RCAt7khZ4Ro
   RxE5DPPAr4xfILs77iCuZTZHL+z3a1qtL+rNTlkbVxPHA/H+mhHBH0jjm
   NTJNJIStbkonUwF7zNuld/fspxk2+KpoeV8bQ7ufQSzqZIl93/D1w6nwK
   Q==;
X-CSE-ConnectionGUID: C6i5ObiFTIKTWDmietH6cg==
X-CSE-MsgGUID: eWJyVt75Qt+RW26d2tXfNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099402"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099402"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:23 -0700
X-CSE-ConnectionGUID: m7GI8gO9Q02oNZ3/pk1hfQ==
X-CSE-MsgGUID: upg9HI/pSS+Xz/cJn5r++g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019263"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/14] wifi: mac80211: __ieee80211_recalc_txpower receives a link
Date: Mon,  7 Oct 2024 15:00:51 +0300
Message-Id: <20241007144851.3c9cd0731f5b.I6ebfd9d5084f3602b55c55e2669881fd92471c2f@changeid>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Handle the tx power per-link. Don't change the behavior for now. Just
change the signature of the function.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/iface.c       | 5 +++--
 net/mac80211/mlme.c        | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 67de4675c33a..edb2d55a5126 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2033,7 +2033,7 @@ void ieee80211_sdata_stop(struct ieee80211_sub_if_data *sdata);
 int ieee80211_add_virtual_monitor(struct ieee80211_local *local);
 void ieee80211_del_virtual_monitor(struct ieee80211_local *local);
 
-bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata);
+bool __ieee80211_recalc_txpower(struct ieee80211_link_data *link);
 void ieee80211_recalc_txpower(struct ieee80211_link_data *link,
 			      bool update_bss);
 void ieee80211_recalc_offload(struct ieee80211_local *local);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index e4a8ed102736..138ba30e23ba 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -44,8 +44,9 @@
 
 static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work);
 
-bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
+bool __ieee80211_recalc_txpower(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	int power;
 
@@ -77,7 +78,7 @@ bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
 void ieee80211_recalc_txpower(struct ieee80211_link_data *link,
 			      bool update_bss)
 {
-	if (__ieee80211_recalc_txpower(link->sdata) ||
+	if (__ieee80211_recalc_txpower(link) ||
 	    (update_bss && ieee80211_sdata_running(link->sdata)))
 		ieee80211_link_info_change_notify(link->sdata, link,
 						  BSS_CHANGED_TXPOWER);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e791f75a09a4..2cb3691971e0 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2872,7 +2872,7 @@ static u64 ieee80211_handle_pwr_constr(struct ieee80211_link_data *link,
 	}
 
 	link->ap_power_level = new_ap_level;
-	if (__ieee80211_recalc_txpower(sdata))
+	if (__ieee80211_recalc_txpower(link))
 		return BSS_CHANGED_TXPOWER;
 	return 0;
 }
-- 
2.34.1


