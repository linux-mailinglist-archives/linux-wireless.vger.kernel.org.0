Return-Path: <linux-wireless+bounces-33047-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL4NMNxVsmlvLwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33047-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:57:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 283A426D739
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A596030530F3
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E344309F1D;
	Thu, 12 Mar 2026 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iZSkA0YA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5E30F7EF
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773295061; cv=none; b=gSMhWs5sqlt0mPMyU4Sknsjjfbu1Fcz+7dz5rkskt0Phwj+cvZyuLlSbRoB1VFK7VtmGvJ5+SklQ0LKzt1X1LVmQX5RVw3sXu0w8PYRq7GiVohaK+L2UYCiAirdmZYLw4SAZNjhwFVWjXr3/Tzu1ziDO1rMzm2N3nD522aZITrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773295061; c=relaxed/simple;
	bh=oyV9s7iqILAimvAadueACXVg6uFwrR2efxDDbpNFyCA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q2HQEdzEl0SUJ1uFMbemMOkCvFyrA0D8Yu1VFM1sKUdrHvxtNTz67ZbhGuRu7Mjh8nYcqBB3pu2SRdGiiuW5xS06sr/5zcTIRijm/5RBHI5MzL8GjOqhVUDU+w2CHJctXLbUOPjgaxswzkh6o2Cwo/34Nyghmi44yR/unxm4E80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iZSkA0YA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62C5vXGw91983292, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773295054; bh=R4r5KM7qM6GGtEpv/yOkxs2vQIl2gcYNMCDpF3ZQa/A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=iZSkA0YAeiu5JCyoICIE0bex7k3qW/AAlZ/P6L9hWknl2nR55Xu+QRQGXZRU43MsE
	 0Bqr5qfITq8JP5V694N+MrgBp8BFLj0dV8pZWGA1x3s8dBB0jb2G3VY6XsNf9sVmdp
	 t2GXQ8DEZHDzT4/+oOjByYGObxvsLze5OWoNSAsSE74VAzPxCrfucG4EGNzeiwXUhS
	 qq2U2yKSLhIP8C5ERLMHh24IACrHaZ2LXlmelXIUjBdQWCkOVTWM9R5e87CYTe62LK
	 3HTgVM/UwQsOTVDYUfBQJdd+w1sf9B6HRZiTY1d9rmedCBeAD7O8jZt9fyx6d8UU0R
	 YnzZPUeRUUIgQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62C5vXGw91983292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 13:57:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 12 Mar 2026 13:57:33 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 12 Mar 2026 13:57:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>, <mh_chen@realtek.com>, <isaiah@realtek.com>
Subject: [PATCH v2 rtw-next] wifi: rtw89: usb: Rx aggregation for RTL8832CU/RTL8851BU
Date: Thu, 12 Mar 2026 13:57:24 +0800
Message-ID: <20260312055724.12177-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com];
	TAGGED_FROM(0.00)[bounces-33047-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: 283A426D739
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shin-Yi Lin <isaiah@realtek.com>

USB RX Aggregation is a performance optimization technique used
in USB network devices to increase throughput.

Instead of sending every received network packet to the host computer
individually, the device hardware groups multiple smaller packets
into a single, large USB Bulk Transfer.

 * toAP/toNB use iperf3 respectively.

With Cisco BE6000 - iperf3 tcp 10 pair (to another NB)

[6G 160Mhz]:

 RTL8832CU-USB3.0
       before   after
 TX    941      941
 RX    847      919

 RTL8832CU-USB2.0
       before   after
 TX    293      286
 RX    342      356

[5G 80Mhz]:

 RTL8832CU-USB3.0
       before   after
 TX    864      877
 RX    864      902

 RTL8832CU-USB2.0
       before   after
 TX    279      271
 RX    327      349

 RTL8851BU
       before   after
 TX    115      114
 RX    295      306

Signed-off-by: Shin-Yi Lin <isaiah@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: address Bitterblue's comments
 - correct throughput value in commit message
 - add rtw89_ prefix to missed functions
 - add unit '1K' in macro naming

Note:
This one is to add USB RX aggregation to improve performance. The other
one is TX aggregation, which we are working on.
---
 .../net/wireless/realtek/rtw89/rtw8851bu.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852au.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bu.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852cu.c    |  1 +
 drivers/net/wireless/realtek/rtw89/usb.c      | 84 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/usb.h      | 12 +++
 6 files changed, 87 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index 959d62aefdd8..6a8d31544314 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -15,6 +15,7 @@ static const struct rtw89_usb_info rtw8851b_usb_info = {
 	.usb3_mac_npi_config_intf_0	= R_AX_USB3_MAC_NPI_CONFIG_INTF_0,
 	.usb_endpoint_0			= R_AX_USB_ENDPOINT_0,
 	.usb_endpoint_2			= R_AX_USB_ENDPOINT_2,
+	.rx_agg_alignment		= 8,
 	.bulkout_id = {
 		[RTW89_DMA_ACH0] = 3,
 		[RTW89_DMA_ACH1] = 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
index ccdbcc178c2a..4cced4619b7d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
@@ -15,6 +15,7 @@ static const struct rtw89_usb_info rtw8852a_usb_info = {
 	.usb3_mac_npi_config_intf_0	= R_AX_USB3_MAC_NPI_CONFIG_INTF_0,
 	.usb_endpoint_0			= R_AX_USB_ENDPOINT_0,
 	.usb_endpoint_2			= R_AX_USB_ENDPOINT_2,
+	.rx_agg_alignment		= 8,
 	.bulkout_id = {
 		[RTW89_DMA_ACH0] = 3,
 		[RTW89_DMA_ACH2] = 5,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index 84cd3ec971f9..37111fed276f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -15,6 +15,7 @@ static const struct rtw89_usb_info rtw8852b_usb_info = {
 	.usb3_mac_npi_config_intf_0	= R_AX_USB3_MAC_NPI_CONFIG_INTF_0,
 	.usb_endpoint_0			= R_AX_USB_ENDPOINT_0,
 	.usb_endpoint_2			= R_AX_USB_ENDPOINT_2,
+	.rx_agg_alignment		= 8,
 	.bulkout_id = {
 		[RTW89_DMA_ACH0] = 3,
 		[RTW89_DMA_ACH1] = 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
index 3b9825c92a0d..0c5aebaed873 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -15,6 +15,7 @@ static const struct rtw89_usb_info rtw8852c_usb_info = {
 	.usb3_mac_npi_config_intf_0	= R_AX_USB3_MAC_NPI_CONFIG_INTF_0_V1,
 	.usb_endpoint_0			= R_AX_USB_ENDPOINT_0_V1,
 	.usb_endpoint_2			= R_AX_USB_ENDPOINT_2_V1,
+	.rx_agg_alignment		= 8,
 	.bulkout_id = {
 		[RTW89_DMA_ACH0] = 3,
 		[RTW89_DMA_ACH2] = 5,
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index da1b7ce8089e..1665169f45fc 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -408,11 +408,14 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
 static void rtw89_usb_rx_handler(struct work_struct *work)
 {
 	struct rtw89_usb *rtwusb = container_of(work, struct rtw89_usb, rx_work);
+	const struct rtw89_usb_info *info = rtwusb->info;
 	struct rtw89_dev *rtwdev = rtwusb->rtwdev;
 	struct rtw89_rx_desc_info desc_info;
+	s32 aligned_offset, remaining;
 	struct sk_buff *rx_skb;
 	struct sk_buff *skb;
 	u32 pkt_offset;
+	u8 *pkt_ptr;
 	int limit;
 
 	for (limit = 0; limit < 200; limit++) {
@@ -425,23 +428,38 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 			goto free_or_reuse;
 		}
 
-		memset(&desc_info, 0, sizeof(desc_info));
-		rtw89_chip_query_rxdesc(rtwdev, &desc_info, rx_skb->data, 0);
+		pkt_ptr = rx_skb->data;
+		remaining = rx_skb->len;
 
-		skb = rtw89_alloc_skb_for_rx(rtwdev, desc_info.pkt_size);
-		if (!skb) {
-			rtw89_debug(rtwdev, RTW89_DBG_HCI,
-				    "failed to allocate RX skb of size %u\n",
-				    desc_info.pkt_size);
-			goto free_or_reuse;
-		}
+		do {
+			memset(&desc_info, 0, sizeof(desc_info));
+			rtw89_chip_query_rxdesc(rtwdev, &desc_info, pkt_ptr, 0);
 
-		pkt_offset = desc_info.offset + desc_info.rxd_len;
+			pkt_offset = desc_info.offset + desc_info.rxd_len;
+			if (remaining < (pkt_offset + desc_info.pkt_size)) {
+				rtw89_debug(rtwdev, RTW89_DBG_HCI,
+					    "Failed to get remaining RX pkt %u > %u\n",
+					    pkt_offset + desc_info.pkt_size, remaining);
+				goto free_or_reuse;
+			}
 
-		skb_put_data(skb, rx_skb->data + pkt_offset,
-			     desc_info.pkt_size);
+			skb = rtw89_alloc_skb_for_rx(rtwdev, desc_info.pkt_size);
+			if (!skb) {
+				rtw89_debug(rtwdev, RTW89_DBG_HCI,
+					    "failed to allocate RX skb of size %u\n",
+					    desc_info.pkt_size);
+				goto free_or_reuse;
+			}
+
+			skb_put_data(skb, pkt_ptr + pkt_offset, desc_info.pkt_size);
+			rtw89_core_rx(rtwdev, &desc_info, skb);
 
-		rtw89_core_rx(rtwdev, &desc_info, skb);
+			/* next frame */
+			pkt_offset += desc_info.pkt_size;
+			aligned_offset = ALIGN(pkt_offset, info->rx_agg_alignment);
+			pkt_ptr += aligned_offset;
+			remaining -= aligned_offset;
+		} while (remaining > 0);
 
 free_or_reuse:
 		if (skb_queue_len(&rtwusb->rx_free_queue) >= RTW89_USB_RX_SKB_NUM)
@@ -745,6 +763,44 @@ static int rtw89_usb_ops_mac_pre_deinit(struct rtw89_dev *rtwdev)
 	return 0; /* Nothing to do. */
 }
 
+static void rtw89_usb_rx_agg_cfg_v1(struct rtw89_dev *rtwdev)
+{
+	const u32 rxagg_0 = FIELD_PREP_CONST(B_AX_RXAGG_0_EN, 1) |
+			    FIELD_PREP_CONST(B_AX_RXAGG_0_NUM_TH, 0) |
+			    FIELD_PREP_CONST(B_AX_RXAGG_0_TIME_32US_TH, 32) |
+			    FIELD_PREP_CONST(B_AX_RXAGG_0_BUF_SZ_4K, 5);
+
+	rtw89_write32(rtwdev, R_AX_RXAGG_0, rxagg_0);
+}
+
+static void rtw89_usb_rx_agg_cfg_v2(struct rtw89_dev *rtwdev)
+{
+	const u32 rxagg_0 = FIELD_PREP_CONST(B_AX_RXAGG_0_EN, 1) |
+			    FIELD_PREP_CONST(B_AX_RXAGG_0_NUM_TH, 255) |
+			    FIELD_PREP_CONST(B_AX_RXAGG_0_TIME_32US_TH, 32) |
+			    FIELD_PREP_CONST(B_AX_RXAGG_0_BUF_SZ_1K, 20);
+
+	rtw89_write32(rtwdev, R_AX_RXAGG_0_V1, rxagg_0);
+	rtw89_write32(rtwdev, R_AX_RXAGG_1_V1, 0x1F);
+}
+
+static void rtw89_usb_rx_agg_cfg(struct rtw89_dev *rtwdev)
+{
+	switch (rtwdev->chip->chip_id) {
+	case RTL8851B:
+	case RTL8852A:
+	case RTL8852B:
+		rtw89_usb_rx_agg_cfg_v1(rtwdev);
+		break;
+	case RTL8852C:
+		rtw89_usb_rx_agg_cfg_v2(rtwdev);
+		break;
+	default:
+		rtw89_warn(rtwdev, "%s: USB RX agg not support\n", __func__);
+		return;
+	}
+}
+
 static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
@@ -773,6 +829,8 @@ static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
 		rtw89_write8(rtwdev, info->usb_endpoint_2 + 1, NUMP);
 	}
 
+	rtw89_usb_rx_agg_cfg(rtwdev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index 203ec8e993e9..3d17e514e346 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -20,6 +20,17 @@
 #define RTW89_MAX_ENDPOINT_NUM		9
 #define RTW89_MAX_BULKOUT_NUM		7
 
+#define R_AX_RXAGG_0_V1			0x6000
+#define B_AX_RXAGG_0_EN			BIT(31)
+#define B_AX_RXAGG_0_NUM_TH		GENMASK(23, 16)
+#define B_AX_RXAGG_0_TIME_32US_TH	GENMASK(15, 8)
+#define B_AX_RXAGG_0_BUF_SZ_1K		GENMASK(7, 0)
+
+#define R_AX_RXAGG_1_V1			0x6004
+
+#define R_AX_RXAGG_0			0x8900
+#define B_AX_RXAGG_0_BUF_SZ_4K		GENMASK(7, 0)
+
 struct rtw89_usb_info {
 	u32 usb_host_request_2;
 	u32 usb_wlan0_1;
@@ -27,6 +38,7 @@ struct rtw89_usb_info {
 	u32 usb3_mac_npi_config_intf_0;
 	u32 usb_endpoint_0;
 	u32 usb_endpoint_2;
+	u8 rx_agg_alignment;
 	u8 bulkout_id[RTW89_DMA_CH_NUM];
 };
 

base-commit: 039cd522dc70151da13329a5e3ae19b1736f468a
-- 
2.25.1


