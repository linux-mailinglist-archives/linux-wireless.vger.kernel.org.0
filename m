Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5141972C6C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 12:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfGXKh6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 06:37:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36036 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfGXKh6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 06:37:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so20747398pfl.3
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2019 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QU1tJuVkhMSN47kAB/pTnlFwuoQ05qC+w6HgDQJKhBA=;
        b=nNTn/C/CWnIHmS2sqyuKO3fkrhF82+N96gXC9KgEuKKOKgf4vspJfFDRO2rjSBnoCQ
         2lc8I+HW+14VpcUn3dhD89idM8UBlhWvmVpvawtybMKx5KlX7UdRHHHV+ZSnK6PPUYq0
         pdL7s5TOlme+RtxWfw7RNZpN3H3kttZ1uprQkaEdWpXANj5NAFrcZ5Xj/HH+nzIoEhd7
         PY/0M9KdfbbGHuUwzQiylxKRzCrz4e3mBzHRakLc5aE6c+igeliY1F52v/xyNnOmLetS
         /9tkhSzfb1mdMGITTqMTLUNhdCdsQPCvhikQDsRL2477JLLP7C11juqyMv+GL6xXdP7+
         qweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QU1tJuVkhMSN47kAB/pTnlFwuoQ05qC+w6HgDQJKhBA=;
        b=MDNitHaZtxKwAIxF2fvSdZTQb0pILoka6PFa0PqZDdpDfn3qscCnFuczk5GA2F/G1+
         EflTpSdi+0UUQWEzRhv5XtsJ44/V9wPaIK69jRdKCJS6xCkgOns9N77SbqyfqLRzfAKc
         aGbut9eo8E+f+7bTuV2skZOaupFd1Lo8Azk33Ls8Qzyqd+cuBikYe80T4z6lCCz/GCRZ
         AoWXl0Wp40HybtTZBs9jwE3zXeBOTn33YPEclCj+8wwzdtlUC+2XE1d5BANVzxVdqW+R
         0seGPHDvW/u52tRRewO24+EBF/kdxkRz8xSzbBsa9VomEfPDDjbAcL37gJ+jEzPH+Ufb
         oxtw==
X-Gm-Message-State: APjAAAXL/LgMS9HF9R2mrzfFLCNH+L020AnkLyOISd5M9mOtk3BIcq0z
        BS0QVeP6b5ByF9cPR+2uezBQcb2SJeieaQ==
X-Google-Smtp-Source: APXvYqzGICfUkd0BuIynXsxHlNTDsMRS04CjJmPcVva3sqTQsGATV33SB/8eMkC+AopJN1fo4O1C3w==
X-Received: by 2002:a63:1:: with SMTP id 1mr16391504pga.162.1563964677446;
        Wed, 24 Jul 2019 03:37:57 -0700 (PDT)
Received: from cpu508.localdomain ([183.82.100.30])
        by smtp.gmail.com with ESMTPSA id l6sm45639818pga.72.2019.07.24.03.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 03:37:56 -0700 (PDT)
From:   ganapathirajukondraju@gmail.com
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Rishikesh Basu <rishikesh.basu@redpinesignals.com>,
        ganapathi.kondraju@redpinesignals.com,
        krishna.pedda@redpinesignals.com, narasimha.a@redpinesignals.com,
        Ganapathi Kondraju <ganapathirajukondraju@gmail.com>
Subject: [PATCH] rsi: fix for sdio interface setup in 9116
Date:   Wed, 24 Jul 2019 16:07:21 +0530
Message-Id: <1563964641-9413-1-git-send-email-ganapathirajukondraju@gmail.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ganapathi Kondraju <ganapathirajukondraju@gmail.com>

Issue: RS-9116 Card is not responding after firmware got loaded.

Root cause: After firmware got loaded, we need to reset the program
counter and few device specific registers. Those registers were not
resetted properly.

Fix: Properly resetting those registers.

Signed-off-by: Ganapathi Kondraju <ganapathirajukondraju@gmail.com>
---
 drivers/net/wireless/rsi/rsi_91x_sdio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index b42cd50..1ab2bd2 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -944,7 +944,7 @@ static int rsi_sdio_ta_reset(struct rsi_hw *adapter)
 	put_unaligned_le32(TA_HOLD_THREAD_VALUE, data);
 	addr = TA_HOLD_THREAD_REG | RSI_SD_REQUEST_MASTER;
 	status = rsi_sdio_write_register_multiple(adapter, addr,
-						  (u8 *)&data,
+						  (u8 *)data,
 						  RSI_9116_REG_SIZE);
 	if (status < 0) {
 		rsi_dbg(ERR_ZONE, "Unable to hold TA threads\n");
@@ -954,7 +954,7 @@ static int rsi_sdio_ta_reset(struct rsi_hw *adapter)
 	put_unaligned_le32(TA_SOFT_RST_CLR, data);
 	addr = TA_SOFT_RESET_REG | RSI_SD_REQUEST_MASTER;
 	status = rsi_sdio_write_register_multiple(adapter, addr,
-						  (u8 *)&data,
+						  (u8 *)data,
 						  RSI_9116_REG_SIZE);
 	if (status < 0) {
 		rsi_dbg(ERR_ZONE, "Unable to get TA out of reset\n");
@@ -964,7 +964,7 @@ static int rsi_sdio_ta_reset(struct rsi_hw *adapter)
 	put_unaligned_le32(TA_PC_ZERO, data);
 	addr = TA_TH0_PC_REG | RSI_SD_REQUEST_MASTER;
 	status = rsi_sdio_write_register_multiple(adapter, addr,
-						  (u8 *)&data,
+						  (u8 *)data,
 						  RSI_9116_REG_SIZE);
 	if (status < 0) {
 		rsi_dbg(ERR_ZONE, "Unable to Reset TA PC value\n");
@@ -975,7 +975,7 @@ static int rsi_sdio_ta_reset(struct rsi_hw *adapter)
 	put_unaligned_le32(TA_RELEASE_THREAD_VALUE, data);
 	addr = TA_RELEASE_THREAD_REG | RSI_SD_REQUEST_MASTER;
 	status = rsi_sdio_write_register_multiple(adapter, addr,
-						  (u8 *)&data,
+						  (u8 *)data,
 						  RSI_9116_REG_SIZE);
 	if (status < 0) {
 		rsi_dbg(ERR_ZONE, "Unable to release TA threads\n");
-- 
2.5.5

