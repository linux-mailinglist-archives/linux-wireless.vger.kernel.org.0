Return-Path: <linux-wireless+bounces-2398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAC0839749
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD9E1C20BBB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760E781AAB;
	Tue, 23 Jan 2024 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTAF76c3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E981211
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033330; cv=none; b=UeL6W0bM0SUJNgxO3okkDwD3gpEts1cXxlUNqvZRshG4r7kEp5h7LDr24JTA3gV0SEdJy3umxL5goYVUU9sRypRqkZgY4llQVY3Xtv9yw0VdG3ho0qJ1MaQ2t2OKy4R/VwZhNU2brvfGguEhDnJcMK9Kkuw4OS4kZYrU4NQnPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033330; c=relaxed/simple;
	bh=iwgU0p9i0rodI4rgTUyjNC3Gf3GTZzZkm2fYOJ1FAEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJ+/OArtRBkzJxYVsctGI4IbwoeJ73IE+nm+USKctqXiu2KtY7FRdaHhYD9S7JIo1UO1eNrd9NXT0wVPOKAyTlMDrJ7SEXbuH/j3ymdEl1UvVOvUcqknjvO4sSTvYMUZRuaRghqVvzQYpNpVzx5CJMeju6kRUQPifG/2gW3LrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YTAF76c3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033329; x=1737569329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iwgU0p9i0rodI4rgTUyjNC3Gf3GTZzZkm2fYOJ1FAEM=;
  b=YTAF76c3G65tDtvsnEV/3vtWGev/N5qLJ9TqoXmi7Prvq/8f7T8SnKbq
   VNgqyR8eXPU6lHihi3NbkmlMczoraVwjlZ+RoGp6ruyFSgPd3aPaXTfIg
   v5V2xhKjdiPorbvYyo6R24OauSI0rCbHnQONveJWHmH9DkNoUK7JFQmKW
   2KKep0s7yuwI+A8WUaBIAIBy05tU7JLqjQFFJRWjjSPFvpF3zWSbcPLPP
   rr6TS9ZreO0kN3Ge1yX3GDEmPsdcNja69+GJxySeTlO+PRCW1zK57Hjon
   lMK4XFiPDlAgvwz3rmDyLOXVXt1jYlveFbEvbjXRb/yolMqHgB3YlmRh/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501709"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501709"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666470"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Guy Kaplan <guy.kaplan@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: fix double-free bug
Date: Tue, 23 Jan 2024 20:08:11 +0200
Message-Id: <20240123200528.675f3c24ec0d.I6ab4015cd78d82dd95471f840629972ef0331de3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The storage for the TLV PC register data wasn't done like all
the other storage in the drv->fw area, which is cleared at the
end of deallocation. Therefore, the freeing must also be done
differently, explicitly NULL'ing it out after the free, since
otherwise there's a nasty double-free bug here if a file fails
to load after this has been parsed, and we get another free
later (e.g. because no other file exists.) Fix that by adding
the missing NULL assignment.

Fixes: a3b8008dc142 ("wifi: mac80211: move ps setting to vif config")
Reported-by: Guy Kaplan <guy.kaplan@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index ffe2670720c9..abf8001bdac1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -128,6 +128,7 @@ static void iwl_dealloc_ucode(struct iwl_drv *drv)
 	kfree(drv->fw.ucode_capa.cmd_versions);
 	kfree(drv->fw.phy_integration_ver);
 	kfree(drv->trans->dbg.pc_data);
+	drv->trans->dbg.pc_data = NULL;
 
 	for (i = 0; i < IWL_UCODE_TYPE_MAX; i++)
 		iwl_free_fw_img(drv, drv->fw.img + i);
-- 
2.34.1


