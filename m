Return-Path: <linux-wireless+bounces-28902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2695CC569B2
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 10:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE8EF346D8A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5A22D9786;
	Thu, 13 Nov 2025 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5ODqebe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50265330D32
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026390; cv=none; b=eCEldkxh+mOKC4sDjtSoDAaHPCE01FV+Yvj+92Fma6kWEPMvfULkNv0bimGL3jheXzjUaLaK9w7DjtyQipNZmi+wVKPOii0b+magOMoZM0Im9ZvgTZo8LhxjWejAHH1t58+ZPW4fneCmbt/OW0AJYNnW5HWnStavjL/OoHOYtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026390; c=relaxed/simple;
	bh=6CdjwJQ7hPiohaz0fdQwC6bD08nUDLHNuovY/UzQN8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7xJ7Lt3GGIiwzR0KfO5hO+z+pPj2bdr+R2R1G5NtyceoQGZfMZsd34mBi6u/N1ixGztpOBSzgS77rjeuuSfr2XT2tEFoPBeP6nh9Eye2O6KHpXueihcNi6o8oTy3bBQTaTLnKdsfRCVtcgC8xVB0qSGyU6yuI3FAatyBUuxq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5ODqebe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763026390; x=1794562390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6CdjwJQ7hPiohaz0fdQwC6bD08nUDLHNuovY/UzQN8A=;
  b=I5ODqebeWYBREi491FIfmZxiWRAldjdfws5Y1H/pBf3BxFgFpkR7+aYy
   NAJzPTe14mbIgzjWWDONq0t1Dohi5I256h3RQAZ3lHOZghdTTsdgeGXvD
   a7/v2AvuGkZtXUqXlgALc5QjV00gevShedJsyFM9cVlsTXxbLAusHodoC
   9Q2lJEtbXEUAu1WchJk8nty2OwlZNAlkTx4p3BGhGX/dNbDf/kajPurmW
   YskCMiRhQSA5l7YwrpqhA7UEEba2RyqpNn8ngpq/vTJy1p4uPvHX4Sarw
   8MfUz/kez+bMK1hIgkbf5Zvmmy9mLsp2ZsbHVCyiM78gmRf8GNoMONLMO
   Q==;
X-CSE-ConnectionGUID: N0tVZuvBTfS1Eo/7IMpXFw==
X-CSE-MsgGUID: ah2qnBkGTdGLQo5CRUjlsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65028275"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65028275"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 01:33:10 -0800
X-CSE-ConnectionGUID: rBYc99oDQCGTTGlej6HxxQ==
X-CSE-MsgGUID: RSy3KFfnSv2Wdp2HAFF3xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="188737148"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 01:33:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 2/3] wifi: nl80211: don't allow DFS channels for NAN
Date: Thu, 13 Nov 2025 11:32:58 +0200
Message-Id: <20251113112845.ea0195672de2.Idca29fb8a235df980e63b733a298fd1f2bdf2f48@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113093259.3576302-1-miriam.rachel.korenblit@intel.com>
References: <20251113093259.3576302-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

NAN cannot use DFS channels.
Mark DFS channels as unusable if the chandef is to be used for NAN.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/chan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 68221b1ab45e..0dde8f3007f0 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -754,6 +754,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_NAN:
 		width = cfg80211_chandef_get_width(chandef);
 		if (width < 0)
 			return -EINVAL;
@@ -768,7 +769,6 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
-	case NL80211_IFTYPE_NAN:
 		break;
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_UNSPECIFIED:
-- 
2.34.1


