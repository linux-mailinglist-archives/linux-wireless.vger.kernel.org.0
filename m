Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26A57B6C8F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbjJCPBr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbjJCPBi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 11:01:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF561A1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 08:01:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42EFC433C8;
        Tue,  3 Oct 2023 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696345295;
        bh=lVcxIOxipF//JQsTO3JXp6HIOgSsOIh5C2sbfnSbzhw=;
        h=From:To:Cc:Subject:Date:From;
        b=CbosmV/bZL50DTPQD2iDFbm5HTNgTYuN+ab+ixJKEwcM+u+cR+KHKfBIeN9oEEgjf
         XA/6a1P/Uu1grtQofMTDJdoAQNlUxfi4iG27XZ311+OrDw58TG76/lSiqh4Cwkmjl/
         EXqZZuYp/tdGT/TZKdYNRfreKj08WhMr2kwNl5TcXxoPNxdmtM2GY7beJv8FZoB01L
         5Vb8F/lBuolgH1MIVNeejOtrxiwiVwywZfoUeoyQO3zNXX86aZ60RwUOJlj9r/rmgF
         R8ZrPkk2rQuTGYebnJfYec7QK+FGQq8q80KvIQ1IPsfJht4EXJ4Gwt+/pPliNoT+dO
         QsOt1idAOdg8Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fix debug messages
Date:   Tue,  3 Oct 2023 18:01:32 +0300
Message-Id: <20231003150132.187875-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

In ath12k the debug messages were broken, no matter setting what value to the
debug_mask module parameter would not get the debug messages printed. The issue
is that __ath12k_dbg() uses dev_dbg() to print the debug messages which requires either enabling
CONFIG_DYNAMIC_DEBUG or DEBUG symbol in the driver.

ath12k is supposed to use debug_mask module to control whether debug messages
are printed or not. Using both CONFIG_DYNAMIC_DEBUG and debug_mask parameter
does not make any sense so switch to using dev_printk(), just like ath11k does.
Now it's enough just to debug_mask module parameter to get the debug messages.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/debug.c b/drivers/net/wireless/ath/ath12k/debug.c
index 67893923e010..45d33279e665 100644
--- a/drivers/net/wireless/ath/ath12k/debug.c
+++ b/drivers/net/wireless/ath/ath12k/debug.c
@@ -64,7 +64,7 @@ void __ath12k_dbg(struct ath12k_base *ab, enum ath12k_debug_mask mask,
 	vaf.va = &args;
 
 	if (ath12k_debug_mask & mask)
-		dev_dbg(ab->dev, "%pV", &vaf);
+		dev_printk(KERN_DEBUG, ab->dev, "%pV", &vaf);
 
 	/* TODO: trace log */
 

base-commit: 140accd3f29eee6507f8a51bc38e85c119aedf14
-- 
2.39.2

