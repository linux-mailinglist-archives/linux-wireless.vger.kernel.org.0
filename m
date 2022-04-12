Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41664FE867
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbiDLTE1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbiDLTEZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 15:04:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FF620E
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649790127; x=1681326127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RBNPrefe8ZmddWqaYvMHWA3kI5l2YFVxnKTiFFQO1Wg=;
  b=DlDats40DGwPZ/y17B4UWrQ6JkdbI+RyC1eWDCTrt/j8aSkklBMMaAsp
   sj3DEZzctXsG9c5kzhiYhsBj2U6BA52Ph/MJ2wr2d0sjXw8SFj75/J/1j
   PsYoeAwroKSC5t9orebTQBa4VdYz30COrTDswTSDKIu/MmogXbmms2VEu
   q22iHyfash2pm3jG261+UvKK1pMn8vbZI4hcAAu/ujNNHFD7Upb3wI7PA
   6TZPq+N/Once/yCshtKwqzpKHpEVlXKT4MdBqlnCsLc3sk4rswMPGQm2m
   VcYxXfkR1ELU2Xokhiaqq1Lv1T3ZWYY4qunuMo6QWCjGN5bs9f7/+9ezD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262232135"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="262232135"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 12:01:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="572916307"
Received: from sergeyst-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.228.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 12:01:53 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     luca@coelho.fi, luciano.coelho@intel.com,
        linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH] MAINTAINERS: update iwlwifi driver maintainer
Date:   Tue, 12 Apr 2022 22:01:41 +0300
Message-Id: <20220412190141.4543-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Set myself as a maintainer of iwlwifi driver as Luca is
moving to a new role.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5ce4f60786e..283ddb060e6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9945,7 +9945,7 @@ S:	Supported
 F:	drivers/net/wireless/intel/iwlegacy/
 
 INTEL WIRELESS WIFI LINK (iwlwifi)
-M:	Luca Coelho <luciano.coelho@intel.com>
+M:	Gregory Greenman <gregory.greenman@intel.com>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi
-- 
2.35.1

