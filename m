Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A052B9675
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Nov 2020 16:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgKSPm5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 10:42:57 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:45322 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgKSPm5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 10:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1605800574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+pJRjlbwmSusjW1i62G5hcw7CWCCnniXgoMSu36jH24=;
        b=y90e2Q3AID+7QEajDTFJe8SbOJpXBINnIf5kxqmT9NsHgoik9Jigdod2ZL3TWjN7cH1PYb
        SoddlBN5H2VCbN9SQuGBujEv2HWw2Gv8bSqzeYjW4ZmN+vw10IPzsPmILLO8OfWq6eCOcb
        22EY0uDgwRI+YxbPMxWGwLzmJsCX9Gg=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v2 2/3] ath11k: Reset ath11k_skb_cb before setting new flags
Date:   Thu, 19 Nov 2020 16:42:33 +0100
Message-Id: <20201119154235.263250-2-sven@narfation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119154235.263250-1-sven@narfation.org>
References: <20201119154235.263250-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It was observed that the codepath for the ATH11K_SKB_HW_80211_ENCAP was
used even when the IEEE80211_TX_CTRL_HW_80211_ENCAP was not enabled for a
an skbuff. This became even more prominent when the QCAs wlan-open patchset
for ath11k [1] was applied and a sane looking fix just caused crashes when
injecting frames via a monitor interface (for example with ratechecker):

  [   86.963152] Unable to handle kernel NULL pointer dereference at virtual address 00000338
  [   86.963192] pgd = ffffffc0008f0000
  [   86.971034] [00000338] *pgd=0000000051706003, *pud=0000000051706003, *pmd=0000000051707003, *pte=00e800000b000707
  [   86.984292] Internal error: Oops: 96000006 [#1] PREEMPT SMP
  [...]
  [   87.713339] [<ffffffbffc802480>] ieee80211_tx_status_8023+0xf8/0x220 [mac80211]
  [   87.715654] [<ffffffbffc98bad4>] ath11k_dp_tx_completion_handler+0x42c/0xa10 [ath11k]
  [   87.722924] [<ffffffbffc989190>] ath11k_dp_service_srng+0x70/0x3c8 [ath11k]
  [   87.730831] [<ffffffbffca03460>] 0xffffffbffca03460
  [   87.737599] [<ffffffc00046ef58>] net_rx_action+0xf8/0x288
  [   87.742462] [<ffffffc000097554>] __do_softirq+0xfc/0x220
  [   87.748014] [<ffffffc000097900>] irq_exit+0x98/0xe8
  [   87.753396] [<ffffffc0000cf188>] __handle_domain_irq+0x90/0xb8
  [   87.757999] [<ffffffc000081ca4>] gic_handle_irq+0x6c/0xc8
  [   87.763899] Exception stack(0xffffffc00081bdc0 to 0xffffffc00081bef0)

Problem is that the state of ath11k_skb_cb->flags must be considered
unknown and could contain anything when it is not manually initialized. So
it could also contain ATH11K_SKB_HW_80211_ENCAP. And this can result in the
code to assume that the ath11k_skb_cb->vif is set - even when this is not
always the case for non ATH11K_SKB_HW_80211_ENCAP transmissions.

Tested-on: IPQ8074 hw2.0 WLAN.HK.2.4.0.1.r1-00026-QCAHKSWPL_SILICONZ-2

[1] https://source.codeaurora.org/quic/qsdk/oss/system/feeds/wlan-open/tree/mac80211/patches?h=NHSS.QSDK.11.4.r3
    (162 patches at the moment which are often not upstreamed but essential
     to get ath11k working)

Fixes: e7f33e0c52c0 ("ath11k: add tx hw 802.11 encapsulation offloading support")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
- nothing changed

 drivers/net/wireless/ath/ath11k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 05ed6ec99b55..591c4c57b61e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4057,6 +4057,7 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 	bool is_prb_rsp;
 	int ret;
 
+	memset(skb_cb, 0, sizeof(*skb_cb));
 	skb_cb->vif = vif;
 
 	if (key) {
-- 
2.29.2

