Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69664582025
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 08:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiG0Gcu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 02:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiG0Gcr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 02:32:47 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3773C8F7
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jul 2022 23:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658903566; x=1690439566;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=StAwd9Yq3ilcHJTzCCnVUCEz2K4sPRTAkvruuE94TMc=;
  b=Ci24JRs+9f9cC/ZnYwfXyzp4KldTGoJOnW3hS0mH6kAoQ6nBFlp8vhqA
   pMDlq6HS8w7QtmtoaxOCLgthNWo9IXGU3foK55wF2JnkItItCQIiODpp2
   vV6tS1DDaBCKiHlfwAugcCm4EQsUjpo6JCLOO6ropi/WDn9XsaX6xzG+a
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Jul 2022 23:32:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 23:32:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 23:32:45 -0700
Received: from haric-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 23:32:43 -0700
From:   <quic_haric@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH] mac80211 : allow bw change during channel switch in mesh
Date:   Wed, 27 Jul 2022 12:02:29 +0530
Message-ID: <1658903549-21218-1-git-send-email-quic_haric@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Hari Chandrakanthan <quic_haric@quicinc.com>

From 'IEEE Std 802.11-2020 section 11.8.8.4.1' :
The mesh channel switch may be triggered by the need to avoid
interference to a detected radar signal, or to reassign mesh STA
channels to ensure the MBSS connectivity.
A 20/40 MHz MBSS may be changed to a 20 MHz MBSS and a 20 MHz MBSS may be
changed to a 20/40 MHz MBSS.

Since the standard allows the change of bandwidth during
the channel switch in mesh, remove the bandwidth check present in
ieee80211_set_csa_beacon.

Fixes: c6da674aff94 ("{nl,cfg,mac}80211: enable the triggering of CSA frame in mesh")
Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
---
 net/mac80211/cfg.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index fe6500b..5db2cba 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3598,9 +3598,6 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_MESH_POINT: {
 		struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 
-		if (params->chandef.width != sdata->vif.bss_conf.chandef.width)
-			return -EINVAL;
-
 		/* changes into another band are not supported */
 		if (sdata->vif.bss_conf.chandef.chan->band !=
 		    params->chandef.chan->band)
-- 
2.7.4

