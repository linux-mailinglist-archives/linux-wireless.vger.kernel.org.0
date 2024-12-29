Return-Path: <linux-wireless+bounces-16872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748619FDF49
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56AE3A18ED
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27056189BB5;
	Sun, 29 Dec 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L61P9Kfx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42213194A73
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483526; cv=none; b=knCa/VpMkCCoKdSpUKtXyd0M0oXHtrlVqevxtASkSj/thk+Z6OqugM2aimGqDEazHqX9CZeqnLYKkGaAzvr+qQiCaROZegNVRw5vVZX6VYPK4H+umwadz3OuzDYFJAigBrHQUnD3pEZ/t1imDtoA+nv87HVmSiMvWOlFBb6/mbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483526; c=relaxed/simple;
	bh=h9V7NrYliYLzH+AHIcTKwb8kkK/KeGVbpX/vg8UogcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d+Z55Uj7LHhnA271numeb8QtNYWTh7/75xeCAkRh6aX5XrbnOZ26Iic1qVcdmo+3Q0C4p94zuJgonnd7REiN25UNi+qONLtiGAaiuDXgBwLMLpF9o7jGSCuj6Q9E/OZYCL7LdO2/dMLP/pUcQi/dKBdu6udAruMDqeUMyN4AyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L61P9Kfx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483525; x=1767019525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h9V7NrYliYLzH+AHIcTKwb8kkK/KeGVbpX/vg8UogcI=;
  b=L61P9KfxaMWvd/ung4QKxtOKORpvrrrT9kb8i3jGRHpmXjuCrRx8GXdb
   5YnZ9HwmCmr38ujx6C+fv6S0g5AzaRuHC46Sb33EXFy/kxknsTMJGa+lD
   1hKu7htHNtSiJw63urp4QAT1BpOtqQRBOCZOgSuu0eYwYqlqqwq5e9YoK
   B11LuNbjDX43+HsknHgcLitqZzYaVuA/fRljLSozCVpgQWPSAtna0Nfv0
   LPvnpHmY8+6ui/IYVQLaME7y5JAc/r2XDSE9jBNJvnI/CM1btbCkEGlx/
   I/WosbvEq8umhIRbDGNz0N8rDNOmRjVc4zMDT3M1zhZtrgy6aNwBy0p8t
   Q==;
X-CSE-ConnectionGUID: VYs9D0F/RbWMTKOSyjyh9g==
X-CSE-MsgGUID: 0E5GWL4MRe2kOU/zsu6fww==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572455"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572455"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:24 -0800
X-CSE-ConnectionGUID: tH7CjvuaT/iMQib9fZNM8Q==
X-CSE-MsgGUID: 2Pdem4ptR3mBfg1jnY5gAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656971"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Deming Wang <wangdeming@inspur.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 11/17] iwlwifi: api: remove the double word
Date: Sun, 29 Dec 2024 16:44:46 +0200
Message-Id: <20241229164246.7b385f337e46.Iae60151e718f344098058b0e4fa6f6c1e43cb414@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Deming Wang <wangdeming@inspur.com>

Remove the duplicate "the".

Signed-off-by: Deming Wang <wangdeming@inspur.com>
Link: https://msgid.link/20240318054853.2352-1-wangdeming@inspur.com
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index b9807dd4f255..0a39e4b6eb62 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -191,7 +191,7 @@ enum iwl_tx_offload_assist_flags_pos {
  *	cleared. Combination of RATE_MCS_*
  * @sta_id: index of destination station in FW station table
  * @sec_ctl: security control, TX_CMD_SEC_*
- * @initial_rate_index: index into the the rate table for initial TX attempt.
+ * @initial_rate_index: index into the rate table for initial TX attempt.
  *	Applied if TX_CMD_FLG_STA_RATE_MSK is set, normally 0 for data frames.
  * @reserved2: reserved
  * @key: security key
-- 
2.34.1


