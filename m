Return-Path: <linux-wireless+bounces-2614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A97C83F471
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AAE1C219EF
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C57DF42;
	Sun, 28 Jan 2024 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUvY93BJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B2DF5B
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424894; cv=none; b=qLDC8cQcdZHOlQOheyAqVhcgH/KFj+0pijbv0zeMPItheF6dQNnBbIKWhMzPHrOF/TY7WJhzs1ycGeMWuwi9BdF64rNZnY5GvOrqOSwt00689efMZ/zZaI/672jsp6GJbBaBYJcofPEAXgalhoSCGVZgl7rEZS/lvFApCoAqk0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424894; c=relaxed/simple;
	bh=5pWcRkQzYphZo2/y7E25PpcFyA8iUcC8kpZEL4b4pjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=muvsub9H6iA5JzWYZwosphMVjs1gfoPu3WVNJtoh2VNEzfl3z9JX1tiS2DrsxCNQqPB/jMggcVEOtVX6beg+LAdIEpGk58DGGM86zCDNLELO6gFr5+yNRAYfPqdMw24w4lsASidnmDtISoBpp++NQrgF6eehGtd9OvKUFlmccr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUvY93BJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424893; x=1737960893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5pWcRkQzYphZo2/y7E25PpcFyA8iUcC8kpZEL4b4pjo=;
  b=gUvY93BJUh1jDjnyiUwlR/JVrq6CCDne/vN/A8IFBgXNB/+oxEDhAvtR
   Cd74DF5c+3fDr6AC4OP3sMqI/W98A5gEmMjzR13B8LpIU9R/AlnNgz3ZW
   mYq/xDVJaCoUvqFF2dSz1SWzSCXsefmtYn6JgVcXbp8NNzV8B807HiUBF
   bprNz1y1MW6T2tpN++KV5+JMot5UJ9QYrVwOMQPeYNgxeTUWrIKQJ8xAG
   iTaGVP5qN+/x8IHiX2tJxebX6y2cqEfnGEyVo1Lt4vgl79tPDFV4uG5F+
   rxFT5awl+eqRVr5VBrbDsBAXZy3TmU1/cvYB7tyd8YjvGORkAJfMI8bE5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24217667"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24217667"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35833360"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:51 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/14] wifi: iwlwifi: fw: dbg: ensure correct config name sizes
Date: Sun, 28 Jan 2024 08:53:54 +0200
Message-Id: <20240128084842.58fcdea2ace7.I49cb1d7bdbea12085aada0c96ef42fcbcb3d2b38@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
References: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This hard-codes the size, but it's not obvious why that's
correct. Use sizeof() and cross-check the two structs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 05e220173fa1..b877a2cd4005 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2430,9 +2430,12 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 		struct iwl_fw_ini_debug_info_tlv *debug_info =
 			(void *)node->tlv.data;
 
+		BUILD_BUG_ON(sizeof(cfg_name->cfg_name) !=
+			     sizeof(debug_info->debug_cfg_name));
+
 		cfg_name->image_type = debug_info->image_type;
 		cfg_name->cfg_name_len =
-			cpu_to_le32(IWL_FW_INI_MAX_CFG_NAME);
+			cpu_to_le32(sizeof(cfg_name->cfg_name));
 		memcpy(cfg_name->cfg_name, debug_info->debug_cfg_name,
 		       sizeof(cfg_name->cfg_name));
 		cfg_name++;
-- 
2.34.1


