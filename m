Return-Path: <linux-wireless+bounces-27057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2806B479A5
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62811B22AFC
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5EA2192E4;
	Sun,  7 Sep 2025 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUFN9oAX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2D17A31E
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233867; cv=none; b=bTTnjv8bW4lB/iULDd6VFicbW36+bNZTfZHKgrCq6STsycKBKl2WxO35swetYhRphFexB7KikQsCxTXpEvFs7Alpb2Lrpy2MNuomVZmF0S9KDsYTNL362ayYMKIfLJQtIh2dBJhMivFTNCnFfbL5B516KCr9iI5MBI5H0EnwRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233867; c=relaxed/simple;
	bh=T7yb95q8W9Jda7mRUS7HdLhLBmojiiZcnADDQOFpLYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NgXnBKvt9tOLYfnOH1C3P6nuspOQNoYax0VVgkuHm9VWw3sfJix1Pa0vsIDsx+HH7m4L4AWE860BUKZdhK9feZ0gt5Sjc3aPcRgC+1zZWhDsMSfkYw01sMUIurIkumgJIgP5fly1uW8jYgE25IuGR9KoIdtihfh5LSbyzyN7gzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUFN9oAX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233865; x=1788769865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7yb95q8W9Jda7mRUS7HdLhLBmojiiZcnADDQOFpLYU=;
  b=JUFN9oAXOpgqNWoTeJzRF5kNH2s2fFxa9fkxlDpast1bm5P9mw5O652M
   KE+XEre+Did0oOv7kZ00nVBY22IfwHG86gTw4hKpekbysp5iEHNr/jexc
   mIFv58K7z4edG51esI6IMfDtcakvfx6Co/PJPXAostEvWWSFuhLHBjToM
   N9S6Ew+fM7O+HuEKDk7Tl9aAl/LkUghKlhEw+Px4sE3K0mvGnUFih4tEB
   qryWrkqATQhX40qPSfM/dGV/+TeCCrlEcBgY76rGQucxUHnbJbDcgmrCo
   ryRscBta7P/3OEnCLIjbD8st6dQq0NadUyuBWLkXfv4vdM9/a4a8XUX/O
   g==;
X-CSE-ConnectionGUID: 1zr8eYZVRze0zBOF751vGw==
X-CSE-MsgGUID: /rClx00XQLOq9d6hHsEmoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973618"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973618"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:05 -0700
X-CSE-ConnectionGUID: Ohz4HL6RS5imqL7gQvEBgQ==
X-CSE-MsgGUID: M+dUU0QoSiSKVABukhEk1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790068"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mld: don't consider phy cmd version 5
Date: Sun,  7 Sep 2025 11:30:09 +0300
Message-Id: <20250907112757.48d2be5d41b8.I207ff53d259cc90781a0082320e2646b35925e5f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
References: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

It was planed that iwlmld will be loaded also for HR and GF, which has
versions < 6. But eventually it was decided to keep use iwlmvm for those
devices, so iwlmld doesn't need to support those versions.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index debfb986a387..5725104a53bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -626,7 +626,7 @@ int iwl_mld_mac80211_add_interface(struct ieee80211_hw *hw,
 					     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 	}
 
-	if (vif->p2p || iwl_fw_lookup_cmd_ver(mld->fw, PHY_CONTEXT_CMD, 0) < 5)
+	if (vif->p2p)
 		vif->driver_flags |= IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW;
 
 	/*
-- 
2.34.1


