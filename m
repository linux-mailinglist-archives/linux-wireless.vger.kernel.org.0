Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135FB7327FA
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbjFPGzS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjFPGzJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:55:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D697296F
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898507; x=1718434507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HmfwchnLo4DKxt/DQ6d/YN76WHmz43aEtE7YlWWBLm0=;
  b=eu26u+Lauo7Ch4AYrlWlAxzGUn3HdB1Id4Pee521IbMkzNMz/jkkMEfV
   VXJ033vpy0Kxnggy50imxuNSIhAbMQXNswIlXOO+b7LV4X95zAs45bmQL
   2k49l4AQQ6ajGA3+bqlMwMgiBhDtxIKDX9Shm3ysWOJrofIUEp6SmHDGs
   R2399kxcOoGS+Ptb5oacarG/Ne0+Ax9QbNvlPaS8PfRKcf/b1JWw2oeRg
   5TJr3BrmiW/Kk7wJE5RSawYpOvSv2LaGmQi1cKx9KzR3N2bFUWVH/pZyg
   cZzcW2yxTAeKcoIcq1QO8XSSVYqIOraXP3LNenQvX6U4WbSQ9i0BLXVv5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078928"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078928"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:55:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720457"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720457"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:55:05 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 19/20] wifi: mac80211: Add support for parsing Reconfiguration Multi Link element
Date:   Fri, 16 Jun 2023 09:54:08 +0300
Message-Id: <20230616094949.6eeb6c9a4a6e.I1cb137da9b3c712fc7c7949a6dec9e314b5d7f63@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Parse Reconfiguration Multi Link IE.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/ieee80211_i.h |  5 +++++
 net/mac80211/util.c        | 21 ++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 554aeb2e20d9..be3294719cb4 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1727,6 +1727,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_eht_cap_elem *eht_cap;
 	const struct ieee80211_eht_operation *eht_operation;
 	const struct ieee80211_multi_link_elem *ml_basic;
+	const struct ieee80211_multi_link_elem *ml_reconf;
 
 	/* length of them, respectively */
 	u8 ext_capab_len;
@@ -1752,10 +1753,14 @@ struct ieee802_11_elems {
 
 	/* mult-link element can be de-fragmented and thus u8 is not sufficient */
 	size_t ml_basic_len;
+	size_t ml_reconf_len;
 
 	/* The basic Multi-Link element in the original IEs */
 	const struct element *ml_basic_elem;
 
+	/* The reconfiguration Multi-Link element in the original IEs */
+	const struct element *ml_reconf_elem;
+
 	/*
 	 * store the per station profile pointer and length in case that the
 	 * parsing also handled Multi-Link element parsing for a specific link
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 473c77dd3137..1e104c8756b1 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -984,9 +984,24 @@ ieee80211_parse_extension_element(u32 *crc,
 		break;
 	case WLAN_EID_EXT_EHT_MULTI_LINK:
 		if (ieee80211_mle_size_ok(data, len)) {
-			elems->ml_basic_elem = (void *)elem;
-			elems->ml_basic = (void *)data;
-			elems->ml_basic_len = len;
+			const struct ieee80211_multi_link_elem *mle =
+				(void *)data;
+
+			switch (le16_get_bits(mle->control,
+					      IEEE80211_ML_CONTROL_TYPE)) {
+			case IEEE80211_ML_CONTROL_TYPE_BASIC:
+				elems->ml_basic_elem = (void *)elem;
+				elems->ml_basic = data;
+				elems->ml_basic_len = len;
+				break;
+			case IEEE80211_ML_CONTROL_TYPE_RECONF:
+				elems->ml_reconf_elem = (void *)elem;
+				elems->ml_reconf = data;
+				elems->ml_reconf_len = len;
+				break;
+			default:
+				break;
+			}
 		}
 		break;
 	}
-- 
2.38.1

