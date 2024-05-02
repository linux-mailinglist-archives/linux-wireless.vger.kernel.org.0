Return-Path: <linux-wireless+bounces-7099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD2D8B9371
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 04:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF44B22B99
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 02:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00797179BD;
	Thu,  2 May 2024 02:26:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3817997
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616774; cv=none; b=E3AEB5uOARKvZQtitB1JeyoyhgEr/cHJjo1ZPdDD3R1RED5d1XPXf9NjYLDWkNemU/LuYxjCQyLhDH4TW6v+reOFv14bNB9ZXXbFh+gZRq/rX0bTpfb0Voi1q7XB+p5tRnRunZohAwmdxzG+V9uD53jsZAz7ByTat0v0Pfh5u34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616774; c=relaxed/simple;
	bh=Y12EvOeEJLOlFzrIANMotfbZ4QSqef+wz2fX7hCMjqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMYOLZzkGXMQ28RghtdldE8LbYs5DfOfJE6T920c6/6BXN43XaYfPrMZmSvZ/Usla1bxbp9/DF3+U7ScjXjHufo/3c8hEDah4CFb5zT+MQmCasAB0m88ci07hyFAMNwQKfv0ZMu+uOKM5VSf/9ljUjPu79xvbHKnFlWSkM4HMhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4422QBSE02027818, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4422QBSE02027818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 2 May 2024 10:26:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 10:26:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 10:26:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH v2 12/12] wifi: rtw89: wow: add ARP offload feature
Date: Thu, 2 May 2024 10:25:05 +0800
Message-ID: <20240502022505.28966-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502022505.28966-1-pkshih@realtek.com>
References: <20240502022505.28966-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chin-Yen Lee <timlee@realtek.com>

Add H2C command and offload template packet to allow firmware send ARP
response in WoWLAN mode. Then, firmware in WoWLAN mode can interactive
with peer that issue ARP request to query MAC address.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 108 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       |  14 +++
 drivers/net/wireless/realtek/rtw89/mac80211.c |   3 +
 drivers/net/wireless/realtek/rtw89/wow.c      |   8 ++
 5 files changed, 134 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1aa25a3f3659..e03645bb27b7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3341,6 +3341,7 @@ struct rtw89_vif {
 	u8 port;
 	u8 mac_addr[ETH_ALEN];
 	u8 bssid[ETH_ALEN];
+	__be32 ip_addr;
 	u8 phy_idx;
 	u8 mac_idx;
 	u8 net_type;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 444badc3eede..044a5b90c7f4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include <linux/if_arp.h>
 #include "cam.h"
 #include "chan.h"
 #include "coex.h"
@@ -26,6 +27,17 @@ struct rtw89_sa_query {
 	u8 action;
 } __packed __aligned(2);
 
+struct rtw89_arp_rsp {
+	struct ieee80211_hdr_3addr addr;
+	u8 llc_hdr[sizeof(rfc1042_header)];
+	__be16 llc_type;
+	struct arphdr arp_hdr;
+	u8 sender_hw[ETH_ALEN];
+	__be32 sender_ip;
+	u8 target_hw[ETH_ALEN];
+	__be32 target_ip;
+} __packed __aligned(2);
+
 static const u8 mss_signature[] = {0x4D, 0x53, 0x53, 0x4B, 0x50, 0x4F, 0x4F, 0x4C};
 
 union rtw89_fw_element_arg {
@@ -2223,6 +2235,48 @@ static struct sk_buff *rtw89_sa_query_get(struct rtw89_dev *rtwdev,
 	return skb;
 }
 
+static struct sk_buff *rtw89_arp_response_get(struct rtw89_dev *rtwdev,
+					      struct rtw89_vif *rtwvif)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_arp_rsp *arp_skb;
+	struct arphdr *arp_hdr;
+	struct sk_buff *skb;
+	__le16 fc;
+
+	skb = dev_alloc_skb(sizeof(struct rtw89_arp_rsp));
+	if (!skb)
+		return NULL;
+
+	arp_skb = skb_put_zero(skb, sizeof(*arp_skb));
+
+	if (rtw_wow->ptk_alg)
+		fc = cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_FCTL_TODS |
+				 IEEE80211_FCTL_PROTECTED);
+	else
+		fc = cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_FCTL_TODS);
+
+	arp_skb->addr.frame_control = fc;
+	ether_addr_copy(arp_skb->addr.addr1, rtwvif->bssid);
+	ether_addr_copy(arp_skb->addr.addr2, rtwvif->mac_addr);
+	ether_addr_copy(arp_skb->addr.addr3, rtwvif->bssid);
+
+	memcpy(arp_skb->llc_hdr, rfc1042_header, sizeof(rfc1042_header));
+	arp_skb->llc_type = htons(ETH_P_ARP);
+
+	arp_hdr = &arp_skb->arp_hdr;
+	arp_hdr->ar_hrd = htons(ARPHRD_ETHER);
+	arp_hdr->ar_pro = htons(ETH_P_IP);
+	arp_hdr->ar_hln = ETH_ALEN;
+	arp_hdr->ar_pln = 4;
+	arp_hdr->ar_op = htons(ARPOP_REPLY);
+
+	ether_addr_copy(arp_skb->sender_hw, rtwvif->mac_addr);
+	arp_skb->sender_ip = rtwvif->ip_addr;
+
+	return skb;
+}
+
 static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif,
 					enum rtw89_fw_pkt_ofld_type type,
@@ -2256,6 +2310,9 @@ static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 	case RTW89_PKT_OFLD_TYPE_SA_QUERY:
 		skb = rtw89_sa_query_get(rtwdev, rtwvif);
 		break;
+	case RTW89_PKT_OFLD_TYPE_ARP_RSP:
+		skb = rtw89_arp_response_get(rtwdev, rtwvif);
+		break;
 	default:
 		goto err;
 	}
@@ -6390,6 +6447,57 @@ int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	return ret;
 }
 
+int rtw89_fw_h2c_arp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			     bool enable)
+{
+	struct rtw89_h2c_arp_offload *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	u8 pkt_id = 0;
+	int ret;
+
+	if (enable) {
+		ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+						   RTW89_PKT_OFLD_TYPE_ARP_RSP,
+						   &pkt_id);
+		if (ret)
+			return ret;
+	}
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for arp offload\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_arp_offload *)skb->data;
+
+	h2c->w0 = le32_encode_bits(enable, RTW89_H2C_ARP_OFFLOAD_W0_ENABLE) |
+		  le32_encode_bits(0, RTW89_H2C_ARP_OFFLOAD_W0_ACTION) |
+		  le32_encode_bits(rtwvif->mac_id, RTW89_H2C_ARP_OFFLOAD_W0_MACID) |
+		  le32_encode_bits(pkt_id, RTW89_H2C_ARP_OFFLOAD_W0_PKT_ID);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_WOW,
+			      H2C_FUNC_ARP_OFLD, 0, 1,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 #define H2C_DISCONNECT_DETECT_LEN 8
 int rtw89_fw_h2c_disconnect_detect(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif *rtwvif, bool enable)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 5e51267558ad..4151c9d566bd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2025,6 +2025,17 @@ struct rtw89_h2c_wow_gtk_ofld {
 #define RTW89_H2C_WOW_GTK_OFLD_W1_PMF_BIP_SEC_ALGO GENMASK(9, 8)
 #define RTW89_H2C_WOW_GTK_OFLD_W1_ALGO_AKM_SUIT GENMASK(17, 10)
 
+struct rtw89_h2c_arp_offload {
+	__le32 w0;
+	__le32 w1;
+} __packed;
+
+#define RTW89_H2C_ARP_OFFLOAD_W0_ENABLE BIT(0)
+#define RTW89_H2C_ARP_OFFLOAD_W0_ACTION BIT(1)
+#define RTW89_H2C_ARP_OFFLOAD_W0_MACID GENMASK(23, 16)
+#define RTW89_H2C_ARP_OFFLOAD_W0_PKT_ID GENMASK(31, 24)
+#define RTW89_H2C_ARP_OFFLOAD_W1_CONTENT GENMASK(31, 0)
+
 enum rtw89_btc_btf_h2c_class {
 	BTFC_SET = 0x10,
 	BTFC_GET = 0x11,
@@ -3919,6 +3930,7 @@ enum rtw89_wow_h2c_func {
 	H2C_FUNC_DISCONNECT_DETECT	= 0x1,
 	H2C_FUNC_WOW_GLOBAL		= 0x2,
 	H2C_FUNC_GTK_OFLD		= 0x3,
+	H2C_FUNC_ARP_OFLD		= 0x4,
 	H2C_FUNC_WAKEUP_CTRL		= 0x8,
 	H2C_FUNC_WOW_CAM_UPD		= 0xC,
 	H2C_FUNC_AOAC_REPORT_REQ	= 0xD,
@@ -4436,6 +4448,8 @@ int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif, bool enable);
 int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			    bool enable);
+int rtw89_fw_h2c_arp_offload(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif *rtwvif, bool enable);
 int rtw89_fw_h2c_disconnect_detect(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif *rtwvif, bool enable);
 int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 2fd23f79544d..ca4938eed23c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -473,6 +473,9 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_PS)
 		rtw89_recalc_lps(rtwdev);
 
+	if (changed & BSS_CHANGED_ARP_FILTER)
+		rtwvif->ip_addr = vif->cfg.arp_addr_list[0];
+
 	mutex_unlock(&rtwdev->mutex);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 434b29ae8ae9..fa61484c3839 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1320,6 +1320,10 @@ static int rtw89_wow_fw_start(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
+	ret = rtw89_fw_h2c_arp_offload(rtwdev, rtwvif, true);
+	if (ret)
+		rtw89_warn(rtwdev, "wow: failed to enable arp offload\n");
+
 	ret = rtw89_wow_cfg_wake(rtwdev, true);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to config wake\n");
@@ -1362,6 +1366,10 @@ static int rtw89_wow_fw_stop(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
+	ret = rtw89_fw_h2c_arp_offload(rtwdev, rtwvif, false);
+	if (ret)
+		rtw89_warn(rtwdev, "wow: failed to disable arp offload\n");
+
 	rtw89_wow_key_clear(rtwdev);
 	rtw89_fw_release_general_pkt_list(rtwdev, true);
 
-- 
2.25.1


