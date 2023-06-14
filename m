Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC0A72F4EE
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 08:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbjFNGfj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 02:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243281AbjFNGfH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 02:35:07 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75971709;
        Tue, 13 Jun 2023 23:33:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id ECD893FE8F;
        Wed, 14 Jun 2023 06:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686724426;
        bh=+hqis1W8nQ4EkQUmco7jTscaaZbuSwY0XCyi+/U9QfM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=wIVM1sNd+ojHp6usjuvn93Ejfp9bdZeFSaG46lVPT9zOIp8wytXooK36JiMTSSn0l
         2eDxchP16vkMHZh9WMeLMOU2uMYGl2IC72DT9wEtoCN8kE1SKDZyKISm6VclhVjH/K
         pM7P3JTy9iTfu8Met2cxNQk3SUybNSvxw4H3B5ZkrdBYvUX6a3HdEqTVRdIWGKE4bN
         cGy0m6IQJBwBfD+iG9SDVbKk8b6BQnCCFks9n+yETD6WkkbiY/dOe28fNPPKk/AY1w
         t7LdI6MxufhU+CLvZ7/233P6hdL4RZwqhDqF6cvYqn1aXRlc7irfxVq2mCg44OOzkJ
         Wu9959Z93e1Kg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: mt7921e: Perform FLR to recovery the device
Date:   Wed, 14 Jun 2023 14:32:50 +0800
Message-Id: <20230614063252.1650824-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When "Pre-boot WiFi" is enabled in BIOS, the mt7921e device may not
work:
mt7921e 0000:02:00.0: ASIC revision: 79220010
mt7921e 0000:02:00.0: Message 00000010 (seq 1) timeout
mt7921e 0000:02:00.0: Failed to get patch semaphore
mt7921e 0000:02:00.0: Message 00000010 (seq 2) timeout
mt7921e 0000:02:00.0: Failed to get patch semaphore
mt7921e 0000:02:00.0: Message 00000010 (seq 3) timeout
mt7921e 0000:02:00.0: Failed to get patch semaphore
mt7921e 0000:02:00.0: Message 00000010 (seq 4) timeout
mt7921e 0000:02:00.0: Failed to get patch semaphore
mt7921e 0000:02:00.0: Message 00000010 (seq 5) timeout
mt7921e 0000:02:00.0: Failed to get patch semaphore
mt7921e 0000:02:00.0: Message 00000010 (seq 6) timeout
mt7921e 0000:02:00.0: Failed to get patch semaphore
mt7921e 0000:02:00.0: Message 00000010 (seq 7) timeout
mt7921e 0000:02:00.0: Failed to get patch semaphore
mt7921e 0000:02:00.0: Message 00000010 (seq 8) timeout
mt7921e 0000:02:00.0: Failed to get patch semaphore
mt7921e 0000:02:00.0: Message 00000010 (seq 9) timeout
mt7921e 0000:02:00.0: Failed to get patch semaphore
mt7921e 0000:02:00.0: Message 00000010 (seq 10) timeout
mt7921e 0000:02:00.0: Failed to get patch semaphore
mt7921e 0000:02:00.0: hardware init failed

After some trials and errors, it shows that PCI function level reset can
recover the device back to a functional state.

So perform FLR at probe routine to workaround the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index ddb1fa4ee01d..9671fbe35a8e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -262,6 +262,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	int ret;
 	u16 cmd;
 
+	ret = pci_reset_function_locked(pdev);
+	if (ret)
+		pci_info(pdev, "Unable to perform FLR\n");
+
 	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ret;
-- 
2.34.1

