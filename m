Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5EDFF4948
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 13:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390392AbfKHLnQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 06:43:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390383AbfKHLnP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 06:43:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9712222CB;
        Fri,  8 Nov 2019 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213394;
        bh=UM+uiVXGrOUFsU4KqPI+fr6gwIOMvJUHAQ2n0jspCrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRo+40bz06aPtoCBcA/cj6CDBJstQHEamiPzyMfogAXyr/Tsf9mmF0S8UlEYxRlyC
         cIugfY0naJOd/ySEuG0Y2DakeJ58pA7b2LdggdNUDVB8k3vmgpSyUcGadyo+35d1LF
         o5vO3QCYvIr4a+9FFyaC0t4uuocg5upJHwK7eHPw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tamizh chelvam <tamizhr@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 003/103] ath10k: fix kernel panic by moving pci flush after napi_disable
Date:   Fri,  8 Nov 2019 06:41:28 -0500
Message-Id: <20191108114310.14363-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tamizh chelvam <tamizhr@codeaurora.org>

[ Upstream commit bd1d395070cca4f42a93e520b0597274789274a4 ]

When continuously running wifi up/down sequence, the napi poll
can be scheduled after the CE buffers being freed by ath10k_pci_flush

Steps:
  In a certain condition, during wifi down below scenario might occur.

ath10k_stop->ath10k_hif_stop->napi_schedule->ath10k_pci_flush->napi_poll(napi_synchronize).

In the above scenario, CE buffer entries will be freed up and become NULL in
ath10k_pci_flush. And the napi_poll has been invoked after the flush process
and it will try to get the skb from the CE buffer entry and perform some action on that.
Since the CE buffer already cleaned by pci flush this action will create NULL
pointer dereference and trigger below kernel panic.

Unable to handle kernel NULL pointer dereference at virtual address 0000005c
PC is at ath10k_pci_htt_rx_cb+0x64/0x3ec [ath10k_pci]
ath10k_pci_htt_rx_cb [ath10k_pci]
ath10k_ce_per_engine_service+0x74/0xc4 [ath10k_pci]
ath10k_ce_per_engine_service [ath10k_pci]
ath10k_ce_per_engine_service_any+0x74/0x80 [ath10k_pci]
ath10k_ce_per_engine_service_any [ath10k_pci]
ath10k_pci_napi_poll+0x48/0xec [ath10k_pci]
ath10k_pci_napi_poll [ath10k_pci]
net_rx_action+0xac/0x160
net_rx_action
__do_softirq+0xdc/0x208
__do_softirq
irq_exit+0x84/0xe0
irq_exit
__handle_domain_irq+0x80/0xa0
__handle_domain_irq
gic_handle_irq+0x38/0x5c
gic_handle_irq
__irq_usr+0x44/0x60

Tested on QCA4019 and firmware version 10.4.3.2.1.1-00010

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/ahb.c | 4 ++--
 drivers/net/wireless/ath/ath10k/pci.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index ff6815e956848..1404ec9f56be9 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -663,10 +663,10 @@ static void ath10k_ahb_hif_stop(struct ath10k *ar)
 	ath10k_ahb_irq_disable(ar);
 	synchronize_irq(ar_ahb->irq);
 
-	ath10k_pci_flush(ar);
-
 	napi_synchronize(&ar->napi);
 	napi_disable(&ar->napi);
+
+	ath10k_pci_flush(ar);
 }
 
 static int ath10k_ahb_hif_power_up(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index d790ea20b95d9..27ab3eb47534f 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1787,9 +1787,9 @@ static void ath10k_pci_hif_stop(struct ath10k *ar)
 
 	ath10k_pci_irq_disable(ar);
 	ath10k_pci_irq_sync(ar);
-	ath10k_pci_flush(ar);
 	napi_synchronize(&ar->napi);
 	napi_disable(&ar->napi);
+	ath10k_pci_flush(ar);
 
 	spin_lock_irqsave(&ar_pci->ps_lock, flags);
 	WARN_ON(ar_pci->ps_wake_refcount > 0);
-- 
2.20.1

