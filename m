Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539486A05AD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjBWKK2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjBWKKW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:10:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA8851F88
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147014; x=1708683014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4vSpCzna0egldAcTfT6fQwZ13/Mw9yITNPPz/I7zC6o=;
  b=L5SDHsTKrnB1ZKe30/pkNZ+vOTH3EtfTTuEiOccRQb+/XXhY1gvDqJ7I
   snXMny+/FgjrwbU16/jLglyklnBrOxhgSUXgMhFhbS75digdPUfl4UAin
   TquGZvf1MsY1TH+QBzFMj5UKv/QUMEp/L9mc7ySXr08s88owXkeKA7Cs4
   jloTyjf+quWlP8+b0rcERuhnEkSM55ZOsPFGQyn+YjidjpQXUlcjKbL5I
   kFcrQywOyq3s11sJ4ZnmLbb+3b7aotFgP1fKxax8OJhIxBTlxYsBDYXfM
   tvykOvtMdj534r8VILaDHYiG2G7I5WrRcIZSuLthFJ16M3RBExfqKmJpW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396179"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396179"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796244879"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796244879"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:11 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/21] wifi: nl80211: Update the documentation of NL80211_SCAN_FLAG_COLOCATED_6GHZ
Date:   Thu, 23 Feb 2023 12:09:22 +0200
Message-Id: <20230223114629.92bcd37b0ba6.I5129fd61841332474693046241586f057b134c3c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230223100942.767589-1-gregory.greenman@intel.com>
References: <20230223100942.767589-1-gregory.greenman@intel.com>
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

From: Ilan Peer <ilan.peer@intel.com>

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/uapi/linux/nl80211.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f14621a954e1..c22eeb18b996 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6510,8 +6510,14 @@ enum nl80211_timeout_reason {
  * @NL80211_SCAN_FLAG_FREQ_KHZ: report scan results with
  *	%NL80211_ATTR_SCAN_FREQ_KHZ. This also means
  *	%NL80211_ATTR_SCAN_FREQUENCIES will not be included.
- * @NL80211_SCAN_FLAG_COLOCATED_6GHZ: scan for colocated APs reported by
- *	2.4/5 GHz APs
+ * @NL80211_SCAN_FLAG_COLOCATED_6GHZ: scan for collocated APs reported by
+ *	2.4/5 GHz APs. When the flag is set, the scan logic will use the
+ *	information from the RNR element found in beacons/probe responses
+ *	received on the 2.4/5 GHz channels to actively scan only the 6GHz
+ *	channels on which APs are expected to be found. Note that when not set,
+ *	the scan logic would scan all 6GHz channels, but since transmission of
+ *	probe requests on non PSC channels is limited, it is highly likely that
+ *	these channels would passively be scanned.
  */
 enum nl80211_scan_flags {
 	NL80211_SCAN_FLAG_LOW_PRIORITY				= 1<<0,
-- 
2.38.1

