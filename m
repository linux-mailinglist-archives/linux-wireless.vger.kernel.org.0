Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2194D4C10A0
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 11:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbiBWKr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 05:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbiBWKr0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 05:47:26 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFCB59A7F
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 02:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645613219; x=1677149219;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=7c1uvbTPd9u8TWIZwiNl+kRfToSOpmbl4FTqgcuGmsI=;
  b=s2/g9/s42GZvwSBx6VxYUe5ka9Hiw7eQ+OKQ5A09q47m5w6niXsBiwOw
   NhBNQqH50we5dGcX9bZ+0humet/Zg9pgM19W0nmc/u0DIb4y1OFvLFnvN
   gA3M46/NcGqOn15zTE1atLsS1PoFBZc1Js3I+Eq9XsO0ThBMrYf47Vrqu
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Feb 2022 02:46:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 02:46:59 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 02:46:58 -0800
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 02:46:57 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_usdutt@quicinc.com>
Subject: [PATCH v2 0/3] cfg80211: Add MLO Link Device abstraction
Date:   Wed, 23 Feb 2022 16:16:37 +0530
Message-ID: <1645613200-30221-1-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

This patch series adds support for MLO link in STA mode. Add new iface
type (NL80211_IFTYPE_MLO_LINK) to represent MLO link in non-AP MLD mode.
Define several attributes to indicate MLO links info associated with
MLD STA interface to userspace. Add support for key operations on wdev
without netdev to allow configuring per link keys(GTK/IGTK/BIGTK).

Sunil Dutt (2):
  cfg80211: Add NL80211_IFTYPE_MLO_LINK type for MLO links on MLD STA
  cfg80211: Indicate MLO links info in connect/roam events

Veerendranath Jakkam (1):
  cfg80211: Add support for key operations on NL80211_IFTYPE_MLO_LINK

Added required changes in "cfg80211: Add support for key operations on
NL80211_IFTYPE_MLO_LINK" patch to fix the compilation issue reported by
"kernel test robot <lkp@intel.com>".

 drivers/net/wireless/ath/ath6kl/cfg80211.c         |  52 ++++-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |  38 ++--
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  58 +++--
 drivers/net/wireless/marvell/libertas/cfg.c        |  14 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |  40 +++-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  48 ++++-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |  40 +++-
 drivers/net/wireless/rndis_wlan.c                  |  24 ++-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  40 +++-
 drivers/staging/wlan-ng/cfg80211.c                 |  41 +++-
 include/net/cfg80211.h                             |  78 ++++++-
 include/uapi/linux/nl80211.h                       |  50 +++++
 net/mac80211/cfg.c                                 |  59 ++++--
 net/mac80211/chan.c                                |   2 +
 net/mac80211/iface.c                               |   2 +
 net/mac80211/util.c                                |   1 +
 net/wireless/chan.c                                |  21 ++
 net/wireless/core.c                                | 100 ++++++++-
 net/wireless/core.h                                |  16 ++
 net/wireless/ibss.c                                |   2 +-
 net/wireless/nl80211.c                             | 233 +++++++++++++++++----
 net/wireless/rdev-ops.h                            |  36 ++--
 net/wireless/scan.c                                |  25 +++
 net/wireless/sme.c                                 |  81 ++++++-
 net/wireless/trace.h                               |  68 +++---
 net/wireless/util.c                                |  10 +-
 net/wireless/wext-compat.c                         |  10 +-
 27 files changed, 966 insertions(+), 223 deletions(-)

-- 
2.7.4

