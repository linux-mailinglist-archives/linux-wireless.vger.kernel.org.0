Return-Path: <linux-wireless+bounces-36526-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GbrLcXPCGqA6QMAu9opvQ
	(envelope-from <linux-wireless+bounces-36526-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F96255DA35
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A095F3023539
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 20:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6F654654;
	Sat, 16 May 2026 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnDVT91u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27BB29A32D
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962325; cv=none; b=fCnnIdTQQPKTBApBrTfqZgMAKw4qz/XEjWMh3gfa4K4QODIvvegqtpIRNKlK7HcnJot38HOtP0gMpzLrdadQVrJUjYZVNJSa1n9LJA8mhcVPct+wZZzTzWMywLDt9b771Dd/veTnl9TqovhLjF3+fy5H+SC4wERIvk7DUIgZXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962325; c=relaxed/simple;
	bh=FTce+iebG7zGydfyMVAMtQ+vURTiX68QyCmwhuRKE68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IkE/bs4xJ5pE6sqRnbCxtG1xyplBj4uKf8AzLe0Zhs6tu8p6TUr8Y8K7/zEZNfh7xu/rc6cQ/E7+lzusHeYyyA+MGcCeYoM9jxwaRsPmOnxTBxnwpSxCwHECeelEm3KytZpsqtxiK6jb0A3Q7UM/lFHmYucvs+EYT/3891bwPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnDVT91u; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778962324; x=1810498324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTce+iebG7zGydfyMVAMtQ+vURTiX68QyCmwhuRKE68=;
  b=ZnDVT91ulC8BVCrAdgCP1tA8sA80/ysUfzSGz+glHBD8JlBEZvzGCX9B
   A3KW6xt4mfU0xj1YecBMjmS7wUTZjXQjAgs7PuRfgMYcEU2ApaskDnqO8
   snhzYVnaYAmreriWTT7wkHwaojD+zoSlK3NJ2GYcztE7v1dxnHhERTUIU
   SmbprL94Bw88yHYwI4XLqcOdnZ8OkcpZKx7HWBtYOtSfyv54ulQgRvLJn
   CO9ccEt5/vbhKMhL2EBrwcUNpKoReFHs1PSnr5sLCbpgAYOE3BrWgbcVt
   QoOmrZN621NUTnvm3LeSVAB4861jqKN7TIrTbAFhhITU+ow0LpQk9DEWB
   Q==;
X-CSE-ConnectionGUID: tiI2XMrNQEWvnokQyElwxQ==
X-CSE-MsgGUID: qZDtDZrlTVSN6ROWnGEz3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79845729"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79845729"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:12:04 -0700
X-CSE-ConnectionGUID: OIpAVjt0RmWfO9V4/KI2Jw==
X-CSE-MsgGUID: 1bjN+CaORXGg/Ks4SENU8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="239130904"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:12:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Shahar Tzarfati <shahar.tzarfati@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 08/15] wifi: iwlwifi: Add names for Killer BE1735x and BE1730x
Date: Sat, 16 May 2026 23:11:30 +0300
Message-Id: <20260516230843.359f865f0920.Ie73648dd75f9c7d9e9a707311bd4d724d83b8763@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
References: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F96255DA35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36526-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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


