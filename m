Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E4B7A7BBD
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 13:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjITLzS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 07:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjITLzQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 07:55:16 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2052EB4
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 04:55:11 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:1215:0:640:367b:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id A2270600FD;
        Wed, 20 Sep 2023 14:55:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7tHqHADWpGk0-9GVgaGtu;
        Wed, 20 Sep 2023 14:55:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695210908; bh=3c5PeWokgzzMqcgnV+f2qIXZF3JTEAld8A0W+J95PJ8=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=sDYpWZHFgIxY60G6G59Qiav2buPKKZklfcQ2AYVyEB/jwRo/RIn+AyMV9YcPdUb39
         jvdOM0Pii9gu0gQBZyEWHNnkYHUGbAzKxpMPTbvGkLafA8eqRZL0ZfxjBofdsx3Gwc
         I4FzNsgxe8NvVbDC1hGVzhWb3wVaqBhNS3+iD4pQ=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath11k: consistently use kstrtoul_from_user()
Date:   Wed, 20 Sep 2023 14:54:43 +0300
Message-ID: <20230920115447.38355-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use 'kstrtoul_from_user()' in 'ath11k_write_file_spectral_count()'
and 'ath11k_write_file_spectral_bins()' and so simplify both ones.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
Hopefully this doesn't violate "if it isn't broke, don't fix
it" rule (the same thing was recently accepted for ath9k).
---
 drivers/net/wireless/ath/ath11k/spectral.c | 26 +++++++---------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 705868198df4..51d0c4a56b93 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -382,16 +382,11 @@ static ssize_t ath11k_write_file_spectral_count(struct file *file,
 {
 	struct ath11k *ar = file->private_data;
 	unsigned long val;
-	char buf[32];
-	ssize_t len;
-
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
+	ssize_t ret;
 
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &val))
-		return -EINVAL;
+	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
 
 	if (val > ATH11K_SPECTRAL_SCAN_COUNT_MAX)
 		return -EINVAL;
@@ -437,16 +432,11 @@ static ssize_t ath11k_write_file_spectral_bins(struct file *file,
 {
 	struct ath11k *ar = file->private_data;
 	unsigned long val;
-	char buf[32];
-	ssize_t len;
-
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
+	ssize_t ret;
 
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &val))
-		return -EINVAL;
+	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
 
 	if (val < ATH11K_SPECTRAL_MIN_BINS ||
 	    val > ar->ab->hw_params.spectral.max_fft_bins)
-- 
2.41.0

