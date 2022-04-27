Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A651214A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiD0Snv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 14:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiD0SnR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 14:43:17 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48953A76E7
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651083865; x=1682619865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GWD6I3nWyhMhEIhGza5hKKxTz8/Uc/bHDPFJhYpifKY=;
  b=S6uA8+4KPzj9NLDwvm6LoNNtTfjdLKV000FpRQ0eKBQtqFZLscK19jMI
   kniLG4tXTq9cTK6UWrG3sLsVWJfWHmKi17vha/FHmvTOUXpj9t6uYLQ6m
   gNuiBRiwx+MdGolirXQJgifobPuhG99Up1XDbnQdfE4RY18ojhdGw5kDz
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Apr 2022 11:23:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 11:23:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 11:23:24 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 11:23:22 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH] mac80211: Reset MBSSID parameters upon connection
Date:   Wed, 27 Apr 2022 23:53:05 +0530
Message-ID: <20220427182305.11703-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently MBSSID parameters in struct ieee80211_bss_conf
are not reset upon connection. This could be problematic
with some drivers in a scenario where the device first
connects to a non-transmit BSS and then connects to a
transmit BSS of a Multi BSS AP. The MBSSID parameters
which are set after connecting to a non-transmit BSS will
not be reset and the same parameters will be passed on to
the driver during the subsequent connection to a transmit
BSS of a Multi BSS AP.

For example, firmware running on the ath11k device uses the
Multi BSS data for tracking the beacon of a non-transmit BSS
and reports the driver when there is a beacon miss. If we do
not reset the MBSSID parameters during the subsequent
connection to a transmit BSS, then the driver would have
wrong MBSSID data and FW would be looking for an incorrect
BSSID in the MBSSID beacon of a Multi BSS AP and reports
beacon loss leading to an unstable connection.

Reset the MBSSID parameters upon every connection to solve this
problem.

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 net/mac80211/mlme.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b857915881e0..07a96f7c5dc3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3657,6 +3657,12 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				cbss->transmitted_bss->bssid);
 		bss_conf->bssid_indicator = cbss->max_bssid_indicator;
 		bss_conf->bssid_index = cbss->bssid_index;
+	} else {
+		bss_conf->nontransmitted = false;
+		memset(bss_conf->transmitter_bssid, 0,
+		       sizeof(bss_conf->transmitter_bssid));
+		bss_conf->bssid_indicator = 0;
+		bss_conf->bssid_index = 0;
 	}
 
 	/*
-- 
2.35.1

