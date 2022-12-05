Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A38F6424BD
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 09:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiLEIgv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 03:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiLEIgh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 03:36:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA2717068
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 00:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229397; x=1701765397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m0SOCPKcLlxZ70kZelXgEFGapdM6Bkyb50dZt6Wfkeo=;
  b=ekFnU0Y2yIJ5SLGzbgN0pwR6yzdHDFw9D4LH/DnqfEUuOD2NB9btmHAj
   Tt8UvOerCE0vulFpcR6quyjunQxaG4Cl00yweR/VV4XrSewN+TvJLS9Kq
   j10N84buKsBM1/CdNQA9rhcFLjsI4mOJjBMLuwg2Ji5pLVQ0Mn8dke/BM
   uiH2Gfsk3JZZ5LwVVT5PR3w/kZgV0t9U7hwBHEXBQjJIEvFMRMGaYp3o3
   jw7AOh/HAj+5e7UVJIjJvKAN9tVt2aOqWxWHF2Rpsxldys68u3HLcWkts
   i52RG3crCXRKogaIitIeWqggYRW/WnCplIoOXeeHPERZ8p2JFD29oyx7f
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316323173"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316323173"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752100436"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="752100436"
Received: from eamit-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.181.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:31 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/11] wifi: iwlwifi: mei: clean up comments
Date:   Mon,  5 Dec 2022 10:35:45 +0200
Message-Id: <20221205102808.f1ff5aff270b.Ie4ba3f980a35455ed95e7c0cae854231fccc89e2@changeid>
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

From: Tom Rix <trix@redhat.com>

SPDX
*.h use /* */ style comments

Spelling replacements
commnunication to communication
adsress to address
procotol to protocol
addtional to additional
kown to know
negotiaion to negotiation
mssage to message

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h    |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mei/main.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/mei/sap.h        | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/mei/trace-data.h |  2 +-
 drivers/net/wireless/intel/iwlwifi/mei/trace.h      |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
index 2b639eef595d..ae66192feefe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2021 Intel Corporation
  */
@@ -13,7 +13,7 @@
 /**
  * DOC: Introduction
  *
- * iwlmei is the kernel module that is in charge of the commnunication between
+ * iwlmei is the kernel module that is in charge of the communication between
  * the iwlwifi driver and the CSME firmware's WLAN driver. This communication
  * uses the SAP protocol defined in another file.
  * iwlwifi can request or release ownership on the WiFi device through iwlmei.
@@ -348,7 +348,7 @@ void iwl_mei_set_rfkill_state(bool hw_rfkill, bool sw_rfkill);
 /**
  * iwl_mei_set_nic_info() - set mac address
  * @mac_address: mac address to set
- * @nvm_address: NVM mac adsress to set
+ * @nvm_address: NVM mac address to set
  *
  * This function must be called upon mac address change.
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index b89989b6399a..f9d11935ed97 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1963,7 +1963,7 @@ static int iwl_mei_probe(struct mei_cl_device *cldev,
 	iwl_mei_dbgfs_register(mei);
 
 	/*
-	 * We now have a Rx function in place, start the SAP procotol
+	 * We now have a Rx function in place, start the SAP protocol
 	 * we expect to get the SAP_ME_MSG_START_OK response later on.
 	 */
 	mutex_lock(&iwl_mei_mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/sap.h b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
index 6c0ad4adbf32..3b56637b9697 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/sap.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2021 - 2022 Intel Corporation
  */
@@ -25,7 +25,7 @@
  *
  * Since this messaging system cannot support high amounts of
  * traffic, iwlwifi and the CSME firmware's WLAN driver have an
- * addtional communication pipe to exchange information. The body
+ * additional communication pipe to exchange information. The body
  * of the message is copied to a shared area and the message that
  * goes over the ME interface just signals the other side
  * that a new message is waiting in the shared area. The ME
@@ -55,7 +55,7 @@
 /**
  * DOC: Host and driver state messages
  *
- * In order to let CSME konw about the host state and the host driver state,
+ * In order to let CSME know about the host state and the host driver state,
  * the host sends messages that let CSME know about the host's state.
  * When the host driver is loaded, the host sends %SAP_MSG_NOTIF_WIFIDR_UP.
  * When the host driver is unloaded, the host sends %SAP_MSG_NOTIF_WIFIDR_DOWN.
@@ -76,7 +76,7 @@
  * DOC: Ownership
  *
  * The device can be controlled either by the CSME firmware or
- * by the host driver: iwlwifi. There is a negotiaion between
+ * by the host driver: iwlwifi. There is a negotiation between
  * those two entities to determine who controls (or owns) the
  * device. Since the CSME can control the device even when the
  * OS is not working or even missing, the CSME can request the
@@ -136,7 +136,7 @@ enum iwl_sap_me_msg_id {
  * struct iwl_sap_me_msg_hdr - the header of the ME message
  * @type: the type of the message, see &enum iwl_sap_me_msg_id.
  * @seq_num: a sequence number used for debug only.
- * @len: the length of the mssage.
+ * @len: the length of the message.
  */
 struct iwl_sap_me_msg_hdr {
 	__le32 type;
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h b/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
index 83639c6225ca..15cb0bb4e9dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright(c) 2021        Intel Corporation
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/trace.h b/drivers/net/wireless/intel/iwlwifi/mei/trace.h
index 45ecb22ec84a..20ff836733bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/trace.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright(c) 2021        Intel Corporation
  */
-- 
2.35.3

