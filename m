Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE6010A8EE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 03:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfK0C7a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 21:59:30 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:46768
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbfK0C7a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 21:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574823569;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=v95gBZ3VAsv1yFIp+edO6sWwlF1JTcZQtDQw10B41Xg=;
        b=jMDaFH471UUVzN39ul5BdypqDLEEeOjFaCD5xw8K4WLOAxRRDgNleO6wnopJEx9K
        1B3xcAR2SMuQDTuntsd0IZBXvpg26RNdzbazPab3OlCQJF+rfsAHeo/tNRRfW/OB7Fz
        UWrSkSw8YoNPlmevrNrq8Bg0dQy4QbKkkCsZ98XY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574823569;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=v95gBZ3VAsv1yFIp+edO6sWwlF1JTcZQtDQw10B41Xg=;
        b=CiSwneJ8DzTTbbsJq3Do3rkCpJejX2syrplLBnPP9/mTOe47Xdwp0u3r0yDQw/Ki
        KhJDUdX1kxtJS9b6m706yxV35Gb0kCLfjJP9JsZkLMlVpocGRVKMHHuahBHzL5YBXKG
        1jbJO/TUgtq2jhGKa1Wn9GZvr88mkfEtaxa5hNmo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B302C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: set max mtu to 1500 for sdio chip
Date:   Wed, 27 Nov 2019 02:59:29 +0000
Message-ID: <0101016eaacca72d-a73d6fb5-0e3f-4fbb-9045-8363270fe25f-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.27-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For sdio chip, the max credit size in firmware is 1556, the 1556
include payload, ieee80211 header, htt header, htc header. So it
need to set the max mtu to 1500 to forbidden TX packet which exceed
1500 form application.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 60849ab8088f..8aa8ebc1d8e9 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2185,6 +2185,8 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 	bus_params.chip_id = 0;
 	bus_params.hl_msdu_ids = true;
 
+	ar->hw->max_mtu = ETH_DATA_LEN;
+
 	ret = ath10k_core_register(ar, &bus_params);
 	if (ret) {
 		ath10k_err(ar, "failed to register driver core: %d\n", ret);
-- 
2.23.0

