Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A423D6CEF28
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 18:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC2QUq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjC2QUp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 12:20:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F615BA
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 09:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EDC3B8237A
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 16:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A45BC433EF;
        Wed, 29 Mar 2023 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680106841;
        bh=vOk0cgYmlWsKP5u7OjDTcUC1HKBh/95816/u0sOAjso=;
        h=From:To:Cc:Subject:Date:From;
        b=clQU8xF6DNIhk2+760jsgMfW0RwLmNu5Jc3S/Yw2EYYrVzlIcM7mpbWr1tCV4ptmB
         +u4as1hB49NzaTQCj6uHu9956/KYzzkvJidMCwsIf6Jr0zYyS1CZxEC1PgTerwmBLt
         i9i2/pT6nzMeml4Nd+9feTGoVc+coW7cpoNVXeCjGCwqBjVKSAeRixIBz+zP7qRu/1
         /0z1wuVy7SC/O+Q5WZIapvycFhP3KfPZLgCpp4xR+Md/0RSnKWw1LKT9nDAiOdji+c
         57gwnOiVE+80Cq4wjluEFgyAlFjyNWanQhXpAIrWOSBNHzvkFHzLwhJC+HVRwJMFy5
         04et300/Pq8AA==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath11k: reduce the MHI timeout to 20s
Date:   Wed, 29 Mar 2023 19:20:38 +0300
Message-Id: <20230329162038.8637-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Currently ath11k breaks after hibernation, the reason being that ath11k expects
that the wireless device will have power during suspend and the firmware will
continue running. But of course during hibernation the power from the device is
cut off and firmware is not running when resuming, so ath11k will fail.

(The reason why ath11k needs the firmware running is the interaction between
mac80211 and MHI stack, it's a long story and more info in the bugzilla report.)

In SUSE kernels the watchdog timeout is reduced from the default 120 to 60 seconds:

CONFIG_DPM_WATCHDOG_TIMEOUT=60

But as the ath11k MHI timeout is 90 seconds the kernel will crash before will
ath11k will recover in resume callback. To avoid the crash reduce the MHI
timeout to just 20 seconds.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9

Link: https://bugzilla.kernel.org/show_bug.cgi?id=214649
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 86995e8dc913..a62ee05c5409 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -16,7 +16,7 @@
 #include "pci.h"
 #include "pcic.h"
 
-#define MHI_TIMEOUT_DEFAULT_MS	90000
+#define MHI_TIMEOUT_DEFAULT_MS	20000
 #define RDDM_DUMP_SIZE	0x420000
 
 static struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {

base-commit: bea046575a2e6d7d1cf63cc7ab032647a3585de5
-- 
2.30.2

