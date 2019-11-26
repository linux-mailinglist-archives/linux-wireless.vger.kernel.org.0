Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3477C109CB6
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 12:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfKZLEu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 06:04:50 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:36996
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbfKZLEt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 06:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574766288;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=N0KFSViNp6dbv8JN49RBq/u51L+g0F6cC8pD7HsH63o=;
        b=WHFDta6y6EBM1ldPRHE1tZm5WWP5uggvCk7v1J8jiICy3LXHxCwkwydhSqxwx5hJ
        RMieYWqPghu5yxPSSGGcEUK6XeALAtD1P+awmm+/E2SRYa0DMebBzlfU4O9ogm4SLKT
        eZemZhwXTWv/1HWq4jvh9j3Ds6fuUrXTuTQ/vfC0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574766288;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=N0KFSViNp6dbv8JN49RBq/u51L+g0F6cC8pD7HsH63o=;
        b=LPgx+Xpj8wVCOaUor63tKcMjrOBb/o3+TcuCA+UZmVT6Hw8KY2bpn1zQf8ElfRLZ
        Uqem+8pzyljEDgWkYc/FGgEQj95ku1Egx+ZYDuqT0qeJ7sjBf2Cnd/uSiIHynleQrGw
        IOXUbhMWbn1Ps18jUC150TFC7I8EYKh1mXdvHH2w=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD4E3C447A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 03/10] ath11k: fix wmi service ready ext tlv parsing
Date:   Tue, 26 Nov 2019 11:04:48 +0000
Message-ID: <0101016ea7629e86-f417ea8d-3ed3-4794-aa02-5c21b621e022-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
References: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.26-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

The current ath11k driver failed to parse
wmi_tlv_svc_rdy_ext_parse if there is change in
wmi_mac_phy_capabilities length with below error.

ath11k c000000.wifi1: failed to extract mac caps, idx :0
ath11k c000000.wifi1: failed to parse tlv -22

This is needed to get firmware version
WLAN.HK.2.0.0.1-00240-QCAHKSWPL_SILICONZ-1 working.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 14 +++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.h |  1 -
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2c3c973f5f7c..ccebf7ce420a 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -310,7 +310,7 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
 	if (phy_id >= hal_reg_caps->num_phy)
 		return -EINVAL;
 
-	mac_phy_caps = &wmi_mac_phy_caps[phy_idx];
+	mac_phy_caps = wmi_mac_phy_caps + phy_idx;
 
 	pdev->pdev_id = mac_phy_caps->pdev_id;
 	pdev_cap->supported_bands = mac_phy_caps->supported_bands;
@@ -2959,6 +2959,15 @@ static int ath11k_wmi_tlv_mac_phy_caps_parse(struct ath11k_base *soc,
 	if (svc_rdy_ext->n_mac_phy_caps >= svc_rdy_ext->tot_phy_id)
 		return -ENOBUFS;
 
+	len = min_t(u16, len, sizeof(struct wmi_mac_phy_capabilities));
+	if (!svc_rdy_ext->n_mac_phy_caps) {
+		svc_rdy_ext->mac_phy_caps = kzalloc((svc_rdy_ext->tot_phy_id) * len,
+						    GFP_ATOMIC);
+		if (!svc_rdy_ext->mac_phy_caps)
+			return -ENOMEM;
+	}
+
+	memcpy(svc_rdy_ext->mac_phy_caps + svc_rdy_ext->n_mac_phy_caps, ptr, len);
 	svc_rdy_ext->n_mac_phy_caps++;
 	return 0;
 }
@@ -3092,8 +3101,6 @@ static int ath11k_wmi_tlv_svc_rdy_ext_parse(struct ath11k_base *ab,
 			svc_rdy_ext->hw_mode_done = true;
 		} else if (!svc_rdy_ext->mac_phy_done) {
 			svc_rdy_ext->n_mac_phy_caps = 0;
-			svc_rdy_ext->mac_phy_caps =
-					(struct wmi_mac_phy_capabilities *)ptr;
 			ret = ath11k_wmi_tlv_iter(ab, ptr, len,
 						  ath11k_wmi_tlv_mac_phy_caps_parse,
 						  svc_rdy_ext);
@@ -3134,6 +3141,7 @@ static int ath11k_service_ready_ext_event(struct ath11k_base *ab,
 		return ret;
 	}
 
+	kfree(svc_rdy_ext.mac_phy_caps);
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 7d5690c65279..6a0468094694 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2276,7 +2276,6 @@ struct wmi_hw_mode_capabilities {
 #define WMI_MAX_HECAP_PHY_SIZE                 (3)
 
 struct wmi_mac_phy_capabilities {
-	u32 tlv_header;
 	u32 hw_mode_id;
 	u32 pdev_id;
 	u32 phy_id;
-- 
2.7.4

