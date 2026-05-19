Return-Path: <linux-wireless+bounces-36634-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA4VBQUJDGo5UQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36634-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:53:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AB25786CB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1385530866CE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AE0390C86;
	Tue, 19 May 2026 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+Ebs/7s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEEB399036
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172836; cv=none; b=EVPvH5SUEHOub3E93VZTAPWBHhb1CuOX7q3cGuZ2D17wKdp7lVXpCcxajJd+YJfakzCNV5XggSwxzhPfdLP+Az025kUEBIziBYCRBxpxTfguH/tE6KBS9vgxihXQnI0RpgJ+pc4HHwF4cAG1ly4HWghC3z/ra7ARPlzjCRj9NUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172836; c=relaxed/simple;
	bh=Zx3OY52KjG+ZfQ/s+KhkOO+QtyNhRve/iray4ymnQc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lUPmGa/Jk9FonSJyKOUtDwiLmJWNBX5Q9ruxy8rNL94aTnuP87HbWoIdqoJQ+kwutulfCoyRM/c9FVkTx8wE8dWYENXs1GA+YcPRRYzPNyWWFVz8VbroDqw3ie5h6R7dyXGAR+m2GbYmyBfz7k6aTkVuO8VQ5WEmsPN6pPSiKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+Ebs/7s; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779172835; x=1810708835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zx3OY52KjG+ZfQ/s+KhkOO+QtyNhRve/iray4ymnQc0=;
  b=X+Ebs/7sFM4LB/tsc+Rd09iZexIfEvc54CN/GURdHOs9P0pDLPGYUBoe
   UH0SIBqtw8z4IS8x5ma8taNu6yApQyOYjU+9E06iVOBVzf1wbwtUJVDsv
   0Ky86mXTUl/56xGdZd7kYCf8QTGDfOKuTaTZ2k3KxAsNY/QQemAtB4rvp
   GDQzyYagd1YBPh7u4S7AmZHNlL+dV02C/fYkyqgYrJW6NT6Jpdc4Q0p6S
   7xdgp9jhGsclfy9qphPpKqY384fCB2HtjgYqjxOC5V+2rCNmLbEBvuIWk
   oLYio4q4/s1KGlpaeUfsQv+f+XewdHUuW27Ccb2JY9N+Xxvxb0IPrXJaT
   g==;
X-CSE-ConnectionGUID: tX/lDi9IQj+pvzu6skmc7w==
X-CSE-MsgGUID: SUjRiQ71SJiKm8X+WCbMCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82605661"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82605661"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:35 -0700
X-CSE-ConnectionGUID: 572nVxfNQE2bjJA9NDLArw==
X-CSE-MsgGUID: hbYm92kkTN6DueFe0i8Kng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235227302"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Shahar Tzarfati <shahar.tzarfati@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 iwlwifi-next 08/15] wifi: iwlwifi: Add names for Killer BE1735x and BE1730x
Date: Tue, 19 May 2026 09:40:03 +0300
Message-Id: <20260519064010.549003-9-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
References: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36634-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 09AB25786CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shahar Tzarfati <shahar.tzarfati@intel.com>

The devices were supported but had no name in the driver.
Add the correct names for these devices.

Signed-off-by: Shahar Tzarfati <shahar.tzarfati@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20260517100550.359f865f0920.Ie73648dd75f9c7d9e9a707311bd4d724d83b8763@changeid
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


