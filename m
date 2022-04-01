Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6325A4EE921
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 09:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiDAHeD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 03:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiDAHeC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 03:34:02 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332551E6E9C
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648798333; x=1680334333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z53IQgbA88qDwxA3RPNy6ZnD/+8bI67ulGNfAfZJ2xQ=;
  b=AS4Zca12GIGcoolLPLV3ULk5VY3poEgPgMHi6Yptr/8QB9tjZNufdypJ
   AiGuY1Deg6mLpE9CuJ+tXsRYs6xnElsM4LWn3pgfCc7p2v+e50sfQ4/aw
   d1mqhBx1k/EHA0yU16+aJEQtduIlv6QaYbtOx782m5jWFtoJ+53Wnpma1
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Apr 2022 00:32:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 00:32:12 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Apr 2022 00:32:12 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Apr 2022 00:32:11 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 1/2] ath11k: add support for extended wmi service bit
Date:   Fri, 1 Apr 2022 15:31:59 +0800
Message-ID: <20220401073200.1195070-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

Currently the wmi service bis is report from firmware, it is divided
to 128 bits for each segment. The first segment is processed by
ath11k_wmi_service_bitmap_copy(), the second segment is processed by
ath11k_service_available_event() with WMI_TAG_SERVICE_AVAILABLE_EVENT,
When the service bit exceed 256 bits, then firmware report it by tag
WMI_TAG_ARRAY_UINT32 in WMI_SERVICE_AVAILABLE_EVENTID.

ath11k does not process the third segment, this is to extend the wmi
service bits from 256 to 384 for the third 128 bits. The 3 enum value
WMI_MAX_SERVICE(128)/WMI_MAX_EXT_SERVICE(256)/WMI_MAX_EXT2_SERVICE(384)
are convenient to process the service bits.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 81 ++++++++++++++++-----------
 drivers/net/wireless/ath/ath11k/wmi.h |  9 ++-
 2 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 3af24b18204e..a5876e0378fe 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7297,47 +7297,64 @@ static void ath11k_vdev_install_key_compl_event(struct ath11k_base *ab,
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
index 925b8003feae..da9b0a90fd70 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1992,6 +1992,7 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_ACK_TIMEOUT = 126,
 	WMI_TLV_SERVICE_PDEV_BSS_CHANNEL_INFO_64 = 127,
 
+	/* The first 128 bits */
 	WMI_MAX_SERVICE = 128,
 
 	WMI_TLV_SERVICE_CHAN_LOAD_INFO = 128,
@@ -2084,7 +2085,11 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
 	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
 
-	WMI_MAX_EXT_SERVICE
+	/* The second 128 bits */
+	WMI_MAX_EXT_SERVICE = 256,
+
+	/* The third 128 bits */
+	WMI_MAX_EXT2_SERVICE = 384
 };
 
 enum {
@@ -5378,7 +5383,7 @@ struct ath11k_wmi_base {
 
 	struct completion service_ready;
 	struct completion unified_ready;
-	DECLARE_BITMAP(svc_map, WMI_MAX_EXT_SERVICE);
+	DECLARE_BITMAP(svc_map, WMI_MAX_EXT2_SERVICE);
 	wait_queue_head_t tx_credits_wq;
 	const struct wmi_peer_flags_map *peer_flags;
 	u32 num_mem_chunks;
-- 
2.25.1

