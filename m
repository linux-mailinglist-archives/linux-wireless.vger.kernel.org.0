Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F772CAB3
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbjFLPwY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbjFLPwW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:52:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F45E1A7
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585138; x=1718121138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DyK1GQrxvFd8h16yCroU8hZZ23b+diXgSO8NFvyS1h0=;
  b=BEf2Z74q3O0XiUjC0aCSZPXab7XK3hBwhFbGVl1VLuftwH3xzSwyLYoB
   ara8zuAg9Iw1I6rjH0m2/Hkf/3h89LgUufgTtVsGDAE9gpN9D3NU/2QIp
   lQGmb0fMenIuYSXTT/kjawVV8JjXT6eo9AzlJeIpgyS6h2EMY3MrZ+Jhm
   +3ou1gut+n5cl6LSzmd47HhnuAN7qdRgBSZZn5Dhad2jwLHVQs73I9zJV
   moM/LbGXa496Z4hwWxurVCzBaWMcg6ExpsH/NKlj3Fi+/AmHNFGRJXts0
   ei1cWP7WzGtEOqNnwslNsUbz9DYLFY6bupvAguIbwnKvkUHAUKzaZ+WF5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674287"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674287"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499382"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499382"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:54 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: debugfs: add ppag capa to fw info file
Date:   Mon, 12 Jun 2023 18:51:13 +0300
Message-Id: <20230612184434.4655922aff4d.Ie934027940bd53d05124222aa6a8a8b7021952c4@changeid>
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

From: Alon Giladi <alon.giladi@intel.com>

Add information about ppag_china_bit_support capability.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 607e07ed2477..ebacf0e9fb0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -354,9 +354,18 @@ static int iwl_dbgfs_fw_info_seq_show(struct seq_file *seq, void *v)
 	const struct iwl_fw *fw = priv->fwrt->fw;
 	const struct iwl_fw_cmd_version *ver;
 	u32 cmd_id;
-
-	if (!state->pos)
+	int has_capa;
+
+	if (!state->pos) {
+		seq_puts(seq, "fw_capa:\n");
+		has_capa = fw_has_capa(&fw->ucode_capa,
+				       IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT) ? 1 : 0;
+		seq_printf(seq,
+			   "    %d: %d\n",
+			   IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT,
+			   has_capa);
 		seq_puts(seq, "fw_api_ver:\n");
+	}
 
 	ver = &fw->ucode_capa.cmd_versions[state->pos];
 
-- 
2.38.1

