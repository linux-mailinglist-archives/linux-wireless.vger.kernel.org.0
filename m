Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2022D12490C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 15:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfLROGE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 09:06:04 -0500
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:4869 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727108AbfLROGE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 09:06:04 -0500
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 18 Dec 2019 14:59:55 +0100
Received: from lx-merez2.mea.qualcomm.com ([10.18.173.102])
  by ironmsg03-ams.qualcomm.com with ESMTP; 18 Dec 2019 14:59:53 +0100
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Dedy Lansky <dlansky@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 5/8] wil6210: reduce ucode_debug memory region
Date:   Wed, 18 Dec 2019 15:59:44 +0200
Message-Id: <20191218135947.5903-6-merez@codeaurora.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218135947.5903-1-merez@codeaurora.org>
References: <20191218135947.5903-1-merez@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dedy Lansky <dlansky@codeaurora.org>

ucode_debug memory region defined as 4K bytes. Fix this according to
Talyn device memory map.

Signed-off-by: Dedy Lansky <dlansky@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 7a0d934eb271..3aca86b3071d 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -196,8 +196,8 @@ const struct fw_map talyn_mb_fw_mapping[] = {
 	{0x8c0000, 0x8c0210, 0x8c0000, "dum_user_rgf", true, true},
 	/* DMA OFU 296b */
 	{0x8c2000, 0x8c2128, 0x8c2000, "dma_ofu", true, true},
-	/* ucode debug 4k */
-	{0x8c3000, 0x8c4000, 0x8c3000, "ucode_debug", true, true},
+	/* ucode debug 256b */
+	{0x8c3000, 0x8c3100, 0x8c3000, "ucode_debug", true, true},
 	/* upper area 1536k */
 	{0x900000, 0xa80000, 0x900000, "upper", true, true},
 	/* UCODE areas - accessible by debugfs blobs but not by
-- 
2.23.0

