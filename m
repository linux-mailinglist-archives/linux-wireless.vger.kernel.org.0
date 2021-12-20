Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C5547B09B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 16:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhLTPsx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 10:48:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43340 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbhLTPsx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 10:48:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFA6260F67
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 15:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF1EC36AE7;
        Mon, 20 Dec 2021 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015332;
        bh=GPLEmeAU8jLsi4WiN6AAPu6SgCbTrRhGYryhtYPRf+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crrINkDTeaEJ4XPstrcXauLRDfZHR5ientf3YFq2g6Hryx+L/x8IqTcAGlG57e122
         IpcJAen8jyefdazMe1jGibAkyRvgDPshtKr3Bs9Qaicvb3n0YU6TUYgIHQe08utDpt
         oD3vb1Kzbs/RQVhGfdkOicmNlKVXrwnW6O9ytT34GJ/orC6yxDo+Cy/c54GFwY8j+O
         yQs8JdmlgumjE+GH2FNkTEN6VNsg9bi3ecK+5W9cggCBkwkqHpvGH2Rl84OMjUtQOg
         lVlwlWcYueQhzg9hcf/piOZXCbo9EURQGtzpfyBVZAQzrooMGvDshriTa7TOKKxUAw
         TNqIMsxlxcT/g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     j@w1.fi
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 6/9] DFS: introduce hostapd_dfs_request_channel_switch routine
Date:   Mon, 20 Dec 2021 16:48:21 +0100
Message-Id: <c1bf7dc195281330e7108c533da5770adf479d84.1640014128.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640014128.git.lorenzo@kernel.org>
References: <cover.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to add Channel Switch Announcement for
background radar detection.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 src/ap/dfs.c | 159 +++++++++++++++++++++++++++------------------------
 1 file changed, 84 insertions(+), 75 deletions(-)

diff --git a/src/ap/dfs.c b/src/ap/dfs.c
index 94ef87d87..bd8a2484d 100644
--- a/src/ap/dfs.c
+++ b/src/ap/dfs.c
@@ -940,6 +940,85 @@ int hostapd_is_dfs_chan_available(struct hostapd_iface *iface)
 	return dfs_check_chans_available(iface, start_chan_idx, n_chans);
 }
 
+static int hostapd_dfs_request_channel_switch(struct hostapd_iface *iface,
+					      int channel, int freq,
+					      int secondary_channel,
+					      u8 oper_centr_freq_seg0_idx,
+					      u8 oper_centr_freq_seg1_idx)
+{
+	struct hostapd_hw_modes *cmode = iface->current_mode;
+	int ieee80211_mode = IEEE80211_MODE_AP, err, i;
+	struct csa_settings csa_settings;
+	u8 new_vht_oper_chwidth;
+
+	wpa_printf(MSG_DEBUG, "DFS will switch to a new channel %d", channel);
+	wpa_msg(iface->bss[0]->msg_ctx, MSG_INFO, DFS_EVENT_NEW_CHANNEL
+		"freq=%d chan=%d sec_chan=%d", freq, channel,
+		secondary_channel);
+
+	new_vht_oper_chwidth = hostapd_get_oper_chwidth(iface->conf);
+	hostapd_set_oper_chwidth(iface->conf,
+				 hostapd_get_oper_chwidth(iface->conf));
+
+	/* Setup CSA request */
+	os_memset(&csa_settings, 0, sizeof(csa_settings));
+	csa_settings.cs_count = 5;
+	csa_settings.block_tx = 1;
+#ifdef CONFIG_MESH
+	if (iface->mconf)
+		ieee80211_mode = IEEE80211_MODE_MESH;
+#endif /* CONFIG_MESH */
+	err = hostapd_set_freq_params(&csa_settings.freq_params,
+				      iface->conf->hw_mode,
+				      freq, channel,
+				      iface->conf->enable_edmg,
+				      iface->conf->edmg_channel,
+				      iface->conf->ieee80211n,
+				      iface->conf->ieee80211ac,
+				      iface->conf->ieee80211ax,
+				      secondary_channel,
+				      new_vht_oper_chwidth,
+				      oper_centr_freq_seg0_idx,
+				      oper_centr_freq_seg1_idx,
+				      cmode->vht_capab,
+				      &cmode->he_capab[ieee80211_mode]);
+
+	if (err) {
+		wpa_printf(MSG_ERROR, "DFS failed to calculate CSA freq params");
+		hostapd_disable_iface(iface);
+		return err;
+	}
+
+	for (i = 0; i < iface->num_bss; i++) {
+		err = hostapd_switch_channel(iface->bss[i], &csa_settings);
+		if (err)
+			break;
+	}
+
+	if (err) {
+		wpa_printf(MSG_WARNING, "DFS failed to schedule CSA (%d) - trying fallback",
+			   err);
+		iface->freq = freq;
+		iface->conf->channel = channel;
+		iface->conf->secondary_channel = secondary_channel;
+		hostapd_set_oper_chwidth(iface->conf, new_vht_oper_chwidth);
+		hostapd_set_oper_centr_freq_seg0_idx(iface->conf,
+						     oper_centr_freq_seg0_idx);
+		hostapd_set_oper_centr_freq_seg1_idx(iface->conf,
+						     oper_centr_freq_seg1_idx);
+
+		hostapd_disable_iface(iface);
+		hostapd_enable_iface(iface);
+
+		return 0;
+	}
+
+	/* Channel configuration will be updated once CSA completes and
+	 * ch_switch_notify event is received */
+	wpa_printf(MSG_DEBUG, "DFS waiting channel switch event");
+
+	return 0;
+}
 
 static struct hostapd_channel_data *
 dfs_downgrade_bandwidth(struct hostapd_iface *iface, int *secondary_channel,
@@ -1179,21 +1258,13 @@ static int hostapd_dfs_start_channel_switch_cac(struct hostapd_iface *iface)
 	return err;
 }
 
-
 static int hostapd_dfs_start_channel_switch(struct hostapd_iface *iface)
 {
 	struct hostapd_channel_data *channel;
 	int secondary_channel;
 	u8 oper_centr_freq_seg0_idx;
 	u8 oper_centr_freq_seg1_idx;
-	u8 new_vht_oper_chwidth;
 	int skip_radar = 1;
-	struct csa_settings csa_settings;
-	unsigned int i;
-	int err = 1;
-	struct hostapd_hw_modes *cmode = iface->current_mode;
-	u8 current_vht_oper_chwidth = hostapd_get_oper_chwidth(iface->conf);
-	int ieee80211_mode = IEEE80211_MODE_AP;
 
 	wpa_printf(MSG_DEBUG, "%s called (CAC active: %s, CSA active: %s)",
 		   __func__, iface->cac_started ? "yes" : "no",
@@ -1256,73 +1327,11 @@ static int hostapd_dfs_start_channel_switch(struct hostapd_iface *iface)
 		}
 	}
 
-	wpa_printf(MSG_DEBUG, "DFS will switch to a new channel %d",
-		   channel->chan);
-	wpa_msg(iface->bss[0]->msg_ctx, MSG_INFO, DFS_EVENT_NEW_CHANNEL
-		"freq=%d chan=%d sec_chan=%d", channel->freq,
-		channel->chan, secondary_channel);
-
-	new_vht_oper_chwidth = hostapd_get_oper_chwidth(iface->conf);
-	hostapd_set_oper_chwidth(iface->conf, current_vht_oper_chwidth);
-
-	/* Setup CSA request */
-	os_memset(&csa_settings, 0, sizeof(csa_settings));
-	csa_settings.cs_count = 5;
-	csa_settings.block_tx = 1;
-#ifdef CONFIG_MESH
-	if (iface->mconf)
-		ieee80211_mode = IEEE80211_MODE_MESH;
-#endif /* CONFIG_MESH */
-	err = hostapd_set_freq_params(&csa_settings.freq_params,
-				      iface->conf->hw_mode,
-				      channel->freq,
-				      channel->chan,
-				      iface->conf->enable_edmg,
-				      iface->conf->edmg_channel,
-				      iface->conf->ieee80211n,
-				      iface->conf->ieee80211ac,
-				      iface->conf->ieee80211ax,
-				      secondary_channel,
-				      new_vht_oper_chwidth,
-				      oper_centr_freq_seg0_idx,
-				      oper_centr_freq_seg1_idx,
-				      cmode->vht_capab,
-				      &cmode->he_capab[ieee80211_mode]);
-
-	if (err) {
-		wpa_printf(MSG_ERROR, "DFS failed to calculate CSA freq params");
-		hostapd_disable_iface(iface);
-		return err;
-	}
-
-	for (i = 0; i < iface->num_bss; i++) {
-		err = hostapd_switch_channel(iface->bss[i], &csa_settings);
-		if (err)
-			break;
-	}
-
-	if (err) {
-		wpa_printf(MSG_WARNING, "DFS failed to schedule CSA (%d) - trying fallback",
-			   err);
-		iface->freq = channel->freq;
-		iface->conf->channel = channel->chan;
-		iface->conf->secondary_channel = secondary_channel;
-		hostapd_set_oper_chwidth(iface->conf, new_vht_oper_chwidth);
-		hostapd_set_oper_centr_freq_seg0_idx(iface->conf,
-						     oper_centr_freq_seg0_idx);
-		hostapd_set_oper_centr_freq_seg1_idx(iface->conf,
-						     oper_centr_freq_seg1_idx);
-
-		hostapd_disable_iface(iface);
-		hostapd_enable_iface(iface);
-		return 0;
-	}
-
-	/* Channel configuration will be updated once CSA completes and
-	 * ch_switch_notify event is received */
-
-	wpa_printf(MSG_DEBUG, "DFS waiting channel switch event");
-	return 0;
+	return hostapd_dfs_request_channel_switch(iface, channel->chan,
+						  channel->freq,
+						  secondary_channel,
+						  oper_centr_freq_seg0_idx,
+						  oper_centr_freq_seg1_idx);
 }
 
 
-- 
2.33.1

