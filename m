Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68344D26A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 08:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhKKH0F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 02:26:05 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:57885 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhKKH0E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 02:26:04 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id l4QSmSYM1Bazol4QSmZB3p; Thu, 11 Nov 2021 08:23:15 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 11 Nov 2021 08:23:15 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     luciano.coelho@intel.com, kvalo@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org, rdunlap@infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iwlwifi: Fix memory leaks in error handling path
Date:   Thu, 11 Nov 2021 08:23:11 +0100
Message-Id: <1504cd7d842d13ddb8244e18004523128d5c9523.1636615284.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Should an error occur (invalid TLV len or memory allocation failure), the
memory already allocated in 'reduce_power_data' should be freed before
returning, otherwise it is leaking.

Fixes: 9dad325f9d57 ("iwlwifi: support loading the reduced power table from UEFI")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index c875bf35533c..009dd4be597b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -86,6 +86,7 @@ static void *iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 		if (len < tlv_len) {
 			IWL_ERR(trans, "invalid TLV len: %zd/%u\n",
 				len, tlv_len);
+			kfree(reduce_power_data);
 			reduce_power_data = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -105,6 +106,7 @@ static void *iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 				IWL_DEBUG_FW(trans,
 					     "Couldn't allocate (more) reduce_power_data\n");
 
+				kfree(reduce_power_data);
 				reduce_power_data = ERR_PTR(-ENOMEM);
 				goto out;
 			}
@@ -134,6 +136,10 @@ static void *iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 done:
 	if (!size) {
 		IWL_DEBUG_FW(trans, "Empty REDUCE_POWER, skipping.\n");
+		/* Better safe than sorry, but 'reduce_power_data' should
+		 * always be NULL if !size.
+		 */
+		kfree(reduce_power_data);
 		reduce_power_data = ERR_PTR(-ENOENT);
 		goto out;
 	}
-- 
2.30.2

