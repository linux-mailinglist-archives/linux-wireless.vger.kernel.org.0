Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4099723A5A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbjFFHqq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbjFFHqF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:46:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E113310C2
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037403; x=1717573403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WiwTKNW5nqu2r12VFG0azIa+7X8VutGhdHFxs6gKC9U=;
  b=ECa+/ic0djhIicWIrgaKM8dtuWbx2vCM1o0l6IlDDHeU9Jn5vkZGEF1A
   4lfGjOK6l2kzGd9k9GFBWMOo76Vr+NIMjimAo7x3h8a5L7+GaIwBaSfZK
   MYXokjJynnztJ9Wy2z8/rYCqdZCbJV8K3OKhlsEYEaiz6gvCEtKkknOsB
   FPzsLyZCeKrw6FXygTt6DNzwAkI4kwZmr5UGj1auxoxyhdZlHGvgmMzl+
   jYrB4+UvmuIOOOS5H9/Qe9wcDPWHPEwM549K9ZR7J1qMR9zk92zgLAx+Y
   VMhWcX0N/pU23WEksr3JTATzGj4G4G07E9JW6eRZGB1nR4FCPU4F+iAQo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419035"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419035"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516206"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516206"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/13] wifi: iwlwifi: updates intended for v6.5 2023-06-06 
Date:   Tue,  6 Jun 2023 10:42:57 +0300
Message-Id: <20230606074310.889520-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
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

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.5.
All the patches are related to the same feature - adding support
for fragmented PNVM image.

Thanks,
Gregory

Alon Giladi (10):
  wifi: iwlwifi: Generalize the parsing of the pnvm image
  wifi: iwlwifi: Separate loading and setting of pnvm image into two functions
  wifi: iwlwifi: Take loading and setting of pnvm image out of parsing part
  wifi: iwlwifi: Allow trans_pcie track more than 1 pnvm DRAM region
  wifi: iwlwifi: Add support for fragmented pnvm images
  wifi: iwlwifi: Implement loading and setting of fragmented pnvm image
  wifi: iwlwifi: Separate loading and setting of power reduce tables
  wifi: iwlwifi: Use iwl_pnvm_image in reduce power tables flow
  wifi: iwlwifi: Enable loading of reduce-power tables into several segments
  wifi: iwlwifi: Separate reading and parsing of reduce power table

Gregory Greenman (2):
  wifi: iwlwifi: fw: don't use constant size with efi.get_variable
  wifi: iwlwifi: pnvm: handle memory descriptor tlv

Johannes Berg (1):
  wifi: iwlwifi: fw: clean up PNVM loading code

 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   2 +
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 234 +++++++++------
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h  |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 272 ++++++++---------
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  47 +--
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  32 +-
 .../wireless/intel/iwlwifi/iwl-context-info.h |   5 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  95 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   3 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 273 +++++++++++++++---
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |   8 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  12 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  39 ++-
 13 files changed, 694 insertions(+), 333 deletions(-)

-- 
2.38.1

