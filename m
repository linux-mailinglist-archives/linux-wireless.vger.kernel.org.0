Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B857D3CC3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 18:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjJWQlZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJWQlZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 12:41:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638098F
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 09:41:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F4BC433C8;
        Mon, 23 Oct 2023 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698079283;
        bh=WAm74M7mbG38lwboqiQzFnKHRrC1aVyJgkBL0L2vwCk=;
        h=From:To:Cc:Subject:Date:From;
        b=fNrVnAGg0i2rOZZlBmfXG296ACi0jqjRnyBSyE6MKU7LpFq/0GDHqLDM4zwvdL4rE
         NDYhEp16ThDgBcnTa0XDOI6KXaGjVvn1uxHE0Pir5z7i1TXQBQ5lwceSm9i+BvXu3v
         0wwDJNO0i5w36JEZkkL1k9PGE1/1HUEzat2vRIPsRzHje/IoF058gKyvbchM67/TOC
         0+nUAOYPuS7tvo5RlVRxr/9NAMtARBpy/aq8KCyJTTDDlsB/KXEcBv+BoutdGIupPt
         loZeJWhykrGOAUUmitv681PfTt4LWJB78r+cieWE/rXQ7LR6VTitCFptSw+5IHUUHh
         ibHbgj8lF5DmA==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] Revert "wifi: ath11k: call ath11k_mac_fils_discovery() without condition"
Date:   Mon, 23 Oct 2023 19:41:20 +0300
Message-Id: <20231023164120.651151-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

This reverts commit e149353e6562f3e3246f75dfc4cca6a0cc5b4efc. The commit caused
QCA6390 hw2.0 firmware WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1 to crash
during disconnect:

[71990.787525] ath11k_pci 0000:72:00.0: firmware crashed: MHI_CB_EE_RDDM

Closes: https://lore.kernel.org/all/87edhu3550.fsf@kernel.org/
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ec46e2ee6ddf..7f7b39817773 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3732,7 +3732,9 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 	}
 
-	ath11k_mac_fils_discovery(arvif, info);
+	if (changed & BSS_CHANGED_FILS_DISCOVERY ||
+	    changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP)
+		ath11k_mac_fils_discovery(arvif, info);
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
 		ipv4_cnt = min(vif->cfg.arp_addr_cnt, ATH11K_IPV4_MAX_COUNT);

base-commit: 5b6e11406d5c198c402e8b7f7085a8c229198ba4
-- 
2.39.2

