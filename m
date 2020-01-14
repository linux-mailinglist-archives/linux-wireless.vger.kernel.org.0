Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8CD13B0D4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 18:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgANR1X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 12:27:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58560 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgANR1X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 12:27:23 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1irPyK-0007BN-CO; Tue, 14 Jan 2020 17:27:20 +0000
From:   Colin King <colin.king@canonical.com>
To:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: wilc1000: remove redundant assignment to variable result
Date:   Tue, 14 Jan 2020 17:27:20 +0000
Message-Id: <20200114172720.376286-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable result is being initialized with a value that
is never read and is being re-assigned later on. The assignment
is redundant and hence can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/wilc1000/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.c
index 55f8757325f0..8694ab5fcb22 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -733,7 +733,7 @@ static int spi_internal_read(struct wilc *wilc, u32 adr, u32 *data)
 static int wilc_spi_write_reg(struct wilc *wilc, u32 addr, u32 data)
 {
 	struct spi_device *spi = to_spi_device(wilc->dev);
-	int result = N_OK;
+	int result;
 	u8 cmd = CMD_SINGLE_WRITE;
 	u8 clockless = 0;
 
@@ -782,7 +782,7 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
 static int wilc_spi_read_reg(struct wilc *wilc, u32 addr, u32 *data)
 {
 	struct spi_device *spi = to_spi_device(wilc->dev);
-	int result = N_OK;
+	int result;
 	u8 cmd = CMD_SINGLE_READ;
 	u8 clockless = 0;
 
-- 
2.24.0

