Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F1F2234E4
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 08:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGQGuF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jul 2020 02:50:05 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55019 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgGQGuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jul 2020 02:50:05 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06H6o0My9028960, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06H6o0My9028960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jul 2020 14:50:00 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:50:00 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:50:00 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/7] rtw88: add ieee80211_ops::change_interface
Date:   Fri, 17 Jul 2020 14:49:35 +0800
Message-ID: <20200717064937.27966-6-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717064937.27966-1-yhchuang@realtek.com>
References: <20200717064937.27966-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Sometimes mac80211 will just ask driver to change the interface
instead of to remove and then add a new one. And for driver, to
change the interface is just simply to remove and add a new one
but change the type of it.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index c412bc54efde..bb82b044ff82 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -231,6 +231,23 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 	mutex_unlock(&rtwdev->mutex);
 }
 
+static int rtw_ops_change_interface(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    enum nl80211_iftype type, bool p2p)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+
+	rtw_info(rtwdev, "change vif %pM (%d)->(%d), p2p (%d)->(%d)\n",
+		 vif->addr, vif->type, type, vif->p2p, p2p);
+
+	rtw_ops_remove_interface(hw, vif);
+
+	vif->type = type;
+	vif->p2p = p2p;
+
+	return rtw_ops_add_interface(hw, vif);
+}
+
 static void rtw_ops_configure_filter(struct ieee80211_hw *hw,
 				     unsigned int changed_flags,
 				     unsigned int *new_flags,
@@ -827,6 +844,7 @@ const struct ieee80211_ops rtw_ops = {
 	.config			= rtw_ops_config,
 	.add_interface		= rtw_ops_add_interface,
 	.remove_interface	= rtw_ops_remove_interface,
+	.change_interface	= rtw_ops_change_interface,
 	.configure_filter	= rtw_ops_configure_filter,
 	.bss_info_changed	= rtw_ops_bss_info_changed,
 	.conf_tx		= rtw_ops_conf_tx,
-- 
2.17.1

