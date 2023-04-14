Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF25A6E207E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjDNKOg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDNKOf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:14:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3312D6B
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467237; x=1713003237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+92juXt6V26BBvbcrT5VRudgMZ9MlCp4R6jkxhrzGK4=;
  b=etEYY3loetVB5Jbfqr6Kpryklw1iVyr1RK8jLD3+J+vOycu+Ti5+yEq0
   6lCys3GdqHeeuRKnx514jQ/Hnycx8IVz/2vffQos2C/jNh8TuP2hlib/G
   idECNmMYN6VYuT+2FQ/geEZ7+R/qEAERx+cAai9HW7+8dhoMdq3hEbeVe
   5BpGU7IL9MlRtVvhjPt2KFBEQLVOU2d6Y9r4HEHuOp6Ef+k8YFXFY0rX+
   c5t6XP8IJqY/+CTYyXF15VdXS6Jsm7IWipcTxLRlRDRQPoec6BkY+rQb8
   3XpFB/hfN40wla1TNXNEy5TWbi+sC7PdjypzJTvPyAseZB0fnHlkb+c4w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263625"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263625"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351737"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351737"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: pcie: Fix integer overflow in iwl_write_to_user_buf
Date:   Fri, 14 Apr 2023 13:11:59 +0300
Message-Id: <20230414130637.2d80ace81532.Iecfba549e0e0be21bbb0324675392e42e75bd5ad@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414101206.1170180-1-gregory.greenman@intel.com>
References: <20230414101206.1170180-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Hyunwoo Kim <imv4bel@gmail.com>

An integer overflow occurs in the iwl_write_to_user_buf() function,
which is called by the iwl_dbgfs_monitor_data_read() function.

static bool iwl_write_to_user_buf(char __user *user_buf, ssize_t count,
				  void *buf, ssize_t *size,
				  ssize_t *bytes_copied)
{
	int buf_size_left = count - *bytes_copied;

	buf_size_left = buf_size_left - (buf_size_left % sizeof(u32));
	if (*size > buf_size_left)
		*size = buf_size_left;

If the user passes a SIZE_MAX value to the "ssize_t count" parameter,
the ssize_t count parameter is assigned to "int buf_size_left".
Then compare "*size" with "buf_size_left" . Here, "buf_size_left" is a
negative number, so "*size" is assigned "buf_size_left" and goes into
the third argument of the copy_to_user function, causing a heap overflow.

This is not a security vulnerability because iwl_dbgfs_monitor_data_read()
is a debugfs operation with 0400 privileges.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 40283fe622da..1b32a4035d88 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2860,7 +2860,7 @@ static bool iwl_write_to_user_buf(char __user *user_buf, ssize_t count,
 				  void *buf, ssize_t *size,
 				  ssize_t *bytes_copied)
 {
-	int buf_size_left = count - *bytes_copied;
+	ssize_t buf_size_left = count - *bytes_copied;
 
 	buf_size_left = buf_size_left - (buf_size_left % sizeof(u32));
 	if (*size > buf_size_left)
-- 
2.38.1

