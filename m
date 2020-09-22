Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE8273A35
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgIVFhV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:21 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:33938 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726495AbgIVFhU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 302344F9DFE;
        Tue, 22 Sep 2020 05:37:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TJblzonK-Gf3; Tue, 22 Sep 2020 05:37:17 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 1FA764F2279;
        Tue, 22 Sep 2020 05:37:16 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v4 00/17] add support for S1G association
Date:   Mon, 21 Sep 2020 19:28:01 -0700
Message-Id: <20200922022818.15855-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These are the remaining (v4) patches in the S1G association series.

Changes in v4:
 - stop fudging the channel width in cfg80211_chandef_create() (we don't
   actually need it).
 - use NLA_POLICY_EXACT_LEN() in nl80211 policy
 - protect against eg. DS param IE in S1G
 - remove bss->s1g tracking
 - clean up ugly check for S1G BSS
 - fix ieee80211_encode_usf() return type (thanks kbot)

Thomas Pedersen (17):
  {cfg,mac}80211: get correct default channel width for S1G
  mac80211: s1g: choose scanning width based on frequency
  nl80211: support S1G capabilities
  mac80211: support S1G STA capabilities
  cfg80211: convert S1G beacon to scan results
  cfg80211: parse S1G Operation element for BSS channel
  mac80211: convert S1G beacon to scan results
  cfg80211: handle Association Response from S1G STA
  mac80211: encode listen interval for S1G
  mac80211: don't calculate duration for S1G
  mac80211: handle S1G low rates
  mac80211: avoid rate init for S1G band
  mac80211: receive and process S1G beacons
  mac80211: support S1G association
  nl80211: include frequency offset in survey info
  mac80211_hwsim: fix TSF timestamp write to S1G beacon
  mac80211_hwsim: indicate support for S1G

 drivers/net/wireless/mac80211_hwsim.c |  98 +++++++++++--
 include/linux/ieee80211.h             |  67 +++++++++
 include/net/cfg80211.h                |   3 +
 include/net/mac80211.h                |   4 +
 include/uapi/linux/nl80211.h          |  11 ++
 net/mac80211/cfg.c                    |   2 +
 net/mac80211/chan.c                   |   9 +-
 net/mac80211/ibss.c                   |   3 +-
 net/mac80211/ieee80211_i.h            |  16 +++
 net/mac80211/iface.c                  |   5 +
 net/mac80211/mlme.c                   | 180 ++++++++++++++++++-----
 net/mac80211/rate.c                   |  39 ++++-
 net/mac80211/rx.c                     |  87 +++++-------
 net/mac80211/scan.c                   |  34 ++++-
 net/mac80211/tx.c                     |   4 +
 net/mac80211/util.c                   | 196 ++++++++++++++++++++++++++
 net/wireless/mlme.c                   |  14 +-
 net/wireless/nl80211.c                |  22 +++
 net/wireless/scan.c                   |  85 +++++++++--
 19 files changed, 756 insertions(+), 123 deletions(-)

-- 
2.20.1

