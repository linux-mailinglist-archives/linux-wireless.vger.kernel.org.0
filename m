Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825CA244549
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 09:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHNHLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 03:11:02 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:44859 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbgHNHKy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 03:10:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597389054; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=YRPm4zR+P0v0xHCVODnyRtWTfJ+LHwwTonokhghsx1g=; b=wVcw+VeK3i+Ys//QsEMCjhFUHA/sK59Yn4D0iuZ6Gv3TeHLm09yjC2mKWf4LwqqciCgGI2+J
 icOrrEKAT4mdY7x62XE2WlRbDXUSbgJRYIcbOdWwx17Fai9VPustZtuEu/MOrPW6A3/Pfced
 oXn/eh/VlLVC0kjD+i9B2bYTjYs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f3638f7668ab3fef6968f2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 07:10:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 777BFC433C6; Fri, 14 Aug 2020 07:10:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FA8EC433CA;
        Fri, 14 Aug 2020 07:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FA8EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 09/11] ath11k: fix KASAN warning of ath11k_qmi_wlanfw_wlan_cfg_send
Date:   Fri, 14 Aug 2020 10:10:28 +0300
Message-Id: <1597389030-13887-10-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
References: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

It's caused by reading memory out of boundary from target_ce_config_wlan.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 529886b1f068..12991a835b8b 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2233,7 +2233,7 @@ static int ath11k_qmi_wlanfw_wlan_cfg_send(struct ath11k_base *ab)
 	req->tgt_cfg_valid = 1;
 	/* This is number of CE configs */
 	req->tgt_cfg_len = ab->qmi.ce_cfg.tgt_ce_len;
-	for (pipe_num = 0; pipe_num <= req->tgt_cfg_len ; pipe_num++) {
+	for (pipe_num = 0; pipe_num < req->tgt_cfg_len ; pipe_num++) {
 		req->tgt_cfg[pipe_num].pipe_num = ce_cfg[pipe_num].pipenum;
 		req->tgt_cfg[pipe_num].pipe_dir = ce_cfg[pipe_num].pipedir;
 		req->tgt_cfg[pipe_num].nentries = ce_cfg[pipe_num].nentries;
-- 
2.7.4

