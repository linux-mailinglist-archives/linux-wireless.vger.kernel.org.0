Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B314B2B82
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 18:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiBKROR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 12:14:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242158AbiBKROQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 12:14:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764212E8
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 09:14:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20A68B82B0E
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 17:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045D8C340EF;
        Fri, 11 Feb 2022 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644599652;
        bh=UgDFQyXqvdtue64DlUBPULkSMEr9ov6JGcOAoODkMZw=;
        h=From:To:Cc:Subject:Date:From;
        b=avWQJt7PV7SaiKyHOrG8+ZcGhlhPqSxs/iZGLoG9PGQDtC3Am6EIkR51+r/ueycEd
         uuyLCF4zV9R+tUht2vNXN8uIHZX5labiGbLrlZu4u8PAlREaPrfbkKSGflMysWoM2S
         OGaMWa9GCEdQT2+/5T8azCwU5NV+ncpjyCa9tl/HmO8QClZq7Mxn966QwgMs4dJWuY
         LRs4nirRYjCKzVtXUnrJPRmd7kWL962IXsgsz+iDmB4FAMzmcehuROxt4CP2WXAz+2
         OT8EHpP0FH9TfORO2cBBzhRO0zPn8xHI6zfu/wNKmzMJTEIQWuGUs8tPCppQjp/cx+
         yc2A+FwoDGYpg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: fix endianness warnings in mt7915_mac_tx_free()
Date:   Fri, 11 Feb 2022 18:14:00 +0100
Message-Id: <b40f1cae33f04001e1531bac31671583555d46bb.1644599600.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning in mt7915_mac_tx_free routine:
warning: incorrect type in assignment (different base types)
   expected unsigned int [usertype] *cur_info
   got restricted __le32 *
   warning: cast to restricted __le32

Fixes: c17780e7b21ec ("mt76: mt7915: add txfree event v3")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 713e534bf946..631928cd0e9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1433,7 +1433,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 	bool v3, wake = false;
 	u16 total, count = 0;
 	u32 txd = le32_to_cpu(free->txd);
-	u32 *cur_info;
+	__le32 *cur_info;
 
 	/* clean DMA queues and unmap buffers first */
 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
-- 
2.34.1

