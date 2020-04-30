Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B311BED65
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 03:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgD3BGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 21:06:47 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:58322 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726284AbgD3BGr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 21:06:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 519C04F80D3;
        Thu, 30 Apr 2020 01:06:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wL8PKa6uTtyk; Thu, 30 Apr 2020 01:06:43 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 61BFC4F800E;
        Thu, 30 Apr 2020 01:06:43 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 0/5] initial S1G defines
Date:   Wed, 29 Apr 2020 18:06:37 -0700
Message-Id: <20200430010642.22552-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset finishes the work to make channels work on a KHz offset,
and includes the initial definitions for S1G (802.11ah).

These patches on top of wt-2020-04-29 with hostap c54a5e96b505 gives the
following hwsim test results:

Failed even on retry:
proxyarp_open_ebtables wpas_config_file fst_dynamic_iface_attach
TOTAL=3531 PASS=3265 FAIL=12 SKIP=251

Which is what we currently expect of HEAD.

Changes from v3 are rebasing on latest wireless-testing and making the
SCAN_FREQ_KHZ more robust so userspace can omit the MHZ-only scan
frequencies in the request, and kernel can do the same in the results.

Also some breakage introduced by patch #1 has been addressed by leaving
the existing cfg80211 API intact.

Thomas Pedersen (5):
  cfg80211: add KHz variants of frame RX API
  nl80211: add KHz frequency offset for most wifi commands
  nl80211: support scan frequencies in KHz
  ieee80211: S1G defines
  nl80211: S1G band and channel definitions

 include/linux/ieee80211.h    | 222 +++++++++++++++++++++++++++++++++++
 include/net/cfg80211.h       |  71 ++++++++++-
 include/uapi/linux/nl80211.h |  77 +++++++++---
 net/mac80211/chan.c          |   7 +-
 net/mac80211/main.c          |   2 +
 net/mac80211/rx.c            |   8 +-
 net/mac80211/scan.c          |   1 +
 net/mac80211/tx.c            |   5 +
 net/mac80211/util.c          |   5 +
 net/wireless/chan.c          |  29 +++++
 net/wireless/core.c          |   5 +-
 net/wireless/mlme.c          |   8 +-
 net/wireless/nl80211.c       | 135 +++++++++++++++------
 net/wireless/trace.h         |  12 +-
 net/wireless/util.c          |   8 ++
 15 files changed, 521 insertions(+), 74 deletions(-)

-- 
2.20.1

