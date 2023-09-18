Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08E87A4816
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbjIRLM1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241429AbjIRLL4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34ED102
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035508; x=1726571508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HtDJhZB2j4u2ksLhmW/LRlqH1TmIrp2WCbJFqoGS+0=;
  b=S+NDyn/E6qbItUEPgQMJn9w5j9ckSyFf2EUYpwN8OyQqcL16UMB9M0/Q
   NjLB6E8rnkQhRYAshwmRdMmQIOOZd8viNUquO+gNAP+us1wuL2DLW/ycb
   kf9weyQ8WRCIYNM2MbPuxvhG3DBcLhdPqj5j7S3afbmgUVyWAmvHwLjBd
   ZJ7ekhwAl/N2dr6k66zGALumzunoorIRNrjUQwbW2fTexRIk+FM6JZ5Gx
   EyGY31e2KMYqE8nWsGa+E3BvocAh1fpVZUkkJ/d27ZH988nA/834UxNQC
   CbaxkUIfxovbFu08qVGL+uk2rkqU9F+K8bTZUPVSxIPTx5g74mF4abd4c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535781"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535781"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025342"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025342"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:39 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/18] wifi: cfg80211: Fix 6GHz scan configuration
Date:   Mon, 18 Sep 2023 14:10:54 +0300
Message-Id: <20230918140607.6d31d2a96baf.I6c4e3e3075d1d1878ee41f45190fdc6b86f18708@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

When the scan request includes a non broadcast BSSID, when adding the
scan parameters for 6GHz collocated scanning, do not include entries
that do not match the given BSSID.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index a5758edf53b8..8d114faf4842 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -908,6 +908,10 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		    !cfg80211_find_ssid_match(ap, request))
 			continue;
 
+		if (!is_broadcast_ether_addr(request->bssid) &&
+		    !ether_addr_equal(request->bssid, ap->bssid))
+			continue;
+
 		if (!request->n_ssids && ap->multi_bss && !ap->transmitted_bssid)
 			continue;
 
-- 
2.38.1

