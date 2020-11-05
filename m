Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A9E2A7887
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 09:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgKEIE7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 03:04:59 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:16748 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgKEIE6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 03:04:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604563498; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=2n04+8L1w2prXqMee5PbxAMQMSRpCI6DQrDnRNEzo5Y=; b=mVNSr/t0SANb3Qd4hpCaqyw8kMv0TqleHefZnsRDhKpoyOtseVfmqLNA1Q14quu87tal/xk6
 K7kfGlbHS3bzSKFhMlJ1OlGUEbAz9bI2k4CnRtZvCcLCyTBg5JA21clbNVl95VVuLIcRJpOO
 H9Atj3pPQPRzWtKaFNeuVmmL/AA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fa3b2299e7ab790f00caff1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 08:04:57
 GMT
Sender: lavaks=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E92F7C433C9; Thu,  5 Nov 2020 08:04:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from lavaks-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: lavaks)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9505C433C8;
        Thu,  5 Nov 2020 08:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9505C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=lavaks@codeaurora.org
From:   Lavanya Suresh <lavaks@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Lavanya Suresh <lavaks@codeaurora.org>
Subject: [PATCH] ath11k: Add new dfs region name for JP
Date:   Thu,  5 Nov 2020 13:34:35 +0530
Message-Id: <1604563475-5782-1-git-send-email-lavaks@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Japan has new Radar types as per latest regulatory,
included under MKK_N in FW. So adding new enum in
ath11k to support it.

Tested-on: IPQ8074 hw2.0 PCI WLAN.HK.2.4.0.1-00041-QCAHKSWPL_SILICONZ-1

Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/reg.c | 1 +
 drivers/net/wireless/ath/ath11k/reg.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index f6a1f03..4f178d8 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -277,6 +277,7 @@ ath11k_map_fw_dfs_region(enum ath11k_dfs_region dfs_region)
 	case ATH11K_DFS_REG_KR:
 		return NL80211_DFS_ETSI;
 	case ATH11K_DFS_REG_MKK:
+	case ATH11K_DFS_REG_MKK_N:
 		return NL80211_DFS_JP;
 	default:
 		return NL80211_DFS_UNSET;
diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
index 39b7fc9..65d56d4 100644
--- a/drivers/net/wireless/ath/ath11k/reg.h
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -20,6 +20,7 @@ enum ath11k_dfs_region {
 	ATH11K_DFS_REG_MKK,
 	ATH11K_DFS_REG_CN,
 	ATH11K_DFS_REG_KR,
+	ATH11K_DFS_REG_MKK_N,
 	ATH11K_DFS_REG_UNDEF,
 };
 
-- 
2.7.4

