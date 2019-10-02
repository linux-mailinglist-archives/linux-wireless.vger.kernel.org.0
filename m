Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6FC45E5
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 04:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfJBCbj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 22:31:39 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45998 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbfJBCbj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 22:31:39 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x922VXGr031835, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x922VXGr031835
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 10:31:33 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 10:31:32 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 03/12] rtw88: not to enter or leave PS under IRQ
Date:   Wed, 2 Oct 2019 10:31:19 +0800
Message-ID: <20191002023128.12090-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002023128.12090-1-yhchuang@realtek.com>
References: <20191002023128.12090-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Remove PS related *_irqsafe functions to avoid entering/leaving PS
under interrupt context. Instead, make PS decision in watch_dog.
This could simplify the logic and make the code look clean.

But it could have a little side-effect that if the driver is having
heavy traffic before the every-2-second watch_dog detect the traffic
and decide to leave PS, the thoughput will be lower. Once traffic is
detected by watch_dog and left PS state, the throughput will resume
to the peak the hardware ought to have again.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
  - rebase on top of wireless-drivers-next

 drivers/net/wireless/realtek/rtw88/main.c |  3 +-
 drivers/net/wireless/realtek/rtw88/main.h |  1 -
 drivers/net/wireless/realtek/rtw88/ps.c   | 44 -----------------------
 drivers/net/wireless/realtek/rtw88/ps.h   |  3 --
 drivers/net/wireless/realtek/rtw88/rx.c   |  2 --
 drivers/net/wireless/realtek/rtw88/tx.c   |  2 --
 6 files changed, 2 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 36ba2211faaf..22fc5d6f6b62 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -182,6 +182,8 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	if (rtw_fw_support_lps &&
 	    data.rtwvif && !data.active && data.assoc_cnt == 1)
 		rtw_enter_lps(rtwdev, data.rtwvif);
+	else
+		rtw_leave_lps(rtwdev, rtwdev->lps_conf.rtwvif);
 
 	if (test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
 		return;
@@ -1152,7 +1154,6 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 		    rtw_tx_report_purge_timer, 0);
 
 	INIT_DELAYED_WORK(&rtwdev->watch_dog_work, rtw_watch_dog_work);
-	INIT_DELAYED_WORK(&rtwdev->lps_work, rtw_lps_work);
 	INIT_DELAYED_WORK(&coex->bt_relink_work, rtw_coex_bt_relink_work);
 	INIT_DELAYED_WORK(&coex->bt_reenable_work, rtw_coex_bt_reenable_work);
 	INIT_DELAYED_WORK(&coex->defreeze_work, rtw_coex_defreeze_work);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 11ab9967617b..0955970d6f4d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1361,7 +1361,6 @@ struct rtw_dev {
 
 	/* lps power state & handler work */
 	struct rtw_lps_conf lps_conf;
-	struct delayed_work lps_work;
 
 	struct dentry *debugfs;
 
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 4896953ec4b9..ffba3bd7bb31 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -91,50 +91,6 @@ static void rtw_enter_lps_core(struct rtw_dev *rtwdev)
 	set_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags);
 }
 
-void rtw_lps_work(struct work_struct *work)
-{
-	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
-					      lps_work.work);
-	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
-	struct rtw_vif *rtwvif = conf->rtwvif;
-
-	if (WARN_ON(!rtwvif))
-		return;
-
-	if (conf->mode == RTW_MODE_LPS)
-		rtw_enter_lps_core(rtwdev);
-	else
-		rtw_leave_lps_core(rtwdev);
-}
-
-void rtw_enter_lps_irqsafe(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
-{
-	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
-
-	if (rtwvif->in_lps)
-		return;
-
-	conf->mode = RTW_MODE_LPS;
-	conf->rtwvif = rtwvif;
-	rtwvif->in_lps = true;
-
-	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->lps_work, 0);
-}
-
-void rtw_leave_lps_irqsafe(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
-{
-	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
-
-	if (!rtwvif->in_lps)
-		return;
-
-	conf->mode = RTW_MODE_ACTIVE;
-	conf->rtwvif = rtwvif;
-	rtwvif->in_lps = false;
-
-	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->lps_work, 0);
-}
-
 bool rtw_in_lps(struct rtw_dev *rtwdev)
 {
 	return test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags);
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index 09e57405dc1b..0ac6c2983a06 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -10,9 +10,6 @@
 int rtw_enter_ips(struct rtw_dev *rtwdev);
 int rtw_leave_ips(struct rtw_dev *rtwdev);
 
-void rtw_lps_work(struct work_struct *work);
-void rtw_enter_lps_irqsafe(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif);
-void rtw_leave_lps_irqsafe(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif);
 void rtw_enter_lps(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif);
 void rtw_leave_lps(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif);
 bool rtw_in_lps(struct rtw_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 48b9ed49b79a..16b22eb57171 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -25,8 +25,6 @@ void rtw_rx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 			rtwvif = (struct rtw_vif *)vif->drv_priv;
 			rtwvif->stats.rx_unicast += skb->len;
 			rtwvif->stats.rx_cnt++;
-			if (rtwvif->stats.rx_cnt > RTW_LPS_THRESHOLD)
-				rtw_leave_lps_irqsafe(rtwdev, rtwvif);
 		}
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 8eaa9809ca44..91bfd8c28ff7 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -27,8 +27,6 @@ void rtw_tx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 			rtwvif = (struct rtw_vif *)vif->drv_priv;
 			rtwvif->stats.tx_unicast += skb->len;
 			rtwvif->stats.tx_cnt++;
-			if (rtwvif->stats.tx_cnt > RTW_LPS_THRESHOLD)
-				rtw_leave_lps_irqsafe(rtwdev, rtwvif);
 		}
 	}
 }
-- 
2.17.1

