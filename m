Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426C041B2B6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbhI1PQ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 11:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241080AbhI1PQ0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 11:16:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD84C6120D;
        Tue, 28 Sep 2021 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632842087;
        bh=x4sdbYlv2Fw2NBY7XGgKWNnqRMfVh408TP/JdMwdQWk=;
        h=From:To:Cc:Subject:Date:From;
        b=fD+tEbbFwJHO8UrFexH0fiWz6o5YIgqdneFlE3tW5fXhvGkkqTjVwgjV1WFlMZXvG
         Xyu4bun1gUF2wIim+aWfXm7MrUNW61rUwmOKnErnzP0VV3sKv4k02CwdcQbd06iR4n
         FfBOxZOZO8ruTPzSrfhAMB6zg/c9E6Q98x1wrsZ4u5B+Ln8zRhsXWAYOqJh7ZDQ7EP
         1LzEIsGIknVD6eIbhsKfHbFTxEJhckB1MIhesIdjMYkNsJgAQqMyq1zHCdaEzu9WMz
         Mn4nnXCRjFvoZqQruOgpCejrFn+al+t8zGjEchqGauj1Kq5dP6FlkoIJ1S9+7hYNjE
         9/bHnz1vyb+SQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com, john@phrozen.org
Subject: [RFC 0/7] add offchannel monitor chain support
Date:   Tue, 28 Sep 2021 17:14:31 +0200
Message-Id: <cover.1632841652.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce the capability to configure a dedicated chain available for radar
detection on some hw (e.g. mt7915). The driver is supposed to implement CAC
management in sw or fw while hostapd (or iw) will implement the logic to
select and configure the monitored channel.
Using a dedicated chain to perform the CAC, the AP can avoid the CAC downtime
switching to a new DFS channel.

Lorenzo Bianconi (7):
  mac80211: introduce set_offchan_chain callback
  cfg80211: introduce nl80211_set_offchan_chain callback
  cfg80211: introduce cfg80211_cac_offchan_event routine
  mt76: mt7915: introduce mt7915_set_offchan_chain routine
  mt76: mt7915: enable radar trigger on rdd2
  mt76: mt7915: introduce rdd_monitor debugfs node
  mt76: mt7915: add cac support for offchannel chain

 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 37 +++++++++-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 ++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 57 ++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 33 +++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 67 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 24 +++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 10 +++
 include/net/cfg80211.h                        | 19 ++++++
 include/net/mac80211.h                        |  5 ++
 include/uapi/linux/nl80211.h                  |  6 ++
 net/mac80211/cfg.c                            | 13 ++++
 net/wireless/mlme.c                           | 26 +++++++
 net/wireless/nl80211.c                        | 41 ++++++++++++
 net/wireless/rdev-ops.h                       | 17 +++++
 net/wireless/trace.h                          | 19 ++++++
 15 files changed, 375 insertions(+), 3 deletions(-)

-- 
2.31.1

