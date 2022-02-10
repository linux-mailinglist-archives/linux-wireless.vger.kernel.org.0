Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A4F4B1611
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 20:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343831AbiBJTQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 14:16:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343829AbiBJTQy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 14:16:54 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6915310BA
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=6zyPbu0mpzpCbSPZOzjaLI7jXViF1SG+MAU/UvWTaPY=; t=1644520615; x=1645730215; 
        b=Dha+3ZbFerS14dJ+BwYRIQ8tQnSgjNjNxTKn0uh7cQLUMFReZSIRMPHlzoYW+O4/adlG5jPF1da
        /pKQV+gxOA7eddt8tY+l34wgCTgA3sWFwekCox2za6sdXLfQl5AcGEPWHsoJdgAfbTOxyQrIHO1tG
        5GHFufsZc6Obp+6GTuU5DzlEt0EyF2wgUWF5AQDsnPMjKeism3LsN5xqMdACBOHrMD+JpTjGOsuiY
        amua2O4PmrIOdJqgJ4hklZkKcQIks9QcBxhetBy/QoEv4QbHhAyAzJhoukWaGCe9GJ/BuJlqx0JJz
        JsQcGlxWDvUftB1y1VwhYAcfqJgLWpZdneWg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIEw0-00HBx2-TF;
        Thu, 10 Feb 2022 20:16:53 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Beni Lev <beni.lev@intel.com>
Subject: [PATCH] mac80211_hwsim: Add command to control rx status RSSI
Date:   Thu, 10 Feb 2022 20:16:50 +0100
Message-Id: <20220210201649.dddebbb55a7f.I6c0607694587b577070339078829fcc20dfcfe2c@changeid>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Beni Lev <beni.lev@intel.com>

Set the base RSSI of a TX frame. The final RSSI of the frame will be
the base RSSI + the radio's TX power

Signed-off-by: Beni Lev <beni.lev@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 36 +++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 8d54f9face2f..ac1caf659e0b 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -503,6 +503,8 @@ static const struct ieee80211_rate hwsim_rates[] = {
 	{ .bitrate = 540 }
 };
 
+#define DEFAULT_RX_RSSI -50
+
 static const u32 hwsim_ciphers[] = {
 	WLAN_CIPHER_SUITE_WEP40,
 	WLAN_CIPHER_SUITE_WEP104,
@@ -690,6 +692,9 @@ struct mac80211_hwsim_data {
 	u64 rx_bytes;
 	u64 tx_dropped;
 	u64 tx_failed;
+
+	/* RSSI in rx status of the receiver */
+	int rx_rssi;
 };
 
 static const struct rhashtable_params hwsim_rht_params = {
@@ -964,6 +969,29 @@ DEFINE_DEBUGFS_ATTRIBUTE(hwsim_fops_group,
 			 hwsim_fops_group_read, hwsim_fops_group_write,
 			 "%llx\n");
 
+static int hwsim_fops_rx_rssi_read(void *dat, u64 *val)
+{
+	struct mac80211_hwsim_data *data = dat;
+	*val = data->rx_rssi;
+	return 0;
+}
+
+static int hwsim_fops_rx_rssi_write(void *dat, u64 val)
+{
+	struct mac80211_hwsim_data *data = dat;
+	int rssi = (int)val;
+
+	if (rssi >= 0 || rssi < -100)
+		return -EINVAL;
+
+	data->rx_rssi = rssi;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(hwsim_fops_rx_rssi,
+			hwsim_fops_rx_rssi_read, hwsim_fops_rx_rssi_write,
+			"%lld\n");
+
 static netdev_tx_t hwsim_mon_xmit(struct sk_buff *skb,
 					struct net_device *dev)
 {
@@ -1482,8 +1510,8 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 		rx_status.bw = RATE_INFO_BW_20;
 	if (info->control.rates[0].flags & IEEE80211_TX_RC_SHORT_GI)
 		rx_status.enc_flags |= RX_ENC_FLAG_SHORT_GI;
-	/* TODO: simulate real signal strength (and optional packet loss) */
-	rx_status.signal = -50;
+	/* TODO: simulate optional packet loss */
+	rx_status.signal = data->rx_rssi;
 	if (info->control.vif)
 		rx_status.signal += info->control.vif->bss_conf.txpower;
 
@@ -3309,6 +3337,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		hw->wiphy->n_cipher_suites = param->n_ciphers;
 	}
 
+	data->rx_rssi = DEFAULT_RX_RSSI;
+
 	INIT_DELAYED_WORK(&data->roc_start, hw_roc_start);
 	INIT_DELAYED_WORK(&data->roc_done, hw_roc_done);
 	INIT_DELAYED_WORK(&data->hw_scan, hw_scan_work);
@@ -3500,6 +3530,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	debugfs_create_file("ps", 0666, data->debugfs, data, &hwsim_fops_ps);
 	debugfs_create_file("group", 0666, data->debugfs, data,
 			    &hwsim_fops_group);
+	debugfs_create_file("rx_rssi", 0666, data->debugfs, data,
+			    &hwsim_fops_rx_rssi);
 	if (!data->use_chanctx)
 		debugfs_create_file("dfs_simulate_radar", 0222,
 				    data->debugfs,
-- 
2.34.1

