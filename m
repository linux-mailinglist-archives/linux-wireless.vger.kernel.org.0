Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D6172CAAF
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjFLPwC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbjFLPv7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:51:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4389E6
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585112; x=1718121112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SF2l2ZN4P3yBqoC7R4bDYteJtqTCcavbITCu0CB8E48=;
  b=OEl2u9VMQ7ugXCeqCi6cacJM2aJ863FRQLUMQTHManV8rgHVoVt4u/K0
   iuuSwZtKogepHM8pypxH7pqTwKO0vZAUXWDIaO+CKyedTWMQ3Ce0zsgXh
   1eMQNPiqyMXCM9XCjqpbTbSnGlSRLkaa9SIy7DEIDziaWMbtrecvT7Nw4
   G4YiFLvq5kjboC3aeSYwxQVTSYzbp/IsqWc/bP90HWZugFhAhR5NBCwUM
   ZbbpECmYzHNHAWRyxsWzjPm9IxIh2f0RI37hmH2YPsEFULNp0TGyRm9oO
   +6APies6sykulShd1mh6GnORsCv64DkOpIwleHPhdjZzXRMk3eV9R0IH8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674265"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674265"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499355"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499355"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: fw: print PC register value instead of address
Date:   Mon, 12 Jun 2023 18:51:11 +0300
Message-Id: <20230612184434.e5a5f18f1b2c.Ib6117a4e7f66a075913241cc81477c0059953d5d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612155116.168000-1-gregory.greenman@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

The program counter address is read from the TLV and
PC address is printed in debug messages.
Read the value at PC address and print the value
instead of the register address.

Fixes: 5e31b3df86ec ("wifi: iwlwifi: dbg: print pc register data once fw dump occurred")
Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 64e83f30f947..23388261e97f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -507,11 +507,16 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 	iwl_fwrt_dump_fseq_regs(fwrt);
 	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
 		pc_data = fwrt->trans->dbg.pc_data;
+
+		if (!iwl_trans_grab_nic_access(fwrt->trans))
+			return;
 		for (count = 0; count < fwrt->trans->dbg.num_pc;
 		     count++, pc_data++)
 			IWL_ERR(fwrt, "%s: 0x%x\n",
 				pc_data->pc_name,
-				pc_data->pc_address);
+				iwl_read_prph_no_grab(fwrt->trans,
+						      pc_data->pc_address));
+		iwl_trans_release_nic_access(fwrt->trans);
 	}
 
 	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
-- 
2.38.1

