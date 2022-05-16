Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE215291F6
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiEPUtO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 16:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348199AbiEPUsH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 16:48:07 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD32954032
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 13:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652732706; x=1684268706;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=logqdQO0AhOWfcr9pxeL7bvtV12AiySCPbMN2suLmyI=;
  b=uFUUTckF1tGhH9uor+TCa10fRnw/in0CvWpyby7Myd9ubhWVRS0Upohi
   hDwu+CLsS2Tp3bwh9kByVVXbrZa9eSuvYidbvSeAN/xTH4P55NZl0ez2Y
   4h3exKPkkAt9R2PvsStf28VSiTC944b7kkD1hofwAaEz6/DK/erWJhzR8
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 16 May 2022 13:25:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 13:25:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 13:25:04 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 13:25:04 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v5 0/3] additional processing in NL80211_CMD_SET_BEACON
Date:   Mon, 16 May 2022 13:24:51 -0700
Message-ID: <20220516202454.4925-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FILS discovery and unsolicited broadcast probe response transmissions
are configured as part of NL80211_CMD_START_AP, however both stop
after userspace uses the NL80211_CMD_SET_BEACON command as these
attributes are not processed as part of this command.

- Add the missing implementation in nl80211 and mac80211.
- Modify the local variable in nl80211_set_beacon() and input parameter
to rdev_change_beacon() from type struct cfg80211_beacon_data to
type struct cfg80211_ap_settings to support the new processing.
- Modify ieee80211_change_beacon() to reflect the new input parameter type.
- Modify driver specific functions pointed by change_beacon to
reflect the new input parameter type.

Aloka Dixit (3):
  cfg80211: additional processing in NL80211_CMD_SET_BEACON
  mac80211: process additional data during beacon change
  drivers: modify prototype for beacon change functions

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  4 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  3 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  4 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  4 +-
 include/net/cfg80211.h                        |  2 +-
 net/mac80211/cfg.c                            | 34 +++++++++---
 net/wireless/nl80211.c                        | 28 ++++++++--
 net/wireless/rdev-ops.h                       |  2 +-
 net/wireless/trace.h                          | 52 +++++++++++--------
 11 files changed, 94 insertions(+), 46 deletions(-)


base-commit: 9335156ac0e174721921c404bd173526c8509124
-- 
2.31.1

