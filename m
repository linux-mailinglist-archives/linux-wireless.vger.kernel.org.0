Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7727F55D7E3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jun 2022 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbiF0J3o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jun 2022 05:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiF0J3n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jun 2022 05:29:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA40B08;
        Mon, 27 Jun 2022 02:29:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CBA6B81071;
        Mon, 27 Jun 2022 09:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23528C3411D;
        Mon, 27 Jun 2022 09:29:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="URNO8rbW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656322175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YtKczlNmNnwe7BRbfivFJb7Cyrti3AY4QZWRSGBykVk=;
        b=URNO8rbWWkQWXsEH7Oyi+jP0waSx2jzPGEHtue7g1vGO9ev8qyFtN9d1A18eErDQ+T0qaW
        hMOhVC2n61HSCkfOWEUM0szQtmyqZVCuy2HkIezKcEKa8MlTm5n2PDbmGMKCjoxyEhCGtn
        C2JLtgH1D/meP5rHrcFA8PVcWCTahDM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f824000f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 27 Jun 2022 09:29:34 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Gregory Erwin <gregerwin256@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        stable@vger.kernel.org
Subject: [PATCH v3] ath9k: sleep for less time when unregistering hwrng
Date:   Mon, 27 Jun 2022 11:29:27 +0200
Message-Id: <20220627092927.513709-1-Jason@zx2c4.com>
In-Reply-To: <YrlR7O4roipJt4Nc@gondor.apana.org.au>
References: <YrlR7O4roipJt4Nc@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Even though hwrng provides a `wait` parameter, it doesn't work very well
when waiting for a long time. There are numerous deadlocks that emerge
related to shutdown. Work around this API limitation by waiting for a
shorter amount of time and erroring more frequently. This commit also
prevents hwrng from splatting messages to dmesg when there's a timeout
and prevents calling msleep_interruptible() for tons of time when a
thread is supposed to be shutting down, since msleep_interruptible()
isn't actually interrupted by kthread_stop().

Reported-by: Gregory Erwin <gregerwin256@gmail.com>
Tested-by: Gregory Erwin <gregerwin256@gmail.com>
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: stable@vger.kernel.org
Fixes: fcd09c90c3c5 ("ath9k: use hw_random API instead of directly dumping into random.c")
Link: https://lore.kernel.org/all/CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDsFGTEjs0c00giw@mail.gmail.com/
Link: https://lore.kernel.org/lkml/CAO+Okf5k+C+SE6pMVfPf-d8MfVPVq4PO7EY8Hys_DVXtent3HA@mail.gmail.com/
Link: https://bugs.archlinux.org/task/75138
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/hw_random/core.c        | 10 ++++++++--
 drivers/net/wireless/ath/ath9k/rng.c | 20 +++-----------------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 16f227b995e8..a15273271d87 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -513,8 +513,13 @@ static int hwrng_fillfn(void *unused)
 			break;
 
 		if (rc <= 0) {
-			pr_warn("hwrng: no data available\n");
-			msleep_interruptible(10000);
+			int i;
+
+			for (i = 0; i < 100; ++i) {
+				if (kthread_should_stop() ||
+				    schedule_timeout_interruptible(HZ / 20))
+					goto out;
+			}
 			continue;
 		}
 
@@ -529,6 +534,7 @@ static int hwrng_fillfn(void *unused)
 		add_hwgenerator_randomness((void *)rng_fillbuf, rc,
 					   entropy >> 10);
 	}
+out:
 	hwrng_fill = NULL;
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath9k/rng.c b/drivers/net/wireless/ath/ath9k/rng.c
index cb5414265a9b..39195f89ea85 100644
--- a/drivers/net/wireless/ath/ath9k/rng.c
+++ b/drivers/net/wireless/ath/ath9k/rng.c
@@ -52,20 +52,6 @@ static int ath9k_rng_data_read(struct ath_softc *sc, u32 *buf, u32 buf_size)
 	return j << 2;
 }
 
-static u32 ath9k_rng_delay_get(u32 fail_stats)
-{
-	u32 delay;
-
-	if (fail_stats < 100)
-		delay = 10;
-	else if (fail_stats < 105)
-		delay = 1000;
-	else
-		delay = 10000;
-
-	return delay;
-}
-
 static int ath9k_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 {
 	struct ath_softc *sc = container_of(rng, struct ath_softc, rng_ops);
@@ -80,10 +66,10 @@ static int ath9k_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 			bytes_read += max & 3UL;
 			memzero_explicit(&word, sizeof(word));
 		}
-		if (!wait || !max || likely(bytes_read) || fail_stats > 110)
+		if (!wait || !max || likely(bytes_read) || ++fail_stats >= 100 ||
+		    schedule_timeout_interruptible(HZ / 20) ||
+		    ((current->flags & PF_KTHREAD) && kthread_should_stop()))
 			break;
-
-		msleep_interruptible(ath9k_rng_delay_get(++fail_stats));
 	}
 
 	if (wait && !bytes_read && max)
-- 
2.35.1

