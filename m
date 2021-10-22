Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE9437FFD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 23:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhJVVoZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 17:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbhJVVoY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 17:44:24 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A78C061764
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 14:42:06 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Hbd965YhjzQjhm;
        Fri, 22 Oct 2021 23:42:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634938920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pB4rCsUZFuXDl0dMr5VB3KnHQZfsnI3rApDjB1j7HTQ=;
        b=nvsdK78G0l5r8xdkXMi6hwfqjbq3p0BCP4JSX6GH9rUAZB4cj0cQzk4wY/UnV3/nbuU4GT
        SRicTCaodHYqVHKX6q/+eRswYo6wSxSyWn6d7pbeMLN1ntyjePoDzmLQQIdYmNXV0Ar3RV
        dBCUPfAfR5AH/HDnlZJBsk/a5cgASR+WZGf7RTBGk0fuN+O+RrqPsW7PpN7k3elgWQYFU1
        qzqpPriBeLol+D9KjATN9v3lYnYEF0nA/7PGpzQwKWiQaKzz2sukMiFEAmws0qwjh/DlOL
        Xyt4IbGw5KGjBR+tZLT5VLyS9nc4Kh87bbAHufmreEsmUFur4h/DIpLqnguRkA==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, kvalo@codeaurora.org
Cc:     ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] mt76: Print error message when reading EEPROM from mtd failed
Date:   Fri, 22 Oct 2021 23:41:40 +0200
Message-Id: <20211022214140.1735488-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E81917FC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the EEPROM data is stored on a MTD partition print an error message
when reading this MTD partition failed. This is currently happening
often in OpenWrt because the initial data was written with using a flash
driver which ignores the error detection data and now OpenWrt uses a
driver which checks it.

With this patch a better error message is shown:
[    8.986988] mt7915e 0000:01:00.0: WA Firmware Version: DEV_000000, Build Time: 20201105222323
[    9.100508] mt7915e 0000:01:00.0: reading EEPROM from mtd factory failed: -117
[    9.144289] mt7915e: probe of 0000:01:00.0 failed with error -22

mt7915 does not work without an EEPROM, MT7922 still works.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

As an alternative we could also ignore the error EUCLEAN, which is 
printed when the error detection algorithm detected a problem.

 drivers/net/wireless/mediatek/mt76/eeprom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 3b47e85e95e7..05579588af04 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -54,8 +54,11 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 	offset = be32_to_cpup(list);
 	ret = mtd_read(mtd, offset, len, &retlen, eep);
 	put_mtd_device(mtd);
-	if (ret)
+	if (ret) {
+		dev_err(dev->dev, "reading EEPROM from mtd %s failed: %i\n",
+			part, ret);
 		goto out_put_node;
+	}
 
 	if (retlen < len) {
 		ret = -EINVAL;
-- 
2.30.2

