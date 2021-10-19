Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A97F433346
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 12:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhJSKPG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 06:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhJSKPF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 06:15:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35AD561374;
        Tue, 19 Oct 2021 10:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634638373;
        bh=lKKiMWNMXzWec0e3mDgtclD1MMg7YAAZvR3UYYz+2AU=;
        h=From:To:Cc:Subject:Date:From;
        b=ZgtMO7XhcKv2RLMwuhcpQ+5YWKqQNGn1uz5A87elwv6MQ1cbTrcvzRlAyl/oMmD9s
         x+siWoyJKA0WxFkyK+UadmbDIyUVlE2SGhoGZ5RyOHKVn0Tox8rBSEIKLmpIkrJIPn
         WXYzJLRSyJxuBOHUlVR1wMZfzEzoiQSI9H5NSikq7WX9ItphgE5BPw4dtH+KoWvgQd
         Jr8lC97L8flVn0miDbR7vaXWrTm398RopPmTWnJXvKjQUpi/636KKor80SpU9VseQl
         v0fuKKo+H5pL2dOrzztH2w/XT7L6tL0s3f85MZYYblg0UdLyGxhBtjlGhl9WaOVtwc
         9yGyOBzQMLomA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 00/10] mt76: ethtool stats features and fixes
Date:   Tue, 19 Oct 2021 12:12:22 +0200
Message-Id: <cover.1634637742.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- mt7921: add ethtool support similar to mt7915 driver
- mt7915: some ethtool fixes

Changes since v1:
- rebase on top of "Add MT7921 SDIO WiFi support"
  https://patchwork.kernel.org/project/linux-wireless/list/?series=565859
- do not reset MIB counters in .get_stats callback

Lorenzo Bianconi (10):
  mt76: move mt76_sta_stats in mt76.h
  mt76: move mt76_ethtool_worker_info in mt76 module
  mt76: mt7915: run mt7915_get_et_stats holding mt76 mutex
  mt76: mt7915: move tx amsdu stats in mib_stats
  mt76: do not reset MIB counters in get_stats callback
  mt76: mt7921: add some more MIB counters
  mt76: mt7921: introduce stats reporting through ethtool
  mt76: mt7921: add sta stats accounting in mt7921_mac_add_txs_skb
  mt76: mt7921: move tx amsdu stats in mib_stats
  mt76: mt7921: add per-vif counters in ethtool

 drivers/net/wireless/mediatek/mt76/mac80211.c |  28 +++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  17 ++
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   2 -
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  24 +--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  11 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  60 ++-----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  13 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  27 ++-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  49 ++++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 169 +++++++++++++++++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  22 +++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  28 +++
 12 files changed, 362 insertions(+), 88 deletions(-)

-- 
2.31.1

