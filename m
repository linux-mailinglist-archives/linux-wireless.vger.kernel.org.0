Return-Path: <linux-wireless+bounces-14601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17999B2F69
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFA11C21121
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C6C1DA2E0;
	Mon, 28 Oct 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThbPhlXG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42DC1D967B
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116538; cv=none; b=EqmgCAQ0LjeWfmKGIOVkX1L0Wj7Salyzu1BEQcZCAkF6R348jzCMZ0T/snTwpQE0YazgR04ZdgbCZf4uGkywNYmv0Ilq7m84ce1DHQH8YldRPUXZx1HT9FPOdxG+WvbX9pxpkGE+oYX2qMSupHThhT1gD5ByHhMN1ShiJCtN02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116538; c=relaxed/simple;
	bh=HNANnP5pp0eHgV1/ZZ7RO8lKm15HdBMNPlLQzqfr8LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQtx76Xm1p1l92Yfp/aa7AGMfG26yNzwgqC7e92UADqivQim2StI5cPHv/eTEDaDuCR6khlVHTS4VhWrgl9A6giExbVaMqHSS+V4M5L3ErrZWpniC59Bo8bxdeyjleUtyAFbsOKwMvut98uar//SbaYJHNMd2LbWccqcQcDfvvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThbPhlXG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116534; x=1761652534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HNANnP5pp0eHgV1/ZZ7RO8lKm15HdBMNPlLQzqfr8LY=;
  b=ThbPhlXGwLjSN8GwDZhIdh3e+LhqMeHVrj8gC0WPiziGGcnUZXjErouL
   3FlSTU92gWYx3bsmT3/2g4nFFqFrqn3CeBLqA7yAmsXlpaS0uPMK1Ivb6
   sGcj4XpZM6fbaA4fj6KYtsd9524DkeEuXg+OcnE3IfPSTU5Iqo0VrYWIV
   C+NACaLP/v5F+X+NVDkpJbpOhfz3CZuEmkl8ytkkZ+l0cO8KyH/xG9wQq
   /NOpnFVNeuOnx+egNOksfd80uO9n/yByMEk0jBuW6ILVBSwVnLsw2+5QP
   AWPXkRMr2J79FJXnsdwGvcHkrrBriGhQUj4otNCSBZzUDl8BGiMX0O5P4
   w==;
X-CSE-ConnectionGUID: 3wqVGYU0RuygfPVq+Y0rWg==
X-CSE-MsgGUID: SnqSHdzpTIyV8Lcp8o0d2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813912"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813912"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:33 -0700
X-CSE-ConnectionGUID: i34Na10eSgmDbS/q6xqS6A==
X-CSE-MsgGUID: qHXhE2EHR6eDH4LaNvihrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432608"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: move IWL_LMAC_*_INDEX to fw/api/context.h
Date: Mon, 28 Oct 2024 13:54:56 +0200
Message-Id: <20241028135215.48443f1c1819.I1cfe8c6c58153031d44f81edc0f8731077666355@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Those macros are currently in fw/api/binding.h, which should really not
be included in newer code, where this API is not used.
Just move it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/binding.h | 2 --
 drivers/net/wireless/intel/iwlwifi/fw/api/context.h | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h b/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
index 2397fdc37fc5..9b942c4aabd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
@@ -56,8 +56,6 @@ struct iwl_binding_cmd {
 } __packed; /* BINDING_CMD_API_S_VER_2 */
 
 #define IWL_BINDING_CMD_SIZE_V1	sizeof(struct iwl_binding_cmd_v1)
-#define IWL_LMAC_24G_INDEX		0
-#define IWL_LMAC_5G_INDEX		1
 
 /* The maximal number of fragments in the FW's schedule session */
 #define IWL_MVM_MAX_QUOTA 128
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/context.h b/drivers/net/wireless/intel/iwlwifi/fw/api/context.h
index 1fa5678c1cd6..a9fa5f054ce0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/context.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/context.h
@@ -40,4 +40,7 @@ enum iwl_ctxt_action {
 	FW_CTXT_ACTION_REMOVE,
 }; /* COMMON_CONTEXT_ACTION_API_E_VER_1 */
 
+#define IWL_LMAC_24G_INDEX		0
+#define IWL_LMAC_5G_INDEX		1
+
 #endif /* __iwl_fw_api_context_h__ */
-- 
2.34.1


