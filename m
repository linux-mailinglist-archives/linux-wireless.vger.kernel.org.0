Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEE27347C4
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjFRSuq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFRSup (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3702A1A4
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114238; x=1718650238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MKjV6mdrCY1LWLfOXjj/LlyCEvRrOIyfdJS5T0m8XiM=;
  b=OuiHw2WJ8LtakGisbM7fniv6YLhGOp4UVq0nY1u8cwz5Sjk5UwQgpLwV
   4OEzszzaSDVu8dh3GKTgE2OjLZTn8e7MIPCUu5rR852H90HKohQQQzaUN
   LXY6+Gg90SWwyy8x7i6JlOSZsLeRm2Ic251zuEnaM63RpYEByPs4ZiCof
   y4IMfB6VpqJ8YBsW3QdUTM3h2Ps4ls7gHB0fMroPRIG1Zrkd6HabdFlJJ
   srYsrw7XvxtFj0dbuQdqu8ZRLkmdPJSKtuf1VgQDjaVTIL8dke34XZC2U
   DE7xxC2ZvI+Pfe50nn6D7WBJuQFDINHdO0Cah+wuoLrPbLj9jxKrdHtK9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116647"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116647"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:37 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747233978"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747233978"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/20] wifi: ieee80211: add structs for TBTT information access
Date:   Sun, 18 Jun 2023 21:49:51 +0300
Message-Id: <20230618214436.2a6f8766a3ec.Ic962e28492212cc8ee1eb602b8f07a4ea172fc4a@changeid>
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

The TBTT information can have various lengths with different elements
thare are present. Add definitions for the two types that we are
interested in (i.e. the ones that contain the BSSID).

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 7afd08d2de2f..5a27c232afdb 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4523,6 +4523,28 @@ struct ieee80211_rnr_mld_params {
 #define IEEE80211_RNR_MLD_PARAMS_UPDATES_INCLUDED		0x1000
 #define IEEE80211_RNR_MLD_PARAMS_DISABLED_LINK			0x2000
 
+/* Format of the TBTT information element if it has 7, 8 or 9 bytes */
+struct ieee80211_tbtt_info_7_8_9 {
+	u8 tbtt_offset;
+	u8 bssid[ETH_ALEN];
+
+	/* The following element is optional, structure may not grow */
+	u8 bss_params;
+	u8 psd_20;
+} __packed;
+
+/* Format of the TBTT information element if it has >= 11 bytes */
+struct ieee80211_tbtt_info_ge_11 {
+	u8 tbtt_offset;
+	u8 bssid[ETH_ALEN];
+	__le32 short_ssid;
+
+	/* The following elements are optional, structure may grow */
+	u8 bss_params;
+	u8 psd_20;
+	struct ieee80211_rnr_mld_params mld_params;
+} __packed;
+
 /* multi-link device */
 #define IEEE80211_MLD_MAX_NUM_LINKS	15
 
-- 
2.38.1

