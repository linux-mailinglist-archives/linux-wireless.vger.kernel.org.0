Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08692D04FE
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 13:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgLFMz4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 07:55:56 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34890 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727931AbgLFMzj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 07:55:39 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kltYx-003AHZ-Hu; Sun, 06 Dec 2020 14:54:52 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 14:54:39 +0200
Message-Id: <20201206125450.564941-1-luca@coelho.fi>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/11] cfg80211/mac80211 patches from our internal tree 2020-12-06
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

A bunch of patches with mac80211 and cfg80211 changes from our
internal tree.

Please review, though you have already reviewed (or even written!)
most if not all of them. ;)

Cheers,
Luca.


Avraham Stern (1):
  mac80211: support Rx timestamp calculation for all preamble types

Emmanuel Grumbach (1):
  mac80211: don't filter out beacons once we start CSA

Ilan Peer (2):
  mac80211: Fix calculation of minimal channel width
  mac80211: Update rate control on channel change

Johannes Berg (7):
  cfg80211: remove struct ieee80211_he_bss_color
  mac80211: use struct assignment for he_obss_pd
  cfg80211: support immediate reconnect request hint
  mac80211: support driver-based disconnect with reconnect hint
  mac80211: don't set set TDLS STA bandwidth wider than possible
  mac80211: use bitfield helpers for BA session action frames
  mac80211: ignore country element TX power on 6 GHz

 include/net/cfg80211.h       | 17 ++------
 include/net/mac80211.h       | 11 +++++
 include/uapi/linux/nl80211.h |  6 +++
 net/mac80211/agg-rx.c        |  8 ++--
 net/mac80211/agg-tx.c        | 12 +++---
 net/mac80211/cfg.c           |  6 +--
 net/mac80211/chan.c          | 71 ++++++++++++++++++++++++++++--
 net/mac80211/ieee80211_i.h   | 14 +++---
 net/mac80211/mlme.c          | 83 +++++++++++++++++++++++++++---------
 net/mac80211/trace.h         | 23 +++++++++-
 net/mac80211/util.c          | 66 +++++++++++++++++++++++++++-
 net/mac80211/vht.c           | 14 ++++--
 net/wireless/mlme.c          | 26 ++++++-----
 net/wireless/nl80211.c       | 23 ++++++----
 net/wireless/nl80211.h       |  8 ++--
 net/wireless/trace.h         | 12 ++++--
 16 files changed, 307 insertions(+), 93 deletions(-)

-- 
2.29.2

