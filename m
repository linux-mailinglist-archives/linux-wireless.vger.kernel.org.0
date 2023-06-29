Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E017422AC
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 10:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjF2Iwm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 04:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjF2IwH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 04:52:07 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA32693
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 01:51:48 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:1d21:0:640:c9e4:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id C27FF60020;
        Thu, 29 Jun 2023 11:51:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ipIxcZ1DSeA0-ueLZJa0F;
        Thu, 29 Jun 2023 11:51:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688028705;
        bh=LDSwx6T2pybWuexKQ6K8L5O84LPiT9lRnVFusPQ+UX8=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=D0f9pC0QM426JxZHzVdXpfFuGL0lub0ZeMKxE0XVDAxQi2auCNFIl13iqjz7kxcTi
         Mq587XAbBB5IH8cAY/s9ZeiY7UiAGeRiRLHscnD/UgBLNhEy+4eN4o6kpKaYH/eQCz
         qnqJ8xgeVaBqNEO6VGmZyjMZoujGyLel0+GNHPAE=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/3] [v4] wifi: mwifiex: prefer strscpy() over strlcpy()
Date:   Thu, 29 Jun 2023 11:51:00 +0300
Message-ID: <20230629085115.180499-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prefer 'strscpy()' over 'strlcpy()' in 'mwifiex_init_hw_fw()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: simplify to drop strlcpy() only (Brian Norris)
---
 drivers/net/wireless/marvell/mwifiex/main.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

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
-- 
2.41.0

