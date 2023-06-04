Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAFC7215B8
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjFDJMA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjFDJL6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:11:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBF3E3
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869917; x=1717405917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UtiKfALdwL26rTrCrAFSEV1TF56KhOcEbmoI8kUW3Fw=;
  b=nbh3XYozBzCoDBmA+R/o2MeFTfKrdsgu4W+Iut5Roo8UoSvoOKjkcT7I
   HwxFyaMTxZMlqgL/QFWCEXUdv/dHf/6F2K4XWPiXhHWh8thUUC40HKTzc
   6Y9YBa1FjqezohfeID4+MTh9xpxtzSVGg7bQGNW8htRBvu2eqNXHrAN2o
   phtQkXe6+yqEfVNxtTWw8bUW4ulZjPFevPwy/KAJWvKzG/ZKwWS5E+LZS
   PjG81g4CZ6gfSWMdQwm6P4tsEV04PtrWAOZAYkaBKRXNRvt2bzImxjSG+
   dgfFfzNhdnUtH28R12yp73ftD6nFTyFBHs4dtW3DqABWh5FUQS55cP74o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526501"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526501"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804481"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804481"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/16] wifi: mac80211: provide a helper to fetch the medium synchronization delay
Date:   Sun,  4 Jun 2023 12:11:17 +0300
Message-Id: <20230604120651.b1043f3126e2.Iad3806f8bf8df07f52ef0a02cc3d0373c44a8c93@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230604091128.609335-1-gregory.greenman@intel.com>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

There are drivers which need this information.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 35 +++++++++++++++++++++++++++++++++++
 include/net/mac80211.h    |  3 +++
 net/mac80211/mlme.c       |  5 ++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index fba4c44da832..516cd32d6196 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4635,6 +4635,41 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
 	return sizeof(*mle) + common + mle->variable[0];
 }
 
+/**
+ * ieee80211_mle_get_eml_sync_delay - returns the medium sync delay
+ * @data: pointer to the multi link EHT IE
+ *
+ * The element is assumed to be big enough. This must be checked by
+ * ieee80211_mle_size_ok().
+ * If the medium synchronization can't be found (the type is not basic, or
+ * the medium sync presence bit is clear), 0 will be returned.
+ */
+static inline u16 ieee80211_mle_get_eml_med_sync_delay(const u8 *data)
+{
+	const struct ieee80211_multi_link_elem *mle = (const void *)data;
+	u16 control = le16_to_cpu(mle->control);
+	const u8 *common = mle->variable;
+
+	if (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE) !=
+	    IEEE80211_ML_CONTROL_TYPE_BASIC)
+		return 0;
+
+	/* common points now at the beginning of
+	 * ieee80211_mle_basic_common_info
+	 */
+	common += sizeof(struct ieee80211_mle_basic_common_info);
+
+	if (!(control & IEEE80211_MLC_BASIC_PRES_MED_SYNC_DELAY))
+		return 0;
+
+	if (control & IEEE80211_MLC_BASIC_PRES_LINK_ID)
+		common += 1;
+	if (control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT)
+		common += 1;
+
+	return get_unaligned_le16(common);
+}
+
 /**
  * ieee80211_mle_get_eml_cap - returns the EML capability
  * @data: pointer to the multi link EHT IE
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f75d941eece8..f4516c034da2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1791,6 +1791,8 @@ enum ieee80211_offload_flags {
  *	offchannel/dynamic_ps operations.
  * @aid: association ID number, valid only when @assoc is true
  * @eml_cap: EML capabilities as described in P802.11be_D2.2 Figure 9-1002k.
+ * @eml_med_sync_delay: Medium Synchronization delay as described in
+ *	P802.11be_D2.2 Figure 9-1002j.
  * @arp_addr_list: List of IPv4 addresses for hardware ARP filtering. The
  *	may filter ARP queries targeted for other addresses than listed here.
  *	The driver must allow ARP queries targeted for all address listed here
@@ -1814,6 +1816,7 @@ struct ieee80211_vif_cfg {
 	bool ps;
 	u16 aid;
 	u16 eml_cap;
+	u16 eml_med_sync_delay;
 
 	__be32 arp_addr_list[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
 	int arp_addr_cnt;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 97671734427c..a404448eb84e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4862,9 +4862,12 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		/* data + 1 / datalen - 1 since it's an extended element */
 		if (eht_ml_elem &&
 		    ieee80211_mle_size_ok(eht_ml_elem->data + 1,
-					  eht_ml_elem->datalen - 1))
+					  eht_ml_elem->datalen - 1)) {
 			sdata->vif.cfg.eml_cap =
 				ieee80211_mle_get_eml_cap(eht_ml_elem->data + 1);
+			sdata->vif.cfg.eml_med_sync_delay =
+				ieee80211_mle_get_eml_med_sync_delay(eht_ml_elem->data + 1);
+		}
 	}
 
 	/* Allow VHT if at least one channel on the sband supports 80 MHz */
-- 
2.38.1

