Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719B77A8BB4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjITS1G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjITS1F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:27:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D4123
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234406; x=1726770406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9A8ncsHTZr8uFdkqGZbGKrqo31vxEdNqJv6vyPQiGkk=;
  b=OaLfP/3/jCq1n1OiLFEtNDSpA6owBrso7DOaR+5ShEQdTDy4zlDu66Xp
   0nlyO8hZHtebSVV3LqlgeYGNzomyjtje9LQGdykKf4sR2uEZCMyiuQzjX
   2elVFIWzNpV31ATCIl6CaBfYgPagprp7TOYbDzFTI1JqyhZPH67ojkPi4
   v8a6iSqhkx3HkSwCHkDe9N6kzEtkCeQnL2SMYdsKtnjOu5SYLSvyER6CO
   fIqXSSbNpgbiwkMMvnLaAQ82lwB90168+CGhFNE/UoL9mr25AX/6kb/sf
   O7I16usPRMcFFUPAn57Lx71VtsYNqucbUd+j/vbeZ1rwhUY7RFjyzcTih
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556431"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556431"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424264"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424264"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:41 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 13/18] wifi: mac80211: add support for parsing TID to Link mapping element
Date:   Wed, 20 Sep 2023 21:25:24 +0300
Message-Id: <20230920211508.9ea9b0b4412a.I2281ab2c70e8b43a39032dc115db6a80f1f0b3f4@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920182529.659973-1-gregory.greenman@intel.com>
References: <20230920182529.659973-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Beker <ayala.beker@intel.com>

Add the relevant definitions for TID to Link mapping element
according to the P802.11be_D4.0.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h  | 58 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  3 ++
 net/mac80211/util.c        |  8 ++++++
 3 files changed, 69 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index f11b7022d9eb..f2965ff3d7c1 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1246,6 +1246,30 @@ struct ieee80211_twt_setup {
 	u8 params[];
 } __packed;
 
+#define IEEE80211_TTLM_MAX_CNT				2
+#define IEEE80211_TTLM_CONTROL_DIRECTION		0x03
+#define IEEE80211_TTLM_CONTROL_DEF_LINK_MAP		0x04
+#define IEEE80211_TTLM_CONTROL_SWITCH_TIME_PRESENT	0x08
+#define IEEE80211_TTLM_CONTROL_EXPECTED_DUR_PRESENT	0x10
+#define IEEE80211_TTLM_CONTROL_LINK_MAP_SIZE		0x20
+
+#define IEEE80211_TTLM_DIRECTION_DOWN		0
+#define IEEE80211_TTLM_DIRECTION_UP		1
+#define IEEE80211_TTLM_DIRECTION_BOTH		2
+
+/**
+ * struct ieee80211_ttlm_elem - TID-To-Link Mapping element
+ *
+ * Defined in section 9.4.2.314 in P802.11be_D4
+ *
+ * @control: the first part of control field
+ * @optional: the second part of control field
+ */
+struct ieee80211_ttlm_elem {
+	u8 control;
+	u8 optional[];
+} __packed;
+
 struct ieee80211_mgmt {
 	__le16 frame_control;
 	__le16 duration;
@@ -3618,6 +3642,7 @@ enum ieee80211_eid_ext {
 	WLAN_EID_EXT_EHT_OPERATION = 106,
 	WLAN_EID_EXT_EHT_MULTI_LINK = 107,
 	WLAN_EID_EXT_EHT_CAPABILITY = 108,
+	WLAN_EID_EXT_TID_TO_LINK_MAPPING = 109,
 	WLAN_EID_EXT_BANDWIDTH_INDICATION = 135,
 };
 
@@ -5155,6 +5180,39 @@ static inline bool ieee80211_mle_reconf_sta_prof_size_ok(const u8 *data,
 	       fixed + prof->sta_info_len - 1 <= len;
 }
 
+static inline bool ieee80211_tid_to_link_map_size_ok(const u8 *data, size_t len)
+{
+	const struct ieee80211_ttlm_elem *t2l = (const void *)data;
+	u8 control, fixed = sizeof(*t2l), elem_len = 0;
+
+	if (len < fixed)
+		return false;
+
+	control = t2l->control;
+
+	if (control & IEEE80211_TTLM_CONTROL_SWITCH_TIME_PRESENT)
+		elem_len += 2;
+	if (control & IEEE80211_TTLM_CONTROL_EXPECTED_DUR_PRESENT)
+		elem_len += 3;
+
+	if (!(control & IEEE80211_TTLM_CONTROL_DEF_LINK_MAP)) {
+		u8 bm_size;
+
+		elem_len += 1;
+		if (len < fixed + elem_len)
+			return false;
+
+		if (control & IEEE80211_TTLM_CONTROL_LINK_MAP_SIZE)
+			bm_size = 1;
+		else
+			bm_size = 2;
+
+		elem_len += hweight8(t2l->optional[0]) * bm_size;
+	}
+
+	return len >= fixed + elem_len;
+}
+
 #define for_each_mle_subelement(_elem, _data, _len)			\
 	if (ieee80211_mle_size_ok(_data, _len))				\
 		for_each_element(_elem,					\
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 6c56ec42dde9..3209c7c11207 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1678,6 +1678,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_multi_link_elem *ml_basic;
 	const struct ieee80211_multi_link_elem *ml_reconf;
 	const struct ieee80211_bandwidth_indication *bandwidth_indication;
+	const struct ieee80211_ttlm_elem *ttlm[IEEE80211_TTLM_MAX_CNT];
 
 	/* length of them, respectively */
 	u8 ext_capab_len;
@@ -1711,6 +1712,8 @@ struct ieee802_11_elems {
 	/* The reconfiguration Multi-Link element in the original IEs */
 	const struct element *ml_reconf_elem;
 
+	u8 ttlm_num;
+
 	/*
 	 * store the per station profile pointer and length in case that the
 	 * parsing also handled Multi-Link element parsing for a specific link
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 97c5823da0eb..98a3bffc6991 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -995,6 +995,14 @@ ieee80211_parse_extension_element(u32 *crc,
 			elems->bandwidth_indication = data;
 		calc_crc = true;
 		break;
+	case WLAN_EID_EXT_TID_TO_LINK_MAPPING:
+		calc_crc = true;
+		if (ieee80211_tid_to_link_map_size_ok(data, len) &&
+		    elems->ttlm_num < ARRAY_SIZE(elems->ttlm)) {
+			elems->ttlm[elems->ttlm_num] = (void *)data;
+			elems->ttlm_num++;
+		}
+		break;
 	}
 
 	if (crc && calc_crc)
-- 
2.38.1

