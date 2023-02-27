Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E906A4C6F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 21:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjB0Ukq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 15:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjB0Ujr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 15:39:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C9C28848
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 12:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677530374; x=1709066374;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l9XxEqJrNLwHGRQFH/5gqGNnxgONd212RX3oMACeEys=;
  b=M1+nGhLeXQO5Ia11pPgeDsr9wOiBk+zqk4uNhpVmMbHHWuYpDaOYr9e+
   fhPfV512KOg3sBG8yAoqHsf1aELi6ZHQaR21FOFWpEQIjbQWjZkrTp/1T
   AEyxjf5xUPbrbirk2/Bg7pyYkmofoJv8/QIT4BPZ9GhBbawSuj9zk+aTg
   XtXGzUVqhiHU7+OCF8FWBrpokC1tCxHZkraGubuCFe4XwuR4B7hzndfmQ
   C9Ra0NIbjE23v1tzu+R8hZq7bZzodsug90vfgR2BP06uK7IBfrQtdXBMR
   hPIHrAipBTmche/r+9ULZ31v4veoXOs7PDizmvs6ZFacult9i/F8TA9an
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="322208540"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="322208540"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 12:39:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="919492055"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="919492055"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 12:39:33 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 0/3] net: wireless: use struct_size where appropriate
Date:   Mon, 27 Feb 2023 12:39:24 -0800
Message-Id: <20230227203927.3662811-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f83
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series fixes a few wireless drivers to use struct_size rather than open
coding some equivalent checks. This ensures that these size calculations
will not overflow but instead be bounded at SIZE_MAX.

In the first case, the code is first converted to a flexible array, which
saves a few bytes of memory in addition to the fix with struct_size.

These were caught with a coccinelle patch I recently posted at [1].

[1]: https://lore.kernel.org/all/20230227202428.3657443-1-jacob.e.keller@intel.com/

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org

Jacob Keller (3):
  wifi: ipw2x00: convert ipw_fw_error->elem to flexible array[]
  wifi: cfg80211: use struct_size and size_sub for payload length
  wifi: nl80211: convert cfg80211_scan_request allocation to *_size
    macros

 drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  7 +++--
 drivers/net/wireless/intel/ipw2x00/ipw2200.h  |  3 +--
 .../net/wireless/quantenna/qtnfmac/commands.c |  7 ++---
 net/wireless/nl80211.c                        | 26 ++++++++++---------
 4 files changed, 22 insertions(+), 21 deletions(-)

-- 
2.39.1.405.gd4c25cc71f83

