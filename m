Return-Path: <linux-wireless+bounces-39091-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5lK1LFJ4VmqO6QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39091-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:56:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF61757A6F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:56:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=baFPRVJX;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39091-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39091-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 925E630D3B18
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353A3128CA;
	Tue, 14 Jul 2026 17:52:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05A13D503
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 17:52:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051534; cv=none; b=IlWyE6S3d0JawBPipzdWZtvkGMu2zmnETlporPYMbLTsY+DadBU8fqOKhR2AcEKQI3b90zBEd2uQtSmXhUseYZdYLUkQwJwrJNappvH5oH8iIIQidQA5pITUTYQ90mZtSBs+qP6tgkPZiKi9fxPJF2X21haxr8EYJCrdjZnF5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051534; c=relaxed/simple;
	bh=jnZxvEnZDAPn3oL4QUYVtnEmwZHmMDUiBbVPfTKJx08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYYwElxwpncDFg3fABQCQQGoFGR+u3hoTWK47PYefs65e6vfSi13ZuFr82BG9p1OutKj1s7QbMN1Cj5+eheDUvhbiK0zsAf3BOoeVVdtLvmpq6/ng4BClRpKfJWqC8qbSktROcAlvzGYvvNgclmiU+7Y4shfA0vcbL7BV09Odh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=baFPRVJX; arc=none smtp.client-ip=95.215.58.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784051527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqTooyytXZlfVBzqXtozAQEQQ+L8Mg4wXyViVCZI0F4=;
	b=baFPRVJXjLqtX373esG/7mKcSPfAfUJmYVaXP0I7qUE6KaNGD2ZD3xc0pIHp4sIg1FRwBu
	C1uzKhiphKKsXkl8ER3iFjd6D9IJPGDNvQ8ei4IZwA1hIRMveFryrPX/rsdbijuKCUnhHc
	9qc5IClFJe67AKOFNKHmK4a0by2omDc=
From: luka.gejak@linux.dev
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	straube.linux@gmail.com,
	luka.gejak@linux.dev
Subject: [RFC PATCH v1 3/9] wifi: rtw88: 8723bs: add the firmware host-to-chip interface
Date: Tue, 14 Jul 2026 19:51:01 +0200
Message-ID: <bb413d9c2319f4f2f3b0f6f3091c82e6a6758463.1784047561.git.luka.gejak@linux.dev>
In-Reply-To: <cover.1784047561.git.luka.gejak@linux.dev>
References: <cover.1784047561.git.luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-39091-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:pkshih@realtek.com,m:straube.linux@gmail.com,m:luka.gejak@linux.dev,m:straubelinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DF61757A6F

From: Luka Gejak <luka.gejak@linux.dev>

The RTL8723BS SDIO uses the Realtek vendor firmware, which speaks a
different H2C/C2H protocol than the other rtw88 chips. Add the vendor
byte-layout H2C builders (RSSI monitor, rate-adaptation MACID_CFG with
no-update gating, media status, channel info, GNT_BT and the coex antenna
reserve), route the vendor CCX TX reports (C2H 0x03/0x12, and 0x32 which
the firmware reuses for scan-probe reports) to the 8723b handler, and fix
the reserved-page BIT_BCN_VALID handshake for SDIO by clearing the beacon
download-queue and SW-beacon-select bits during the upload.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 171 ++++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/fw.h |  17 +++
 drivers/net/wireless/realtek/rtw88/rx.c |   8 +-
 3 files changed, 185 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 945fedcd375b..30091d43d908 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -315,8 +315,22 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 
 	switch (c2h->id) {
 	case C2H_CCX_TX_RPT:
+		if (rtw_is_8723bs_sdio(rtwdev)) {
+			rtw_tx_report_handle_8723b(rtwdev, c2h->id,
+						   c2h->payload, len);
+			break;
+		}
 		rtw_tx_report_handle(rtwdev, skb, C2H_CCX_TX_RPT);
 		break;
+	case C2H_VENDOR_TX_RPT:
+	case C2H_WLAN_RFON:
+		/* 8723BS SDIO: vendor management TX reports (0x12, and 0x32
+		 * which the v41 firmware reuses for scan-probe TX reports).
+		 */
+		if (rtw_is_8723bs_sdio(rtwdev))
+			rtw_tx_report_handle_8723b(rtwdev, c2h->id,
+						   c2h->payload, len);
+		break;
 	case C2H_BT_INFO:
 		rtw_coex_bt_info_notify(rtwdev, c2h->payload, len);
 		break;
@@ -365,6 +379,15 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 		rtw_coex_info_response(rtwdev, skb);
 		break;
 	case C2H_WLAN_RFON:
+		/* On 8723BS SDIO with v41 firmware, C2H 0x32 carries a scan TX
+		 * report, not a WLAN_RFON event: defer it to rtw_fw_c2h_cmd_handle().
+		 */
+		if (rtw_is_8723bs_sdio(rtwdev)) {
+			*((u32 *)skb->cb) = pkt_offset;
+			skb_queue_tail(&rtwdev->c2h_queue, skb);
+			ieee80211_queue_work(rtwdev->hw, &rtwdev->c2h_work);
+			break;
+		}
 		complete(&rtwdev->lps_leave_check);
 		dev_kfree_skb_any(skb);
 		break;
@@ -726,9 +749,19 @@ void rtw_fw_send_rssi_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 
 	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RSSI_MONITOR);
 
-	SET_RSSI_INFO_MACID(h2c_pkt, si->mac_id);
-	SET_RSSI_INFO_RSSI(h2c_pkt, rssi);
-	SET_RSSI_INFO_STBC(h2c_pkt, stbc_en);
+	if (rtw_is_8723bs_sdio(rtwdev)) {
+		/* Vendor v5.2.17 RA_INFO byte layout (H2C 0x42):
+		 * [1] mac_id, [2] 0x00, [3] rssi, [4] stbc?0x04:0x00.
+		 */
+		h2c_pkt[1] = si->mac_id & 0x7f;
+		h2c_pkt[2] = 0x00;
+		h2c_pkt[3] = rssi;
+		h2c_pkt[4] = stbc_en ? 0x04 : 0x00;
+	} else {
+		SET_RSSI_INFO_MACID(h2c_pkt, si->mac_id);
+		SET_RSSI_INFO_RSSI(h2c_pkt, rssi);
+		SET_RSSI_INFO_STBC(h2c_pkt, stbc_en);
+	}
 
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
@@ -742,6 +775,37 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 
 	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
 
+	if (rtw_is_8723bs_sdio(rtwdev)) {
+		/* The v41 firmware parses the vendor v5.2.17 MACID_CFG (0x40)
+		 * byte layout, not the bit-packed rtw88 RA_INFO below:
+		 * [1] mac_id, [2] rate_id | sgi_en(bit7),
+		 * [3] bw(bits 1-0) | no_update(bit3), [4..7] 4-byte mask.
+		 *
+		 * no_update(bit3)=1 tells the firmware to keep its existing
+		 * rate mask, so a mask that changes under no_update is dropped.
+		 * Force no_update=0 whenever the mask actually changes so the
+		 * update is applied, and keep no_update=1 for identical
+		 * refreshes so the firmware retains the rate it has learned.
+		 */
+		bool apply = reset_ra_mask || si->ra_mask != si->ra_mask_last;
+
+		h2c_pkt[1] = si->mac_id & 0x7f;
+		h2c_pkt[2] = (si->rate_id & 0x1f) |
+			     (si->sgi_enable ? BIT(7) : 0);
+		h2c_pkt[3] = ((si->bw_mode ? 3 : 1) & 0x3) |
+			     (apply ? 0 : BIT(3));
+		h2c_pkt[4] = si->ra_mask & 0xff;
+		h2c_pkt[5] = (si->ra_mask >> 8) & 0xff;
+		h2c_pkt[6] = (si->ra_mask >> 16) & 0xff;
+		h2c_pkt[7] = (si->ra_mask >> 24) & 0xff;
+
+		si->ra_mask_last = si->ra_mask;
+		si->init_ra_lv = 0;
+
+		rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+		return;
+	}
+
 	SET_RA_INFO_MACID(h2c_pkt, si->mac_id);
 	SET_RA_INFO_RATE_ID(h2c_pkt, si->rate_id);
 	SET_RA_INFO_INIT_RA_LVL(h2c_pkt, si->init_ra_lv);
@@ -780,8 +844,78 @@ void rtw_fw_media_status_report(struct rtw_dev *rtwdev, u8 mac_id, bool connect)
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
 
 	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_MEDIA_STATUS_RPT);
-	MEDIA_STATUS_RPT_SET_OP_MODE(h2c_pkt, connect);
-	MEDIA_STATUS_RPT_SET_MACID(h2c_pkt, mac_id);
+
+	if (rtw_is_8723bs_sdio(rtwdev)) {
+		/* Vendor v5.2.17 MEDIA_STATUS_RPT: connect = 21 00 00,
+		 * disconnect = 00 00 00. Byte1[0]=OPMODE, [5]=ROLE(STA=0),
+		 * [1]=MACID_IND; byte2=MACID; byte3=MACID_END.
+		 */
+		h2c_pkt[1] = connect ? 0x21 : 0x00;
+		h2c_pkt[2] = mac_id & 0x7f;
+		h2c_pkt[3] = 0x00;
+	} else {
+		MEDIA_STATUS_RPT_SET_OP_MODE(h2c_pkt, connect);
+		MEDIA_STATUS_RPT_SET_MACID(h2c_pkt, mac_id);
+	}
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+/* 8723BS SDIO: post-assoc rate-adaptation config in the vendor v5.2.17
+ * MACID_CFG byte layout. disra (bit7 of [2]) must stay 0 so the firmware keeps
+ * running rate adaptation for this mac_id.
+ */
+void rtw_fw_macid_cfg(struct rtw_dev *rtwdev, u8 mac_id, u8 raid, u8 bw,
+		      u8 sgi, u32 rate_mask)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
+
+	h2c_pkt[1] = mac_id & 0x7f;
+	h2c_pkt[2] = (raid & 0x1f) | (sgi ? BIT(7) : 0) | 0x60;
+	h2c_pkt[3] = (bw ? 3 : 1) & 0x3;
+	h2c_pkt[4] = rate_mask & 0xff;
+	h2c_pkt[5] = (rate_mask >> 8) & 0xff;
+	h2c_pkt[6] = (rate_mask >> 16) & 0xff;
+	h2c_pkt[7] = (rate_mask >> 24) & 0xff;
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+/* 8723BS SDIO: report the connected channel/bandwidth to the vendor firmware. */
+void rtw_fw_send_wl_ch_info(struct rtw_dev *rtwdev, u8 ch, u8 bw)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+	u8 bw_byte = bw == RTW_CHANNEL_WIDTH_40 ? 0x30 : 0x20;
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_WL_CH_INFO);
+	h2c_pkt[1] = 0x00;
+	h2c_pkt[2] = ch;
+	h2c_pkt[3] = bw_byte;
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+/* 8723BS SDIO: set the firmware GNT_BT state (0 = WiFi owns the antenna). */
+void rtw_fw_set_gnt_bt(struct rtw_dev *rtwdev, u8 state)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_GNT_BT);
+	SET_GNT_BT_STATE(h2c_pkt, state);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+/* 8723BS SDIO: vendor coex antenna-select reserve H2C (part of the init toggle). */
+void rtw_fw_coex_ant_sel_rsv(struct rtw_dev *rtwdev, u8 inverse, u8 type)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_COEX_ANT_SEL_RSV);
+	SET_COEX_ANT_SEL_RSV_INVERSE(h2c_pkt, inverse);
+	SET_COEX_ANT_SEL_RSV_TYPE(h2c_pkt, type);
 
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
@@ -1466,10 +1600,14 @@ void rtw_add_rsvd_page_sta(struct rtw_dev *rtwdev,
 	rtw_add_rsvd_page(rtwdev, rtwvif, RSVD_LPS_PG_INFO, true);
 }
 
+/* REG_DWBCN1_CTRL bit 20 (SW_BCN_SEL for port 0), relative to byte +2 */
+#define BIT_OFFSET_DWBCN1_SW_BCN_SEL_PORT0	(20 - 16)
+
 int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 				u8 *buf, u32 size)
 {
-	u8 bckp[3];
+	const bool is_8723bs_sdio = rtw_is_8723bs_sdio(rtwdev);
+	u8 bckp[4];
 	u8 val;
 	u16 rsvd_pg_head;
 	u32 bcn_valid_addr;
@@ -1499,13 +1637,28 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 	rtw_write8(rtwdev, REG_BCN_CTRL,
 		   (bckp[2] & ~BIT_EN_BCN_FUNCTION) | BIT_DIS_TSF_UDT);
 
-	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE) {
+	/* Clear BIT_EN_BCNQ_DL so the chip does not treat the reserved-page
+	 * upload as a real beacon; otherwise BIT_BCN_VALID never asserts. The
+	 * vendor rtl8723bs driver does this unconditionally; rtw88 only did it
+	 * for PCIe, which left 8723BS SDIO's BCN_VALID handshake failing.
+	 */
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE || is_8723bs_sdio) {
 		val = rtw_read8(rtwdev, REG_FWHW_TXQ_CTRL + 2);
 		bckp[1] = val;
 		val &= ~(BIT_EN_BCNQ_DL >> 16);
 		rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, val);
 	}
 
+	/* 8723BS SDIO: point the SW beacon download path at port 0, else
+	 * BIT_BCN_VALID is never asserted after the SDIO upload completes.
+	 */
+	if (is_8723bs_sdio) {
+		val = rtw_read8(rtwdev, REG_DWBCN1_CTRL + 2);
+		bckp[3] = val;
+		val &= ~BIT(BIT_OFFSET_DWBCN1_SW_BCN_SEL_PORT0);
+		rtw_write8(rtwdev, REG_DWBCN1_CTRL + 2, val);
+	}
+
 	ret = rtw_hci_write_data_rsvd_page(rtwdev, buf, size);
 	if (ret) {
 		rtw_err(rtwdev, "failed to write data to rsvd page\n");
@@ -1526,11 +1679,13 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 	}
 
 restore:
+	if (is_8723bs_sdio)
+		rtw_write8(rtwdev, REG_DWBCN1_CTRL + 2, bckp[3]);
 	rsvd_pg_head = rtwdev->fifo.rsvd_boundary;
 	rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2,
 		    rsvd_pg_head | BIT_BCN_VALID_V1);
 	rtw_write8(rtwdev, REG_BCN_CTRL, bckp[2]);
-	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE)
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE || is_8723bs_sdio)
 		rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, bckp[1]);
 	rtw_write8(rtwdev, REG_CR + 1, bckp[0]);
 
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 48ad9ceab6ea..8b238b41decf 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -54,6 +54,10 @@ enum rtw_c2h_cmd_id {
 	C2H_BT_MP_INFO = 0x0b,
 	C2H_BT_HID_INFO = 0x45,
 	C2H_RA_RPT = 0x0c,
+	/* 8723BS SDIO vendor v41 firmware management TX report (0x32 is
+	 * reported as C2H_WLAN_RFON, handled per-chip in the C2H dispatch).
+	 */
+	C2H_VENDOR_TX_RPT = 0x12,
 	C2H_HW_FEATURE_REPORT = 0x19,
 	C2H_WLAN_INFO = 0x27,
 	C2H_WLAN_RFON = 0x32,
@@ -568,10 +572,12 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_QUERY_BT_INFO		0x61
 #define H2C_CMD_FORCE_BT_TX_POWER	0x62
 #define H2C_CMD_IGNORE_WLAN_ACTION	0x63
+#define H2C_CMD_COEX_ANT_SEL_RSV	0x65
 #define H2C_CMD_WL_CH_INFO		0x66
 #define H2C_CMD_QUERY_BT_MP_INFO	0x67
 #define H2C_CMD_BT_WIFI_CONTROL		0x69
 #define H2C_CMD_WIFI_CALIBRATION	0x6d
+#define H2C_CMD_GNT_BT			0x6e
 #define H2C_CMD_QUERY_BT_HID_INFO	0x73
 
 #define H2C_CMD_KEEP_ALIVE		0x03
@@ -684,6 +690,12 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(31, 24))
 #define SET_QUERY_BT_INFO(h2c_pkt, value)                                      \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+#define SET_GNT_BT_STATE(h2c_pkt, value)                                       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+#define SET_COEX_ANT_SEL_RSV_INVERSE(h2c_pkt, value)                           \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 8))
+#define SET_COEX_ANT_SEL_RSV_TYPE(h2c_pkt, value)                              \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
 #define SET_WL_CH_INFO_LINK(h2c_pkt, value)                                    \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 8))
 #define SET_WL_CH_INFO_CHNL(h2c_pkt, value)                                    \
@@ -849,6 +861,11 @@ void rtw_fw_send_rssi_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
 void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 			 bool reset_ra_mask);
 void rtw_fw_media_status_report(struct rtw_dev *rtwdev, u8 mac_id, bool conn);
+void rtw_fw_macid_cfg(struct rtw_dev *rtwdev, u8 mac_id, u8 raid, u8 bw,
+		      u8 sgi, u32 rate_mask);
+void rtw_fw_send_wl_ch_info(struct rtw_dev *rtwdev, u8 ch, u8 bw);
+void rtw_fw_set_gnt_bt(struct rtw_dev *rtwdev, u8 state);
+void rtw_fw_coex_ant_sel_rsv(struct rtw_dev *rtwdev, u8 inverse, u8 type);
 void rtw_fw_update_wl_phy_info(struct rtw_dev *rtwdev);
 void rtw_fw_beacon_filter_config(struct rtw_dev *rtwdev, bool connect,
 				 struct ieee80211_vif *vif);
diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 01fd299abb7f..57facbc1b41f 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -253,10 +253,12 @@ static void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
 
 	rtw_rx_addr_match(rtwdev, pkt_stat, hdr);
 
-	/* Rtl8723cs driver checks for size < 14 or size > 8192 and
-	 * simply drops the packet.
+	/* Rtl8723cs and rtl8723bs drivers check for size < 14 or size > 8192
+	 * and simply drop the packet.
 	 */
-	if (rtwdev->chip->id == RTW_CHIP_TYPE_8703B && pkt_stat->pkt_len == 0) {
+	if ((rtwdev->chip->id == RTW_CHIP_TYPE_8703B ||
+	     rtwdev->chip->id == RTW_CHIP_TYPE_8723B) &&
+	    pkt_stat->pkt_len == 0) {
 		rx_status->flag |= RX_FLAG_NO_PSDU;
 		rtw_dbg(rtwdev, RTW_DBG_RX, "zero length packet");
 	}
-- 
2.55.0


