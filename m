Return-Path: <linux-wireless+bounces-2617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CA483F474
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7911F22EFB
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A111D680;
	Sun, 28 Jan 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyzFbeKJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130B1D682
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424903; cv=none; b=gj34Gy4ioXXmFZl5BbQ/pLIHtMN6ey0EQnolK2LbMPTD4d0fEDnDqbfWFqdMmTOgqKdJmx9T4V/c7Am31aXfUaOgVESQu43DG5yoAlt7CrwxSvc0rzS8CRDzzDw4L02m8/RG2liY0guMJt/hb/sfL4UkjNvkI0VEtcyCANXDR6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424903; c=relaxed/simple;
	bh=9J2hwsT3EDOeLax5cwa+Qtk/Ex5EpvLUHfJwdBfMLaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQ8c0VZUdTSvxD0Dgp8OxvOO1Osao7tWagvPo3qfKfArEuQpofnqUsdWXFU0TlvQVddxUPZxSAWZ0QHa6Mjeqw9Z7X1j5kK7xKrWpv+3WLbBuIYhyBh5pK3diuqAFSvhQOWPzzgLQaHdyiuAPll5eqpBR7FjUS2MlU9xfEXFjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyzFbeKJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424902; x=1737960902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9J2hwsT3EDOeLax5cwa+Qtk/Ex5EpvLUHfJwdBfMLaY=;
  b=jyzFbeKJls4o5YhW/eD0Na1rd5qeyIgh5LPBYLbW4zUkV9BV9x1mYQZ4
   UM0j/r+IGAZumd12huxYCng+JkRI07l75gQ84CVqmjkXTbwOVxkWuujEP
   Is9ALiOJ0baHHlEhj1BQfw0xozGHvcLxr4zhJpKIS8AE82vCK/yTE7eEk
   WHdPMl77RUJcMGcNur7HTIiKf3ebLnh/hKlL6NRlzCNB0RP9pQNC9Mulx
   jdZhLEKRJHPb2PMh9nfiaKhRim+erN9xLiBxyVjmauwtf9X9oz4aCduo0
   IKPI7mjoWLILv8G2UAAYMH6nHIM5VnpwgEN04ubXoO/BJg2ZspqiQfs99
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24217685"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24217685"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:55:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35833372"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:59 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Eilon Rinat <eilon.rinat@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/14] wifi: iwlwifi: mvm: fix a battery life regression
Date: Sun, 28 Jan 2024 08:53:57 +0200
Message-Id: <20240128084842.90d2600edc27.Id657ea2f0ddb131f5f9d0ac39aeb8c88754fe54b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
References: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Fix the DBG_CONFIG_TOKEN to not enable debug components that would
prevent the device to save power.

Fixes: fc2fe0a5e856 ("wifi: iwlwifi: fw: disable firmware debug asserts")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Eilon Rinat <eilon.rinat@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 798731ecbefd..b740c65a7dca 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -537,7 +537,7 @@ enum iwl_fw_dbg_config_cmd_type {
 }; /* LDBG_CFG_CMD_TYPE_API_E_VER_1 */
 
 /* this token disables debug asserts in the firmware */
-#define IWL_FW_DBG_CONFIG_TOKEN 0x00011301
+#define IWL_FW_DBG_CONFIG_TOKEN 0x00010001
 
 /**
  * struct iwl_fw_dbg_config_cmd - configure FW debug
-- 
2.34.1


