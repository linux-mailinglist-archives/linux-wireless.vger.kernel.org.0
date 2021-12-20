Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7607847B098
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 16:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhLTPsr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 10:48:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38536 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbhLTPsr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 10:48:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22A73B80EE9
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 15:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C96CC36AE5;
        Mon, 20 Dec 2021 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015324;
        bh=p4uetvzmsltCoTVzsFQkigKq5jtSu0xJVz+J1rpZ390=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8XJaJR4AqB1kwfvX38YZCK5/BWkOUu0czwG71q4+VqmEJN6gDPW5sDfWfAKet3JK
         kwAklyyUEQlZyfPXgQowcQCCM68pSSoirWZ+iIDhoaOnDvn0TRlibeyobEfRx43QLV
         Xe0EPflaEcMVJ7ndIJSvGqndHnQfznaNpbo8lnJ0WjckWkN2ssgXNKvrEV34XS6g+N
         JJphcWwFz3TEMG+uhPSLWgLDb2x/rxwFDJJbD/sp10P1ylMI5xtX9sz73q3KXI1l3p
         PbZbn/Z6Lgl+M6W7arsBvNyMOClvrAsa2dAoSV0XYLboZIs+N0LpDhy9JYvMKRUilV
         LBbPT7VXlZJnA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     j@w1.fi
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 3/9] DFS: add capability select radar-only channels
Date:   Mon, 20 Dec 2021 16:48:18 +0100
Message-Id: <8ce98f32015291c8fd633bcf811f379bd0afc5ff.1640014128.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640014128.git.lorenzo@kernel.org>
References: <cover.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce flags parameter to dfs_get_valid_channel routine in order to
select radar-only channel where the CAC detection has not been performed
yet. This is a preliminary patch to enable background radar/CAC detection.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 src/ap/dfs.c | 57 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/src/ap/dfs.c b/src/ap/dfs.c
index a97403756..5ce5489b2 100644
--- a/src/ap/dfs.c
+++ b/src/ap/dfs.c
@@ -50,16 +50,32 @@ static int dfs_get_used_n_chans(struct hostapd_iface *iface, int *seg1)
 	return n_chans;
 }
 
-
+/* dfs_channel_available: select new channel according to flags parameter
+ *
+ * flags:
+ * - 0: any channel
+ * - 1: non-radar channel or radar available one
+ * - 2: radar-only channel not yet available
+ */
 static int dfs_channel_available(struct hostapd_channel_data *chan,
-				 int skip_radar)
+				 int flags)
 {
+	if (flags == 2) {
+		/* Select only radar channel where CAC has not been
+		 * performed yet
+		 */
+		if ((chan->flag & HOSTAPD_CHAN_RADAR) &&
+		    (chan->flag & HOSTAPD_CHAN_DFS_MASK) ==
+		     HOSTAPD_CHAN_DFS_USABLE)
+			return 1;
+		return 0;
+	}
 	/*
 	 * When radar detection happens, CSA is performed. However, there's no
 	 * time for CAC, so radar channels must be skipped when finding a new
 	 * channel for CSA, unless they are available for immediate use.
 	 */
-	if (skip_radar && (chan->flag & HOSTAPD_CHAN_RADAR) &&
+	if (flags && (chan->flag & HOSTAPD_CHAN_RADAR) &&
 	    ((chan->flag & HOSTAPD_CHAN_DFS_MASK) !=
 	     HOSTAPD_CHAN_DFS_AVAILABLE))
 		return 0;
@@ -135,10 +151,15 @@ dfs_get_chan_data(struct hostapd_hw_modes *mode, int freq, int first_chan_idx)
 	return NULL;
 }
 
-
+/*
+ * flags:
+ * - 0: any channel
+ * - 1: non-radar channel or radar available one
+ * - 2: radar-only channel not yet available
+ */
 static int dfs_chan_range_available(struct hostapd_hw_modes *mode,
 				    int first_chan_idx, int num_chans,
-				    int skip_radar)
+				    int flags)
 {
 	struct hostapd_channel_data *first_chan, *chan;
 	int i;
@@ -177,7 +198,7 @@ static int dfs_chan_range_available(struct hostapd_hw_modes *mode,
 			return 0;
 		}
 
-		if (!dfs_channel_available(chan, skip_radar)) {
+		if (!dfs_channel_available(chan, flags)) {
 			wpa_printf(MSG_DEBUG, "DFS: channel not available %d",
 				   first_chan->freq + i * 20);
 			return 0;
@@ -204,10 +225,15 @@ static int is_in_chanlist(struct hostapd_iface *iface,
  *  - hapd->secondary_channel
  *  - hapd->vht/he_oper_centr_freq_seg0_idx
  *  - hapd->vht/he_oper_centr_freq_seg1_idx
+ *
+ * flags:
+ * - 0: any channel
+ * - 1: non-radar channel or radar available one
+ * - 2: radar-only channel not yet available
  */
 static int dfs_find_channel(struct hostapd_iface *iface,
 			    struct hostapd_channel_data **ret_chan,
-			    int idx, int skip_radar)
+			    int idx, int flags)
 {
 	struct hostapd_hw_modes *mode;
 	struct hostapd_channel_data *chan;
@@ -232,7 +258,7 @@ static int dfs_find_channel(struct hostapd_iface *iface,
 		}
 
 		/* Skip incompatible chandefs */
-		if (!dfs_chan_range_available(mode, i, n_chans, skip_radar)) {
+		if (!dfs_chan_range_available(mode, i, n_chans, flags)) {
 			wpa_printf(MSG_DEBUG,
 				   "DFS: range not available for %d (%d)",
 				   chan->freq, chan->chan);
@@ -469,13 +495,18 @@ static int dfs_check_chans_unavailable(struct hostapd_iface *iface,
 	return res;
 }
 
-
+/*
+ * flags:
+ * - 0: any channel
+ * - 1: non-radar channel or radar available one
+ * - 2: radar-only channel not yet available
+ */
 static struct hostapd_channel_data *
 dfs_get_valid_channel(struct hostapd_iface *iface,
 		      int *secondary_channel,
 		      u8 *oper_centr_freq_seg0_idx,
 		      u8 *oper_centr_freq_seg1_idx,
-		      int skip_radar)
+		      int flags)
 {
 	struct hostapd_hw_modes *mode;
 	struct hostapd_channel_data *chan = NULL;
@@ -499,7 +530,7 @@ dfs_get_valid_channel(struct hostapd_iface *iface,
 		return NULL;
 
 	/* Get the count first */
-	num_available_chandefs = dfs_find_channel(iface, NULL, 0, skip_radar);
+	num_available_chandefs = dfs_find_channel(iface, NULL, 0, flags);
 	wpa_printf(MSG_DEBUG, "DFS: num_available_chandefs=%d",
 		   num_available_chandefs);
 	if (num_available_chandefs == 0)
@@ -508,7 +539,7 @@ dfs_get_valid_channel(struct hostapd_iface *iface,
 	if (os_get_random((u8 *) &_rand, sizeof(_rand)) < 0)
 		return NULL;
 	chan_idx = _rand % num_available_chandefs;
-	dfs_find_channel(iface, &chan, chan_idx, skip_radar);
+	dfs_find_channel(iface, &chan, chan_idx, flags);
 	if (!chan) {
 		wpa_printf(MSG_DEBUG, "DFS: no random channel found");
 		return NULL;
@@ -537,7 +568,7 @@ dfs_get_valid_channel(struct hostapd_iface *iface,
 		for (i = 0; i < num_available_chandefs - 1; i++) {
 			/* start from chan_idx + 1, end when chan_idx - 1 */
 			chan_idx2 = (chan_idx + 1 + i) % num_available_chandefs;
-			dfs_find_channel(iface, &chan2, chan_idx2, skip_radar);
+			dfs_find_channel(iface, &chan2, chan_idx2, flags);
 			if (chan2 && abs(chan2->chan - chan->chan) > 12) {
 				/* two channels are not adjacent */
 				sec_chan_idx_80p80 = chan2->chan;
-- 
2.33.1

