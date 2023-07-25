Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54180760A00
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 08:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjGYGF7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 02:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjGYGFu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 02:05:50 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E582E10EF
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 23:05:42 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:552b:0:640:471f:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id 908236002E;
        Tue, 25 Jul 2023 09:05:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id X5DgcxaDR0U0-ZW1Ckoco;
        Tue, 25 Jul 2023 09:05:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690265140;
        bh=+kUs6jYNNrH0dYj4cK1PorwrZ+KoiqdO7uKVdvyvceM=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Ve1UOw+KpwGDZ4ctTVuPcQ+jUyGGXHyEGc1O7y+zrG1HuVoW5Z2liAnlpE7+q4cMb
         2aa+7gw02wTenACTnXEuwU2U/ECoZKwLUDLQcEVzJ3wQ5EDd/7yFVYKtCnOSQq5UlK
         dyEYJoNTcPbWdWWycGLlGFERsvCAfJy04wrEva1k=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Dan Williams <dcbw@redhat.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 6/6] [v2] wifi: libertas: prefer kstrtoX() for simple integer conversions
Date:   Tue, 25 Jul 2023 09:04:48 +0300
Message-ID: <20230725060531.72968-6-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725060531.72968-1-dmantipov@yandex.ru>
References: <d7262341b0d3b635403f9d19ff2d381f7a543c2a.camel@redhat.com>
 <20230725060531.72968-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prefer 'kstrtoX()' family of functions over 'sscanf()' to convert
strings to integers and always check results of the conversions.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/libertas/mesh.c | 51 +++++++++++++-------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/mesh.c b/drivers/net/wireless/marvell/libertas/mesh.c
index 90ffe8d1e0e8..2dd635935448 100644
--- a/drivers/net/wireless/marvell/libertas/mesh.c
+++ b/drivers/net/wireless/marvell/libertas/mesh.c
@@ -188,8 +188,11 @@ static ssize_t anycast_mask_store(struct device *dev,
 	uint32_t datum;
 	int ret;
 
+	ret = kstrtouint(buf, 16, &datum);
+	if (ret)
+		return ret;
+
 	memset(&mesh_access, 0, sizeof(mesh_access));
-	sscanf(buf, "%x", &datum);
 	mesh_access.data[0] = cpu_to_le32(datum);
 
 	ret = lbs_mesh_access(priv, CMD_ACT_MESH_SET_ANYCAST, &mesh_access);
@@ -241,15 +244,14 @@ static ssize_t prb_rsp_limit_store(struct device *dev,
 	int ret;
 	unsigned long retry_limit;
 
-	memset(&mesh_access, 0, sizeof(mesh_access));
-	mesh_access.data[0] = cpu_to_le32(CMD_ACT_SET);
-
 	ret = kstrtoul(buf, 10, &retry_limit);
 	if (ret)
 		return ret;
 	if (retry_limit > 15)
 		return -ENOTSUPP;
 
+	memset(&mesh_access, 0, sizeof(mesh_access));
+	mesh_access.data[0] = cpu_to_le32(CMD_ACT_SET);
 	mesh_access.data[1] = cpu_to_le32(retry_limit);
 
 	ret = lbs_mesh_access(priv, CMD_ACT_MESH_SET_GET_PRB_RSP_LIMIT,
@@ -285,9 +287,12 @@ static ssize_t lbs_mesh_store(struct device *dev,
 			      const char *buf, size_t count)
 {
 	struct lbs_private *priv = to_net_dev(dev)->ml_priv;
-	int enable;
+	int ret, enable;
+
+	ret = kstrtoint(buf, 16, &enable);
+	if (ret)
+		return ret;
 
-	sscanf(buf, "%x", &enable);
 	enable = !!enable;
 	if (enable == !!priv->mesh_dev)
 		return count;
@@ -387,11 +392,13 @@ static ssize_t bootflag_store(struct device *dev, struct device_attribute *attr,
 	uint32_t datum;
 	int ret;
 
-	memset(&cmd, 0, sizeof(cmd));
-	ret = sscanf(buf, "%d", &datum);
-	if ((ret != 1) || (datum > 1))
+	ret = kstrtouint(buf, 10, &datum);
+	if (ret)
+		return ret;
+	if (datum > 1)
 		return -EINVAL;
 
+	memset(&cmd, 0, sizeof(cmd));
 	*((__le32 *)&cmd.data[0]) = cpu_to_le32(!!datum);
 	cmd.length = cpu_to_le16(sizeof(uint32_t));
 	ret = lbs_mesh_config_send(priv, &cmd, CMD_ACT_MESH_CONFIG_SET,
@@ -438,11 +445,14 @@ static ssize_t boottime_store(struct device *dev,
 	uint32_t datum;
 	int ret;
 
-	memset(&cmd, 0, sizeof(cmd));
-	ret = sscanf(buf, "%d", &datum);
-	if ((ret != 1) || (datum > 255))
+	ret = kstrtouint(buf, 10, &datum);
+	if (ret)
+		return ret;
+	if (datum > 255)
 		return -EINVAL;
 
+	memset(&cmd, 0, sizeof(cmd));
+
 	/* A too small boot time will result in the device booting into
 	 * standalone (no-host) mode before the host can take control of it,
 	 * so the change will be hard to revert.  This may be a desired
@@ -497,11 +507,13 @@ static ssize_t channel_store(struct device *dev, struct device_attribute *attr,
 	uint32_t datum;
 	int ret;
 
-	memset(&cmd, 0, sizeof(cmd));
-	ret = sscanf(buf, "%d", &datum);
-	if (ret != 1 || datum < 1 || datum > 11)
+	ret = kstrtouint(buf, 10, &datum);
+	if (ret)
+		return ret;
+	if (datum < 1 || datum > 11)
 		return -EINVAL;
 
+	memset(&cmd, 0, sizeof(cmd));
 	*((__le16 *)&cmd.data[0]) = cpu_to_le16(datum);
 	cmd.length = cpu_to_le16(sizeof(uint16_t));
 	ret = lbs_mesh_config_send(priv, &cmd, CMD_ACT_MESH_CONFIG_SET,
@@ -626,11 +638,14 @@ static ssize_t protocol_id_store(struct device *dev,
 	uint32_t datum;
 	int ret;
 
-	memset(&cmd, 0, sizeof(cmd));
-	ret = sscanf(buf, "%d", &datum);
-	if ((ret != 1) || (datum > 255))
+	ret = kstrtouint(buf, 10, &datum);
+	if (ret)
+		return ret;
+	if (datum > 255)
 		return -EINVAL;
 
+	memset(&cmd, 0, sizeof(cmd));
+
 	/* fetch all other Information Element parameters */
 	ret = mesh_get_default_parameters(dev, &defs);
 
-- 
2.41.0

