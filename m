Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22CC6F7521
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 21:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjEDT4a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 15:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjEDTyg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 15:54:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A19AD22;
        Thu,  4 May 2023 12:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81342637DA;
        Thu,  4 May 2023 19:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8855C4339C;
        Thu,  4 May 2023 19:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229682;
        bh=ANj1/Mdt11UKjqOjZLYLvGkukMF6iBUj/697rQNawaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bs/+x8yfpnrck5YNa6JgTsrXiD7eS1JQlxdfM5PXXcQ3kZYufu+OOLNkandS+nWcV
         cRAINo57BXlLWb+AtEE838WsqKGFHUz/Z8BZM//LeWL+CXINU5aXmxyhtzMQvXQjiH
         v9iizTS5Dmup36eKeqpg7Nzvd4hOBpng4Jxkl6PgCqeMWgjCTeirfbfvllC2bTB22v
         jp1uCK7qszYt0ll4pb2BziQuCstrP73T/+jr0s0m+faFWswXqlY1TtAnBE/ngoNb/y
         F0yZcjWbG7zqVn+Cu4HOz3I4W5ByCbVvYAXX2Ukk1IPyCNp96CT6RebIKzUkkipbFh
         LK7pjxrTYr1ew==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nagarajan Maran <quic_nmaran@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 37/49] wifi: ath11k: Fix SKB corruption in REO destination ring
Date:   Thu,  4 May 2023 15:46:14 -0400
Message-Id: <20230504194626.3807438-37-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194626.3807438-1-sashal@kernel.org>
References: <20230504194626.3807438-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nagarajan Maran <quic_nmaran@quicinc.com>

[ Upstream commit f9fff67d2d7ca6fa8066132003a3deef654c55b1 ]

While running traffics for a long time, randomly an RX descriptor
filled with value "0" from REO destination ring is received.
This descriptor which is invalid causes the wrong SKB (SKB stored in
the IDR lookup with buffer id "0") to be fetched which in turn
causes SKB memory corruption issue and the same leads to crash
after some time.

Changed the start id for idr allocation to "1" and the buffer id "0"
is reserved for error validation. Introduced Sanity check to validate
the descriptor, before processing the SKB.

Crash Signature :

Unable to handle kernel paging request at virtual address 3f004900
PC points to "b15_dma_inv_range+0x30/0x50"
LR points to "dma_cache_maint_page+0x8c/0x128".
The Backtrace obtained is as follows:
[<8031716c>] (b15_dma_inv_range) from [<80313a4c>] (dma_cache_maint_page+0x8c/0x128)
[<80313a4c>] (dma_cache_maint_page) from [<80313b90>] (__dma_page_dev_to_cpu+0x28/0xcc)
[<80313b90>] (__dma_page_dev_to_cpu) from [<7fb5dd68>] (ath11k_dp_process_rx+0x1e8/0x4a4 [ath11k])
[<7fb5dd68>] (ath11k_dp_process_rx [ath11k]) from [<7fb53c20>] (ath11k_dp_service_srng+0xb0/0x2ac [ath11k])
[<7fb53c20>] (ath11k_dp_service_srng [ath11k]) from [<7f67bba4>] (ath11k_pci_ext_grp_napi_poll+0x1c/0x78 [ath11k_pci])
[<7f67bba4>] (ath11k_pci_ext_grp_napi_poll [ath11k_pci]) from [<807d5cf4>] (__napi_poll+0x28/0xb8)
[<807d5cf4>] (__napi_poll) from [<807d5f28>] (net_rx_action+0xf0/0x280)
[<807d5f28>] (net_rx_action) from [<80302148>] (__do_softirq+0xd0/0x280)
[<80302148>] (__do_softirq) from [<80320408>] (irq_exit+0x74/0xd4)
[<80320408>] (irq_exit) from [<803638a4>] (__handle_domain_irq+0x90/0xb4)
[<803638a4>] (__handle_domain_irq) from [<805bedec>] (gic_handle_irq+0x58/0x90)
[<805bedec>] (gic_handle_irq) from [<80301a78>] (__irq_svc+0x58/0x8c)

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230403191533.28114-1-quic_nmaran@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 1786d83f8f2ed..38be646bc0214 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -389,10 +389,10 @@ int ath11k_dp_rxbufs_replenish(struct ath11k_base *ab, int mac_id,
 			goto fail_free_skb;
 
 		spin_lock_bh(&rx_ring->idr_lock);
-		buf_id = idr_alloc(&rx_ring->bufs_idr, skb, 0,
-				   rx_ring->bufs_max * 3, GFP_ATOMIC);
+		buf_id = idr_alloc(&rx_ring->bufs_idr, skb, 1,
+				   (rx_ring->bufs_max * 3) + 1, GFP_ATOMIC);
 		spin_unlock_bh(&rx_ring->idr_lock);
-		if (buf_id < 0)
+		if (buf_id <= 0)
 			goto fail_dma_unmap;
 
 		desc = ath11k_hal_srng_src_get_next_entry(ab, srng);
@@ -2665,6 +2665,9 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 				   cookie);
 		mac_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_PDEV_ID, cookie);
 
+		if (unlikely(buf_id == 0))
+			continue;
+
 		ar = ab->pdevs[mac_id].ar;
 		rx_ring = &ar->dp.rx_refill_buf_ring;
 		spin_lock_bh(&rx_ring->idr_lock);
-- 
2.39.2

