Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DC87CC825
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 17:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjJQPyR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbjJQPyP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 11:54:15 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CB995
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 08:54:13 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2087:0:640:7bf5:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 6689960A7F;
        Tue, 17 Oct 2023 18:54:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Asm1c64WrCg0-SuD4nnZc;
        Tue, 17 Oct 2023 18:54:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697558050; bh=ExbI9XKauKt0OTBWrumrPRIe6hhpHVSKix15w8H4dWQ=;
        h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
        b=S2XB/tuvUwzNzyZJ4bhBsBuwiMfkIax0PzhFcqeKGVdz1/JM4w4FtJ6KMa+CCcCIS
         kehf37Iw2VkwqCetziWTatqMbNs1Ny7u/iOc6EbCgDq4viHW3C2EFCySrLHFhBzp3t
         wuuGNTHPaGLzu4GiHjLqyb2UmrNO0RqgWPZ6h4tA=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath11k: fix -Wformat-truncation warning
Date:   Tue, 17 Oct 2023 18:53:25 +0300
Message-ID: <20231017155342.112032-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <87fs2k5l1a.fsf@kernel.org>
References: <87fs2k5l1a.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following warning observed with GCC 13.2 and -Wformat-truncation:

drivers/net/wireless/ath/ath11k/debugfs.c: In function ‘ath11k_debugfs_register’:
drivers/net/wireless/ath/ath11k/debugfs.c:1597:51: warning: ‘%d’ directive output
may be truncated writing between 1 and 3 bytes into a region of size 2 [-Wformat-truncation=]
 1597 |         snprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
      |                                                   ^~
drivers/net/wireless/ath/ath11k/debugfs.c:1597:48: note: directive argument in the range [0, 255]
 1597 |         snprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
      |                                                ^~~~~~
drivers/net/wireless/ath/ath11k/debugfs.c:1597:9: note: ‘snprintf’ output between
5 and 7 bytes into a destination of size 5
 1597 |         snprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Simplify the 'snprintf()' statement as well.

Suggested-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath11k/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 5bb6fd17fdf6..e9b05e7c189b 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1591,10 +1591,10 @@ static const struct file_operations fops_ps_state_enable = {
 int ath11k_debugfs_register(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
-	char pdev_name[5];
+	char pdev_name[8];
 	char buf[100] = {0};
 
-	snprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
+	snprintf(pdev_name, sizeof(pdev_name), "mac%u", ar->pdev_idx);
 
 	ar->debug.debugfs_pdev = debugfs_create_dir(pdev_name, ab->debugfs_soc);
 	if (IS_ERR(ar->debug.debugfs_pdev))
-- 
2.41.0

