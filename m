Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1359927E714
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgI3Kvb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 06:51:31 -0400
Received: from z5.mailgun.us ([104.130.96.5]:31626 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgI3KvX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 06:51:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601463082; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=1Xv8PF7NBi6kzHcF/odJ6y7zteTy8wRCCXQ3JfSmoGM=; b=wD+aFDwzsv2Gni18jXFy+CY4312sMpNQkNc/VZIhIT/Vc7unjz24THWL5YqjQqgM1EUwsdYf
 lPPiCFb3/nxKqvnqKxfUFSbGrbcg5aEVWG3os2C/NpiHnn6Vtjsst82nz1EafK/njD15J8eL
 RHHbSpjK2XGStL16Zc8LUm7hPOs=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f74632abe59ebabf3180ff2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 10:51:22
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 446AAC433CA; Wed, 30 Sep 2020 10:51:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E371DC433CA;
        Wed, 30 Sep 2020 10:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E371DC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/5] ath11k: pci: fix rmmod crash
Date:   Wed, 30 Sep 2020 13:51:10 +0300
Message-Id: <1601463073-12106-3-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601463073-12106-1-git-send-email-kvalo@codeaurora.org>
References: <1601463073-12106-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For QCA6390 we first need to call free_irq() and only then disable_msi(). Otherwise a
kernel BUG below will happen. Also free core, hal_srng and ce resources during
ath11k_pci_remove().

[ 1089.425506] ------------[ cut here ]------------
[ 1089.425510] kernel BUG at drivers/pci/msi.c:375!
[ 1089.425514] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
[ 1089.425517] CPU: 1 PID: 20539 Comm: rmmod Not tainted 5.9.0-rc5-wt-ath+ #198
[ 1089.425519] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0049.2018.0801.1601 08/01/2018
[ 1089.425523] RIP: 0010:free_msi_irqs+0x184/0x1b0
[ 1089.425526] Code: 14 85 c0 0f 84 cc fe ff ff 31 ed eb 0f 83 c5 01 39 6b 14 0f 86 bc fe ff ff 8b 7b 10 01 ef e8 c3 01 bf ff 48 83 78 70 00 74 e3 <0f> 0b 49 8d b5 b0 00 00 0
[ 1089.425528] RSP: 0018:ffffb128c0cf7dd0 EFLAGS: 00010282
[ 1089.425530] RAX: ffff947d67549000 RBX: ffff947cd2d25200 RCX: 0000000000000000
[ 1089.425532] RDX: ffff947d94a6f928 RSI: ffff947d94a6fa18 RDI: 0000000000000099
[ 1089.425533] RBP: 0000000000000000 R08: ffff947d67549000 R09: ffffffff86670050
[ 1089.425535] R10: 0000000000000000 R11: 0000000000000000 R12: ffff947d96c194f0
[ 1089.425537] R13: ffff947d96c19000 R14: 0000000000000000 R15: ffffffffc0225250
[ 1089.425539] FS:  00007f97c44ed700(0000) GS:ffff947d9c200000(0000) knlGS:0000000000000000
[ 1089.425541] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1089.425543] CR2: 00007f97c408d701 CR3: 0000000192bc0006 CR4: 00000000003706e0
[ 1089.425544] Call Trace:
[ 1089.425549]  ath11k_pci_remove+0x2b/0x90 [ath11k_pci]
[ 1089.425553]  pci_device_remove+0x36/0x90
[ 1089.425556]  __device_release_driver+0x16c/0x220
[ 1089.425559]  driver_detach+0xcf/0x110
[ 1089.425561]  bus_remove_driver+0x4d/0xa2
[ 1089.425564]  pci_unregister_driver+0x25/0xa0
[ 1089.425568]  __do_sys_delete_module+0x163/0x240
[ 1089.425571]  ? trace_hardirqs_on+0x1c/0x100
[ 1089.425575]  do_syscall_64+0x33/0x40
[ 1089.425577]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1089.425579] RIP: 0033:0x7f97c401d9e7
[ 1089.425581] Code: 73 01 c3 48 8b 0d b1 c4 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c
[ 1089.425583] RSP: 002b:00007fff1e0fb728 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[ 1089.425585] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f97c401d9e7
[ 1089.425587] RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005585aad022e8
[ 1089.425589] RBP: 00005585aad02280 R08: 0000000000000000 R09: 1999999999999999
[ 1089.425591] R10: 0000000000000883 R11: 0000000000000206 R12: 00007fff1e0fb940
[ 1089.425592] R13: 00007fff1e0fd917 R14: 0000000000000000 R15: 00005585aad02280
[ 1089.425596] Modules linked in: ath11k_pci(-) ath11k qmi_helpers qrtr_mhi mhi qrtr ns nvme nvme_core [last unloaded: mhi]
[ 1089.425603] ---[ end trace 2a81926cc0708a38 ]---

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index e76a8b61d037..69e5b7c57695 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -971,10 +971,17 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
+
+	ath11k_core_deinit(ab);
+
 	ath11k_mhi_unregister(ab_pci);
+
+	ath11k_pci_free_irq(ab);
 	ath11k_pci_disable_msi(ab_pci);
 	ath11k_pci_free_region(ab_pci);
-	ath11k_pci_free_irq(ab);
+
+	ath11k_hal_srng_deinit(ab);
+	ath11k_ce_free_pipes(ab);
 	ath11k_core_free(ab);
 }
 
-- 
2.7.4

