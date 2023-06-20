Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113677368E0
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjFTKKe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjFTKKc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:10:32 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA1A3
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:10:28 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id 18E2A600DC;
        Tue, 20 Jun 2023 13:09:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id d9eIllrDZ0U0-P5L736Pz;
        Tue, 20 Jun 2023 13:09:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687255787;
        bh=HkCFXEEnrmStviwzT132w8G9XgVYgvZO3eEETWC5ipQ=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=KVuth/lCRErk4FPsqJuxEAuy6OZ+fRivkSS/1zCaqu4XarCGstj71mxwelX+1brLR
         26AJ1FslZw89VAVRK+wMOwh9Xws+ZLU5FpPXL5dc3Zj0kTS3qnZ/CMixOO25MLyqdZ
         6I+RtbVWfnQACHF0Drwe1NgXupimWxM7isdQRb7g=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] [v2] wifi: mwifiex: avoid strlcpy() and use strscpy() where appropriate
Date:   Tue, 20 Jun 2023 13:07:36 +0300
Message-ID: <20230620100803.519926-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prefer 'strscpy()' over unsafe 'strlcpy()' and 'strcpy()' in
'mwifiex_init_hw_fw()' and 'mwifiex_register_dev()', respectively.
All other calls to 'strcpy(adapter->name, ...)' should be safe
because the firmware name is a compile-time constant of known
length and so guaranteed to fit into a destination buffer.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 11 +++--------
 drivers/net/wireless/marvell/mwifiex/sdio.c |  4 +++-
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index ea22a08e6c08..64512b00e8b5 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -724,14 +724,9 @@ static int mwifiex_init_hw_fw(struct mwifiex_adapter *adapter,
 	/* Override default firmware with manufacturing one if
 	 * manufacturing mode is enabled
 	 */
-	if (mfg_mode) {
-		if (strlcpy(adapter->fw_name, MFG_FIRMWARE,
-			    sizeof(adapter->fw_name)) >=
-			    sizeof(adapter->fw_name)) {
-			pr_err("%s: fw_name too long!\n", __func__);
-			return -1;
-		}
-	}
+	if (mfg_mode)
+		strscpy(adapter->fw_name, MFG_FIRMWARE,
+			sizeof(adapter->fw_name));
 
 	if (req_fw_nowait) {
 		ret = request_firmware_nowait(THIS_MODULE, 1, adapter->fw_name,
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index a24bd40dd41a..a5d3128d7922 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -2483,7 +2483,9 @@ static int mwifiex_register_dev(struct mwifiex_adapter *adapter)
 		if ((val & card->reg->host_strap_mask) == card->reg->host_strap_value)
 			firmware = card->firmware_sdiouart;
 	}
-	strcpy(adapter->fw_name, firmware);
+	ret = strscpy(adapter->fw_name, firmware, sizeof(adapter->fw_name));
+	if (ret < 0)
+		return ret;
 
 	if (card->fw_dump_enh) {
 		adapter->mem_type_mapping_tbl = generic_mem_type_map;
-- 
2.41.0

