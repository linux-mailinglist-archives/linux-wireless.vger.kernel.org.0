Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5D6798CEB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 20:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbjIHSTM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Sep 2023 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344044AbjIHSSe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Sep 2023 14:18:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A5A2111;
        Fri,  8 Sep 2023 11:18:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B763C116CA;
        Fri,  8 Sep 2023 18:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196968;
        bh=9/PnDo7PI+SMCeuDLvQ08bsQaRciDUxuttuBzW6Z/z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sk+Gp5OU/4e0PSAG3KXFH6xdfZzN93rs23C8mwPKmDZaUyXwYc0pnFp44e0Jw6lMe
         FWAAuThuutOAoS2Epnq/8DSiuf3R+KAWYGOUIByXbrSEINi2gbTP8kMs86NRTk98aw
         9YOd2F5mYfugHig/yosJdssbbfbz+cnLueBUNiVyVKem0aCXvHTT4E6pgrbbBTDuhf
         PSu8qkuggWCvAyhrhkBYBOQaklazjg8nlpvaBucSCFvyuNX0MkGWzky9KDK1iR5Wbe
         lGAFSA7mMxPs/a7tpJaT/v+rnr+3fvMRr4+VIR5VTbqUBL4CpTWSrbCQA08tmHT/jq
         B9f7r/3oqY1ig==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 06/41] wifi: ath9k: fix printk specifier
Date:   Fri,  8 Sep 2023 14:15:20 -0400
Message-Id: <20230908181555.3459640-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dongliang Mu <dzm91@hust.edu.cn>

[ Upstream commit 061115fbfb2ce5870c9a004d68dc63138c07c782 ]

Smatch reports:

ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer

Fix it by modifying %lx to %p in the printk format string.

Note that with this change, the pointer address will be printed as a
hashed value by default. This is appropriate because the kernel
should not leak kernel pointers to user space in an informational
message. If someone wants to see the real address for debugging
purposes, this can be achieved with the no_hash_pointers kernel option.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230723040403.296723-1-dzm91@hust.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 4 ++--
 drivers/net/wireless/ath/ath9k/pci.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 9cd12b20b18d8..9bfaadfa6c009 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -132,8 +132,8 @@ static int ath_ahb_probe(struct platform_device *pdev)
 
 	ah = sc->sc_ah;
 	ath9k_hw_name(ah, hw_name, sizeof(hw_name));
-	wiphy_info(hw->wiphy, "%s mem=0x%lx, irq=%d\n",
-		   hw_name, (unsigned long)mem, irq);
+	wiphy_info(hw->wiphy, "%s mem=0x%p, irq=%d\n",
+		   hw_name, mem, irq);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index a09f9d223f3de..0633589b85c23 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -988,8 +988,8 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	sc->sc_ah->msi_reg = 0;
 
 	ath9k_hw_name(sc->sc_ah, hw_name, sizeof(hw_name));
-	wiphy_info(hw->wiphy, "%s mem=0x%lx, irq=%d\n",
-		   hw_name, (unsigned long)sc->mem, pdev->irq);
+	wiphy_info(hw->wiphy, "%s mem=0x%p, irq=%d\n",
+		   hw_name, sc->mem, pdev->irq);
 
 	return 0;
 
-- 
2.40.1

