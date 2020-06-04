Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5361EDDFF
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFDH1C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgFDH1C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:27:02 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C2AC05BD1E
        for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2020 00:27:02 -0700 (PDT)
Received: from [46.59.202.224] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jgk0n-0001P3-SY; Thu, 04 Jun 2020 09:10:01 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 12/12] ath11k: set the multiple bssid hw cap
Date:   Thu,  4 Jun 2020 09:09:52 +0200
Message-Id: <20200604070952.15481-13-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604070952.15481-1-john@phrozen.org>
References: <20200604070952.15481-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch sets the SUPPORTS_MULTI_BSSID inside ath11k.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++++
 drivers/net/wireless/ath/ath11k/wmi.h | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8ec11c654b3e..55876600b7c5 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5980,17 +5980,20 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 
 static const u8 ath11k_if_types_ext_capa[] = {
 	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 };
 
 static const u8 ath11k_if_types_ext_capa_sta[] = {
 	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 	[9] = WLAN_EXT_CAPA10_TWT_REQUESTER_SUPPORT,
 };
 
 static const u8 ath11k_if_types_ext_capa_ap[] = {
 	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 	[9] = WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT,
 };
@@ -6101,6 +6104,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ieee80211_hw_set(ar->hw, QUEUE_CONTROL);
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(ar->hw, REPORTS_LOW_ACK);
+	ieee80211_hw_set(ar->hw, SUPPORTS_MULTI_BSSID);
 	if (ht_cap & WMI_HT_CAP_ENABLED) {
 		ieee80211_hw_set(ar->hw, AMPDU_AGGREGATION);
 		ieee80211_hw_set(ar->hw, TX_AMPDU_SETUP_IN_HW);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 548fa05cb1f6..14cffda43ed0 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -109,8 +109,8 @@ enum {
 
 enum {
 	WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP	= 1,
-	WMI_HOST_VDEV_FLAGS_TRANSMIT_AP		= 2,
-	WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP	= 4,
+	WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP	= 2,
+	WMI_HOST_VDEV_FLAGS_TRANSMIT_AP		= 4,
 };
 
 /*
-- 
2.20.1

