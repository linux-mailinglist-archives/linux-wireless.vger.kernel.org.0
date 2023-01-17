Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9A66DFD5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 15:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjAQODP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 09:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjAQODO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 09:03:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EF539B95
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 06:03:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92C3561466
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E0BC433D2;
        Tue, 17 Jan 2023 14:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673964193;
        bh=jOq3HAgMjaj1SFCSBHKjYOyCtvfDE2riyu3cWxH+X7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lza//oB5cDF78ePfrd+9Qvn71DcdGRYU3gX5qZHtSMcIy3yYsIuGE6iI8n3/cHMpc
         5bl9aGv5Uo3k5rpdswyUerNa/TGrRPu/zRlrfpbEuzIvxiPwMVS4Xw7PIPaaW0GBD4
         7egJVF/FmG/ocOvR+7lLbRpiMRM1j+6J2zmnpOPxcPret62HZdNJTRO8gvBv132XUU
         4yiAS8PxSm5WtzYnfAZTRczOtbM+ChjJKVJ644HX8UcNBs7Nflg/0ofY48Bb8ABphA
         5kI9j33jRFeP2y4y7LHhTLL0qjXG+CfcbmiNM71jnfnuIS6cm3nEm72S/cqPJ7nM/k
         wr2FcMqY+0Djg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sujuan.chen@mediatek.com
Subject: [PATCH v2 2/4] wifi: mt76: dma: reset wed queues in mt76_dma_rx_reset
Date:   Tue, 17 Jan 2023 15:02:54 +0100
Message-Id: <16202ff5289742d3deb2c6bd7130911e33ab551a.1673963962.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673963962.git.lorenzo@kernel.org>
References: <cover.1673963962.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sujuan Chen <sujuan.chen@mediatek.com>

This is a preliminary patch to introduce proper wed reset support.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 5629b949fac0..93c42082f1c2 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -766,8 +766,13 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 		q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
 
 	mt76_dma_rx_cleanup(dev, q);
-	mt76_dma_sync_idx(dev, q);
-	mt76_dma_rx_fill(dev, q, false);
+
+	/* reset WED rx queues */
+	mt76_dma_wed_setup(dev, q, true);
+	if (q->flags != MT_WED_Q_TXFREE) {
+		mt76_dma_sync_idx(dev, q);
+		mt76_dma_rx_fill(dev, q, false);
+	}
 }
 
 static void
-- 
2.39.0

