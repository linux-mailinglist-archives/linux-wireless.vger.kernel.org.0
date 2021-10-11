Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA4C4286A7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 08:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhJKGNg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 02:13:36 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:54653 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhJKGNf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 02:13:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633932696; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=xhj5dxu+eDLVZQYYajqtKXXzXLf5dHufW15/ovtEr8A=; b=k0jNCSb46hs9dlVmLecZeiqVCANHWe+iyNFTEDF2e93P5mj/ARxayZz5j9b9ruu43au3h+ct
 pSDNnmCQEUdj+JoAbBkhJF6m2I9hp+YkQ5NyvQsR1cpuu0aNgsgZDseJX7hGj6tXUzXhQsjh
 0ONZm+bi3wnOi7R4+SFE57ZS+tU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6163d58eab9da96e6427bc62 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 06:11:26
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ECFE2C4360C; Mon, 11 Oct 2021 06:11:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from bqiang-Celadon-RN.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D672AC4338F;
        Mon, 11 Oct 2021 06:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D672AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Baochen Qiang <bqiang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: Identify DFS channel when sending scan channel list command
Date:   Mon, 11 Oct 2021 13:49:19 +0800
Message-Id: <20211011054919.77071-1-bqiang@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WMI_CHAN_INFO_DFS flag should be set when configuring a DFS channel
included in scan channel list. Without it, firmware will not send a
probe request frame which is needed in connection to an AP configured
with hidden SSID/network_id. So fix this to allow probe request frames
to be sent in cases where a beacon frame has been seen on the channel
first.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2d0acfb748cf..9781b69515dd 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2371,6 +2371,8 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
 				chan_info->info |= WMI_CHAN_INFO_QUARTER_RATE;
 			if (tchan_info->psc_channel)
 				chan_info->info |= WMI_CHAN_INFO_PSC;
+			if (tchan_info->dfs_set)
+				chan_info->info |= WMI_CHAN_INFO_DFS;
 
 			chan_info->info |= FIELD_PREP(WMI_CHAN_INFO_MODE,
 						      tchan_info->phy_mode);
-- 
2.25.1

