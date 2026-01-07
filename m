Return-Path: <linux-wireless+bounces-30446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 240EBCFDE49
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 14:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9793730049C9
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC3B329C53;
	Wed,  7 Jan 2026 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1IdPkh7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA723EAAF
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792020; cv=none; b=kYQRntwt77mn9hf58pQMJ9sSsc75porkquG7L1w+DDDBhd2MHzS2fsEfs0Fkx9EE6DajgkvXAl4V/MfrSWz4zJVVgQ7Ohy0oPx517D5bc7kExgShzYX6W1DTIwBXQjAeR4XMG2GJ6iqB5RdgqQmcNh6NBzpoxjWYuzQpJ93sxoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792020; c=relaxed/simple;
	bh=6CdjwJQ7hPiohaz0fdQwC6bD08nUDLHNuovY/UzQN8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nvi45VpPONciyCKYTHvmOOmE4SRNbqWeSictcfLJQfB7VYDVKxFvVf3NxA+wMuGtAoVjRDyKx36hOreDpqDGBUeTNNfrFHAjoPO3eNCbLJCih6gXDXThtYOFS8RKM0Y0Lgb4yP1brDom9H1oSI1FQZo6aPnWXQt5sqTN7uvZlXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1IdPkh7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767792019; x=1799328019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6CdjwJQ7hPiohaz0fdQwC6bD08nUDLHNuovY/UzQN8A=;
  b=m1IdPkh70qHfHTDH6O4+HBzVyzDCZN70Nh57seaFRGIQpiPbrQyHXhIW
   X3GPwnL5nMolRsLeYO7hvavsNHhcCxyL/TftHABitwDKzrjo5OYhjBEJ6
   eRKR6t7O7jzhR3brRHTeefmZZF1CtxtC9cTnBsy8B/nUThdKGCx1ANvdY
   pEL+Oeom+kaTJK/wU6EHQ99xxoLBGsrP2s4No8xGgkJ01Ym4L2DxCyR4x
   dgDHwyiYqO19omM3uXFmt0uHcCUX67Q2f6jzzOfRbLHiYS3THYMCbghEM
   KxV2ursJ6+u0TKKK6UCPShOfGAAn4hN08uSETYUidJSt8+tGni1aYomK8
   A==;
X-CSE-ConnectionGUID: 3NJfiiHETRS3mMeEfAloKQ==
X-CSE-MsgGUID: RGwbDGSOQpCzMweBvTbBkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86576858"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86576858"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:18 -0800
X-CSE-ConnectionGUID: NvdVzJ5+T0mNUUhmm13D9A==
X-CSE-MsgGUID: P20EH4dATPSW3mKaKBBwtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203185738"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 04/15] wifi: nl80211: don't allow DFS channels for NAN
Date: Wed,  7 Jan 2026 15:19:52 +0200
Message-Id: <20260107150057.e4c71fd7a030.Idca29fb8a235df980e63b733a298fd1f2bdf2f48@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
References: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
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


