Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F46E2074
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDNKNJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDNKNI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:13:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C41D4ED0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467161; x=1713003161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s9OP/gIZPXds2wY7KyxyQV4a6LysK11/BO5DZhuDGds=;
  b=ln2PCBD9Ct9aY0D6mtVmc5qlyQKAhen3ZfEJWryRMk+F+wILbc/0SV1k
   VcouaDi0qrZodOIF0HJ0AR9Z0R9BOwDFp1cHpF8AhVJ8HmNCC3Eow3OIN
   thnym/0kO68s7FYvUzSyv80lKJNUoC8PW0mdVpfBiF4SiDH612przAwRd
   OYib+rZ1zX6a3j8YDUD8K3CSxCnQjn9PVkNg+pblbUz1nvsNJwHmS3zwA
   qNMqAje4VDa8Z++j+aAANyWdt73WdZPntANT43hUKaoZlIMYQK3SfilV5
   CwocGVb4NMF9rxRyjaB5UFp+kpSkfCEny5MwgCpxj8xW7regA/ya6SE+J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263604"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263604"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351721"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351721"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:32 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: fw: move memset before early return
Date:   Fri, 14 Apr 2023 13:11:58 +0300
Message-Id: <20230414130637.872a7175f1ff.I33802a77a91998276992b088fbe25f61c87c33ac@changeid>
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

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this representative issue
dbg.c:1455:6: warning: Branch condition evaluates to
a garbage value
  if (!rxf_data.size)
       ^~~~~~~~~~~~~~

This check depends on iwl_ini_get_rxf_data() to clear
rxf_data but the function can return early without
doing the clear.  So move the memset before the early
return.

Fixes: cc9b6012d34b ("iwlwifi: yoyo: use hweight_long instead of bit manipulating")
Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index d5b51496bd0b..d9faaae01abd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1388,13 +1388,13 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
 	if (!data)
 		return;
 
+	memset(data, 0, sizeof(*data));
+
 	/* make sure only one bit is set in only one fid */
 	if (WARN_ONCE(hweight_long(fid1) + hweight_long(fid2) != 1,
 		      "fid1=%x, fid2=%x\n", fid1, fid2))
 		return;
 
-	memset(data, 0, sizeof(*data));
-
 	if (fid1) {
 		fifo_idx = ffs(fid1) - 1;
 		if (WARN_ONCE(fifo_idx >= MAX_NUM_LMAC, "fifo_idx=%d\n",
-- 
2.38.1

