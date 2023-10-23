Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EB27D2ABA
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 08:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjJWGxL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 02:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWGxK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 02:53:10 -0400
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Oct 2023 23:53:08 PDT
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F79B0
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 23:53:08 -0700 (PDT)
Received: from localhost (unknown [124.16.138.129])
        by APP-01 (Coremail) with SMTP id qwCowAA3Px_iFTZl2bVyAA--.45S2;
        Mon, 23 Oct 2023 14:42:42 +0800 (CST)
From:   Chen Ni <nichen@iscas.ac.cn>
To:     gregory.greenman@intel.com, kvalo@kernel.org,
        johannes.berg@intel.com, mukesh.sisodiya@intel.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] wifi: iwlwifi: Add check for kmemdup
Date:   Mon, 23 Oct 2023 06:45:01 +0000
Message-Id: <20231023064501.274599-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAA3Px_iFTZl2bVyAA--.45S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF48Gw15tF1rJrW5tFW5KFg_yoWDXrgEkr
        1fGFn7A34jkr1j9r4UAFWIy34ay3s0gwna93s2q3yfArWDJ3yUXr95ZrnrAr4kGr4jvF97
        ArnxCFWfA3sxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK
        6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUeVyIUUUUU
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since the kmemdup may return NULL pointer,
it should be better to add check for the return value
in order to avoid NULL pointer dereference.

Fixes: 5e31b3df86ec ("wifi: iwlwifi: dbg: print pc register data once fw dump occurred")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 3d87d26845e7..9bba8fa62f54 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1307,6 +1307,8 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				tlv_len / sizeof(struct iwl_pc_data);
 			drv->trans->dbg.pc_data =
 				kmemdup(tlv_data, tlv_len, GFP_KERNEL);
+			if (!drv->trans->dbg.pc_data)
+				return -ENOMEM;
 			break;
 		default:
 			IWL_DEBUG_INFO(drv, "unknown TLV: %d\n", tlv_type);
-- 
2.25.1

