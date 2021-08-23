Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A433F500C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 20:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhHWSDz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 14:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231898AbhHWSDv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 14:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DA746136F;
        Mon, 23 Aug 2021 18:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629741786;
        bh=ARLetWSeDLRHbDXTtzzQ9OIcfS5f2LiuXN6xi6kGKcE=;
        h=From:To:Cc:Subject:Date:From;
        b=mJt6EZ5OCpd/Gn8hfgTHmhYT3iUBbWypL6WNse6EMlBrnUHBcIDzEVeHtXTzuDWek
         YJUGp0RcOZoutnIItO9eNLHl9YHmb1Es60QoqVB5pHR109Gw+h+1N2AhjduAj6PEZx
         6nOU1/Ji+1weZ1Q+FKL/is1jcX8sBo7dkzQm0Dhw4Ob626D9C0gDYtmeSPeGJePU26
         /wzgF4KtdN93Y/i7n10tR3oV6aGklFzE3KTl2Q3X132uC8sbzG3zt8mIbEuxvPdCZh
         uZ8nmKeMO0GyRv3bz2hqy87DiF2naoW0jTdlpniRG69lvLt2XijRO9b9QRwamECRAn
         HAxnig1HkXTNA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH v4 mac80211-next 0/7] introduce individual TWT support in AP mode
Date:   Mon, 23 Aug 2021 20:02:37 +0200
Message-Id: <cover.1629741512.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce TWT action frames parsing support to mac80211.
Currently just individual TWT agreement are support in AP mode.
Whenever the AP receives a TWT action frame from an associated client,
after performing sanity checks, it will notify the underlay driver with
requested parameters in order to check if they are supported and if there
is enough room for a new agreement. The hw is expected to set agreement
result and report it to mac80211.
The two following drv callbacks have been added to mac80211:
- add_twt_setup (mandatory)
- twt_teardown_request (optional)

mac80211 will send an action frame reply according to the result
reported by the driver/fw.
Add individual TWT support to mt7915 in AP mode.

Changes since v3:
- move twt_setup status management in ieee80211_report_used_skb() in order to
  consider when the driver drops the frame on the tx path
- minor changes

Changes since v2:
- introduce status_queue for twt status frame parsing
- add tracing for add_twt_setup/twt_teardown_request
- fix routine naming convention
- always reply with reject frames for broadcast agrt requests

Changes since v1:
- fix rcu unbalance in mt7915/debugfs.c

Changes since rfc:
- run ieee80211_s1g_status_h_twt only for failed twt action frames
- change add_twt_setup return value from int to void


Lorenzo Bianconi (7):
  mac80211: add twt ie in ieee80211_mgmt structure
  mac80211: introduce individual TWT support in AP mode.
  mt76: mt7915: introduce __mt7915_get_tsf routine
  mt76: mt7915: introduce mt7915_mcu_twt_agrt_update mcu command
  mt76: mt7915: introduce mt7915_mac_add_twt_setup routine
  mt76: mt7915: enable twt responder capability
  mt76: mt7915: add twt_stats knob in debugfs

 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  28 +++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   3 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 180 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  39 +++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  50 +++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |   9 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  38 +++-
 include/linux/ieee80211.h                     |  62 ++++++
 include/net/mac80211.h                        |  12 ++
 net/mac80211/driver-ops.h                     |  35 ++++
 net/mac80211/ieee80211_i.h                    |   6 +
 net/mac80211/iface.c                          |  41 ++++
 net/mac80211/rx.c                             |  72 +++++++
 net/mac80211/s1g.c                            | 187 ++++++++++++++++++
 net/mac80211/status.c                         |  17 +-
 net/mac80211/trace.h                          |  67 +++++++
 16 files changed, 838 insertions(+), 8 deletions(-)

-- 
2.31.1

