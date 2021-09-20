Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F634115F2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 15:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbhITNlp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 09:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbhITNlm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 09:41:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C2DC061764
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=s+cbGAdxw/sghZvm54YxPVpJu6bh644f9w+nKfC+KGI=;
        t=1632145215; x=1633354815; b=lfIROpIXpwFHm93918CH5mQUm1VWa+WZC+JmA+nQMMOIi92
        iAj+VPpuc0g8AavflW6iGexXK8dwcC4yUvuIjKYOIY9zmpGEaKpoIbwyAbukUIFn/ZnaUHMxoWoLK
        OR+n0q4JDbTcH1nxDn9UmRiimrWfpJJd5EaHSQcKctsweFnRgaQXoj+l6scY7SiT4DdgdFixlNXYE
        2h18KaPkf5krH0V+fDkrOrBwR7rmbefQ2wYoWgQwGsq32jCbiiiJ1AqqB6tp7dajA9bWEkEDevBVM
        YbiLSXKh5Ycig6mDKD02xtYUel/N9UtKAlk23lH2dXRGhciibfEEy8xgLG5psL8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mSJWn-009SO7-8J;
        Mon, 20 Sep 2021 15:40:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 2/6] mac80211: reduce stack usage in debugfs
Date:   Mon, 20 Sep 2021 15:40:06 +0200
Message-Id: <20210920154009.1387f44e7382.Ife043c169e6a44edace516fea9f8311a5ca4282a@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920154009.3110ff75be0c.Ib6a2ff9e9cc9bc6fca50fce631ec1ce725cc926b@changeid>
References: <20210920154009.3110ff75be0c.Ib6a2ff9e9cc9bc6fca50fce631ec1ce725cc926b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We put a few large buffers on the stack here, but it's easy to
just allocate them on the heap, so do that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs_sta.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 8be28cfd6f64..da22725eca0f 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -5,7 +5,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2020 Intel Corporation
+ * Copyright (C) 2018 - 2021 Intel Corporation
  */
 
 #include <linux/debugfs.h>
@@ -314,11 +314,17 @@ STA_OPS_RW(aql);
 static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
 					size_t count, loff_t *ppos)
 {
-	char buf[71 + IEEE80211_NUM_TIDS * 40], *p = buf;
+	char *buf, *p;
 	int i;
 	struct sta_info *sta = file->private_data;
 	struct tid_ampdu_rx *tid_rx;
 	struct tid_ampdu_tx *tid_tx;
+	ssize_t ret;
+
+	buf = kzalloc(71 + IEEE80211_NUM_TIDS * 40, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	p = buf;
 
 	rcu_read_lock();
 
@@ -352,7 +358,9 @@ static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
 	}
 	rcu_read_unlock();
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	kfree(buf);
+	return ret;
 }
 
 static ssize_t sta_agg_status_write(struct file *file, const char __user *userbuf,
@@ -434,10 +442,16 @@ static ssize_t sta_ht_capa_read(struct file *file, char __user *userbuf,
 	if (_cond) \
 			p += scnprintf(p, sizeof(buf)+buf-p, "\t" _str "\n"); \
 	} while (0)
-	char buf[512], *p = buf;
+	char *buf, *p;
 	int i;
 	struct sta_info *sta = file->private_data;
 	struct ieee80211_sta_ht_cap *htc = &sta->sta.ht_cap;
+	ssize_t ret;
+
+	buf = kzalloc(512, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	p = buf;
 
 	p += scnprintf(p, sizeof(buf) + buf - p, "ht %ssupported\n",
 			htc->ht_supported ? "" : "not ");
@@ -504,16 +518,24 @@ static ssize_t sta_ht_capa_read(struct file *file, char __user *userbuf,
 				htc->mcs.tx_params);
 	}
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	kfree(buf);
+	return ret;
 }
 STA_OPS(ht_capa);
 
 static ssize_t sta_vht_capa_read(struct file *file, char __user *userbuf,
 				 size_t count, loff_t *ppos)
 {
-	char buf[512], *p = buf;
+	char *buf, *p;
 	struct sta_info *sta = file->private_data;
 	struct ieee80211_sta_vht_cap *vhtc = &sta->sta.vht_cap;
+	ssize_t ret;
+
+	buf = kzalloc(512, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	p = buf;
 
 	p += scnprintf(p, sizeof(buf) + buf - p, "VHT %ssupported\n",
 			vhtc->vht_supported ? "" : "not ");
@@ -609,7 +631,9 @@ static ssize_t sta_vht_capa_read(struct file *file, char __user *userbuf,
 #undef PFLAG
 	}
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	kfree(buf);
+	return ret;
 }
 STA_OPS(vht_capa);
 
-- 
2.31.1

