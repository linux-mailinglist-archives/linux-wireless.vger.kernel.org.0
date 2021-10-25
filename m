Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D464395D3
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 14:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhJYMSg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 08:18:36 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:1599 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhJYMSf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 08:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635164174; x=1666700174;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=fNkXmNG4QtVHw0/e61QNdNqge1zf/SQk2d174RRSZqA=;
  b=Pk03DszD+Gs62exXb8jWDKvYzmuvYRKFr/2QOlFvUjbr7XgJ7L9ZWjTJ
   rUZ3erKfdSVHvdPSYw5OziNxeP7whTFudcoCKzb/PlxyaEYWUgFtwFjCH
   +PmoZXivPzh5Y5/6zgLiiTedFUoKqIoCfpG6oJwf036QB7iZAz8Upcvf+
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 05:16:13 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:16:14 -0700
Received: from ppranees-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 05:16:11 -0700
From:   P Praneesh <quic_ppranees@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH] ath11k: fix FCS_ERR flag in radio tap header
Date:   Mon, 25 Oct 2021 17:44:20 +0530
Message-ID: <1635164060-18423-1-git-send-email-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In radio tap header, BAD FCS flag is not updated properly because
driver failed to update FCS_ERR flag in monitor mode.

In rx_desc, FCS_ERR information is available in rx_attention
structure and presence of this field indicates corresponding frame
failed FCS check.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 1232bbe..63b1e87 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4825,7 +4825,7 @@ static struct sk_buff *
 ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 			    u32 mac_id, struct sk_buff *head_msdu,
 			    struct sk_buff *last_msdu,
-			    struct ieee80211_rx_status *rxs)
+			    struct ieee80211_rx_status *rxs, bool *fcs_err)
 {
 	struct ath11k_base *ab = ar->ab;
 	struct sk_buff *msdu, *prev_buf;
@@ -4835,12 +4835,17 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 	u8 *dest, decap_format;
 	struct ieee80211_hdr_3addr *wh;
 	struct rx_attention *rx_attention;
+	u32 err_bitmap;
 
 	if (!head_msdu)
 		goto err_merge_fail;
 
 	rx_desc = (struct hal_rx_desc *)head_msdu->data;
 	rx_attention = ath11k_dp_rx_get_attention(ab, rx_desc);
+	err_bitmap = ath11k_dp_rx_h_attn_mpdu_err(rx_attention);
+
+	if (err_bitmap & DP_RX_MPDU_ERR_FCS)
+		*fcs_err = true;
 
 	if (ath11k_dp_rxdesc_get_mpdulen_err(rx_attention))
 		return NULL;
@@ -4929,9 +4934,10 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 	struct ath11k_pdev_dp *dp = &ar->dp;
 	struct sk_buff *mon_skb, *skb_next, *header;
 	struct ieee80211_rx_status *rxs = &dp->rx_status;
+	bool fcs_err = false;
 
 	mon_skb = ath11k_dp_rx_mon_merg_msdus(ar, mac_id, head_msdu,
-					      tail_msdu, rxs);
+					      tail_msdu, rxs, &fcs_err);
 
 	if (!mon_skb)
 		goto mon_deliver_fail;
@@ -4939,6 +4945,10 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 	header = mon_skb;
 
 	rxs->flag = 0;
+
+	if (fcs_err)
+		rxs->flag = RX_FLAG_FAILED_FCS_CRC;
+
 	do {
 		skb_next = mon_skb->next;
 		if (!skb_next)
-- 
2.7.4

