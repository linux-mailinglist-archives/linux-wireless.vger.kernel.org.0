Return-Path: <linux-wireless+bounces-20048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39D7A57E7B
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C67F1892715
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C6D1E25F7;
	Sat,  8 Mar 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRP5UQmI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03962046BF
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468784; cv=none; b=reeap4wgRgoC6nw1ToA0lC3Siws1HF+RNIuh8c5au2YU9amX2P43rw4oHEwHHVEvuXl7R20XrvBSC+7uqTNiFW4jOFzmKFVo9zRRI04WqpOKv4B87hRol1hFlw450t3tYj5A5y3Ugesyl0Fm8AAEk6cNtMYdk1QN+h3XVxNhj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468784; c=relaxed/simple;
	bh=jOSPCYdHjY3mmUmNQsjMfcaCD0ekcqINe9k3tizI2lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CazkRpTVrxJmS+a9I08FwxTmTUlDzuxnI6VG8rwcgYzCycAl0jMOaJXwQTkAFn4io+8i6o8vMgvtIO/hwPEUXU1/+5mbwLo0wmp+rtfirRWmu42874F5teE8dMgR4TwFKFPtQBvro7IOa4qJZEVKb4erlsf7jF80VcAVq986vTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRP5UQmI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468783; x=1773004783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jOSPCYdHjY3mmUmNQsjMfcaCD0ekcqINe9k3tizI2lk=;
  b=JRP5UQmISy9goAiWS+OveP3JdjJbu/JuNUZ4r1Sqxu5RmJ6L9GnVO4cP
   /7RRmKS3TyoXQF8zbJG2KtemS6KWO3NPDyNNtCgTKuHoDv0UqBDOSSExu
   YtNqEf5dm715EjBYsgpXirngi8qQ/m9F2pQ3pfaJCf+g/+U6/Nr3qXm2c
   xPtu1Yrt62ocLJz1SF8bJTCHkh3KuVTSoWUp5p/w2EFUYuvdvyt0/LD0s
   cwip1aHioTatWEI6hgvQKefxQMqY9HZgFIOCAGD2vhjif5hkWPalut6By
   o5iNuL/QN0JzMnh5kW5nnxoDFag4O8w616UTCYXPmF1lj220EtVrXcrxP
   g==;
X-CSE-ConnectionGUID: +NJzr2jqS5WwYTovbvcbpw==
X-CSE-MsgGUID: ixE7tNTQTumdpleCmKMBqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052367"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052367"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:43 -0800
X-CSE-ConnectionGUID: wICFJnuMT0e6lsBaGWvf8w==
X-CSE-MsgGUID: axefZ+6SQHib99f8MQhhFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859902"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v3 wireless-next 03/14] wifi: iwlwifi: fix print for ECKV
Date: Sat,  8 Mar 2025 23:19:14 +0200
Message-Id: <20250308231426.e006c6b21432.I318fed724709f9ee7a0c369e1cf5e1038ddd546a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The print was obviously wrong. We are handling ECKV and not WRDD in this
function.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index b4438b1f8dad..386aadbce2a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -690,7 +690,7 @@ int iwl_uefi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk)
 
 	if (data->revision != IWL_UEFI_ECKV_REVISION) {
 		ret = -EINVAL;
-		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI WRDD revision:%d\n",
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI ECKV revision:%d\n",
 				data->revision);
 		goto out;
 	}
-- 
2.34.1


