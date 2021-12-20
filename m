Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058B047B09A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 16:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhLTPsw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 10:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhLTPsv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 10:48:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BFFC061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 07:48:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D30260F50
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 15:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5D5C36AEA;
        Mon, 20 Dec 2021 15:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015329;
        bh=sXDLqP7UqSBXf2uO6/8ONrEdyzIPyatVU9Mjbm8p/Go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2GGG+rm4fr/eQdE3eM21g14eeNkllBWXbSoclbmu8qRKh1/Zp3QHbPybhB4c8Evu
         dYnORE5Xk9+VImfyhoAC+v5tIVK9NpBk8lIG4VmwUOWuSGxv9IQIG3q15uaZIovl+M
         Arvd43Da/LQEoZXdMkmsLJkg9SLmkdelUHsBcKubKGx8AU0HU7xVPGt/QkvPDIIa/m
         KWc7zs/XY0J370MZMhbzaXGdhg2aRefw0TUKu6CN+AEgpnX6BDUwq1ijgEy5R/s/L+
         odc+rV4DxBRiQMT50eRmUH+HPogntmIedjy/oJPb9r+4CLI+8YDeR6ABca7Rq4vG94
         KtVrfmIiFZ6Xg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     j@w1.fi
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 5/9] DFS: configure background radar/cac detection.
Date:   Mon, 20 Dec 2021 16:48:20 +0100
Message-Id: <bb37607827b240a6a702a205bd42e6d1a0b70eca.1640014128.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640014128.git.lorenzo@kernel.org>
References: <cover.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce the capability to perfrom radar/CAC detection on a offchannel
radar chain available on some hw (e.g. mt7915). This feature allows
to avoid CAC downtime switching on a different channel during CAC
detection on the selected radar channel.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 src/ap/ap_drv_ops.c          |   9 ++-
 src/ap/ap_drv_ops.h          |   3 +-
 src/ap/dfs.c                 | 129 ++++++++++++++++++++++++++++++++++-
 src/ap/hostapd.h             |  15 ++++
 src/drivers/driver.h         |   5 ++
 src/drivers/driver_nl80211.c |   5 ++
 6 files changed, 160 insertions(+), 6 deletions(-)

diff --git a/src/ap/ap_drv_ops.c b/src/ap/ap_drv_ops.c
index e91773666..63791330b 100644
--- a/src/ap/ap_drv_ops.c
+++ b/src/ap/ap_drv_ops.c
@@ -812,7 +812,8 @@ int hostapd_start_dfs_cac(struct hostapd_iface *iface,
 			  int channel, int ht_enabled, int vht_enabled,
 			  int he_enabled,
 			  int sec_channel_offset, int oper_chwidth,
-			  int center_segment0, int center_segment1)
+			  int center_segment0, int center_segment1,
+			  int radar_background)
 {
 	struct hostapd_data *hapd = iface->bss[0];
 	struct hostapd_freq_params data;
@@ -838,10 +839,14 @@ int hostapd_start_dfs_cac(struct hostapd_iface *iface,
 		wpa_printf(MSG_ERROR, "Can't set freq params");
 		return -1;
 	}
+	data.radar_background = radar_background;
 
 	res = hapd->driver->start_dfs_cac(hapd->drv_priv, &data);
 	if (!res) {
-		iface->cac_started = 1;
+		if (radar_background)
+			iface->radar_background.cac_started = 1;
+		else
+			iface->cac_started = 1;
 		os_get_reltime(&iface->dfs_cac_start);
 	}
 
diff --git a/src/ap/ap_drv_ops.h b/src/ap/ap_drv_ops.h
index 61c8f64eb..92842a1dc 100644
--- a/src/ap/ap_drv_ops.h
+++ b/src/ap/ap_drv_ops.h
@@ -130,7 +130,8 @@ int hostapd_start_dfs_cac(struct hostapd_iface *iface,
 			  int channel, int ht_enabled, int vht_enabled,
 			  int he_enabled,
 			  int sec_channel_offset, int oper_chwidth,
-			  int center_segment0, int center_segment1);
+			  int center_segment0, int center_segment1,
+			  int radar_offchan);
 int hostapd_drv_do_acs(struct hostapd_data *hapd);
 int hostapd_drv_update_dh_ie(struct hostapd_data *hapd, const u8 *peer,
 			     u16 reason_code, const u8 *ie, size_t ielen);
diff --git a/src/ap/dfs.c b/src/ap/dfs.c
index 5ce5489b2..94ef87d87 100644
--- a/src/ap/dfs.c
+++ b/src/ap/dfs.c
@@ -870,7 +870,9 @@ int hostapd_handle_dfs(struct hostapd_iface *iface)
 
 	/* Finally start CAC */
 	hostapd_set_state(iface, HAPD_IFACE_DFS);
-	wpa_printf(MSG_DEBUG, "DFS start CAC on %d MHz", iface->freq);
+	wpa_printf(MSG_DEBUG, "DFS start CAC on %d MHz background %d",
+		   iface->freq,
+		   !!(iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND));
 	wpa_msg(iface->bss[0]->msg_ctx, MSG_INFO, DFS_EVENT_CAC_START
 		"freq=%d chan=%d sec_chan=%d, width=%d, seg0=%d, seg1=%d, cac_time=%ds",
 		iface->freq,
@@ -887,13 +889,37 @@ int hostapd_handle_dfs(struct hostapd_iface *iface)
 		iface->conf->secondary_channel,
 		hostapd_get_oper_chwidth(iface->conf),
 		hostapd_get_oper_centr_freq_seg0_idx(iface->conf),
-		hostapd_get_oper_centr_freq_seg1_idx(iface->conf));
+		hostapd_get_oper_centr_freq_seg1_idx(iface->conf),
+		!!(iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND));
 
 	if (res) {
 		wpa_printf(MSG_ERROR, "DFS start_dfs_cac() failed, %d", res);
 		return -1;
 	}
 
+	if (iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND) {
+		/* Cache background radar parameters */
+		iface->radar_background.channel = iface->conf->channel;
+		iface->radar_background.secondary_channel =
+			iface->conf->secondary_channel;
+		iface->radar_background.freq = iface->freq;
+		iface->radar_background.centr_freq_seg0_idx =
+			hostapd_get_oper_centr_freq_seg0_idx(iface->conf);
+		iface->radar_background.centr_freq_seg1_idx =
+			hostapd_get_oper_centr_freq_seg1_idx(iface->conf);
+
+		/*
+		 * Let's select a random channel for the moment
+		 * and perform CAC on dedicated radar chain
+		 */
+		res = dfs_set_valid_channel(iface, 1);
+		if (res < 0)
+			return res;
+
+		iface->radar_background.temp_ch = 1;
+		return 1;
+	}
+
 	return 0;
 }
 
@@ -915,6 +941,78 @@ int hostapd_is_dfs_chan_available(struct hostapd_iface *iface)
 }
 
 
+static struct hostapd_channel_data *
+dfs_downgrade_bandwidth(struct hostapd_iface *iface, int *secondary_channel,
+			u8 *oper_centr_freq_seg0_idx,
+			u8 *oper_centr_freq_seg1_idx, int *skip_radar);
+
+static void
+hostpad_dfs_update_background_chain(struct hostapd_iface *iface)
+{
+	struct hostapd_channel_data *channel;
+	int sec = 0, flags = 2;
+	u8 cf1 = 0, cf2 = 0;
+
+	channel = dfs_get_valid_channel(iface, &sec, &cf1, &cf2, 2);
+	if (!channel || channel->chan == iface->conf->channel)
+		channel = dfs_downgrade_bandwidth(iface, &sec, &cf1, &cf2,
+						  &flags);
+	if (!channel ||
+	    hostapd_start_dfs_cac(iface, iface->conf->hw_mode,
+				  channel->freq, channel->chan,
+				  iface->conf->ieee80211n,
+				  iface->conf->ieee80211ac,
+				  iface->conf->ieee80211ax,
+				  sec, hostapd_get_oper_chwidth(iface->conf),
+				  cf1, cf2, 1)) {
+		/*
+		 * Toggle interface state to enter DFS state
+		 * until NOP is finished.
+		 */
+		wpa_printf(MSG_ERROR, "DFS failed start CAC offchannel");
+		return;
+	}
+
+	wpa_printf(MSG_DEBUG,
+		   "%s: setting background chain to chan %d (%d MHz)",
+		   __func__, channel->chan, channel->freq);
+
+	iface->radar_background.channel = channel->chan;
+	iface->radar_background.freq = channel->freq;
+	iface->radar_background.secondary_channel = sec;
+	iface->radar_background.centr_freq_seg0_idx = cf1;
+	iface->radar_background.centr_freq_seg1_idx = cf2;
+}
+
+/* XXX: check if all channel bandwith */
+static int
+hostapd_dfs_is_background_event(struct hostapd_iface *iface, int freq)
+{
+	if (iface->radar_background.freq != freq)
+		return 0;
+
+	return 1;
+}
+
+static int
+hostapd_dfs_start_channel_switch_background(struct hostapd_iface *iface)
+{
+	iface->conf->channel = iface->radar_background.channel;
+	iface->freq = iface->radar_background.freq;
+	iface->conf->secondary_channel =
+		iface->radar_background.secondary_channel;
+	hostapd_set_oper_centr_freq_seg0_idx(iface->conf,
+			iface->radar_background.centr_freq_seg0_idx);
+	hostapd_set_oper_centr_freq_seg1_idx(iface->conf,
+			iface->radar_background.centr_freq_seg1_idx);
+
+	hostpad_dfs_update_background_chain(iface);
+	hostapd_disable_iface(iface);
+	hostapd_enable_iface(iface);
+
+	return 0;
+}
+
 int hostapd_dfs_complete_cac(struct hostapd_iface *iface, int success, int freq,
 			     int ht_enabled, int chan_offset, int chan_width,
 			     int cf1, int cf2)
@@ -935,6 +1033,23 @@ int hostapd_dfs_complete_cac(struct hostapd_iface *iface, int success, int freq,
 			set_dfs_state(iface, freq, ht_enabled, chan_offset,
 				      chan_width, cf1, cf2,
 				      HOSTAPD_CHAN_DFS_AVAILABLE);
+
+			/*
+			 * radar event from background chain for selected
+			 * channel. Perfrom CSA, move main chain to selected
+			 * channel and configure background chain to a new DFS
+			 * channel
+			 */
+			if ((iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND) &&
+			    hostapd_dfs_is_background_event(iface, freq)) {
+				iface->radar_background.cac_started = 0;
+				if (!iface->radar_background.temp_ch)
+					return 0;
+
+				iface->radar_background.temp_ch = 0;
+				return hostapd_dfs_start_channel_switch_background(iface);
+			}
+
 			/*
 			 * Just mark the channel available when CAC completion
 			 * event is received in enabled state. CAC result could
@@ -951,6 +1066,10 @@ int hostapd_dfs_complete_cac(struct hostapd_iface *iface, int success, int freq,
 				iface->cac_started = 0;
 			}
 		}
+	} else if ((iface->drv_flags2 & WPA_DRIVER_RADAR_BACKGROUND) &&
+		   hostapd_dfs_is_background_event(iface, freq)) {
+		iface->radar_background.cac_started = 0;
+		hostpad_dfs_update_background_chain(iface);
 	}
 
 	return 0;
@@ -1308,7 +1427,11 @@ int hostapd_dfs_start_cac(struct hostapd_iface *iface, int freq,
 		"seg1=%d cac_time=%ds",
 		freq, (freq - 5000) / 5, chan_offset, chan_width, cf1, cf2,
 		iface->dfs_cac_ms / 1000);
-	iface->cac_started = 1;
+
+	if (hostapd_dfs_is_background_event(iface, freq))
+		iface->radar_background.cac_started = 1;
+	else
+		iface->cac_started = 1;
 	os_get_reltime(&iface->dfs_cac_start);
 	return 0;
 }
diff --git a/src/ap/hostapd.h b/src/ap/hostapd.h
index f3ca7529a..72b6035d6 100644
--- a/src/ap/hostapd.h
+++ b/src/ap/hostapd.h
@@ -520,6 +520,21 @@ struct hostapd_iface {
 	int *basic_rates;
 	int freq;
 
+	/* Background radar configuration */
+	struct {
+		int channel;
+		int secondary_channel;
+		int freq;
+		int centr_freq_seg0_idx;
+		int centr_freq_seg1_idx;
+		/* Main chain is on temporary channel during
+		 * CAC detection on radar offchain.
+		 */
+		unsigned int temp_ch:1;
+		/* CAC started on radar offchain */
+		unsigned int cac_started:1;
+	} radar_background;
+
 	u16 hw_flags;
 
 	/* Number of associated Non-ERP stations (i.e., stations using 802.11b
diff --git a/src/drivers/driver.h b/src/drivers/driver.h
index fa28b03db..10dc84994 100644
--- a/src/drivers/driver.h
+++ b/src/drivers/driver.h
@@ -782,6 +782,11 @@ struct hostapd_freq_params {
 	 * for IEEE 802.11ay EDMG configuration.
 	 */
 	struct ieee80211_edmg_config edmg;
+
+	/**
+	 * radar_background - Whether radar/CAC background is requested
+	 */
+	int radar_background;
 };
 
 /**
diff --git a/src/drivers/driver_nl80211.c b/src/drivers/driver_nl80211.c
index aec179ac3..e8e06cf17 100644
--- a/src/drivers/driver_nl80211.c
+++ b/src/drivers/driver_nl80211.c
@@ -4896,6 +4896,8 @@ static int nl80211_put_freq_params(struct nl_msg *msg,
 	wpa_printf(MSG_DEBUG, "  * he_enabled=%d", freq->he_enabled);
 	wpa_printf(MSG_DEBUG, "  * vht_enabled=%d", freq->vht_enabled);
 	wpa_printf(MSG_DEBUG, "  * ht_enabled=%d", freq->ht_enabled);
+	wpa_printf(MSG_DEBUG, "  * radar_background=%d",
+		   freq->radar_background);
 
 	hw_mode = ieee80211_freq_to_chan(freq->freq, &channel);
 	is_24ghz = hw_mode == HOSTAPD_MODE_IEEE80211G ||
@@ -4973,6 +4975,9 @@ static int nl80211_put_freq_params(struct nl_msg *msg,
 				NL80211_CHAN_NO_HT))
 			return -ENOBUFS;
 	}
+	if (freq->radar_background)
+		nla_put_flag(msg, NL80211_ATTR_RADAR_BACKGROUND);
+
 	return 0;
 }
 
-- 
2.33.1

