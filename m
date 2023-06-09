Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B196729CBE
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 16:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbjFIOYr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbjFIOYq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 10:24:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D530F6
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 07:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A0FB612DC
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 14:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14429C433D2;
        Fri,  9 Jun 2023 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320684;
        bh=UaJWYbBerV1+c0yzKaM0ZSFmcF3N7Eb/Hwya0EflQhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Co0fOLUR91I1KLFbrxWdB90ygZFhi0sjHYmQgwZU/5gsIkXiX4n8UR6MYYdvUwxRN
         MqOpO5KkrgZ5DeFzg7dSmRJz27LdiT6YS6O1DooO9PpY6djP+VWRdWNXQMpvjQqbs6
         h/KtaZ2oez/eZak1/pf0U87rxWnUnkL6bANmTMllsrcRfm3rDj4h8M8s2hywLFUuHR
         UdWgyomS3WHt2SdBj5v3GuTWSRAmV7f5cx+s0TRswGqxUILiVRNRBL5+tMuURrCMN8
         2shph3bbhgWpSQs1pu6JhbM/wvg6xpnTucKoYuuqv28xlsBsdFnzZwrKckMs6tqbfT
         WD6DkEnaRDraw==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 01/15] wifi: ath11k: debug: remove unused ATH11K_DBG_ANY
Date:   Fri,  9 Jun 2023 17:24:26 +0300
Message-Id: <20230609142440.24643-2-kvalo@kernel.org>
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

It's not used anywhere so can be easily removed.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index 621d85f3118c..0a9418c36bf4 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -26,7 +26,6 @@ enum ath11k_debug_mask {
 	ATH11K_DBG_PCI		= 0x00001000,
 	ATH11K_DBG_DP_TX	= 0x00002000,
 	ATH11K_DBG_DP_RX	= 0x00004000,
-	ATH11K_DBG_ANY		= 0xffffffff,
 };
 
 __printf(2, 3) void ath11k_info(struct ath11k_base *ab, const char *fmt, ...);
-- 
2.30.2

