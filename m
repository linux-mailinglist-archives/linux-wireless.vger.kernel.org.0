Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B415D3DA14D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 12:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbhG2Kk6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 06:40:58 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47840
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236686AbhG2Kkv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:51 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 305183F0B8
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555248;
        bh=6LhaqEyE6YM7qc+DvvBC/izK9f7my9CENZwOkswScoM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DZEvd42wLQFPfzp9BcHelNFTA+e+fKXktDcoAuVrtISExfMPCcDMoPvvTLdBQRT7y
         cbhBYREL7bzPVLUmhSxGalTwjbNSnFK21ti2I5JV3QnnpjFwv6vI6d96bEdCufhyS5
         S7wkXGrsuI211iQMNQS36NYndBZhGmROk2dS24jBs4SYL7SCqFo1Ef55Car4YYCD6R
         wqtIm0z9rsGm7KE98dt+Afu/RgG1in2f5oOtPjMdTOqKCmdrTyHxTtJ2UD8WJsLocg
         osCWx/8VKe5gmJNxCSw1JJTXYq17vp9fIBGrFUXRfALWT/imPQ/Tb5z09J4jIn4C1N
         QuyXK5sUFO7WQ==
Received: by mail-ed1-f71.google.com with SMTP id c1-20020aa7df010000b02903bb5c6f746eso2723477edy.10
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 03:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LhaqEyE6YM7qc+DvvBC/izK9f7my9CENZwOkswScoM=;
        b=Kf6C0XHyCYJ9V3bOQj6POztH4g5w1tw1B8tHiwds8MS+7Chx17kIKUZ52pkFhrJj+F
         r+IL4+vN4kqccmG88flisYiaPt/y33LMQMgBCABwGjDOpV6i3ShcMt6Lty28rn7X0IRR
         InTT0KK8NXe/NKI9AblTXXqqt4v0Z+P35zDiyfO+HprkKa6TLvrxNSdeZ30eTZvd0RRN
         TeKqySk2ZhnZrDkUaJVXmRgIr3/T3VwKjrecv2N62U9NMivvuSFiHnRG1/g/bjZTsSz3
         4Ib+alSFNcyaKnqmrjXPtfYlLXZ6wx5ZUIWJyEaSyAQBYRjHy5YxzryBSQeF8Kf1xw4H
         x2kg==
X-Gm-Message-State: AOAM532jWMTns4+Bd7/ibNvTAaSOXNrNL+Zg4K1R66/ONUH6QyV0T7s2
        Pj2khUdXY5jFe1laK+19P7mP3Lcxu1AW4gP+zBKEFYWnzCrE1HSMJnA/grg/9xJDHbVDXZrYqWK
        fQcZeQuqozV0n+a4b3BiqfRTmGerwTIIw7IswQsq7DfKW
X-Received: by 2002:a05:6402:d2:: with SMTP id i18mr5264560edu.17.1627555247739;
        Thu, 29 Jul 2021 03:40:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyU2Ka89Z3Qjr8Tzvk3IIGX+JEzwdx0FNyuEdwHjyphht6T2bpxMENgCaQjv8QxWPsttQOLJw==
X-Received: by 2002:a05:6402:d2:: with SMTP id i18mr5264543edu.17.1627555247595;
        Thu, 29 Jul 2021 03:40:47 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 11/12] nfc: mrvl: constify several pointers
Date:   Thu, 29 Jul 2021 12:40:21 +0200
Message-Id: <20210729104022.47761-12-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Several functions do not modify pointed data so arguments and local
variables can be const for correctness and safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/nfcmrvl/fw_dnld.c | 16 +++++++++-------
 drivers/nfc/nfcmrvl/i2c.c     |  2 +-
 drivers/nfc/nfcmrvl/main.c    |  2 +-
 drivers/nfc/nfcmrvl/nfcmrvl.h |  2 +-
 drivers/nfc/nfcmrvl/spi.c     |  4 ++--
 drivers/nfc/nfcmrvl/uart.c    |  2 +-
 6 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
index aaccb8b76b3e..edac56b01fd1 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -129,7 +129,7 @@ static void fw_dnld_timeout(struct timer_list *t)
 }
 
 static int process_state_reset(struct nfcmrvl_private *priv,
-			       struct sk_buff *skb)
+			       const struct sk_buff *skb)
 {
 	if (sizeof(nci_pattern_core_reset_ntf) != skb->len ||
 	    memcmp(skb->data, nci_pattern_core_reset_ntf,
@@ -145,7 +145,8 @@ static int process_state_reset(struct nfcmrvl_private *priv,
 	return 0;
 }
 
-static int process_state_init(struct nfcmrvl_private *priv, struct sk_buff *skb)
+static int process_state_init(struct nfcmrvl_private *priv,
+			      const struct sk_buff *skb)
 {
 	struct nci_core_set_config_cmd cmd;
 
@@ -175,7 +176,7 @@ static void create_lc(struct nfcmrvl_private *priv)
 }
 
 static int process_state_set_ref_clock(struct nfcmrvl_private *priv,
-				       struct sk_buff *skb)
+				       const struct sk_buff *skb)
 {
 	struct nci_core_set_config_cmd cmd;
 
@@ -221,7 +222,7 @@ static int process_state_set_ref_clock(struct nfcmrvl_private *priv,
 }
 
 static int process_state_set_hi_config(struct nfcmrvl_private *priv,
-				       struct sk_buff *skb)
+				       const struct sk_buff *skb)
 {
 	if (sizeof(nci_pattern_core_set_config_rsp) != skb->len ||
 	    memcmp(skb->data, nci_pattern_core_set_config_rsp, skb->len))
@@ -232,7 +233,7 @@ static int process_state_set_hi_config(struct nfcmrvl_private *priv,
 }
 
 static int process_state_open_lc(struct nfcmrvl_private *priv,
-				 struct sk_buff *skb)
+				 const struct sk_buff *skb)
 {
 	if (sizeof(nci_pattern_core_conn_create_rsp) >= skb->len ||
 	    memcmp(skb->data, nci_pattern_core_conn_create_rsp,
@@ -347,7 +348,7 @@ static int process_state_fw_dnld(struct nfcmrvl_private *priv,
 }
 
 static int process_state_close_lc(struct nfcmrvl_private *priv,
-				  struct sk_buff *skb)
+				  const struct sk_buff *skb)
 {
 	if (sizeof(nci_pattern_core_conn_close_rsp) != skb->len ||
 	    memcmp(skb->data, nci_pattern_core_conn_close_rsp, skb->len))
@@ -358,7 +359,8 @@ static int process_state_close_lc(struct nfcmrvl_private *priv,
 	return 0;
 }
 
-static int process_state_boot(struct nfcmrvl_private *priv, struct sk_buff *skb)
+static int process_state_boot(struct nfcmrvl_private *priv,
+			      const struct sk_buff *skb)
 {
 	if (sizeof(nci_pattern_proprietary_boot_rsp) != skb->len ||
 	    memcmp(skb->data, nci_pattern_proprietary_boot_rsp, skb->len))
diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
index 59a529e72d96..6e659e77c8a2 100644
--- a/drivers/nfc/nfcmrvl/i2c.c
+++ b/drivers/nfc/nfcmrvl/i2c.c
@@ -182,8 +182,8 @@ static int nfcmrvl_i2c_parse_dt(struct device_node *node,
 static int nfcmrvl_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
+	const struct nfcmrvl_platform_data *pdata;
 	struct nfcmrvl_i2c_drv_data *drv_data;
-	struct nfcmrvl_platform_data *pdata;
 	struct nfcmrvl_platform_data config;
 	int ret;
 
diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index 6e9e7ce8792c..d8e48bdaf652 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -93,7 +93,7 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 				void *drv_data,
 				struct nfcmrvl_if_ops *ops,
 				struct device *dev,
-				struct nfcmrvl_platform_data *pdata)
+				const struct nfcmrvl_platform_data *pdata)
 {
 	struct nfcmrvl_private *priv;
 	int rc;
diff --git a/drivers/nfc/nfcmrvl/nfcmrvl.h b/drivers/nfc/nfcmrvl/nfcmrvl.h
index a715543bc9bf..84fafa95965e 100644
--- a/drivers/nfc/nfcmrvl/nfcmrvl.h
+++ b/drivers/nfc/nfcmrvl/nfcmrvl.h
@@ -94,7 +94,7 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 				void *drv_data,
 				struct nfcmrvl_if_ops *ops,
 				struct device *dev,
-				struct nfcmrvl_platform_data *pdata);
+				const struct nfcmrvl_platform_data *pdata);
 
 
 void nfcmrvl_chip_reset(struct nfcmrvl_private *priv);
diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
index 66696321c645..7b015bb33fc9 100644
--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -106,7 +106,7 @@ static struct nfcmrvl_if_ops spi_ops = {
 	.nci_update_config = nfcmrvl_spi_nci_update_config,
 };
 
-static int nfcmrvl_spi_parse_dt(struct device_node *node,
+static int nfcmrvl_spi_parse_dt(const struct device_node *node,
 				struct nfcmrvl_platform_data *pdata)
 {
 	int ret;
@@ -129,7 +129,7 @@ static int nfcmrvl_spi_parse_dt(struct device_node *node,
 
 static int nfcmrvl_spi_probe(struct spi_device *spi)
 {
-	struct nfcmrvl_platform_data *pdata;
+	const struct nfcmrvl_platform_data *pdata;
 	struct nfcmrvl_platform_data config;
 	struct nfcmrvl_spi_drv_data *drv_data;
 	int ret = 0;
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 50d86c90b9dd..63ac434675c8 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -98,8 +98,8 @@ static int nfcmrvl_uart_parse_dt(struct device_node *node,
 static int nfcmrvl_nci_uart_open(struct nci_uart *nu)
 {
 	struct nfcmrvl_private *priv;
-	struct nfcmrvl_platform_data *pdata = NULL;
 	struct nfcmrvl_platform_data config;
+	const struct nfcmrvl_platform_data *pdata = NULL;
 	struct device *dev = nu->tty->dev;
 
 	/*
-- 
2.27.0

