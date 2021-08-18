Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC1D3F0E9A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 01:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhHRX1i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 19:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhHRX1h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 19:27:37 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25909C061764
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 16:27:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14c:485:504a:609d:5443:34fc:77bc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0CFCF80F30;
        Thu, 19 Aug 2021 01:26:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1629329218;
        bh=s6e4Ese2VIMrxJ7iyVt3pQ+bRy1WssQdFGiizMnyVWk=;
        h=From:To:Cc:Subject:Date:From;
        b=mwvQKN49+SlILw9eldAn08MYYfTq53nQl3gjlkAAMYN9FUKZjnC9argrZkh8PWVTx
         YNPO5HXYi/UW1CbDRRe8SgiRRxjacfypwvR4RthdJ97IBIP3KQNF/906udRu46nD2q
         //fzsgtjaC1LGvBWilFGCDfASX7rDVYXb2ix0uV/VcidOWnIYlxhKt/rlaKjmOljNU
         N/FXU0qPT5hS56SzL63iVdwffzd2seq155kdm+cTK1OKgW67lpPh950+iHtZwJ8Nij
         s9cJkxNfwqblyEPEuPTRDxgiOAYJvNR2q8YjMcn3inUj7J+E0w1+nRy0FLXpRtHI38
         LkcRHYLoLqFbQ==
From:   Fabio Estevam <festevam@denx.de>
To:     kvalo@codeaurora.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        hch@lst.de, erik.stromdahl@gmail.com, peter.oh@eero.com,
        aspriel@gmail.com, marex@denx.de, alagusankar@silex-india.com,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3] ath10k: high latency fixes for beacon buffer
Date:   Wed, 18 Aug 2021 20:26:27 -0300
Message-Id: <20210818232627.2040121-1-festevam@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alagu Sankar <alagusankar@silex-india.com>

Beacon buffer for high latency devices does not use DMA. other similar
buffer allocation methods in the driver have already been modified for
high latency path. Fix the beacon buffer allocation left out in the
earlier high latency changes.

Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
[fabio: adapt it to use ar->bus_param.dev_type ]
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- Pick Alagu's patch:
https://patchwork.kernel.org/project/ath10k/patch/20190417191503.18814-3-erik.stromdahl@gmail.com/

 drivers/net/wireless/ath/ath10k/mac.c | 31 ++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index c272b290fa73..7ca68c81d9b6 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -993,8 +993,12 @@ static void ath10k_mac_vif_beacon_cleanup(struct ath10k_vif *arvif)
 	ath10k_mac_vif_beacon_free(arvif);
 
 	if (arvif->beacon_buf) {
-		dma_free_coherent(ar->dev, IEEE80211_MAX_FRAME_LEN,
-				  arvif->beacon_buf, arvif->beacon_paddr);
+		if (ar->bus_param.dev_type == ATH10K_DEV_TYPE_HL)
+			kfree(arvif->beacon_buf);
+		else
+			dma_free_coherent(ar->dev, IEEE80211_MAX_FRAME_LEN,
+					  arvif->beacon_buf,
+					  arvif->beacon_paddr);
 		arvif->beacon_buf = NULL;
 	}
 }
@@ -5576,10 +5580,17 @@ static int ath10k_add_interface(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_ADHOC ||
 	    vif->type == NL80211_IFTYPE_MESH_POINT ||
 	    vif->type == NL80211_IFTYPE_AP) {
-		arvif->beacon_buf = dma_alloc_coherent(ar->dev,
-						       IEEE80211_MAX_FRAME_LEN,
-						       &arvif->beacon_paddr,
-						       GFP_ATOMIC);
+		if (ar->bus_param.dev_type == ATH10K_DEV_TYPE_HL) {
+			arvif->beacon_buf = kmalloc(IEEE80211_MAX_FRAME_LEN,
+						    GFP_KERNEL);
+			arvif->beacon_paddr = (dma_addr_t)arvif->beacon_buf;
+		} else {
+			arvif->beacon_buf =
+				dma_alloc_coherent(ar->dev,
+						   IEEE80211_MAX_FRAME_LEN,
+						   &arvif->beacon_paddr,
+						   GFP_ATOMIC);
+		}
 		if (!arvif->beacon_buf) {
 			ret = -ENOMEM;
 			ath10k_warn(ar, "failed to allocate beacon buffer: %d\n",
@@ -5794,8 +5805,12 @@ static int ath10k_add_interface(struct ieee80211_hw *hw,
 
 err:
 	if (arvif->beacon_buf) {
-		dma_free_coherent(ar->dev, IEEE80211_MAX_FRAME_LEN,
-				  arvif->beacon_buf, arvif->beacon_paddr);
+		if (ar->bus_param.dev_type == ATH10K_DEV_TYPE_HL)
+			kfree(arvif->beacon_buf);
+		else
+			dma_free_coherent(ar->dev, IEEE80211_MAX_FRAME_LEN,
+					  arvif->beacon_buf,
+					  arvif->beacon_paddr);
 		arvif->beacon_buf = NULL;
 	}
 
-- 
2.25.1

