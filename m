Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F66CD283
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjC2HGy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjC2HGv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:06:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA440FE
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073573; x=1711609573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=60yYO7xv2Ochy7uD/DYU+7zoI+7jwn7L7o/fk+K3E9s=;
  b=fuidNItkwFeqTsvGxJbW8v6eD4c4/0YMWeLtaGzNwzamtoTPGuUDhRhD
   +9kw8E0xC4Bo50XUOQcPQar2jsTujJ1HZvaTbSFPhEikGPa4Vi4vkWogB
   p0J2W6xWAhSSxaozq2uHwMCuFQtJXnHny3LDb4KIlztMvc2Cr6qpW1uyf
   uctOmjW+JvMARa7rI7tj3n85nzCHs5qiWZFRFlnClbVrkoKbXILLvOIlh
   jluPowLXPqDPbHD9qtMXLD45NQFWsNUeIjeD2j9Hbqe3zJkX+2+5RLbac
   QQQqN1mYAp/CUQbn0yOi43sAbSimG5Ba2+w9tT2XXcJZZn54vOvYBlo5/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450728"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450728"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111180"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111180"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:00 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/34] wifi: iwlwifi: mvm: use STA link address
Date:   Wed, 29 Mar 2023 10:05:10 +0300
Message-Id: <20230329100039.c853c8ced3ba.I2e1915d1090c526e6a4c718440b45a7192bbbb03@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For now we only support a single link, so just use the
deflink's address for the link address, instead of the
STA's (MLD) address, but use the link address anyway
in order to facilitate MLO connections.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 7a01295949fa..da9d2cefa509 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -398,9 +398,9 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 
 	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
 
-	/* For now the link addr is the same as the mld addr */
 	memcpy(&cmd.peer_mld_address, sta->addr, ETH_ALEN);
-	memcpy(&cmd.peer_link_address, sta->addr, ETH_ALEN);
+	/* FIXME: use the correct link */
+	memcpy(&cmd.peer_link_address, sta->deflink.addr, ETH_ALEN);
 
 	if (mvm_sta->sta_state >= IEEE80211_STA_ASSOC)
 		cmd.assoc_id = cpu_to_le32(sta->aid);
-- 
2.38.1

