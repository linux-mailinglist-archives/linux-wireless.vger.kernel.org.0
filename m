Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A672DC66C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 19:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgLPSZj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 13:25:39 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:16587 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbgLPSZM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608143087; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Hj7xYRgtW8e6QXy3Cy5jsBPL35QpdkLcNo6ILdYYOQc=; b=T8DjnU9bPp1j/33ro1FeK7f3s93g3wB6TYV8ieWYY09qTmWM10mcimUljevWU92JlOlbfv++
 tgow5cvz+vIXCgJiwJyaSk+zrSaSIYu9O0is/AiAioj1JiGKIU1ZeqZBX2Tc4Eyiq7dC+FjW
 NIGZmgi7AgBsE1QgRbpmu9ekQdk=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fda50d0065be8d835153163 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Dec 2020 18:24:16
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6EDCC433CA; Wed, 16 Dec 2020 18:24:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89863C433C6;
        Wed, 16 Dec 2020 18:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89863C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: pci: remove unnecessary mask in ath11k_pci_enable_ltssm()
Date:   Wed, 16 Dec 2020 20:24:11 +0200
Message-Id: <1608143051-5386-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

0x10 is a leftover and unnecessary, GCC_GCC_PCIE_HOT_RST_VAL is already defined
to 0x10.

No functional changes, compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 7024648c9e4f..1cda36e674fe 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -328,7 +328,7 @@ static void ath11k_pci_enable_ltssm(struct ath11k_base *ab)
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci ltssm 0x%x\n", val);
 
 	val = ath11k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST);
-	val |= GCC_GCC_PCIE_HOT_RST_VAL | 0x10;
+	val |= GCC_GCC_PCIE_HOT_RST_VAL;
 	ath11k_pci_write32(ab, GCC_GCC_PCIE_HOT_RST, val);
 	val = ath11k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST);
 
-- 
2.7.4

