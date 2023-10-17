Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1AE7CC91E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 18:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjJQQw6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjJQQw5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 12:52:57 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF7E94
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 09:52:53 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:4081:0:640:557:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id 72D926003C;
        Tue, 17 Oct 2023 19:52:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id oqnsgf4DWKo0-o08kFiIX;
        Tue, 17 Oct 2023 19:52:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697561571; bh=T6nyfo4lr5eAPIp055bI9qRCQrUkqbAboL5RoBiZqn0=;
        h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
        b=c8hlZ0tx553umeKNd4hSyjMtHDAJATtfEW5fNXeukVGQd9naIBTeulLp66JKdw+11
         PGb0ubzw8TdtyjC2UjDA90prKKEskRtfDj/ZLv/iktESXreQ1lTEaXHWmQVJD+vzv1
         Wd8We+jFPbag9G9b0OTyj3ZgFe/LNqPHqG1+ylrM=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ipw2x00: fix -Wformat-truncation warnings
Date:   Tue, 17 Oct 2023 19:51:52 +0300
Message-ID: <20231017165215.143992-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <87fs2k5l1a.fsf@kernel.org>
References: <87fs2k5l1a.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following warnings observed with GCC 13.2 and -Wformat-truncation:

drivers/net/wireless/intel/ipw2x00/ipw2100.c: In function ‘ipw_ethtool_get_drvinfo’:
drivers/net/wireless/intel/ipw2x00/ipw2100.c:5905:63: warning: ‘%s’ directive output
may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
 5905 |         snprintf(info->fw_version, sizeof(info->fw_version), "%s:%d:%s",
      |                                                               ^~
 5906 |                  fw_ver, priv->eeprom_version, ucode_ver);
      |                  ~~~~~~
drivers/net/wireless/intel/ipw2x00/ipw2100.c:5905:9: note: ‘snprintf’ output between
4 and 140 bytes into a destination of size 32
 5905 |         snprintf(info->fw_version, sizeof(info->fw_version), "%s:%d:%s",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 5906 |                  fw_ver, priv->eeprom_version, ucode_ver);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For ipw2100, 'ipw2100_get_fwversion()' says that the firmware version
is no longer than 14 bytes, and 'ipw2100_get_ucodeversion()' uses "%08X"
so 10 bytes should be enough.

drivers/net/wireless/intel/ipw2x00/ipw2200.c: In function ‘ipw_ethtool_get_drvinfo’:
drivers/net/wireless/intel/ipw2x00/ipw2200.c:10392:63: warning: ‘%s’ directive output
may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
10392 |         snprintf(info->fw_version, sizeof(info->fw_version), "%s (%s)",
      |                                                               ^~
10393 |                  vers, date);
      |                  ~~~~
drivers/net/wireless/intel/ipw2x00/ipw2200.c:10392:9: note: ‘snprintf’ output between
4 and 98 bytes into a destination of size 32
10392 |         snprintf(info->fw_version, sizeof(info->fw_version), "%s (%s)",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
10393 |                  vers, date);
      |                  ~~~~~~~~~~~

For ipw2200, I assume that the firmware version is no longer than 14
bytes as well, and, according to ipw2100.h, firmware date is in
'mmm dd yyyy' format so 12 bytes should be enough.

Suggested-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/intel/ipw2x00/ipw2100.c | 2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 0812db8936f1..11b698255fe8 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -5894,7 +5894,7 @@ static void ipw_ethtool_get_drvinfo(struct net_device *dev,
 				    struct ethtool_drvinfo *info)
 {
 	struct ipw2100_priv *priv = libipw_priv(dev);
-	char fw_ver[64], ucode_ver[64];
+	char fw_ver[16], ucode_ver[10];
 
 	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
 	strscpy(info->version, DRV_VERSION, sizeof(info->version));
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 820100cac491..f9a539d2e93b 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -10377,8 +10377,8 @@ static void ipw_ethtool_get_drvinfo(struct net_device *dev,
 				    struct ethtool_drvinfo *info)
 {
 	struct ipw_priv *p = libipw_priv(dev);
-	char vers[64];
-	char date[32];
+	char vers[16];
+	char date[12];
 	u32 len;
 
 	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
-- 
2.41.0

