Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8F879E750
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbjIML5N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjIML5M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:57:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B8B1996
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606228; x=1726142228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JIESgcHWBEA280p/KwYfRuT9N7lr2wPGJ6vVOH4uY08=;
  b=eThrzop24C75hghNtmVYRMHO5Aackup2QvTo2jgKDLhTqfowaEYkM71N
   LvXqTVUMJOnn9dMnKcHLbmbEA7XXTrKLrxZVMt/A62bYPJlo9jyKZoACA
   uplHF3l5OIS+lvRx/ETpJPSt2Ufyw8Bc/JOCBIg/NSBsm7SMIralNUekl
   pBgFkJWa94lMR3IhGj3+MymERJRanJxzBP+UhHSI73ljW6S2Hh3CzLU+Z
   gaCcpvYMG7hW05+JXR7PEapqtnaxvoZ52KVCKM4FOfJytqpcDLgOan49h
   rU0wCyUtfjt6+QcZ0ek45aEQxkoLXgksO7qPR++wVRVr+OtufiktR51sq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368902967"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368902967"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470920"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470920"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: pcie: rescan bus if no parent
Date:   Wed, 13 Sep 2023 14:56:37 +0300
Message-Id: <20230913145231.f7795a1ccdab.I2b84810a743469a1bcabf3628262cf54311593f4@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the bus has no parent due to the topology, platform level device
reset (PLDR) wouldn't work. On the other hand, some platforms appear
to require scanning the parent, though it's not clear why.

However if there's no parent, then we skip the rescan, which isn't a
good idea. Change the code to go to the parent only if that exists,
and rescan the bus itself where it doesn't.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index a9e00a2cd9ba..51012435e39b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2112,8 +2112,11 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
 	pci_lock_rescan_remove();
 	pci_dev_put(pdev);
 	pci_stop_and_remove_bus_device(pdev);
-	if (removal->rescan)
-		pci_rescan_bus(bus->parent);
+	if (removal->rescan && bus) {
+		if (bus->parent)
+			bus = bus->parent;
+		pci_rescan_bus(bus);
+	}
 	pci_unlock_rescan_remove();
 
 	kfree(removal);
-- 
2.38.1

