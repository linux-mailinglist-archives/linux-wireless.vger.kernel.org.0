Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB69719FA3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 16:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjFAOUj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 10:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjFAOUi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 10:20:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF23D1A8
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629234; x=1717165234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hG9sjoshQnFQltSqbNkO30xazJMnjp50CEiUdVYGcaA=;
  b=eJhR/su1rDyouasbKLtTP2mpDFOe7FaGCsENPNXAQRZJ1RzRjtEyK1+f
   5c+BtSYGPpHw+fOw/sZbXDkLJJuH19H4MNpRfBC9OxmiOiGMPaBmUq4K1
   4V6M98auVGJwF/HPhd3522fZvkWrLBUMki+oEfwzEFfufdLaCQgVTforQ
   zSSQ8qRzxRBEZwzGgHwFDDeN9B2kK217rz+N3amOiUQohG0U5nNHMpBhq
   u2CMyLWzd0vRjnmB6XdR7+M+8BbMpesukvyTk62qkpZPCGGX0fs8AY9fi
   DkwFwzQIEiNuofbD4siFHzwMMwcf7bzsU0i2jHYEt/eW10QtxQ3WWNImB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="441931802"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441931802"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="819812710"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="819812710"
Received: from dvinnyc-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.93.27])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:21 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 0/6] wifi: iwlwifi: updates intended for v6.5 2023-06-01 
Date:   Thu,  1 Jun 2023 17:20:02 +0300
Message-Id: <20230601142008.375040-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.5.
It has few small kernel-doc fixes along with two other bugfixes.

Thanks,
Gregory

Alon Giladi (1):
  wifi: iwlwifi: mvm: fix OEM's name in the tas approved list

Johannes Berg (5):
  wifi: iwlwifi: api: link context action in kernel-doc
  wifi: iwlwifi: api: use __le16 instead of u16
  wifi: iwlwifi: api: remove unused commands
  wifi: iwlwifi: api: fix kernel-doc links
  wifi: iwlwifi: limit queue use independent of allocation

 .../wireless/intel/iwlwifi/fw/api/binding.h   |  6 ++---
 .../wireless/intel/iwlwifi/fw/api/commands.h  | 23 +++++++------------
 .../wireless/intel/iwlwifi/fw/api/context.h   | 13 +++++++----
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  6 +++--
 .../wireless/intel/iwlwifi/fw/api/location.h  | 16 +++++++++----
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  6 ++---
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  2 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 11 ++++++---
 .../wireless/intel/iwlwifi/fw/api/offload.h   |  3 ++-
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |  6 ++---
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   | 10 +++++---
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  2 +-
 .../intel/iwlwifi/fw/api/time-event.h         |  7 +++---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 --
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 23 ++++++++++++++++---
 17 files changed, 87 insertions(+), 53 deletions(-)

-- 
2.38.1

