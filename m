Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAB76152F
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jul 2019 16:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGGOMY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Jul 2019 10:12:24 -0400
Received: from alexa-out-ams-01.qualcomm.com ([185.23.61.162]:9325 "EHLO
        alexa-out-ams-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfGGOMX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Jul 2019 10:12:23 -0400
Received: from ironmsg01-ams.qualcomm.com ([10.251.56.2])
  by alexa-out-ams-01.qualcomm.com with ESMTP; 07 Jul 2019 16:12:22 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9310"; a="8689572"
Received: from unknown (HELO wigig-1329.mea.qualcomm.com) ([10.4.89.235])
  by ironmsg01-ams.qualcomm.com with ESMTP; 07 Jul 2019 16:12:16 +0200
From:   Alexei Avshalom Lazar <ailizaro@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: [PATCH v4 0/2] Add support for new channels on 60GHz band
Date:   Sun,  7 Jul 2019 17:12:05 +0300
Message-Id: <1562508727-17082-1-git-send-email-ailizaro@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following set of patches add support for new channels on
60GHz band and EDMG channels:
Changelog:
V4:
- Addressed to comments from the community
- Updated comments and variable name
V3:
- Addressed to comments from the community
- Added 60G check for verifying some EDMG cases are relevant
- Used the ieee80211_sta_edmg_cap struct as the edmg channel configuration
- Updated nla_policy to NLA_POLICY_RANGE()
V2
- Addressed to comments from the community
- Align to latest Spec release

Alexei Avshalom Lazar (2):
  nl80211: Add support for EDMG channels
  wil6210: Add EDMG channel support

 drivers/net/wireless/ath/wil6210/cfg80211.c  | 205 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/wil6210/txrx_edma.c |   2 +
 drivers/net/wireless/ath/wil6210/txrx_edma.h |   6 +
 drivers/net/wireless/ath/wil6210/wil6210.h   |   8 +-
 drivers/net/wireless/ath/wil6210/wmi.c       |   5 +-
 drivers/net/wireless/ath/wil6210/wmi.h       |  30 +++-
 include/net/cfg80211.h                       |  37 ++++-
 include/uapi/linux/nl80211.h                 |  22 +++
 net/wireless/chan.c                          | 158 ++++++++++++++++++++-
 net/wireless/nl80211.c                       |  35 +++++
 net/wireless/util.c                          |  42 +++++-
 11 files changed, 530 insertions(+), 20 deletions(-)

-- 
1.9.1

