Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B191B729CC6
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241351AbjFIOZX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 10:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241359AbjFIOY6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 10:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109C030E5
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 07:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2B206173E
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 14:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98BCC4339B;
        Fri,  9 Jun 2023 14:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320696;
        bh=SKsI2rnqa095kjtAjcxr/w6BKVrMdzEtqkylAe3qL70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIxXPx56rm7FRXnEbpsgqgp2c2/Qt33KWXmY/nNz9gEEPCMg6Tq1qr9btZWRQq2mF
         ZkNYRXuXwXcxBksUTQhROadVQIEMburjemHDto68zUdubpkrU7MCqAlTSjJXa+soAd
         GGqTAwWfXmg9nxcQGWwTxqYffXCSLGuOVghk9crmh793htf+A6b5bJYp7y8SF7oFal
         pG9Fk5OV5/fgkOIjeJoI8tljtMKEPN3XvrXmxyckCzHbddiRl74NS6ohHl3d/QdKNs
         LrCl/3tRmoqrvQQ+PnwwEov5lNJ5hgbW4HwVuDqHK5acbkM2mad8rjlNOhFj3M+IEQ
         BtMwX27OEzisg==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 12/15] wifi: ath11k: hal: cleanup debug message
Date:   Fri,  9 Jun 2023 17:24:37 +0300
Message-Id: <20230609142440.24643-13-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609142440.24643-1-kvalo@kernel.org>
References: <20230609142440.24643-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Fix the debug message to follow the preferred style.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 148eeb06a906..0a99aa7ddbf4 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1119,7 +1119,7 @@ int ath11k_hal_srng_update_shadow_config(struct ath11k_base *ab,
 					  ring_num);
 
 	ath11k_dbg(ab, ATH11K_DBG_HAL,
-		   "target_reg %x, shadow reg 0x%x shadow_idx 0x%x, ring_type %d, ring num %d",
+		   "update shadow config target_reg %x shadow reg 0x%x shadow_idx 0x%x ring_type %d ring num %d",
 		  target_reg,
 		  HAL_SHADOW_REG(ab, shadow_cfg_idx),
 		  shadow_cfg_idx,
-- 
2.30.2

