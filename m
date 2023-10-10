Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC427BF2E7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 08:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442202AbjJJGW5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 02:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442156AbjJJGW4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 02:22:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C54E97
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 23:22:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E04C433C7;
        Tue, 10 Oct 2023 06:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696918973;
        bh=5NOg5uNUDnpZqHcJPhdo5YvKO0Os9HQIPC4c1sGnyPw=;
        h=From:To:Cc:Subject:Date:From;
        b=aacs0stuQVdFu4ERHSz8s2LC+p5c5tLKNMXRrUalh77ExMDnIB3vKNqv44Evd2ayr
         utToWvTgLQ2BjLk3bwmatsi8PuN4eAqMAfdcRW3Grwl51Gxb2mw0FJaGFepz+cu+hZ
         7WPNyi5IMVbyjEfslpwKzMwunW2Ih6ZULp7C5FdHyr/zQQVNa8KFYhbh9yLW+8YhYA
         JoCXY9MxS6ll30E4m9rQJhTDBi/6GRYX+m3NL+nIg1y21xwNP4kCjR1AgdeHg9j0Df
         J3iWVsuI+qr15tiywJnC8BKoxbo/wxitHBkfOROhtldeI5RIQOBxjPf+68AkwNRZJR
         XuUf7vWYlCylA==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath11k: ath11k_debugfs_register(): fix format-truncation warning
Date:   Tue, 10 Oct 2023 09:22:50 +0300
Message-Id: <20231010062250.2580951-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

In v6.6-rc4 with GCC 13.2 I see a new warning:

drivers/net/wireless/ath/ath11k/debugfs.c: In function 'ath11k_debugfs_register':
drivers/net/wireless/ath/ath11k/debugfs.c:1597:51: error: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size 2 [-Werror=format-truncation=]
drivers/net/wireless/ath/ath11k/debugfs.c:1597:48: note: directive argument in the range [0, 255]
drivers/net/wireless/ath/ath11k/debugfs.c:1597:9: note: 'snprintf' output between 5 and 7 bytes into a destination of size 5

Increase the size of pdev_name to 10 bytes to make sure there's enough room for
the string. Also change the format to '%u' as ar->pdev_idx is u8.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 5bb6fd17fdf6..6f89e24cb612 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1591,10 +1591,10 @@ static const struct file_operations fops_ps_state_enable = {
 int ath11k_debugfs_register(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
-	char pdev_name[5];
+	char pdev_name[10];
 	char buf[100] = {0};
 
-	snprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
+	snprintf(pdev_name, sizeof(pdev_name), "%s%u", "mac", ar->pdev_idx);
 
 	ar->debug.debugfs_pdev = debugfs_create_dir(pdev_name, ab->debugfs_soc);
 	if (IS_ERR(ar->debug.debugfs_pdev))

base-commit: 54ca82af78699713bae8b086f46ae13179772085
-- 
2.39.2

