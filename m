Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8F91B909
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 16:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfEMOsx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 10:48:53 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:65258 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730112AbfEMOsx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 10:48:53 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 May 2019 10:48:52 EDT
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 13 May 2019 16:42:45 +0200
X-IronPort-AV: E=McAfee;i="5900,7806,9255"; a="8085233"
Received: from unknown (HELO wigig-1329.mea.qualcomm.com) ([10.4.89.235])
  by ironmsg03-ams.qualcomm.com with ESMTP; 13 May 2019 16:42:44 +0200
From:   Alexei Avshalom Lazar <ailizaro@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: [PATCH v2 0/2] Add support for new channels on 60GHz band
Date:   Mon, 13 May 2019 17:42:32 +0300
Message-Id: <1557758554-18907-1-git-send-email-ailizaro@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following set of patches add support for new channels on
60GHz band and EDMG channels:
-Nl80211 support for EDMG channels
-Wil6210 support for EDMG channels

Alexei Avshalom Lazar (2):
  nl80211: Add support for EDMG channels
  wil6210: Add EDMG channel support

 drivers/net/wireless/ath/wil6210/cfg80211.c  | 205 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/wil6210/txrx_edma.c |   2 +
 drivers/net/wireless/ath/wil6210/txrx_edma.h |   6 +
 drivers/net/wireless/ath/wil6210/wil6210.h   |   8 +-
 drivers/net/wireless/ath/wil6210/wmi.c       |   5 +-
 drivers/net/wireless/ath/wil6210/wmi.h       |  30 +++-
 include/net/cfg80211.h                       |  39 ++++-
 include/uapi/linux/nl80211.h                 |  19 +++
 net/wireless/chan.c                          | 152 +++++++++++++++++++-
 net/wireless/nl80211.c                       |  33 +++++
 net/wireless/util.c                          |  42 +++++-
 11 files changed, 521 insertions(+), 20 deletions(-)

-- 
1.9.1

