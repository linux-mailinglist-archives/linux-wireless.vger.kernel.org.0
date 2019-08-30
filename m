Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F18A359B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 13:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfH3LY7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 07:24:59 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39416 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727410AbfH3LY7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 07:24:59 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i3f1U-0001lc-8x; Fri, 30 Aug 2019 14:24:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:24:43 +0300
Message-Id: <20190830112451.21655-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 0/8] cfg80211/mac80211 patches from our internal tree 2019-08-30
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Some patches with mac80211 and cfg80211 changes from our internal
tree.

Please review, though you have already reviewed most if not all of
them ;)

Cheers,
Luca.


Ilan Peer (1):
  mac80211: Allow user space to register for station Rx authentication

Johannes Berg (4):
  cfg80211: always shut down on HW rfkill
  mac80211: list features in WEP/TKIP disable in better order
  mac80211: remove unnecessary key condition
  mac80211: IBSS: send deauth when expiring inactive STAs

Lior Cohen (1):
  mac80211: clear crypto tx tailroom counter upon keys enable

Luca Coelho (1):
  mac80211: don't check if key is NULL in ieee80211_key_link()

Mordechay Goodstein (1):
  mac80211: vht: add support VHT EXT NSS BW in parsing VHT

 net/mac80211/ibss.c        |  8 +++++++
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/key.c         | 48 +++++++++++++-------------------------
 net/mac80211/key.h         |  4 ++--
 net/mac80211/main.c        | 13 +++++++++++
 net/mac80211/mlme.c        | 13 ++++++-----
 net/mac80211/util.c        | 11 ++++-----
 net/mac80211/vht.c         | 10 +++++++-
 net/wireless/core.c        | 13 ++++++-----
 net/wireless/core.h        |  2 +-
 net/wireless/wext-compat.c |  5 ++--
 11 files changed, 72 insertions(+), 58 deletions(-)

-- 
2.23.0.rc1

