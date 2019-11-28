Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE5A10C4E1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 09:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfK1IVu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 03:21:50 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:35278
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727266AbfK1IVu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 03:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574929310;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=WNgcdifeKPsqi/GRjYzosb1eetOaTcII9PbVVYOev18=;
        b=hcKOBTHLyIGmbGsIEQekoTFR61FAkcGrn9kwAwMunCqjPJiPmTYXpe2zzuQ6SHq/
        wFYY7VlaF1ggFyKBzbbLDkhIaP7TdX9MjnNdoz+CAgAP6SS+13nxwjlWpS8O7HPrLFD
        jF/yHqWec+ODOKhUBPDfAYw+CRltHKA3CjkMQ8Mk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574929310;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=WNgcdifeKPsqi/GRjYzosb1eetOaTcII9PbVVYOev18=;
        b=Wa863X5pjKNwcR/gNhU105kk/sfGY/BmPtl/OcrSwu7qFdDRz+OEEKZ8WaJdjcq3
        ElMEZWNddD21DRdcZ8HxeUMqbDQq38wgM4C5jd3oL8tcIbFiziS0FHW4BcLFo6Izd+9
        X94558rV7dZCJVsdO+F562PEhDwxOcpGld/fzFgI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18162C447AF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 3/9] ath11k: fix memory leak in monitor mode
Date:   Thu, 28 Nov 2019 08:21:49 +0000
Message-ID: <0101016eb11a2018-f7fbb7a5-d195-4af8-8733-408db6c9a012-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
References: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.28-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miles Hu <milehu@codeaurora.org>

remove tail check to avoid last amsdu leak.
recycle skb in ppdu id wrap around case

Signed-off-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 8c21925a522a..85e999c7a238 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3735,8 +3735,15 @@ ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar,
 
 				if (ath11k_dp_rx_mon_comp_ppduid(msdu_ppdu_id,
 								 ppdu_id,
-								 &rx_bufs_used))
+								 &rx_bufs_used)) {
+					if (rx_bufs_used) {
+						drop_mpdu = true;
+						dev_kfree_skb_any(msdu);
+						msdu = NULL;
+						goto next_msdu;
+					}
 					return rx_bufs_used;
+				}
 				pmon->mon_last_linkdesc_paddr = paddr;
 				is_first_msdu = false;
 			}
@@ -3938,7 +3945,7 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 
 		ath11k_dp_rx_deliver_msdu(ar, napi, mon_skb);
 		mon_skb = skb_next;
-	} while (mon_skb && (mon_skb != tail_msdu));
+	} while (mon_skb);
 	rxs->flag = 0;
 
 	return 0;
-- 
2.7.4

