Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDED32A3FE1
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 10:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgKCJWr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 04:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCJWr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 04:22:47 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E27FC0613D1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 01:22:47 -0800 (PST)
Received: from [149.224.151.57] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kZsWb-0006Q9-Dy; Tue, 03 Nov 2020 10:22:45 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH V6 0/3] mac80211: add BSS color change support
Date:   Tue,  3 Nov 2020 10:22:41 +0100
Message-Id: <20201103092244.1925158-1-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds support for BSS color collission detection and change.

This series depends on the multiple bssid one.

Changes in V6
* rebase on current next tree
* add 2 addition guards

John Crispin (3):
  nl80211: add support for BSS coloring
  mac80211: add support for BSS color change
  ath11k: add support for BSS color change

 drivers/net/wireless/ath/ath11k/mac.c |  35 ++++
 drivers/net/wireless/ath/ath11k/mac.h |   1 +
 drivers/net/wireless/ath/ath11k/wmi.c |  57 ++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  14 ++
 include/net/cfg80211.h                |  95 ++++++++++
 include/net/mac80211.h                |  28 +++
 include/uapi/linux/nl80211.h          |  46 +++++
 net/mac80211/cfg.c                    | 250 +++++++++++++++++++++++++-
 net/mac80211/ieee80211_i.h            |  12 ++
 net/mac80211/iface.c                  |   3 +
 net/mac80211/tx.c                     |  24 ++-
 net/wireless/nl80211.c                | 135 ++++++++++++++
 net/wireless/rdev-ops.h               |  12 ++
 net/wireless/trace.h                  |  47 +++++
 14 files changed, 741 insertions(+), 18 deletions(-)

-- 
2.25.1

