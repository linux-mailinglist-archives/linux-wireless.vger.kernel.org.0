Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6D66A5D02
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 17:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjB1QXO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 11:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjB1QXN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 11:23:13 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3321AD26
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 08:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677601389; x=1709137389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l9XxEqJrNLwHGRQFH/5gqGNnxgONd212RX3oMACeEys=;
  b=JdjGIQBjVnE3RMJuQFHi3YmFyuei0mvypeYczG8ejotm6HAhOmCJ11zo
   W6cYGRm7dPJJ7YATwMZklYIY2BUNgTyQnyZkwhWZWoxVo55BR6OQKRH6K
   YfRMwwRK3k8kwcuG7BaQAHKShOV7HEdwO6g2gEBz/cvSCN6q7doI4OQOM
   d9mMjudotFBHrQsypKumiRtHT5Ea4REE7xiKCWMnfrAJtOHvK5uWOu02a
   0xJL4DmLu0vIAbw1ReLimK4yqnLD2oEvkKSlAEQfOuCcJwMw3yHrivsaO
   9RtEB7ndSltjxzOrmsSSr0EVe9M24UbjjDcwW6uR/ejRyVdGpuR6FqldD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336470961"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="336470961"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:22:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="651646911"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="651646911"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:22:55 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 0/3] net: wireless: use struct_size where appropriate
Date:   Tue, 28 Feb 2023 08:22:38 -0800
Message-Id: <20230228162241.3874991-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f83
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

