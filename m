Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067F266D4FF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 04:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjAQDde (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 22:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbjAQDdd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 22:33:33 -0500
X-Greylist: delayed 300 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Jan 2023 19:33:31 PST
Received: from aib29gb127.yyz1.oracleemaildelivery.com (aib29gb127.yyz1.oracleemaildelivery.com [192.29.72.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9971922DDC
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 19:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-2023;
 d=n8pjl.ca;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=cxpiFbfKTwfi/HQ21L22O5XuzZAHjqm8ye08lI1cAuQ=;
 b=dAcIK1B+1NqRtm2fYYOgHDrw+9raPT3P8xBJWj4Q7/7Wg4Ug6bJIKN6ZND1BSMydnrETtfZLSb09
   VDZ3LH4V59wwHp8nUuU7DRGBQAt58OxAF2xzVVC3z+ljIWMntJvQFmLPKoy0ef8pybJ2OURoll4u
   s/DMxIIqMQflTwJTpvd9KBshJ7HfApiO903neaHjySlDVrUUCuUcF58u+nOl8CG9fTOaStmIIVSW
   zX4l32icFGHtvorZw/VciLFgogvoO6wpMpnUJqS3eOxu6i67t402bNZK7MjU++l6DpJiZn2WPEa1
   QNhv/Gck8U9kQxYaZwbYxaLg/HQgMqLzsntavg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-yyz-20200204;
 d=yyz1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=cxpiFbfKTwfi/HQ21L22O5XuzZAHjqm8ye08lI1cAuQ=;
 b=KraK87MOgxiGIKGg7GsABjGSA72fuKVAoynvrvEf3tmN12aLv97FlwvD5V90GAU2Cxl6MHCmpUXs
   msELIJYUY380CDJE74Ni04ZNcZ7mK429+eRcl2SrSpsKK4IUk2Y9RfM8Wsfzx3+z3EAZb7BhR1fi
   jrFOeyO0nGBtF7pw109hpTaPNcUsLQ2lNZeL1qOL2Z+PWlzlvY1Fkef2SsPZyEV4ikGEw39vxuJp
   T79k+CGn/S4JSP/wTw9vWk6eioD48Pq1Os5YIGt04NYSMj57ekW0Lwn68Pe4WOTuhLRZL++XpGHe
   irSeB17Np8y/pXhyWQEEb/+Zpx62DfJupXWmRA==
Received: by omta-ad1-fd3-102-ca-toronto-1.omtaad1.vcndpyyz.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20221212 64bit (built Dec 12
 2022))
 with ESMTPS id <0ROM00MSK1NI8310@omta-ad1-fd3-102-ca-toronto-1.omtaad1.vcndpyyz.oraclevcn.com> for
 linux-wireless@vger.kernel.org; Tue, 17 Jan 2023 03:28:30 +0000 (GMT)
From:   Peter Lafreniere <peter@n8pjl.ca>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     peter@n8pjl.ca, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: rsi: Avoid defines prefixed with CONFIG
Date:   Mon, 16 Jan 2023 22:27:29 -0500
Message-id: <20230117032729.9578-1-peter@n8pjl.ca>
X-Mailer: git-send-email 2.39.0
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta: AAHiyYFu0MCxKBTa9Dl/SLLmtqNcWrAX7M4oL30YuiG0jhEemrrj8Isyt4Pz+FBl
 MNOofWk5sVY+4ISbEn5nsTpse/oJoQH6OH9XP6pes6Rt0D186h8WJ253nX5fq1KB
 5/TxIsZaYC0QqYTmhN6886HWFffEBger5daDBhWNj9wHM0gvwixSDRV+KuJG5Yrt
 sZ4F53807RnfQUoIAAYMDHQm4zu7h3OnFO6QR4rLQ+5XSHSe159YPIpi4ZAvSwGC
 A4CECoe7X8lNuGSVNt73ZSAtUuMIYvfOtpjKI6Lh4qp/P4wY8ztA0JifUXBTJPSy
 PXHEVCdDauOCdfnyx+tnYGKtyN1cYtXOxrqw+e7ivG1NnVwT9vD8wsQ/dx2zKW3f
 sBLSrGgNhdgXz2YDDPXALBDdT+Ec1joYJnv4AKytX5YIk3y/I2uK9rRgilzvrZhO Bw==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To avoid confusion, it is best to only define CONFIG_* macros in Kconfig
files. Here we change the name of one define, which causes no change to
functionality.

Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
---
 drivers/net/wireless/rsi/rsi_91x_hal.c | 4 ++--
 drivers/net/wireless/rsi/rsi_hal.h     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index c7460fbba014..d2e02d5da3c0 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -894,7 +894,7 @@ static int rsi_load_9113_firmware(struct rsi_hw *adapter)
 	struct ta_metadata *metadata_p;
 	int status;
 
-	status = bl_cmd(adapter, CONFIG_AUTO_READ_MODE, CMD_PASS,
+	status = bl_cmd(adapter, CONFIGURE_AUTO_READ_MODE, CMD_PASS,
 			"AUTO_READ_CMD");
 	if (status < 0)
 		return status;
@@ -984,7 +984,7 @@ static int rsi_load_9113_firmware(struct rsi_hw *adapter)
 	}
 	rsi_dbg(ERR_ZONE, "Firmware upgrade failed\n");
 
-	status = bl_cmd(adapter, CONFIG_AUTO_READ_MODE, CMD_PASS,
+	status = bl_cmd(adapter, CONFIGURE_AUTO_READ_MODE, CMD_PASS,
 			"AUTO_READ_MODE");
 	if (status)
 		goto fail;
diff --git a/drivers/net/wireless/rsi/rsi_hal.h b/drivers/net/wireless/rsi/rsi_hal.h
index 5b07262a9740..e1d9a4676f44 100644
--- a/drivers/net/wireless/rsi/rsi_hal.h
+++ b/drivers/net/wireless/rsi/rsi_hal.h
@@ -69,7 +69,7 @@
 #define EOF_REACHED			'E'
 #define CHECK_CRC			'K'
 #define POLLING_MODE			'P'
-#define CONFIG_AUTO_READ_MODE		'R'
+#define CONFIGURE_AUTO_READ_MODE	'R'
 #define JUMP_TO_ZERO_PC			'J'
 #define FW_LOADING_SUCCESSFUL		'S'
 #define LOADING_INITIATED		'1'
-- 
2.39.0

