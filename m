Return-Path: <linux-wireless+bounces-4892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A45587F91B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0371F24486
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C270C53E11;
	Tue, 19 Mar 2024 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqG7l19B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE4D7D096
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835868; cv=none; b=WsqxsFMhCXrdBwkSrugNnGN5Gh92D00vC9nvgF2LJCVczCXA0v4EEIRARcrJqRZoMuwxFY1oQT1f6DqC2mstlK2lalvIqNiND0S3IO/GZcdR9okveB9vQOq7P9V6Gc3wz9wePW7RLfSpz4PutDkObR7M0y/EfERoHjWaR3OBrfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835868; c=relaxed/simple;
	bh=FF6kwELGd23LQ8A2nrjtyiht6Rddx5XC/1Bv9TqxOYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rmF9JHtF29uj89Yze44EIkcnq6DAQtl2KvXKFn9NtFkdJq6b6Qehhbw1J3SWYzLTv43/s+D0FZbdEUI6VtkkTEosr7qHfUwGzORQXAiPXzuXTlbdHbNgMB54SVdfDc8GpnDAgEzjz2Hr+tEAOXbiZ3gOng7+SAg4GLuaYmFKxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqG7l19B; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835867; x=1742371867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FF6kwELGd23LQ8A2nrjtyiht6Rddx5XC/1Bv9TqxOYI=;
  b=HqG7l19BW2hj2TOTv6JOmgOhBapxdYdp5ga5t8UWijI+e2g8Px+XZWP4
   LAvK97E+SO5mnEtTYPldw073YmVZ7PBsJQVs/x4f6Wxcc9+agdGDyjGb2
   t5qQDGssP0l2rtyn7PFDR4D2SO44TevMp3oMcgKkvp9RsKXCVq1nVG/i5
   o8+dR5Y5SwD99w+SUn/fzgNdUh1wfJMNufO1ZfrDSXfqxwazBeFySNoXh
   H1ESfEm8guEPdh9YLw4uwy+ZPgi98aHV3yQfbwWP91mBmNm6z5ioP1MtB
   Yjd8iQT9VQbCqQ9+oAcjTNruCQ0uXEUKZGtyoyIzV1qgoq/4B1tHpsqWa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810580"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810580"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447653"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: remove 6 GHz NVM override
Date: Tue, 19 Mar 2024 10:10:24 +0200
Message-Id: <20240319100755.73bff65d5597.I1ae23a509fad252c0237e74defba6cb74b6ca188@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We shouldn't override the flags to zero here for 6 GHz
capable devices any more, but since LAR will be there,
this also shouldn't make a difference now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index baa39a18087a..047f77aad367 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -478,11 +478,6 @@ static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
 		else
 			channel->flags = 0;
 
-		/* TODO: Don't put limitations on UHB devices as we still don't
-		 * have NVM for them
-		 */
-		if (cfg->uhb_supported)
-			channel->flags = 0;
 		iwl_nvm_print_channel_flags(dev, IWL_DL_EEPROM,
 					    channel->hw_value, ch_flags);
 		IWL_DEBUG_EEPROM(dev, "Ch. %d: %ddBm\n",
-- 
2.34.1


