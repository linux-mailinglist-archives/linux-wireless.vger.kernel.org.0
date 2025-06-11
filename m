Return-Path: <linux-wireless+bounces-24003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD13AD5F07
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDD31779A6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E0527CCDB;
	Wed, 11 Jun 2025 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyFyOFQv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3F2BD5AF
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670016; cv=none; b=b65TunpZIuMeovgWoxb1CWFHFJ0Wvq97JfgSYeSR/GTrjw27+rHuIFOkhMixM/b2Dk2sFG7ffZPBsQHe+8a/FrWdbCT5uYKPOiu+Zo+nQUuC0FW54+i/XmziWQ3TiW42UDCM/6X60eBE4K1d6DvK/c9GSuezRIL0I5X8dibpCzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670016; c=relaxed/simple;
	bh=vFaw8DdSiGh0at6BYe0LRkJWv/OhnvWxzE6n1Q3UtkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B434tb7P67V8Ymjg0DTqdf4iRSSfOTAbmvvUiUqGu4tT4IGewpbGl5lLzo/xXqMSJMaf9o8D7I6x3730BuSDTlSiF4ovpocSUsKHTQHoBKTC3jxnrwz8qN0OtoU5Uumiz24Ln0qA1+7Qv/ZHhbKWfQGoVvdmgY7q0Nj13ajHMrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyFyOFQv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670015; x=1781206015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vFaw8DdSiGh0at6BYe0LRkJWv/OhnvWxzE6n1Q3UtkM=;
  b=RyFyOFQvtEyf4iEE5eW22sGdyBhLZ4NXBAV8dN+/rU6YK7EK/ZNyPxyu
   GWSpx9UT/MiGGfgV0BQXu2aSidIwK0GWP506hxm5R3m/8dE5lyCWhyS6y
   Xyspcr5GfRqXXq+bz1u/PjeyD59vqZgSxafdE2SX2Fe4xcjrqQqx+y3VQ
   5x5z5fCp5e5OlHShtpcav0tWEL4ZlzEmKZxK0NKDQFLCljuHync6Fspsf
   4EKlsvE+hPW3F6ZfICJ0W6+iSZowMEa5fl08y9Blh95al4pzSAGQUeXDe
   uXphK2ZsSRz+wWY0S4rH5+y+vZBa3LWMTqyQyZL0VcRHOm91BwRrKyT5P
   A==;
X-CSE-ConnectionGUID: NFx+flOFShmGHQzWWarofA==
X-CSE-MsgGUID: i6YsGa7pTY6beCj/1ioRZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360862"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360862"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:55 -0700
X-CSE-ConnectionGUID: SsRNxj2eT4GF5CSJ9LXmKg==
X-CSE-MsgGUID: Uxy4MThZTeGXa6KxGR56lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165837"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next v2 03/15] wifi: iwlwifi: mld: Add dump handler to iwl_mld
Date: Wed, 11 Jun 2025 22:26:22 +0300
Message-Id: <20250611222325.18ebf46690ce.Ia52941f761a446cb3e43cbe49d2b9a49fc15f4a8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
References: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Implement a dump handler in the iwl_mld operation mode to
collect firmware dump upon trigger from trans layer.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 8cdd960c5245..103912c4e4cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -723,6 +723,17 @@ static void iwl_mld_device_powered_off(struct iwl_op_mode *op_mode)
 {}
 #endif
 
+static void iwl_mld_dump(struct iwl_op_mode *op_mode)
+{
+	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+	struct iwl_fw_runtime *fwrt = &mld->fwrt;
+
+	if (!iwl_trans_fw_running(fwrt->trans))
+		return;
+
+	iwl_dbg_tlv_time_point(fwrt, IWL_FW_INI_TIME_POINT_USER_TRIGGER, NULL);
+}
+
 static const struct iwl_op_mode_ops iwl_mld_ops = {
 	.start = iwl_op_mode_mld_start,
 	.stop = iwl_op_mode_mld_stop,
@@ -737,6 +748,7 @@ static const struct iwl_op_mode_ops iwl_mld_ops = {
 	.sw_reset = iwl_mld_sw_reset,
 	.time_point = iwl_mld_time_point,
 	.device_powered_off = pm_sleep_ptr(iwl_mld_device_powered_off),
+	.dump = iwl_mld_dump,
 };
 
 struct iwl_mld_mod_params iwlmld_mod_params = {
-- 
2.34.1


