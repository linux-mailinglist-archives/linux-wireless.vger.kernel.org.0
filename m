Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906F459502
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 09:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfF1Hbr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 03:31:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfF1Hbr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 03:31:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8188660ACA; Fri, 28 Jun 2019 07:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561707106;
        bh=+9xyXiRYLpw9BcxZ6J8Eald2gfGG5pwOx3yOKjDlG2c=;
        h=From:To:Cc:Subject:Date:From;
        b=l0Ue87SaEui7QLMfCTfLA5CNBX0mNTbAPq3sR3rfS0bjTZ8xXehZcN80WyQUEmt1H
         eE1/HQeYdz9qAvoKkELGeqUoZ0S3cr7lazezr1Vs9RCn2ypwnJQ1XDPyD4uehwYzWF
         IfLScK690AwQxsbwraGjtVZONVQ/LHiE9E9T/FBs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from bpothuno-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bpothuno@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D64160A97;
        Fri, 28 Jun 2019 07:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561707106;
        bh=+9xyXiRYLpw9BcxZ6J8Eald2gfGG5pwOx3yOKjDlG2c=;
        h=From:To:Cc:Subject:Date:From;
        b=l0Ue87SaEui7QLMfCTfLA5CNBX0mNTbAPq3sR3rfS0bjTZ8xXehZcN80WyQUEmt1H
         eE1/HQeYdz9qAvoKkELGeqUoZ0S3cr7lazezr1Vs9RCn2ypwnJQ1XDPyD4uehwYzWF
         IfLScK690AwQxsbwraGjtVZONVQ/LHiE9E9T/FBs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D64160A97
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bpothuno@codeaurora.org
From:   Balaji Pothunoori <bpothuno@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Abhishek Ambure <aambure@codeaurora.org>,
        Balaji Pothunoori <bpothuno@codeaurora.org>
Subject: [PATCH] ath10k: check data ack rssi enabled/disabled in htt rx event
Date:   Fri, 28 Jun 2019 13:01:24 +0530
Message-Id: <1561707084-10021-1-git-send-email-bpothuno@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Abhishek Ambure <aambure@codeaurora.org>

For all data packets trasmmited, host gets htt tx completion event.

QCA9984 firmware gives data ack rssi values to host through
htt event of data tx completion. Data ack rssi values are valid
if A0 bit is set in HTT rx message.

Tested HW: QCA9984
Tested FW: 10.4-3.9.0.2-00044

Signed-off-by: Abhishek Ambure <aambure@codeaurora.org>
Signed-off-by: Balaji Pothunoori <bpothuno@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/hw.c b/drivers/net/wireless/ath/ath10k/hw.c
index ad082b7..303f17d 100644
--- a/drivers/net/wireless/ath/ath10k/hw.c
+++ b/drivers/net/wireless/ath/ath10k/hw.c
@@ -1145,6 +1145,7 @@ static bool ath10k_qca99x0_rx_desc_msdu_limit_error(struct htt_rx_desc *rxd)
 const struct ath10k_hw_ops qca99x0_ops = {
 	.rx_desc_get_l3_pad_bytes = ath10k_qca99x0_rx_desc_get_l3_pad_bytes,
 	.rx_desc_get_msdu_limit_error = ath10k_qca99x0_rx_desc_msdu_limit_error,
+	.is_rssi_enable = ath10k_htt_tx_rssi_enable,
 };
 
 const struct ath10k_hw_ops qca6174_ops = {
-- 
2.7.4

