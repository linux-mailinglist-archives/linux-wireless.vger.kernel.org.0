Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3442D097B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 04:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgLGDfz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 22:35:55 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:25672 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGDfy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 22:35:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607312134; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=pADto9znzN8yD/HpOV5r1c9eP1YWr0M/dmgfltU1A4s=; b=b59vSFc9Kqn5bBx2ZHwx4n1MOQmUqLW5452t8OUvzaERLP505kZVZcbh38cJjD+pWh+mGOI1
 EObZdNZ1K6ArSpYyifJXq+X6qLtQVr/d31cdqNdn3EcWXG1BN453pHcfC64NFxZIugyVqeYQ
 QTpHOzwIaGiLoQtyHVjeshxaZhM=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fcda30596285165cdfa44d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 03:35:33
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A004EC433C6; Mon,  7 Dec 2020 03:35:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA94BC43462;
        Mon,  7 Dec 2020 03:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA94BC43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 1/2] mac80211: save ssid info to ieee80211_bss_conf while assoc
Date:   Mon,  7 Dec 2020 11:36:34 +0800
Message-Id: <1607312195-3583-2-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607312195-3583-1-git-send-email-wgong@codeaurora.org>
References: <1607312195-3583-1-git-send-email-wgong@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ssid info of ieee80211_bss_conf is filled in ieee80211_start_ap()
for AP mode. For STATION mode, it is empty, save the info from struct
ieee80211_mgd_assoc_data, the struct ieee80211_mgd_assoc_data will be
freed after assoc, so the ssid info of ieee80211_mgd_assoc_data can not
access after assoc, save ssid info to ieee80211_bss_conf, then ssid info
can be still access after assoc.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 net/mac80211/mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ac870309b911..f3b3cba02be2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5364,6 +5364,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgd_assoc_data *assoc_data;
 	const struct cfg80211_bss_ies *beacon_ies;
 	struct ieee80211_supported_band *sband;
+	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 	const u8 *ssidie, *ht_ie, *vht_ie;
 	int i, err;
 	bool override = false;
@@ -5381,6 +5382,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	}
 	memcpy(assoc_data->ssid, ssidie + 2, ssidie[1]);
 	assoc_data->ssid_len = ssidie[1];
+	memcpy(bss_conf->ssid, assoc_data->ssid, assoc_data->ssid_len);
+	bss_conf->ssid_len = assoc_data->ssid_len;
 	rcu_read_unlock();
 
 	if (ifmgd->associated) {
-- 
2.23.0

