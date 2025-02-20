Return-Path: <linux-wireless+bounces-19170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 799ADA3D181
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 07:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70957188DE79
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 06:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605DA5223;
	Thu, 20 Feb 2025 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YGaDBpuG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508611C5D5E
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033883; cv=none; b=tfGSfnhvuHsLi9NF1uImocchcQzAwf6fZFbjDg1z/HXKTySRB3Sk0kRn23KsGbGOvd1VwLyW9dFrHz5wRL/VB9YLjlVp4RQ4KpVNlsVbpcar2oDsLNFMQ6pLUNh0iH2uP+yn5ES9iTFL1kc1wQd2witqGMAALsx03Fk+7q7C770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033883; c=relaxed/simple;
	bh=pEMbmpDqncFsJ9KSh804r+vBx9ic33Z1Bx+AmrqoWgY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B3Rs47kHGkpFi+PuCF/KpwRFRvP02y72LhJ5D2fDP9ESG26Z2ZWMHVfRg37d38UytTGT6dFsoOe354AafhoyAbKVJxt+9a9smU2xEJBou/k5uhu3G33jUPnlJfILYkTDlB6wLnCTt3vW+HQnHk1T3UadSeXGa/CR7N1Lv24fv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YGaDBpuG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51K6ibVuB722637, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740033877; bh=pEMbmpDqncFsJ9KSh804r+vBx9ic33Z1Bx+AmrqoWgY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=YGaDBpuG+hT2tmBWYDq5TSJFi6o+fH0ASKPQc8GuIFKvIGcH62zTWBL3FrOucb06y
	 sIi2FRoFg40xzx+ZkHKj/vgrKoQSuT2Vln7fJ7qFqrqAC68Kj8vOs0iixk7HsAKkQ2
	 Lh6SyDP2Ntr4uq7t9jE+CWQhpnhPzSywtJ1UPJGAGqpKo82HffA/7MW1wONYusQgBF
	 oQ8w8NPEtlHlLCg+Gza4eACESPOScsB/Ylm8D1zWyIiCAtbQWDTPc+XyTS5FSNM6Pp
	 dfjG5Ul9o1CJBxKaI8nYhKo7ZgL8Ief0F7Z+2NQWH1cbEAALcXDIk06qhMTO8vTu7J
	 RNOpdscjLMvSQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51K6ibVuB722637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 14:44:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Feb 2025 14:44:38 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Feb
 2025 14:44:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH] wifi: rtw89: Parse channel from IE to correct invalid hardware reports during scanning
Date: Thu, 20 Feb 2025 14:43:57 +0800
Message-ID: <20250220064357.17962-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

From: Chih-Kang Chang <gary.chang@realtek.com>

For some packets, we could not get channel information from PPDU status.
And this causes wrong frequencies being reported. Parse the channel
information from IE if provided by AP to fix this.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 44 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 8 files changed, 51 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 8d5dc22fb508..4d286182e21d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2382,6 +2382,49 @@ static void rtw89_core_validate_rx_signal(struct ieee80211_rx_status *rx_status)
 		rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 }
 
+static void rtw89_core_update_rx_freq_from_ie(struct rtw89_dev *rtwdev,
+					      struct sk_buff *skb,
+					      struct ieee80211_rx_status *rx_status)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	size_t hdr_len, ielen;
+	u8 *variable;
+	int chan;
+
+	if (!rtwdev->chip->rx_freq_frome_ie)
+		return;
+
+	if (!rtwdev->scanning)
+		return;
+
+	if (ieee80211_is_beacon(mgmt->frame_control)) {
+		variable = mgmt->u.beacon.variable;
+		hdr_len = offsetof(struct ieee80211_mgmt,
+				   u.beacon.variable);
+	} else if (ieee80211_is_probe_resp(mgmt->frame_control)) {
+		variable = mgmt->u.probe_resp.variable;
+		hdr_len = offsetof(struct ieee80211_mgmt,
+				   u.probe_resp.variable);
+	} else {
+		return;
+	}
+
+	if (skb->len > hdr_len)
+		ielen = skb->len - hdr_len;
+	else
+		return;
+
+	/* The parsing code for both 2GHz and 5GHz bands is the same in this
+	 * function.
+	 */
+	chan = cfg80211_get_ies_channel_number(variable, ielen, NL80211_BAND_2GHZ);
+	if (chan == -1)
+		return;
+
+	rx_status->band = chan > 14 ? RTW89_BAND_5G : RTW89_BAND_2G;
+	rx_status->freq = ieee80211_channel_to_frequency(chan, rx_status->band);
+}
+
 static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 				      struct rtw89_rx_phy_ppdu *phy_ppdu,
 				      struct rtw89_rx_desc_info *desc_info,
@@ -2399,6 +2442,7 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 	rtw89_core_update_rx_status_by_ppdu(rtwdev, rx_status, phy_ppdu);
 	rtw89_core_update_radiotap(rtwdev, skb_ppdu, rx_status);
 	rtw89_core_validate_rx_signal(rx_status);
+	rtw89_core_update_rx_freq_from_ie(rtwdev, skb_ppdu, rx_status);
 
 	/* In low power mode, it does RX in thread context. */
 	local_bh_disable();
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 676f5e21744f..50a608a0c2be 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4279,6 +4279,7 @@ struct rtw89_chip_info {
 	bool support_ant_gain;
 	bool ul_tb_waveform_ctrl;
 	bool ul_tb_pwr_diff;
+	bool rx_freq_frome_ie;
 	bool hw_sec_hdr;
 	bool hw_mgmt_tx_encrypt;
 	bool hw_tkip_crypto;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index e5ccd55655b6..76a66b19567b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2498,6 +2498,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.support_ant_gain	= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
+	.rx_freq_frome_ie	= true,
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt	= false,
 	.hw_tkip_crypto		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 42642135d274..e8c1cf2917d9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2216,6 +2216,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.support_ant_gain	= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
+	.rx_freq_frome_ie	= true,
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt	= false,
 	.hw_tkip_crypto		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index e9ff6bcdd9ec..e36b171a0382 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -852,6 +852,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.support_ant_gain	= true,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
+	.rx_freq_frome_ie	= true,
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt	= false,
 	.hw_tkip_crypto		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 2f5804f77f9d..ec8243926479 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -785,6 +785,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.support_ant_gain	= true,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
+	.rx_freq_frome_ie	= true,
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt     = false,
 	.hw_tkip_crypto		= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 89f258b98e75..6494239ac1f5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3011,6 +3011,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.support_ant_gain	= true,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= true,
+	.rx_freq_frome_ie	= false,
 	.hw_sec_hdr		= true,
 	.hw_mgmt_tx_encrypt	= true,
 	.hw_tkip_crypto		= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 99221677065c..9cf6aed456cf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2770,6 +2770,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.support_ant_gain	= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
+	.rx_freq_frome_ie	= false,
 	.hw_sec_hdr		= true,
 	.hw_mgmt_tx_encrypt	= true,
 	.hw_tkip_crypto		= true,
-- 
2.25.1


