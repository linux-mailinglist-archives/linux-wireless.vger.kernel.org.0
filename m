Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E025C801
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Sep 2020 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgICRYF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Sep 2020 13:24:05 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:42250 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgICRYC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Sep 2020 13:24:02 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 37DD313C2B0;
        Thu,  3 Sep 2020 10:24:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 37DD313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1599153842;
        bh=DYRihOm0trFDBL9jAzUYYoS2AyyhAKLXSUkVK31L8qk=;
        h=From:To:Cc:Subject:Date:From;
        b=Kdx/3Gd+NzZH0P52SxgHfxQ+n3CM3b+7jhe6hLD1RTflNZ2TbIoDZYC1L6o2/Ma2B
         5bTj/yP/pm6d9VEd6XjJnclSl8CggeuTfECTSv94gjH/RmdApDW8htP93QeHbQirJF
         h9VvMKj3ZGD0bJ0yYqwgNp16vkzPehPFbnuVSO84=
From:   greearb@candelatech.com
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ben Greear <greearb@candelatech.com>
Subject: [PATCH] ath11k:  Allow debugfs to work with 2+ radios installed.
Date:   Thu,  3 Sep 2020 10:23:59 -0700
Message-Id: <20200903172359.29199-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The code is trying to create an ath11k directory on debugfs
root, but that fails when there is a second radio (and thus
second instance of the driver).

Work around this by finding a free name.  This may fall into
the HACK category, I'm not really sure what the original design
is supposed to accomplish.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

NOTE:  A second radio still does not get far enough to fully boot
the NIC and create a phy* device, but at least system doesn't crash
hard now.

 drivers/net/wireless/ath/ath11k/core.h  |  5 +++--
 drivers/net/wireless/ath/ath11k/debug.c | 23 ++++++++++++++++-------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index bb22b41fefaa..858dfc700d54 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -707,8 +707,9 @@ struct ath11k_base {
 	/* Current DFS Regulatory */
 	enum ath11k_dfs_region dfs_region;
 #ifdef CONFIG_ATH11K_DEBUGFS
-	struct dentry *debugfs_soc;
-	struct dentry *debugfs_ath11k;
+	struct dentry *debugfs_soc; /* child of debugfs_ath11k */
+	char debugfs_ath11k_fname[36];
+	struct dentry *debugfs_ath11k; /* per driver instance */
 #endif
 	struct ath11k_soc_dp_stats soc_stats;
 
diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 31978ef9144e..70b4c4837879 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -1011,15 +1011,24 @@ void ath11k_debug_pdev_destroy(struct ath11k_base *ab)
 
 int ath11k_debug_soc_create(struct ath11k_base *ab)
 {
-	ab->debugfs_ath11k = debugfs_create_dir("ath11k", NULL);
+	/* We need one of these per driver instance, try until we find an un-used name */
+	int i;
 
-	if (IS_ERR_OR_NULL(ab->debugfs_ath11k)) {
-		if (IS_ERR(ab->debugfs_ath11k))
-			return PTR_ERR(ab->debugfs_ath11k);
-		return -ENOMEM;
+	for (i = 0; i<99; i++) {
+		snprintf(ab->debugfs_ath11k_fname, sizeof(ab->debugfs_ath11k_fname), "ath11k-%d", i);
+		ab->debugfs_ath11k = debugfs_create_dir(ab->debugfs_ath11k_fname, NULL);
+
+		if (!IS_ERR_OR_NULL(ab->debugfs_ath11k)) {
+			return 0;
+		}
 	}
 
-	return 0;
+	/* Couldn't create one */
+	ab->debugfs_ath11k_fname[0] = 0;
+
+	if (IS_ERR(ab->debugfs_ath11k))
+		return PTR_ERR(ab->debugfs_ath11k);
+	return -ENOMEM;
 }
 
 void ath11k_debug_soc_destroy(struct ath11k_base *ab)
@@ -1228,7 +1237,7 @@ int ath11k_debug_register(struct ath11k *ar)
 	}
 
 	/* Create a symlink under ieee80211/phy* */
-	snprintf(buf, 100, "../../ath11k/%pd2", ar->debug.debugfs_pdev);
+	snprintf(buf, 100, "../../%s/%pd2", ab->debugfs_ath11k_fname, ar->debug.debugfs_pdev);
 	debugfs_create_symlink("ath11k", ar->hw->wiphy->debugfsdir, buf);
 
 	ath11k_debug_htt_stats_init(ar);
-- 
2.26.2

