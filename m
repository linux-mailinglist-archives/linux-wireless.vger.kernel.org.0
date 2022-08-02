Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F0A587743
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 08:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbiHBGun (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 02:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiHBGum (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 02:50:42 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C2060EF
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 23:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659423042; x=1690959042;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=swf5klhNTqw414ycRFxHu3r93E9CMpBlB6kAQlk5sVY=;
  b=FvjqZgpluP2rteaeY8NKDsCYm3JFXmmhy2kdZaWDpXcAI7e1lv/ivxmP
   1IjaP+uEA/gVUAI9OKsJdjcqDxZsRw/yThTdZHziipFeDDZIOvGBgOQYi
   hyj6ueA+OtiA2ZG0p/JcLs7MkmgG+Hm6iprcDEfdUYIeB3rkXN6gyZRq9
   A=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 01 Aug 2022 23:50:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 23:50:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 23:50:40 -0700
Received: from CDCCSTEX0180100-LIN.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 23:50:39 -0700
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [RFC 0/2] wifi: mac80211:  extend rx API with link_id for MLO connection
Date:   Tue, 2 Aug 2022 12:20:17 +0530
Message-ID: <20220802065019.20791-1-quic_vthiagar@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

In MLO, the frames can be received on any of the affiliated links.
When the address translation for rx frames are done in fw/hw, it
is very important to have an explicit link information reported
for every rx frame to mac80211. Per-link processing includes
stats update, GTK/IGTK/BIGTK retrieval and so on. This patch
set only tries to use the link at the top level APIs, deep
rx handlers are yet to be changed to use the respective
link accordingly.

This series is prepared on top of the latest mld branch.

Base mld commit

commit f69d4554386b4d2b56ca883fb97c92d64e188615
Author: Shaul Triebitz <shaul.triebitz@intel.com>
Date:   Sun Jul 24 11:07:32 2022 +0300

    wifi: mac80211: properly set old_links when removing a link

    In ieee80211_sta_remove_link, valid_links is set to
    the new_links before calling drv_change_sta_links, but
    is used for the old_links.

    Change-Id: I7f74b5d818c6154bc544a75a2933ab924b0c8937
    Fixes: cb71f1d136a6 ("wifi: mac80211: add sta link addition/removal")
    Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>


Vasanthakumar Thiagarajan (2):
  wifi: mac80211: add a new field in ieee80211_rx_status for link id
  wifi: mac80211: use link_id from ieee80211_rx_status to retrieve rx
    link

 include/net/mac80211.h |   4 ++
 net/mac80211/rx.c      | 133 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 128 insertions(+), 9 deletions(-)

-- 
2.17.1

