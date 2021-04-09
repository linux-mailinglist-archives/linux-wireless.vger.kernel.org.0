Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3F359970
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 11:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhDIJkq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 05:40:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44220 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230181AbhDIJkp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 05:40:45 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUncq-000ELR-N2; Fri, 09 Apr 2021 12:40:30 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  9 Apr 2021 12:40:13 +0300
Message-Id: <20210409094028.356611-1-luca@coelho.fi>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 00/15] cfg80211/mac80211 patches from our internal tree 2021-04-09
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

A bunch of patches with mac80211 and cfg80211 changes from our
internal tree.

As we discussed, a couple of these break ath11k compilation, but since
you're the original author, it's easier (at least for me :P) if you
fix them before applying.

Please review, though you have already reviewed (or even written!)
most if not all of them. ;)

Thanks!

Cheers,
Luca.


Avraham Stern (2):
  nl80211/cfg80211: add a flag to negotiate for LMR feedback in NDP
    ranging
  ieee80211: add the values of ranging parameters max LTF total field

Emmanuel Grumbach (5):
  mac80211: properly drop the connection in case of invalid CSA IE
  cfg80211: don't WARN if a self-managed device doesn't have a regdom
  mac80211: make ieee80211_vif_to_wdev work when the vif isn't in the
    driver
  cfg80211: allow to specifying a reason for hw_rfkill
  mac80211: clear the beacon's CRC after channel switch

Ilan Peer (2):
  nl80211: Add new RSNXE related nl80211 extended features
  cfg80211: Remove wrong RNR IE validation check

Johannes Berg (5):
  wireless: align some HE capabilities with the spec
  wireless: align HE capabilities A-MPDU Length Exponent Extension
  mac80211: bail out if cipher schemes are invalid
  wireless: fix spelling of A-MSDU in HE capabilities
  mac80211: aes_cmac: check crypto_shash_setkey() return value

Naftali Goldstein (1):
  mac80211: drop the connection if firmware crashed while in CSA

 backport-include/net/cfg80211.h               | 17 +++++++++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 12 +++---
 drivers/net/wireless/mac80211_hwsim.c         | 16 ++++----
 include/linux/ieee80211.h                     | 33 ++++++++++-------
 include/net/cfg80211.h                        | 16 +++++++-
 include/net/mac80211.h                        |  5 +--
 include/uapi/linux/nl80211.h                  | 17 +++++++++
 net/mac80211/aes_cmac.c                       | 11 +++++-
 net/mac80211/debugfs_sta.c                    | 37 ++++++++++---------
 net/mac80211/ieee80211_i.h                    |  2 +
 net/mac80211/main.c                           | 16 ++++++--
 net/mac80211/mlme.c                           | 16 ++++----
 net/mac80211/util.c                           | 10 +----
 net/wireless/core.c                           |  7 ++--
 net/wireless/nl80211.c                        |  5 ++-
 net/wireless/pmsr.c                           | 12 +++++-
 net/wireless/scan.c                           |  2 +-
 17 files changed, 154 insertions(+), 80 deletions(-)
 create mode 100644 backport-include/net/cfg80211.h

-- 
2.31.0

