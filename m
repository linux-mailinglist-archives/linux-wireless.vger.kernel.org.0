Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017F12437DF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 11:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMJrL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 05:47:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19556 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMJrK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 05:47:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597312030; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=eRZASBNixokv/44Lx7vvG92DmwvVc7bXULHxLMW9ml0=; b=sU5tXDDiXs8DD/OLb/lD0g1h6jLI6RE/jEIU0Jb1haiVgAeLptNN1X+4FIDGwIXyfLxc/ijX
 vaWpm2Vb3cMHpkdoSNQB/WODvPY8ANK+oFHoNQXwb8zNqBpyMyQ7JmAMJvOva5svLdZ/bM3O
 oRRKc6PlbCaPPjpagM9IN7sRwPE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f350c062f4952907de13d3b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 09:46:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E65A0C433C9; Thu, 13 Aug 2020 09:46:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9DE52C433C6;
        Thu, 13 Aug 2020 09:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DE52C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 3/3] ath10k: enable supports_peer_stats_info for QCA6174 PCI devices
Date:   Thu, 13 Aug 2020 17:47:09 +0800
Message-Id: <1597312029-32348-4-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597312029-32348-1-git-send-email-wgong@codeaurora.org>
References: <1597312029-32348-1-git-send-email-wgong@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When using QCA6174 PCI devices working in station mode, after connected
to AP, tx bitrate is always '1.0 MBit/s' in output of command 'iw wlan0
station dump'. (QCA6174 SDIO devices are working fine.)

After this patch, it show correct bitrate:

Station c4:04:15:5d:97:22 (on wls1)
        inactive time:  312 ms
        rx bytes:       31496
        rx packets:     173
        tx bytes:       8625
        tx packets:     46
        tx retries:     0
        tx failed:      0
        signal:         -76 [-88, -80] dBm
        signal avg:     -75 [-82, -77] dBm
        tx bitrate:     39.0 MBit/s MCS 4
        rx bitrate:     26.0 MBit/s MCS 3

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 22b6937ac225..c4f098c4431f 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -334,6 +334,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = true,
 		.tx_stats_over_pktlog = false,
+		.supports_peer_stats_info = true,
 	},
 	{
 		.id = QCA99X0_HW_2_0_DEV_VERSION,
-- 
2.23.0

