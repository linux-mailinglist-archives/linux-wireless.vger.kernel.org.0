Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFEA6537B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2019 11:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfGKJF1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 05:05:27 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:59796 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728045AbfGKJFY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 05:05:24 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id CEFAA30C030;
        Thu, 11 Jul 2019 02:05:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com CEFAA30C030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1562835922;
        bh=eXMq3HW7Oh5koNi3ssVzL7XpBJJU9K5kfeDRoTV+WTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+UbpN4oiwFv928OYd+ME0K+8yslLpwppJz8B72uAw3P9pEYqfqnjjVOzUJSdArY8
         UyHAhAdYTTD65hssR7sZo5UcgFTBQ4ocb+YP5WBqPq0+HQD1u1QfNqJfAUyf7p02h+
         kcBgm0IVyktWUiW3T5+2ZAoAE4KLDLhC11p2KvjM=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id D475360D22;
        Thu, 11 Jul 2019 02:05:22 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 15998B030A9; Thu, 11 Jul 2019 11:05:19 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 5/7] brcmfmac: avoid firmware commands when bus is down
Date:   Thu, 11 Jul 2019 11:05:10 +0200
Message-Id: <1562835912-1404-6-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562835912-1404-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1562835912-1404-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Upon rmmod a few attempts are made to inform firmware, but there is
no point as the bus is down and these will fail. Avoid them to keep
the logs clean.

Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 23 ++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index b6d0df3..4e3e9d44 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1267,17 +1267,21 @@ static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(vif->wdev.wiphy);
 	struct brcmf_pub *drvr = cfg->pub;
+	bool bus_up = drvr->bus_if->state == BRCMF_BUS_UP;
 	s32 err = 0;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
 	if (test_and_clear_bit(BRCMF_VIF_STATUS_CONNECTED, &vif->sme_state)) {
-		brcmf_dbg(INFO, "Call WLC_DISASSOC to stop excess roaming\n");
-		err = brcmf_fil_cmd_data_set(vif->ifp,
-					     BRCMF_C_DISASSOC, NULL, 0);
-		if (err) {
-			bphy_err(drvr, "WLC_DISASSOC failed (%d)\n", err);
+		if (bus_up) {
+			brcmf_dbg(INFO, "Call WLC_DISASSOC to stop excess roaming\n");
+			err = brcmf_fil_cmd_data_set(vif->ifp,
+						     BRCMF_C_DISASSOC, NULL, 0);
+			if (err)
+				bphy_err(drvr, "WLC_DISASSOC failed (%d)\n",
+					 err);
 		}
+
 		if ((vif->wdev.iftype == NL80211_IFTYPE_STATION) ||
 		    (vif->wdev.iftype == NL80211_IFTYPE_P2P_CLIENT))
 			cfg80211_disconnected(vif->wdev.netdev, reason, NULL, 0,
@@ -1287,7 +1291,8 @@ static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason)
 	clear_bit(BRCMF_SCAN_STATUS_SUPPRESS, &cfg->scan_status);
 	brcmf_btcoex_set_mode(vif, BRCMF_BTCOEX_ENABLED, 0);
 	if (vif->profile.use_fwsup != BRCMF_PROFILE_FWSUP_NONE) {
-		brcmf_set_pmk(vif->ifp, NULL, 0);
+		if (bus_up)
+			brcmf_set_pmk(vif->ifp, NULL, 0);
 		vif->profile.use_fwsup = BRCMF_PROFILE_FWSUP_NONE;
 	}
 	brcmf_dbg(TRACE, "Exit\n");
@@ -4985,18 +4990,16 @@ static int brcmf_cfg80211_get_channel(struct wiphy *wiphy,
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct net_device *ndev = wdev->netdev;
 	struct brcmf_pub *drvr = cfg->pub;
-	struct brcmf_if *ifp;
 	struct brcmu_chan ch;
 	enum nl80211_band band = 0;
 	enum nl80211_chan_width width = 0;
 	u32 chanspec;
 	int freq, err;
 
-	if (!ndev)
+	if (!ndev || drvr->bus_if->state != BRCMF_BUS_UP)
 		return -ENODEV;
-	ifp = netdev_priv(ndev);
 
-	err = brcmf_fil_iovar_int_get(ifp, "chanspec", &chanspec);
+	err = brcmf_fil_iovar_int_get(netdev_priv(ndev), "chanspec", &chanspec);
 	if (err) {
 		bphy_err(drvr, "chanspec failed (%d)\n", err);
 		return err;
-- 
1.9.1

