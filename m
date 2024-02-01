Return-Path: <linux-wireless+bounces-2957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A7B8459FD
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2293628E138
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6175CDE3;
	Thu,  1 Feb 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7kVI+U+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68E5337E
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797215; cv=none; b=PMBCMSj8LzsCXZozTnm/xsUi8y5C097MtRxTqNcCLwGY6CsbZnj+Rq/tfFRh1VpmxBmp4K9PEy7wGS4GWrwTHHt9US34fjh9EpjhhJGOnP/GiC+H1Cn4swpvzC3uINULTGiwwGJsAsnMwvx9WG4taxFlAX4iNndBQvjPXonPZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797215; c=relaxed/simple;
	bh=MT004vZMmxjF/sIQQavVW2su4La2o527To0QGqdxvdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTM5rrwZtrF3URdnfcBl0j9tqvX99KtQ5PgKhXhLuPhyILu5J4c7CHW0qPHOr1rmmFishEDM4wo6crJ+FUIi5ebPUQv8gOzzQD9vAvMxpVxUm3Py+y6qlJwCWgA5uYmHMYG7W/i29lZAnQjnw8K9wAHoaZc45zq4oNWnr35Nl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7kVI+U+; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797213; x=1738333213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MT004vZMmxjF/sIQQavVW2su4La2o527To0QGqdxvdo=;
  b=P7kVI+U+1mAl3awFSv91Dl7+4UFMbOYIqT9M719gKpX7WrrnF8CVYuY9
   dk8ncIQQgACT4+Z8SNOp98I9HJxuEK9Rq4OxkRzmkWK6ioUQmiocjUMlZ
   +W22Gyj/b9aZSKTxNqT6sZMTLGJoTijZQjHQU80GM6OtRYZc30PGUCu2A
   FR2f2iQ9xLmPK2GFqnEbYvZ8iOhUQwLNAtihQzHup8cxrtxEr5N8GgfCH
   JIE2hMQtLrmsoOXt9Q90HCai2mn8upExbA7YuheI6LapmVxAgHmAYIg37
   nst+myDchQ+lCtYwov3+aS/zrc+CkT4a4TY3Tx18hRWnZwy6nnUEO03Kj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062928"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062928"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94210"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/17] wifi: iwlwifi: take send-DSM-to-FW flows out of ACPI ifdef
Date: Thu,  1 Feb 2024 16:17:34 +0200
Message-Id: <20240201155157.1412e6d561f8.I84f67478d01b576457e1bf489fbcb044adfda6fe@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
References: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

These functions shouldn't be ACPI_CONFIG dependent, as they don't
access the ACPI. The functions that really access ACPI -
already handle the case that CONFIG_ACPI is not set.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  5 -----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 15 ---------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index e6d68ab83ba9..8b64888052ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -243,11 +243,6 @@ static inline int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt,
 	return -ENOENT;
 }
 
-static inline __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
-{
-	return 0;
-}
-
 static inline int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 {
 	return -ENOENT;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index e9b5dc7ee8c7..77464620eafc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1201,8 +1201,6 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		IWL_DEBUG_RADIO(mvm, "failed to send TAS_CONFIG (%d)\n", ret);
 }
 
-#ifdef CONFIG_ACPI
-
 static bool iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 {
 	u8 value = 0;
@@ -1350,19 +1348,6 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 		mvm->fwrt.uats_enabled = TRUE;
 }
 
-#else /* CONFIG_ACPI */
-
-static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
-{
-}
-
-static bool iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
-{
-	return false;
-}
-
-#endif /* CONFIG_ACPI */
-
 void iwl_mvm_get_bios_tables(struct iwl_mvm *mvm)
 {
 	int ret;
-- 
2.34.1


