Return-Path: <linux-wireless+bounces-36544-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPz8Ocl1CWokbAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36544-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:01:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B6855FD76
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A671E301724E
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B410B67E;
	Sun, 17 May 2026 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VL86TxL+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E32E1F06
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004837; cv=none; b=upNtTLTo+yU7/Y78fBMOIkdVbMpnkCA8brZY2sSOr6reukbWgr9eNamhk/Buinntnu40mIbbtvBHqXhso26lsqvlFavzWwCqKdBNKd0uDvmWaCIk7mcpOmqvsR66pMvdzid7jBZ0fjT/VmrD7Uav6kF/qJTRKQW45V50E1vMFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004837; c=relaxed/simple;
	bh=FTce+iebG7zGydfyMVAMtQ+vURTiX68QyCmwhuRKE68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTkgGIsoDLm49qRehbZ8c+2RIwiZuQba0skjfXO87kX98ovb/gW1TE2crWEnQuCVkdYW3lAvr7EAuBLXiJcPpDTJEVvhDQYG786byekaaWkDe7Bz/+bE/12LRzEeLklKflbGdm1xdQsVj/NWB2Rabt/pgIa6aQ+vaGPlFE7/L/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VL86TxL+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779004835; x=1810540835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTce+iebG7zGydfyMVAMtQ+vURTiX68QyCmwhuRKE68=;
  b=VL86TxL+yj/WwzURUqhSTVFEfWIhUWagmcAeOinRc3sDkUG0d68hbA34
   TWlGrrHfznL+E/I2GFYthSegvi2RBOixaJnoZ4ju6hafJfxD7azrhcnFy
   lv12jdWzBxYWMTIdhLlhr7wscgo8OpGASnKW9uChci1u+8SghhkhuVUvM
   rmTm55Co6ZCQKTEc1qN8+tu6Tz8d+2mtr9b4UOGQE1WrUSgMO9BJbfw25
   IkLee5+m7aH/WgKQsX8A+MQQemUCkGV1JHlu9BYYYQNo9/Wgk/JWQLch0
   O5LiMGUv86ollXOppSlPO5BzImdiaKsP7O4cyjEnelm6mnduYawvMW/7a
   g==;
X-CSE-ConnectionGUID: kj8uaCDNSl2FdCWYRnPfRA==
X-CSE-MsgGUID: +nPyeAtHRQ6MzpL0VNNDlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79606965"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="79606965"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:35 -0700
X-CSE-ConnectionGUID: aW9CWf3MRzuiHH7W6OPyMg==
X-CSE-MsgGUID: fd3hytCQTFeVcJRPQUWS5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="236490460"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Shahar Tzarfati <shahar.tzarfati@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 08/15] wifi: iwlwifi: Add names for Killer BE1735x and BE1730x
Date: Sun, 17 May 2026 10:59:52 +0300
Message-Id: <20260517100550.359f865f0920.Ie73648dd75f9c7d9e9a707311bd4d724d83b8763@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
References: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76B6855FD76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36544-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Shahar Tzarfati <shahar.tzarfati@intel.com>

The devices were supported but had no name in the driver.
Add the correct names for these devices.

Signed-off-by: Shahar Tzarfati <shahar.tzarfati@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c  | 2 ++
 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c  | 2 ++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 4 ++++
 4 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
index f482536e6b5e..294cf25ae2a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
@@ -47,6 +47,8 @@ const char iwl_killer_be1790s_name[] =
 	"Killer(R) Wi-Fi 7 BE1790s 320MHz Wireless Network Adapter (BE401D2W)";
 const char iwl_killer_be1790i_name[] =
 	"Killer(R) Wi-Fi 7 BE1790i 320MHz Wireless Network Adapter (BE401NGW)";
+const char iwl_killer_be1730x_name[] =
+	"Killer(TM) Wi-Fi 7 BE1730x 160MHz Wireless Network Adapter (BE202)";
 
 const char iwl_be201_name[] = "Intel(R) Wi-Fi 7 BE201 320MHz";
 const char iwl_be200_name[] = "Intel(R) Wi-Fi 7 BE200 320MHz";
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
index fa63a9a01264..c432aa1a0af6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
@@ -29,6 +29,8 @@ const char iwl_killer_be1775s_name[] =
 	"Killer(R) Wi-Fi 7 BE1775s 320MHz Wireless Network Adapter (BE211D2W)";
 const char iwl_killer_be1775i_name[] =
 	"Killer(R) Wi-Fi 7 BE1775i 320MHz Wireless Network Adapter (BE211NGW)";
+const char iwl_killer_be1735x_name[] =
+	"Killer(TM) Wi-Fi 7 BE1735x 160MHz Wireless Network Adapter (BE213)";
 
 const char iwl_be211_name[] = "Intel(R) Wi-Fi 7 BE211 320MHz";
 const char iwl_be213_name[] = "Intel(R) Wi-Fi 7 BE213 160MHz";
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index da6d3686e7dd..30d5ec31b9c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -676,6 +676,7 @@ extern const char iwl_killer_be1750w_name[];
 extern const char iwl_killer_be1750x_name[];
 extern const char iwl_killer_be1790s_name[];
 extern const char iwl_killer_be1790i_name[];
+extern const char iwl_killer_be1730x_name[];
 extern const char iwl_be201_name[];
 extern const char iwl_be200_name[];
 extern const char iwl_be202_name[];
@@ -683,6 +684,7 @@ extern const char iwl_be401_name[];
 extern const char iwl_be213_name[];
 extern const char iwl_killer_be1775s_name[];
 extern const char iwl_killer_be1775i_name[];
+extern const char iwl_killer_be1735x_name[];
 extern const char iwl_be211_name[];
 extern const char iwl_killer_bn1850w2_name[];
 extern const char iwl_killer_bn1850i_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b0c59181907e..608100bc6b11 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1054,6 +1054,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1750i_name, SUBDEV(0x1772)),
 	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1790s_name, SUBDEV(0x1791)),
 	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1790i_name, SUBDEV(0x1792)),
+	IWL_DEV_INFO(iwl_rf_fm_160mhz, iwl_killer_be1730x_name, SUBDEV(0x1730)),
+	IWL_DEV_INFO(iwl_rf_fm_160mhz, iwl_killer_be1730x_name, SUBDEV(0x1731)),
 
 /* Killer discrete */
 	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1750w_name,
@@ -1079,6 +1081,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 /* Killer */
 	IWL_DEV_INFO(iwl_rf_wh, iwl_killer_be1775s_name, SUBDEV(0x1776)),
 	IWL_DEV_INFO(iwl_rf_wh, iwl_killer_be1775i_name, SUBDEV(0x1775)),
+	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_killer_be1735x_name, SUBDEV(0x1735)),
+	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_killer_be1735x_name, SUBDEV(0x1736)),
 
 	IWL_DEV_INFO(iwl_rf_pe, iwl_killer_bn1850w2_name, SUBDEV(0x1851)),
 	IWL_DEV_INFO(iwl_rf_pe, iwl_killer_bn1850i_name, SUBDEV(0x1852)),
-- 
2.34.1


