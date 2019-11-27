Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D198910B0E5
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 15:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfK0OJB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 09:09:01 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:45904
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726696AbfK0OJB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 09:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574863740;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=S0apdURwPBR2nrkCZDTjzubRjhMSXAjQxFXVfOWaBhA=;
        b=KajAqlnGzx6y9yF+LyrPjMToRFoD/DNFkXZ80lTKKN9oxFjnkssosePuS/d1LEge
        F2zRwMwF6/WFiZkG6kEunXzuVZitd300hhKIE4wertEcknasraHLQ4noJnbN5rxSZxL
        26SB3x+kTEZZEleGewH/tePvgxCqRLXB4g6ZMEJI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574863740;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=S0apdURwPBR2nrkCZDTjzubRjhMSXAjQxFXVfOWaBhA=;
        b=B7NaSOjJcuXPF8Xp3/0iGhlQuipGrqnFi1aq2zyTrlcJvCRQK6Y9N81aT8ZV/8xI
        KpQJDq/yQz01ltSSVyBq4XKyo4SHN1ERRKctXCi+FJsuMllqp6PdECjBNgfCw+Lju+x
        ZGgMQswTXVcdke+yMFXSLWJBEnt6nNXOm8zpqu54=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2481FC36E95
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 10/10] ath11k: add necessary peer assoc params in wmi dbg
Date:   Wed, 27 Nov 2019 14:09:00 +0000
Message-ID: <0101016ead319e31-7e6c3955-7d36-4e8f-8649-a3b2a9bf25d1-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
References: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.27-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sriram R <srirrama@codeaurora.org>

Add necessary peer assoc params in WMI debug message
while sending the peer assoc command to firmware
to aid in debugging.

Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index f349bf2c1ee8..b05642617b78 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1804,8 +1804,17 @@ int ath11k_wmi_send_peer_assoc_cmd(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI peer assoc vdev id %d assoc id %d peer mac %pM\n",
-		   param->vdev_id, param->peer_associd, param->peer_mac);
+		   "wmi peer assoc vdev id %d assoc id %d peer mac %pM peer_flags %x rate_caps %x peer_caps %x listen_intval %d ht_caps %x max_mpdu %d nss %d phymode %d peer_mpdu_density %d vht_caps %x he cap_info %x he ops %x he cap_info_ext %x he phy %x %x %x peer_bw_rxnss_override %x\n",
+		   cmd->vdev_id, cmd->peer_associd, param->peer_mac,
+		   cmd->peer_flags, cmd->peer_rate_caps, cmd->peer_caps,
+		   cmd->peer_listen_intval, cmd->peer_ht_caps,
+		   cmd->peer_max_mpdu, cmd->peer_nss, cmd->peer_phymode,
+		   cmd->peer_mpdu_density,
+		   cmd->peer_vht_caps, cmd->peer_he_cap_info,
+		   cmd->peer_he_ops, cmd->peer_he_cap_info_ext,
+		   cmd->peer_he_cap_phy[0], cmd->peer_he_cap_phy[1],
+		   cmd->peer_he_cap_phy[2],
+		   cmd->peer_bw_rxnss_override);
 
 	return ret;
 }
-- 
2.7.4

