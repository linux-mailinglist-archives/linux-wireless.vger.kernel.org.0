Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D5E4FFB4C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Apr 2022 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiDMQc0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Apr 2022 12:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbiDMQcY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Apr 2022 12:32:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FEE5AECC
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649867400; x=1681403400;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=HoVVyU3PfDjcbuJmaJXA6a0mb47RJRgDtg7tKrlqpF0=;
  b=QJRgePuo2FM/nR30Edckt+hx382SFQFQbd/ZeNkwE4PxZNVUsSJQkeAl
   /cXMd49iHAuKdL5UmNyJFX+abWysN26uzEhJAeTro9Hx2RxSsmbtWbWuw
   ce98eE4APTqhPpqwzqRdsxhiZt9iE4Baq3tsrUW4UeBhyiWvMB3wihAxY
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Apr 2022 09:29:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:29:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 09:29:58 -0700
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 09:29:56 -0700
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v5 0/2] Disable BSS color collision detection in case of no free colors
Date:   Wed, 13 Apr 2022 21:58:13 +0530
Message-ID: <1649867295-7204-1-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

AP may run out of BSS color after color collision
detection event from driver.
Disable BSS color collision detection if no free colors are
available based on bss color disabled bit sent as a part of
NL80211_ATTR_HE_BSS_COLOR attribute sent in
NL80211_CMD_SET_BEACON.

Changes since v4:
 - Added new flag he_bss_color_valid to indicate presence
   of NL80211_ATTR_HE_BSS_COLOR
 - Split the changes into two patches.

Changes since v3:
 - Updated subject

Changes since v2:
 - Moved the logic to ieee80211_change_beacon() to have this
   BSS color enabled unset only during set_beacon case based
   on NL80211_ATTR_HE_BSS_COLOR attribute sent by hostapd.
 - Removed the relocation and parsing changes done on v1 and moved
   he_bss_color to cfg80211_beacon_data and parsed
   NL80211_ATTR_HE_BSS_COLOR in nl80211_parse_beacon()

Changes since v1:
 - Relocated ap params to cfg80211_beacon_data and
   nl80211_calculate_ap_params() to nl80211_parse_beacon()
   to have them parsed for all (start_ap and change beacon) commands.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Lavanya Suresh (1):
  mac80211: disable BSS color collision detection in case of no free
    colors

Rameshkumar Sundaram (1):
  nl80211: Parse NL80211_ATTR_HE_BSS_COLOR as a part of     
    nl80211_parse_beacon

 include/net/cfg80211.h |  7 ++++--
 net/mac80211/cfg.c     | 17 ++++++++++----
 net/wireless/nl80211.c | 64 +++++++++++++++++++++++++-------------------------
 3 files changed, 50 insertions(+), 38 deletions(-)

-- 
2.7.4

