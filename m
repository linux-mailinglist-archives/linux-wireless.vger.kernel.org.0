Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3417E2FC623
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 01:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbhATAxE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 19:53:04 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:24307 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbhATAxA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 19:53:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611103960; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=VznWztOqo1C8K8UIv12GZ5Dpfy1tv83x6hMFma+NnhM=; b=SPPQ3Mb9xsP1zZyG/biyoN55TA2gVqEW8rWRHQ/A1vsQzUsUEUmXsmeldgLCMFx8SaiDHDaD
 b7hdz/6LY84CH9gxD005tmnYjkiywY3+nCxSgrkZomymC7zdFDHRbPOBAc/XTIEzldFAHrwy
 PzqBQW+BYhk7YAPuJoyMRQ130Pc=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60077ed58a0374a501e99fb3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Jan 2021 00:52:37
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14307C433C6; Wed, 20 Jan 2021 00:52:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63399C43463;
        Wed, 20 Jan 2021 00:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63399C43463
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH 2/2] mac80211: Commands for FILS discovery and unsolicited broadcast probe response
Date:   Tue, 19 Jan 2021 16:52:29 -0800
Message-Id: <20210120005229.32582-3-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210120005229.32582-1-alokad@codeaurora.org>
References: <20210120005229.32582-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch registers ieee80211_set_fils_discovery() and
ieee80211_set_unsol_bcast_probe_resp() as callback functions with
mac80211_config_ops() to be used for configuring FILS discovery
transmission.

Changes also include new calls to ieee80211_bss_info_change_notify()
which were not needed earlier as configurations were completed through
ieee80211_start_ap().

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
 net/mac80211/cfg.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c4c70e30ad7f..27c97fd88e76 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -839,11 +839,13 @@ static int ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
+static int ieee80211_set_fils_discovery(struct wiphy *wiphy,
+					struct net_device *dev,
 					struct cfg80211_fils_discovery *params)
 {
 	struct fils_discovery_data *new, *old = NULL;
 	struct ieee80211_fils_discovery *fd;
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
 	if (!params->tmpl || !params->tmpl_len)
 		return -EINVAL;
@@ -863,18 +865,23 @@ static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
 	if (old)
 		kfree_rcu(old, rcu_head);
 
+	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_FILS_DISCOVERY);
 	return 0;
 }
 
 static int
-ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
+ieee80211_set_unsol_bcast_probe_resp(struct wiphy *wiphy,
+				     struct net_device *dev,
 				     struct cfg80211_unsol_bcast_probe_resp *params)
 {
 	struct unsol_bcast_probe_resp_data *new, *old = NULL;
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
 	if (!params->tmpl || !params->tmpl_len)
 		return -EINVAL;
 
+	sdata->vif.bss_conf.unsol_bcast_probe_resp_interval = params->interval;
+
 	old = sdata_dereference(sdata->u.ap.unsol_bcast_probe_resp, sdata);
 	new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
 	if (!new)
@@ -886,9 +893,7 @@ ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
 	if (old)
 		kfree_rcu(old, rcu_head);
 
-	sdata->vif.bss_conf.unsol_bcast_probe_resp_interval =
-							params->interval;
-
+	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_UNSOL_BCAST_PROBE_RESP);
 	return 0;
 }
 
@@ -1161,22 +1166,6 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		goto error;
 	changed |= err;
 
-	if (params->fils_discovery.max_interval) {
-		err = ieee80211_set_fils_discovery(sdata,
-						   &params->fils_discovery);
-		if (err < 0)
-			goto error;
-		changed |= BSS_CHANGED_FILS_DISCOVERY;
-	}
-
-	if (params->unsol_bcast_probe_resp.interval) {
-		err = ieee80211_set_unsol_bcast_probe_resp(sdata,
-							   &params->unsol_bcast_probe_resp);
-		if (err < 0)
-			goto error;
-		changed |= BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
-	}
-
 	err = drv_start_ap(sdata->local, sdata);
 	if (err) {
 		old = sdata_dereference(sdata->u.ap.beacon, sdata);
@@ -4187,4 +4176,6 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.set_tid_config = ieee80211_set_tid_config,
 	.reset_tid_config = ieee80211_reset_tid_config,
 	.set_sar_specs = ieee80211_set_sar_specs,
+	.set_fils_discovery = ieee80211_set_fils_discovery,
+	.set_unsol_bcast_probe_resp = ieee80211_set_unsol_bcast_probe_resp,
 };
-- 
2.25.0

