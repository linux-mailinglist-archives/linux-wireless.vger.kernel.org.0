Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3411E700F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 01:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437502AbgE1XKg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 19:10:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50003 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437480AbgE1XKc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 19:10:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590707432; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6+PG64eQ2LLIGbH6g81osVZVe+vs2+tcvwlNxHba5jI=; b=BF8lMfRaDQdMnjhPVDcp1jvPF5fKIcnmBj2W+1aIS0RrT4hGJ6IGSJbmAgWiFBPoYqDSiRzU
 xztk3HM3M1cwNG7hxyJpIRvNyTIsfku8UAYxZHg7ReogB7jSjv1yujXrnItKskFQe+GDTUws
 wv3/RZBWIxakobVMAcZEtiqRn/w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ed044df3ac6f4f6038df356 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 23:10:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 23EACC433CA; Thu, 28 May 2020 23:10:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7ABD8C433C6;
        Thu, 28 May 2020 23:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7ABD8C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=msinada@codeaurora.org
From:   Muna Sinada <msinada@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
Subject: [PATCH v2] ath11k: clear DCM max constellation tx value
Date:   Thu, 28 May 2020 16:10:17 -0700
Message-Id: <1590707417-29672-1-git-send-email-msinada@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to 11ax spec. draft 4.0. DCM Max Constellation Tx data
field should be set to "Reserved" for an AP, therefore bit is
cleared.

Signed-off-by: Muna Sinada <msinada@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1a7e5817e5c8..3b360c6a1f32 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3578,6 +3578,8 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 
 		switch (i) {
 		case NL80211_IFTYPE_AP:
+			he_cap_elem->phy_cap_info[3] &=
+				~IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_MASK;
 			he_cap_elem->phy_cap_info[9] |=
 				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
 			break;
-- 
2.7.4

