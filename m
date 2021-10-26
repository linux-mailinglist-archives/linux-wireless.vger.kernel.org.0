Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A043AA7F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 04:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhJZCx4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 22:53:56 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:40615 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhJZCxz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 22:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635216692; x=1666752692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qWNXKZEUBFhXN/M7Sy4OIdMpTqWWuS/4cjm0eMEsInc=;
  b=S955UHSgJPs6SpGA2aJHD2zM3mtlt3j79XE0N5V34rfg9gr3OzfuBXQp
   8NbPrWTVvShyBncBO6/wQ8dnZs3eZ/LxqcKbLEyGbZ6YQZq6JbUlDBETd
   e3H37I/wfvr/LJurFWMIrDsiYAOo10FDvT9iVS9MqspFySrdVHqjABu/4
   s=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 19:51:32 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 19:51:31 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 19:51:30 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath10k: drop beacon and probe response which leak from other channel
Date:   Mon, 25 Oct 2021 22:51:14 -0400
Message-ID: <20211026025114.26313-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When scan request on channel 1, it also receive beacon from other
channels, and the beacon also indicate to mac80211 and wpa_supplicant,
and then the bss info appears in radio measurement report of radio
measurement sent from wpa_supplicant, thus lead RRM case fail.

This is to drop the beacon and probe response which is not the same
channel of scanning.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
This depends on commit 
97981d89a1d47942a2d7517631d2400b99fe3f93 
("cfg80211: separate get channel number from ies")

 drivers/net/wireless/ath/ath10k/wmi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index d48b922215eb..2c75fdddbf6e 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2610,6 +2610,29 @@ int ath10k_wmi_event_mgmt_rx(struct ath10k *ar, struct sk_buff *skb)
 	if (ieee80211_is_beacon(hdr->frame_control))
 		ath10k_mac_handle_beacon(ar, skb);
 
+	if (ieee80211_is_beacon(hdr->frame_control) ||
+	    ieee80211_is_probe_resp(hdr->frame_control)) {
+		struct ieee80211_mgmt *mgmt = (void *)skb->data;
+		u8 *ies;
+		int ies_ch;
+
+		if (!ar->scan_channel)
+			goto drop;
+
+		ies = mgmt->u.beacon.variable;
+
+		ies_ch = cfg80211_get_ies_channel_number(mgmt->u.beacon.variable,
+							 skb_tail_pointer(skb) - ies,
+							 sband->band);
+
+		if (ies_ch > 0 && ies_ch != channel) {
+			ath10k_dbg(ar, ATH10K_DBG_MGMT,
+				   "channel mismatched ds channel %d scan channel %d\n",
+				   ies_ch, channel);
+			goto drop;
+		}
+	}
+
 	ath10k_dbg(ar, ATH10K_DBG_MGMT,
 		   "event mgmt rx skb %pK len %d ftype %02x stype %02x\n",
 		   skb, skb->len,
@@ -2623,6 +2646,10 @@ int ath10k_wmi_event_mgmt_rx(struct ath10k *ar, struct sk_buff *skb)
 	ieee80211_rx_ni(ar->hw, skb);
 
 	return 0;
+
+drop:
+	dev_kfree_skb(skb);
+	return 0;
 }
 
 static int freq_to_idx(struct ath10k *ar, int freq)
-- 
2.31.1

