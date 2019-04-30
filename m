Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033ABF0DA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 09:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfD3HDq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 03:03:46 -0400
Received: from nbd.name ([46.4.11.11]:60876 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfD3HDq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 03:03:46 -0400
Received: from p548c87b5.dip0.t-ipconnect.de ([84.140.135.181] helo=bertha.fritz.box)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hLMno-0008Ac-Nx; Tue, 30 Apr 2019 09:03:44 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH V2 0/3] mac80211: add code to explicitly enable TWT support inside the driver
Date:   Tue, 30 Apr 2019 09:03:35 +0200
Message-Id: <20190430070338.4006-1-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

At least ath11k needs an extra FW call to enable TWT inside the HW. This
series adds code to trigger this from within start_ap() and also STA assoc
events.

Changes in V2
* fix 2 typos
* move from bbs_config to start_ap

John Crispin (3):
  mac80211: dynamically enable the TWT requester support on STA
    interfaces
  mac80211: allow turning TWT responder support on and off via netlink
  ath11k: add TWT support

 drivers/net/wireless/ath/ath11k/mac.c |  7 +++
 drivers/net/wireless/ath/ath11k/wmi.c | 91 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 71 +++++++++++++++++++++++++++
 include/net/cfg80211.h                |  2 +
 include/net/mac80211.h                |  5 ++
 include/uapi/linux/nl80211.h          |  4 ++
 net/mac80211/cfg.c                    |  4 +-
 net/mac80211/mlme.c                   | 18 ++++++-
 net/wireless/nl80211.c                |  5 ++
 9 files changed, 204 insertions(+), 3 deletions(-)

-- 
2.11.0

