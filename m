Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F25A735884
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjFSN1X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 09:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjFSN1W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 09:27:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86487123
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 06:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687181240; x=1718717240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KvWguZGglO0ZdEe0RJp7kVkK9S+rNoeulT0oL8e2odU=;
  b=EriHw3JvaWm2fsdoWqdyns3i5EpM7vJYddtzH396BMcwc277xueHMXd8
   uxkW8rnSuo12c1q1CVjrRg53kO0QQj/K8ToMQ54ztLQry+8JQHXWs3XBm
   cGe8rSfrjPGGvaMq6E37mH8VEGEJZU8/LGWnoVpsBYkB0/cKD+x7fBbjY
   XkiZ5zJ9OgtJbV1wxgf7BrxT15CQoSTcNUuUqqFFHBmb2JK6CjhZeYSFn
   DwYqXUA8kzXndUG0yK5aiR7a6qe6W8bzIAW04QOWcw5mcojw8DMvChk2r
   Uj1hyZmwXaq4/gVRNlGl0HRYdywjEorGCsPmDpXV/UeNS1ZVYFidCeO4N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339240698"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339240698"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="716871753"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="716871753"
Received: from aadawii-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.201.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 7/9] wifi: mac80211: fix CRC calculation for extended elems
Date:   Mon, 19 Jun 2023 16:26:51 +0300
Message-Id: <20230619161906.93235d5c8651.I6615cb3c1244bc9618066baa2bdad7982e9abd1f@changeid>
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

For extended elements, we currently only calculate the CRC
for some of them, but really we should do it also for the
rest that we care about, such as EHT operation and multi-
link.

Also, while at it, it seems we should do it even if they
aren't well-formed, so we notice if that changes.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/util.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 35701316dccf..516e68a39b7d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -918,6 +918,7 @@ ieee80211_parse_extension_element(u32 *crc,
 				  struct ieee80211_elems_parse_params *params)
 {
 	const void *data = elem->data + 1;
+	bool calc_crc = false;
 	u8 len;
 
 	if (!elem->datalen)
@@ -927,12 +928,9 @@ ieee80211_parse_extension_element(u32 *crc,
 
 	switch (elem->data[0]) {
 	case WLAN_EID_EXT_HE_MU_EDCA:
-		if (len >= sizeof(*elems->mu_edca_param_set)) {
+		calc_crc = true;
+		if (len >= sizeof(*elems->mu_edca_param_set))
 			elems->mu_edca_param_set = data;
-			if (crc)
-				*crc = crc32_be(*crc, (void *)elem,
-						elem->datalen + 2);
-		}
 		break;
 	case WLAN_EID_EXT_HE_CAPABILITY:
 		if (ieee80211_he_capa_size_ok(data, len)) {
@@ -941,13 +939,10 @@ ieee80211_parse_extension_element(u32 *crc,
 		}
 		break;
 	case WLAN_EID_EXT_HE_OPERATION:
+		calc_crc = true;
 		if (len >= sizeof(*elems->he_operation) &&
-		    len >= ieee80211_he_oper_size(data) - 1) {
-			if (crc)
-				*crc = crc32_be(*crc, (void *)elem,
-						elem->datalen + 2);
+		    len >= ieee80211_he_oper_size(data) - 1)
 			elems->he_operation = data;
-		}
 		break;
 	case WLAN_EID_EXT_UORA:
 		if (len >= 1)
@@ -981,16 +976,15 @@ ieee80211_parse_extension_element(u32 *crc,
 	case WLAN_EID_EXT_EHT_OPERATION:
 		if (ieee80211_eht_oper_size_ok(data, len))
 			elems->eht_operation = data;
+		calc_crc = true;
 		break;
 	case WLAN_EID_EXT_EHT_MULTI_LINK:
+		calc_crc = true;
+
 		if (ieee80211_mle_size_ok(data, len)) {
 			const struct ieee80211_multi_link_elem *mle =
 				(void *)data;
 
-			if (crc)
-				*crc = crc32_be(*crc, (void *)elem,
-						elem->datalen + 2);
-
 			switch (le16_get_bits(mle->control,
 					      IEEE80211_ML_CONTROL_TYPE)) {
 			case IEEE80211_ML_CONTROL_TYPE_BASIC:
@@ -1009,6 +1003,9 @@ ieee80211_parse_extension_element(u32 *crc,
 		}
 		break;
 	}
+
+	if (crc && calc_crc)
+		*crc = crc32_be(*crc, (void *)elem, elem->datalen + 2);
 }
 
 static u32
-- 
2.38.1

