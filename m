Return-Path: <linux-wireless+bounces-27125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47170B49FF5
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1989E4E61DA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDB1275AFF;
	Tue,  9 Sep 2025 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8YYr5n0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5026FA67
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388125; cv=none; b=VSiRsRoA+iJ5UsqjoQ6g9Vs/KO6am96phaPiaMx2TnV2qzIWDRGM16nCthhk5NPdy+pQkBnElE8TKH+vfoL7373RioygxqAre/OXiyugMvBLIglZ5D0MzD0Rirbc343PEdLmEPOktjW2cPv6rVDnYkn2xvCbLbh6crsx1nbWYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388125; c=relaxed/simple;
	bh=5FGqVmkaFfJ4ryjFu21RYAwrJOOmHk41lDQoykl8LpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INx5t2PHf5ZCCbq7tgz8ygPwVEA3CCrqIH2Zu11xa16l0vb04iM5VnDqORFr28swOuX1d1WzDPYO6Zk0EXkeEZa/5ck8ZBgL5YXmDfjLcFTT1mf9LUuFp20NGq2M46xctjSkuYrvZrmEXE/1ohBJhDJTF4rtPgXv6qhzmo4HMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8YYr5n0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388123; x=1788924123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5FGqVmkaFfJ4ryjFu21RYAwrJOOmHk41lDQoykl8LpI=;
  b=k8YYr5n0Phjo/5z2zNJoW2hSswzc5DQykFDC3N4OBZEaCsd5HnkLCNbl
   dGmsyDlCynSUqwhqY+PVnNlpSVvyY8bxchO73q2rCxKBNTKgndY8fYS0I
   zcxDq+e19TlWqa3LPe7jA0ucY5/B+lOsnFpR9lUOiVpAlvBU1wHHmVk1P
   7hmphfz8BnFkGExW5jUnGFC+yqFsDzeQfhv1r8yAKINl3kOzgY3p8GGnI
   7XzMwnlJEgbMx+4XAXDBpfNfc+0v6oBfG90FdIAOmwu37brk1wF+3oaXC
   1JJR/7SHPG+NQnYbDHUvrChq+JiWtcgvDev8EiDmOG3tugmEIPijUpIRb
   g==;
X-CSE-ConnectionGUID: yRhWIYdRRh24mthB/6t6ng==
X-CSE-MsgGUID: +rpvjZQ6SPG8+gBuLnPxJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281059"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281059"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:03 -0700
X-CSE-ConnectionGUID: IS6WgFtiTqayL73jeg88TA==
X-CSE-MsgGUID: QjEtUicHSvy7Ed77Gj7TSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950371"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 06/15] wifi: iwlwifi: api: add a flag to iwl_link_ctx_modify_flags
Date: Tue,  9 Sep 2025 06:21:19 +0300
Message-Id: <20250909061931.b399aebbc384.I8a5a2728e71d92db67d4a4e0f4c358ca7b16ff51@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
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


