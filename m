Return-Path: <linux-wireless+bounces-479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D21F806A1C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89BF282039
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79B81A5B6;
	Wed,  6 Dec 2023 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCssQrSI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB61FE4
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852595; x=1733388595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sZwZ+doVhLe9eOvBwRN4d8gpT5zQxfiWZ1DO7IotUB8=;
  b=bCssQrSIlAjMu6Zd1dWC1KILvA5mDJCAwG4G5Qtp+sjzLxith+m4AkH5
   bmZELWK2/atSnFxvfP9TBRYwpv8ImHHTpcoh8vtMoPZaiMqVX1vlWihA+
   i2ODTZIT4KtkCTi/cDE8A2aubk7oFdVumEA9j/voHs2iUDMj5bOnvJjYB
   wD/UV61vvVr2n8llZv1ZQ1YN8v2T8zoH4uOYzLon6pkt63PPmtShQm89U
   3AfEtf5YuAVmpZwX4MSjLLtvzF9E6gsmeif3mfur7HqPimFIOF2DuOaZ0
   HbKeQIxuwDvUBLpKaPSSvmucn6flHPBGBg9Dg02v34SEkmaIGrTCqOP63
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916547"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916547"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575402"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575402"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:53 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 06/13] wifi: iwlwifi: pcie: clean up device removal work
Date: Thu,  7 Dec 2023 04:50:11 +0200
Message-Id: <20231207044813.6c0879e695f7.I1d3ce75ecad32a4cbf1b9dad61bfb7bc7821fdd9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

From: Johannes Berg <johannes.berg@intel.com>

We shouldn't access the device if we don't hold a reference,
and if - after locking - we see that it has no bus, we also
can't do anything, in fact, pci_stop_and_remove_bus_device()
will be a no-op.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index a468e5efeecd..31a6e34b33ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2107,18 +2107,29 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
 		container_of(wk, struct iwl_trans_pcie_removal, work);
 	struct pci_dev *pdev = removal->pdev;
 	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
-	struct pci_bus *bus = pdev->bus;
+	struct pci_bus *bus;
+
+	pci_lock_rescan_remove();
+
+	bus = pdev->bus;
+	/* in this case, something else already removed the device */
+	if (!bus)
+		goto out;
 
 	dev_err(&pdev->dev, "Device gone - attempting removal\n");
+
 	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, prop);
-	pci_lock_rescan_remove();
-	pci_dev_put(pdev);
+
 	pci_stop_and_remove_bus_device(pdev);
-	if (removal->rescan && bus) {
+	pci_dev_put(pdev);
+
+	if (removal->rescan) {
 		if (bus->parent)
 			bus = bus->parent;
 		pci_rescan_bus(bus);
 	}
+
+out:
 	pci_unlock_rescan_remove();
 
 	kfree(removal);
-- 
2.34.1


