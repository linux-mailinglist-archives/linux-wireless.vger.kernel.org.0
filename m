Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A641BB89A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgD1IOQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 04:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726692AbgD1IOQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 04:14:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB4DC03C1A9
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 01:14:15 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jTLNc-000xL6-HI; Tue, 28 Apr 2020 10:14:12 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     devel@driverdev.osuosl.org,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] staging: rtl8723bs: remove mgmt_frame_register method
Date:   Tue, 28 Apr 2020 10:14:02 +0200
Message-Id: <20200428101400.ae19d651ec38.Ieb15844bb5ab93b3d7931d6561f42e3316ef8251@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This was changed in cfg80211, so having it broke things, but
there's no need to adjust since it's an empty implementation.
Just remove it.

Fixes: 6cd536fe62ef ("cfg80211: change internal management frame registration API")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 24 -------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 1ba85a43f05a..cd31ad2b8a7b 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -3163,29 +3163,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	return ret;
 }
 
-static void cfg80211_rtw_mgmt_frame_register(struct wiphy *wiphy,
-	struct wireless_dev *wdev,
-	u16 frame_type, bool reg)
-{
-	struct net_device *ndev = wdev_to_ndev(wdev);
-	struct adapter *adapter;
-
-	if (ndev == NULL)
-		goto exit;
-
-	adapter = (struct adapter *)rtw_netdev_priv(ndev);
-
-#ifdef DEBUG_CFG80211
-	DBG_871X(FUNC_ADPT_FMT" frame_type:%x, reg:%d\n", FUNC_ADPT_ARG(adapter),
-		frame_type, reg);
-#endif
-
-	if (frame_type != (IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_PROBE_REQ))
-		return;
-exit:
-	return;
-}
-
 #if defined(CONFIG_PNO_SUPPORT)
 static int cfg80211_rtw_sched_scan_start(struct wiphy *wiphy,
 		struct net_device *dev,
@@ -3397,7 +3374,6 @@ static struct cfg80211_ops rtw_cfg80211_ops = {
 	.change_bss = cfg80211_rtw_change_bss,
 
 	.mgmt_tx = cfg80211_rtw_mgmt_tx,
-	.mgmt_frame_register = cfg80211_rtw_mgmt_frame_register,
 
 #if defined(CONFIG_PNO_SUPPORT)
 	.sched_scan_start = cfg80211_rtw_sched_scan_start,
-- 
2.25.1

