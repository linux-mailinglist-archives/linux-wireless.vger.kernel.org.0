Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D3E5152A7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379775AbiD2RuN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 13:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379374AbiD2RuM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 13:50:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8802230F4B
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 10:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39692B83770
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 17:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78A4C385B4;
        Fri, 29 Apr 2022 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651254411;
        bh=UMfk072vUSyhqlFuA6Th86TIcLdnvzSh7cVFGbUysDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y08TARZ3KdzEZQQi1p5Vh0u8NgQbPM7nb+xOv/7oVz4zj6izoXDDBNlPJYXuLNZPO
         sG69KkB5SH6bjkCXdVj+fs1u85Gcn8oGphcTnKMUegTnzvWD7/lK30TUSKZRfoancz
         nglJSHLjnynxOLvEbDpgfsYpv04IpkC0Zc0f7Aase8NqaAOY7PfFd2c4Mtmg6hy11H
         zEPVS9Xl6/4kTTBBlQnHYjiHDSdiUv0TPPH4Mo4Usr7FY6R0ACCq5Equ6AEq2TAMEN
         5hbEZ9eLHVkD4mgnMKV2Q0zC+xB1w7Qm5nvsCdiHWJTzV68NqaTcpiBI5a5y/tBH9b
         apeM8eCRfg1xw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH wireless-next 3/3] wifi: wil6210: use NAPI_POLL_WEIGHT for napi budget
Date:   Fri, 29 Apr 2022 10:46:43 -0700
Message-Id: <20220429174643.196994-4-kuba@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429174643.196994-1-kuba@kernel.org>
References: <20220429174643.196994-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The comment next to WIL6210_NAPI_BUDGET says "arbitrary".
If we're picking arbitrary values let's pick the recommended
default which is NAPI_POLL_WEIGHT.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/wireless/ath/wil6210/netdev.c  | 8 ++++----
 drivers/net/wireless/ath/wil6210/wil6210.h | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/netdev.c b/drivers/net/wireless/ath/wil6210/netdev.c
index 0913f0bf60e7..390648066382 100644
--- a/drivers/net/wireless/ath/wil6210/netdev.c
+++ b/drivers/net/wireless/ath/wil6210/netdev.c
@@ -457,17 +457,17 @@ int wil_if_add(struct wil6210_priv *wil)
 	if (wil->use_enhanced_dma_hw) {
 		netif_napi_add(&wil->napi_ndev, &wil->napi_rx,
 			       wil6210_netdev_poll_rx_edma,
-			       WIL6210_NAPI_BUDGET);
+			       NAPI_POLL_WEIGHT);
 		netif_tx_napi_add(&wil->napi_ndev,
 				  &wil->napi_tx, wil6210_netdev_poll_tx_edma,
-				  WIL6210_NAPI_BUDGET);
+				  NAPI_POLL_WEIGHT);
 	} else {
 		netif_napi_add(&wil->napi_ndev, &wil->napi_rx,
 			       wil6210_netdev_poll_rx,
-			       WIL6210_NAPI_BUDGET);
+			       NAPI_POLL_WEIGHT);
 		netif_tx_napi_add(&wil->napi_ndev,
 				  &wil->napi_tx, wil6210_netdev_poll_tx,
-				  WIL6210_NAPI_BUDGET);
+				  NAPI_POLL_WEIGHT);
 	}
 
 	wil_update_net_queues_bh(wil, vif, NULL, true);
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 11946ecd0b99..22a6eb3e12b7 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -82,7 +82,6 @@ static inline u32 WIL_GET_BITS(u32 x, int b0, int b1)
 #define WIL6210_MAX_TX_RINGS	(24) /* HW limit */
 #define WIL6210_MAX_CID		(20) /* max number of stations */
 #define WIL6210_RX_DESC_MAX_CID	(8)  /* HW limit */
-#define WIL6210_NAPI_BUDGET	(16) /* arbitrary */
 #define WIL_MAX_AMPDU_SIZE	(64 * 1024) /* FW/HW limit */
 #define WIL_MAX_AGG_WSIZE	(32) /* FW/HW limit */
 #define WIL_MAX_AMPDU_SIZE_128	(128 * 1024) /* FW/HW limit */
-- 
2.34.1

