Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B81B7E1DE8
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Nov 2023 11:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjKFKIu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Nov 2023 05:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKIt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Nov 2023 05:08:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B721DA9
        for <linux-wireless@vger.kernel.org>; Mon,  6 Nov 2023 02:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699265326; x=1730801326;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iInoY/2NmAdaN1Xt0r9DRjJsAJOjOS1P8nyZxb7JqQk=;
  b=ZP3+cjgz+R9/TWv1zVKg7r3ML0o6TjUMABS6hcUl4n3oMUPrnVh/rIkq
   yiDYsRL4k5v2IsIWpffPUUqBiCcb11jII59sRNfYamFa84sQb8eIBEVB6
   uAgumIvOs53s6MS1juO7/zC8bFxrxZJUq3dH0Q3zWvzJGKxXuC4WLEz/k
   DZZ+3RNExxeGW0xcxnnlqeOnnOYoZ8WL/1xOqI8DED1vLNewW3XM2Bg+F
   dgFR+PkGK7EPVKl47cr00CYkq3LI+tOULbixDWLRQ30sOrLRmSHINgFwp
   LRbEt9jB7C0D2jg9z7iCMFiMnDUD8qfxs90zrME8B/ccKkAZFJO48pru/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="392113819"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="392113819"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:08:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="832680614"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="832680614"
Received: from nabuhijl-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.164])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:08:43 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] MAINTAINERS: update iwlwifi maintainers
Date:   Mon,  6 Nov 2023 12:07:59 +0200
Message-Id: <20231106100759.1226662-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Add Miri as a maintainer for iwlwifi driver.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fca2003efa7b..7e7a54386dc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10860,6 +10860,7 @@ F:	drivers/net/wireless/intel/iwlegacy/
 
 INTEL WIRELESS WIFI LINK (iwlwifi)
 M:	Gregory Greenman <gregory.greenman@intel.com>
+M:	Miri Korenblit <miriam.rachel.korenblit@intel.com>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi
-- 
2.38.1
