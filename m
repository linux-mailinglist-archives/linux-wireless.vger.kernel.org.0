Return-Path: <linux-wireless+bounces-3750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA073859857
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 18:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E021F21A08
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 17:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D24F6FB84;
	Sun, 18 Feb 2024 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fu+McmBb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57086F073
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278751; cv=none; b=fTy+mL8w27Xa0CpHbYkZyRjnV3O4O8GWNgrhx5tDl2Tzi28jcuJzguzgdnsSjjZzlqJzOLEzX9yCVejg0o9MTbRrkLq4Fdz+NFsRrOLK11xNJUCNN8F7HM7AFSZloGbXvqW2EhTXBFEWcqczGq+K7idEBwg/qx+7CdS5lnvTJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278751; c=relaxed/simple;
	bh=G+YodfR4e2XXImQfdYALBKenslG2kJSn0i17Xvfpm5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVLWssCqtTjgkmcn0iuT50BJ7x0DRlWoeJOdqziUmbcsgfntFRC9OKLSPlWKnGGsq+9aAu4JDBmxdcaGVkLgcSGYq4Nh1pP/h4k8nuiiHd0n7orr+tB81q/2r74GBLwPJVGFlC8cbKOD2qI7BPeD2H7vI9Oo1jOvbiffYcSlLO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fu+McmBb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708278741; x=1739814741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+YodfR4e2XXImQfdYALBKenslG2kJSn0i17Xvfpm5o=;
  b=fu+McmBbBNjNeH6LalQWxtJbxRPi65W3MsL8Q0OAFZ8vWYb/ZzizmA2/
   MEc9F54w5J3wmpwxwgjmNFDyLqcmTITxvzbENV2Efrpps5rQJrPp6mVJS
   A443nIo44h4bDemPSc6rX59m7JKht+iOdxAcJLGhT82efWnjBmI3RtIx3
   snYhLvce+lsC4wR8Rw5vlokIEMn275TKoeJiXoKveC5reVGMdgkFx8EGu
   4+kHiMd2LmHUfm7xZs8cjCN7QIObWQS81jvYTktDa8ijrWHTuyLEIu67v
   BLgwJMkDj/xzjtPlreWYzdtlNL/K2dTppnnZXHMxQEFl+fYd19+0UZ8Ll
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2464985"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2464985"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="27459449"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/11] wifi: iwlwifi: iwl-fh.h: fix kernel-doc issues
Date: Sun, 18 Feb 2024 19:51:49 +0200
Message-Id: <20240218194912.4a342ac06f0b.I604ea964a094b43df0ab29b06231c2f42d6bd79b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
References: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Clean up kernel-doc in iwl-fh.h. In one case, rename the
(otherwise unused) struct member to have the correct name.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h | 36 ++++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index e0400ba2ab74..6ba374efaacb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2021, 2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021, 2023-2024 Intel Corporation
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fh_h__
@@ -570,18 +570,19 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 /**
  * struct iwl_rb_status - reserve buffer status
  * 	host memory mapped FH registers
- * @closed_rb_num [0:11] - Indicates the index of the RB which was closed
- * @closed_fr_num [0:11] - Indicates the index of the RX Frame which was closed
- * @finished_rb_num [0:11] - Indicates the index of the current RB
+ * @closed_rb_num: [0:11] Indicates the index of the RB which was closed
+ * @closed_fr_num: [0:11] Indicates the index of the RX Frame which was closed
+ * @finished_rb_num: [0:11] Indicates the index of the current RB
  * 	in which the last frame was written to
- * @finished_fr_num [0:11] - Indicates the index of the RX Frame
+ * @finished_fr_num: [0:11] Indicates the index of the RX Frame
  * 	which was transferred
+ * @__spare: reserved
  */
 struct iwl_rb_status {
 	__le16 closed_rb_num;
 	__le16 closed_fr_num;
 	__le16 finished_rb_num;
-	__le16 finished_fr_nam;
+	__le16 finished_fr_num;
 	__le32 __spare;
 } __packed;
 
@@ -651,15 +652,15 @@ struct iwl_tfd_tb {
  *
  * This structure contains dma address and length of transmission address
  *
- * @tb_len length of the tx buffer
- * @addr 64 bits dma address
+ * @tb_len: length of the tx buffer
+ * @addr: 64 bits dma address
  */
 struct iwl_tfh_tb {
 	__le16 tb_len;
 	__le64 addr;
 } __packed;
 
-/**
+/*
  * Each Tx queue uses a circular buffer of 256 TFDs stored in host DRAM.
  * Both driver and device share these circular buffers, each of which must be
  * contiguous 256 TFDs.
@@ -698,10 +699,11 @@ struct iwl_tfd {
 
 /**
  * struct iwl_tfh_tfd - Transmit Frame Descriptor (TFD)
- * @ num_tbs 0-4 number of active tbs
- *	     5 -15   reserved
- * @ tbs[25]	transmit frame buffer descriptors
- * @ __pad	padding
+ * @num_tbs:
+ *	0-4 number of active tbs
+ *	5-15   reserved
+ * @tbs:	transmit frame buffer descriptors
+ * @__pad:	padding
  */
 struct iwl_tfh_tfd {
 	__le16 num_tbs;
@@ -718,10 +720,12 @@ struct iwl_tfh_tfd {
  * struct iwlagn_schedq_bc_tbl scheduler byte count table
  *	base physical address provided by SCD_DRAM_BASE_ADDR
  * For devices up to 22000:
- * @tfd_offset  0-12 - tx command byte count
+ * @tfd_offset:
+ *	For devices up to 22000:
+ *		 0-12 - tx command byte count
  *		12-16 - station index
- * For 22000:
- * @tfd_offset  0-12 - tx command byte count
+ *	For 22000:
+ *		 0-12 - tx command byte count
  *		12-13 - number of 64 byte chunks
  *		14-16 - reserved
  */
-- 
2.34.1


