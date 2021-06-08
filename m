Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E0E39F9E6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhFHPG3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 11:06:29 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:49107 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhFHPG2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 11:06:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623164676; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=+JlSXk5CnPW6EBvkfwHFnyWHDN78GV2P2av+La/x6TY=; b=EFuy/PTJov21xsDIojMQVYczTKh7KmqJJd2qdHrD+XIEViXXT6uIs4xZAK2XLWZEwRwAWc3m
 pNFRbT/iluPJrnEm2Ubq9SlG2K4pOLmvvgTgx9W2rFXmGvPIyN7vZc4hh8fbPMGkG/3HxTAr
 TvnrsuoBJEXa+G1plEakD82UZIs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60bf86fae570c05619a854c2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Jun 2021 15:04:26
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BFFF2C43460; Tue,  8 Jun 2021 15:04:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 069ECC43217;
        Tue,  8 Jun 2021 15:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 069ECC43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     000ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH v3 2/3] mac80211: Add support for beacon tx mode
Date:   Tue,  8 Jun 2021 20:34:02 +0530
Message-Id: <1623164643-7803-3-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623164643-7803-1-git-send-email-mkenna@codeaurora.org>
References: <1623164643-7803-1-git-send-email-mkenna@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pass the beacon tx mode value from the nl80211/cfg80211
layer to the driver via ieee80211_ops and driver ops.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00480-QCAHKSWPL_SILICONZ-1

Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 include/net/mac80211.h | 2 ++
 net/mac80211/cfg.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 445b66c..ff0e51e 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -631,6 +631,7 @@ struct ieee80211_fils_discovery {
  * @s1g: BSS is S1G BSS (affects Association Request format).
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
+ * @beacon_tx_mode: Beacon Tx Mode setting.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -700,6 +701,7 @@ struct ieee80211_bss_conf {
 	u32 unsol_bcast_probe_resp_interval;
 	bool s1g;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
+	enum nl80211_beacon_tx_mode beacon_tx_mode;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7a99892..18e0d98 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1063,6 +1063,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	prev_beacon_int = sdata->vif.bss_conf.beacon_int;
 	sdata->vif.bss_conf.beacon_int = params->beacon_interval;
+	sdata->vif.bss_conf.beacon_tx_mode = params->beacon_tx_mode;
 
 	if (params->he_cap && params->he_oper) {
 		sdata->vif.bss_conf.he_support = true;
@@ -2094,6 +2095,7 @@ static int copy_mesh_setup(struct ieee80211_if_mesh *ifmsh,
 
 	sdata->vif.bss_conf.beacon_int = setup->beacon_interval;
 	sdata->vif.bss_conf.dtim_period = setup->dtim_period;
+	sdata->vif.bss_conf.beacon_tx_mode = setup->beacon_tx_mode;
 
 	sdata->beacon_rate_set = false;
 	if (wiphy_ext_feature_isset(sdata->local->hw.wiphy,
-- 
2.7.4

