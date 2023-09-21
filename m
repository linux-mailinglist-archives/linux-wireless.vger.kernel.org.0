Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE5A7A9DE1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjIUTua (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjIUTuS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:50:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D681379631
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318630; x=1726854630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9BklHQwi8dkkg1YSTnZO6soNolaofhwELZWOV9WtMCc=;
  b=GHA1kbPSu3EYSrhZCxRkMnnwUM7PgWQHWri+ZQFovoyITl4ECNrQSQe2
   CvML7pqXTsXs4ecfYuyAFKd2amayESuSA17Gmm7X2g+77puSA0UBDfg0y
   7KfD+XUCmzIY3mRhwKpABpivlc85lPn3kydA9Fvv0gLvYfEKY0vbfE+54
   auAKmfWb3jKCchzVSn7aJizqvHqkVTC5M6M6VnR6852snRo72s+/bt/Mt
   MJbYnSNOAZpZp5pUfCICpqMc0iF/E/34v0Vz4gJpmMUlwiVHZsHDKOsDo
   pLHH77CO1zLl0w0Jy5Qm8pj599CB2Hhnm+j4pol0n2npFNq0ezB+rKvpw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384305335"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384305335"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740545547"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740545547"
Received: from rchuwer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.229.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:53 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/12] wifi: iwlwifi: pcie: (re-)assign BAR0 on driver bind
Date:   Thu, 21 Sep 2023 11:58:03 +0300
Message-Id: <20230921110726.5f5f782a4e97.I4b7bf5c52ba44a8c7f9878009021689bbfa9c5ef@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230921085810.693048-1-gregory.greenman@intel.com>
References: <20230921085810.693048-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's a race with runtime PM getting enabled by userspace:
 - we rescan the PCI bus
 - this creates the new PCI device including its sysfs
   representation
 - udev sees the new device, and the (OS-specific?) scripting
   enables runtime PM by writing to power/control; this can
   happen _before_ the next step - this will runtime-suspend
   the device which saves the config space, including the BAR0
   that wasn't assigned yet
 - the bus rescan assigns resources to the devices and writes
   them to the config space of the device
   (but not the runtime-pm saved copy)
 - the driver binds and this disallows runtime PM, so the device
   is resumed, restoring the (incomplete!) config space
 - the driver cannot work due to BAR0 not being configured

Fixing the actual race is hard and deep in the PCI layer,
though probably should be done for upstream as well; perhaps
runtime PM should only be allowed after resource assignment,
or some other TBD way.

Work around this in the driver for now by simply (re-)assigning
BAR0 when the driver initializes, if it's unset.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 849ea1851508..5020ae4493c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3610,10 +3610,19 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	int ret, addr_size;
 	const struct iwl_trans_ops *ops = &trans_ops_pcie_gen2;
 	void __iomem * const *table;
+	u32 bar0;
 
 	if (!cfg_trans->gen2)
 		ops = &trans_ops_pcie;
 
+	/* reassign our BAR 0 if invalid due to possible runtime PM races */
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &bar0);
+	if (bar0 == PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		ret = pci_assign_resource(pdev, 0);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ERR_PTR(ret);
-- 
2.38.1

