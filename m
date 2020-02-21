Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 679BB167B5C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2020 11:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBUKvW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Feb 2020 05:51:22 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:40596 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgBUKvW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Feb 2020 05:51:22 -0500
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Feb 2020 05:51:17 EST
Received: from ubuntu.localdomain (unknown [183.131.110.113])
        by APP-01 (Coremail) with SMTP id qwCowACHrGI3tE9eWnK+BA--.21533S2;
        Fri, 21 Feb 2020 18:43:07 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     stf_xl@wp.pl, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iwlegacy: Remove unneeded variable ret
Date:   Fri, 21 Feb 2020 18:43:03 +0800
Message-Id: <20200221104303.3901-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowACHrGI3tE9eWnK+BA--.21533S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43KFW5GFWxXF1fAr4Dtwb_yoW8Xr4kpF
        4UurZFkw4YgF4DGaykAa9ayFs8Z3W7JrZrGa9akw1ruF9rJr1F9r40qFyYy3yF9rWDXF1a
        9F4jyrWfCrn8JrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUymb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
        IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bY0PhUUUUU=
X-Originating-IP: [183.131.110.113]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMNA1z4ixYqcgAEsk
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unneeded variable ret used to store return value.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 4 +---
 drivers/net/wireless/intel/iwlegacy/4965.c     | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 206b43b9dff8..9167c3d2711d 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -228,9 +228,7 @@ il3945_set_dynamic_key(struct il_priv *il, struct ieee80211_key_conf *keyconf,
 static int
 il3945_remove_static_key(struct il_priv *il)
 {
-	int ret = -EOPNOTSUPP;
-
-	return ret;
+	return -EOPNOTSUPP;
 }
 
 static int
diff --git a/drivers/net/wireless/intel/iwlegacy/4965.c b/drivers/net/wireless/intel/iwlegacy/4965.c
index 34d0579132ce..fc8fa5818de7 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965.c
@@ -416,7 +416,6 @@ il4965_set_ucode_ptrs(struct il_priv *il)
 {
 	dma_addr_t pinst;
 	dma_addr_t pdata;
-	int ret = 0;
 
 	/* bits 35:4 for 4965 */
 	pinst = il->ucode_code.p_addr >> 4;
@@ -433,7 +432,7 @@ il4965_set_ucode_ptrs(struct il_priv *il)
 		   il->ucode_code.len | BSM_DRAM_INST_LOAD);
 	D_INFO("Runtime uCode pointers are set.\n");
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.17.1

