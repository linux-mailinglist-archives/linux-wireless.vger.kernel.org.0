Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53257D2374
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjJVO4g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 10:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjJVO4e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 10:56:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F8111B
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697986591; x=1729522591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oCce0Ubhn71ADqAyC9UktQ+eO1ftAjGAZOoSj7Ungcs=;
  b=kQvwWdxwMlPwRoIdGPZ0651ZjfDcvrSIPH7/9znzayoQOSH4aGTbOXi4
   pRtml3lbf2ceTQ/kgnc+3uFAuYkqlDYIsG71MK5rI1feg0KrCk06a/sW0
   5HRyb2JorBbflBkgCpaMT9fQ58dc5oJ5JdxlnWSsGZjhjWvkv/TSvgpB+
   Vk0q/fIH9nh0ANInjlFZldCGn6S5koerZcim7KAb5jFCR1xERke57Yl22
   J6yd0No2j3NCgLG2GdBOKS0SEummeQ7/rL4KTJ40Uz/g398FAcaD0den6
   s2mt5sbP4//8krp97OxGI8G4iLt16fReYmHau7NHXjDRHeujWWBoeLYhL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="472925867"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="472925867"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="5556225"
Received: from umark-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.231.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:55:15 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/10] wifi: iwlwifi: bump FW API to 86 for AX/BZ/SC devices
Date:   Sun, 22 Oct 2023 17:55:56 +0300
Message-Id: <20231022173519.e2f720799600.I6e22188a47efe0cbb4e013259955c4019843799f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231022145556.244202-1-gregory.greenman@intel.com>
References: <20231022145556.244202-1-gregory.greenman@intel.com>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Start supporting API version 86 for new devices.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 0aa4d42c7a74..134635c70ce8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_AX210_UCODE_API_MAX	84
+#define IWL_AX210_UCODE_API_MAX	86
 
 /* Lowest firmware API version supported */
 #define IWL_AX210_UCODE_API_MIN	59
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index ed097dd394c9..82da957adcf6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	84
+#define IWL_BZ_UCODE_API_MAX	86
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	80
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index bc1e75ee946a..80eb9b499538 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	84
+#define IWL_SC_UCODE_API_MAX	86
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	82
-- 
2.38.1

