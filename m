Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF53D2209
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhGVJkd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 05:40:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38344 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhGVJkd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 05:40:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626949268; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=8LtPGJGunu592abx+3Vdgj3yMYEyAgHRF3rksHbKtnM=; b=qKilSXd2vV8G0vH80e66vSZ/k3XXsf4N+2Qc+3MdGRuRtFwpHwqmd1u0we69TAfwZWA7VFn6
 6wWv8TxkBpDiu3/q+E00fD7Y0+1uV56JvJoixAUBR4yCx7DFPWqe/TpLhgfrDtUFj52Q3B9Z
 nLtK8LypxZ7GvJBiShmKOGRSrhc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60f9468e96a66e66b2df2866 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 22 Jul 2021 10:21:02
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 142AFC4338A; Thu, 22 Jul 2021 10:21:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A9F9C4338A;
        Thu, 22 Jul 2021 10:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A9F9C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/3] ath11k: add channel 2 into 6 GHz channel list
Date:   Thu, 22 Jul 2021 13:20:52 +0300
Message-Id: <20210722102054.43419-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

Add support for the 6 GHz channel 2 with center frequency 5935 MHz and
operating class 136 per IEEE Std 802.11ax-2021, Table E-4.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h | 4 ++--
 drivers/net/wireless/ath/ath11k/mac.c  | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 79c52d28a3a2..d58ca38d78c7 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -381,9 +381,9 @@ struct ath11k_sta {
 };
 
 #define ATH11K_MIN_5G_FREQ 4150
-#define ATH11K_MIN_6G_FREQ 5945
+#define ATH11K_MIN_6G_FREQ 5925
 #define ATH11K_MAX_6G_FREQ 7115
-#define ATH11K_NUM_CHANS 100
+#define ATH11K_NUM_CHANS 101
 #define ATH11K_MAX_5G_CHAN 173
 
 enum ath11k_state {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 10a838563683..56120407bfdd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -150,6 +150,9 @@ static const struct ieee80211_channel ath11k_6ghz_channels[] = {
 	CHAN6G(225, 7075, 0),
 	CHAN6G(229, 7095, 0),
 	CHAN6G(233, 7115, 0),
+
+	/* new addition in IEEE Std 802.11ax-2021 */
+	CHAN6G(2, 5935, 0),
 };
 
 static struct ieee80211_rate ath11k_legacy_rates[] = {
-- 
2.25.1

