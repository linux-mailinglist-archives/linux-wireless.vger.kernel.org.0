Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380F4783AFA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 09:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjHVHde (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 03:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjHVHdd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 03:33:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E42137
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 00:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692689612; x=1724225612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5qYS8lB8Zt3V425xe/+VgRxaybEQLM/DdDe99XmyPVQ=;
  b=LH/EKDLb+cAcV48tC0PylKY1EW2ZM3bT5PyCpIF0yZ04Cwe90hlmL/pz
   RcTLbTHWcLYkJO/NTrmq+uESDGWsX0OVLbc6SjqgV9aSirmS2sbZbTiam
   7xnZASOqc8TDYGs8LCIG5Zuew58RmVtSbkF88QNjypaPFHRl3t3eWcfg4
   Et4c82gWDgqNNczyPpYFCtp+qc0F83vQATr202yMsHLpiqYcY0xw9G8k1
   db2+RMZNdHfwuc2oLv1mXqyFkhOh+54cTQt1TIsZ5tqG69/5SmCv1tD2T
   2OCVpKJRTXtPD5B8MdjVQkaQsY+y55l2xBCLyNzesjI8L8Dd817yLo7bv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="363968711"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="363968711"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826229593"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="826229593"
Received: from msharshe-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.209.35])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 0/5] wifi: iwlwifi: updates intended for v6.6 2023-08-22
Date:   Tue, 22 Aug 2023 10:33:14 +0300
Message-Id: <20230822073319.466640-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.6.

A few iwlmei fixes and a related PCIe fix.

Thanks,
Gregory

Avraham Stern (5):
  wifi: iwlwifi: pcie: avoid a warning in case prepare card failed
  wifi: iwlmei: don't send SAP messages if AMT is disabled
  wifi: iwlmei: send HOST_GOES_DOWN message even if wiamt is disabled
  wifi: iwlmei: send driver down SAP message only if wiamt is enabled
  wifi: iwlmei: don't send nic info with invalid mac address

 drivers/net/wireless/intel/iwlwifi/mei/main.c | 70 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 11 +--
 2 files changed, 37 insertions(+), 44 deletions(-)

-- 
2.38.1

