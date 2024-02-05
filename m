Return-Path: <linux-wireless+bounces-3168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AC984A6D5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F34A1F26EDA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8205C5812B;
	Mon,  5 Feb 2024 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APN7m7Kt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B10481A7
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160908; cv=none; b=fSuh7gJ/kOOJVhz/V11gzB26VUVtjs9T2immQ4ag7gi39MMfXAGMqzx0EI/xWauy+XnKDVOZu/ZTT637NR4fFoDMbwqN+ERu4jlZqTisX8ssajfmp0ICKiu+CuG+Txk5PHVydkLrBdwhWnHkPvA5clnC6CYHpW4uBYJgeiKLcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160908; c=relaxed/simple;
	bh=QMQw+gtgPhX7KIkcONJcPGxezrk5GuFk3FaezbeRsDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UD6lR/A7V/oYrzz2DMeLGXs9oCeOpT6H4wyDUCD6kJ7kEywJPW9oSfRHh0rRwkshKKUIB9/tn+oavZ91BcrLwhenLyXPpBitlfI+NcE2wJj1AZa7DygZ9WHMOueVGkLMmCuvYvyeLkIo2q4LZTVP8EPb+If4+Wy8OGXy6T/dSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APN7m7Kt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160907; x=1738696907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QMQw+gtgPhX7KIkcONJcPGxezrk5GuFk3FaezbeRsDw=;
  b=APN7m7KtifGdk0mc+Zc+gtfaLjTRAZ7HOvypg8Y8e2cG4tn1KmxAyTg2
   0ag1gw1u+ZX3zmPdswOhQ4B1C17RwSUEXWVa/Oe9i2Uv80Kk9QU4FXVx1
   OmcMW201KQiIfmgaf0MeFM8+GI7qvD/6J5LM6z1BysrT960LJJZqqqcCt
   HZr43EkaIisG5ytq2QsY4aFdc1Cb0mwwq3ryZdpJmHcRXsuXwPnpbJawN
   2dzV/vwA56R6Sz6ez4xoxoB5nUn08F8DUdD3saZzxgbT9F4z9EOffCbn/
   YzoxUWVv9PM8ivm8o/m79ZrfqPcjO3+x+VIEYrjZrh0rZCtOUbwYQFgTG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381593"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381593"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403106"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:45 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: properly check if link is active
Date: Mon,  5 Feb 2024 21:21:05 +0200
Message-Id: <20240205211151.c61820f14ca6.Ibbe0f848f3e71f64313d21642650b6e4bfbe4b39@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Before sending SESSION PROTECTION cmd the driver verifies that the
link for which the cmd is going to be sent is active.
The existing code is checking it only for MLD vifs,
but also the deflink (in non-MLD vifs) needs to be active in order
the have a session protection for it.
Fix this by checking if the link is active also for non-MLD vifs

Fixes: 135065837310 ("wifi: iwlwifi: support link_id in SESSION_PROTECTION cmd")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index be823c85c39d..c3518585c20e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -706,8 +706,7 @@ static int iwl_mvm_get_session_prot_id(struct iwl_mvm *mvm,
 		 "Invalid link ID for session protection: %u\n", link_id))
 		return -EINVAL;
 
-	if (WARN(ieee80211_vif_is_mld(vif) &&
-		 !(vif->active_links & BIT(link_id)),
+	if (WARN(!mvmvif->link[link_id]->active,
 		 "Session Protection on an inactive link: %u\n", link_id))
 		return -EINVAL;
 
-- 
2.34.1


