Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCFD11D379
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 18:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfLLROR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 12:14:17 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:50186 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbfLLROR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 12:14:17 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id BA15A13C283;
        Thu, 12 Dec 2019 09:14:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BA15A13C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576170856;
        bh=8pY1HIK3azgho2bzhpGrhM5tbAYHFJtFAzH+baIVhIs=;
        h=From:To:Cc:Subject:Date:From;
        b=NXY1HEWaU8dPlykutxnS1CVj7uoylNJGVLJLhkhY16+6T9DmRu22CR6zpmQnbItEd
         n2GnwiGtc29MJdki4911XyeZUjEOeeP+8UMWvV1/6ChykzqcuyR7C6GKjgYDe1hORi
         JfgNMy6+FowfloyGkqNeF+F5B9r7rsFtmRMiFx+U=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org, kvalo@qca.qualcomm.com,
        ath10k@lists.infradead.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] ath10k:  Fix setting txpower to zero.
Date:   Thu, 12 Dec 2019 09:14:09 -0800
Message-Id: <20191212171409.21041-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Do not ignore 0 txpower setting unless the vif is of type p2p.

This should fix regression in:

commit 88407beb1b1462f706a1950a355fd086e1c450b6
Author: Ryan Hsu <ryanhsu@qca.qualcomm.com>
Date:   Tue Dec 13 14:55:19 2016 -0800

    ath10k: fix incorrect txpower set by P2P_DEVICE interface

Tested (without p2p in use) on 9984 with ath10k-ct firmware, but I don't think
this is firmware specific.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 289d03da14b2..1c5e1b5570f8 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5902,11 +5902,18 @@ static int ath10k_mac_txpower_recalc(struct ath10k *ar)
 {
 	struct ath10k_vif *arvif;
 	int ret, txpower = -1;
+	int p2p_st;
+
+	p2p_st = ath10k_wmi_get_vdev_subtype(ar, WMI_VDEV_SUBTYPE_P2P_DEVICE);
 
 	lockdep_assert_held(&ar->conf_mutex);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
-		if (arvif->txpower <= 0)
+		/* p2p may not initialize txpower, and we should ignore it
+		 * in that case.
+		 */
+		if ((arvif->txpower < 0) ||
+		    ((arvif->txpower == 0) && (arvif->vdev_subtype == p2p_st)))
 			continue;
 
 		if (txpower == -1)
-- 
2.20.1

