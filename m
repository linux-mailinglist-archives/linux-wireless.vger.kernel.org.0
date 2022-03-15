Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5944D9F67
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 16:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiCOP4O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 11:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiCOP4N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 11:56:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B4765AE
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 08:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3523B81754
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 15:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C2BC340E8;
        Tue, 15 Mar 2022 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647359698;
        bh=H3Iw5/Cg0bzJmoFidn/e7FTnqwyY28fUPOy9FOkimFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LK+RgA5mbDMic1HtoNJvgug5sX3qdo+inR9ceVfyYjence1kZvB0R/DV1Ku5YTKRt
         aCUno2qSuAL3kLL8LRKGWZX6rCKYNrK6tq7qLNaWTBXQcPZl3ycCqZK80FMSNtYQH5
         Ee5A5b/g2XH1Qxq8Km0Rd0QWmT93kpRASc3/433uy810h5JthFjkFa++VLEzqFsAet
         uAPxWVaDknZpanff+xAs0+L+Ic3NL2I2ArJYPVse1IQRo808+nAgEfbb6IAnhXWKl8
         VGQnVMmsmQ55ykRP8F+zac5379+iQLKtkY4keLNCoB8oeZ7T++54e7Dzlf2gh4vl5R
         TbGk7yl4hBlTw==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] Revert "ath10k: drop beacon and probe response which leak from other channel"
Date:   Tue, 15 Mar 2022 17:54:55 +0200
Message-Id: <20220315155455.20446-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

This reverts commit 3bf2537ec2e33310b431b53fd84be8833736c256.

I was reported privately that this commit breaks AP and mesh mode on QCA9984
(firmware 10.4-3.9.0.2-00156). So revert the commit to fix the regression.

There was a conflict due to cfg80211 API changes but that was easy to fix.

Fixes: 3bf2537ec2e3 ("ath10k: drop beacon and probe response which leak from other channel")
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 33 +--------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 62c453a21e49..7c1c2658cb5f 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2611,36 +2611,9 @@ int ath10k_wmi_event_mgmt_rx(struct ath10k *ar, struct sk_buff *skb)
 		ath10k_mac_handle_beacon(ar, skb);
 
 	if (ieee80211_is_beacon(hdr->frame_control) ||
-	    ieee80211_is_probe_resp(hdr->frame_control)) {
-		struct ieee80211_mgmt *mgmt = (void *)skb->data;
-		enum cfg80211_bss_frame_type ftype;
-		u8 *ies;
-		int ies_ch;
-
+	    ieee80211_is_probe_resp(hdr->frame_control))
 		status->boottime_ns = ktime_get_boottime_ns();
 
-		if (!ar->scan_channel)
-			goto drop;
-
-		ies = mgmt->u.beacon.variable;
-
-		if (ieee80211_is_beacon(mgmt->frame_control))
-			ftype = CFG80211_BSS_FTYPE_BEACON;
-		else
-			ftype = CFG80211_BSS_FTYPE_PRESP;
-
-		ies_ch = cfg80211_get_ies_channel_number(mgmt->u.beacon.variable,
-							 skb_tail_pointer(skb) - ies,
-							 sband->band, ftype);
-
-		if (ies_ch > 0 && ies_ch != channel) {
-			ath10k_dbg(ar, ATH10K_DBG_MGMT,
-				   "channel mismatched ds channel %d scan channel %d\n",
-				   ies_ch, channel);
-			goto drop;
-		}
-	}
-
 	ath10k_dbg(ar, ATH10K_DBG_MGMT,
 		   "event mgmt rx skb %pK len %d ftype %02x stype %02x\n",
 		   skb, skb->len,
@@ -2654,10 +2627,6 @@ int ath10k_wmi_event_mgmt_rx(struct ath10k *ar, struct sk_buff *skb)
 	ieee80211_rx_ni(ar->hw, skb);
 
 	return 0;
-
-drop:
-	dev_kfree_skb(skb);
-	return 0;
 }
 
 static int freq_to_idx(struct ath10k *ar, int freq)

base-commit: e6e91ec966db5af4f059cfbac1af06560404b317
-- 
2.30.2

