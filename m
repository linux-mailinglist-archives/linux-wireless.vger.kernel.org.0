Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B546C669A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 12:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCWLcW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 07:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCWLcU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 07:32:20 -0400
Received: from out-15.mta1.migadu.com (out-15.mta1.migadu.com [IPv6:2001:41d0:203:375::f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B75126EF
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 04:32:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679570783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rFrZeFL95bAADeoxTVP7Nzd5sq/6QShfuHH0D38gefI=;
        b=iieSNHbLTfna/AJWw4ifxYEls++cBF9dlNm9peQh4RNpnr/S41QQfmoR6P1mfO93mmDEm/
        sUOXphPRjd2lfzh8OKjD0eTzs73xofcjuI6u/1+T2KsrkL9xXCatCQFGOu976gs0BeEbgp
        oYmUYiuMI5+e3DM0+fDsGgf8JSQ62BM=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
Subject: [PATCH 1/5] wifi: ath11k: Remove redundant pci_clear_master
Date:   Thu, 23 Mar 2023 19:26:09 +0800
Message-Id: <20230323112613.7550-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove pci_clear_master to simplify the code,
the bus-mastering is also cleared in do_pci_disable_device,
like this:
./drivers/pci/pci.c:2197
static void do_pci_disable_device(struct pci_dev *dev)
{
	u16 pci_command;

	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
	if (pci_command & PCI_COMMAND_MASTER) {
		pci_command &= ~PCI_COMMAND_MASTER;
		pci_write_config_word(dev, PCI_COMMAND, pci_command);
	}

	pcibios_disable_device(dev);
}.
And dev->is_busmaster is set to 0 in pci_disable_device.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/net/wireless/ath/ath11k/pci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 0aeef2948ff5..522d01e5e11c 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -540,7 +540,7 @@ static int ath11k_pci_claim(struct ath11k_pci *ab_pci, struct pci_dev *pdev)
 	if (!ab->mem) {
 		ath11k_err(ab, "failed to map pci bar %d\n", ATH11K_PCI_BAR_NUM);
 		ret = -EIO;
-		goto clear_master;
+		goto release_region;
 	}
 
 	ab->mem_ce = ab->mem;
@@ -548,8 +548,6 @@ static int ath11k_pci_claim(struct ath11k_pci *ab_pci, struct pci_dev *pdev)
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot pci_mem 0x%pK\n", ab->mem);
 	return 0;
 
-clear_master:
-	pci_clear_master(pdev);
 release_region:
 	pci_release_region(pdev, ATH11K_PCI_BAR_NUM);
 disable_device:
@@ -565,7 +563,6 @@ static void ath11k_pci_free_region(struct ath11k_pci *ab_pci)
 
 	pci_iounmap(pci_dev, ab->mem);
 	ab->mem = NULL;
-	pci_clear_master(pci_dev);
 	pci_release_region(pci_dev, ATH11K_PCI_BAR_NUM);
 	if (pci_is_enabled(pci_dev))
 		pci_disable_device(pci_dev);
-- 
2.34.1

