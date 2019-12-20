Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93C7127804
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 10:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLTJWi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 04:22:38 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47443 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLTJWe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 04:22:34 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBK9MQWK025725, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBK9MQWK025725
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Dec 2019 17:22:26 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Dec 2019 17:22:26 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 07/11] rtw88: remove unused variable 'in_lps'
Date:   Fri, 20 Dec 2019 17:21:52 +0800
Message-ID: <20191220092156.13443-8-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220092156.13443-1-yhchuang@realtek.com>
References: <20191220092156.13443-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Unused, will not be used neither, because the hardware/firmware
can only support one vif for LPS currnetly. If there's more than
one vif, than driver will never enter LPS. So remove it.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 1 -
 drivers/net/wireless/realtek/rtw88/main.h     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 34a1c3b53cd4..ddde3b855893 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -157,7 +157,6 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->stats.rx_unicast = 0;
 	rtwvif->stats.tx_cnt = 0;
 	rtwvif->stats.rx_cnt = 0;
-	rtwvif->in_lps = false;
 	memset(&rtwvif->bfee, 0, sizeof(struct rtw_bfee));
 	rtwvif->conf = &rtw_vif_port[port];
 	rtw_txq_init(rtwdev, vif->txq);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index b2cc7479d49b..a80fa38fb404 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -737,7 +737,6 @@ struct rtw_vif {
 	const struct rtw_vif_port *conf;
 
 	struct rtw_traffic_stats stats;
-	bool in_lps;
 
 	struct rtw_bfee bfee;
 };
-- 
2.17.1

