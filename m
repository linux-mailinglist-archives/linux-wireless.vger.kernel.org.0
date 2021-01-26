Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F1305C64
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 14:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313836AbhAZWrT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 17:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbhAZVTV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jan 2021 16:19:21 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ED0C061793;
        Tue, 26 Jan 2021 13:16:21 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l4VhE-00C3HE-A2; Tue, 26 Jan 2021 22:16:20 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Subject: pull-request: mac80211-next 2021-01-26
Date:   Tue, 26 Jan 2021 22:16:13 +0100
Message-Id: <20210126211614.76456-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

So here's a pretty big and invasive mac80211-next pull. It has now been
in linux-next for some time, and all the issues that had been reported by
people running that are fixed. I've also thrown hwsim and Intel-internal
tests at it. However, changing the locking is somewhat dangerous, so if I
consider it, I sort of expect some more fallout from that. I did sprinkle
lockdep assertions fairly liberally, so we'll see.

Please pull and let me know if there's any problem.

Thanks,
johannes



The following changes since commit 9e8789c85deee047c5753e22f725d5fc10682468:

  net: stmmac: dwmac-meson8b: fix the RX delay validation (2021-01-20 22:15:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git tags/mac80211-next-for-net-next-2021-01-26

for you to fetch changes up to a05829a7222e9d10c416dd2dbbf3929fe6646b89:

  cfg80211: avoid holding the RTNL when calling the driver (2021-01-26 11:55:50 +0100)

----------------------------------------------------------------
More updates:
 * many minstrel improvements, including removal of the old
   minstrel in favour of minstrel_ht
 * speed improvements on FQ
 * support for RX decapsulation (header conversion) offload
 * RTNL reduction: limit RTNL usage in the wireless stack
   mostly to where really needed (regulatory not yet) to
   reduce contention on it
 * various other small updates

----------------------------------------------------------------
Arend van Spriel (1):
      cfg80211: add VHT rate entries for MCS-10 and MCS-11

Felix Fietkau (13):
      net/fq_impl: bulk-free packets from a flow on overmemory
      net/fq_impl: drop get_default_func, move default flow to fq_tin
      net/fq_impl: do not maintain a backlog-sorted list of flows
      mac80211: add rx decapsulation offload support
      mac80211: minstrel_ht: clean up CCK code
      mac80211: minstrel_ht: add support for OFDM rates on non-HT clients
      mac80211: remove legacy minstrel rate control
      mac80211: minstrel_ht: remove old ewma based rate average code
      mac80211: minstrel_ht: improve ampdu length estimation
      mac80211: minstrel_ht: improve sample rate selection
      mac80211: minstrel_ht: fix max probability rate selection
      mac80211: minstrel_ht: increase stats update interval
      mac80211: minstrel_ht: fix rounding error in throughput calculation

Johannes Berg (2):
      cfg80211: change netdev registration/unregistration semantics
      cfg80211: avoid holding the RTNL when calling the driver

Lorenzo Bianconi (1):
      mac80211: introduce aql_enable node in debugfs

Max Chen (1):
      cfg80211: Add phyrate conversion support for extended MCS in 60GHz band

Philipp Borgers (1):
      mac80211: add LDPC encoding to ieee80211_parse_tx_radiotap

Ramon Fontes (1):
      mac80211_hwsim: add 6GHz channels

Wen Gong (2):
      mac80211: remove NSS number of 160MHz if not support 160MHz for HE
      mac80211: reduce peer HE MCS/NSS to own capabilities

 drivers/net/wireless/ath/ath11k/reg.c              |   4 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |   4 +-
 drivers/net/wireless/ath/ath6kl/core.c             |   2 +
 drivers/net/wireless/ath/ath6kl/init.c             |   2 +
 drivers/net/wireless/ath/wil6210/cfg80211.c        |   2 +
 drivers/net/wireless/ath/wil6210/netdev.c          |  11 +-
 drivers/net/wireless/ath/wil6210/pcie_bus.c        |   2 +
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |  24 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.h    |   6 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |   2 +-
 drivers/net/wireless/mac80211_hwsim.c              |  74 ++-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |  10 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |   7 +
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   2 +-
 drivers/net/wireless/microchip/wilc1000/mon.c      |   4 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |   2 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |   4 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c      |   5 +-
 drivers/net/wireless/virt_wifi.c                   |   8 +
 include/net/cfg80211.h                             | 146 ++++-
 include/net/fq.h                                   |  11 +-
 include/net/fq_impl.h                              | 171 ++++--
 include/net/mac80211.h                             |  26 +-
 net/mac80211/Makefile                              |   2 -
 net/mac80211/debugfs.c                             |  52 ++
 net/mac80211/debugfs_sta.c                         |   1 +
 net/mac80211/driver-ops.h                          |  16 +
 net/mac80211/he.c                                  |  92 +++
 net/mac80211/ieee80211_i.h                         |   3 +-
 net/mac80211/iface.c                               |  40 +-
 net/mac80211/key.c                                 |   4 +-
 net/mac80211/main.c                                |   5 +
 net/mac80211/pm.c                                  |   6 +-
 net/mac80211/rc80211_minstrel.c                    | 574 ------------------
 net/mac80211/rc80211_minstrel.h                    | 184 ------
 net/mac80211/rc80211_minstrel_debugfs.c            | 172 ------
 net/mac80211/rc80211_minstrel_ht.c                 | 560 ++++++++++++------
 net/mac80211/rc80211_minstrel_ht.h                 |  96 ++-
 net/mac80211/rc80211_minstrel_ht_debugfs.c         |  57 +-
 net/mac80211/rx.c                                  | 243 +++++---
 net/mac80211/sta_info.h                            |   2 +
 net/mac80211/tdls.c                                |   6 +-
 net/mac80211/trace.h                               |  18 +-
 net/mac80211/tx.c                                  |  33 +-
 net/mac80211/util.c                                |  14 +-
 net/mac80211/vht.c                                 |   9 +-
 net/wireless/chan.c                                |   5 +-
 net/wireless/core.c                                | 159 +++--
 net/wireless/core.h                                |   2 +-
 net/wireless/debugfs.c                             |   4 -
 net/wireless/ibss.c                                |   3 +-
 net/wireless/mlme.c                                |   6 +-
 net/wireless/nl80211.c                             | 657 +++++++++++----------
 net/wireless/reg.c                                 |  91 ++-
 net/wireless/reg.h                                 |   1 -
 net/wireless/scan.c                                |  35 +-
 net/wireless/sme.c                                 |   5 +-
 net/wireless/sysfs.c                               |   5 +
 net/wireless/util.c                                |  39 +-
 net/wireless/wext-compat.c                         | 271 ++++++---
 net/wireless/wext-sme.c                            |   4 +-
 64 files changed, 2097 insertions(+), 1926 deletions(-)
 delete mode 100644 net/mac80211/rc80211_minstrel.c
 delete mode 100644 net/mac80211/rc80211_minstrel.h
 delete mode 100644 net/mac80211/rc80211_minstrel_debugfs.c

