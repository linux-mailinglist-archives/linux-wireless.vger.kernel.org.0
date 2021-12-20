Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA7347B09D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 16:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhLTPtA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 10:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbhLTPtA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 10:49:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD10CC061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 07:48:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A6DCB80ED8
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 15:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935B4C36AE5;
        Mon, 20 Dec 2021 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015337;
        bh=6oyuWZXaKGDu+gyN0PGpbyd4ymHwEZX1LmxtSQrpEbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBvcMci6oOiMWam38FNA47mUYGh7lGEgEukQzN3BWymEy+42bo6dJNxGQVxY8YWcd
         V4O9bhfYh8Fv3Obhg2o2ubJlb/XaSBB89aLNdVZ/BaFAHWK1sKte3tU/IBnVMmWoTa
         RhikaWUZFbCHePYxzSyiE1Wy7EUkg/370TTZI7KohLiWPP5OGSD0JgW2MMFHEMoXWY
         iRozt+NZ+O6FEQF1P8KRnn/cQqJ7kpLYmxwjjTLRiRx+sCe00/a1Lf8KGfCXBKJdkm
         nRT6pXZ5fz0SIOFf9so6YLI7xZw3s0yncyxVje95O2vJ64s628CxzCO4LhztsKQVAx
         UUCEPDR5Eh/2A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     j@w1.fi
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 8/9] DFS: switch to background radar channel if available
Date:   Mon, 20 Dec 2021 16:48:23 +0100
Message-Id: <ec706e090d7e44bcc9afd2f9789802f8c07e3c3f.1640014128.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640014128.git.lorenzo@kernel.org>
References: <cover.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On radar detection on the main chain switch to the channel monitored
by the background chain if we have already performed the CAC there.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 src/ap/dfs.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/src/ap/dfs.c b/src/ap/dfs.c
index 30be7e349..35d26e725 100644
--- a/src/ap/dfs.c
+++ b/src/ap/dfs.c
@@ -1259,6 +1259,48 @@ static int hostapd_dfs_start_channel_switch_cac(struct hostapd_iface *iface)
 	return err;
 }
 
+static int
+hostapd_dfs_background_start_channel_switch(struct hostapd_iface *iface,
+					    int freq)
+{
+	if (!(iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND))
+		return -1; /* Background radar chain not supported */
+
+	wpa_printf(MSG_DEBUG,
+		   "%s called (background CAC active: %s, CSA active: %s)",
+		   __func__, iface->radar_background.cac_started ? "yes" : "no",
+		   hostapd_csa_in_progress(iface) ? "yes" : "no");
+
+	/* Check if CSA in progress */
+	if (hostapd_csa_in_progress(iface))
+		return 0;
+
+	/*
+	 * If background radar detection is supported and radar channel
+	 * monitored by background chain is available switch to it without
+	 * waiting for the CAC otherwise let's keep a random channel.
+	 * If radar pattern is reported on the background chain, just switch
+	 * monitoring another radar channel.
+	 */
+	if (hostapd_dfs_is_background_event(iface, freq)) {
+		hostpad_dfs_update_background_chain(iface);
+		return 0;
+	}
+
+	/* Background channel not available yet. Perform CAC on the
+	 * main chain.
+	 */
+	if (iface->radar_background.cac_started) {
+		/* We want to switch to monitored channel as soon as
+		 * CAC is completed.
+		 */
+		iface->radar_background.temp_ch = 1;
+		return -1;
+	}
+
+	return hostapd_dfs_start_channel_switch_background(iface);
+}
+
 static int hostapd_dfs_start_channel_switch(struct hostapd_iface *iface)
 {
 	struct hostapd_channel_data *channel;
@@ -1359,15 +1401,19 @@ int hostapd_dfs_radar_detected(struct hostapd_iface *iface, int freq,
 	if (!res)
 		return 0;
 
-	/* Skip if reported radar event not overlapped our channels */
-	res = dfs_are_channels_overlapped(iface, freq, chan_width, cf1, cf2);
-	if (!res)
-		return 0;
+	if (!hostapd_dfs_is_background_event(iface, freq)) {
+		/* Skip if reported radar event not overlapped our channels */
+		res = dfs_are_channels_overlapped(iface, freq, chan_width,
+						  cf1, cf2);
+		if (!res)
+			return 0;
+	}
 
-	/* radar detected while operating, switch the channel. */
-	res = hostapd_dfs_start_channel_switch(iface);
+	if (hostapd_dfs_background_start_channel_switch(iface, freq))
+		/* radar detected while operating, switch the channel. */
+		return hostapd_dfs_start_channel_switch(iface);
 
-	return res;
+	return 0;
 }
 
 
-- 
2.33.1

