Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD05319B9C5
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 03:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbgDBBSP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 21:18:15 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:46418 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732462AbgDBBSP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 21:18:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id A18A94F7AF9;
        Thu,  2 Apr 2020 01:18:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SQ7Tvw24nyhQ; Thu,  2 Apr 2020 01:18:11 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 6C6D14F7A30;
        Thu,  2 Apr 2020 01:18:11 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 0/9] initial support for S1G channels
Date:   Wed,  1 Apr 2020 18:18:01 -0700
Message-Id: <20200402011810.22947-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

See previous submission here: https://lore.kernel.org/linux-wireless/20200401062150.3324-1-thomas@adapt-ip.com/T/#t

This series includes the previous patches, address some comments from
Johannes, and add the definitions needed for drivers to declare support
for the new S1G (802.11ah) band.

For now no S1G MAC layer or regulatory changes are included.

With hostap HEAD (a3eda98c229b), this patchset still passes as well as
the current wireless-testing HEAD (af962cb402):

Failed even on retry:
proxyarp_open_ebtables wpas_config_file fst_dynamic_iface_attach
TOTAL=3508 PASS=3230 FAIL=13 SKIP=262

Thomas Pedersen (9):
  ieee80211: share 802.11 unit conversion helpers
  cfg80211: express channels with a KHz component
  mac80211: handle channel frequency offset
  mac80211: add freq_offset to RX status
  cfg80211: report frequency in KHz for management RX
  nl80211: add KHz frequency offset for most wifi commands
  nl80211: accept scan frequencies in KHz
  ieee80211: S1G defines
  nl80211: S1G band and channel definitions

 drivers/net/wireless/ath/ath6kl/wmi.c         |   5 +-
 drivers/net/wireless/ath/wil6210/wmi.c        |   3 +-
 .../broadcom/brcm80211/brcmfmac/p2p.c         |   6 +-
 drivers/net/wireless/marvell/mwifiex/util.c   |   3 +-
 drivers/staging/wilc1000/cfg80211.c           |   2 +-
 include/linux/ieee80211.h                     | 231 ++++++++++++++++++
 include/net/cfg80211.h                        | 113 ++++++++-
 include/net/mac80211.h                        |  10 +-
 include/net/regulatory.h                      |   7 -
 include/uapi/linux/nl80211.h                  |  67 +++--
 net/mac80211/cfg.c                            |   6 +
 net/mac80211/chan.c                           |   8 +-
 net/mac80211/ibss.c                           |   5 +
 net/mac80211/main.c                           |   8 +-
 net/mac80211/mlme.c                           |  22 +-
 net/mac80211/offchannel.c                     |   4 +
 net/mac80211/rx.c                             |   7 +-
 net/mac80211/scan.c                           |   5 +-
 net/mac80211/tdls.c                           |   4 +
 net/mac80211/trace.h                          |  41 +++-
 net/mac80211/tx.c                             |   1 +
 net/mac80211/util.c                           |   5 +
 net/wireless/chan.c                           |  97 +++++---
 net/wireless/core.c                           |   5 +-
 net/wireless/nl80211.c                        |  97 ++++++--
 net/wireless/reg.c                            |  40 +--
 net/wireless/scan.c                           |   4 +-
 net/wireless/trace.h                          |  21 +-
 net/wireless/util.c                           |  40 ++-
 29 files changed, 711 insertions(+), 156 deletions(-)

-- 
2.20.1

