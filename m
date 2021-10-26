Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F207D43B110
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 13:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhJZLWO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 07:22:14 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:47817 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbhJZLWN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 07:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635247190; x=1666783190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dszUnoqU0uc1i+dM0m8lC2i9LJBR6A/k9YFSwTfixNs=;
  b=E8GFzuzNtPpq5cJwzeGHLK0bWO4aKW8rY1VcK2dyPYYC6nLmvYq+eeKd
   CdA02gBIgAKAEiWQfi8pycCHpWYr2e7ABcO6MULp6eCHX3jUlTiWn9xK/
   AHNt9rpXFgN3r3XdIi4F7QuIJqXjS7gkR6IJGeS64tZR2fHypWv7KiPe0
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 04:19:49 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 04:19:49 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 04:19:48 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 01/15] ath11k: add support for extended wmi service bit
Date:   Tue, 26 Oct 2021 07:18:59 -0400
Message-ID: <20211026111913.7346-2-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026111913.7346-1-quic_wgong@quicinc.com>
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The max wmi service bit is 256 in ath11k, Extend it
for more wmi service bit.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 81 ++++++++++++++++-----------
 drivers/net/wireless/ath/ath11k/wmi.h |  6 +-
 2 files changed, 53 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 51b694c1f948..69c7b8355e52 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6626,47 +6626,64 @@ static void ath11k_vdev_install_key_compl_event(struct ath11k_base *ab,
 	rcu_read_unlock();
 }
 
-static void ath11k_service_available_event(struct ath11k_base *ab, struct sk_buff *skb)
+static int  ath11k_wmi_tlv_services_parser(struct ath11k_base *ab,
+					   u16 tag, u16 len,
+					   const void *ptr, void *data)
 {
-	const void **tb;
 	const struct wmi_service_available_event *ev;
-	int ret;
+	u32 *wmi_ext2_service_bitmap;
 	int i, j;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
-	if (IS_ERR(tb)) {
-		ret = PTR_ERR(tb);
-		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
-		return;
-	}
+	switch (tag) {
+	case WMI_TAG_SERVICE_AVAILABLE_EVENT:
+		ev = (struct wmi_service_available_event *)ptr;
+		for (i = 0, j = WMI_MAX_SERVICE;
+			i < WMI_SERVICE_SEGMENT_BM_SIZE32 && j < WMI_MAX_EXT_SERVICE;
+			i++) {
+			do {
+				if (ev->wmi_service_segment_bitmap[i] &
+				    BIT(j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32))
+					set_bit(j, ab->wmi_ab.svc_map);
+			} while (++j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32);
+		}
 
-	ev = tb[WMI_TAG_SERVICE_AVAILABLE_EVENT];
-	if (!ev) {
-		ath11k_warn(ab, "failed to fetch svc available ev");
-		kfree(tb);
-		return;
-	}
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "wmi_ext_service_bitmap 0:0x%04x, 1:0x%04x, 2:0x%04x, 3:0x%04x",
+			   ev->wmi_service_segment_bitmap[0],
+			   ev->wmi_service_segment_bitmap[1],
+			   ev->wmi_service_segment_bitmap[2],
+			   ev->wmi_service_segment_bitmap[3]);
+		break;
+	case WMI_TAG_ARRAY_UINT32:
+		wmi_ext2_service_bitmap = (u32 *)ptr;
+		for (i = 0, j = WMI_MAX_EXT_SERVICE;
+			i < WMI_SERVICE_SEGMENT_BM_SIZE32 && j < WMI_MAX_EXT2_SERVICE;
+			i++) {
+			do {
+				if (wmi_ext2_service_bitmap[i] &
+				    BIT(j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32))
+					set_bit(j, ab->wmi_ab.svc_map);
+			} while (++j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32);
+		}
 
-	/* TODO: Use wmi_service_segment_offset information to get the service
-	 * especially when more services are advertised in multiple sevice
-	 * available events.
-	 */
-	for (i = 0, j = WMI_MAX_SERVICE;
-	     i < WMI_SERVICE_SEGMENT_BM_SIZE32 && j < WMI_MAX_EXT_SERVICE;
-	     i++) {
-		do {
-			if (ev->wmi_service_segment_bitmap[i] &
-			    BIT(j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32))
-				set_bit(j, ab->wmi_ab.svc_map);
-		} while (++j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32);
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "wmi_ext2_service__bitmap  0:0x%04x, 1:0x%04x, 2:0x%04x, 3:0x%04x",
+			   wmi_ext2_service_bitmap[0], wmi_ext2_service_bitmap[1],
+			   wmi_ext2_service_bitmap[2], wmi_ext2_service_bitmap[3]);
+		break;
 	}
+	return 0;
+}
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "wmi_ext_service_bitmap 0:0x%x, 1:0x%x, 2:0x%x, 3:0x%x",
-		   ev->wmi_service_segment_bitmap[0], ev->wmi_service_segment_bitmap[1],
-		   ev->wmi_service_segment_bitmap[2], ev->wmi_service_segment_bitmap[3]);
+static void ath11k_service_available_event(struct ath11k_base *ab, struct sk_buff *skb)
+{
+	int ret;
 
-	kfree(tb);
+	ret = ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath11k_wmi_tlv_services_parser,
+				  NULL);
+	if (ret)
+		ath11k_warn(ab, "failed to parse services available tlv %d\n", ret);
 }
 
 static void ath11k_peer_assoc_conf_event(struct ath11k_base *ab, struct sk_buff *skb)
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index e1809ae8d628..79e9140b40d0 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2059,7 +2059,9 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
 	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
 
-	WMI_MAX_EXT_SERVICE
+	WMI_MAX_EXT_SERVICE = 256,
+
+	WMI_MAX_EXT2_SERVICE
 };
 
 enum {
@@ -5066,7 +5068,7 @@ struct ath11k_wmi_base {
 
 	struct completion service_ready;
 	struct completion unified_ready;
-	DECLARE_BITMAP(svc_map, WMI_MAX_EXT_SERVICE);
+	DECLARE_BITMAP(svc_map, WMI_MAX_EXT2_SERVICE);
 	wait_queue_head_t tx_credits_wq;
 	const struct wmi_peer_flags_map *peer_flags;
 	u32 num_mem_chunks;
-- 
2.31.1

