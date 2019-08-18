Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727019174B
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2019 16:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfHROPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Aug 2019 10:15:36 -0400
Received: from alexa-out-ams-01.qualcomm.com ([185.23.61.162]:44201 "EHLO
        alexa-out-ams-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbfHROPg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Aug 2019 10:15:36 -0400
Received: from ironmsg02-ams.qualcomm.com ([10.251.56.3])
  by alexa-out-ams-01.qualcomm.com with ESMTP; 18 Aug 2019 16:15:32 +0200
Received: from unknown (HELO wigig-1329.mea.qualcomm.com) ([10.4.89.235])
  by ironmsg02-ams.qualcomm.com with ESMTP; 18 Aug 2019 16:15:26 +0200
From:   Alexei Avshalom Lazar <ailizaro@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: [PATCH v7 0/2] Add support for new channels on 60GHz band
Date:   Sun, 18 Aug 2019 17:15:17 +0300
Message-Id: <1566137719-3544-1-git-send-email-ailizaro@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following set of patches add support for new channels on
60GHz band and EDMG channels:
Changelog:
V7:
- Checkpatch fix in wil6210 driver
- Verify stats initialized in wil6210 driver
V6:
- Update commit message
- Initialize chandef variable
V5:
- Addressed to comments from the community
- Added enum for bw_config
- Updated nla_policy to NLA_POLICY_RANGE()
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
  wil6210: Add EDMG channel support
  nl support for dmtool

 drivers/net/wireless/ath/wil6210/Kconfig     |  11 ++
 drivers/net/wireless/ath/wil6210/Makefile    |   1 +
 drivers/net/wireless/ath/wil6210/cfg80211.c  | 206 +++++++++++++++++++++-
 drivers/net/wireless/ath/wil6210/ioctl.c     | 245 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/wil6210/netdev.c    |   8 +
 drivers/net/wireless/ath/wil6210/txrx_edma.c |   2 +
 drivers/net/wireless/ath/wil6210/txrx_edma.h |   6 +
 drivers/net/wireless/ath/wil6210/wil6210.h   |   9 +-
 drivers/net/wireless/ath/wil6210/wmi.c       |   5 +-
 drivers/net/wireless/ath/wil6210/wmi.h       |  26 ++-
 include/uapi/linux/wil6210_uapi.h            |  77 +++++++++
 11 files changed, 583 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/wireless/ath/wil6210/ioctl.c
 create mode 100644 include/uapi/linux/wil6210_uapi.h

-- 
2.7.4

