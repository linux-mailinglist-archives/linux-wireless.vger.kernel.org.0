Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE320DEBD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 23:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbgF2U2j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 16:28:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:36329 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732500AbgF2TZX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:23 -0400
IronPort-SDR: jxIgeswT0RQcxiq5i90ukunWtKqg5ZGGIJuZgQDDsIPNsrh7OHZAPW5SAzB/8hrHrRI9ie4Icn
 MB1yn56ptvEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="143414451"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="143414451"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 03:03:31 -0700
IronPort-SDR: 4YqE72cLuVtXbqx2btrSflq7dheUQuyC8fcvBY4alz9zIVYF8Iws2pMmeRrszZZPHleRbd8uit
 b9cZgPpk5RBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="312995672"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2020 03:03:30 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpqdN-0000vY-O6; Mon, 29 Jun 2020 10:03:29 +0000
Date:   Mon, 29 Jun 2020 18:02:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>, ath10k@lists.infradead.org
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [RFC PATCH] ath10k: ath10k_mac_set_tid_config() can be static
Message-ID: <20200629100253.GA83675@930a38d91fed>
References: <1593363718-5148-4-git-send-email-tamizhr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593363718-5148-4-git-send-email-tamizhr@codeaurora.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 mac.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index b1a89c5869a01..8025c9115e3d6 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6861,9 +6861,9 @@ ath10k_mac_tid_bitrate_config(struct ath10k *ar,
 	return 0;
 }
 
-int ath10k_mac_set_tid_config(struct ath10k *ar, struct ieee80211_sta *sta,
-			      struct ieee80211_vif *vif, u32 changed,
-			      struct wmi_per_peer_per_tid_cfg_arg *arg)
+static int ath10k_mac_set_tid_config(struct ath10k *ar, struct ieee80211_sta *sta,
+				     struct ieee80211_vif *vif, u32 changed,
+				     struct wmi_per_peer_per_tid_cfg_arg *arg)
 {
 	struct ath10k_vif *arvif = (void *)vif->drv_priv;
 	struct ath10k_sta *arsta;
