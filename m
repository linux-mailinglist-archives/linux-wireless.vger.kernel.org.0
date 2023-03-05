Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949946AAF61
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCEMRH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEMRG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:06 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A1113502
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018625; x=1709554625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vwhGmk2WNDF3ObdXaS6YqUyUhjbjKpENFJzu17aZTuc=;
  b=Z94boR9n6cWSmC6Z0EUY09UkE2IGUnKmZgEila6/B1WGAz8NdPiyaWGj
   wFJ2x7ec1CdOpn/JIVY5cb+MFovQTkTx+W19rZIZJtUNrbQRLs+X1waOx
   u9lG7N7g6RFPYT24cRo869ebS86/SuQTDIdsN8zymWaZTkz/LmovhFaCQ
   K3M0T0B769ItMdzqYXlFUbDOlPQhAxwHO82mCxL0IGa2htbzmkgSZ5EYi
   WmH2u0cwWQ9vzCb7P94xGynHj7CXVOu67aGMlUdvELnjaDYn9V06Iv5he
   QGeqDMkAicyKqluMWMD1puSWFmWvlc5FD4geqJdkqfWgA6VoWvgHdX7nH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193179"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193179"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355042"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355042"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:03 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/21] wifi: iwlwifi: mvm: add an helper function for adding TLVs
Date:   Sun,  5 Mar 2023 14:16:19 +0200
Message-Id: <20230305124407.8ac5195bb3e6.I19ad99c1ad3108453aede64bddf6ef1a7c4a0b74@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230305121635.301451-1-gregory.greenman@intel.com>
References: <20230305121635.301451-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

This adds in with one function setting type-len, and zero out
TLV data part, and include adding padding in necessary.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 30 ++++++++++++-------
 drivers/net/wireless/mac80211_hwsim.c         | 14 ++++-----
 include/net/ieee80211_radiotap.h              | 20 +++++++++----
 3 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 2db4f68becff..48c79f665be8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -205,22 +205,33 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 	return 0;
 }
 
+/* put a TLV on the skb and return data pointer
+ *
+ * Also pad to 4 the len and zero out all data part
+ */
+static void *
+iwl_mvm_radiotap_put_tlv(struct sk_buff *skb, u16 type, u16 len)
+{
+	struct ieee80211_radiotap_tlv *tlv;
+
+	tlv = skb_put(skb, sizeof(*tlv));
+	tlv->type = cpu_to_le16(type);
+	tlv->len = cpu_to_le16(len);
+	return skb_put_zero(skb, ALIGN(len, 4));
+}
+
 static void iwl_mvm_add_rtap_sniffer_config(struct iwl_mvm *mvm,
 					    struct sk_buff *skb)
 {
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
-	struct ieee80211_radiotap_vendor_tlv *radiotap;
+	struct ieee80211_radiotap_vendor_content *radiotap;
 	const u16 vendor_data_len = sizeof(mvm->cur_aid);
-	const u16 padding = ALIGN(vendor_data_len, 4) - vendor_data_len;
 
 	if (!mvm->cur_aid)
 		return;
 
-	radiotap = skb_put(skb, sizeof(*radiotap) + vendor_data_len + padding);
-	radiotap->type = cpu_to_le16(IEEE80211_RADIOTAP_VENDOR_NAMESPACE);
-	radiotap->len = cpu_to_le16(sizeof(*radiotap) -
-				    sizeof(struct ieee80211_radiotap_tlv) +
-				    vendor_data_len);
+	radiotap = iwl_mvm_radiotap_put_tlv(skb, IEEE80211_RADIOTAP_VENDOR_NAMESPACE,
+					    sizeof(*radiotap) + vendor_data_len);
 
 	/* Intel OUI */
 	radiotap->oui[0] = 0xf6;
@@ -229,12 +240,9 @@ static void iwl_mvm_add_rtap_sniffer_config(struct iwl_mvm *mvm,
 	/* radiotap sniffer config sub-namespace */
 	radiotap->oui_subtype = 1;
 	radiotap->vendor_type = 0;
-	/* clear reserved field */
-	radiotap->reserved = 0;
+
 	/* fill the data now */
 	memcpy(radiotap->data, &mvm->cur_aid, sizeof(mvm->cur_aid));
-	/* and clear the padding */
-	memset(radiotap->data + vendor_data_len, 0, padding);
 
 	rx_status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
 }
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 152617034d19..f4bdc243ea0d 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1556,14 +1556,14 @@ static void mac80211_hwsim_add_vendor_rtap(struct sk_buff *skb)
 				sizeof(vendor_data));
 	rtap->type = cpu_to_le16(IEEE80211_RADIOTAP_VENDOR_NAMESPACE);
 
-	rtap->oui[0] = HWSIM_RADIOTAP_OUI[0];
-	rtap->oui[1] = HWSIM_RADIOTAP_OUI[1];
-	rtap->oui[2] = HWSIM_RADIOTAP_OUI[2];
-	rtap->oui_subtype = 127;
+	rtap->content.oui[0] = HWSIM_RADIOTAP_OUI[0];
+	rtap->content.oui[1] = HWSIM_RADIOTAP_OUI[1];
+	rtap->content.oui[2] = HWSIM_RADIOTAP_OUI[2];
+	rtap->content.oui_subtype = 127;
 	/* clear reserved field */
-	rtap->reserved = 0;
-	rtap->vendor_type = 0;
-	memcpy(rtap->data, vendor_data, sizeof(vendor_data));
+	rtap->content.reserved = 0;
+	rtap->content.vendor_type = 0;
+	memcpy(rtap->content.data, vendor_data, sizeof(vendor_data));
 
 	IEEE80211_SKB_RXCB(skb)->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
 #endif
diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 95436686d3fe..eaf673d292a8 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -370,18 +370,14 @@ struct ieee80211_radiotap_tlv {
 } __packed;
 
 /**
- * struct ieee80211_radiotap_vendor_tlv - vendor radiotap data information
- * @type: should always be set to IEEE80211_RADIOTAP_VENDOR_NAMESPACE
- * @len: length of data
+ * struct ieee80211_radiotap_vendor_content - vendor radiotap content information
  * @oui: radiotap vendor namespace OUI
  * @oui_subtype: radiotap vendor sub namespace
  * @vendor_type: radiotap vendor type
  * @reserved: should always be set to zero (to avoid leaking memory)
  * @data: the actual vendor namespace data
  */
-struct ieee80211_radiotap_vendor_tlv {
-	__le16 type; /* IEEE80211_RADIOTAP_VENDOR_NAMESPACE */
-	__le16 len;
+struct ieee80211_radiotap_vendor_content {
 	u8 oui[3];
 	u8 oui_subtype;
 	__le16 vendor_type;
@@ -389,6 +385,18 @@ struct ieee80211_radiotap_vendor_tlv {
 	u8 data[];
 } __packed;
 
+/**
+ * struct ieee80211_radiotap_vendor_tlv - vendor radiotap data information
+ * @type: should always be set to IEEE80211_RADIOTAP_VENDOR_NAMESPACE
+ * @len: length of data
+ * @content: vendor content see @ieee80211_radiotap_vendor_content
+ */
+struct ieee80211_radiotap_vendor_tlv {
+	__le16 type; /* IEEE80211_RADIOTAP_VENDOR_NAMESPACE */
+	__le16 len;
+	struct ieee80211_radiotap_vendor_content content;
+};
+
 /* ieee80211_radiotap_eht_usig - content of U-SIG tlv (type 33)
  * see www.radiotap.org/fields/U-SIG.html for details
  */
-- 
2.38.1

