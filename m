Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D1E74C54F
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jul 2023 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjGIPPn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jul 2023 11:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjGIPPD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jul 2023 11:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBC71BE;
        Sun,  9 Jul 2023 08:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BBD360C13;
        Sun,  9 Jul 2023 15:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAE5C433C8;
        Sun,  9 Jul 2023 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915657;
        bh=/rno5ne+sKJjosGqkgyrU/dv8tH/5zQ/xDXZ8DfHoG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zl9I92LLgMIJjG/NJgCaeLwq9ABxATqiJhAzd5smam6mJ+i/G1INegNbR0trqoy5M
         KhYiZO75p6dGhDjMbMFAeMNzAmcBP+I8UJ7sRVnB3+rz82+iEgYSzQZxf5RussCGyV
         P40RIbZLqS0e6nV0FCpDHUAM4vLg5kKahI/rzLgL+jXrzX9R2kiEuv+8/pr2Bfgfjk
         v9lgWog1jg1D7S8E50XCC2Bbpasrt+0Ax80ZOc3puLi7LYUOApRT8RwEqBGsBU/AZ5
         +7UFeZiB9Xb4z4qU9QOONKJEzsifjoMzL8XkWfw2rX74dHnIP23gckNzFA1LpvEkEY
         f6dJzhBC90qyg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Balamurugan S <quic_bselvara@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 12/22] wifi: ath12k: Avoid NULL pointer access during management transmit cleanup
Date:   Sun,  9 Jul 2023 11:13:46 -0400
Message-Id: <20230709151356.513279-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151356.513279-1-sashal@kernel.org>
References: <20230709151356.513279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Balamurugan S <quic_bselvara@quicinc.com>

[ Upstream commit 054b5580a36e435692c203c19abdcb9f7734320e ]

Currently 'ar' reference is not added in skb_cb.
Though this is generally not used during transmit completion
callbacks, on interface removal the remaining idr cleanup callback
uses the ar pointer from skb_cb from management txmgmt_idr. Hence fill them
during transmit call for proper usage to avoid NULL pointer dereference.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230518071046.14337-1-quic_bselvara@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index bf7e5b6977b27..ff9f9c84129bc 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4366,6 +4366,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_vif *arvif,
 	int buf_id;
 	int ret;
 
+	ATH12K_SKB_CB(skb)->ar = ar;
 	spin_lock_bh(&ar->txmgmt_idr_lock);
 	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
 			   ATH12K_TX_MGMT_NUM_PENDING_MAX, GFP_ATOMIC);
-- 
2.39.2

