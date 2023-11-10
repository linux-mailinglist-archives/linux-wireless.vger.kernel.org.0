Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D427E7F5A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 18:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjKJRxL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 12:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjKJRwn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1586F28139
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 02:22:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED639C433CA;
        Fri, 10 Nov 2023 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699611732;
        bh=jnbhwmRl5zZlAGHpkM5vY+jFOya5KqTgBO3ldORwj7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRasFlWlr14W9NNPXlOqfKkrUj6oofyQIVxSbSSIMrZzaJPgyA9TGhNzLUUDTA8EZ
         ZRJcC0nqwAQCCr79/WkN2TlCTWFn+TX65preVjb9bDJZzSau3mOJgcgSG3A7K9VWOF
         Ue5mM9QHMSFZ24NUtekXB7GHwpakTktKg7HfWsrncCAMVoDraZPodHswdkRx+wRHIw
         btmNZYUaSi/OpHXhbNBLYjjgBvl1PS4R+AM7GFq3HCLkY4xjyXMNdp8KLpxO2twSQu
         j/lYKVJkAMa3oFP4DAo9j9JWbNtYZA5JQrySGKmzSQeRqBKI3U3kDosEDGZU5IfAks
         rD8ilm6xhHJfQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 6/8] wifi: ath11k: fix warning on DMA ring capabilities event
Date:   Fri, 10 Nov 2023 12:22:00 +0200
Message-Id: <20231110102202.3168243-7-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110102202.3168243-1-kvalo@kernel.org>
References: <20231110102202.3168243-1-kvalo@kernel.org>
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

From: Baochen Qiang <quic_bqiang@quicinc.com>

We are seeing below warning in both reset and suspend/resume scenarios:

[69663.691847] ath11k_pci 0000:02:00.0: Already processed, so ignoring dma ring caps

This is because ab->num_db_cap is not cleared in
ath11k_wmi_free_dbring_caps(), so clear it to avoid such
warnings.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2845b4313d3a..b73d4286f7d3 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4786,6 +4786,7 @@ static void ath11k_wmi_free_dbring_caps(struct ath11k_base *ab)
 {
 	kfree(ab->db_caps);
 	ab->db_caps = NULL;
+	ab->num_db_cap = 0;
 }
 
 static int ath11k_wmi_tlv_dma_ring_caps(struct ath11k_base *ab,
-- 
2.39.2

