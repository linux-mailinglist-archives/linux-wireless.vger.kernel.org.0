Return-Path: <linux-wireless+bounces-26535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3181CB30173
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 19:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B126027B5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 17:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3BB34321C;
	Thu, 21 Aug 2025 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MX6bxDpg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317934166D
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798483; cv=none; b=DznM5DvzDDMIW3uE5SaUkemA+U6Gm30Yz/w5T2ms6qgBN5/5wyMIve0xlrH9hXclsUSIsj3ZkmPZoc0qlEMPz+eLriDszz5enWhbUfxQCTxNlUByNArARU7NRZrAN+w/3Jy3PNB7xjkLbsDPjEH7xxiiQB5SfVDDK2O/pBwuehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798483; c=relaxed/simple;
	bh=yAsU254Uy2k0VxDrhKiK0bxJpzOTmqRznZ2LKLQx8NI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2buH1n2Xypvo/CqEnj6NuyR+Zy5NBJ7dKqBO74WHrpzsZbZii92kTkC5nhPG0ueWUqfBhsQcenxLicL6E2TbWxcjhBDt3d2ydAQQXV4f09B82jpuGs+nLqznM5mz3ZeZFvHyIoQFeGErZkg/oAe26SDJIiiRS7Y/2wI18l6QRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MX6bxDpg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755798482; x=1787334482;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yAsU254Uy2k0VxDrhKiK0bxJpzOTmqRznZ2LKLQx8NI=;
  b=MX6bxDpg4Otndgd7ne1yEvJ50gWPG9VF5OJ2cRyiKaevSoj83ajSaCSH
   WiI853p8yVf6/tjbOLnKvEfYi89i74boLfYiwim/X/EXy39Q/+4/yuCqq
   u1/9k3QsowbPWi2WeQgIDP+shNV8iw1LCSNo/zNK1kKcASHqsLZX/jsU5
   Su6ttcJnNeruoQ2qvL1raVueK/kbhvixn0Wb5N85ju53cOLXPiE5ORWAP
   8KY7grXa2TZwUyMlWwpds+kjQAUjLue3csuRLrihL0bU+C9rm+gL6jYIn
   TEp7uuSVa4U/CmZ2ywNH+pQMWPQGz90YYFh4nH4vothN5Iyz18zHPuRnz
   g==;
X-CSE-ConnectionGUID: NyH2zv7yQ06bI3ybRFX//g==
X-CSE-MsgGUID: 01z/DWDaRSm9WuP9CKPdnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68806075"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68806075"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:02 -0700
X-CSE-ConnectionGUID: AnCvWwPjTm2b8pM7G311Sw==
X-CSE-MsgGUID: IO3lHGBVSzmWQQzLAUHJeg==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 08/15] wifi: iwlwifi: mvm: remove a function declaration
Date: Thu, 21 Aug 2025 20:47:19 +0300
Message-Id: <20250821174726.2425334-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
References: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_mvm_average_dbm_values was removed, but the declaration wasn't.
Remove it now.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 4aeb27ee9149..f02da4e0380f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2021,9 +2021,6 @@ struct iwl_mvm_link_sel_data {
 };
 
 #if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
-
-s8 iwl_mvm_average_dbm_values(const struct iwl_umac_scan_channel_survey_notif *notif);
-
 extern const struct iwl_hcmd_arr iwl_mvm_groups[];
 extern const unsigned int iwl_mvm_groups_size;
 #endif
-- 
2.34.1


