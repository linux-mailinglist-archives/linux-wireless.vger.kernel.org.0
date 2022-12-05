Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE96424BF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 09:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiLEIgx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 03:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiLEIgj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 03:36:39 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF288167D5
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 00:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229398; x=1701765398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Bo8N8MZt9QrHd19vziMqepB+X0g7B3hFJ+RDzh5gVw=;
  b=hwKNJKE8PtuaDhEQy6woALtDf3puOvMNcyx87KX0DfjkG58eKlaun1oQ
   rtSuUDEvuuMPV1o7sF13XyvzC8NBAScN9bY6uXYawN+L3KeRwXOHMrZkc
   WbdD1N0uO7OnpV1/9FJMozqXMhJDFjpRAqGCg82Y49S9PffywkEftHQfj
   OqZ8hClDZoGYzOkzXrFAPr2vAn69ttMbCWjreykoSG3bidS4RzcyyEg1F
   Pq7RT/MUq531o1fojjnZDl8s5+QFOEJOSqkjzwqmpXVTcdH9kLs+lHGye
   nKABsybb2eiI/avXH9DtNKE7Fa1+QC3Uo7r83VqKKgjLgLcqdd2zMtLN6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316323196"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316323196"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752100450"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="752100450"
Received: from eamit-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.181.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:36 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/11] wifi: iwlwifi: dump: Update check for UMAC valid FW address
Date:   Mon,  5 Dec 2022 10:35:47 +0200
Message-Id: <20221205102808.e4b7fc650144.I46103baf400bb4ae69d82738e402a3903b17c030@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205083548.236620-1-gregory.greenman@intel.com>
References: <20221205083548.236620-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

The error dump base address check for UMAC
need an update based on current hardware.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 0a41cd0ab243..0c6b49fcb00d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -122,6 +122,9 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	u32 version = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
 					      UCODE_ALIVE_NTFY, 0);
 	u32 i;
+	struct iwl_trans *trans = mvm->trans;
+	enum iwl_device_family device_family = trans->trans_cfg->device_family;
+
 
 	if (version == 6) {
 		struct iwl_alive_ntf_v6 *palive;
@@ -230,7 +233,8 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 
 	if (umac_error_table) {
 		if (umac_error_table >=
-		    mvm->trans->cfg->min_umac_error_event_table) {
+		    mvm->trans->cfg->min_umac_error_event_table ||
+		    device_family >= IWL_DEVICE_FAMILY_BZ) {
 			iwl_fw_umac_set_alive_err_table(mvm->trans,
 							umac_error_table);
 		} else {
-- 
2.35.3

