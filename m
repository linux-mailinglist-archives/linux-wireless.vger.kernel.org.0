Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9A63D220A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhGVJke (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 05:40:34 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:20867 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhGVJkd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 05:40:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626949268; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=sEI8O3MRZYX32rujGHdALGWFcR20l7QSJ0dWH7WlTls=; b=FCVgh1MrjdLdpFRHbZWeGg4/zPwiuoIsZYSjg8ppEmEOxbcSnyhTn8k9WQExwntYf1C3IerN
 1MlntG7f+CXyDWMJJlEU3zBrh4ImXnNBstPeCdeOuKptdYQ/AlMbX2WG2v/H06jwaQWFB/MS
 W4R0dxx/tOKZ08epDCoqSkJz5xE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60f946934815712f3a2f8d9d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 22 Jul 2021 10:21:07
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A2B9C43460; Thu, 22 Jul 2021 10:21:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 730A5C433D3;
        Thu, 22 Jul 2021 10:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 730A5C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/3] ath11k: fix survey dump collection in 6 GHz
Date:   Thu, 22 Jul 2021 13:20:54 +0300
Message-Id: <20210722102054.43419-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722102054.43419-1-jouni@codeaurora.org>
References: <20210722102054.43419-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

When ath11k receives survey request, choose the 6 GHz band when enabled.
Without this, survey request does not include any 6 GHz band results,
thereby causing auto channel selection to fail.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01386-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 56120407bfdd..133ecb351365 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7073,7 +7073,13 @@ static int ath11k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 	if (!sband)
 		sband = hw->wiphy->bands[NL80211_BAND_5GHZ];
+	if (sband && idx >= sband->n_channels) {
+		idx -= sband->n_channels;
+		sband = NULL;
+	}
 
+	if (!sband)
+		sband = hw->wiphy->bands[NL80211_BAND_6GHZ];
 	if (!sband || idx >= sband->n_channels) {
 		ret = -ENOENT;
 		goto exit;
-- 
2.25.1

