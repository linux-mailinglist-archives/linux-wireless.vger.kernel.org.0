Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960CE435CF6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhJUIgM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhJUIgM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 04:36:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676C8C061749
        for <linux-wireless@vger.kernel.org>; Thu, 21 Oct 2021 01:33:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g25so568962wrb.2
        for <linux-wireless@vger.kernel.org>; Thu, 21 Oct 2021 01:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mltRTxaYCQxrHGE1wadkDhXPGA8yKbpSyUnv/63w7IU=;
        b=KGF5+kU7z/2LoUdHYPjyrvXjeoppxyp5oRnkcbXwmMBDj5Hs6792K7xU6GDWiq6QHP
         kz23oPW0xOMIXdPZZEZ47QWw24Y6xkpVhy6ku5k6q22m47Z7EsLEqfERCEDps3Grq38t
         6nG7joJZVKPcyq7RiyGePAdhkws4Q20KR9CMt9oxfQE9tGIjs1IZxUB/5nSEIHlVOWtW
         rAMucU9/akhOfzmPrXstgr8Z/GjAobkHqSpLARRVUKdA7WGF3x+Ad0cw1l51QXkLatNo
         Xw8CyHhOpxO6O/Ud88p78SDOMfg0i3eZW9DUGZhxSuADdoizGJZZHzexkuZkaZETu3sq
         6gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mltRTxaYCQxrHGE1wadkDhXPGA8yKbpSyUnv/63w7IU=;
        b=CJh9Hei09PZ62nnxKeUDCRJosYJS4FVFYNtfPLN8RuNgVoudYzkJ4HuHQO9IcneDfP
         iVx72flC+wa4CLSSqfwOZRS73oItPdVAif/O4aN4a+c+m+Dn4GDuzyMO+b7usO04KXKn
         0Ig9+sgREMD53ODIFp6Aj+oCEbJlEPhDc49rpsKA6M/r8bojDvuAc1UmJPFO1laADHxs
         vAEssxfHwK2FzIDvz4sqMfBNaocTCNds0CBiRiogUC9vcp0R7zgngQ/raa+PPVUmWT0t
         x78jLDik6B/glSiSgwp5L9QGVu3wbc9TlYoSnkWA4CY7Z6HLtKcBI5dU1QWPaw4cb4ML
         p9/Q==
X-Gm-Message-State: AOAM530637oPkmh9fWPR2szVFHMdXRRd6kyKtNQoi3JGfCBDF9AQcHRt
        vP1a66WexktPpOpAReUMF/h/cfb4PmEU7A==
X-Google-Smtp-Source: ABdhPJw3fqhcOkTi7zV2hKqj1x44kX34CtBKretQuBsi3bnG9Odl6kC1wKqDJUsA5cNTbyBChtGS+Q==
X-Received: by 2002:a05:6000:547:: with SMTP id b7mr5572111wrf.344.1634805234910;
        Thu, 21 Oct 2021 01:33:54 -0700 (PDT)
Received: from localhost.localdomain ([88.160.176.23])
        by smtp.gmail.com with ESMTPSA id x8sm1079113wrr.53.2021.10.21.01.33.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Oct 2021 01:33:54 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] net: mac80211: Prevent AP probing during suspend
Date:   Thu, 21 Oct 2021 10:45:27 +0200
Message-Id: <1634805927-1113-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Submitting AP probe/null during suspend can cause unexpected
disconnect on resume because of timeout waiting for ack status:

wlan0: Failed to send nullfunc to AP 11:22:33:44:55:66 after 500ms, disconnecting

This is especially the case when we enter suspend when a scan is
ongoing, indeed, scan is cancelled from __ieee80211_suspend, leading
to a corresponding (aborted) scan complete event, which in turn causes
the submission of an immediate monitor null frame (restart_sta_timer).
The corresponding packet or ack will not be processed before resuming,
causing a timeout & disconnect on resume.

This changes cause the AP probing to be delayed when suspending.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 net/mac80211/ieee80211_i.h | 3 +++
 net/mac80211/mlme.c        | 7 +++++++
 net/mac80211/pm.c          | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 159af6c..09d4034 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1242,6 +1242,9 @@ struct ieee80211_local {
 	 */
 	bool suspended;
 
+	/* suspending is true during the whole suspend process */
+	bool suspending;
+
 	/*
 	 * Resuming is true while suspended, but when we're reprogramming the
 	 * hardware -- at that time it's allowed to use ieee80211_queue_work()
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c0ea3b1..10a586c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2583,6 +2583,13 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
+	if (sdata->local->suspending) {
+		/* reschedule after resume */
+		mutex_unlock(&sdata->local->mtx);
+		ieee80211_reset_ap_probe(sdata);
+		goto out;
+	}
+
 	if (beacon) {
 		mlme_dbg_ratelimited(sdata,
 				     "detected beacon loss from AP (missed %d beacons) - probing\n",
diff --git a/net/mac80211/pm.c b/net/mac80211/pm.c
index 7809a90..0ccb570 100644
--- a/net/mac80211/pm.c
+++ b/net/mac80211/pm.c
@@ -27,6 +27,9 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 	if (!local->open_count)
 		goto suspend;
 
+	local->suspending = true;
+	mb(); /* make suspending visible before any cancellation */
+
 	ieee80211_scan_cancel(local);
 
 	ieee80211_dfs_cac_cancel(local);
@@ -176,6 +179,7 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 	/* need suspended to be visible before quiescing is false */
 	barrier();
 	local->quiescing = false;
+	local->suspending = false;
 
 	return 0;
 }
-- 
2.7.4

