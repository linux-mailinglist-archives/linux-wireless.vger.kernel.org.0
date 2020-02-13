Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5347B15B991
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 07:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgBMG1y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 01:27:54 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:39606 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgBMG1y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 01:27:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581575273; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=WOciJxsbOtP7DrKFkMKDj7TwpDa2ZDD5O2ypu1OCZlQ=; b=BCAJ/COBZ7S5YDftcWdDaAjfimqID4W3mT5ohoHra+NT1rmSoaHTM+9zXKTi4grCVBiOa9Vb
 anu6eMfjcg83RVp4+giZo3EjpsjujSmKsjjTV8+B168f+ndWZHFPSvSC1eBfHcbf+tb9yQ78
 hYtOTnDgpZtX6ZNWGIUOc9Qbe6U=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e44ec62.7f964620cab0-smtp-out-n01;
 Thu, 13 Feb 2020 06:27:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3B931C43383; Thu, 13 Feb 2020 06:27:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from ybzhao-HP-Z230-SFF-Workstation.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yiboz)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3CE4C433A2;
        Thu, 13 Feb 2020 06:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3CE4C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=yiboz@codeaurora.org
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: [PATCH] Allow qca988x family to support ack rssi of tx data packets.
Date:   Thu, 13 Feb 2020 14:30:51 +0800
Message-Id: <1581575451-948-1-git-send-email-yiboz@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hardwares tested : QCA9887
Firmwares tested : 10.4-3.9.0.1-00036

Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/hw.c b/drivers/net/wireless/ath/ath10k/hw.c
index 2451e0f..57c58af 100644
--- a/drivers/net/wireless/ath/ath10k/hw.c
+++ b/drivers/net/wireless/ath/ath10k/hw.c
@@ -1131,6 +1131,7 @@ static int ath10k_get_htt_tx_data_rssi_pad(struct htt_resp *resp)
 
 const struct ath10k_hw_ops qca988x_ops = {
 	.set_coverage_class = ath10k_hw_qca988x_set_coverage_class,
+	.is_rssi_enable = ath10k_htt_tx_rssi_enable,
 };
 
 static int ath10k_qca99x0_rx_desc_get_l3_pad_bytes(struct htt_rx_desc *rxd)
-- 
1.9.1
