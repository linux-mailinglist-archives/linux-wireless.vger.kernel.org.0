Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7016310C6B2
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 11:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfK1Kaw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 05:30:52 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:60890
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbfK1Kav (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 05:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574937051;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=WyBvYeOgrJ1f6gqrgsynruyGZF1bUj8PVJH71NYxq60=;
        b=Hc4P2bonVVGSYyoR5UaPTLVvODWltAzvqtz3g4lBHh5JeVSBBYHALWtwpziyQWHG
        nVspd2H2q0aChNvT3y7d7JXfdt22nNkojNEY9QZqRWb/LAC8lKRtFioaB1mIiuNtQ/9
        8vmb8DP1yLrB1sU33tL/pANSwQ8Xjdb+OzVX3noM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574937051;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=WyBvYeOgrJ1f6gqrgsynruyGZF1bUj8PVJH71NYxq60=;
        b=SN6E7ZLkFnx1VwPwXyWwUqP7DHEUcOrduVwt+CrJXvezFjmUQE7a6zKp/WGt8cmD
        CGnOUFuEKu6IxtgA8Sr6LcND59cAzGDz1l+bhJ+/x3pbpnKUNuZfNs2FL5h/jsN2TRq
        FPulidt5P6ThkxAfFbc5bjdS92y1N0ckGlCqukyM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1AF7C4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v8 2/4] ath10k: change ATH10K_SDIO_BUS_REQUEST_MAX_NUM from 64 to 1024
Date:   Thu, 28 Nov 2019 10:30:51 +0000
Message-ID: <0101016eb1903f76-040bc7e3-4306-46d8-8bb2-06c8e76a9d13-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128103030.6429-1-wgong@codeaurora.org>
References: <20191128103030.6429-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.28-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

sdio bus bandwidth is low, sometimes for high performance TX test,
it will lack of ath10k_sdio_bus_request, it will print message:
ath10k_sdio mmc1:0001:1: unable to allocate bus request for async request

change the num from 64 to 1024 will not happen it.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/sdio.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.h b/drivers/net/wireless/ath/ath10k/sdio.h
index b8c7ac0330bd..556f67b0f89e 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.h
+++ b/drivers/net/wireless/ath/ath10k/sdio.h
@@ -37,7 +37,7 @@
 	(ATH10K_SDIO_MAX_BUFFER_SIZE - sizeof(struct ath10k_htc_hdr))
 
 #define ATH10K_HIF_MBOX_NUM_MAX                 4
-#define ATH10K_SDIO_BUS_REQUEST_MAX_NUM         64
+#define ATH10K_SDIO_BUS_REQUEST_MAX_NUM         1024
 
 #define ATH10K_SDIO_HIF_COMMUNICATION_TIMEOUT_HZ (100 * HZ)
 
@@ -98,6 +98,7 @@
 #define ATH10K_FIFO_TIMEOUT_AND_CHIP_CONTROL_DISABLE_SLEEP_OFF 0xFFFEFFFF
 #define ATH10K_FIFO_TIMEOUT_AND_CHIP_CONTROL_DISABLE_SLEEP_ON 0x10000
 
+/* TODO: remove this and use skb->cb instead, much cleaner approach */
 struct ath10k_sdio_bus_request {
 	struct list_head list;
 
-- 
2.23.0

