Return-Path: <linux-wireless+bounces-4535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EEB877AEA
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D37281D4B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAB210A23;
	Mon, 11 Mar 2024 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/LtT3y9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193310795
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138516; cv=none; b=PAMdx2wSrciTTric+d+/eextiARzW7kDOB9axPanjXBdRsaxmgn0lBU3hw84Wxpv3e2tvLSlOOaOE0KpGcBaK/m3XbJO+Ff+gJ0q7jXuqp8OFtHSbXTIrBryr64GYleJVajcEfa6yWICzQUksWnCIr6CG2tPluW5yE+ZGHAjllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138516; c=relaxed/simple;
	bh=szzQHHcox/DYD9ln1maCxQdtNf2IeHm6BEd8K44CPAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyCunCTMi9my9AF8cA8QSRW3dekQ3tWg2zcp/954TzNQKUtDbvhJIw9RI+0o9cL4hd4KOWGz8odjmP3g48+v1gFlm+mQVIaee5tPLXy2YMRlGXsK7yDQa5Sh9npkQzEzAAVCzj4In8I0ifiRqBTqAJMyRjRSXVQn1WJeq+9WN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/LtT3y9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138513; x=1741674513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=szzQHHcox/DYD9ln1maCxQdtNf2IeHm6BEd8K44CPAA=;
  b=d/LtT3y9nPLwh2rwZ813azmcoeUg8ydTBLmqxYN8d85av4KgHAzD9yBx
   5RGwN9ZTBEpOwi19qpEv2B3K/JGpLfbVJhWA7AlLTtKlwf4snMMrIBW2j
   u6mTIG06cfsTvXq3WC4Q8Zc4m7xRDFYLH8Ma+txSLVIvqMwiQm+Bn6Knj
   j05iQC1uoGCeFm1qkk3Pe3Z0D2moN4ATWZFvCEHLLun70vvmcoh6r25qC
   e1HDdNYCF8TwAkweH5Oc+ob4JRy2YCSWx8JAuwDlocmWcK9pySo45CTcw
   25xouw5hKefCayDY89fhDvjhDJo8JaFS8v31q9CkJlgnc4pOMa3I+1nJ5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226739"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226739"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657617"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: fix firmware API kernel doc
Date: Mon, 11 Mar 2024 08:28:03 +0200
Message-Id: <20240311081938.2ea25f49489b.I83fa1cdc39f74ad2aacf75c2c14412eeaf93e787@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
References: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

Fix the comment of the associated struct of the
wowlan info notification.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/offload.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index 2d2b9c8c36ea..2ed7acc09e5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -3,7 +3,7 @@
  * Copyright (C) 2012-2014 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2021-2023 Intel Corporation
+ * Copyright (C) 2021-2024 Intel Corporation
  */
 #ifndef __iwl_fw_api_offload_h__
 #define __iwl_fw_api_offload_h__
@@ -20,7 +20,7 @@ enum iwl_prot_offload_subcmd_ids {
 	/**
 	 * @WOWLAN_INFO_NOTIFICATION: Notification in
 	 * &struct iwl_wowlan_info_notif_v1, &struct iwl_wowlan_info_notif_v2,
-	 * or iwl_wowlan_info_notif
+	 * or &struct iwl_wowlan_info_notif
 	 */
 	WOWLAN_INFO_NOTIFICATION = 0xFD,
 
-- 
2.34.1


