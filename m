Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39D645B7F8
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 11:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbhKXKFY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 05:05:24 -0500
Received: from smtpbguseast3.qq.com ([54.243.244.52]:43275 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbhKXKFY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 05:05:24 -0500
X-QQ-mid: bizesmtp35t1637748116td6iwrjl
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 24 Nov 2021 18:01:55 +0800 (CST)
X-QQ-SSF: 01400000002000B0C000B00C0000000
X-QQ-FEAT: jHl0immEoeGSEOYNHDr0mHeivGbr621uv1UQnKwvVLBnzrDWYDDepJ+hjPxZE
        pXnVqGnQ+T6i0mxh7oat6qwe0uk7m0gd7SYf4OXjPzATP6chZWM9iA7RFXma2xICtplvTjf
        PGmp+vk6EtcXsfkJcEo+qnVk0r6iyzQWXvbqz782JiURXPCZSPBRkYU1llC8rr/bZKSY2PN
        0B7Da3CeFBblR2GzotGCiZItTlpQKJT1bGIhkf17CZL/XEkhFHHEkuWFjTIvSuwWz1Pvg9a
        Li5TAwNKoTDLUaVObpP+szYqFjmL1uzn6GECiOSmte/bgRL59eArCDVZ2ULYXDsPMv8L2zC
        nkQS9iB5QCFHV3Wru8=
X-QQ-GoodBg: 2
From:   liuguoqiang <liuguoqiang@uniontech.com>
To:     johannes@sipsolutions.net
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org,
        liuguoqiang <liuguoqiang@uniontech.com>
Subject: [PATCH] net: fix incorrect return code
Date:   Wed, 24 Nov 2021 18:01:51 +0800
Message-Id: <20211124100151.31233-1-liuguoqiang@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In drv_can_aggregate_in_amsdu, when ops->can_aggregate_in_amsdu is NULL,
should return -EOPNOTSUPP rather than true.
Also check check_sdata_in_driver's return code, exit called when failed.

Signed-off-by: liuguoqiang <liuguoqiang@uniontech.com>
---
 net/mac80211/driver-ops.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index cd3731cbf6c6..d0b3a5476d28 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1241,7 +1241,7 @@ static inline int drv_can_aggregate_in_amsdu(struct ieee80211_local *local,
 					     struct sk_buff *skb)
 {
 	if (!local->ops->can_aggregate_in_amsdu)
-		return true;
+		return -EOPNOTSUPP;
 
 	return local->ops->can_aggregate_in_amsdu(&local->hw, head, skb);
 }
@@ -1303,7 +1303,8 @@ static inline int drv_start_nan(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
-	check_sdata_in_driver(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
 
 	trace_drv_start_nan(local, sdata, conf);
 	ret = local->ops->start_nan(&local->hw, &sdata->vif, conf);
@@ -1315,7 +1316,8 @@ static inline void drv_stop_nan(struct ieee80211_local *local,
 				struct ieee80211_sub_if_data *sdata)
 {
 	might_sleep();
-	check_sdata_in_driver(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return;
 
 	trace_drv_stop_nan(local, sdata);
 	local->ops->stop_nan(&local->hw, &sdata->vif);
@@ -1330,7 +1332,8 @@ static inline int drv_nan_change_conf(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
-	check_sdata_in_driver(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
 
 	if (!local->ops->nan_change_conf)
 		return -EOPNOTSUPP;
@@ -1350,7 +1353,8 @@ static inline int drv_add_nan_func(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
-	check_sdata_in_driver(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
 
 	if (!local->ops->add_nan_func)
 		return -EOPNOTSUPP;
@@ -1367,7 +1371,8 @@ static inline void drv_del_nan_func(struct ieee80211_local *local,
 				   u8 instance_id)
 {
 	might_sleep();
-	check_sdata_in_driver(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return;
 
 	trace_drv_del_nan_func(local, sdata, instance_id);
 	if (local->ops->del_nan_func)
@@ -1407,7 +1412,8 @@ static inline void drv_update_vif_offload(struct ieee80211_local *local,
 					  struct ieee80211_sub_if_data *sdata)
 {
 	might_sleep();
-	check_sdata_in_driver(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return;
 
 	if (!local->ops->update_vif_offload)
 		return;
-- 
2.20.1



