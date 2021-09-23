Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA019416105
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbhIWOby (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 10:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241501AbhIWObx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 10:31:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5225610C8;
        Thu, 23 Sep 2021 14:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632407422;
        bh=rhiK11k7hRsu0uixXkVim00XNZQGwjjIjuhvhjLUrD8=;
        h=From:To:Cc:Subject:Date:From;
        b=YX4DetzHeV/ENAfqzxuYg2+IYmkbm3Uhr2iYxKRuEps6QyGbe486o5cL+GUv1ABmN
         IKLh5JNVlBRUDQPmrtKANkSckl+4yZRkGBS475GdsWYv0ytJrNSdq5e+OseFRB4Gew
         53yS/FCr02YqO5UEjCPrjiA95my6dsnlNBDb3UN/GepSm61/3D5h4BLo/3STRBPrwa
         fynY0zgTvGqeh81yDLnTI3xg5/1IOmwMz1IfD6l4TyxJNWJI22Va+kcIcCYlQYN9em
         spyIkSfk9quRPKL5r6nVP40tEDf1YSfB90IV0AeZ0+y6B/9oQaJcuXeK7SahNFfGEZ
         67PnJoveAxEjA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v5 0/5] introduce individual TWT support in AP mode
Date:   Thu, 23 Sep 2021 16:29:29 +0200
Message-Id: <cover.1632406731.git.lorenzo@kernel.org>
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

Changes since v4:
- drop mac80211 patches since they are already applied
- fix table_id configuration

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

Lorenzo Bianconi (5):
  mt76: mt7915: introduce __mt7915_get_tsf routine
  mt76: mt7915: introduce mt7915_mcu_twt_agrt_update mcu command
  mt76: mt7915: introduce mt7915_mac_add_twt_setup routine
  mt76: mt7915: enable twt responder capability
  mt76: mt7915: add twt_stats knob in debugfs

 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  28 +++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   3 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 179 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  39 +++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  50 +++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |   9 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  42 +++-
 7 files changed, 344 insertions(+), 6 deletions(-)

-- 
2.31.1

