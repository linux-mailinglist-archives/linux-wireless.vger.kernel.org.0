Return-Path: <linux-wireless+bounces-23872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A00AAD257A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05773A62BD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEA021D3DF;
	Mon,  9 Jun 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJsfiQRO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172521D3C9
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493327; cv=none; b=CZuyqLTJAIt9bz8HihZdl1I6AXxyESChGfj+cHkyorMlr6ewtBDjTAmclYIglr7BdJ6zg90hH/ihWzTsR7fzxnOnHkUk4VyB4+Cvbw7cFaBvvXkJNzB4E3p5YzBG/KStbKGr9MTuKM4DwyGbO1Mb2TPpqJ7d1mcZ5ObaeUrVKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493327; c=relaxed/simple;
	bh=WDWr9xitRnUk7uYxWnvreyUG9OR9PkvefvcCk+zudNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPBvl/CKM2dauidUCjgUUC4t/BwDeTw9PFvAIDfEc7EbM4DI7SVueLDP6MZovODdsXjzbrxbdK/j3P8gJjUky6ExffmLWBGaFXJoIfi9bTGZ30awVLeW5OW4Ahobio4vI5D17U7E1XY8qqEWoozMOmxvdLRhlNolrR/SGMIYzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJsfiQRO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493325; x=1781029325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WDWr9xitRnUk7uYxWnvreyUG9OR9PkvefvcCk+zudNE=;
  b=nJsfiQROwKjE9KZd0GOWXgI4Fdus4JHqselgfec8JCRLahc7hhBnODeh
   TxpowS4uT3N9jb0c8enoiRjWpSbIKYmxKnbIzAqV5wUcO440QtdbvnZVx
   W+GzgPRUq2XK1J028pEtZsM/b+Qtj3GatGyTtePvgU+cC0kNzHQx7cCln
   lJAz8Eam8bD7VuHUxYB8sxNr6pqUJrAlTIcNvjdalDCHIOU0BKCk1teUz
   3dLav9dkd6dHd4I24VkSwI7GjP+gdyeM+YlKM8epp7yfVAPkzbW0qNYe8
   4vvHj6yZDVOn242kkelquRfJzLzS63mZH+Ffap729h1V9mgDQ/PFsMcVc
   g==;
X-CSE-ConnectionGUID: PYI8Wxj5Tlyqqqcc/G53YA==
X-CSE-MsgGUID: IiP7IumdTYaBo9iy7GVIvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237693"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237693"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:22:05 -0700
X-CSE-ConnectionGUID: jkaVGi+QQImxb9qfXWF5Uw==
X-CSE-MsgGUID: jsFiIY2VQ2uPkBaEySlg/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510389"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:22:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: Remove unused cfg parameter from iwl_nvm_get_regdom_bw_flags
Date: Mon,  9 Jun 2025 21:21:19 +0300
Message-Id: <20250609211928.987b1a749b78.I11a67c0737fb39b594831c10f62de1a195ed24e3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Refactor iwl_nvm_get_regdom_bw_flags() by removing the unused cfg
parameter to enhance code clarity and maintainability

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 56bac0a9755a..c5c80f72696f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1632,8 +1632,7 @@ IWL_EXPORT_SYMBOL(iwl_parse_nvm_data);
 
 static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 				       int ch_idx, u16 nvm_flags,
-				       struct iwl_reg_capa reg_capa,
-				       const struct iwl_rf_cfg *cfg)
+				       struct iwl_reg_capa reg_capa)
 {
 	u32 flags = NL80211_RRF_NO_HT40;
 
@@ -1820,8 +1819,8 @@ iwl_parse_nvm_mcc_info(struct iwl_trans *trans,
 		}
 
 		reg_rule_flags = iwl_nvm_get_regdom_bw_flags(nvm_chan, ch_idx,
-							     ch_flags, reg_capa,
-							     cfg);
+							     ch_flags,
+							     reg_capa);
 
 		/* we can't continue the same rule */
 		if (ch_idx == 0 || prev_reg_rule_flags != reg_rule_flags ||
-- 
2.34.1


