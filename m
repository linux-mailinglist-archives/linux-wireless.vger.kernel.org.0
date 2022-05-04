Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749E051A599
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353494AbiEDQhC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 12:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353501AbiEDQhA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 12:37:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087D746B1E
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 09:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 408D6B82794
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 16:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C381CC385A5;
        Wed,  4 May 2022 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651682001;
        bh=si/jNKIZjWSD/yUoWGMbT7rlQSbsfPJ27eDg3wHOTDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1LQ1trrmK7l2ixEtDc9/JShSJkVrmkvVHDTlNjwgic9sYRN91ix7vzGkH96Irq1i
         NGhO8krj95jR0BZbXM+wdZ+32Gw5pP6CSqOucLiaerzRgBnhAIg/VjitPi9D8Q68Im
         Pp0g2ObO7BWRbhrZyemeWxLiVA3c6nITQI+Ry+eZ3oTvnoaPvvxV9O76EO+MEPKf+/
         ERY8mzUAoonEoBmzymzRJDV++7qpW+8+q5VjJwlUz4ksngfq2nuKP6s76jhXjivF3C
         xryWO9K26jOtIhxcdnPQxP/uLltYCR6S6DcugjwnP5jDxaL3Omr6hebK7MaZdIJBCg
         E/xjyoxFqoZZQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        imitsyanko@quantenna.com, geomatsi@gmail.com
Subject: [PATCH wireless-next 3/3] wifi: qtnfmac: switch to netif_napi_add_weight()
Date:   Wed,  4 May 2022 09:33:16 -0700
Message-Id: <20220504163316.549648-4-kuba@kernel.org>
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

qtnfmac chooses its own magic NAPI weight so switch to the new
API created for those who don't use NAPI_POLL_WEIGHT.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: imitsyanko@quantenna.com
CC: geomatsi@gmail.com
CC: kvalo@kernel.org
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c | 4 ++--
 drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
index 840728ed57b2..8c23a77d1671 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
@@ -1146,8 +1146,8 @@ static int qtnf_pcie_pearl_probe(struct qtnf_bus *bus, unsigned int tx_bd_size,
 	}
 
 	tasklet_setup(&ps->base.reclaim_tq, qtnf_pearl_reclaim_tasklet_fn);
-	netif_napi_add(&bus->mux_dev, &bus->mux_napi,
-		       qtnf_pcie_pearl_rx_poll, 10);
+	netif_napi_add_weight(&bus->mux_dev, &bus->mux_napi,
+			      qtnf_pcie_pearl_rx_poll, 10);
 
 	ipc_int.fn = qtnf_pcie_pearl_ipc_gen_ep_int;
 	ipc_int.arg = ps;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
index 9534e1b33780..d83362578374 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
@@ -1159,8 +1159,8 @@ static int qtnf_pcie_topaz_probe(struct qtnf_bus *bus,
 	}
 
 	tasklet_setup(&ts->base.reclaim_tq, qtnf_reclaim_tasklet_fn);
-	netif_napi_add(&bus->mux_dev, &bus->mux_napi,
-		       qtnf_topaz_rx_poll, 10);
+	netif_napi_add_weight(&bus->mux_dev, &bus->mux_napi,
+			      qtnf_topaz_rx_poll, 10);
 
 	ipc_int.fn = qtnf_topaz_ipc_gen_ep_int;
 	ipc_int.arg = ts;
-- 
2.34.1

