Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2C82C79B9
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgK2Pbr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:31:47 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33504 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726021AbgK2Pbq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:31:46 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfB-0035ld-AD; Sun, 29 Nov 2020 17:30:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:42 +0200
Message-Id: <20201129153055.1971298-1-luca@coelho.fi>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/13] cfg80211/mac80211 patches from our internal tree 2020-11-29
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


Avraham Stern (2):
  nl80211: always accept scan request with the duration set
  ieee80211: update reduced neighbor report TBTT info length

Ayala Beker (1):
  cfg80211: scan PSC channels in case of scan with wildcard SSID

Borwankar, Antara (1):
  mac80211: set sdata state once vif is up after restart

Ilan Peer (4):
  cfg80211: Parse SAE H2E only membership selector
  mac80211: Skip entries with SAE H2E only membership selector
  cfg80211: Update TSF and TSF BSSID for multi BSS
  cfg80211: Save the regulatory domain when setting custom regulatory

Johannes Berg (3):
  mac80211: support MIC error/replay detected counters driver update
  mac80211: disallow band-switch during CSA
  cfg80211: include block-tx flag in channel switch started event

Sara Sharon (1):
  cfg80211: initialize rekey_data

Shaul Triebitz (1):
  mac80211: he: remove non-bss-conf fields from bss_conf

 include/linux/ieee80211.h    | 10 +++++---
 include/net/cfg80211.h       |  6 +++--
 include/net/mac80211.h       | 22 ++++++++++++++--
 include/uapi/linux/nl80211.h |  3 ++-
 net/mac80211/cfg.c           |  2 +-
 net/mac80211/iface.c         |  2 ++
 net/mac80211/key.c           | 49 ++++++++++++++++++++++++++++++++++++
 net/mac80211/mlme.c          | 35 +++++++++++++++-----------
 net/wireless/nl80211.c       | 27 ++++++++++----------
 net/wireless/reg.c           |  8 ++++++
 net/wireless/scan.c          | 21 ++++++++--------
 11 files changed, 137 insertions(+), 48 deletions(-)

-- 
2.29.2

