Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD234EF407
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348352AbiDAO4D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352451AbiDAOuW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 10:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB77292B86;
        Fri,  1 Apr 2022 07:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF2A060BAF;
        Fri,  1 Apr 2022 14:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF00C340F2;
        Fri,  1 Apr 2022 14:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648824103;
        bh=E82SV7e6t4GyW9rakvNFtqwmoOj2puq32T+bfxLiQxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvAS1AUpfMcN8KGEI4TgxTw2/09RgD0nZbo67TEoAde4EdWv56WCu3+fgsiSgBKJn
         7dcJQAIuYFczyapXpWifrX8S5qMrMGl/k8DY7fkJuGEtR6s57Nj+C87pLdARX5mxUb
         N76Lg4TxaRql8eUoJTs5zIrq+UyIWU7ZsI6okd54nYyqO4gPGECvQSNABtepQHU+1o
         sljaS5VFkI2ogpvHkaLEcyTTI0uG7w5JaBuvjttRQdVScmWr+dx9DsvBYqCKwbk35/
         9HjwZfuCUZcHOph0uUMgUMna23jGu3xxTCTeyDsDVNX3XmoiAK7YeItfabWVN6dBsB
         exTWiQ3HaaOpg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Deren Wu <deren.wu@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>,
        lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        kvalo@kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, matthias.bgg@gmail.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 88/98] mt76: fix monitor mode crash with sdio driver
Date:   Fri,  1 Apr 2022 10:37:32 -0400
Message-Id: <20220401143742.1952163-88-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401143742.1952163-1-sashal@kernel.org>
References: <20220401143742.1952163-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Deren Wu <deren.wu@mediatek.com>

[ Upstream commit 123bc712b1de0805f9d683687e17b1ec2aba0b68 ]

mt7921s driver may receive frames with fragment buffers. If there is a
CTS packet received in monitor mode, the payload is 10 bytes only and
need 6 bytes header padding after RXD buffer. However, only RXD in the
first linear buffer, if we pull buffer size RXD-size+6 bytes with
skb_pull(), that would trigger "BUG_ON(skb->len < skb->data_len)" in
__skb_pull().

To avoid the nonlinear buffer issue, enlarge the RXD size from 128 to
256 to make sure all MCU operation in linear buffer.

[   52.007562] kernel BUG at include/linux/skbuff.h:2313!
[   52.007578] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[   52.007987] pc : skb_pull+0x48/0x4c
[   52.008015] lr : mt7921_queue_rx_skb+0x494/0x890 [mt7921_common]
[   52.008361] Call trace:
[   52.008377]  skb_pull+0x48/0x4c
[   52.008400]  mt76s_net_worker+0x134/0x1b0 [mt76_sdio 35339a92c6eb7d4bbcc806a1d22f56365565135c]
[   52.008431]  __mt76_worker_fn+0xe8/0x170 [mt76 ef716597d11a77150bc07e3fdd68eeb0f9b56917]
[   52.008449]  kthread+0x148/0x3ac
[   52.008466]  ret_from_fork+0x10/0x30

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4d01fd85283d..6e4d69715927 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -19,7 +19,7 @@
 
 #define MT_MCU_RING_SIZE	32
 #define MT_RX_BUF_SIZE		2048
-#define MT_SKB_HEAD_LEN		128
+#define MT_SKB_HEAD_LEN		256
 
 #define MT_MAX_NON_AQL_PKT	16
 #define MT_TXQ_FREE_THR		32
-- 
2.34.1

