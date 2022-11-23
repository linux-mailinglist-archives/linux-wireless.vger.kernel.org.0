Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C45636BC9
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 22:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiKWVDX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 16:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbiKWVDM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 16:03:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6258FB85F
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 13:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669237390; x=1700773390;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xryi2b5uF4Q+P7TuNu8w2c3yLTpkHJ2bLHVqEoZNiGA=;
  b=gtrpcZafBpkVVeRus+j6nF/LNAoRIfuUMnmLXNlr6Si0o4h+dbCzy+xP
   dabp6Go6NV1RqjbKn/gF9IbVgUD6GcpypIs7fhWobUOOJhHSr+jRrRnws
   7vguI317lzeKsF20O7BX/dTsrUAEdbSZX/x33ca0oXVJqQ3tGCDRxq9XX
   lcXqTsZKzhwnPvEXJOOcV0RuZ3A9/ZkNJ6OKN11aJP6ZT2ShVIIqhIM71
   h9jrLCzo5x6NJOpZZBv7MvnAD9d+ZETKJ/4HjAycXGmyLsFG4erT1L3dG
   yOb5JNV9SMVPoND6ST90zj9UEJoMcxyozSbpII5cZE//a+uFLopdFCKbP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="297518395"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="297518395"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 13:03:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="619761534"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="619761534"
Received: from stopaz-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.194.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 13:03:07 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 0/5] updates and fixes intended for v6.2 2022-11-23 
Date:   Wed, 23 Nov 2022 23:02:04 +0200
Message-Id: <20221123210209.2941641-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's an additional patchset intended for v6.2

This patchset contains:
* several MEI fixes (Smatch errors and one detected during an internal testing)
* a fix for an old double-free bug in tx path
* an update for debug data printed after FW load

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Thanks,
Gregory

Avraham Stern (2):
  wifi: iwlwifi: mvm: trigger PCI re-enumeration in case of PLDR sync
  wifi: iwlwifi: mvm: return error value in case PLDR sync failed

Ben Greear (1):
  wifi: iwlwifi: mvm: fix double free on tx path.

Daniel Gabay (1):
  wifi: iwlwifi: mvm: print OTP info after alive

Gregory Greenman (1):
  wifi: iwlwifi: mei: fix parameter passing to iwl_mei_alive_notif()

 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  1 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 29 +++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  3 +
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 12 ++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 85 ++++++++++---------
 8 files changed, 99 insertions(+), 44 deletions(-)

-- 
2.35.3

