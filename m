Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C451A597
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353499AbiEDQhA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353489AbiEDQg5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 12:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0E146B15
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 09:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82FD661720
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 16:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AEDC385A4;
        Wed,  4 May 2022 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651681999;
        bh=wbusJfoYZehqiS4XJgZraes4GLnlWPmLjAAcZQ2pDaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InCTidC7UEbF1/EziZJGus5yTq7DnbHqhPpAOI+wqExRZjjkmyTqfvKGHqKBg6o0s
         +H6kp6hPI41vN49bdkHUzzt2+AZJM6SeeNcd2SRt3/v8WPPCnQwk5IwtyIvZ/jnHJa
         tuJucmYlexTe35LUBFYql83CDWipt0K4kW3BBO9VVJ+Tl97KVDbENs07ssdeJqinUK
         NTwazla4k4C2Vgac2ra8L5ojL87Qd1Z4ZKZrj/SmfPvALp9faPtkPzRTYDKcvyEVoq
         J55X0xxm0xL/9h93hAU2ZNKvoeU7zUPbUk1ocPUzNzb5TfFQRMNsLNSHBrV4dDfotV
         wDN4Zg3EXBakg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH wireless-next 1/3] wifi: wil6210: switch to netif_napi_add_tx()
Date:   Wed,  4 May 2022 09:33:14 -0700
Message-Id: <20220504163316.549648-2-kuba@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220504163316.549648-1-kuba@kernel.org>
References: <20220504163316.549648-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Switch to the new API not requiring passing in NAPI_POLL_WEIGHT.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kvalo@kernel.org
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ath/wil6210/netdev.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/netdev.c b/drivers/net/wireless/ath/wil6210/netdev.c
index 390648066382..87a88f26233e 100644
--- a/drivers/net/wireless/ath/wil6210/netdev.c
+++ b/drivers/net/wireless/ath/wil6210/netdev.c
@@ -458,16 +458,14 @@ int wil_if_add(struct wil6210_priv *wil)
 		netif_napi_add(&wil->napi_ndev, &wil->napi_rx,
 			       wil6210_netdev_poll_rx_edma,
 			       NAPI_POLL_WEIGHT);
-		netif_tx_napi_add(&wil->napi_ndev,
-				  &wil->napi_tx, wil6210_netdev_poll_tx_edma,
-				  NAPI_POLL_WEIGHT);
+		netif_napi_add_tx(&wil->napi_ndev,
+				  &wil->napi_tx, wil6210_netdev_poll_tx_edma);
 	} else {
 		netif_napi_add(&wil->napi_ndev, &wil->napi_rx,
 			       wil6210_netdev_poll_rx,
 			       NAPI_POLL_WEIGHT);
-		netif_tx_napi_add(&wil->napi_ndev,
-				  &wil->napi_tx, wil6210_netdev_poll_tx,
-				  NAPI_POLL_WEIGHT);
+		netif_napi_add_tx(&wil->napi_ndev,
+				  &wil->napi_tx, wil6210_netdev_poll_tx);
 	}
 
 	wil_update_net_queues_bh(wil, vif, NULL, true);
-- 
2.34.1

