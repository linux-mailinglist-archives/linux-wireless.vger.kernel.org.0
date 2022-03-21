Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102F84E2EFB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 18:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351798AbiCURYj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 13:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351792AbiCURYi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 13:24:38 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700B83BF8E
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647883392; x=1679419392;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=yirBN0FCyH1Z6wIMXksUg4ALNTNGcfiiNQVe+V5YtEI=;
  b=vuT/VUTwXON+MtCuJSAOTgkYZRflXKVs2EmkM2DBSiVdetMHZlJIZHiR
   957qz0U9eDI5pcHk0N9gbTFE4HOQk1ewSmtaVdvlNeGUHJZIZKMfJ/Lm3
   Iz4agvUPB3LaK2oiktVncHi3NTKXcjb7AliGYQ5Ctto0T0ntuz+pRsXQl
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Mar 2022 10:23:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 10:23:11 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 10:23:11 -0700
Received: from ppranees-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 03:17:15 -0700
From:   P Praneesh <quic_ppranees@quicinc.com>
To:     <ath11k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v4 0/3] mac80211: Add extended ROC support for 40-80 MHz bandwidth
Date:   Mon, 21 Mar 2022 15:46:34 +0530
Message-ID: <1647857797-19749-1-git-send-email-quic_ppranees@quicinc.com>
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

This patch add extended roc support for 40 and 80 Mhz bandwidth.
It helps to handle remain on channel for wide band scan in ath11k.
---
v4:
	- added feature check based on the hardware advertisement
	  SUPPORTS_EXT_REMAIN_ON_CHAN and addressed other review comments.
v3:
	- addressed Johannes comment to use ROC instead of SCAN command and
	  changed cover letter title from 'add Wide Band Scan support' to
	  'mac80211: Add extended ROC support for 40-80 MHz bandwidth'
v2:
	- updated message on cover letter.

---
P Praneesh (3):
  nl80211: Extended ROC support for 40-80 MHz bandwidth
  ath11k: Refactor update channel list function
  ath11k: Add ROC support for wide band scan

 drivers/net/wireless/ath/ath10k/mac.c              |   3 +-
 drivers/net/wireless/ath/ath11k/core.c             |   1 +
 drivers/net/wireless/ath/ath11k/mac.c              | 215 ++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/reg.c              |  49 +++--
 drivers/net/wireless/ath/ath11k/reg.h              |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  59 +++++-
 drivers/net/wireless/ath/ath11k/wmi.h              |  26 ++-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |   5 +-
 drivers/net/wireless/ath/ath6kl/wmi.c              |  10 +-
 drivers/net/wireless/ath/ath9k/main.c              |   4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |  13 +-
 drivers/net/wireless/ath/wil6210/p2p.c             |  27 ++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |  10 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   3 +-
 drivers/net/wireless/mac80211_hwsim.c              |   3 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |  10 +-
 drivers/net/wireless/marvell/mwifiex/sta_event.c   |   4 +-
 drivers/net/wireless/marvell/mwifiex/uap_event.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   3 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  17 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |   3 +-
 drivers/net/wireless/ti/wlcore/main.c              |   3 +-
 drivers/staging/rtl8723bs/include/ioctl_cfg80211.h |   4 +-
 include/net/cfg80211.h                             |  17 +-
 include/net/mac80211.h                             |   5 +-
 net/mac80211/debugfs.c                             |   1 +
 net/mac80211/driver-ops.h                          |   6 +-
 net/mac80211/ieee80211_i.h                         |   4 +-
 net/mac80211/offchannel.c                          |  64 +++---
 net/mac80211/trace.h                               |   9 +-
 net/wireless/nl80211.c                             |  27 +--
 net/wireless/rdev-ops.h                            |   6 +-
 net/wireless/trace.h                               |  44 ++---
 35 files changed, 489 insertions(+), 176 deletions(-)

-- 
2.7.4

