Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709383CB94E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jul 2021 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbhGPPHY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jul 2021 11:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240066AbhGPPHY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jul 2021 11:07:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BBF060FF3;
        Fri, 16 Jul 2021 15:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626447867;
        bh=rJSkckdOG7FaH0XjPRhUdD9DnqAhptDshlk3zJIv19g=;
        h=From:To:Cc:Subject:Date:From;
        b=idSYbDhC9bs9t4V0VNRIsDZr0CvdPbV/x1P5rBElJSkAKNdlj8ywmrb31TFxvagxw
         zwpRTOFPPimH0ZdPmSqGT6vgMadHO4crsFjgYNLuSVGxC13Dk3hviqJViwV3tQyigq
         MOxDf6iwuT3SOpmWBEkbpFmEFIi+8LUB2ji9p6jIyiN9x7exzn0pOWV9hJbefdAF/h
         iGXdVcUSJYUSAwa7gKs1i9HIA6vj8JeZCSTjukZIpgJUd6aS5pj7y8alkZjqLgDrxz
         MzDsTZRwPobz/b0hXQf4TUMMH90gemNoR2OLuxtYpwn/5Ke3neQKq9Azqv9YAl6i74
         xnMlTpCaqI6eQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name, ryder.lee@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [RFC mac80211-next 0/7] introduce individual TWT support in AP mode
Date:   Fri, 16 Jul 2021 17:03:59 +0200
Message-Id: <cover.1626447537.git.lorenzo@kernel.org>
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
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 193 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  39 +++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  50 +++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |   9 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  39 +++-
 include/linux/ieee80211.h                     |  67 ++++++
 include/net/mac80211.h                        |  13 ++
 net/mac80211/driver-ops.h                     |  24 +++
 net/mac80211/ieee80211_i.h                    |   3 +
 net/mac80211/iface.c                          |  10 +
 net/mac80211/rx.c                             |  54 +++++
 net/mac80211/s1g.c                            | 183 +++++++++++++++++
 net/mac80211/status.c                         |  30 ++-
 15 files changed, 738 insertions(+), 7 deletions(-)

-- 
2.31.1

