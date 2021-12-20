Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5396847B097
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 16:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhLTPsp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 10:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhLTPsp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 10:48:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CA3C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 07:48:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8365BB80E22
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 15:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0557C36AE8;
        Mon, 20 Dec 2021 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015322;
        bh=3QWthDait3INDIa0Ur5ioF+BalKjo00X8NOZTNg6GEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/0wiRcsycFlVVEHq9AUXaU/zQDAqpNIyTkHFUv4nb0iqHKIOduDs97Y0Ard+8FlY
         HdCZ3AVwoWPi+bKoqKZVq6OVyfe4WYxcr30nYrzUsQd2DZIlDsTA56iS/SEOT86gjY
         OxXVsjy0TPnTeTFN0S+m6+xyYh6lMb8ebeCXd1xSMABIjTnbQJXpsRRMDNz2Ydbz34
         tPN4hxEGzYaOKSoEuzrH2L/gqUjjKWEFNtXmbZ46BdQI25pfnRWENsTBIk0rLUOCXK
         gubBad0j647Eck+bTTudX0y5Z1p+gRV33HPUIOADL9oGV3YC0oAWUjqytiWCbq4aBs
         Bh7Qed6iFzdWQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     j@w1.fi
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 2/9] DFS: introduce dfs_set_valid_channel utility routine
Date:   Mon, 20 Dec 2021 16:48:17 +0100
Message-Id: <f1a1a91eb7caf87ca5ab0f431da78f774f973b48.1640014128.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640014128.git.lorenzo@kernel.org>
References: <cover.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to introduce radar/CAC background
detection support.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 src/ap/dfs.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/src/ap/dfs.c b/src/ap/dfs.c
index 5c99ecfd0..a97403756 100644
--- a/src/ap/dfs.c
+++ b/src/ap/dfs.c
@@ -567,6 +567,27 @@ dfs_get_valid_channel(struct hostapd_iface *iface,
 	return chan;
 }
 
+static int dfs_set_valid_channel(struct hostapd_iface *iface, int skip_radar)
+{
+	struct hostapd_channel_data *channel;
+	u8 cf1 = 0, cf2 = 0;
+	int sec = 0;
+
+	channel = dfs_get_valid_channel(iface, &sec, &cf1, &cf2,
+					skip_radar);
+	if (!channel) {
+		wpa_printf(MSG_ERROR, "could not get valid channel");
+		return -1;
+	}
+
+	iface->freq = channel->freq;
+	iface->conf->channel = channel->chan;
+	iface->conf->secondary_channel = sec;
+	hostapd_set_oper_centr_freq_seg0_idx(iface->conf, cf1);
+	hostapd_set_oper_centr_freq_seg1_idx(iface->conf, cf2);
+
+	return 0;
+}
 
 static int set_dfs_state_freq(struct hostapd_iface *iface, int freq, u32 state)
 {
@@ -755,7 +776,6 @@ static unsigned int dfs_get_cac_time(struct hostapd_iface *iface,
  */
 int hostapd_handle_dfs(struct hostapd_iface *iface)
 {
-	struct hostapd_channel_data *channel;
 	int res, n_chans, n_chans1, start_chan_idx, start_chan_idx1;
 	int skip_radar = 0;
 
@@ -810,22 +830,10 @@ int hostapd_handle_dfs(struct hostapd_iface *iface)
 		wpa_printf(MSG_DEBUG, "DFS %d chans unavailable - choose other channel: %s",
 			   res, res ? "yes": "no");
 		if (res) {
-			int sec = 0;
-			u8 cf1 = 0, cf2 = 0;
-
-			channel = dfs_get_valid_channel(iface, &sec, &cf1, &cf2,
-							skip_radar);
-			if (!channel) {
-				wpa_printf(MSG_ERROR, "could not get valid channel");
+			if (dfs_set_valid_channel(iface, skip_radar) < 0) {
 				hostapd_set_state(iface, HAPD_IFACE_DFS);
 				return 0;
 			}
-
-			iface->freq = channel->freq;
-			iface->conf->channel = channel->chan;
-			iface->conf->secondary_channel = sec;
-			hostapd_set_oper_centr_freq_seg0_idx(iface->conf, cf1);
-			hostapd_set_oper_centr_freq_seg1_idx(iface->conf, cf2);
 		}
 	} while (res);
 
-- 
2.33.1

