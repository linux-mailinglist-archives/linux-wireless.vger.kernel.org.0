Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05833E4AD4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhHIR3N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 13:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234329AbhHIR3M (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 13:29:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7E6B60560;
        Mon,  9 Aug 2021 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628530131;
        bh=XYMCWEcYMl6SUE91xutPU6LHPHaBF/0QvSEAz0w5wkY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZxAw/h2bv1nwcx7LnmghJNNp51UOT+tuTxToAgc73xEowtLdNUmiGx0zHpGjgLIgh
         tPZeh1iasQPaPGx4v5DJMTkfJndp48jr/HcsqaLjjljomdAySXceXajVRxnyr1lcIw
         /whGWLF2r+JMJFWU6y3atH4wBjVuD5fMadyGwaRmXArcr72e1LQtHS38dZ3JbnfDQW
         1Cx17AhstmIAZ6EATBSmwouLimXkdfP2czgdZvGGRvPpv6d+sHFKKiPuakJTCIShI+
         8h8HqMJJVPnmDZ+i7m3TKnd8lSMIzJ6SPgPmqbyj2VydSa6vW95eCEbBLfVrq+F8aT
         pn048DlDygyIA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH v2 mac80211-next 0/7] introduce individual TWT support in AP mode
Date:   Mon,  9 Aug 2021 19:28:26 +0200
Message-Id: <cover.1628529781.git.lorenzo@kernel.org>
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
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 185 ++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  39 +++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  50 +++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |   9 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  39 +++-
 include/linux/ieee80211.h                     |  67 ++++++
 include/net/mac80211.h                        |  13 ++
 net/mac80211/driver-ops.h                     |  24 +++
 net/mac80211/ieee80211_i.h                    |   5 +
 net/mac80211/iface.c                          |  13 ++
 net/mac80211/rx.c                             |  54 +++++
 net/mac80211/s1g.c                            | 198 ++++++++++++++++++
 net/mac80211/status.c                         |  34 ++-
 15 files changed, 754 insertions(+), 7 deletions(-)

-- 
2.31.1

