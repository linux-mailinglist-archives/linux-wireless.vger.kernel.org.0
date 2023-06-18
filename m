Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0CE7347C0
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjFRSua (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFRSu3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B931A4
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114228; x=1718650228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZWs+WlGZSGpAisrjmVbvl3io9H/ohc8FEaD8vZ6rHc4=;
  b=KrxIWkxcxTCifyNsU+xZPRcfBNeA0OD4Zieh4T/K7T+r/nuR4t4G+bYp
   Kp0WjKi2/stK+R31OfqL4NsJXSOaRHFNjppfLp2M3yC9HITvx/L/vlyIh
   dhki5UNeKDypXpVe3B+Dnb1TyDasQMP2BStW/aNI1/V+lJMQILjF0Fv/o
   D4CyzqHNsDRoQ0bO6GgcHpjQZXKQIVGPcWRERxxWFEYvXVcCjbxRgX9Up
   9RN1YsxyHW+kzPaOu8z7Ar2L/2qlAoMHv+1qtIoIJ+24eDRfrZXUYy63O
   PW/CgWG5yKZXAlHyqZBz0LH0TmiSSd+WhPhJYY6/CaedOLKI0sWdi1X4j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116636"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116636"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:28 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747233881"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747233881"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:26 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/20] wifi: ieee80211: use default for medium synchronization delay
Date:   Sun, 18 Jun 2023 21:49:47 +0300
Message-Id: <20230618214435.a7725bef3795.I2d3528cf4af021c5b37f97fbe64ae9116ce9bef1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230618185002.817236-1-gregory.greenman@intel.com>
References: <20230618185002.817236-1-gregory.greenman@intel.com>
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

From: Benjamin Berg <benjamin.berg@intel.com>

Default values are defined for the information included in the Medium
Synchronization Delay Information subfield. The spec says to
initialize the values to these defaults and only change them when
included.

Return the default value instead of zero so that the defaults are
used when the field is not included in the association response.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index b107f21e1233..251998be24d0 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4535,6 +4535,14 @@ struct ieee80211_multi_link_elem {
 #define IEEE80211_MED_SYNC_DELAY_SYNC_OFDM_ED_THRESH	0x0f00
 #define IEEE80211_MED_SYNC_DELAY_SYNC_MAX_NUM_TXOPS	0xf000
 
+/*
+ * Described in P802.11be_D3.0
+ * dot11MSDTimerDuration should default to 5484 (i.e. 171.375)
+ * dot11MSDOFDMEDthreshold defaults to -72 (i.e. 0)
+ * dot11MSDTXOPMAX defaults to 1
+ */
+#define IEEE80211_MED_SYNC_DELAY_DEFAULT		0x10ac
+
 #define IEEE80211_EML_CAP_EMLSR_SUPP			0x0001
 #define IEEE80211_EML_CAP_EMLSR_PADDING_DELAY		0x000e
 #define  IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_0US		0
@@ -4642,7 +4650,8 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
  * The element is assumed to be of the correct type (BASIC) and big enough,
  * this must be checked using ieee80211_mle_type_ok().
  *
- * If the medium synchronization is not present, then 0 is returned.
+ * If the medium synchronization is not present, then the default value is
+ * returned.
  */
 static inline u16 ieee80211_mle_get_eml_med_sync_delay(const u8 *data)
 {
@@ -4654,7 +4663,7 @@ static inline u16 ieee80211_mle_get_eml_med_sync_delay(const u8 *data)
 	common += sizeof(struct ieee80211_mle_basic_common_info);
 
 	if (!(control & IEEE80211_MLC_BASIC_PRES_MED_SYNC_DELAY))
-		return 0;
+		return IEEE80211_MED_SYNC_DELAY_DEFAULT;
 
 	if (control & IEEE80211_MLC_BASIC_PRES_LINK_ID)
 		common += 1;
-- 
2.38.1

