Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DC13E9A7B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhHKVpR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:45:17 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:52164 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229589AbhHKVpP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:15 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.131])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3204A1A006C
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 113EA980074
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 76EAE13C2B1;
        Wed, 11 Aug 2021 14:44:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 76EAE13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718289;
        bh=/HMBBDH6gmnTZKeuRxLMubyCWNPTkOrgAGEYlNBaaAM=;
        h=From:To:Cc:Subject:Date:From;
        b=PgEqWPPochQU/fUIb+LRY4F7aj0IzWmfS++1vRCzsUpsYDnKF+IzPtz9pgeZQErdm
         BpXBKEr7qvGWhKsH3gna7R8uCuwXb+RZjzICVwEIUg67x5VtddovT5Zo49+qL6dvQ2
         iVij1zaDffueTg98a4dU6L5pxdyPcz7jq9wPza64=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 00/15] mt7915 stats and debugging improvements.
Date:   Wed, 11 Aug 2021 14:44:24 -0700
Message-Id: <20210811214439.17458-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718290-pnNF7KTR6_O2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Allow enabling group-5 rx stats, improve ethtool counters,
debugfs entries to getting some fw stats.

This goes on top of the previous two series I have posted
for this driver.

Ben Greear (15):
  mt76: mt7915:  add comments about rx descriptor parsing
  mt76: mt7915:  print out hw revision
  mt76: mt7915:  tx_stats debugfs to read from mib
  mt76: mt7915:  support enabling rx group-5 status
  mt76: mt7915:  use nss for calculating rx-chains
  mt76: mt7915:  rename amsdu_pack_stats to tx_amsdu_pack_stats
  mt76: mt7915:  ethtool group-5 rx stats information
  mt76: mt7915:  ethtool counters for driver rx path
  mt76: mt7915:  fix rate rix and flags in txs path
  mt76: mt7915:  add ethtool tx/rx pkts/bytes
  mt76: mt7915:  debugfs display for pse non-empty queues
  mt76: mt7915: add more pse queue data to debugfs
  mt76: mt7915:  add rx-ppdu-size-out-of-range ethtool counter
  mt76: mt7915:  ethtool and mib rx stats
  mt76: mt7915:  poll mib counters every 200ms

 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 305 ++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   3 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 195 +++++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 161 +++++-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |   2 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  49 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 493 ++++++++++++++++++
 7 files changed, 1160 insertions(+), 48 deletions(-)

-- 
2.20.1

