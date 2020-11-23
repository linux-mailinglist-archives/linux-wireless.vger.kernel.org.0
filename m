Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AF32BFECB
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Nov 2020 04:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgKWDqp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Nov 2020 22:46:45 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:10376 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgKWDqp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Nov 2020 22:46:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606103204; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=2VZv8daVnq0oG8xljIhIrKUEHUqWigF6pO69Dd4empI=; b=Ux6vttotYXuZi6lk/87q5yq0jGAuV3ZQMqxy4EEYhxZlQHCaE0XrF/wPk9xDpQ6PaM3eBGn7
 kgopXpgfLtkiHysHR+1fuHp+dgQ2pqKwPE6+tD23CpFFfHFzE/mcdPY20079jS1QJoBTA18Q
 YyUKeoDwbkDyEjT2B7wf5nvEgWI=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fbb3097e9b70886224ca342 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 03:46:31
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CB460C433C6; Mon, 23 Nov 2020 03:46:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37F69C43460;
        Mon, 23 Nov 2020 03:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37F69C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath10k: fix a check patch warning returnNonBoolInBooleanFunction of sdio.c
Date:   Mon, 23 Nov 2020 11:47:20 +0800
Message-Id: <1606103240-9868-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)
drivers/net/wireless/ath/ath10k/sdio.c:2234:2:
warning: Non-boolean value returned from function returning bool [returnNonBoolInBooleanFunction]
return param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW;

Reported-by: kernel test robot <rong.a.chen@intel.com>

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 2c619ef8a87c..14e2b7f585a5 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2237,7 +2237,7 @@ static bool ath10k_sdio_is_fast_dump_supported(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_SDIO, "sdio hi_option_flag2 %x\n", param);
 
-	return param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW;
+	return !!(param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW);
 }
 
 static void ath10k_sdio_dump_registers(struct ath10k *ar,
-- 
2.23.0

