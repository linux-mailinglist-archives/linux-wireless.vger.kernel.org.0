Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F66A6A88
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCAKK0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCAKKK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B912FCCD
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665410; x=1709201410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KlLTnpUOR0dxMq76x71MDS3Pz6dQjIRjjcGVqlH4yJM=;
  b=GdsMs1z/W/eHvQMC6ig51HsMdpIPYDQd/GVJD5oFvs0GbcAoyta1uXnj
   L10tUavE9Tclh75HxcSeu/ltYOZU5ziiC/2Jsx8eqX8ZKlONWzwaQBQlK
   ElMee7SJvZKb0KrUerRkp05Be3ACX1m2BdNFos3Od+at0meHH0vmw9d0w
   vXygi/DECXsOMmj0neYqsiFE09TVGU3JBbvM63p51uo+pOqT2ioaP2fAp
   RxsY/q22tuyoqznFbyng/sAJFfvCxkKSJJ2cI2DHUTI7URVX4/Fw4Elsx
   bvBWjNl+0MRGnb1UJTEKzvS8MP0f56WM29+pH4pmlmOaVGtD542FCJaB9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662762"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662762"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:09:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738588999"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738588999"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:09:56 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 01/23] wifi: nl80211: Update the documentation of NL80211_SCAN_FLAG_COLOCATED_6GHZ
Date:   Wed,  1 Mar 2023 12:09:13 +0200
Message-Id: <20230301115906.487ab04feb39.I5129fd61841332474693046241586f057b134c3c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230301100935.170922-1-gregory.greenman@intel.com>
References: <20230301100935.170922-1-gregory.greenman@intel.com>
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

Add a detailed description of NL80211_SCAN_FLAG_COLOCATED_6GHZ
flag.

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

