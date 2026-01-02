Return-Path: <linux-wireless+bounces-30272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F5ECEDF80
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 08:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97E1B303CF78
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EDE3115B1;
	Fri,  2 Jan 2026 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qi53q5bZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE7311948
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767337770; cv=none; b=CH/aK+bP+jcqkEsLspq37m7/M4zfpz8vgHlu09h6v9naE+YyiHzT5KIrLJeqLoU3yeMFLwy1RXMZW+laoGLgRzd3kFa6Ni/j6tgLbTc3VPgrKOKIr0ao11kVBTpNY/nJkSyeuKN3PPDJ48BhLqo/I4MuBEAHKB9Ny5E2zE7vsvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767337770; c=relaxed/simple;
	bh=G0qh5IpqH63co4CDwM7XpF5wgpl0WZkRepDd7EjeExk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAz2QHsY3i60cZli/Lq/DTkUo1H7FFCwlX3hATL50RwnStsNcYGRh7ib9SaBDb0ka5QTpxpPg6/OdiDfYc2mToATsfmwgp75GwINNS+G5948I/CYKZGERVTdT0NzHhVaMWmRaqWb47ZT+EcWEjtsB8T3CDam6KMEiFKIf7o1elw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qi53q5bZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60279PHN0487033, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767337765; bh=Do8pRs2t83gRqbj52PJo4l+Bo87ZKQK/v2lj6+XfJQM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qi53q5bZ/eK8y9PZxXxIML75+HvlgFUsaLX206CiuXTiEhmyz75R8+8DsEQu2TXOA
	 vZeGetUbB9lyfLnDmhHCXSdcuu081x9fUrzpAn7fLZN1sZLDdorR3eeEzN5Y4a0Sck
	 zwMW8O/59bB9kKQmS+tU7bBwY7qnrTfbXEb1YPiFB2Zc5QWCI09ylZfscj2wsitPkf
	 D5hroRhvWG4a6ALCF/XYHPzp2j+R7xr0iw38P6Cppbau4l0FePPMrrqp3IarXdVbn/
	 TIyEiFWGp4QRG6DBWv+zyH+9YU3oQRTOOyTAZJjF602eSHPQV7/7fcAtIqgW7re3I3
	 5tWdcTh+15jYg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60279PHN0487033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 2 Jan 2026 15:09:25 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 2 Jan 2026 15:09:26 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 2 Jan 2026 15:09:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 05/10] wifi: rtw89: fw: add CMAC H2C command for association for RTL8922D
Date: Fri, 2 Jan 2026 15:08:35 +0800
Message-ID: <20260102070840.62047-6-pkshih@realtek.com>
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

CMAC H2C command is to configure CMAC such as TX retry and padding. Add to
update CMAC function block according to associated peer.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 128 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h |   3 +
 2 files changed, 131 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b4667097c93f..c0cbbe299b98 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3839,6 +3839,134 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_assoc_cmac_tbl_g7);
 
+int rtw89_fw_h2c_assoc_cmac_tbl_be(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link,
+				   struct rtw89_sta_link *rtwsta_link)
+{
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
+	struct rtw89_h2c_cctlinfo_ud_be *h2c;
+	struct ieee80211_bss_conf *bss_conf;
+	struct ieee80211_link_sta *link_sta;
+	u8 pads[RTW89_PPE_BW_NUM];
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	u16 lowest_rate;
+	int ret;
+
+	memset(pads, 0, sizeof(pads));
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for assoc cmac be\n");
+		return -ENOMEM;
+	}
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+
+	if (rtwsta_link) {
+		link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+
+		if (link_sta->eht_cap.has_eht)
+			__get_sta_eht_pkt_padding(rtwdev, link_sta, pads);
+		else if (link_sta->he_cap.has_he)
+			__get_sta_he_pkt_padding(rtwdev, link_sta, pads);
+	}
+
+	if (vif->p2p)
+		lowest_rate = RTW89_HW_RATE_OFDM6;
+	else if (chan->band_type == RTW89_BAND_2G)
+		lowest_rate = RTW89_HW_RATE_CCK1;
+	else
+		lowest_rate = RTW89_HW_RATE_OFDM6;
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cctlinfo_ud_be *)skb->data;
+
+	h2c->c0 = le32_encode_bits(mac_id, BE_CCTL_INFO_C0_V1_MACID) |
+		  le32_encode_bits(1, BE_CCTL_INFO_C0_V1_OP);
+
+	h2c->w0 = le32_encode_bits(1, BE_CCTL_INFO_W0_DISRTSFB) |
+		  le32_encode_bits(1, BE_CCTL_INFO_W0_DISDATAFB);
+	h2c->m0 = cpu_to_le32(BE_CCTL_INFO_W0_DISRTSFB |
+			      BE_CCTL_INFO_W0_DISDATAFB);
+
+	h2c->w1 = le32_encode_bits(lowest_rate, BE_CCTL_INFO_W1_RTS_RTY_LOWEST_RATE);
+	h2c->m1 = cpu_to_le32(BE_CCTL_INFO_W1_RTS_RTY_LOWEST_RATE);
+
+	h2c->w2 = le32_encode_bits(0, BE_CCTL_INFO_W2_DATA_TXCNT_LMT_SEL);
+	h2c->m2 = cpu_to_le32(BE_CCTL_INFO_W2_DATA_TXCNT_LMT_SEL);
+
+	h2c->w3 = le32_encode_bits(0, BE_CCTL_INFO_W3_RTS_TXCNT_LMT_SEL);
+	h2c->m3 = cpu_to_le32(BE_CCTL_INFO_W3_RTS_TXCNT_LMT_SEL);
+
+	h2c->w4 = le32_encode_bits(rtwvif_link->port, BE_CCTL_INFO_W4_MULTI_PORT_ID);
+	h2c->m4 = cpu_to_le32(BE_CCTL_INFO_W4_MULTI_PORT_ID);
+
+	if (bss_conf->eht_support) {
+		u16 punct = bss_conf->chanreq.oper.punctured;
+
+		h2c->w4 |= le32_encode_bits(~punct,
+					    BE_CCTL_INFO_W4_ACT_SUBCH_CBW);
+		h2c->m4 |= cpu_to_le32(BE_CCTL_INFO_W4_ACT_SUBCH_CBW);
+	}
+
+	h2c->w5 = le32_encode_bits(pads[RTW89_CHANNEL_WIDTH_20],
+				   BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING0_V1) |
+		  le32_encode_bits(pads[RTW89_CHANNEL_WIDTH_40],
+				   BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING1_V1) |
+		  le32_encode_bits(pads[RTW89_CHANNEL_WIDTH_80],
+				   BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING2_V1) |
+		  le32_encode_bits(pads[RTW89_CHANNEL_WIDTH_160],
+				   BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING3_V1) |
+		  le32_encode_bits(pads[RTW89_CHANNEL_WIDTH_320],
+				   BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING4_V1);
+	h2c->m5 = cpu_to_le32(BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING0_V1 |
+			      BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING1_V1 |
+			      BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING2_V1 |
+			      BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING3_V1 |
+			      BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING4_V1);
+
+	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE) {
+		h2c->w5 |= le32_encode_bits(0, BE_CCTL_INFO_W5_DATA_DCM_V1);
+		h2c->m5 |= cpu_to_le32(BE_CCTL_INFO_W5_DATA_DCM_V1);
+	}
+
+	h2c->w6 = le32_encode_bits(vif->cfg.aid, BE_CCTL_INFO_W6_AID12_PAID) |
+		  le32_encode_bits(vif->type == NL80211_IFTYPE_STATION ? 1 : 0,
+				   BE_CCTL_INFO_W6_ULDL);
+	h2c->m6 = cpu_to_le32(BE_CCTL_INFO_W6_AID12_PAID | BE_CCTL_INFO_W6_ULDL);
+
+	if (rtwsta_link) {
+		h2c->w8 = le32_encode_bits(link_sta->he_cap.has_he,
+					   BE_CCTL_INFO_W8_BSR_QUEUE_SIZE_FORMAT_V1);
+		h2c->m8 = cpu_to_le32(BE_CCTL_INFO_W8_BSR_QUEUE_SIZE_FORMAT_V1);
+	}
+
+	rcu_read_unlock();
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_CCTLINFO_UD_G7, 0, 1,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+EXPORT_SYMBOL(rtw89_fw_h2c_assoc_cmac_tbl_be);
+
 int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif_link *rtwvif_link,
 				   struct rtw89_sta_link *rtwsta_link)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 77f0ca1e9115..cd9d12dd1700 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -5009,6 +5009,9 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif_link *rtwvif_link,
 				   struct rtw89_sta_link *rtwsta_link);
+int rtw89_fw_h2c_assoc_cmac_tbl_be(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link,
+				   struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif_link *rtwvif_link,
 				   struct rtw89_sta_link *rtwsta_link);
-- 
2.25.1


