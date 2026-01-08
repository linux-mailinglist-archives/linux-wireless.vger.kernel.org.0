Return-Path: <linux-wireless+bounces-30525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3271BD03D57
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB17031D16A6
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0089634D4DF;
	Thu,  8 Jan 2026 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gePP1+lB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8A34AAEB
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861373; cv=none; b=cSf/dBkjtf1DE9d6Y4CSg1L2/yikj6+N2QzKTG0fG5Lo53UBK3nr1WJCFQlBTDX7erilADPalCpJ8c+cbhF1Tu4TOGNk3yXs6xZy5pVANURKtR5z1Vv/Pxc5FdX4j4lA0IfghCoiPrH3bdCdq9UzpO3GPJ+iR3FHfTgU4Do23+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861373; c=relaxed/simple;
	bh=6CdjwJQ7hPiohaz0fdQwC6bD08nUDLHNuovY/UzQN8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jMhb3Td3rDDV+PBx8WWyBmfETmM1hmg8JQdcMOKC+/WaRcIS6OFc4mfecEu6wXVjzI0gHz3NUKOCqlb//YgZ1BvAigFTNrCaHp6aumLsfAI2bFzchgt8eVarrBXjSZHPl+B8NNvb3HztHTD2OheqqZZPHFxqXouVF4QZ+4xLt9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gePP1+lB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767861368; x=1799397368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6CdjwJQ7hPiohaz0fdQwC6bD08nUDLHNuovY/UzQN8A=;
  b=gePP1+lBDwbTvnHGseLa5iquzJ6LcDWkueL6+f8dG2jSS0FKa+jokvTd
   1FMcBfRQB3UVJWHxKk1So0Il188pT6XcSSDY5AJBARY8Ya7d4EbXynRrA
   4D84+a+5YfQPdVIaJfC0qA/mIR2FB+m8Xg9Knve5doIzLuV+b9M4zrI1n
   UwcpF1fb7Vg5Fl+td+dNHsemgaeAMNghlwKKQj6Lwr83RgqEcnima/k2F
   vQtvnTfD07Y2JpS/82IbAQRYOylz/2ytKPjNE2O8sreRgqBFGX5GYugsz
   duWFHA+cglOWeFFRIq/3DKuso1xdh0g3GeZZlhiLlccRQDLDqoZukKgRM
   w==;
X-CSE-ConnectionGUID: UyxfBx4WQ9W4EQ6c4wjaXQ==
X-CSE-MsgGUID: sRN95mMFRGysClkx219bTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73084787"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73084787"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:57 -0800
X-CSE-ConnectionGUID: F/sCMjvXRaSAYjtizgqM6g==
X-CSE-MsgGUID: 6L/VZNcISHWEAQkz4+eiYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233847473"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v2 05/14] wifi: nl80211: don't allow DFS channels for NAN
Date: Thu,  8 Jan 2026 10:35:31 +0200
Message-Id: <20260108102921.c2a5a0a14b9f.Idca29fb8a235df980e63b733a298fd1f2bdf2f48@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
References: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
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


