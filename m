Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E358258309
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgHaU4I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 16:56:08 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52136 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725993AbgHaU4H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 16:56:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 304004F8D5A;
        Mon, 31 Aug 2020 20:56:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uwuO1UlXyi3S; Mon, 31 Aug 2020 20:56:03 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 18FD24EC91A;
        Mon, 31 Aug 2020 20:56:02 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 00/22] add support for S1G association
Date:   Mon, 31 Aug 2020 13:55:38 -0700
Message-Id: <20200831205600.21058-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is the initial S1G patchset which adds support for:

- defining the S1G 900MHz bands in a custom regulatory database
- setting and receiving S1G beacons (sending short beacons will be
  supported in a future patch)
- configuring S1G capabilities in Association Request (setting
  capabilities along with NL80211_CMD_SET_STATION will be added later).
- scanning on S1G bands
- handling S1G Association Response format
- correctly encoding Listen Interval for S1G
- associating in mac80211
- testing S1G in mac80211_hwsim

Rate control is still TBD, this patchset simply lops off the rate
control hooks for S1G so eg. missing sband->bitrates and S1G Basic Rate
set can't do too much damage.

Note the mac80211_hwsim S1G support introduces a regression in a few
hostap hwsim tests. This is because when processing the reported bands,
hostap assumes freq < 4000 is 11b, and the actual 11b/g band is
overwritten by the S1G band info. Though it does count as a userspace
regression, I'm not sure there is much to do about it besides apply a
small patch to hostapd which treats freq < 2000 as an unknown band.

After the hostap workaround
(https://lists.infradead.org/pipermail/hostap/2020-August/038748.html),
these patches continue to pass the hwsim tests as well as HEAD.


Thomas Pedersen (22):
  ieee80211: redefine S1G bits with GENMASK
  nl80211: advertise supported channel width in S1G
  cfg80211: regulatory: handle S1G channels
  nl80211: correctly validate S1G beacon head
  nl80211: support setting S1G channels
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
  mac80211_hwsim: indicate support for S1G
  mac80211_hwsim: fix TSF timestamp write to S1G beacon

 drivers/net/wireless/mac80211_hwsim.c |  92 +++++++++--
 include/linux/ieee80211.h             | 223 +++++++++++++++++---------
 include/net/cfg80211.h                |  28 ++++
 include/net/mac80211.h                |   3 +
 include/uapi/linux/nl80211.h          |  26 +++
 net/mac80211/cfg.c                    |   2 +
 net/mac80211/chan.c                   |   9 +-
 net/mac80211/ibss.c                   |   3 +-
 net/mac80211/ieee80211_i.h            |  20 +++
 net/mac80211/iface.c                  |   5 +
 net/mac80211/mlme.c                   | 184 +++++++++++++++++----
 net/mac80211/rate.c                   |  39 ++++-
 net/mac80211/rx.c                     |  87 +++++-----
 net/mac80211/scan.c                   |  37 ++++-
 net/mac80211/tx.c                     |   4 +
 net/mac80211/util.c                   | 200 +++++++++++++++++++++++
 net/wireless/chan.c                   | 140 ++++++++++------
 net/wireless/mlme.c                   |  20 +++
 net/wireless/nl80211.c                |  52 +++++-
 net/wireless/reg.c                    |  70 ++++++--
 net/wireless/scan.c                   |  80 +++++++--
 net/wireless/util.c                   |  32 ++++
 22 files changed, 1090 insertions(+), 266 deletions(-)

-- 
2.20.1

