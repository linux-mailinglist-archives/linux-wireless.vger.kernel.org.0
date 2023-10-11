Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FC97C4FE4
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjJKKSI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjJKKSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:18:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294A319BE
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018866; x=1728554866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rudZcrRqzLk7xoQG4/RUl5ApVruUy5Uq9djN1M6tkdo=;
  b=LkDIQ7XaZDGHT2L0wKeLBM6SZ5zy9IvqCUJf2rMnDq7moG2bRUgt7bfc
   SIMJR6T9YMeamoCLpfN+cOfsCS0UgULAD8BTjuowzVck+xNZTm7VUSGS+
   TT146ocerOd9ReHRgjYugwMTj3Hr39oFqXsTAIYDLQzKwr09CdN0Fbkl/
   JLU/egunA5QQMLE7B+Ov45soghhsGAWsgXemM2HNbd3If1jNpA4Rpra5s
   Q4IeYMlmGJnmdNeMREiY7YZQsrZ8lEiGwLPAcyu1SYFty7kIQYhqfSr1P
   OFnlR73ZnaTDJeW21RxbTovHMk4O7U1lI3x+3LCqFBdlIBs560EGslyxF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670551"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670551"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050236"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050236"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:44 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/16] wifi: iwlwifi: fw: increase fw_version string size
Date:   Wed, 11 Oct 2023 13:07:16 +0300
Message-Id: <20231011130030.d859c6fc4bb1.Idced2e8d63c492872edcde1a3ce2cdd6cc0f8eb7@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011100731.361200-1-gregory.greenman@intel.com>
References: <20231011100731.361200-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

In reality 64 bytes are enough to hold fw version string,
but some compilers can complain (with W=1) that output may be
truncated when building this string with snprintf.
Increase the size to avoid this sort of warnings.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/img.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 8d0d58d61892..96bda80632f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -198,7 +198,7 @@ struct iwl_dump_exclude {
 struct iwl_fw {
 	u32 ucode_ver;
 
-	char fw_version[64];
+	char fw_version[128];
 
 	/* ucode images */
 	struct fw_img img[IWL_UCODE_TYPE_MAX];
-- 
2.38.1

