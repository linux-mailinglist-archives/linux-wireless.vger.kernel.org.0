Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A6636B9F8
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 21:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbhDZT2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 15:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbhDZT2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 15:28:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F139C061574
        for <linux-wireless@vger.kernel.org>; Mon, 26 Apr 2021 12:28:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lb6tt-000MUa-Of; Mon, 26 Apr 2021 21:28:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Harald Arnesen <harald@skogtun.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] staging: rtl8723bs: fix monitor netdev register/unregister
Date:   Mon, 26 Apr 2021 21:28:02 +0200
Message-Id: <20210426212801.3d902cc9e6f4.Ie0b1e0c545920c61400a4b7d0f384ea61feb645a@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Due to the locking changes and callbacks happening inside
cfg80211, we need to use cfg80211 versions of the register
and unregister functions if called within cfg80211 methods,
otherwise deadlocks occur.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index ff164a8c8679..0619a7510e83 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2579,7 +2579,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
 	mon_wdev->iftype = NL80211_IFTYPE_MONITOR;
 	mon_ndev->ieee80211_ptr = mon_wdev;
 
-	ret = register_netdevice(mon_ndev);
+	ret = cfg80211_register_netdevice(mon_ndev);
 	if (ret) {
 		goto out;
 	}
@@ -2661,7 +2661,7 @@ static int cfg80211_rtw_del_virtual_intf(struct wiphy *wiphy,
 	adapter = rtw_netdev_priv(ndev);
 	pwdev_priv = adapter_wdev_data(adapter);
 
-	unregister_netdevice(ndev);
+	cfg80211_unregister_netdevice(ndev);
 
 	if (ndev == pwdev_priv->pmon_ndev) {
 		pwdev_priv->pmon_ndev = NULL;
-- 
2.30.2

