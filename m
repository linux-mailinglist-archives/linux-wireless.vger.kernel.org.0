Return-Path: <linux-wireless+bounces-37199-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FCVAjATHGraJQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37199-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC746615A7F
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CA2D3004D9B
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0869376A10;
	Sun, 31 May 2026 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bj0rBQkY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DD376BD3
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224808; cv=none; b=HZ7bP1oqYQtIBLizeCAG3zPXNCT9TiDr4fO3oWUCf+W7pXxwHpaaoSi6GYH6oHTYBJUAh4ycFBgS4Urf0fGTvdghcHoFWpbbdrRybh6Mj7WNj/uDdTDrezD0EB0AWqbu4Q+hEJtY3YsoJ7+VTyZQLIMHqb1u5CQN8lJ4gto2WSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224808; c=relaxed/simple;
	bh=D3piukCJmIDHr158UuvnfmohaRAddEs5qLXmfx3qPO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZ5djODLJlTv0Zr+w8mGd7vM611ChCQQ8gWMIzmwKY5cYhbCPTEbpC0e5JTV4MxiDL6x5tL1Ou8EEgCmepRhz2LNCHAFnB6F/rD9wnaKvarZ6jhHiF6i4kV4mIs38N4gWVcyltWk4eQ/1skoiuk3olLlex+LY4whfqGbOYCBObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bj0rBQkY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780224808; x=1811760808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D3piukCJmIDHr158UuvnfmohaRAddEs5qLXmfx3qPO0=;
  b=Bj0rBQkYMyQGW9skzpnFXL2MI5TfK/iqktwjqJfOvYeLjUuGzxxX+KLp
   p64taCrHyOAqlYIPGGG7ytGEn0Fu7g8n0abfD4DX9TWl73e+jzpgCV9pY
   tnlrF1bdR/7oKQMQYRkJLCWVOGmkdVMk65yXxX4O/MuxMCSJF9XNDMHj5
   /lFWbRr/w5cDfJWQi2UJ02UH/BmQdcJJOBuD+veLj8W4H5rFUqsMzRncf
   TU9iCRzzvQGsCHrO46hbcxCYPt8Q43M8/JfUJMXxxF375PFqTG0OkkWJA
   3P40PMNtxV/ega95wE60zw/wan/7MX+7yQhSUF7yK6ItCUZEHT9w7Ij95
   w==;
X-CSE-ConnectionGUID: K5z77ghsQby9pen5AJT2qA==
X-CSE-MsgGUID: Rmhj/o4zSMakDbF7kCom4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80039664"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80039664"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:27 -0700
X-CSE-ConnectionGUID: GfQpBQg0RlmnBZO6bJSQAA==
X-CSE-MsgGUID: jSs2a/NpSG+oj96HLdQc3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="240295996"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Shahar Tzarfati <shahar.tzarfati@intel.com>
Subject: [PATCH wireless-next 03/10] wifi: iwlwifi: remove orphaned DC2DC config enum
Date: Sun, 31 May 2026 13:53:02 +0300
Message-Id: <20260531135036.487ceed62714.I13cf8cc214c68899379112e8e52f0cd38dc7b6f8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
References: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37199-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EC746615A7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shahar Tzarfati <shahar.tzarfati@intel.com>

FW core102 removed both DC2DC_CONFIG_CMD_API_S and
DC2DC_CONFIG_CMD_RSP_API_S. The only driver-side artifact is
enum iwl_dc2dc_config_id in fw/api/config.h, which has no
callers in any .c file across all driver paths (mld/mvm/xvt).

Remove the dead definition.

Signed-off-by: Shahar Tzarfati <shahar.tzarfati@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/config.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/config.h b/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
index 1fc65469990e..84fa5ff7a57f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2012-2014, 2018-2019, 2023-2024 Intel Corporation
+ * Copyright (C) 2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -99,14 +100,4 @@ struct iwl_phy_cfg_cmd_v3 {
 	struct iwl_phy_specific_cfg phy_specific_cfg;
 } __packed; /* PHY_CONFIGURATION_CMD_API_S_VER_3 */
 
-/*
- * enum iwl_dc2dc_config_id - flag ids
- *
- * Ids of dc2dc configuration flags
- */
-enum iwl_dc2dc_config_id {
-	DCDC_LOW_POWER_MODE_MSK_SET  = 0x1, /* not used */
-	DCDC_FREQ_TUNE_SET = 0x2,
-}; /* MARKER_ID_API_E_VER_1 */
-
 #endif /* __iwl_fw_api_config_h__ */
-- 
2.34.1


