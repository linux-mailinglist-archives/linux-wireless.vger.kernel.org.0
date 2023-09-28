Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8C7B1FBC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjI1OgN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjI1OgL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE3A1B0
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911769; x=1727447769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8tXViS708a7TfCFN4yFbLDVwzfi29rj/GC+3aKEVPTQ=;
  b=PmYoA2eH4YDYmARmZn6kclKSn08/GIxADTnYS9lw9bw5KqsJ/c5qbYFL
   2Mi4uYPLqX3LGWGC6kY9UfDSvH37C5/tyT7djYotzuyDj3V81DcYhwTf8
   PJ3BFTgXXCMBrtk1ODzUZnh3Qjirk81xRmF6bxm6wEIImHlN19LjAvdaP
   hCSHTCbecg24qUJ2S6Lo2JHu+kntCH1ZvmyqHPQdh6ndxP2gPolSxhLRk
   EqgtuO4lF7fxjra921HtUoeYbRP9xk/cns7UrHh2kAXU4nq299r7q49iJ
   F9Tjt1/4u1M2AfnoXbyuVdh6k9L8eHW2+l/2OQrwyFwEQrYQFpmSwxZCF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688443"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688443"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590429"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590429"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:07 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/18] wifi: cfg80211: Include operating class 137 in 6GHz band
Date:   Thu, 28 Sep 2023 17:35:28 +0300
Message-Id: <20230928172905.bed4a007d81b.I3eb4b8fe39c0c1a988c98a103b11a9f45a92b038@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230928143539.1037500-1-gregory.greenman@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
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

Draft P802.11be_D3.1 added operating class to describe 320 MHz
operation in the 6GHz band. Include this new operating class in
ieee80211_operating_class_to_band().

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 213c9405e645..0893b7f57832 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1999,6 +1999,7 @@ bool ieee80211_operating_class_to_band(u8 operating_class,
 		*band = NL80211_BAND_5GHZ;
 		return true;
 	case 131 ... 135:
+	case 137:
 		*band = NL80211_BAND_6GHZ;
 		return true;
 	case 81:
-- 
2.38.1

