Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D19B73587D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjFSN1R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 09:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjFSN1Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 09:27:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41DC19C
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687181234; x=1718717234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lGcR2gtFxqv4iw3dQ9pRjCziO6D6FnDpBd0nAAa50OI=;
  b=ECRO8eiuhqvTOafHzgMn3AvYUVCh00lEm1aciUQCkWkTZCihr6H2yr14
   oM0UXbFsCaM5zK3HcSrPz9h1flGx90TrODOn0NVuvMBJEFVaroM0EcNcb
   esOR6K84fK3MwoeZ79GY/JijpS13ZTQRvV5CkjqaiuclDNaKORE5u4Tkr
   2PWFZg19vfvsWao9+QdNQGD9Ae3kHuP+L6U/NsSOAkZ8u6QeMllk2WUZb
   nanR6LsjSGZVEUHl+jwIAt7/FzRJbLZtSv1jLwWHLXUUdKdUYPSvvA9Fs
   2aEJ0qFw4ubN/xjkXiSlVXlF8TJZB4JAXLCM1Z7ORDUJD6M1UcHmdrhcl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339240670"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339240670"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="716871725"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="716871725"
Received: from aadawii-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.201.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:12 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 4/9] wifi: mac80211: store BSS param change count from assoc response
Date:   Mon, 19 Jun 2023 16:26:48 +0300
Message-Id: <20230619161906.1799c164e7e9.I8e2c1f5eec6eec3fab525ae2dead9f6f099a2427@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619132653.902084-1-gregory.greenman@intel.com>
References: <20230619132653.902084-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When receiving a multi-link association response, make sure to
track the BSS parameter change count for each link, including
the assoc link.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h  | 64 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mlme.c        | 16 +++++++++-
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index fa679613c562..15c4e12b6fc7 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4689,6 +4689,34 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
 	return sizeof(*mle) + common + mle->variable[0];
 }
 
+/**
+ * ieee80211_mle_get_bss_param_ch_cnt - returns the BSS parameter change count
+ * @mle: the basic multi link element
+ *
+ * The element is assumed to be of the correct type (BASIC) and big enough,
+ * this must be checked using ieee80211_mle_type_ok().
+ *
+ * If the BSS parameter change count value can't be found (the presence bit
+ * for it is clear), 0 will be returned.
+ */
+static inline u8
+ieee80211_mle_get_bss_param_ch_cnt(const struct ieee80211_multi_link_elem *mle)
+{
+	u16 control = le16_to_cpu(mle->control);
+	const u8 *common = mle->variable;
+
+	/* common points now at the beginning of ieee80211_mle_basic_common_info */
+	common += sizeof(struct ieee80211_mle_basic_common_info);
+
+	if (!(control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT))
+		return 0;
+
+	if (control & IEEE80211_MLC_BASIC_PRES_LINK_ID)
+		common += 1;
+
+	return *common;
+}
+
 /**
  * ieee80211_mle_get_eml_sync_delay - returns the medium sync delay
  * @data: pointer to the multi link EHT IE
@@ -4902,6 +4930,42 @@ static inline bool ieee80211_mle_basic_sta_prof_size_ok(const u8 *data,
 	       fixed + prof->sta_info_len <= len;
 }
 
+/**
+ * ieee80211_mle_basic_sta_prof_bss_param_ch_cnt - get per-STA profile BSS
+ *	parameter change count
+ * @prof: the per-STA profile, having been checked with
+ *	ieee80211_mle_basic_sta_prof_size_ok() for the correct length
+ *
+ * Return: The BSS parameter change count value if present, 0 otherwise.
+ */
+static inline u8
+ieee80211_mle_basic_sta_prof_bss_param_ch_cnt(const struct ieee80211_mle_per_sta_profile *prof)
+{
+	u16 control = le16_to_cpu(prof->control);
+	const u8 *pos = prof->variable;
+
+	if (!(control & IEEE80211_MLE_STA_CONTROL_BSS_PARAM_CHANGE_CNT_PRESENT))
+		return 0;
+
+	if (control & IEEE80211_MLE_STA_CONTROL_STA_MAC_ADDR_PRESENT)
+		pos += 6;
+	if (control & IEEE80211_MLE_STA_CONTROL_BEACON_INT_PRESENT)
+		pos += 2;
+	if (control & IEEE80211_MLE_STA_CONTROL_TSF_OFFS_PRESENT)
+		pos += 8;
+	if (control & IEEE80211_MLE_STA_CONTROL_DTIM_INFO_PRESENT)
+		pos += 2;
+	if (control & IEEE80211_MLE_STA_CONTROL_COMPLETE_PROFILE &&
+	    control & IEEE80211_MLE_STA_CONTROL_NSTR_BITMAP_SIZE) {
+		if (control & IEEE80211_MLE_STA_CONTROL_NSTR_BITMAP_SIZE)
+			pos += 2;
+		else
+			pos += 1;
+	}
+
+	return *pos;
+}
+
 #define IEEE80211_MLE_STA_RECONF_CONTROL_LINK_ID			0x000f
 #define IEEE80211_MLE_STA_RECONF_CONTROL_COMPLETE_PROFILE		0x0010
 #define IEEE80211_MLE_STA_RECONF_CONTROL_STA_MAC_ADDR_PRESENT		0x0020
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b5678f2d83f5..f9f145cdc773 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -951,6 +951,8 @@ struct ieee80211_link_data_managed {
 	int wmm_last_param_set;
 	int mu_edca_last_param_set;
 
+	u8 bss_param_ch_cnt;
+
 	struct cfg80211_bss *bss;
 };
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 13226349e80e..150393f5d37d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4016,6 +4016,8 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	const struct cfg80211_bss_ies *bss_ies = NULL;
 	struct ieee80211_supported_band *sband;
 	struct ieee802_11_elems *elems;
+	const __le16 prof_bss_param_ch_present =
+		cpu_to_le16(IEEE80211_MLE_STA_CONTROL_BSS_PARAM_CHANGE_CNT_PRESENT);
 	u16 capab_info;
 	bool ret;
 
@@ -4031,7 +4033,17 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		 * successful, so set the status directly to success
 		 */
 		assoc_data->link[link_id].status = WLAN_STATUS_SUCCESS;
-	} else if (!elems->prof) {
+		if (elems->ml_basic) {
+			if (!(elems->ml_basic->control &
+					cpu_to_le16(IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT))) {
+				ret = false;
+				goto out;
+			}
+			link->u.mgd.bss_param_ch_cnt =
+				ieee80211_mle_get_bss_param_ch_cnt(elems->ml_basic);
+		}
+	} else if (!elems->prof ||
+		   !(elems->prof->control & prof_bss_param_ch_present)) {
 		ret = false;
 		goto out;
 	} else {
@@ -4044,6 +4056,8 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		 */
 		capab_info = get_unaligned_le16(ptr);
 		assoc_data->link[link_id].status = get_unaligned_le16(ptr + 2);
+		link->u.mgd.bss_param_ch_cnt =
+			ieee80211_mle_basic_sta_prof_bss_param_ch_cnt(elems->prof);
 
 		if (assoc_data->link[link_id].status != WLAN_STATUS_SUCCESS) {
 			link_info(link, "association response status code=%u\n",
-- 
2.38.1

