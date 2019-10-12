Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9739D5104
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 18:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfJLQ3k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 12:29:40 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48798 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729461AbfJLQ3j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 12:29:39 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJKGu-00062r-LF; Sat, 12 Oct 2019 19:29:37 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 19:29:20 +0300
Message-Id: <20191012192536.4ccda4b2f9c8.Ia7b2a13b07de0ae02c69de37cbbcd9b4aaa67d6e@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012162924.19848-1-luca@coelho.fi>
References: <20191012162924.19848-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 09/13] iwlwifi: dbg_ini: use vzalloc to allocate dumping memory regions
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

During dump flow, the driver allocates spaces to store the memory
regions that will be included in the dump. These regions can be very
large so in order to avoid allocation failure, use vzalloc instead.
The kmalloc uses GFP_KERNEL and the driver does not make any use of the
fact that the memory is contiguous so the same functionality is
maintained.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ce77ed17ede0..007a722cf1c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1846,7 +1846,7 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	if (!size)
 		return 0;
 
-	entry = kmalloc(sizeof(*entry) + sizeof(*tlv) + size, GFP_KERNEL);
+	entry = vzalloc(sizeof(*entry) + sizeof(*tlv) + size);
 	if (!entry)
 		return 0;
 
@@ -1892,7 +1892,7 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	return entry->size;
 
 out_err:
-	kfree(entry);
+	vfree(entry);
 
 	return 0;
 }
@@ -1914,7 +1914,7 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 		num_of_cfg_names++;
 	}
 
-	entry = kmalloc(sizeof(*entry) + size, GFP_KERNEL);
+	entry = vzalloc(sizeof(*entry) + size);
 	if (!entry)
 		return 0;
 
@@ -2121,7 +2121,7 @@ static u32 iwl_dump_ini_file_gen(struct iwl_fw_runtime *fwrt,
 	    !le64_to_cpu(trigger->regions_mask))
 		return 0;
 
-	entry = kmalloc(sizeof(*entry) + sizeof(*hdr), GFP_KERNEL);
+	entry = vzalloc(sizeof(*entry) + sizeof(*hdr));
 	if (!entry)
 		return 0;
 
@@ -2129,7 +2129,7 @@ static u32 iwl_dump_ini_file_gen(struct iwl_fw_runtime *fwrt,
 
 	size = iwl_dump_ini_trigger(fwrt, dump_data, list);
 	if (!size) {
-		kfree(entry);
+		vfree(entry);
 		return 0;
 	}
 
@@ -2195,7 +2195,7 @@ static void iwl_dump_ini_list_free(struct list_head *list)
 			list_entry(list->next, typeof(*entry), list);
 
 		list_del(&entry->list);
-		kfree(entry);
+		vfree(entry);
 	}
 }
 
-- 
2.23.0

