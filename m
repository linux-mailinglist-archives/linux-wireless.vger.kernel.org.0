Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7226B2A3FCB
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 10:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKCJRy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 04:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgKCJRw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 04:17:52 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B7EC061A49
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 01:17:52 -0800 (PST)
Received: from [149.224.151.57] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kZsRo-0006BN-Hq; Tue, 03 Nov 2020 10:17:48 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH V5 0/4] mac80211: add multiple bssid support
Date:   Tue,  3 Nov 2020 10:17:39 +0100
Message-Id: <20201103091743.1924854-1-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds support for multiple bssid beacon/EMA support for AP mode.

Changes in V5
* rebase on current next tree
* minor code cleanups

John Crispin (4):
  nl80211: add basic multiple bssid support
  mac80211: add multiple bssid support to interface handling
  mac80211: add multiple bssid/EMA support to beacon handling
  mac80211: don't allow CSA on non-transmitting interfaces

 include/net/cfg80211.h       |  33 ++++++++
 include/net/mac80211.h       | 118 +++++++++++++++++++++++++-
 include/uapi/linux/nl80211.h |  21 +++++
 net/mac80211/cfg.c           | 113 ++++++++++++++++++++++++-
 net/mac80211/debugfs.c       |   1 +
 net/mac80211/ieee80211_i.h   |   2 +
 net/mac80211/iface.c         |   6 ++
 net/mac80211/tx.c            | 156 +++++++++++++++++++++++++++++++----
 net/wireless/nl80211.c       |  34 ++++++++
 9 files changed, 463 insertions(+), 21 deletions(-)

-- 
2.25.1

