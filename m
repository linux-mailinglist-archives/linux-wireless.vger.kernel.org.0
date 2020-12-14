Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9B42D9DA1
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Dec 2020 18:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440359AbgLNR1N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Dec 2020 12:27:13 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:29393 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440355AbgLNR0K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Dec 2020 12:26:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607966746; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=gw4UYDYVd8rXEN5WrBVDDHwQk65wYFtywoPxnH0UgaM=; b=desfRJOwGlOwzoEWGbSCvnFMjVlj68MzWLij4eodVrIfRZTqSNKdwQdMZ4S92MbzSjOs11wB
 rGJqaDEWpLLw/u3fcrL4H1HXhq8mQqXT3PnA2B2m5XwNBjy/Ea9tQ5yPOCDIgOup2mDUCdTb
 pQTmiE9VpnqFoEPxjKPAWRtstO4=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fd79ff508cce5ad85dd5450 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Dec 2020 17:25:09
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6ECB8C43461; Mon, 14 Dec 2020 17:25:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-35-200-nat.elisa-mobile.fi [85.76.35.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BF6FC433C6;
        Mon, 14 Dec 2020 17:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BF6FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     ath9k-devel@qca.qualcomm.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/5] ath9k: Clear key cache explicitly on disabling hardware
Date:   Mon, 14 Dec 2020 19:21:15 +0200
Message-Id: <20201214172118.18100-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214172118.18100-1-jouni@codeaurora.org>
References: <20201214172118.18100-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Now that ath/key.c may not be explicitly clearing keys from the key
cache, clear all key cache entries when disabling hardware to make sure
no keys are left behind beyond this point.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath9k/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index caebe3fd6869..10b87aa1d289 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -894,6 +894,11 @@ static void ath9k_stop(struct ieee80211_hw *hw)
 
 	spin_unlock_bh(&sc->sc_pcu_lock);
 
+	/* Clear key cache entries explicitly to get rid of any potentially
+	 * remaining keys.
+	 */
+	ath9k_cmn_init_crypto(sc->sc_ah);
+
 	ath9k_ps_restore(sc);
 
 	sc->ps_idle = prev_idle;
-- 
2.20.1

