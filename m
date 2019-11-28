Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDE610C4E7
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 09:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfK1IWB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 03:22:01 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:39138
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727522AbfK1IWA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 03:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574929320;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=dHuD82+0yJBVXsYeOupsPuTPdmUJSLK1w+BQHGdGNGI=;
        b=TYclLICOqQJdfjnmj6wwKo/UGQ4uncxq6SxkdlF22PSXGhcG7THT3TKn4mqEpit/
        idzhIhaGtPmwrEHdwGtwhsJOeWHDwP/HxNMMtjPyu4fn2D19KUJzrVVjJ0qPHNpBnVa
        QH7a0RoKhi/Be4PE649j5GewyY733+DH48NmAcvg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574929320;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=dHuD82+0yJBVXsYeOupsPuTPdmUJSLK1w+BQHGdGNGI=;
        b=VF5QdKeVMqgaQpmI7hETnpG5yk2n6SPbGnc5toHF0MTb4vToo9Dlb3kdeYoobj8S
        83wr7TRDgUggpOR7+cK9nBWcoRRZURqnG4cPnxHxZFNsUVChD3QyEoNPVQOwQDbsNDV
        1KoL8AoY3ObXhZvovezbnHcyBydSsrnNDrJET94c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D30AC48B00
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 9/9] ath11k: fix indentation in ath11k_mac_prepare_he_mode()
Date:   Thu, 28 Nov 2019 08:22:00 +0000
Message-ID: <0101016eb11a483b-ffff8cbb-bd85-45d2-bc54-791a59d0904b-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
References: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.28-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e4dfce6b63f0..978d8768d68a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3883,15 +3883,15 @@ ath11k_mac_prepare_he_mode(struct ath11k_pdev *pdev, u32 viftype)
 	hecap_phy_ptr = &cap_band->he_cap_phy_info[0];
 
 	hemode = FIELD_PREP(HE_MODE_SU_TX_BFEE, HE_SU_BFEE_ENABLE) |
-		FIELD_PREP(HE_MODE_SU_TX_BFER, HECAP_PHY_SUBFMR_GET(hecap_phy_ptr)) |
-		FIELD_PREP(HE_MODE_UL_MUMIMO, HECAP_PHY_ULMUMIMO_GET(hecap_phy_ptr));
+		 FIELD_PREP(HE_MODE_SU_TX_BFER, HECAP_PHY_SUBFMR_GET(hecap_phy_ptr)) |
+		 FIELD_PREP(HE_MODE_UL_MUMIMO, HECAP_PHY_ULMUMIMO_GET(hecap_phy_ptr));
 
 	/* TODO WDS and other modes */
 	if (viftype == NL80211_IFTYPE_AP) {
 		hemode |= FIELD_PREP(HE_MODE_MU_TX_BFER,
-			   HECAP_PHY_MUBFMR_GET(hecap_phy_ptr)) |
-			FIELD_PREP(HE_MODE_DL_OFDMA, HE_DL_MUOFDMA_ENABLE) |
-			FIELD_PREP(HE_MODE_UL_OFDMA, HE_UL_MUOFDMA_ENABLE);
+			  HECAP_PHY_MUBFMR_GET(hecap_phy_ptr)) |
+			  FIELD_PREP(HE_MODE_DL_OFDMA, HE_DL_MUOFDMA_ENABLE) |
+			  FIELD_PREP(HE_MODE_UL_OFDMA, HE_UL_MUOFDMA_ENABLE);
 	} else {
 		hemode |= FIELD_PREP(HE_MODE_MU_TX_BFEE, HE_MU_BFEE_ENABLE);
 	}
-- 
2.7.4

