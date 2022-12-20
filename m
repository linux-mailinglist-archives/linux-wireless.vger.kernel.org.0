Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17A4652039
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 13:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiLTMMk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 07:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiLTMMi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 07:12:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB15186EB
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 04:12:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BFABB8120F
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 12:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3A0C433F0;
        Tue, 20 Dec 2022 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671538354;
        bh=hYDHwsE9piAh72BiV3VVBIriKByV2pTVruzTBjQPzEk=;
        h=From:To:Cc:Subject:Date:From;
        b=h3xR20mUS8l3hWFSdj+iPwT4eX5ykUtEYT75i1NcG3VSqnbOUCeNf7vlpOMi3bL8y
         g28V7lDRaq4mHpGkjZ2krwcuLQMKt05RaDjQ+DmKiQmhZ1LKwfHSnLGJhigf9MMY0J
         OxzhMaNGz7SMIc80fQKSmQihT1MBZq/HIUmXrlIRgEuk3k51orUgvjS7e6i7OqhVmg
         Hy238CvK9G2fP6D0xBZFJgTEE2oBXjnzentm0kA+TkK7EiaIPMfeyAiIMTVhXgG0sB
         tFcVHIHrTdKPIIoWORtEXoRbIizgmH96vwwOIGLAjmiYeLGjv9XbP9Bx5XjXqUH/SK
         eoRUjFIG/E+CQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: debugfs: fix to work with multiple PCI devices
Date:   Tue, 20 Dec 2022 14:12:31 +0200
Message-Id: <20221220121231.20120-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

ath11k fails to load if there are multiple ath11k PCI devices with same name:

 ath11k_pci 0000:01:00.0: Hardware name qcn9074 hw1.0
 debugfs: Directory 'ath11k' with parent '/' already present!
 ath11k_pci 0000:01:00.0: failed to create ath11k debugfs
 ath11k_pci 0000:01:00.0: failed to create soc core: -17
 ath11k_pci 0000:01:00.0: failed to init core: -17
 ath11k_pci: probe of 0000:01:00.0 failed with error -17

Fix this by creating a directory for each ath11k device using schema
<bus>-<devname>, for example "pci-0000:06:00.0". This directory created under
the top-level ath11k directory, for example /sys/kernel/debug/ath11k.

The reference to the toplevel ath11k directory is not stored anymore within ath11k, instead
it's retrieved using debugfs_lookup(). If the directory does not exist it will
be created. After the last directory from the ath11k directory is removed, for
example when doing rmmod ath11k, the empty ath11k directory is left in place,
it's a minor cosmetic issue anyway.

Here's an example hierarchy with one WCN6855:

ath11k
`-- pci-0000:06:00.0
    |-- mac0
    |   |-- dfs_block_radar_events
    |   |-- dfs_simulate_radar
    |   |-- ext_rx_stats
    |   |-- ext_tx_stats
    |   |-- fw_dbglog_config
    |   |-- fw_stats
    |   |   |-- beacon_stats
    |   |   |-- pdev_stats
    |   |   `-- vdev_stats
    |   |-- htt_stats
    |   |-- htt_stats_reset
    |   |-- htt_stats_type
    |   `-- pktlog_filter
    |-- simulate_fw_crash
    `-- soc_dp_stats

I didn't have a test setup where I could connect multiple ath11k devices to the
same the host, so I have only tested this with one device.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h    |  1 -
 drivers/net/wireless/ath/ath11k/debugfs.c | 48 +++++++++++++++++++----
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a8acb8b7b8d5..beb552108ac3 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -921,7 +921,6 @@ struct ath11k_base {
 	enum ath11k_dfs_region dfs_region;
 #ifdef CONFIG_ATH11K_DEBUGFS
 	struct dentry *debugfs_soc;
-	struct dentry *debugfs_ath11k;
 #endif
 	struct ath11k_soc_dp_stats soc_stats;
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index ccdf3d5ba1ab..5bb6fd17fdf6 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -976,10 +976,6 @@ int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
 	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
 		return 0;
 
-	ab->debugfs_soc = debugfs_create_dir(ab->hw_params.name, ab->debugfs_ath11k);
-	if (IS_ERR(ab->debugfs_soc))
-		return PTR_ERR(ab->debugfs_soc);
-
 	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
 			    &fops_simulate_fw_crash);
 
@@ -1001,15 +997,51 @@ void ath11k_debugfs_pdev_destroy(struct ath11k_base *ab)
 
 int ath11k_debugfs_soc_create(struct ath11k_base *ab)
 {
-	ab->debugfs_ath11k = debugfs_create_dir("ath11k", NULL);
+	struct dentry *root;
+	bool dput_needed;
+	char name[64];
+	int ret;
+
+	root = debugfs_lookup("ath11k", NULL);
+	if (!root) {
+		root = debugfs_create_dir("ath11k", NULL);
+		if (IS_ERR_OR_NULL(root))
+			return PTR_ERR(root);
+
+		dput_needed = false;
+	} else {
+		/* a dentry from lookup() needs dput() after we don't use it */
+		dput_needed = true;
+	}
+
+	scnprintf(name, sizeof(name), "%s-%s", ath11k_bus_str(ab->hif.bus),
+		  dev_name(ab->dev));
+
+	ab->debugfs_soc = debugfs_create_dir(name, root);
+	if (IS_ERR_OR_NULL(ab->debugfs_soc)) {
+		ret = PTR_ERR(ab->debugfs_soc);
+		goto out;
+	}
+
+	ret = 0;
 
-	return PTR_ERR_OR_ZERO(ab->debugfs_ath11k);
+out:
+	if (dput_needed)
+		dput(root);
+
+	return ret;
 }
 
 void ath11k_debugfs_soc_destroy(struct ath11k_base *ab)
 {
-	debugfs_remove_recursive(ab->debugfs_ath11k);
-	ab->debugfs_ath11k = NULL;
+	debugfs_remove_recursive(ab->debugfs_soc);
+	ab->debugfs_soc = NULL;
+
+	/* We are not removing ath11k directory on purpose, even if it
+	 * would be empty. This simplifies the directory handling and it's
+	 * a minor cosmetic issue to leave an empty ath11k directory to
+	 * debugfs.
+	 */
 }
 EXPORT_SYMBOL(ath11k_debugfs_soc_destroy);
 

base-commit: 922932ca02191a390f7f52fb6e21c44b50e14025
-- 
2.30.2

