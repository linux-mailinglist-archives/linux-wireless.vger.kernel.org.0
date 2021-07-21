Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22E43D1404
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhGUPlX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 11:41:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49609 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234829AbhGUPlW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 11:41:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626884519; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=A6BZ3p6EYEjd7TuwKM8E0XBm/Q5zNJxBvboS6vabeFI=; b=p5iY0pRN/PD7A//TVcrG4UwLJ9gmCxLt96P8YT0ncIchTQ79Y+6Uo7Tqr7kpaDHNPrUIl4yX
 jG4iBm2E88LMCAot9GqtwgIq6cIVQBc57hp60pb/T392Ti0qaPqfH+ZNrvYGKUvAxPQHOf2K
 IKrKqyub39ub+UmWzBG5RGdj2Zk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60f8497eb653fbdadd2b8b1c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 16:21:18
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3354BC43217; Wed, 21 Jul 2021 16:21:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8ECBCC433F1;
        Wed, 21 Jul 2021 16:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8ECBCC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/3] ath11k: move static function ath11k_mac_vdev_setup_sync to top
Date:   Wed, 21 Jul 2021 19:20:51 +0300
Message-Id: <20210721162053.46290-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721162053.46290-1-jouni@codeaurora.org>
References: <20210721162053.46290-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

This is to prepare for monitor mode clean up.
No functional changes are done.

Co-developed-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: Miles Hu <milehu@codeaurora.org>
Co-developed-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 28 +++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e8da4af82221..3fd9a79801cb 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -731,6 +731,20 @@ static int ath11k_monitor_vdev_up(struct ath11k *ar, int vdev_id)
 	return 0;
 }
 
+static inline int ath11k_mac_vdev_setup_sync(struct ath11k *ar)
+{
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
+		return -ESHUTDOWN;
+
+	if (!wait_for_completion_timeout(&ar->vdev_setup_done,
+					 ATH11K_VDEV_SETUP_TIMEOUT_HZ))
+		return -ETIMEDOUT;
+
+	return ar->last_wmi_vdev_start_status ? -EINVAL : 0;
+}
+
 static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 {
 	/* mac80211 requires this op to be present and that's why
@@ -5165,20 +5179,6 @@ static void ath11k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 	mutex_unlock(&ar->conf_mutex);
 }
 
-static inline int ath11k_mac_vdev_setup_sync(struct ath11k *ar)
-{
-	lockdep_assert_held(&ar->conf_mutex);
-
-	if (test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
-		return -ESHUTDOWN;
-
-	if (!wait_for_completion_timeout(&ar->vdev_setup_done,
-					 ATH11K_VDEV_SETUP_TIMEOUT_HZ))
-		return -ETIMEDOUT;
-
-	return ar->last_wmi_vdev_start_status ? -EINVAL : 0;
-}
-
 static int
 ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 			      const struct cfg80211_chan_def *chandef,
-- 
2.25.1

