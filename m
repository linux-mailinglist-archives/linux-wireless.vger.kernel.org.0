Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B1F1C0C01
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 04:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgEACON (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 22:14:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:13471 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgEACON (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 22:14:13 -0400
IronPort-SDR: jMybSF1qAszJz8/Mzy3UiVBLka5eoY/G2PLF6ZeV5iPHEfrJRmtGrLkofI3GISk6DbYnLkQU1u
 C9FR4Vu8dFMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 19:14:12 -0700
IronPort-SDR: IHjLTzvWcS+2lKlmaUjQaS9QoaReUo3arizOKTg5EWegzZanZxBcxO942I6ak5vmuAo53A419w
 J3XjtyLprHgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,338,1583222400"; 
   d="scan'208";a="303450652"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Apr 2020 19:14:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jULBq-0005tG-FI; Fri, 01 May 2020 10:14:10 +0800
Date:   Fri, 1 May 2020 10:14:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [RFC PATCH] ath11k: ath11k_mac_get_tx_mcs_map() can be static
Message-ID: <20200501021403.GA34224@2ec9c934b904>
References: <20200429145708.25992-3-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429145708.25992-3-john@phrozen.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Signed-off-by: kbuild test robot <lkp@intel.com>
---
 mac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ad05409783c05..c8acdc1e33353 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5285,7 +5285,7 @@ ath11k_mac_has_single_legacy_rate(struct ath11k *ar,
 	return num_rates == 1;
 }
 
-u16 ath11k_mac_get_tx_mcs_map(const struct ieee80211_sta_he_cap *he_cap)
+static u16 ath11k_mac_get_tx_mcs_map(const struct ieee80211_sta_he_cap *he_cap)
 {
 	if (he_cap->he_cap_elem.phy_cap_info[0] &
 	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
