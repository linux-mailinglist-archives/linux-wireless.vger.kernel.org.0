Return-Path: <linux-wireless+bounces-9550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A73916E87
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6011C22796
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E5717C7D9;
	Tue, 25 Jun 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4LUm3xC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F217C7CA
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334317; cv=none; b=fWxlgEe0/8nHz1Wk84BByDzdYGROqaAEbpC9GEEKxt76Sd44n7HxNBlfMijxPcE+k32qaOJLUeAMku4OQlBnGRAIUfysiz2gMWlDcs8pYqu5GrAdOuUPBYahcsYzL+AAgpdVWr9y5z3eJznXsJOXrJjcyQd79OvF0jqybEfBYhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334317; c=relaxed/simple;
	bh=sI3IB/y3jNZM0l8j1+Q9s9pYz4CoLm1pxfHv9Ynp9mw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Km98F1ZiIMpVIFw+ASyjcUxHjN3+rPhofCSeyP4Cru/r5yzkohxuEBceJjWGYgXadBzDgjJZnq0G84Lah2xC+saWbXVvCkQ8bdrqtJZntLM7vOiAJoCqCzc1anww5N08YTp9xfAQFcyKxl5DCtkbecMdZkOwszRuqkzZDz2RXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4LUm3xC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334317; x=1750870317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sI3IB/y3jNZM0l8j1+Q9s9pYz4CoLm1pxfHv9Ynp9mw=;
  b=A4LUm3xCZ2129FdcW1hYdBa5KqMZLnvTLGwEVhTUbYdUzwHWJJTXwdna
   ZDlz599yeHTzQSpp5k5unrMXoP6R5GwqfhhAj0O3r6E2j5n1OAuFPA27m
   gycr05IuoEkOEznjvjFsAKoj1hYWsGDcu773drgdbpnyHYb3uhNC9+gLq
   pGWV1LUiWsus1g0vP1BU+eParOFdENbX1tHj4bqQ3TX5+H3xPrvW2Mafy
   UOCfn03FhcPHgFlg/8uGIhfUkr4p77sJA/pol3VutKQAzIo3FlNngMwQo
   ymtAJVOo+L3Dx8EfQRdyXXY014Qfdru2fXbrbPN9YzBCCcU7iyDu6tuXc
   A==;
X-CSE-ConnectionGUID: Jl1gR1boQuekDviDkEIW6g==
X-CSE-MsgGUID: 60HBzcPBRlCNSYIq3hEydw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594797"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594797"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:56 -0700
X-CSE-ConnectionGUID: 7q8AWRDST9aaJv+ttSs/Ww==
X-CSE-MsgGUID: t55E9wZaSq+GFmCTard7Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632886"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/17] wifi: iwlwifi: fw: api: datapath: fix kernel-doc
Date: Tue, 25 Jun 2024 19:51:22 +0300
Message-Id: <20240625194805.1a644d4c38f4.I6060819da2bfc948bee089a91626ff474300a896@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Fix kernel-doc warnings in datapath.h.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index f272b6a4e72e..2ab38eaeb290 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -231,28 +231,33 @@ struct iwl_synced_time_rsp {
 #define PTP_CTX_MAX_DATA_SIZE   128
 
 /**
- * struct iwl_time_msmt_ptp_ctx - Vendor specific information element
+ * struct iwl_time_msmt_ptp_ctx - Vendor specific element
  * to allow a space for flexibility for the userspace App
  *
- * @element_id: element id of vendor specific ie
- * @length: length of vendor specific ie
- * @reserved: for alignment
- * @data: vendor specific data blob
+ * @ftm: FTM specific vendor element
+ * @ftm.element_id: element id of vendor specific ie
+ * @ftm.length: length of vendor specific ie
+ * @ftm.reserved: for alignment
+ * @ftm.data: vendor specific data blob
+ * @tm: TM specific vendor element
+ * @tm.element_id: element id of vendor specific ie
+ * @tm.length: length of vendor specific ie
+ * @tm.data: vendor specific data blob
  */
 struct iwl_time_msmt_ptp_ctx {
-	/* Differentiate between FTM and TM specific Vendor IEs */
+	/* Differentiate between FTM and TM specific Vendor elements */
 	union {
 		struct {
 			u8 element_id;
 			u8 length;
 			__le16 reserved;
 			u8 data[PTP_CTX_MAX_DATA_SIZE];
-		} ftm; /* FTM specific vendor IE */
+		} ftm;
 		struct {
 			u8 element_id;
 			u8 length;
 			u8 data[PTP_CTX_MAX_DATA_SIZE];
-		} tm; /* TM specific vendor IE */
+		} tm;
 	};
 } __packed /* PTP_CTX_VER_1 */;
 
@@ -531,6 +536,10 @@ struct iwl_rx_baid_cfg_cmd_remove {
 /**
  * struct iwl_rx_baid_cfg_cmd - BAID allocation/config command
  * @action: the action, from &enum iwl_rx_baid_action
+ * @alloc: allocation data
+ * @modify: modify data
+ * @remove_v1: remove data (version 1)
+ * @remove: remove data
  */
 struct iwl_rx_baid_cfg_cmd {
 	__le32 action;
@@ -565,6 +574,7 @@ enum iwl_scd_queue_cfg_operation {
 /**
  * struct iwl_scd_queue_cfg_cmd - scheduler queue allocation command
  * @operation: the operation, see &enum iwl_scd_queue_cfg_operation
+ * @u: union depending on command usage
  * @u.add.sta_mask: station mask
  * @u.add.tid: TID
  * @u.add.reserved: reserved
@@ -634,6 +644,7 @@ enum iwl_sec_key_flags {
 /**
  * struct iwl_sec_key_cmd - security key command
  * @action: action from &enum iwl_ctxt_action
+ * @u: union depending on command type
  * @u.add.sta_mask: station mask for the new key
  * @u.add.key_id: key ID (0-7) for the new key
  * @u.add.key_flags: key flags per &enum iwl_sec_key_flags
-- 
2.34.1


