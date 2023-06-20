Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB267368BA
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFTKFA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjFTKEg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F64A1711
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255475; x=1718791475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W3xD8G1wySQQD0iG3yN6F0ZMGXcxd5xUWRsn/UvFeXU=;
  b=n9PB3Fn/hJkwgXqwPYLkmKopBl307XmSOSvE1aCwt0WPrmIwjSbd/qJF
   NierTbbnB3nh+n1bpF7FsqJS4+GM+nHv9JKfRSTZ3aN7+SaFQi7jlS7Hd
   AztKVxA76RA2ksD16XJAr0LT2AWfjaNULyemwoxy808weEeVkyS2O/vvX
   zuEmCPQwIoTK+mPNtyssDmI8H7MRDXUaSrC0HaR1UTxxf/DzD+jy3KWqy
   M9F24AU/HgzWJkKIGxp00P9h00LJd84bUr7tFxrwez8iikLUrL86GDX55
   jEt2emR5uzffdi9b2V4K4iI6Mt+j1H1wMOGkq89HeVeSdtmbGejO9cGD9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819576"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819576"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143166"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143166"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:31 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/19] wifi: iwlwifi: nvm: handle EHT/320 MHz regulatory flag
Date:   Tue, 20 Jun 2023 13:03:52 +0300
Message-Id: <20230620125813.2c5e886c08f3.Ibc5c27d973d0590e2dea1f50435f9cf3ba8c2c09@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

Handle the regulatory EHT/320 MHz flags from firmware just
like any other flags before it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index d79d5453c2dc..39f13518ca5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1567,10 +1567,17 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 
 		if (!reg_capa.allow_160mhz)
 			flags |= NL80211_RRF_NO_160MHZ;
+
+		if (!reg_capa.allow_320mhz)
+			flags |= NL80211_RRF_NO_320MHZ;
 	}
+
 	if (reg_capa.disable_11ax)
 		flags |= NL80211_RRF_NO_HE;
 
+	if (reg_capa.disable_11be)
+		flags |= NL80211_RRF_NO_EHT;
+
 	return flags;
 }
 
-- 
2.38.1

