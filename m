Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096667A481E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbjIRLMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbjIRLMP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:12:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C722A8F
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035529; x=1726571529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iW4sdpQZ08Y+J8I3PXDtQxVAUyZgW8b1gqjJuaboe0w=;
  b=fsubGlsmB/QoM9Fh9+GTPamw70QJm27dT6Bfw8F9ofhUUZTjfFJMMHol
   Ekk8EdjETg3bpQBViFVjS72JY31ft/reUouEDBMQKXwcY2NmEXT15A5AZ
   wVO3mgomjuDwhFL3XOT+FNyKP8CS3HkJ8xxrRFE7bSTJ2fggQXF4P/apx
   5lPUX+Vma4+IamamqhWw6nbwCFyQU4qD4bDignJFclIe+yrr1ggsIGXrc
   bLpq1DWga/TvhPOLQ5ee2XqBN+cEQoWhtnS21MRAMw3LOEOj9k+QhBPg+
   Q0BZAXW1gC3OtCKb9Hyza5xv+Aq4MtwJnFRzDnwqwMwyB0CpdYrq2fMpd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535907"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535907"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025502"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025502"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:07 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/18] wifi: mac80211: add support for parsing TID to Link mapping element
Date:   Mon, 18 Sep 2023 14:10:58 +0300
Message-Id: <20230918140607.5398d9c5df2a.I2281ab2c70e8b43a39032dc115db6a80f1f0b3f4@changeid>
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

From: Ayala Beker <ayala.beker@intel.com>

Add the relevant definitions for TID to Link mapping element
according to the P802.11be_D3.0.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h  | 51 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/util.c        |  8 ++++++
 3 files changed, 62 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index f11b7022d9eb..6e8913dbbff6 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1246,6 +1246,23 @@ struct ieee80211_twt_setup {
 	u8 params[];
 } __packed;
 
+#define IEEE80211_T2L_MAP_MAX_CNT			2
+#define IEEE80211_T2L_MAP_CONTROL_DIRECTION		0x03
+#define IEEE80211_T2L_MAP_CONTROL_DEF_LINK_MAP		0x04
+#define IEEE80211_T2L_MAP_CONTROL_SWITCH_TIME_PRESENT	0x08
+#define IEEE80211_T2L_MAP_CONTROL_EXPECTED_DUR_PRESENT	0x10
+#define IEEE80211_T2L_MAP_CONTROL_LINK_MAP_SIZE		0x20
+
+#define IEEE80211_T2L_MAP_DIRECTION_DOWN		0
+#define IEEE80211_T2L_MAP_DIRECTION_UP			1
+#define IEEE80211_T2L_MAP_DIRECTION_BOTH		2
+
+struct ieee80211_t2l_map_elem {
+	/* the second part of control field is in optional[] */
+	u8 control;
+	u8 optional[];
+} __packed;
+
 struct ieee80211_mgmt {
 	__le16 frame_control;
 	__le16 duration;
@@ -3618,6 +3635,7 @@ enum ieee80211_eid_ext {
 	WLAN_EID_EXT_EHT_OPERATION = 106,
 	WLAN_EID_EXT_EHT_MULTI_LINK = 107,
 	WLAN_EID_EXT_EHT_CAPABILITY = 108,
+	WLAN_EID_EXT_TID_TO_LINK_MAPPING = 109,
 	WLAN_EID_EXT_BANDWIDTH_INDICATION = 135,
 };
 
@@ -5155,6 +5173,39 @@ static inline bool ieee80211_mle_reconf_sta_prof_size_ok(const u8 *data,
 	       fixed + prof->sta_info_len - 1 <= len;
 }
 
+static inline bool ieee80211_tid_to_link_map_size_ok(const u8 *data, size_t len)
+{
+	const struct ieee80211_t2l_map_elem *t2l = (const void *)data;
+	u8 control, fixed = sizeof(*t2l), elem_len = 0;
+
+	if (len < fixed)
+		return false;
+
+	control = t2l->control;
+
+	if (control & IEEE80211_T2L_MAP_CONTROL_SWITCH_TIME_PRESENT)
+		elem_len += 2;
+	if (control & IEEE80211_T2L_MAP_CONTROL_EXPECTED_DUR_PRESENT)
+		elem_len += 3;
+
+	if (!(control & IEEE80211_T2L_MAP_CONTROL_DEF_LINK_MAP)) {
+		u8 bm_size;
+
+		elem_len += 1;
+		if (len < fixed + elem_len)
+			return false;
+
+		if (control & IEEE80211_T2L_MAP_CONTROL_LINK_MAP_SIZE)
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
index 6c56ec42dde9..fde956f8a939 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1678,6 +1678,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_multi_link_elem *ml_basic;
 	const struct ieee80211_multi_link_elem *ml_reconf;
 	const struct ieee80211_bandwidth_indication *bandwidth_indication;
+	const struct ieee80211_t2l_map_elem *t2l_map[IEEE80211_T2L_MAP_MAX_CNT];
 
 	/* length of them, respectively */
 	u8 ext_capab_len;
@@ -1711,6 +1712,8 @@ struct ieee802_11_elems {
 	/* The reconfiguration Multi-Link element in the original IEs */
 	const struct element *ml_reconf_elem;
 
+	u8 t2l_map_num;
+
 	/*
 	 * store the per station profile pointer and length in case that the
 	 * parsing also handled Multi-Link element parsing for a specific link
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 97c5823da0eb..648d4b883d43 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -995,6 +995,14 @@ ieee80211_parse_extension_element(u32 *crc,
 			elems->bandwidth_indication = data;
 		calc_crc = true;
 		break;
+	case WLAN_EID_EXT_TID_TO_LINK_MAPPING:
+		calc_crc = true;
+		if (ieee80211_tid_to_link_map_size_ok(data, len) &&
+		    elems->t2l_map_num < ARRAY_SIZE(elems->t2l_map)) {
+			elems->t2l_map[elems->t2l_map_num] = (void *)data;
+			elems->t2l_map_num++;
+		}
+		break;
 	}
 
 	if (crc && calc_crc)
-- 
2.38.1

