Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777493DFC27
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 09:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhHDHhI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 03:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235619AbhHDHhH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 03:37:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EE4A60F14;
        Wed,  4 Aug 2021 07:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628062615;
        bh=agN3xbjA8vyJXuHPILZeK79c/I6tnTv9oUNw3IKL7LE=;
        h=From:To:Cc:Subject:Date:From;
        b=OFVb0tzTa6/sFpIas8NzVj2sEe3V6zlDDBeDWgsdRN7y01zurzoyykAnGQiMM1hdt
         pOPuOwIw8/8OKCRCtfuZt9AFyDkKxa/U9u3CRCa6XC9na1FhTrsYkIg3OMKxUwKLYE
         vO6XySaVsCPmEWhW78XVi5zYBUhorRNm8ciGHRYnzxui6N5TpTBPOmpgRXR889FP0d
         fvVwkuCKl6SioBVKociY8zz+VDIj+U3NZL40DJsPFDfwU4Od3HtLtGCcZXdta+EWad
         RaGktXGm3jzIS+F3XfZZtIfSUkwjqVlW2rpGKQl8dZgRSemYYEjS/1Qzf0x9oN7rKK
         hdHNN0yB5lqtQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH mac80211-next 0/7] introduce individual TWT support in AP mode
Date:   Wed,  4 Aug 2021 09:36:31 +0200
Message-Id: <cover.1628062233.git.lorenzo@kernel.org>
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

