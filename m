Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E663E3AC903
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhFRKoN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:44:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48114 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233540AbhFRKoM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:44:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBwj-001YXx-3C; Fri, 18 Jun 2021 13:42:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:25 +0300
Message-Id: <20210618104156.747775-1-luca@coelho.fi>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 00/31] cfg80211/mac80211 patches from our internal tree 2021-06-18
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

A bunch of patches with mac80211 and cfg80211 changes from our
internal tree.

Please review, though you have already reviewed (or even written!)
most if not all of them. ;)

Thanks!

Cheers,


Avraham Stern (2):
  cfg80211: avoid double free of PMSR request
  nl80211/cfg80211: add BSS color to NDP ranging parameters

Ilan Peer (3):
  mac80211: Properly WARN on HW scan before restart
  cfg80211: Support hidden AP discovery over 6GHz band
  mac8021: Allow probe request injection on passive non radar channels

Johannes Berg (19):
  cfg80211: make certificate generation more robust
  mac80211: allow SMPS requests only in client mode
  mac80211: free skb in WEP error case
  ieee80211: add defines for HE PHY cap byte 10
  cfg80211: add cfg80211_any_usable_channels()
  mac80211: conditionally advertise HE in probe requests
  mac80211: always include HE 6GHz capability in probe request
  mac80211: always include HE 6GHz capability in assoc request
  mac80211: rearrange struct txq_info for fewer holes
  mac80211: handle various extensible elements correctly
  mac80211: improve AP disconnect message
  cfg80211: trace more information in assoc trace event
  mac80211: reset profile_periodicity/ema_ap
  mac80211: remove use of ieee80211_get_he_sta_cap()
  cfg80211: remove ieee80211_get_he_sta_cap()
  cfg80211: allow advertising vendor-specific capabilities
  mac80211: add vendor-specific capabilities to assoc request
  mac80211: notify driver on mgd TX completion
  cfg80211: reg: improve bad regulatory warning

Krishnanand Prabhu (1):
  ieee80211: define timing measurement in extended capabilities IE

Miri Korenblit (1):
  cfg80211: set custom regdomain after wiphy registration

Mordechay Goodstein (1):
  mac80211: handle rate control (RC) racing with chanctx definition

Shaul Triebitz (4):
  mac80211: add HE 6GHz cap IE in 6GHz band only
  mac80211: do not add twice the HE 6GHz cap IE
  mac80211: move SMPS mode setting after ieee80211_prep_connection
  mac80211: add to bss_conf if broadcast TWT is supported

 drivers/net/wireless/ath/ath9k/main.c         |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   6 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |   2 +-
 include/linux/ieee80211.h                     |   9 +-
 include/net/cfg80211.h                        |  38 ++-
 include/net/mac80211.h                        |  32 ++-
 include/uapi/linux/nl80211.h                  |   9 +-
 net/mac80211/chan.c                           | 108 +++++---
 net/mac80211/driver-ops.h                     |  26 +-
 net/mac80211/he.c                             |   5 +-
 net/mac80211/ht.c                             |  18 +-
 net/mac80211/ieee80211_i.h                    |   9 +-
 net/mac80211/main.c                           |  16 +-
 net/mac80211/mlme.c                           | 240 +++++++++---------
 net/mac80211/trace.h                          |  33 ++-
 net/mac80211/tx.c                             |  27 +-
 net/mac80211/util.c                           |  59 +++--
 net/wireless/Makefile                         |   2 +-
 net/wireless/chan.c                           |  33 ++-
 net/wireless/core.c                           |   8 +-
 net/wireless/nl80211.c                        |   5 +
 net/wireless/pmsr.c                           |  28 +-
 net/wireless/rdev-ops.h                       |  12 +-
 net/wireless/reg.c                            |   5 +-
 net/wireless/scan.c                           |  16 +-
 net/wireless/trace.h                          |  36 ++-
 26 files changed, 528 insertions(+), 256 deletions(-)

-- 
2.32.0

