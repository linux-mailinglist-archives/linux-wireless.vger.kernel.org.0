Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FBF47B09E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 16:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhLTPtD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 10:49:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38682 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbhLTPtC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 10:49:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DF4CB80ED8
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 15:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A48C36AEA;
        Mon, 20 Dec 2021 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015339;
        bh=PU27TR5jv7kYU1ASU2G3I0FkbIzddIjdFsV12iPQGPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZHwo0IhcADbjtIVgLlPXujHzAW9jSNTER8tlIKRLiVUl6Ent4jyvJUXm9aYrzTfW
         OCSNNFRQFpEcEyhLmMeh5KmTj3OKK5p37VVjUxreb2DSQ1PG1EJMbeN/t3fjQCG/m9
         NE4OX3V9TYn5fEI79pgAwj1kmt6aFryO7Qv/c8sVpaWrH5aDA+tKLewv0RDEALR1ug
         NVpdUqqsDxXKquJ+9RTG25qZCennlE6ddsDOGB01ISaLIB2Kp/2kPLSP/vjXNLzzSb
         RLde78KdHODOoTLWFmiXHI/AVOUzGbQk4mAr3LigM9TdjBYOIltV4xzXX6EX95Qxaz
         DPqA39QbtrMMg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     j@w1.fi
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 9/9] DFS: introduce radar_background parameter to config file
Date:   Mon, 20 Dec 2021 16:48:24 +0100
Message-Id: <3683c678668c4de0ee849974977cf56e64c7162c.1640014128.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640014128.git.lorenzo@kernel.org>
References: <cover.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce radar_background parameter to configuration file
in order to enable/disable background radar/CAC detection.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 hostapd/config_file.c |  2 ++
 hostapd/hostapd.conf  |  7 +++++++
 src/ap/ap_config.h    |  1 +
 src/ap/dfs.c          | 21 +++++++++++++--------
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/hostapd/config_file.c b/hostapd/config_file.c
index b14728d1b..3cba0b2c2 100644
--- a/hostapd/config_file.c
+++ b/hostapd/config_file.c
@@ -2475,6 +2475,8 @@ static int hostapd_config_fill(struct hostapd_config *conf,
 		conf->ieee80211d = atoi(pos);
 	} else if (os_strcmp(buf, "ieee80211h") == 0) {
 		conf->ieee80211h = atoi(pos);
+	} else if (os_strcmp(buf, "radar_background") == 0) {
+		conf->radar_background = atoi(pos);
 	} else if (os_strcmp(buf, "ieee8021x") == 0) {
 		bss->ieee802_1x = atoi(pos);
 	} else if (os_strcmp(buf, "eapol_version") == 0) {
diff --git a/hostapd/hostapd.conf b/hostapd/hostapd.conf
index 3c2019f73..373f44afb 100644
--- a/hostapd/hostapd.conf
+++ b/hostapd/hostapd.conf
@@ -143,6 +143,13 @@ ssid=test
 # ieee80211d=1 and local_pwr_constraint configured.
 #spectrum_mgmt_required=1
 
+# Enable radar/CAC detection through a dedicated background chain available on
+# some hw. The chain can't be used to transmits or receives frames.
+# This feature allows to avoid CAC downtime switching on a different channel
+# during CAC detection on the selected radar channel.
+# (default: 0 = disabled, 1 = enabled)
+#radar_background=0
+
 # Operation mode (a = IEEE 802.11a (5 GHz), b = IEEE 802.11b (2.4 GHz),
 # g = IEEE 802.11g (2.4 GHz), ad = IEEE 802.11ad (60 GHz); a/g options are used
 # with IEEE 802.11n (HT), too, to specify band). For IEEE 802.11ac (VHT), this
diff --git a/src/ap/ap_config.h b/src/ap/ap_config.h
index 49cd3168a..f846437f5 100644
--- a/src/ap/ap_config.h
+++ b/src/ap/ap_config.h
@@ -990,6 +990,7 @@ struct hostapd_config {
 	int ieee80211d;
 
 	int ieee80211h; /* DFS */
+	int radar_background;
 
 	/*
 	 * Local power constraint is an octet encoded as an unsigned integer in
diff --git a/src/ap/dfs.c b/src/ap/dfs.c
index 35d26e725..ba4c83b5f 100644
--- a/src/ap/dfs.c
+++ b/src/ap/dfs.c
@@ -798,6 +798,11 @@ static unsigned int dfs_get_cac_time(struct hostapd_iface *iface,
 	return cac_time_ms;
 }
 
+static int hostapd_is_radar_background_enabled(struct hostapd_iface *iface)
+{
+	return (iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND) &&
+	       iface->conf->radar_background;
+}
 
 /*
  * Main DFS handler
@@ -808,7 +813,7 @@ static unsigned int dfs_get_cac_time(struct hostapd_iface *iface,
 int hostapd_handle_dfs(struct hostapd_iface *iface)
 {
 	int res, n_chans, n_chans1, start_chan_idx, start_chan_idx1;
-	int skip_radar = 0;
+	int skip_radar = 0, radar_background;
 
 	if (is_6ghz_freq(iface->freq))
 		return 1;
@@ -870,9 +875,9 @@ int hostapd_handle_dfs(struct hostapd_iface *iface)
 
 	/* Finally start CAC */
 	hostapd_set_state(iface, HAPD_IFACE_DFS);
+	radar_background = hostapd_is_radar_background_enabled(iface);
 	wpa_printf(MSG_DEBUG, "DFS start CAC on %d MHz background %d",
-		   iface->freq,
-		   !!(iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND));
+		   iface->freq, radar_background);
 	wpa_msg(iface->bss[0]->msg_ctx, MSG_INFO, DFS_EVENT_CAC_START
 		"freq=%d chan=%d sec_chan=%d, width=%d, seg0=%d, seg1=%d, cac_time=%ds",
 		iface->freq,
@@ -890,14 +895,14 @@ int hostapd_handle_dfs(struct hostapd_iface *iface)
 		hostapd_get_oper_chwidth(iface->conf),
 		hostapd_get_oper_centr_freq_seg0_idx(iface->conf),
 		hostapd_get_oper_centr_freq_seg1_idx(iface->conf),
-		!!(iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND));
+		radar_background);
 
 	if (res) {
 		wpa_printf(MSG_ERROR, "DFS start_dfs_cac() failed, %d", res);
 		return -1;
 	}
 
-	if (iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND) {
+	if (radar_background) {
 		/* Cache background radar parameters */
 		iface->radar_background.channel = iface->conf->channel;
 		iface->radar_background.secondary_channel =
@@ -1120,7 +1125,7 @@ int hostapd_dfs_complete_cac(struct hostapd_iface *iface, int success, int freq,
 			 * channel and configure background chain to a new DFS
 			 * channel
 			 */
-			if ((iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND) &&
+			if (hostapd_is_radar_background_enabled(iface) &&
 			    hostapd_dfs_is_background_event(iface, freq)) {
 				iface->radar_background.cac_started = 0;
 				if (!iface->radar_background.temp_ch)
@@ -1146,7 +1151,7 @@ int hostapd_dfs_complete_cac(struct hostapd_iface *iface, int success, int freq,
 				iface->cac_started = 0;
 			}
 		}
-	} else if ((iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND) &&
+	} else if (hostapd_is_radar_background_enabled(iface) &&
 		   hostapd_dfs_is_background_event(iface, freq)) {
 		iface->radar_background.cac_started = 0;
 		hostpad_dfs_update_background_chain(iface);
@@ -1263,7 +1268,7 @@ static int
 hostapd_dfs_background_start_channel_switch(struct hostapd_iface *iface,
 					    int freq)
 {
-	if (!(iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND))
+	if (!hostapd_is_radar_background_enabled(iface))
 		return -1; /* Background radar chain not supported */
 
 	wpa_printf(MSG_DEBUG,
-- 
2.33.1

