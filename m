Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DF06D77B4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 11:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbjDEJEf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 05:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbjDEJEb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 05:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC74171A
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 02:04:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 729846254E
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 09:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118FDC4339C;
        Wed,  5 Apr 2023 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680685468;
        bh=dXbpBAkd76lyuS9ClysGa5XOzVAb4r9ONCYrH5D+Juc=;
        h=From:To:Cc:Subject:Date:From;
        b=UOR8+hhoML7+N4bu+AC9mx9nSD2a5ppMkZSBuEjV3ivgysVQynBdAeh33FMdmlwCh
         ZiNxjwNom7W0mHmKRJ+EAlRcvQAJGz+qj3ZzaEnLFSL1mIcveArluS0G+qRum4GUrm
         7BSecbQe0oqFD2NugI+nSLcLc+HkfBOokMCvoJ4vr2zi+/6G9VafX/ImOr20/38IOg
         ZAveDuXBNh11AoKMWTS/KWjHFMmSYPmADIMv1Y9wPymPytoNH17/4cN8wSjF11njrg
         VmYJD0uQnacnFPqgtUBVBcaX9JbZnp/1t3mjSOXcvkawKTwqf77/KbpC4kXGtipACK
         iZ2MyiqJWsa5w==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath11k: print a warning when crypto_alloc_shash() fails
Date:   Wed,  5 Apr 2023 12:04:25 +0300
Message-Id: <20230405090425.1351-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Christoph reported that ath11k failed to initialise when michael_mic.ko
module was not installed. To make it easier to notice that case print a
warning when crypto_alloc_shash() fails.

Compile tested only.

Reported-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/all/20221130133016.GC3055@lst.de/
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 99859b59138e..d22e5349c551 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3106,8 +3106,11 @@ int ath11k_peer_rx_frag_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id
 	int i;
 
 	tfm = crypto_alloc_shash("michael_mic", 0, 0);
-	if (IS_ERR(tfm))
+	if (IS_ERR(tfm)) {
+		ath11k_warn(ab, "failed to allocate michael_mic shash: %ld\n",
+			    PTR_ERR(tfm));
 		return PTR_ERR(tfm);
+	}
 
 	spin_lock_bh(&ab->base_lock);
 

base-commit: bea046575a2e6d7d1cf63cc7ab032647a3585de5
-- 
2.30.2

