Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA48E277075
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 13:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgIXL6V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 07:58:21 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:18261 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbgIXL6U (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 07:58:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600948700; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=EhgEjHcYZNYBNeHV+1T0xrDSZhavD/WHGktUKZJrSNM=; b=iXR8vg0xRTbAv1vdANSrZGJom7jof390IGSC6hdGeb0R7fvDsXrYcA3TNvywz3Gjz2dLAfZy
 bsDuky4DqBHv2f/2a0GJlnIFc3lHKGfbbqbRD8MEYm61tFeMQ0kfmKLxebAeVyCcsnYyJYdv
 JBNNDk1857LFaQhrXFujwtwMKiU=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f6c89db31df7883e5d4f711 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 11:58:19
 GMT
Sender: govinds=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C9E95C433FE; Thu, 24 Sep 2020 11:58:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from dundi-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27C81C433CA;
        Thu, 24 Sep 2020 11:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27C81C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH] ath11k: Move non-fatal warn logs to dbg level
Date:   Thu, 24 Sep 2020 17:28:11 +0530
Message-Id: <1600948691-6901-1-git-send-email-govinds@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

During driver load below warn logs are printed in the console.
Since driver may not implement all wmi events sent by fw and
all of them are non-fatal, move this log to debug level to
remove un-necessary warn message on console.

[876.898735] ath11k_pci 0000:06:00.0: Unknown eventid: 0x16005
[879.283250] ath11k_pci 0000:06:00.0: Unknown eventid: 0x1d00a

No functional changes. Compile tested only.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index adde14a390ec..1e5a46bdaa61 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6579,7 +6579,7 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 		break;
 	/* TODO: Add remaining events */
 	default:
-		ath11k_warn(ab, "Unknown eventid: 0x%x\n", id);
+		ath11k_dbg(ab, ATH11K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
 		break;
 	}
 
-- 
2.22.0

