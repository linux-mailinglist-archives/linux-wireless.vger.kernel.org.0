Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165996E206C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDNKMp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDNKMa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:12:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87E193C9
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467147; x=1713003147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NE+Y6w83p7JuO0TTDLvJJ5K1MdDEOpBq5glCfo4B//M=;
  b=Lai3Rz+KR4sJXWTsIJMVEXADglrzbEggIbhDOOWYNbatNSZ+5sRysS5n
   p4MwxrL6jzEOdgmy41kNI6b0HV4DC3AyR6DiXYCOjozd+GuWfj411ERPJ
   txF8jfN/j4VLBzV9/Y6jgjLnLZJHxHBeJ1klILdRzA1T1hvTZlMqLf5s/
   8Y6Ods0w/7DkhPlaQE12JklKMwjw2XJcpyrjn91wlMeLNjpQAN3SYKEHX
   RKceeQdQ7C1n0JS1XFX2kuq6fNOlWTouZ2XIMRXEvYmiqxCSOOprXjdd8
   h3kP4CBWJVkUEUkDKIXi9egLiTUwK2/kdhAtZSTmXvwwXN590dH0Mq/1d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263562"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263562"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351675"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351675"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:25 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: Fix spelling mistake "upto" -> "up to"
Date:   Fri, 14 Apr 2023 13:11:55 +0300
Message-Id: <20230414130637.a00965734d02.I760cb43829b3d7a0f567f0958059f2fae0aa8a93@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414101206.1170180-1-gregory.greenman@intel.com>
References: <20230414101206.1170180-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in a IWL_ERR error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 4959977a92a1..4f7f30d79553 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -895,7 +895,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				drv->fw.img[IWL_UCODE_WOWLAN].is_dual_cpus =
 					true;
 			} else if ((num_of_cpus > 2) || (num_of_cpus < 1)) {
-				IWL_ERR(drv, "Driver support upto 2 CPUs\n");
+				IWL_ERR(drv, "Driver support up to 2 CPUs\n");
 				return -EINVAL;
 			}
 			break;
-- 
2.38.1

