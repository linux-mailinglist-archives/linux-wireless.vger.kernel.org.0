Return-Path: <linux-wireless+bounces-27053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AB5B479A1
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7EC17AC1EE
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E1C21B8F7;
	Sun,  7 Sep 2025 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYIFVtTa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E17D21D58B
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233861; cv=none; b=WSqmSZxDOFwxNUOAyq186NrRNQFPXmNLlUXh/lhIwiGbxLv4kvFDlAEW86bX0cnXBq+Tx1Ig2y3IMrPK8fCsWc8cDu97XidgGQwMqzTX/3ndy63vflC+n4X7KZfY7fvF4kfjBnbS0/IKnKPbTugO6kqoY44P0PfJypOjk8Dildc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233861; c=relaxed/simple;
	bh=5FGqVmkaFfJ4ryjFu21RYAwrJOOmHk41lDQoykl8LpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7fXSTTA9YHfHh4EpUzls4nWrlPyoBhpRqxVC0wST2xgD7jGgt9IUSTBxWaDmCJp+B/x6NgHo7YcTZouZ9UKbMgwtcdipy/NETBlph4RyXO4Jbcz4anvaaOfScdNL7kQgruLuAI1+yuKdeCao6yNRCnhdth3VBudqA+N7iYLLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYIFVtTa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233859; x=1788769859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5FGqVmkaFfJ4ryjFu21RYAwrJOOmHk41lDQoykl8LpI=;
  b=KYIFVtTapGo0DzP6l/GeOrHOQ6AVcuW9DErNep3tis9ulvMRDi7IbrVk
   NSIf1i1+NhqT4iAEhobjlf4KL5AB1xniVvLMBh5LoJUfH7gQY4/BaCsRV
   kKT5nKl10EulexYroOPNk8kySfUioloZcLbZBrx3Q/WhVEhCXZMKUbOna
   OTU1heNLgFcTfPEizdrulufT/ME77OF8NFAzV2f6PRG3RMZJ3QMDVh+LB
   B/hXR/6ckqWdqvtmG6qQ4cWKsXp5Njt7gMpM9m3ZgKzbjrsEr1Acjhs1h
   /RDTmerrfttu54NFqlate9es6QZU01RPYXH8QcXZ+0Bd68eN5bbBNSHa6
   Q==;
X-CSE-ConnectionGUID: 2gVCjbxrRpmalJgjr5YSgA==
X-CSE-MsgGUID: +SJrehivSPGwjJzdJNUF/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973612"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973612"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:59 -0700
X-CSE-ConnectionGUID: sIqj1BOoQ5KowOE6uW7lPA==
X-CSE-MsgGUID: eEG6bbfhSfW2Jxgs9h6WYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790047"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: api: add a flag to iwl_link_ctx_modify_flags
Date: Sun,  7 Sep 2025 11:30:05 +0300
Message-Id: <20250907112757.b399aebbc384.I8a5a2728e71d92db67d4a4e0f4c358ca7b16ff51@changeid>
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

Add a new flag which, when set, will indicate that the UHR parameters in
the link command have changed.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index b9f559dac39f..f76cea6e9ec8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -420,6 +420,8 @@ struct iwl_mac_config_cmd {
  *	eht_support set to true. No longer used since _VER_3 of this command.
  * @LINK_CONTEXT_MODIFY_BANDWIDTH: Covers iwl_link_ctx_cfg_cmd::modify_bandwidth.
  *	Request RX OMI to the AP to modify bandwidth of this link.
+ * @LINK_CONTEXT_MODIFY_UHR_PARAMS: covers iwl_link_ctx_cfg_cmd::npca_params and
+ *	iwl_link_ctx_cfg_cmd::prio_edca_params. Since _VER_7.
  * @LINK_CONTEXT_MODIFY_ALL: set all above flags
  */
 enum iwl_link_ctx_modify_flags {
@@ -432,6 +434,7 @@ enum iwl_link_ctx_modify_flags {
 	LINK_CONTEXT_MODIFY_BSS_COLOR_DISABLE	= BIT(6),
 	LINK_CONTEXT_MODIFY_EHT_PARAMS		= BIT(7),
 	LINK_CONTEXT_MODIFY_BANDWIDTH		= BIT(8),
+	LINK_CONTEXT_MODIFY_UHR_PARAMS		= BIT(9),
 	LINK_CONTEXT_MODIFY_ALL			= 0xff,
 }; /* LINK_CONTEXT_MODIFY_MASK_E_VER_1 */
 
-- 
2.34.1


