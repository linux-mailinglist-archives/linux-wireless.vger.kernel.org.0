Return-Path: <linux-wireless+bounces-22682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E141AACE36
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0D24E3081
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A444217660;
	Tue,  6 May 2025 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OroluFvX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BADA2153E4
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560488; cv=none; b=bksGGGW5MvZyt7qJxz7UND6sDBq93Mr5bIkuye1c73zqeAfWyeVdfpAyINzdpFCnG1gM3FNXoLyEm0UOuc6zGqdvnqJTpWx8YK7vXUXa3wZa1P2qBHpgLn/VRrnsQaIwvjTwJlHinR5cCnjgA2dY1ndJIeWx6iRStwBojQ1AKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560488; c=relaxed/simple;
	bh=p8c0oua+4RLIKlicowhwj3gq9ISRP8vdOu0h9k9reB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBbOWetaLkQRmFvYsUIYHSkfLvtff/bssU+ApZv6cldYu+yEO+Rk1Fs4SRwIe8e9ItFbMsPLoNwSnEM+Gm34vtsOsr2bGs48GBMFCdbCZC0ZxaBZw3Alk8RmHHDfpM5fBqTLx30+oftQ6kCsea9wpLg7yf6KCHDnNq34v6oXiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OroluFvX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560487; x=1778096487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p8c0oua+4RLIKlicowhwj3gq9ISRP8vdOu0h9k9reB0=;
  b=OroluFvXH/EBZ59hzWXllOjhB9Q2jFcx/gTTzM/+pWknEwvqJNQwOI/u
   nRraoenZYQdkuLi+k2khjslRJSzaLKl2P4Kp/z8MoGCYgG8yVfAXua4fO
   btJM9F21j6vWzgC7J6kZkQnTEAgIVs9WwjAu7MgKFwljTe815IfXLRZAt
   CKBfbKXytGg3CQSaFgsQS4U5sYwLLxjk9mfIJxnERwY00Xu+aZsVYl0Xw
   8+jdDsWEOLvP5NOHP+eBvAJTrT+xPutGdvsdsy14IiObivcuG+ViUB4hq
   qF1aUC62j4hTeOfTrviu5KEUkQR/WbWr2yEiFdGBoR3Z2hgx5E2fvxBzp
   g==;
X-CSE-ConnectionGUID: Oo1oE7XLSEORqTVF+8xI8Q==
X-CSE-MsgGUID: NirBYTbxTc+d7P7QAWUn0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961640"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961640"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:27 -0700
X-CSE-ConnectionGUID: w6vBAVx8Q1GRUZtVgiZlgQ==
X-CSE-MsgGUID: 0YQmtMNqRSylfImNjdDIJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465462"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: fix thermal code compilation with -Werror=cast-qual
Date: Tue,  6 May 2025 22:40:54 +0300
Message-Id: <20250506194102.3407967-8-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The compare_temps function in both mvm and mld dropped the const
qualifier in a cast in a way that makes -Werror=cast-qual unhappy. Add
the const to the cast to fix this.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Message-Id: <20250506223834.d3ca5aba902e.Iaaa2836064266e9368162ae5eddf574c86ff7594@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/thermal.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
index 1909953a9be9..f655fc04d949 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
@@ -116,8 +116,8 @@ static int iwl_mld_get_temp(struct iwl_mld *mld, s32 *temp)
 
 static int compare_temps(const void *a, const void *b)
 {
-	return ((s16)le16_to_cpu(*(__le16 *)a) -
-		(s16)le16_to_cpu(*(__le16 *)b));
+	return ((s16)le16_to_cpu(*(const __le16 *)a) -
+		(s16)le16_to_cpu(*(const __le16 *)b));
 }
 
 struct iwl_trip_walk_data {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index c851290e75a2..ed2f79abb82b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -552,8 +552,8 @@ int iwl_mvm_ctdp_command(struct iwl_mvm *mvm, u32 op, u32 state)
 #ifdef CONFIG_THERMAL
 static int compare_temps(const void *a, const void *b)
 {
-	return ((s16)le16_to_cpu(*(__le16 *)a) -
-		(s16)le16_to_cpu(*(__le16 *)b));
+	return ((s16)le16_to_cpu(*(const __le16 *)a) -
+		(s16)le16_to_cpu(*(const __le16 *)b));
 }
 
 struct iwl_trip_walk_data {
-- 
2.34.1


