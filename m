Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C3B7351C2
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 12:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjFSKQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 06:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFSKQ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 06:16:29 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91646CA
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 03:16:27 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5f1d:0:640:49bf:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id 6F10E46CE6;
        Mon, 19 Jun 2023 13:16:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EGdRuJjDVmI0-h31f5ji3;
        Mon, 19 Jun 2023 13:16:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687169785;
        bh=HkCFXEEnrmStviwzT132w8G9XgVYgvZO3eEETWC5ipQ=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=jyzgyKg8REpJLNFzxEv/a/OK7Q+kvefRa7v6KUdfrvgpyENfy48kal2aAxCwN+XnN
         s3XcmhuVVZmqQHwMPdIEdwESlnNK8D2LdAA0eeiT6hn2d/5Q0IKCDq5UaS5a55zIEt
         ZaSpvYNOND9V8MxIiH5nt4h3ObzaMcVvxQ7o3PDo=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mwifiex: avoid strlcpy() and use strscpy() where appropriate
Date:   Mon, 19 Jun 2023 13:15:43 +0300
Message-ID: <20230619101613.290001-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

