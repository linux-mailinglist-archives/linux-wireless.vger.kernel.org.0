Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B0C7A4820
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbjIRLMs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241283AbjIRLMU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:12:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FC9FD
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035534; x=1726571534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h7L8l3DVL8SAidJyfMIyfoou06woHdwaQ+W7GI2J6+A=;
  b=HRQrLtllXJI+RvOB27m+/aMRB8bt/D03OlXakYoH7lUb3r5vuqOFC4SO
   NDSD+YupjHGag2jPkiR8LGBA8ECk441+7LJoD8GRdZBJ5+UgXLjt1SsNK
   jX63Gu+nNtzI8CUTV2LiROGt+jcKPHnbkldaJE/gRf6+So6pHkjrqbQ3P
   //EtsFZ4JnTlmyMKrLOt4Q55iZPJR4hxO2+fWnDOcDYW0z52PlVYKCLP6
   lBhbe3YsOud3SSpX32fVXmsH+vBRyHON4fzmZfX1bP3zzhf9nLNqXkBzM
   FCLiHXcIFTxlUu50CcuYNogUMnKiRk49+SRpPkH/8WvhCBVOTFb4HLgOV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535955"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535955"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025542"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025542"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:12 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/18] wifi: mac80211: support antenna control in injection
Date:   Mon, 18 Sep 2023 14:11:00 +0300
Message-Id: <20230918140607.9803b6d8dd83.I00ccb762a806ea62bc3d728fa3a0d29f4f285eeb@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918111103.435195-1-gregory.greenman@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Support antenna control for injection by parsing the antenna
radiotap field (which may be presented multiple times) and
telling the driver about the resulting antenna bitmap. Of
course there's no guarantee the driver will actually honour
this, just like any other injection control.

If misconfigured, i.e. the injected HT/VHT MCS needs more
chains than antennas are configured, the bitmap is reset to
zero, indicating no selection.

For now this is only set up for two anntenas so we keep more
free bits, but that can be trivially extended if any driver
implements support for it that can deal with hardware with
more antennas.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h |  2 ++
 include/net/mac80211.h    |  6 +++++-
 net/mac80211/tx.c         | 14 ++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 6e8913dbbff6..e344708c21da 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1698,6 +1698,8 @@ struct ieee80211_mcs_info {
 #define		IEEE80211_HT_MCS_TX_MAX_STREAMS	4
 #define IEEE80211_HT_MCS_TX_UNEQUAL_MODULATION	0x10
 
+#define IEEE80211_HT_MCS_CHAINS(mcs) ((mcs) == 32 ? 1 : (1 + ((mcs) >> 3)))
+
 /*
  * 802.11n D5.0 20.3.5 / 20.6 says:
  * - indices 0 to 7 and 32 are single spatial stream
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b3df8cb2919b..b67583ddae9c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1178,7 +1178,11 @@ struct ieee80211_tx_info {
 					u8 use_cts_prot:1;
 					u8 short_preamble:1;
 					u8 skip_table:1;
-					/* 2 bytes free */
+
+					/* for injection only (bitmap) */
+					u8 antennas:2;
+
+					/* 14 bits free */
 				};
 				/* only needed before rate control */
 				unsigned long jiffies;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 932516f8cc13..a984fc54644e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2162,6 +2162,11 @@ bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 			rate_found = true;
 			break;
 
+		case IEEE80211_RADIOTAP_ANTENNA:
+			/* this can appear multiple times, keep a bitmap */
+			info->control.antennas |= BIT(*iterator.this_arg);
+			break;
+
 		case IEEE80211_RADIOTAP_DATA_RETRIES:
 			rate_retries = *iterator.this_arg;
 			break;
@@ -2256,8 +2261,17 @@ bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 		}
 
 		if (rate_flags & IEEE80211_TX_RC_MCS) {
+			/* reset antennas if not enough */
+			if (IEEE80211_HT_MCS_CHAINS(rate) >
+					hweight8(info->control.antennas))
+				info->control.antennas = 0;
+
 			info->control.rates[0].idx = rate;
 		} else if (rate_flags & IEEE80211_TX_RC_VHT_MCS) {
+			/* reset antennas if not enough */
+			if (vht_nss > hweight8(info->control.antennas))
+				info->control.antennas = 0;
+
 			ieee80211_rate_set_vht(info->control.rates, vht_mcs,
 					       vht_nss);
 		} else if (sband) {
-- 
2.38.1

