Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A350026E110
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 18:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgIQQrS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 12:47:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10257 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbgIQQqx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 12:46:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600361212; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=36Cv6e/C6O5ZBt/eAxSQurvRX73GutfYYFQ6Ejed8BY=; b=XjLGFUc3hKdwTeYhFZGYEXQv13+5mNRiqeUMk/wzFXtx8tnu2KTJ1urEcOSNLtoTHEaSwCvv
 4cIRN9NTxECbn0sQKNo0TcntBI2BltLncq5fFOz5cyRmYFKZYZcve8mw6cW+G+G3R5c9LzWJ
 /jzR//HfNEX5r5EdAfo6XNEcg30=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f6392eb6ace44cacc50580a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Sep 2020 16:46:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51FF2C433F1; Thu, 17 Sep 2020 16:46:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D6928C433C8;
        Thu, 17 Sep 2020 16:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D6928C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: remove redundant num_keep_alive_pattern assignment
Date:   Thu, 17 Sep 2020 19:46:30 +0300
Message-Id: <1600361190-22047-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There were two asignments to num_keep_alive_pattern, remove the first one which is wrong.

No functional changes. Compile tested only.

Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 5f2eb2032118..4d7d2dc691d2 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -74,7 +74,6 @@ static void ath11k_init_wmi_config_qca6390(struct ath11k_base *ab,
 	config->beacon_tx_offload_max_vdev = 0x2;
 	config->num_multicast_filter_entries = 0x20;
 	config->num_wow_filters = 0x16;
-	config->num_keep_alive_pattern = 0x1;
 	config->num_keep_alive_pattern = 0;
 }
 
-- 
2.7.4

