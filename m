Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DA767D894
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 23:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjAZWgv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 17:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjAZWgl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:41 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B646298DA
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 14:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772600; x=1706308600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNFr408FU7y/ZdbFYBQdnPIbup+RQCcNEIm6BbcQ4so=;
  b=gpjFBxtLi5Mc//g2otXw4ePHuBTHDzmTOujIXAqWNkROdvTLjTIXsKJ9
   SC0F0agTawb2jODuZ3XHd3Tj8WtAzA8ljfStDA3N0NFmifxl2zXs42wpf
   fKlLPU+GNkxP0jZuXk+Y+nJkwsw9GWtx87mIHQ4k82WB31FPn0DNtRiEk
   WIFopDH1NrUR9wWtOf9Ts9stdl0I85MJ/NC+JEs6quXLX0s8s9sKx9rvc
   WAFbbG6Q3hQEn06YBDYqCmlTAg8484KX2Cgv3XNVT6NhSq36vgHyXyFej
   nhat+vL+iGdnKlau0kkTwDdWFr2yj5tQltxrYQy4TF5BcgfKCIsQqK+//
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329098726"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329098726"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612986302"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="612986302"
Received: from razgilad-mobl7.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.211.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:29 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Golan Ben Ami <golan.ben.ami@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/12] wifi: iwlwifi: bump FW API to 74 for AX devices
Date:   Fri, 27 Jan 2023 00:28:19 +0200
Message-Id: <20230127002430.80012ee4c5d6.I45ba1f8bf923d242ef2ffeb160d736120c8add65@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230126222821.305122-1-gregory.greenman@intel.com>
References: <20230126222821.305122-1-gregory.greenman@intel.com>
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

From: Golan Ben Ami <golan.ben.ami@intel.com>

Start supporting API version 74 for AX devices.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index ec6198f1b38c..3bdd6774716d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_22000_UCODE_API_MAX	72
+#define IWL_22000_UCODE_API_MAX	74
 
 /* Lowest firmware API version supported */
 #define IWL_22000_UCODE_API_MIN	39
-- 
2.38.1

