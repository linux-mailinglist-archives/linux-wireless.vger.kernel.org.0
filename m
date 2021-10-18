Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6A4318A1
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 14:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhJRMQ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 08:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231615AbhJRMQZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 08:16:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE87460FDA;
        Mon, 18 Oct 2021 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634559254;
        bh=Xsv+bqMBmvbtOgGtWcP5peL+Qep20XwjLSwlb41OpkU=;
        h=From:To:Cc:Subject:Date:From;
        b=DRtN4WPDM2hSR5/PgJ2K7Mhm0tyaph3NZ56VQuNvMiWDfeKuTXig5/Exq1hEdYunH
         plyr95bGFl2YduAYLaX05XDFzQHQDOxw7gQi5+Uj+llndc3eiV7EPHo1I1mpv1uIu/
         b5b68cs1bO8zUS4K+mlbwZbSIXxSoaEY609DHTZ35VbPUMsSHFXerXANeLfACoMwpR
         LiWFM0WwwaeMJvym+kKa/kZSbrbbtwdGh1QPl6uh5fTG72IUc59/tLzMkw5KwHFYZ7
         1JSXE4/lkQu5AwP+U6v33E1qv9Wud2C9NbJdN6ugZkmvmk6d4O0zyptckTKx8lCLYQ
         E39VGvRPEi7VA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com
Subject: [PATCH 00/10] mt76: ethtool stats features and fixes
Date:   Mon, 18 Oct 2021 14:13:59 +0200
Message-Id: <cover.1634558817.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- mt7921: add ethtool support similar to mt7915 driver
- mt7915: some ethtool fixes

Lorenzo Bianconi (10):
  mt76: move mt76_sta_stats in mt76.h
  mt76: mt7921: add sta stats accounting in mt7921_mac_add_txs_skb
  mt76: mt7921: add some more MIB counters
  mt76: mt7921: introduce stats reporting through ethtool
  mt76: mt7921: move tx amsdu stats in mib_stats
  mt76: move mt76_ethtool_worker_info in mt76 module
  mt76: mt7921: add per-vif counters in ethtool
  mt76: mt7915: run mt7915_get_et_stats holding mt76 mutex
  mt76: mt7915: do not overwrite all mib counters in mt7915_get_stats
  mt76: mt7915: move tx amsdu stats in mib_stats

 drivers/net/wireless/mediatek/mt76/mac80211.c |  28 +++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  17 ++
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  24 +--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  11 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  59 ++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  13 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  27 ++-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  49 ++++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 169 +++++++++++++++++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  22 +++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  28 +++
 11 files changed, 363 insertions(+), 84 deletions(-)

-- 
2.31.1

