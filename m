Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 120AFCF4E6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 10:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfJHIVP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 04:21:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47347 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfJHIVO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 04:21:14 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x988L8Yc028146, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x988L8Yc028146
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 8 Oct 2019 16:21:09 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 8 Oct 2019 16:21:08 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 06/10] rtw88: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 support
Date:   Tue, 8 Oct 2019 16:20:57 +0800
Message-ID: <20191008082101.2494-7-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008082101.2494-1-yhchuang@realtek.com>
References: <20191008082101.2494-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

Add support for NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 feature.
According to the "Hardware crypto acceleration" documentation section,
when set_key() is called with %DISABLE_KEY command, for outgoing frames,
we flush out frames in the queues with the old key; for incoming frames,
no frames will be passed to mac80211 decrypted with the old key due to
rtw_sec_clear_cam().

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.h      | 5 +++++
 drivers/net/wireless/realtek/rtw88/mac80211.c | 1 +
 drivers/net/wireless/realtek/rtw88/main.c     | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.h b/drivers/net/wireless/realtek/rtw88/mac.h
index a67fa82973e4..592dc830160c 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.h
+++ b/drivers/net/wireless/realtek/rtw88/mac.h
@@ -33,4 +33,9 @@ int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw);
 int rtw_mac_init(struct rtw_dev *rtwdev);
 void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop);
 
+static inline void rtw_mac_flush_all_queues(struct rtw_dev *rtwdev, bool drop)
+{
+	rtw_mac_flush_queues(rtwdev, BIT(rtwdev->hw->queues) - 1, drop);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 3e4f2f27ced2..2247bd61e716 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -546,6 +546,7 @@ static int rtw_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				  hw_key_type, hw_key_idx);
 		break;
 	case DISABLE_KEY:
+		rtw_mac_flush_all_queues(rtwdev, false);
 		rtw_sec_clear_cam(rtwdev, sec, key->hw_key_idx);
 		break;
 	}
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index edd490c507b5..71f11c973307 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1403,6 +1403,8 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 
 	hw->wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
+
 	rtw_set_supported_band(hw, rtwdev->chip);
 	SET_IEEE80211_PERM_ADDR(hw, rtwdev->efuse.addr);
 
-- 
2.17.1

