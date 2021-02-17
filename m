Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDBA31DF79
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Feb 2021 20:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhBQTR7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Feb 2021 14:17:59 -0500
Received: from z11.mailgun.us ([104.130.96.11]:35598 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhBQTRf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Feb 2021 14:17:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613589430; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+Uv8rzU3yyfu1nObMEb3ysJ1lA3TWYdg3pXEEeXsODg=; b=vIQX840HAmpa17Oa6+csFWgf3q+uoUkU1I/Q9CvTfGZebTgR2Uvzm9zTjet+Xh/Cf69kOiSo
 OXxm/Xj3h+oOPw1Muz3902/EhxwOkpTz2yKpuxpkGPVpSmBatG1grMKDBEqY0dtIP/aRlAHH
 uWzd4+yW/JhcNqqq25i91040lLE=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 602d6b9d3af8a93304cf0db4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 19:16:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 538C5C433CA; Wed, 17 Feb 2021 19:16:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1BD60C433CA;
        Wed, 17 Feb 2021 19:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BD60C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: print hardware name and version during initialisation
Date:   Wed, 17 Feb 2021 21:16:40 +0200
Message-Id: <1613589400-18891-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This way it's easy for the user to find what device is actually installed. This
also helps reporting bugs.

Screenshot:

[  459.988812] ath11k_pci 0000:06:00.0: BAR 0: assigned [mem 0xdb000000-0xdbffffff 64bit]
[  459.988867] ath11k_pci 0000:06:00.0: enabling device (0000 -> 0002)
[  459.997048] ath11k_pci 0000:06:00.0: qca6390 hw2.0
[  460.058093] mhi mhi0: Requested to power ON
[  460.059741] mhi mhi0: Power on setup success
[  460.476924] ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
[  460.477032] ath11k_pci 0000:06:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50 fw_build_id

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index ddedc331edef..77ce3347ab86 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1017,7 +1017,7 @@ static int ath11k_init_hw_params(struct ath11k_base *ab)
 
 	ab->hw_params = *hw_params;
 
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "Hardware name %s\n", ab->hw_params.name);
+	ath11k_info(ab, "%s\n", ab->hw_params.name);
 
 	return 0;
 }
-- 
2.7.4

