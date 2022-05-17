Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB18529D80
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 11:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244306AbiEQJIV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 05:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244374AbiEQJHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 05:07:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FBA23BD7
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 02:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652778408; x=1684314408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pO4K6ca3nxEpvtgRs0gQbHdPYjJFJErgmD63DL4qbGY=;
  b=V4KGJ0wPoOypeo5LPXdO/Ko0C5v0tw+R50JkyZjfHFGyJhFTcaKBaJuF
   INTtKENaGENYVsayI03LoXJiUmgI0ShMMbTXf9sLJTnfF4JUMv7sEpXYo
   V9t+hXamqDrujwTMaC34UdVmXdBle4ZvAh3rIZU/ACanUJBfWLzq7dSF/
   uajkOxmMxULsIi2mEiuEMF02UYpw+kBVX1sYfd1pQvQMSwSDnSgjQhTEF
   g7evBYFiU+6AcpOsZ/+zmlV79WuuSMhMVy4Vtn7ZUSAOOveeMKERK3+oE
   qZY11avRPPQemZt38nLqrE2rNmC58AXltHc7jIoyiqLb+wah6HlUJk78N
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271064839"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271064839"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="741679771"
Received: from sgens-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.212.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:32 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 09/10] iwlwifi: mei: clear the sap data header before sending
Date:   Tue, 17 May 2022 12:05:13 +0300
Message-Id: <20220517120045.8dd3423cf683.I02976028eaa6aab395cb2e701fa7127212762eb7@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517090514.211796-1-gregory.greenman@intel.com>
References: <20220517090514.211796-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The SAP data header has some fields that are marked as reserved
but are actually in use by CSME. Clear those fields before sending
the data to avoid having random values in those fields.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index b4f45234cfc8..3d2eb15a9662 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -493,6 +493,7 @@ void iwl_mei_add_data_to_ring(struct sk_buff *skb, bool cb_tx)
 	if (cb_tx) {
 		struct iwl_sap_cb_data *cb_hdr = skb_push(skb, sizeof(*cb_hdr));
 
+		memset(cb_hdr, 0, sizeof(*cb_hdr));
 		cb_hdr->hdr.type = cpu_to_le16(SAP_MSG_CB_DATA_PACKET);
 		cb_hdr->hdr.len = cpu_to_le16(skb->len - sizeof(cb_hdr->hdr));
 		cb_hdr->hdr.seq_num = cpu_to_le32(atomic_inc_return(&mei->sap_seq_no));
-- 
2.35.1

