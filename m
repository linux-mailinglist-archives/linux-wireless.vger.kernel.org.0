Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBAF6B9D84
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCNRv5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCNRvy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:51:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB82B423B
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816270; x=1710352270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d2WY2veeXRZaUspwDGPAktmdqvEVD+eWtdu5rfeHq5g=;
  b=B8kX1Pjxr8gO0/RxXJx/GV+4rHMq1uJ3pGDxFtlFmmqtfBGVzWGfglhK
   a7TA5xZeFXMX2EKq74Y1sRfpjNyeEptnfiFwedGaKdte0Xf6jSwsy5fua
   2EHJCdUlV7OFsbFww37t2UY2RZfq/mwMUgZzlCH5dnk/Yp6Qydk9vaZ0U
   1/LsHO6Q6JxPiUa8/WwDYLt9fakJ1FQzwEc95vQAPAVuWZDYGY/qpZH/0
   7916psKMJDp7lIvAQCuaqsnFom5h4zloLGIxW0plaUyzL5/Q/Fw0AzcO8
   qBV4M2v9H0m59eAQ8/1lRwxi08Uxh2kvH/tZgcpnZQYM0YDNn6YWWqipV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149492"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149492"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200450"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200450"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:49:53 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Greenman@vger.kernel.org, Gregory <gregory.greenman@intel.com>
Subject: [PATCH 02/22] wifi: iwlwifi: yoyo: Add new tlv for dump file name extension
Date:   Tue, 14 Mar 2023 19:49:14 +0200
Message-Id: <20230314194113.ffc28212994e.Ie5f10709548497061f95c1634d942dd2facf72ec@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add tlv in dump file for dump file name extension.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Greenman, Gregory <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 32 ++++++++++++++++++-
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 17 +++++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 +++
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index abf49022edbe..ca97f2fcb693 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2320,6 +2320,34 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	return entry->size;
 }
 
+static u32 iwl_dump_ini_file_name_info(struct iwl_fw_runtime *fwrt,
+				       struct list_head *list)
+{
+	struct iwl_fw_ini_dump_entry *entry;
+	struct iwl_dump_file_name_info *tlv;
+	u32 len = strnlen(fwrt->trans->dbg.dump_file_name_ext,
+			  IWL_FW_INI_MAX_NAME);
+
+	if (!fwrt->trans->dbg.dump_file_name_ext_valid)
+		return 0;
+
+	entry = vzalloc(sizeof(*entry) + sizeof(*tlv) + len);
+	if (!entry)
+		return 0;
+
+	entry->size = sizeof(*tlv) + len;
+
+	tlv = (void *)entry->data;
+	tlv->type = cpu_to_le32(IWL_INI_DUMP_NAME_TYPE);
+	tlv->len = cpu_to_le32(len);
+	memcpy(tlv->data, fwrt->trans->dbg.dump_file_name_ext, len);
+
+	/* add the dump file name extension tlv to the list */
+	list_add_tail(&entry->list, list);
+
+	return entry->size;
+}
+
 static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 	[IWL_FW_INI_REGION_INVALID] = {},
 	[IWL_FW_INI_REGION_INTERNAL_BUFFER] = {
@@ -2495,8 +2523,10 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 		size += iwl_dump_ini_mem(fwrt, list, &reg_data,
 					 &iwl_dump_ini_region_ops[IWL_FW_INI_REGION_DRAM_IMR]);
 
-	if (size)
+	if (size) {
+		size += iwl_dump_ini_file_name_info(fwrt, list);
 		size += iwl_dump_ini_info(fwrt, trigger, list);
+	}
 
 	return size;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index c62576e442bd..f5e08988dc7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2014, 2018-2022 Intel Corporation
  * Copyright (C) 2014-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -75,6 +75,18 @@ struct iwl_fw_error_dump_data {
 	__u8 data[];
 } __packed;
 
+/**
+ * struct iwl_dump_file_name_info - data for dump file name addition
+ * @type: region type with reserved bits
+ * @len: the length of file name string to be added to dump file
+ * @data: the string need to be added to dump file
+ */
+struct iwl_dump_file_name_info {
+	__le32 type;
+	__le32 len;
+	__u8 data[];
+} __packed;
+
 /**
  * struct iwl_fw_error_dump_file - the layout of the header of the file
  * @barker: must be %IWL_FW_ERROR_DUMP_BARKER
@@ -231,6 +243,9 @@ struct iwl_fw_error_dump_mem {
 /* Use bit 31 as dump info type to avoid colliding with region types */
 #define IWL_INI_DUMP_INFO_TYPE BIT(31)
 
+/* Use bit 31 and bit 24 as dump name type to avoid colliding with region types */
+#define IWL_INI_DUMP_NAME_TYPE (BIT(31) | BIT(24))
+
 /**
  * struct iwl_fw_error_dump_data - data for one type
  * @type: &enum iwl_fw_ini_region_type
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 9aced3e44bc2..dd277a4fa8dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -775,6 +775,8 @@ struct iwl_imr_data {
  * @periodic_trig_list: periodic triggers list
  * @domains_bitmap: bitmap of active domains other than &IWL_FW_INI_DOMAIN_ALWAYS_ON
  * @ucode_preset: preset based on ucode
+ * @dump_file_name_ext: dump file name extension
+ * @dump_file_name_ext_valid: dump file name extension if valid or not
  */
 struct iwl_trans_debug {
 	u8 n_dest_reg;
@@ -813,6 +815,8 @@ struct iwl_trans_debug {
 	bool restart_required;
 	u32 last_tp_resetfw;
 	struct iwl_imr_data imr_data;
+	u8 dump_file_name_ext[IWL_FW_INI_MAX_NAME];
+	bool dump_file_name_ext_valid;
 };
 
 struct iwl_dma_ptr {
-- 
2.38.1

