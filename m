Return-Path: <linux-wireless+bounces-30268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B906FCEDF68
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 08:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4116D302BAA7
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 07:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A32310644;
	Fri,  2 Jan 2026 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fUNdpFo1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5013101C0
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767337755; cv=none; b=UTOYGlQ2oTLh+TjPMVTycDWVWP1lf9NxYdoiqDrv07LSaWwktwAo0glFjCbwl5aPfre4KphihFfcRE0FU76ESDrw5oLuz7BDPBWOXUsw+8mO59AoN8hfoaTvMYehEU01zRNRyQd78XesI3UV2O14yLuqCCBZQ5sx0aM4JGcWVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767337755; c=relaxed/simple;
	bh=d4ivLn7cxTbcZbeflntzRRYiuKGpFFugAaccuf5R/5E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWVtTfyEEZeplcnZ5fVl6qh+TjMd1O6MqlOGTr+HIIAnxdnYCuRiGtENSUHSvQ3WGB3NYqXz1V4CrR6gccKqYuiGAx2m9qJ+eFsOnEOiTIi5wbiIN7F7nnzYc2kADe2SX6Txafayuh8U0av6ZvSg2i5DRGj4vFH/keeyVRqEcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fUNdpFo1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60279AEs8486946, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767337750; bh=DFNVOBbo4aQOKJbg+Gm6HOzGtukcAJCoqIfMdcanXio=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=fUNdpFo1ZRzvn0bBMy9/N+7b5wgp6LeyMufjnv19zB57xYwvi7Xey9MdllIvMOkUX
	 I9s0h4BUZdnUqa216ajuk9ZR6sHkQXgqoK9V4yTyyo2z/k3lP04ulb+mh+1wunyT6t
	 2CUScuYgXANS8zX2i55VPF3aLxr9NgLrFdkutxRUkapYX9akAsHnrTInvFDpYyGVya
	 VC8ZF3wh8JpgZsAuqH1rekKvzKkanqnuiX3XcyFRWZdpp3C6VkRbbDeg1LRNhZDTg/
	 17ftK7fgh3vhxb5UkiK6ro3GT/EfIMPY4tkKbykVfgC82a1kM1sfj7j49hty50Yn/u
	 SvQ+1BASXh6RQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60279AEs8486946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 2 Jan 2026 15:09:10 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 2 Jan 2026 15:09:11 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 2 Jan 2026 15:09:10 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 2 Jan 2026 15:09:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 02/10] wifi: rtw89: update query RXDESC v3 for RTL8922D
Date: Fri, 2 Jan 2026 15:08:32 +0800
Message-ID: <20260102070840.62047-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260102070840.62047-1-pkshih@realtek.com>
References: <20260102070840.62047-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add RXDESC v3 to parse meta data of receiving packets for RTL8922D.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 72 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 25 ++++++++
 drivers/net/wireless/realtek/rtw89/txrx.h |  6 ++
 3 files changed, 103 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 36565ba2cc91..d61170afea6e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3469,6 +3469,78 @@ void rtw89_core_query_rxdesc_v2(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_core_query_rxdesc_v2);
 
+void rtw89_core_query_rxdesc_v3(struct rtw89_dev *rtwdev,
+				struct rtw89_rx_desc_info *desc_info,
+				u8 *data, u32 data_offset)
+{
+	struct rtw89_rxdesc_phy_rpt_v2 *rxd_rpt;
+	struct rtw89_rxdesc_short_v3 *rxd_s;
+	struct rtw89_rxdesc_long_v3 *rxd_l;
+	u16 shift_len, drv_info_len, phy_rtp_len, hdr_cnv_len;
+
+	rxd_s = (struct rtw89_rxdesc_short_v3 *)(data + data_offset);
+
+	desc_info->pkt_size = le32_get_bits(rxd_s->dword0, BE_RXD_RPKT_LEN_MASK);
+	desc_info->drv_info_size = le32_get_bits(rxd_s->dword0, BE_RXD_DRV_INFO_SZ_MASK);
+	desc_info->phy_rpt_size = le32_get_bits(rxd_s->dword0, BE_RXD_PHY_RPT_SZ_MASK);
+	desc_info->hdr_cnv_size = le32_get_bits(rxd_s->dword0, BE_RXD_HDR_CNV_SZ_MASK);
+	desc_info->shift = le32_get_bits(rxd_s->dword0, BE_RXD_SHIFT_MASK);
+	desc_info->long_rxdesc = le32_get_bits(rxd_s->dword0, BE_RXD_LONG_RXD);
+	desc_info->pkt_type = le32_get_bits(rxd_s->dword0, BE_RXD_RPKT_TYPE_MASK);
+	if (desc_info->pkt_type == RTW89_CORE_RX_TYPE_PPDU_STAT)
+		desc_info->mac_info_valid = true;
+
+	desc_info->frame_type = le32_get_bits(rxd_s->dword2, BE_RXD_TYPE_MASK);
+	desc_info->mac_id = le32_get_bits(rxd_s->dword2, BE_RXD_MAC_ID_V1);
+	desc_info->addr_cam_valid = le32_get_bits(rxd_s->dword2, BE_RXD_ADDR_CAM_VLD);
+
+	desc_info->icv_err = le32_get_bits(rxd_s->dword3, BE_RXD_ICV_ERR);
+	desc_info->crc32_err = le32_get_bits(rxd_s->dword3, BE_RXD_CRC32_ERR);
+	desc_info->hw_dec = le32_get_bits(rxd_s->dword3, BE_RXD_HW_DEC);
+	desc_info->sw_dec = le32_get_bits(rxd_s->dword3, BE_RXD_SW_DEC);
+	desc_info->addr1_match = le32_get_bits(rxd_s->dword3, BE_RXD_A1_MATCH);
+
+	desc_info->bw = le32_get_bits(rxd_s->dword4, BE_RXD_BW_MASK);
+	desc_info->data_rate = le32_get_bits(rxd_s->dword4, BE_RXD_RX_DATARATE_MASK);
+	desc_info->gi_ltf = le32_get_bits(rxd_s->dword4, BE_RXD_RX_GI_LTF_MASK);
+	desc_info->ppdu_cnt = le32_get_bits(rxd_s->dword4, BE_RXD_PPDU_CNT_MASK);
+	desc_info->ppdu_type = le32_get_bits(rxd_s->dword4, BE_RXD_PPDU_TYPE_MASK);
+
+	desc_info->free_run_cnt = le32_to_cpu(rxd_s->dword5);
+
+	shift_len = desc_info->shift << 1; /* 2-byte unit */
+	drv_info_len = desc_info->drv_info_size << 3; /* 8-byte unit */
+	phy_rtp_len = desc_info->phy_rpt_size << 3; /* 8-byte unit */
+	hdr_cnv_len = desc_info->hdr_cnv_size << 4; /* 16-byte unit */
+	desc_info->offset = data_offset + shift_len + drv_info_len +
+			    phy_rtp_len + hdr_cnv_len;
+
+	if (desc_info->long_rxdesc)
+		desc_info->rxd_len = sizeof(struct rtw89_rxdesc_long_v3);
+	else
+		desc_info->rxd_len = sizeof(struct rtw89_rxdesc_short_v3);
+	desc_info->ready = true;
+
+	if (phy_rtp_len == sizeof(*rxd_rpt)) {
+		rxd_rpt = (struct rtw89_rxdesc_phy_rpt_v2 *)(data + data_offset +
+							     desc_info->rxd_len);
+		desc_info->rssi = le32_get_bits(rxd_rpt->dword0, BE_RXD_PHY_RSSI);
+	}
+
+	if (!desc_info->long_rxdesc)
+		return;
+
+	rxd_l = (struct rtw89_rxdesc_long_v3 *)(data + data_offset);
+
+	desc_info->sr_en = le32_get_bits(rxd_l->dword6, BE_RXD_SR_EN);
+	desc_info->user_id = le32_get_bits(rxd_l->dword6, BE_RXD_USER_ID_MASK);
+	desc_info->addr_cam_id = le32_get_bits(rxd_l->dword6, BE_RXD_ADDR_CAM_V1);
+	desc_info->sec_cam_id = le32_get_bits(rxd_l->dword6, BE_RXD_SEC_CAM_IDX_V1);
+
+	desc_info->rx_pl_id = le32_get_bits(rxd_l->dword7, BE_RXD_RX_PL_ID_MASK);
+}
+EXPORT_SYMBOL(rtw89_core_query_rxdesc_v3);
+
 struct rtw89_core_iter_rx_status {
 	struct rtw89_dev *rtwdev;
 	struct ieee80211_rx_status *rx_status;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d9931bc95fcc..8678cfd3d3e4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1137,6 +1137,15 @@ struct rtw89_rxdesc_short_v2 {
 	__le32 dword5;
 } __packed;
 
+struct rtw89_rxdesc_short_v3 {
+	__le32 dword0;
+	__le32 dword1;
+	__le32 dword2;
+	__le32 dword3;
+	__le32 dword4;
+	__le32 dword5;
+} __packed;
+
 struct rtw89_rxdesc_long {
 	__le32 dword0;
 	__le32 dword1;
@@ -1161,6 +1170,19 @@ struct rtw89_rxdesc_long_v2 {
 	__le32 dword9;
 } __packed;
 
+struct rtw89_rxdesc_long_v3 {
+	__le32 dword0;
+	__le32 dword1;
+	__le32 dword2;
+	__le32 dword3;
+	__le32 dword4;
+	__le32 dword5;
+	__le32 dword6;
+	__le32 dword7;
+	__le32 dword8;
+	__le32 dword9;
+} __packed;
+
 struct rtw89_rxdesc_phy_rpt_v2 {
 	__le32 dword0;
 	__le32 dword1;
@@ -7601,6 +7623,9 @@ void rtw89_core_query_rxdesc(struct rtw89_dev *rtwdev,
 void rtw89_core_query_rxdesc_v2(struct rtw89_dev *rtwdev,
 				struct rtw89_rx_desc_info *desc_info,
 				u8 *data, u32 data_offset);
+void rtw89_core_query_rxdesc_v3(struct rtw89_dev *rtwdev,
+				struct rtw89_rx_desc_info *desc_info,
+				u8 *data, u32 data_offset);
 void rtw89_core_napi_start(struct rtw89_dev *rtwdev);
 void rtw89_core_napi_stop(struct rtw89_dev *rtwdev);
 int rtw89_core_napi_init(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index c92e25f8a2b5..b69a2529aefc 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -504,6 +504,7 @@ struct rtw89_phy_sts_iehdr {
 
 /* BE RXD dword2 */
 #define BE_RXD_MAC_ID_MASK GENMASK(7, 0)
+#define BE_RXD_MAC_ID_V1 GENMASK(9, 0)
 #define BE_RXD_TYPE_MASK GENMASK(11, 10)
 #define BE_RXD_LAST_MSDU BIT(12)
 #define BE_RXD_AMSDU_CUT BIT(13)
@@ -535,6 +536,7 @@ struct rtw89_phy_sts_iehdr {
 #define BE_RXD_QNULL BIT(22)
 #define BE_RXD_A4_FRAME BIT(23)
 #define BE_RXD_FRAG_MASK GENMASK(27, 24)
+#define BE_RXD_GET_CH_INFO_V2 GENMASK(31, 29)
 #define BE_RXD_GET_CH_INFO_V1_MASK GENMASK(31, 30)
 
 /* BE RXD dword4 */
@@ -550,10 +552,14 @@ struct rtw89_phy_sts_iehdr {
 
 /* BE RXD dword6 */
 #define BE_RXD_ADDR_CAM_MASK GENMASK(7, 0)
+#define BE_RXD_ADDR_CAM_V1 GENMASK(9, 0)
+#define BE_RXD_RX_STATISTICS_V1 BIT(11)
+#define BE_RXD_SMART_ANT_V1 BIT(12)
 #define BE_RXD_SR_EN BIT(13)
 #define BE_RXD_NON_SRG_PPDU BIT(14)
 #define BE_RXD_INTER_PPDU BIT(15)
 #define BE_RXD_USER_ID_MASK GENMASK(21, 16)
+#define BE_RXD_SEC_CAM_IDX_V1 GENMASK(31, 22)
 #define BE_RXD_RX_STATISTICS BIT(22)
 #define BE_RXD_SMART_ANT BIT(23)
 #define BE_RXD_SEC_CAM_IDX_MASK GENMASK(31, 24)
-- 
2.25.1


