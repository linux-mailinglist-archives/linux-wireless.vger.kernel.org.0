Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41CAE14EB7C
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgAaLNK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:13:10 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55760 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbgAaLNK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:13:10 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEU-0002GC-Ng; Fri, 31 Jan 2020 13:13:07 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:37 +0200
Message-Id: <20200131111300.891737-1-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 00/23] cfg80211/mac80211 patches from our internal tree 2020-01-31
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

A bunch of patches with mac80211 and cfg80211 changes from our
internal tree.

Please review, though you have already reviewed most if not all of
them ;)

Cheers,
Luca.


Andrei Otcheretianski (1):
  mac80211: Accept broadcast probe responses on 6GHz band

Avraham Stern (1):
  nl80211/cfg80211: add support for non EDCA based ranging measurement

Daniel Gabay (1):
  mac80211: update condition for HE disablement

Haim Dreyfuss (2):
  cfg80211: add no HE indication to the channel flag
  mac80211: check whether HE connection is allowed by the reg domain

Ilan Peer (3):
  cfg80211: Limit the registration for authentication frames
  mac80211: Handle SMPS mode changes only in AP mode
  mac80211: Remove support for changing AP SMPS mode

Johannes Berg (7):
  mac80211: simplify and improve HT/VHT/HE disable code
  mac80211: refactor extended element parsing
  mac80211: set station bandwidth from HE capability
  mac80211: remove some stray braces
  mac80211: allow changing TX-related netdev features
  mac80211: update conditions for supported channels element
  mac80211: consider more elements in parsing CRC

Luca Coelho (1):
  mac80211: make ieee80211_wep_init() return void

Sara Sharon (1):
  mac80211: fix quiet mode activation in action frames

Shaul Triebitz (5):
  nl80211: he: pass to driver the HE operation IE
  mac80211: he: set missing bss_conf fields in AP mode
  mac80211: parse also the RSNXE IE
  nl80211: add PROTECTED_TWT nl80211 extended feature
  mac80211: Properly set the SMPS mode for 6GHz station

Tova Mussai (1):
  mac80211: he: set rx nss

 include/linux/ieee80211.h     |   8 ++
 include/net/cfg80211.h        |  22 ++++-
 include/net/mac80211.h        |   2 +
 include/uapi/linux/nl80211.h  |  34 +++++++-
 net/mac80211/cfg.c            | 113 +++-----------------------
 net/mac80211/debugfs_netdev.c |  13 +--
 net/mac80211/he.c             |   4 +
 net/mac80211/ht.c             |  64 ++++++---------
 net/mac80211/ieee80211_i.h    |  16 ++--
 net/mac80211/iface.c          |  10 +--
 net/mac80211/main.c           |  16 ++--
 net/mac80211/mlme.c           | 146 ++++++++++++++++++++++------------
 net/mac80211/rx.c             |   6 +-
 net/mac80211/sta_info.c       |  16 +---
 net/mac80211/util.c           | 104 ++++++++++++++++--------
 net/mac80211/vht.c            |  58 +++++++++++++-
 net/mac80211/wep.c            |   4 +-
 net/mac80211/wep.h            |   2 +-
 net/wireless/core.c           |   6 ++
 net/wireless/core.h           |   2 +-
 net/wireless/mlme.c           |  33 +++++++-
 net/wireless/nl80211.c        |  21 ++++-
 net/wireless/pmsr.c           |  32 ++++++++
 net/wireless/reg.c            |   2 +
 24 files changed, 444 insertions(+), 290 deletions(-)

-- 
2.24.1

