Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF754997E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 08:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfFRGyV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 02:54:21 -0400
Received: from nbd.name ([46.4.11.11]:59432 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbfFRGyV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 02:54:21 -0400
Received: from p5dcfbabb.dip0.t-ipconnect.de ([93.207.186.187] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hd7Sh-0000Ad-6y; Tue, 18 Jun 2019 08:19:19 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH V3 0/2] mac80211: HE: add SPR/OBSSPD support
Date:   Tue, 18 Jun 2019 08:19:13 +0200
Message-Id: <20190618061915.7102-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds support for propagating the OBSS PD information from
assocs to a wireless driver.

Changes in V2
* always use bss_conf as per request from Johannes

Changes in V3
* remove reference to mac80211 inside comment

John Crispin (2):
  mac80211: HE: add Spatial Reuse IE parsing support
  mac80211: allow setting spatial reuse parameters from bss_conf

 include/linux/ieee80211.h    | 49 ++++++++++++++++++++++++++++++++++++
 include/net/cfg80211.h       | 15 +++++++++++
 include/net/mac80211.h       |  4 +++
 include/uapi/linux/nl80211.h | 27 ++++++++++++++++++++
 net/mac80211/cfg.c           |  5 +++-
 net/mac80211/he.c            | 24 ++++++++++++++++++
 net/mac80211/ieee80211_i.h   |  4 +++
 net/mac80211/mlme.c          |  1 +
 net/mac80211/util.c          |  4 +++
 net/wireless/nl80211.c       | 43 +++++++++++++++++++++++++++++++
 10 files changed, 175 insertions(+), 1 deletion(-)

-- 
2.20.1

