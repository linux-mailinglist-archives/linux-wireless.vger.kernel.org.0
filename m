Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591FB7D9155
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjJ0IYZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Oct 2023 04:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjJ0IYY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Oct 2023 04:24:24 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C6D4A
        for <linux-wireless@vger.kernel.org>; Fri, 27 Oct 2023 01:24:18 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:112b:0:640:c113:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 6C6C760A63;
        Fri, 27 Oct 2023 11:24:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id FOMODfGDeW20-2KZyRIKD;
        Fri, 27 Oct 2023 11:24:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698395056; bh=6e2Y33FImmTf0qn7VHbP3LsSLfAcPTpja1q7ddEwKJk=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=llN2U4SzGzpnXml93k5Z+dSiLUBqGUHKI0pwlmFQtEBXlka6smAdzA5MnXEYEQwPA
         vpIaSU88KGdLcLT+rDobo7aYV8Y2sPRDihlO1udgh7sGWfEGwEWBvLtiqUEg03QtL3
         rchbDETmdWzp44OkqP3f/J+NkYyKtRi2CyeRp0Dk=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath10k: prefer stack-allocated __le32 variables
Date:   Fri, 27 Oct 2023 11:23:21 +0300
Message-ID: <20231027082325.126606-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There isn't too much sense to 'kzalloc()' buffer for the only
__le32 value which is going to be freed in the same function,
so switch to stack-allocated one in 'ath10k_sdio_writesb32()'
and 'ath10k_sdio_diag_read32()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 47 +++++++-------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 56fbcfb80bf8..5ce1bad417cd 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -238,36 +238,25 @@ static int ath10k_sdio_write32(struct ath10k *ar, u32 addr, u32 val)
 	return ret;
 }
 
-static int ath10k_sdio_writesb32(struct ath10k *ar, u32 addr, u32 val)
+static int ath10k_sdio_writesb32(struct ath10k *ar, u32 addr, u32 value)
 {
 	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
 	struct sdio_func *func = ar_sdio->func;
-	__le32 *buf;
+	__le32 val = __cpu_to_le32(value);
 	int ret;
 
-	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	*buf = cpu_to_le32(val);
-
 	sdio_claim_host(func);
 
-	ret = sdio_writesb(func, addr, buf, sizeof(*buf));
-	if (ret) {
+	ret = sdio_writesb(func, addr, &val, sizeof(val));
+	if (ret)
 		ath10k_warn(ar, "failed to write value 0x%x to fixed sb address 0x%x: %d\n",
-			    val, addr, ret);
-		goto out;
-	}
-
-	ath10k_dbg(ar, ATH10K_DBG_SDIO, "sdio writesb32 addr 0x%x val 0x%x\n",
-		   addr, val);
+			    value, addr, ret);
+	else
+		ath10k_dbg(ar, ATH10K_DBG_SDIO, "sdio writesb32 addr 0x%x val 0x%x\n",
+			   addr, value);
 
-out:
 	sdio_release_host(func);
 
-	kfree(buf);
-
 	return ret;
 }
 
@@ -1758,24 +1747,14 @@ static int ath10k_sdio_hif_diag_read(struct ath10k *ar, u32 address, void *buf,
 	return ret;
 }
 
-static int ath10k_sdio_diag_read32(struct ath10k *ar, u32 address,
-				   u32 *value)
+static int ath10k_sdio_diag_read32(struct ath10k *ar, u32 address, u32 *value)
 {
-	__le32 *val;
+	__le32 val;
 	int ret;
 
-	val = kzalloc(sizeof(*val), GFP_KERNEL);
-	if (!val)
-		return -ENOMEM;
-
-	ret = ath10k_sdio_hif_diag_read(ar, address, val, sizeof(*val));
-	if (ret)
-		goto out;
-
-	*value = __le32_to_cpu(*val);
-
-out:
-	kfree(val);
+	ret = ath10k_sdio_hif_diag_read(ar, address, &val, sizeof(val));
+	if (!ret)
+		*value = __le32_to_cpu(val);
 
 	return ret;
 }
-- 
2.41.0

