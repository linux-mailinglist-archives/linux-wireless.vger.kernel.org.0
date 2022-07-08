Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E9756C058
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiGHRBG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 13:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiGHRBF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 13:01:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FF6E7C
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 10:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC63EB828B5
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 17:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E800BC341C8;
        Fri,  8 Jul 2022 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657299658;
        bh=+V60161RGtW5N2RGODtn5HtAyykE0KHHtN0onZutMI8=;
        h=From:To:Cc:Subject:Date:From;
        b=cEC/oG7yFRU0/FRvOfo7C7WzZc2GgLRYJD/O4TmiOxLmfPGmHCtDV5pDadYB6OElR
         o2CeoIIcC2MPMrFpVMlXaVat5ZAHehqcBA6BvBqdoh5OYNsS3f19Dr07CXLaMkYDFE
         Sb1RqbOFy0cLPSEHL61TSApUnJrpa2R2uDP1Ig9LFSS83Q0EZhS6zFMP5itwNjalvC
         s9D9KgezNa9XQN869q5Zaw1W9voc2BKMBb1hcGFTucGvRTU7cf+dSLXIlvQa1erIcQ
         fGQwFvx/iLH+IPRfgTd5Yxv0KpDvuv37PXS4tLHGv9sN5yfQZDc8cYbW1z0fHTUzLb
         zr7epB7jllrBw==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: mac: fix long line
Date:   Fri,  8 Jul 2022 20:00:52 +0300
Message-Id: <20220708170052.28615-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Recent mac80211 API changes introduced a long line warning in ath11k:

drivers/net/wireless/ath/ath11k/mac.c:1404: line length of 92 exceeds 90 columns

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 17dbc7d9cf29..7f3e9c30cfb0 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1401,7 +1401,8 @@ void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
 	if (!vif->bss_conf.color_change_active && !arvif->bcca_zero_sent)
 		return;
 
-	if (vif->bss_conf.color_change_active && ieee80211_beacon_cntdwn_is_complete(vif)) {
+	if (vif->bss_conf.color_change_active &&
+	    ieee80211_beacon_cntdwn_is_complete(vif)) {
 		arvif->bcca_zero_sent = true;
 		ieee80211_color_change_finish(vif);
 		return;

base-commit: f6bb3df74ceb88929dd7e09170ec156ac2e5d809
-- 
2.30.2

