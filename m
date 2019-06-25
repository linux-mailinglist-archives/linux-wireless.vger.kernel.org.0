Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A55652FFD
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 12:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfFYKfs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 06:35:48 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:59839 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbfFYKfr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 06:35:47 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 06:35:43 EDT
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 25 Jun 2019 12:29:36 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9298"; a="8582037"
Received: from unknown (HELO wigig-1329.mea.qualcomm.com) ([10.4.89.235])
  by ironmsg03-ams.qualcomm.com with ESMTP; 25 Jun 2019 12:29:30 +0200
From:   Alexei Avshalom Lazar <ailizaro@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: [PATCH v3 0/2] Add support for new channels on 60GHz band
Date:   Tue, 25 Jun 2019 13:29:25 +0300
Message-Id: <1561458567-31866-1-git-send-email-ailizaro@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following set of patches add support for new channels on
60GHz band and EDMG channels:
Changelog:
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
 include/net/cfg80211.h                       |  36 ++++-
 include/uapi/linux/nl80211.h                 |  22 +++
 net/wireless/chan.c                          | 158 ++++++++++++++++++++-
 net/wireless/nl80211.c                       |  35 +++++
 net/wireless/util.c                          |  42 +++++-
 11 files changed, 529 insertions(+), 20 deletions(-)

-- 
1.9.1

