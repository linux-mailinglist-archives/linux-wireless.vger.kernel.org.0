Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D686CD285
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjC2HG4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2HGx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:06:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EAD30D5
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073580; x=1711609580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ryAbSO5n1GMrekzu00T55iS6/zR/2TMT9O4jYq36zr0=;
  b=kOGDBd6PyS7WsZ3bXr60z/HVPcFzbQgV1gFmu03GewvooS3Oh+stFIQu
   NOmNYg+NGrdEMRodomQ7mKZJaF3mFMGJW1Y9E28dqTzQbCwc5Alw7FzO9
   0Po/Mo0WR8Fbty8aOVFGZMAUs4jiEuM+161FYjoeXKhiyj5KAv6gF46xg
   teFcXVr9GV7oS+TSodd7j+pEArt3bv5JdTHEwY5hIdYLFV4ZHlbcOWIBG
   BtIXkdYeJgLY9PwhKEdpUULHZDezG8Vz20bi9ABzzZLYd/Tdi9VwvfqF3
   VaXMfQxaiyLiurevpixZ6K9M4wqOYYlOyzyT/JpwH3X9WTP8Hn/9/aKOG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450734"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450734"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111194"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111194"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:02 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/34] wifi: iwlwifi: mvm: rs-fw: don't crash on missing channel
Date:   Wed, 29 Mar 2023 10:05:11 +0300
Message-Id: <20230329100039.2b0d31bdb60b.I39d23c76eec16ac49f6ae3a6d5f7652041bde855@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is more of a workaround, with MLO we can get here with
the deflink not assigned. It's not critical right now that
we have this right, so WARN_ON_ONCE() and don't crash until
we can fix this area of the code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 778c9237fe87..ed4200d9bd04 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -506,6 +506,9 @@ u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
 
+	if (WARN_ON_ONCE(!mvmsta->vif->bss_conf.chandef.chan))
+		return IEEE80211_MAX_MPDU_LEN_VHT_3895;
+
 	if (mvmsta->vif->bss_conf.chandef.chan->band == NL80211_BAND_6GHZ) {
 		switch (le16_get_bits(sta->deflink.he_6ghz_capa.capa,
 				      IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN)) {
-- 
2.38.1

