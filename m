Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6D6E144B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDMSlo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjDMSlm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:41:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFD861A9
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411300; x=1712947300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MIBUiNGSBFJ3sGCwOeyFlxnZMhEobi0V/e5BlxX7SL8=;
  b=d8csK1HasAKIzdE0J3kAMIUvX7hwu5zUNB6I6A6MxXX/+eJacNE/E2xy
   r/FaOH14dG6XFHnu19gLk1RcgKXCUSDyJqBrmHJZ+N/ohhldPsB/Nuy+a
   6qxdxDLmoVuOqyNbT+dzOialmlef2cQADCMLBIC596hVhUaCQrNjmEI9R
   zpymPtFwv2bQKEgzpTowvHW8czWR6cf+t5uXnkoI2XaOgRRoxlL4aUkKN
   RpToe9UNz6EVwShikE2HmwizSXbOyn/nN2sQkGuJxUbnP0frfP4MF9soU
   8vTrFyan10oR21bBs8HpemsFYSqjx9kSEr4r2aROK1J7WNAQSi7TEaP85
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372127051"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372127051"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984358"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984358"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:09 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: mvm: add DSM_FUNC_ENABLE_6E value to debugfs
Date:   Thu, 13 Apr 2023 21:40:29 +0300
Message-Id: <20230413213309.c9a787710e1e.If509b2e510e22d62f3eefb2c54ff1645e331dc23@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413184035.1140892-1-gregory.greenman@intel.com>
References: <20230413184035.1140892-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In order to simplify checking that this value was set up
correctly, add it to debugfs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 527daaf46f96..affaed4d13fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -340,6 +340,26 @@ static ssize_t iwl_dbgfs_sar_geo_profile_read(struct file *file,
 
 	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 }
+
+static ssize_t iwl_dbgfs_wifi_6e_enable_read(struct file *file,
+					     char __user *user_buf,
+					     size_t count, loff_t *ppos)
+{
+	struct iwl_mvm *mvm = file->private_data;
+	int err, pos;
+	char buf[12];
+	u32 value;
+
+	err = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
+				   DSM_FUNC_ENABLE_6E,
+				   &iwl_guid, &value);
+	if (err)
+		return err;
+
+	pos = sprintf(buf, "0x%08x\n", value);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+}
 #endif
 
 static ssize_t iwl_dbgfs_stations_read(struct file *file, char __user *user_buf,
@@ -1898,6 +1918,7 @@ MVM_DEBUGFS_READ_FILE_OPS(uapsd_noagg_bssids);
 
 #ifdef CONFIG_ACPI
 MVM_DEBUGFS_READ_FILE_OPS(sar_geo_profile);
+MVM_DEBUGFS_READ_FILE_OPS(wifi_6e_enable);
 #endif
 
 MVM_DEBUGFS_READ_WRITE_STA_FILE_OPS(amsdu_len, 16);
@@ -2092,6 +2113,7 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	MVM_DEBUGFS_ADD_FILE(tas_get_status, mvm->debugfs_dir, 0400);
 #ifdef CONFIG_ACPI
 	MVM_DEBUGFS_ADD_FILE(sar_geo_profile, mvm->debugfs_dir, 0400);
+	MVM_DEBUGFS_ADD_FILE(wifi_6e_enable, mvm->debugfs_dir, 0400);
 #endif
 	MVM_DEBUGFS_ADD_FILE(he_sniffer_params, mvm->debugfs_dir, 0600);
 
-- 
2.38.1

