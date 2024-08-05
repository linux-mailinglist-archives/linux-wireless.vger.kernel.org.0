Return-Path: <linux-wireless+bounces-10950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB2E9477E1
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 11:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA112B22B64
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDDD155312;
	Mon,  5 Aug 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="h6twNxFh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038AD153BD9
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848476; cv=none; b=EvP0kQnqeFpIETt7cyU7k0HkJIGAjvVHGT0UVykRqncMEhIMRJOoTwJ6eL4gqVbAXSZ0z7xNpOw0ngSEMFdw1mF0O9pPZnq8DPYklA13sIdC3pVKh2EVBtfmIa2MZDE8P0zHqQPMblDUL+K9zBfAo90Dutz+lnbrPPqovbgVeZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848476; c=relaxed/simple;
	bh=vQDBaq1BtRSeQjJm97aL2LMz5lh2VRkFiPJohBUnR2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3lz5HvE4dcem0vqIt4l/JlUDhU+xJbyL3ylPPE7mFJZG8C8p3H54Ot1AycPhvZalCcyt58f5a64tlavSLFIZx/PIt7oK4VpGTpldRpxQ3RqYU+FACgjE1bO3kP/QU3Xfq9RCmm1ju0R7TWTWp/yVNE5UDcc8xYLrZ/RNZM94ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=h6twNxFh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47591BX803834744, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722848471; bh=vQDBaq1BtRSeQjJm97aL2LMz5lh2VRkFiPJohBUnR2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=h6twNxFhjLxXUerXEHV6w1VDGRPHc4aKFSX6gMWxpRaMqP1gcBxlP8bLie8VgaiRc
	 b4/5l6sX+OK0EaG9bV9ZsOXf4/KN4l6Qa6/Jr40kWXdngEIj0SS+RQM1izkem2UcIY
	 rQO4A1uxbDDirRXcIpMHvvff2kYENaA4vxjqDCbhg6SPdTf3Uo+DdkmyCrKcWfI5zV
	 YrhtjR3FCPzVHGnIbg+I29kl+qCGscY6aizyPGHS3/dvdWZwtld91k3NV4uUrRbv/C
	 qhqhit39+RoR2inUS33NEzLZwMdMNkB+jfqyrldvSZyGuq5r8xkSjtDLQJfUgqvhep
	 69vzTmL4fc0rg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47591BX803834744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 Aug 2024 17:01:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 17:01:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 Aug
 2024 17:01:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH 4/5] wifi: rtw89: wow: add delay option for net-detect
Date: Mon, 5 Aug 2024 17:00:27 +0800
Message-ID: <20240805090028.27768-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240805090028.27768-1-pkshih@realtek.com>
References: <20240805090028.27768-1-pkshih@realtek.com>
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

The delay option is the period in unit of second for WoWLAN firmware
to wait before the first scan. We get the option from cfg80211 and
practice it. Another, in some platform, WoWLAN firmware may found
configured network and then trigger resume process, before suspend
process is completed, lead to the wakeup function failed.
So the default value is set one to avoid the issue.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 24 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h   |  3 +++
 drivers/net/wireless/realtek/rtw89/wow.c  |  2 ++
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f40475a94d11..b42a33b9868a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3677,6 +3677,7 @@ struct rtw89_scan_option {
 	u16 slow_pd;
 	u16 norm_cy;
 	u8 opch_end;
+	u16 delay;
 	u64 prohib_chan;
 	enum rtw89_phy_idx band;
 	enum rtw89_scan_be_operation operation;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2a55f47a0ac8..47aa365991c1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4808,6 +4808,7 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 	return 0;
 }
 
+#define RTW89_SCAN_DELAY_TSF_UNIT 104800
 int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 				 struct rtw89_scan_option *option,
 				 struct rtw89_vif *rtwvif,
@@ -4815,10 +4816,12 @@ int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
 	struct rtw89_chan *op = &rtwdev->scan_info.op_chan;
+	enum rtw89_scan_mode scan_mode = RTW89_SCAN_IMMEDIATE;
 	struct rtw89_h2c_scanofld *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	unsigned int cond;
+	u64 tsf = 0;
 	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
@@ -4829,6 +4832,17 @@ int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_scanofld *)skb->data;
 
+	if (option->delay) {
+		ret = rtw89_mac_port_get_tsf(rtwdev, rtwvif, &tsf);
+		if (ret) {
+			rtw89_warn(rtwdev, "NLO failed to get port tsf: %d\n", ret);
+			scan_mode = RTW89_SCAN_IMMEDIATE;
+		} else {
+			scan_mode = RTW89_SCAN_DELAY;
+			tsf += option->delay * RTW89_SCAN_DELAY_TSF_UNIT;
+		}
+	}
+
 	h2c->w0 = le32_encode_bits(rtwvif->mac_id, RTW89_H2C_SCANOFLD_W0_MACID) |
 		  le32_encode_bits(rtwvif->port, RTW89_H2C_SCANOFLD_W0_PORT_ID) |
 		  le32_encode_bits(RTW89_PHY_0, RTW89_H2C_SCANOFLD_W0_BAND) |
@@ -4837,8 +4851,7 @@ int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 	h2c->w1 = le32_encode_bits(true, RTW89_H2C_SCANOFLD_W1_NOTIFY_END) |
 		  le32_encode_bits(option->target_ch_mode,
 				   RTW89_H2C_SCANOFLD_W1_TARGET_CH_MODE) |
-		  le32_encode_bits(RTW89_SCAN_IMMEDIATE,
-				   RTW89_H2C_SCANOFLD_W1_START_MODE) |
+		  le32_encode_bits(scan_mode, RTW89_H2C_SCANOFLD_W1_START_MODE) |
 		  le32_encode_bits(option->repeat, RTW89_H2C_SCANOFLD_W1_SCAN_TYPE);
 
 	h2c->w2 = le32_encode_bits(option->norm_pd, RTW89_H2C_SCANOFLD_W2_NORM_PD) |
@@ -4855,6 +4868,11 @@ int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 					    RTW89_H2C_SCANOFLD_W0_TARGET_CH_BAND);
 	}
 
+	h2c->tsf_high = le32_encode_bits(upper_32_bits(tsf),
+					 RTW89_H2C_SCANOFLD_W3_TSF_HIGH);
+	h2c->tsf_low = le32_encode_bits(lower_32_bits(tsf),
+					RTW89_H2C_SCANOFLD_W4_TSF_LOW);
+
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
 			      H2C_FUNC_SCANOFLD, 1, 1,
@@ -4972,7 +4990,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 				   RTW89_H2C_SCANOFLD_BE_W4_PROBE_5G) |
 		  le32_encode_bits(probe_id[NL80211_BAND_6GHZ],
 				   RTW89_H2C_SCANOFLD_BE_W4_PROBE_6G) |
-		  le32_encode_bits(0, RTW89_H2C_SCANOFLD_BE_W4_DELAY_START);
+		  le32_encode_bits(option->delay, RTW89_H2C_SCANOFLD_BE_W4_DELAY_START);
 
 	h2c->w5 = le32_encode_bits(option->mlo_mode, RTW89_H2C_SCANOFLD_BE_W5_MLO_MODE);
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index d45355e5b2e8..663eda5d0452 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2107,6 +2107,7 @@ enum rtw89_btc_cxdrvinfo {
 
 enum rtw89_scan_mode {
 	RTW89_SCAN_IMMEDIATE,
+	RTW89_SCAN_DELAY,
 };
 
 enum rtw89_scan_type {
@@ -2686,6 +2687,8 @@ struct rtw89_h2c_scanofld {
 #define RTW89_H2C_SCANOFLD_W1_PROBE_REQ_PKT_ID GENMASK(31, 24)
 #define RTW89_H2C_SCANOFLD_W2_NORM_PD GENMASK(15, 0)
 #define RTW89_H2C_SCANOFLD_W2_SLOW_PD GENMASK(23, 16)
+#define RTW89_H2C_SCANOFLD_W3_TSF_HIGH GENMASK(31, 0)
+#define RTW89_H2C_SCANOFLD_W4_TSF_LOW GENMASK(31, 0)
 
 struct rtw89_h2c_scanofld_be_macc_role {
 	__le32 w0;
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 3bf563998ddf..0f0f4beec4d9 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1458,6 +1458,8 @@ static int rtw89_pno_scan_offload(struct rtw89_dev *rtwdev, bool enable)
 	opt.enable = enable;
 	opt.repeat = RTW89_SCAN_NORMAL;
 	opt.norm_pd = 10; /* in unit of 100ms */
+	opt.delay = max(rtw_wow->nd_config->delay, 1);
+
 	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
 		opt.operation = enable ? RTW89_SCAN_OP_START : RTW89_SCAN_OP_STOP;
 		opt.scan_mode = RTW89_SCAN_MODE_SA;
-- 
2.25.1


