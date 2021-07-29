Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8C13DA165
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 12:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhG2Kmx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 06:42:53 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:48052
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235679AbhG2Kmw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 06:42:52 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 910873F10E
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 10:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555368;
        bh=1aqWonZ1UVeYrgP40WWguDTIwwMWBTXMW2a73Xqk2/I=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fTaOL6yTA1N+j0b4PUpgzWYos85Rpw0HlW0/TgjfeqewNixyjGNfObfDbsVVve1bV
         yydbMj9K5Ccic8BYEPXdTA4fkQWUWx7oJkgK/ZE65F4lEb/LuC3WVjJmC1AffOmwA1
         sGu1k8b6HYE9IzZyrbjGgGc+UubqOQ2+eXU6evx/KPw39ESOd7+97h8+GRCB06Mrl7
         +igO0k3WafwE2vQOrr3evhhnc/jFz2vKZ4rOP/1zt5kbkapY8/rZSQ3V7pAeoLDpbz
         Wz7HRQtEPwtjuNJStAMXPRCC/E2OFNve8/u1A5YWbdQJm8IQeyp/KlLsZmT8d9XkZS
         vHHNwVaZWX8vA==
Received: by mail-ej1-f70.google.com with SMTP id lu19-20020a170906fad3b029058768348f55so1849132ejb.12
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 03:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1aqWonZ1UVeYrgP40WWguDTIwwMWBTXMW2a73Xqk2/I=;
        b=SphBuCpLUHgtr4jst1tql7TielPtwS14rYct9KmpdTa/J4bOGjpDIQ9ggfa0F9hEI+
         XZSl1tiz7TEL+a0JH0Bk2vvsWMnjXmu9jrVeNgpiJP/yylqitjzhENVbmQEtyCY6Zo1R
         bYN4xq9jdhg5tNKyxE0yPoBf4ssteLqBmVd79qGysiQy2MoWZH/en+DniBaZ7edK7PbA
         GfhnLgqic3F48Cv7lRhlcjvJZ5evKArF+i2IAiob6MYbNG2IiIop2Zo/g6rw+Dey16eF
         coax6wF/3jGgBgPAXCqHRHBnwoqE9cFmvJSJVYL6Kuajp0pKJcJb0PBwinWLBygXB/eT
         /Gmg==
X-Gm-Message-State: AOAM532MGzzc9R/YFMK2McTium8F3mStQ+Xrhs3p1tMUwDWBTZNC/3l1
        UBUUb5c+QibWvbqyxfXwe0ejDQw3pMSSNCmdQHsoMVqupj9HdgiWA32smI2cGyDPvBt+oK5+M19
        hiukDWHocXk5mnXFApg+HjjEs6oofDo309bzNyXuiGpYC
X-Received: by 2002:a17:907:1b02:: with SMTP id mp2mr4104322ejc.196.1627555368311;
        Thu, 29 Jul 2021 03:42:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7aV8dzqZZfnsgycbu2nLiwhd9HngRE7rGbZygUqpYd4zH2xG3lNFXnZlVjoxsJ3E/BKLvUA==
X-Received: by 2002:a17:907:1b02:: with SMTP id mp2mr4104308ejc.196.1627555368118;
        Thu, 29 Jul 2021 03:42:48 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id e7sm1048472edk.3.2021.07.29.03.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:42:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 12/12] nfc: mrvl: constify static nfcmrvl_if_ops
Date:   Thu, 29 Jul 2021 12:42:41 +0200
Message-Id: <20210729104241.48086-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

File-scope struct nfcmrvl_if_ops is not modified so can be made const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/nfcmrvl/i2c.c     | 2 +-
 drivers/nfc/nfcmrvl/main.c    | 2 +-
 drivers/nfc/nfcmrvl/nfcmrvl.h | 4 ++--
 drivers/nfc/nfcmrvl/spi.c     | 2 +-
 drivers/nfc/nfcmrvl/uart.c    | 2 +-
 drivers/nfc/nfcmrvl/usb.c     | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
index 6e659e77c8a2..c38b228006fd 100644
--- a/drivers/nfc/nfcmrvl/i2c.c
+++ b/drivers/nfc/nfcmrvl/i2c.c
@@ -146,7 +146,7 @@ static void nfcmrvl_i2c_nci_update_config(struct nfcmrvl_private *priv,
 {
 }
 
-static struct nfcmrvl_if_ops i2c_ops = {
+static const struct nfcmrvl_if_ops i2c_ops = {
 	.nci_open = nfcmrvl_i2c_nci_open,
 	.nci_close = nfcmrvl_i2c_nci_close,
 	.nci_send = nfcmrvl_i2c_nci_send,
diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index d8e48bdaf652..2fcf545012b1 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -91,7 +91,7 @@ static const struct nci_ops nfcmrvl_nci_ops = {
 
 struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 				void *drv_data,
-				struct nfcmrvl_if_ops *ops,
+				const struct nfcmrvl_if_ops *ops,
 				struct device *dev,
 				const struct nfcmrvl_platform_data *pdata)
 {
diff --git a/drivers/nfc/nfcmrvl/nfcmrvl.h b/drivers/nfc/nfcmrvl/nfcmrvl.h
index 84fafa95965e..165bd0a95190 100644
--- a/drivers/nfc/nfcmrvl/nfcmrvl.h
+++ b/drivers/nfc/nfcmrvl/nfcmrvl.h
@@ -77,7 +77,7 @@ struct nfcmrvl_private {
 	/* PHY type */
 	enum nfcmrvl_phy phy;
 	/* Low level driver ops */
-	struct nfcmrvl_if_ops *if_ops;
+	const struct nfcmrvl_if_ops *if_ops;
 };
 
 struct nfcmrvl_if_ops {
@@ -92,7 +92,7 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv);
 int nfcmrvl_nci_recv_frame(struct nfcmrvl_private *priv, struct sk_buff *skb);
 struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 				void *drv_data,
-				struct nfcmrvl_if_ops *ops,
+				const struct nfcmrvl_if_ops *ops,
 				struct device *dev,
 				const struct nfcmrvl_platform_data *pdata);
 
diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
index 7b015bb33fc9..d64abd0c4df3 100644
--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -99,7 +99,7 @@ static void nfcmrvl_spi_nci_update_config(struct nfcmrvl_private *priv,
 	drv_data->nci_spi->xfer_speed_hz = config->clk;
 }
 
-static struct nfcmrvl_if_ops spi_ops = {
+static const struct nfcmrvl_if_ops spi_ops = {
 	.nci_open = nfcmrvl_spi_nci_open,
 	.nci_close = nfcmrvl_spi_nci_close,
 	.nci_send = nfcmrvl_spi_nci_send,
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 63ac434675c8..9c92cbdc42f0 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -49,7 +49,7 @@ static void nfcmrvl_uart_nci_update_config(struct nfcmrvl_private *priv,
 			    config->flow_control);
 }
 
-static struct nfcmrvl_if_ops uart_ops = {
+static const struct nfcmrvl_if_ops uart_ops = {
 	.nci_open = nfcmrvl_uart_nci_open,
 	.nci_close = nfcmrvl_uart_nci_close,
 	.nci_send = nfcmrvl_uart_nci_send,
diff --git a/drivers/nfc/nfcmrvl/usb.c b/drivers/nfc/nfcmrvl/usb.c
index 9d649b45300b..a99aedff795d 100644
--- a/drivers/nfc/nfcmrvl/usb.c
+++ b/drivers/nfc/nfcmrvl/usb.c
@@ -264,7 +264,7 @@ static int nfcmrvl_usb_nci_send(struct nfcmrvl_private *priv,
 	return err;
 }
 
-static struct nfcmrvl_if_ops usb_ops = {
+static const struct nfcmrvl_if_ops usb_ops = {
 	.nci_open = nfcmrvl_usb_nci_open,
 	.nci_close = nfcmrvl_usb_nci_close,
 	.nci_send = nfcmrvl_usb_nci_send,
-- 
2.27.0

