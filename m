Return-Path: <linux-wireless+bounces-16995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D4B9FFA6A
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32731605CB
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BC81B5EBC;
	Thu,  2 Jan 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcSHXums"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7221B6CF6
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827651; cv=none; b=DKMny5B5M6usu8oQmEnFKafcYxtEG6KrfHiGaMgI9a5n5Jfbd6VX7GBvHzaLUjIxsjNB8totAunJ26l/U4YidSRQZAH+R2a88Nj6TaMOUiEC5098R4q7mfgV0ETljY2CvNzFin5RRIKApqVAN9nvZbM8slAljvBg9DGnOrpkfX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827651; c=relaxed/simple;
	bh=JJPQVWKH+mTq6R4jQgUyomNEBmTpbjK8ktVAeXAAQZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O6aE9ecvi54Hx+JvHcBAYtIb9GcpAxpqSGjtRyWzIU1SzW/QEmbAfRuB/aELk+e6JWXOHK8Lr0dlo/GX5Ov0kEgeNSK/T3nJ2R+bvSZ3oy9r6SsuSVSP0RigOHVQePqqe3nTnh6gBnKhWJHoG8KcYptMf61USVhCPtzfeOksPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcSHXums; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827649; x=1767363649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JJPQVWKH+mTq6R4jQgUyomNEBmTpbjK8ktVAeXAAQZE=;
  b=CcSHXumsPUuh5zhbxMme1g2eW6s16afjL7DwmehGFHERfUITcx+V7IXr
   m8mPCnxfHjFBzvKbzxmyfMjdMDEFdFP7bTZ9O5pg9LPTaCIDVqxRma2ol
   9iVrzQqFYnfuuYrMc4HFLA/21Tt8YulLKGFzoKPjQTTDQsQ/W3bwxTafR
   o+yGDtduZ/qc1Nw0wXTcG1u4fVpT5Ldz/PSgDRVG8K1zvVDypccsE3Fdi
   YQSxlZsSwTsEqHys2nwiuFt5aAzJ4iqJwxWqTH7VXqsItEMvq2esSMGOD
   lOYuMXZi68FAypytzDnXEkxEYh25o7zjyoIZk4dk12j2jaUQBZ/3PNDKW
   g==;
X-CSE-ConnectionGUID: tmMVlW0uTOGrcgWhhKm9Vg==
X-CSE-MsgGUID: wyNNQi2wQUalROcPcQEIFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735133"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735133"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:49 -0800
X-CSE-ConnectionGUID: e1Ji5hDAQvCDB1t4cdHL8g==
X-CSE-MsgGUID: L9Zm+WKvQL+o/6P816zNmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357455"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 17/17] wifi: mac80211: avoid double free in auth/assoc timeout
Date: Thu,  2 Jan 2025 16:20:09 +0200
Message-Id: <20250102161730.0c3f7f781096.I2b458fb53291b06717077a815755288a81274756@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In case of authentication/association timeout (as detected in
ieee80211_iface_work->ieee80211_sta_work), ieee80211_destroy_auth_data
is called.
At the beginning of it, the pointer to ifmgd::auth_data memory is
copied to a local variable.
If iface_work is queued again during the execution of the current one,
and then the driver is flushing the wiphy_works (for its needs),
ieee80211_destroy_auth_data will run again and free auth_data.
Then when the execution of the original worker continues, the previously
copied pointer will be freed, causing a kernel bug:
 kernel BUG at mm/slub.c:553! (double free)

Same for association timeout (just with ieee80211_destroy_assoc_data and
ifmgd::assoc_data)

Fix this by NULLifying auth/assoc data right after we copied
the pointer to it. That way, even in the scenario above, the code will
not handle the same timeout twice.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4d9e3e58f3cb..3ef5f82a9b87 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4507,6 +4507,8 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
+	sdata->u.mgd.auth_data = NULL;
+
 	if (!assoc) {
 		/*
 		 * we are not authenticated yet, the only timer that could be
@@ -4528,7 +4530,6 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 
 	cfg80211_put_bss(sdata->local->hw.wiphy, auth_data->bss);
 	kfree(auth_data);
-	sdata->u.mgd.auth_data = NULL;
 }
 
 enum assoc_status {
@@ -4545,6 +4546,8 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
+	sdata->u.mgd.assoc_data = NULL;
+
 	if (status != ASSOC_SUCCESS) {
 		/*
 		 * we are not associated yet, the only timer that could be
@@ -4583,7 +4586,6 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 	}
 
 	kfree(assoc_data);
-	sdata->u.mgd.assoc_data = NULL;
 }
 
 static void ieee80211_auth_challenge(struct ieee80211_sub_if_data *sdata,
-- 
2.34.1


