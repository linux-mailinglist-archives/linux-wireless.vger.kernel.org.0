Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ABC781901
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Aug 2023 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjHSKmp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Aug 2023 06:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjHSKmS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Aug 2023 06:42:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F2B459F2
        for <linux-wireless@vger.kernel.org>; Sat, 19 Aug 2023 03:21:17 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RSZS551b7zNm5Z;
        Sat, 19 Aug 2023 18:17:41 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 19 Aug
 2023 18:21:14 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <ajay.kathat@microchip.com>, <claudiu.beznea@tuxon.dev>,
        <kvalo@kernel.org>, <yuehaibing@huawei.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: wilc1000: Remove unused declarations
Date:   Sat, 19 Aug 2023 18:21:00 +0800
Message-ID: <20230819102100.13720-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 8399918f3056 ("staging: wilc1000: use RCU list to maintain vif interfaces list")
removed wilc_get_interface() but not its declaration.
Commit 9bc061e88054 ("staging: wilc1000: added support to dynamically add/remove interfaces")
declared but never implemented wilc_cfg_alloc() and wilc_netdev_interface().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.h b/drivers/net/wireless/microchip/wilc1000/cfg80211.h
index 37b294cb3b37..8c65951cfaf9 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.h
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.h
@@ -8,15 +8,12 @@
 #define WILC_CFG80211_H
 #include "netdev.h"
 
-struct wiphy *wilc_cfg_alloc(void);
 int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
 		       const struct wilc_hif_func *ops);
 struct wilc *wilc_create_wiphy(struct device *dev);
 void wilc_deinit_host_int(struct net_device *net);
 int wilc_init_host_int(struct net_device *net);
 void wilc_wfi_monitor_rx(struct net_device *mon_dev, u8 *buff, u32 size);
-struct wilc_vif *wilc_netdev_interface(struct wilc *wl, const char *name,
-				       enum nl80211_iftype type);
 void wilc_wfi_deinit_mon_interface(struct wilc *wl, bool rtnl_locked);
 struct net_device *wilc_wfi_init_mon_interface(struct wilc *wl,
 					       const char *name,
@@ -24,7 +21,6 @@ struct net_device *wilc_wfi_init_mon_interface(struct wilc *wl,
 void wilc_update_mgmt_frame_registrations(struct wiphy *wiphy,
 					  struct wireless_dev *wdev,
 					  struct mgmt_frame_regs *upd);
-struct wilc_vif *wilc_get_interface(struct wilc *wl);
 struct wilc_vif *wilc_get_wl_to_vif(struct wilc *wl);
 void wlan_deinit_locks(struct wilc *wilc);
 #endif
-- 
2.34.1

