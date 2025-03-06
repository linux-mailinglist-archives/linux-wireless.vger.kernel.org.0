Return-Path: <linux-wireless+bounces-19889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 414ACA5483B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE7171E1A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CFC20B1EF;
	Thu,  6 Mar 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AeBckitk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29DC20AF77
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257840; cv=none; b=aBipzwN798dSDF2Oy+of+3H27wDe1IwZKujownJvDlvDKe+itYL28YaZgbY03PovLZM60ESdhqp7irhniqkDM2eDqotfCfj2QRtbTV5DHKk/tUgG0cROLfiZNyYnQ7V+WV8sVrNRPgbwTyHmyC2RriYY6NYqyK1LTarqSogZi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257840; c=relaxed/simple;
	bh=Mozn9GM8A5OO8wzQLG5biURyg82peQ/rG6dUuKHg38Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojwdVPtsp/1fm4+v5BcnqRs1ZVEbbQYi9aYXaBtxJIe05HRnrjx6pzZKLIzIGqlTpish9ICszJRx+RaMg2+jlc5y7PwWzDUuymOGwZ8/1xtQPLe4oU2wlWNkOGJtcNc1LwAFJrSjQbfiQ4FG7BeVT9iGjKCInExo63cTsnnzxYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AeBckitk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257839; x=1772793839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mozn9GM8A5OO8wzQLG5biURyg82peQ/rG6dUuKHg38Q=;
  b=AeBckitkEwrKS/DLAtuWo7txDRevD91Hs5mRYl4eZHtlboZYIZ9GLdNh
   RIRfETUucTzh+8+k7AuAAsIZoX5+jtCc0Cq5sgDs1dFHxUWhdymg2cwKp
   Gs1YzcDHbbnz7376L6VtcO0JtdcpqatpINuQilGDZAmkvwoNhwUutzVPB
   T/QVSaLWfhidbW26DmKlpu1qcKIK6QFRch8I/c1Vf9J/1894gTfBL4Vnb
   M3wgbNiH1LCOP3VsOO1flFvYbEli2iCm/3xYzUilQ5xktlN8oMcTbskOb
   EUt7YJS2+Y5ItAgipgaVQadQtJYuyuUeqcFr+H6o7lJ1RDkLF1B7z2+Sr
   A==;
X-CSE-ConnectionGUID: YiIN3S+/S4ufHLKa8TXmJQ==
X-CSE-MsgGUID: T+BHHBPATZqZB7wIcYdyPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844519"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844519"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:59 -0800
X-CSE-ConnectionGUID: wL8lFn4PSuq82CtkeQQalQ==
X-CSE-MsgGUID: pCVzOqqMRpO7DPUFrI1Prw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797780"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 13/15] wifi: mac80211: fix ML reconf reset in disconnect
Date: Thu,  6 Mar 2025 12:43:24 +0200
Message-Id: <20250306124057.0f4758d60066.I7e6b35731ded94fc2d68a2d4ecf81873712c268e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If disconnecting while ML reconfiguration is in progress,
the data isn't freed because the reset call is too late,
after the vif already switches to non-MLD. Move the call
to fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 60a585caa96d..9c4d4f04b23e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4152,16 +4152,16 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	wiphy_work_cancel(sdata->local->hw.wiphy,
 			  &ifmgd->teardown_ttlm_work);
 
-	ieee80211_vif_set_links(sdata, 0, 0);
-
-	ifmgd->mcast_seq_last = IEEE80211_SN_MODULO;
-
 	/* if disconnection happens in the middle of the ML reconfiguration
 	 * flow, cfg80211 must called to release the BSS references obtained
 	 * when the flow started.
 	 */
 	ieee80211_ml_reconf_reset(sdata);
 
+	ieee80211_vif_set_links(sdata, 0, 0);
+
+	ifmgd->mcast_seq_last = IEEE80211_SN_MODULO;
+
 	ifmgd->epcs.enabled = false;
 	ifmgd->epcs.dialog_token = 0;
 }
-- 
2.34.1


