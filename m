Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91E137ABD4
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 18:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhEKQYZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 12:24:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31550 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231812AbhEKQYV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 12:24:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620750195; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=TUpFo7fqbEDDZ7AMoUDruakSieCRFrnRHfwDZQngGPY=; b=uE/twga6knxifqrff5iDWbG88X1pazvYjuAYGk76mFF2RqVs5p/jqI01I8cF3l+OtgwjnOgH
 kl20Z0U8vuDLCAIsVOLvU+f5m01SZzjzZEFPtrV2GNWML3wxqK++s2UI/1g5lSHoyd16GKtv
 BJPsnSZCYOBnrERlB8NXYkrpFNE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 609aaf6eff1bb9beec18fd1c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 May 2021 16:23:10
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4E02C433D3; Tue, 11 May 2021 16:23:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-96-12-nat.elisa-mobile.fi [85.76.96.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3CD6C43145;
        Tue, 11 May 2021 16:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3CD6C43145
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 7/7] ath11k: don't call ath11k_pci_set_l1ss for WCN6855
Date:   Tue, 11 May 2021 19:22:14 +0300
Message-Id: <20210511162214.29475-8-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511162214.29475-1-jouni@codeaurora.org>
References: <20210511162214.29475-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

For QCA6390, one PCI related clock drifts sometimes, and it makes
PCI link difficult to quit L1ss. Current implementation fixed this
by configuring some related regs using ath11k_pci_fix_l1ss.

WCN6855 does not have this clock drift problem, so no need to set
these regs.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 5 +++++
 drivers/net/wireless/ath/ath11k/hw.h   | 1 +
 drivers/net/wireless/ath/ath11k/pci.c  | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index fd8941905fdb..4a1051418f33 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -70,6 +70,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.cold_boot_calib = true,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
+		.fix_l1ss = true,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -110,6 +111,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.cold_boot_calib = true,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
+		.fix_l1ss = true,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -149,6 +151,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.cold_boot_calib = false,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
+		.fix_l1ss = true,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -186,6 +189,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.cold_boot_calib = false,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
+		.fix_l1ss = true,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -225,6 +229,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.cold_boot_calib = false,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
+		.fix_l1ss = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index be62f0c2e25e..62f5978b3005 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -162,6 +162,7 @@ struct ath11k_hw_params {
 	bool cold_boot_calib;
 	bool supports_suspend;
 	u32 hal_desc_sz;
+	bool fix_l1ss;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index d33b5d66b494..9fe42194f488 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -434,7 +434,8 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
 		ath11k_pci_enable_ltssm(ab);
 		ath11k_pci_clear_all_intrs(ab);
 		ath11k_pci_set_wlaon_pwr_ctrl(ab);
-		ath11k_pci_fix_l1ss(ab);
+		if (ab->hw_params.fix_l1ss)
+			ath11k_pci_fix_l1ss(ab);
 	}
 
 	ath11k_mhi_clear_vector(ab);
-- 
2.25.1

