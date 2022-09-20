Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4545BE396
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 12:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiITKmJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiITKlm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 06:41:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25871012
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so799277wmb.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=M29KU5LQ5TE/Fe1LF/C5igCDfXZtTieWoGXhNv9NMaI=;
        b=QR2VcxRoy2bRNtSub+5QkN1ztTCLZtZGdaeSrmnL4zplGHoM+SUJNDW2t5YzYT+xXo
         5Xi9mVYWBCCa9BL00n6Tf9CqJ/WwgcWcu6VJovob6jthtkKfkFzCYqtYKVtd+GPt9UB+
         fgXhXKyJvbDK+0+v3tqZvmE5+x1PwzFkguYJUZnBJ3t9KVJ0FiallBeG+mnYtlAx3IQS
         NOS4IwW4rzLCfRHuPz/vUkGO9h4Qq540DtAKfc7Ps8FHC10WCs29TPWOPL8rZ9jzPAEz
         HZcbcuU6Ib27bm37wfUFK1uxQ+wjhIeRdwh75tMesfo2KCgqKW2gmxBhGI2A81kPi7MF
         YXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M29KU5LQ5TE/Fe1LF/C5igCDfXZtTieWoGXhNv9NMaI=;
        b=nzHG7+mDhPLSMxIiimRz355A1gnog8HlUfIrWhPJNXIIOqZe5uRPRAIbcRzkClV4X9
         lLEa/OlsNRR6+7EpLKuaBuOisWN2xCkYs4CLpzq6G8ksbXDAgQa5xzwzjfcogsLHG5AH
         wL48gDiVnrSiELoEv9d+oo2X2+djRPyw8y5EjeluNHCMMfvCWu9CxKC7G6HQMlEJ9zOh
         hyhMzk1og3vU7vNHzVxoMITGEeybCjTsRhkB7Rj04bpXuXcLDJcdh5OltnKxhle5Uz0u
         c36LLcoLUXSJPlAAlM5XZfi4XFoMZbYMrb30Npr8loJ4kZLKh9QhPRhpRBACV9IPsXqD
         ojQQ==
X-Gm-Message-State: ACrzQf2xzAJ3kgaQ76t34PyxEd+lJVeZi2Ij4g8JUwuFK1s9hVvNafd3
        p5sl+GFqmFUD5+3fcx53wKyMBxbb0fdPxQ==
X-Google-Smtp-Source: AMsMyM7/wgxFUvN48vWb/DsVNSsyElPzrXISG+idu/OELJn8MSUUNJR4L8svQdYX4EFvVqYbR0bSOw==
X-Received: by 2002:a05:600c:2646:b0:3b4:7640:3c1a with SMTP id 6-20020a05600c264600b003b476403c1amr1927179wmy.2.1663670456417;
        Tue, 20 Sep 2022 03:40:56 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f1d4500880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f1d:4500:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id o2-20020a05600c4fc200b003a5fa79007fsm2182018wmq.7.2022.09.20.03.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 03:40:55 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [RFC v2 6/6] mac80211: minstrel_ht - add debugfs entry per sta for fixed tx-power
Date:   Tue, 20 Sep 2022 12:40:32 +0200
Message-Id: <20220920104032.496697-7-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920104032.496697-1-jelonek.jonas@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Create a new debugfs entry called 'rc_fixed_txpower_idx' in debugfs dir
for each station. By writing a positive static tx-power idx into this
file, minstrel_ht applies this tx-power idx to each packet or each mrr
stage, depending on what the hardware supports. By writing (u32)-1 to
the file, minstrel will return to automatic mode which currently just
passes -1 as tx-power idx, indicating that the driver should use a
default.
The debugfs entry will only be created if either tpc per packet or per
mrr is supported.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 net/mac80211/rc80211_minstrel_ht.c         | 14 ++++++++++++++
 net/mac80211/rc80211_minstrel_ht.h         | 11 +++++++++++
 net/mac80211/rc80211_minstrel_ht_debugfs.c | 11 +++++++++++
 3 files changed, 36 insertions(+)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 24c3c055db6d..222b51e7d9ee 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1486,6 +1486,14 @@ minstrel_ht_set_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 
 	ratetbl->rate[offset].idx = idx;
 	ratetbl->rate[offset].flags = flags;
+
+#ifdef CONFIG_MAC80211_DEBUGFS
+	if (mi->fixed_txpower_idx != -1) {
+		ratetbl->rate[offset].txpower_idx = mi->fixed_txpower_idx;
+		return;
+	}
+#endif
+	ratetbl->rate[offset].txpower_idx = -1;
 }
 
 static inline int
@@ -1603,8 +1611,14 @@ minstrel_ht_get_rate(void *priv, struct ieee80211_sta *sta, void *priv_sta,
 	info->flags |= mi->tx_flags;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
+	if (mi->fixed_txpower_idx != -1)
+		info->control.txpower_idx = mi->fixed_txpower_idx;
+
 	if (mp->fixed_rate_idx != -1)
 		return;
+#else
+	/* Pass -1 to indicate 'ignore txpower' or 'use default' */
+	info->control.txpower_idx = -1;
 #endif
 
 	/* Don't use EAPOL frames for sampling on non-mrr hw */
diff --git a/net/mac80211/rc80211_minstrel_ht.h b/net/mac80211/rc80211_minstrel_ht.h
index 1766ff0c78d3..15222d66c4b8 100644
--- a/net/mac80211/rc80211_minstrel_ht.h
+++ b/net/mac80211/rc80211_minstrel_ht.h
@@ -194,6 +194,17 @@ struct minstrel_ht_sta {
 
 	/* MCS rate group info and statistics */
 	struct minstrel_mcs_group_data groups[MINSTREL_GROUPS_NB];
+
+#ifdef CONFIG_MAC80211_DEBUGFS
+	/*
+	 * enable fixed tx-power processing per STA
+	 *   - write static index to debugfs:ieee80211/phyX/netdev:wlanY
+	 *   		/stations/<MAC>/rc_fixed_txpower_idx
+	 *   - write -1 to enable automatic processing again
+	 *   - setting will be applied on next update
+	 */
+	u32 fixed_txpower_idx;
+#endif
 };
 
 void minstrel_ht_add_sta_debugfs(void *priv, void *priv_sta, struct dentry *dir);
diff --git a/net/mac80211/rc80211_minstrel_ht_debugfs.c b/net/mac80211/rc80211_minstrel_ht_debugfs.c
index 25b8a67a63a4..d625d860d01a 100644
--- a/net/mac80211/rc80211_minstrel_ht_debugfs.c
+++ b/net/mac80211/rc80211_minstrel_ht_debugfs.c
@@ -329,8 +329,19 @@ static const struct file_operations minstrel_ht_stat_csv_fops = {
 void
 minstrel_ht_add_sta_debugfs(void *priv, void *priv_sta, struct dentry *dir)
 {
+	struct minstrel_priv *mp = priv;
+	struct minstrel_ht_sta *mi = priv_sta;
+
 	debugfs_create_file("rc_stats", 0444, dir, priv_sta,
 			    &minstrel_ht_stat_fops);
 	debugfs_create_file("rc_stats_csv", 0444, dir, priv_sta,
 			    &minstrel_ht_stat_csv_fops);
+
+	if (ieee80211_hw_check(mp->hw, SUPPORTS_TPC_PER_PACKET) ||
+	    ieee80211_hw_check(mp->hw, SUPPORTS_TPC_PER_MRR))
+	{
+		mi->fixed_txpower_idx = (u32)-1;
+		debugfs_create_u32("rc_fixed_txpower_idx", S_IRUGO | S_IWUGO,
+				   dir, &mi->fixed_txpower_idx);
+	}
 }
-- 
2.30.2

