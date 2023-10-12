Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC9B7C6FDB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjJLN7B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 09:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379110AbjJLN67 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 09:58:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F10BB8
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 06:58:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AE2C433CA
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 13:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697119137;
        bh=cHOTseFbAfjWR5oKSR/XiH3SiuVSV0ZA/i/AQo2UWKk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XTKB8KRdJya0HkrLNc6OeuL+4cDjAJcmZQhyallaYrk4AFEwfeuGXGKChLSrkhrl5
         9xuqARy5zQIY0eKpwR6SsTMTVKbI9Nq4vE5QgkbF1rG8L+yhSSXiDLLehE15Fsq1Hx
         SNaL/3HE0lcmsN0ZWMXFCjGLGixzV1x3Hf/zyIBVgvROlA3wdZhDzLyjz7goYktQix
         415QQAcTfxakVdzLrQfG41gviuYFgYc7y/PcCs1+1arUj0zYd4+VttPr+ArvYc8+qP
         RxwLX1w6EZdTv546KwQLxAsJ1BaqYZT0ZU3RTd56mGYG8xh0NTx4QGm3bBVCLcl62z
         gnEvdSLRu3TaQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] wifi: ipw2x00: fix format-truncation warnings
Date:   Thu, 12 Oct 2023 16:58:53 +0300
Message-Id: <20231012135854.3473332-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012135854.3473332-1-kvalo@kernel.org>
References: <20231012135854.3473332-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On v6.6-rc4 with GCC 13.2 I see:

drivers/net/wireless/intel/ipw2x00/ipw2100.c:5905:63: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
drivers/net/wireless/intel/ipw2x00/ipw2100.c:5905:9: note: 'snprintf' output between 4 and 140 bytes into a destination of size 32
drivers/net/wireless/intel/ipw2x00/ipw2200.c:10392:63: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
drivers/net/wireless/intel/ipw2x00/ipw2200.c:10392:9: note: 'snprintf' output between 4 and 98 bytes into a destination of size 32

Fix this by copying only the firmware version and not providing any extra
information via ethtool. This is an ancient driver anyway and most likely
removed soon so it doesn't really matter.

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/intel/ipw2x00/ipw2100.c | 20 ++------------------
 drivers/net/wireless/intel/ipw2x00/ipw2200.c |  6 +-----
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 0812db8936f1..b6636002c7d2 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -317,8 +317,6 @@ static int ipw2100_get_firmware(struct ipw2100_priv *priv,
 				struct ipw2100_fw *fw);
 static int ipw2100_get_fwversion(struct ipw2100_priv *priv, char *buf,
 				 size_t max);
-static int ipw2100_get_ucodeversion(struct ipw2100_priv *priv, char *buf,
-				    size_t max);
 static void ipw2100_release_firmware(struct ipw2100_priv *priv,
 				     struct ipw2100_fw *fw);
 static int ipw2100_ucode_download(struct ipw2100_priv *priv,
@@ -5894,17 +5892,14 @@ static void ipw_ethtool_get_drvinfo(struct net_device *dev,
 				    struct ethtool_drvinfo *info)
 {
 	struct ipw2100_priv *priv = libipw_priv(dev);
-	char fw_ver[64], ucode_ver[64];
+	char fw_ver[64];
 
 	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
 	strscpy(info->version, DRV_VERSION, sizeof(info->version));
 
 	ipw2100_get_fwversion(priv, fw_ver, sizeof(fw_ver));
-	ipw2100_get_ucodeversion(priv, ucode_ver, sizeof(ucode_ver));
-
-	snprintf(info->fw_version, sizeof(info->fw_version), "%s:%d:%s",
-		 fw_ver, priv->eeprom_version, ucode_ver);
 
+	strscpy(info->fw_version, fw_ver, sizeof(info->fw_version));
 	strscpy(info->bus_info, pci_name(priv->pci_dev),
 		sizeof(info->bus_info));
 }
@@ -8406,17 +8401,6 @@ static int ipw2100_get_fwversion(struct ipw2100_priv *priv, char *buf,
 	return tmp;
 }
 
-static int ipw2100_get_ucodeversion(struct ipw2100_priv *priv, char *buf,
-				    size_t max)
-{
-	u32 ver;
-	u32 len = sizeof(ver);
-	/* microcode version is a 32 bit integer */
-	if (ipw2100_get_ordinal(priv, IPW_ORD_UCODE_VERSION, &ver, &len))
-		return -EIO;
-	return snprintf(buf, max, "%08X", ver);
-}
-
 /*
  * On exit, the firmware will have been freed from the fw list
  */
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 820100cac491..902a772f4649 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -10378,7 +10378,6 @@ static void ipw_ethtool_get_drvinfo(struct net_device *dev,
 {
 	struct ipw_priv *p = libipw_priv(dev);
 	char vers[64];
-	char date[32];
 	u32 len;
 
 	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
@@ -10386,11 +10385,8 @@ static void ipw_ethtool_get_drvinfo(struct net_device *dev,
 
 	len = sizeof(vers);
 	ipw_get_ordinal(p, IPW_ORD_STAT_FW_VERSION, vers, &len);
-	len = sizeof(date);
-	ipw_get_ordinal(p, IPW_ORD_STAT_FW_DATE, date, &len);
 
-	snprintf(info->fw_version, sizeof(info->fw_version), "%s (%s)",
-		 vers, date);
+	strscpy(info->fw_version, vers, sizeof(info->fw_version));
 	strscpy(info->bus_info, pci_name(p->pci_dev),
 		sizeof(info->bus_info));
 }
-- 
2.39.2

