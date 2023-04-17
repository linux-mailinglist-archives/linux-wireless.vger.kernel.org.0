Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AF36E42D1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjDQIm3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjDQIm2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6622830D3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720941; x=1713256941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y0VT5xr/ASFgEZkBgeQLX0wzTKcpl3O8XDdAuUHfbeY=;
  b=d135DucKlhZH1ENkvtLBw5Ofa8FmMr4hHUHRGLHquBQSRcO/ki2KsepE
   ol7xvqoXEQGBYUFNhIkuQY2LxJB+IGnk5SZhZig6KinSGuSJGKYByxFgP
   WNBLq2utQFS2uwTHD3F4B0xIVAYMCvsMD+sGkogZxwwy/2ZVqduE94yCe
   QeXAl9TBq4U7EyicVCN2jAcym8IBd10wI7OtZL+ln9fFCPfrv+qpMO6Jl
   GZhvMhjFjKS5YLhk3AmOWadn/6eUV5gRgt0nLkkkHPeZsAOTRZyWo+SBn
   X1RkiTR+yvf2M9PMgj6WlnBiNyvBaNL0CDejQGObjrlREFAzmrhd2p1Ys
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634448"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634448"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173903"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173903"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:19 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: mvm: check firmware response size
Date:   Mon, 17 Apr 2023 11:41:33 +0300
Message-Id: <20230417113648.0d56fcaf68ee.I70e9571f3ed7263929b04f8fabad23c9b999e4ea@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417084134.1338976-1-gregory.greenman@intel.com>
References: <20230417084134.1338976-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Check the firmware response size for responses to the
memory read/write command in debugfs before using it.

Fixes: 2b55f43f8e47 ("iwlwifi: mvm: Add mem debugfs entry")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index affaed4d13fa..84a488538427 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1961,6 +1961,11 @@ static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 	if (ret < 0)
 		return ret;
 
+	if (iwl_rx_packet_payload_len(hcmd.resp_pkt) < sizeof(*rsp)) {
+		ret = -EIO;
+		goto out;
+	}
+
 	rsp = (void *)hcmd.resp_pkt->data;
 	if (le32_to_cpu(rsp->status) != DEBUG_MEM_STATUS_SUCCESS) {
 		ret = -ENXIO;
@@ -2037,6 +2042,11 @@ static ssize_t iwl_dbgfs_mem_write(struct file *file,
 	if (ret < 0)
 		return ret;
 
+	if (iwl_rx_packet_payload_len(hcmd.resp_pkt) < sizeof(*rsp)) {
+		ret = -EIO;
+		goto out;
+	}
+
 	rsp = (void *)hcmd.resp_pkt->data;
 	if (rsp->status != DEBUG_MEM_STATUS_SUCCESS) {
 		ret = -ENXIO;
-- 
2.38.1

