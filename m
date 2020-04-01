Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5F19A53E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 08:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbgDAGVz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 02:21:55 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:36596 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731683AbgDAGVz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 02:21:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id B776B4F7A55;
        Wed,  1 Apr 2020 06:21:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Qn8VFzU8LwUh; Wed,  1 Apr 2020 06:21:51 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id B654E4E16C7;
        Wed,  1 Apr 2020 06:21:51 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [RFC 0/7] add a KHz component to wireless channels
Date:   Tue, 31 Mar 2020 23:21:43 -0700
Message-Id: <20200401062150.3324-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

This patchset prepares for adding 802.11ah (S1G) support.

S1G channels, at least in the US, may be centered on a sub-MHz
frequency. The current channel structures and nl80211 APIs expect
frequencies in units of MHz. To extend the existing functionality and
APIs while reducing churn and breakage, we add a KHz offset where
needed. This also has the advantage that the KHz offset can be ignored
at will (legacy drivers).

Some cfg80211 and nl80211 internals have been converted to handle units
of KHz, which is not unprecedented (net/wireless/reg.c), and the
collateral damage is localized.

One thing which is still unclear is backward compatibility in nl80211.
If a frequency offset is supplied to an older kernel, it'll just
silently fail to do the right thing. Likewise, these patches will accept
a frequency offset to eg.  NL80211_CMD_JOIN_MESH, but not handle it in
mac80211. For this case is it sufficient to return an error?

The hostap hwsim tests are still passing on par with HEAD. Before these
become PATCH we'd like to add some tests exercising the new nl80211
attributes, but it seems difficult without pulling in the full S1G
patchset. Maybe we'll hack up hwsim + regulatory to use the S1G band for
regular wifi tests. Suggestions here are welcome.

Thanks for looking.

Thomas Pedersen (7):
  ieee80211: share 802.11 unit conversion helpers
  cfg80211: express channels with a KHz component
  mac80211: handle channel frequency offset
  mac80211: add freq_offset to RX status
  cfg80211: report frequency in KHz for management RX
  nl80211: add KHz frequency offset for most wifi commands
  nl80211: accept scan frequencies in KHz

 drivers/net/wireless/ath/ath6kl/wmi.c         |  5 +-
 drivers/net/wireless/ath/wil6210/wmi.c        |  3 +-
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  6 +-
 drivers/net/wireless/marvell/mwifiex/util.c   |  3 +-
 drivers/staging/wilc1000/cfg80211.c           |  2 +-
 include/linux/ieee80211.h                     | 11 +++
 include/net/cfg80211.h                        | 70 ++++++++++++-
 include/net/mac80211.h                        | 10 +-
 include/net/regulatory.h                      |  7 --
 include/uapi/linux/nl80211.h                  | 51 +++++++---
 net/mac80211/chan.c                           |  1 +
 net/mac80211/main.c                           |  8 +-
 net/mac80211/mlme.c                           | 22 +++--
 net/mac80211/rx.c                             |  7 +-
 net/mac80211/scan.c                           |  4 +-
 net/mac80211/trace.h                          | 41 ++++++--
 net/wireless/chan.c                           | 68 +++++++------
 net/wireless/nl80211.c                        | 97 ++++++++++++++-----
 net/wireless/reg.c                            | 40 ++++----
 net/wireless/scan.c                           |  4 +-
 net/wireless/trace.h                          | 21 +++-
 net/wireless/util.c                           | 72 ++++++++++++--
 22 files changed, 406 insertions(+), 147 deletions(-)

-- 
2.20.1

