Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE7DF7E0
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 00:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfJUWO5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Oct 2019 18:14:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:57768 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbfJUWO4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Oct 2019 18:14:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 15:14:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,325,1566889200"; 
   d="scan'208";a="209532870"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2019 15:14:54 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iMfwz-0003qt-Mn; Tue, 22 Oct 2019 06:14:53 +0800
Date:   Tue, 22 Oct 2019 06:14:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: [RFC PATCH] mac80211: ieee80211_calc_rx_airtime() can be static
Message-ID: <20191021221433.5nnny72acwx7lr4a@4978f4969bb8>
References: <157148503639.2989444.8337290298332344733.stgit@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157148503639.2989444.8337290298332344733.stgit@toke.dk>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Fixes: 427959c8f966 ("mac80211: Import airtime calculation code from mt76")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 airtime.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index c8d0cee613660..3f13640643e34 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -208,9 +208,9 @@ ieee80211_calc_legacy_rate_duration(const struct ieee80211_rate *rate,
 	return duration;
 }
 
-u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
-			      struct ieee80211_rx_status *status,
-			      int len)
+static u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
+				     struct ieee80211_rx_status *status,
+				     int len)
 {
 	struct ieee80211_supported_band *sband;
 	const struct ieee80211_rate *rate;
@@ -279,9 +279,9 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 	return duration;
 }
 
-u32 ieee80211_calc_tx_airtime_rate(struct ieee80211_hw *hw,
-				   struct ieee80211_tx_rate *rate,
-				   u8 band, int len)
+static u32 ieee80211_calc_tx_airtime_rate(struct ieee80211_hw *hw,
+					  struct ieee80211_tx_rate *rate,
+					  u8 band, int len)
 {
 	struct ieee80211_rx_status stat = {
 		.band = band,
