Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F65F3DA15A
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 12:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbhG2KlV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 06:41:21 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:34496
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236292AbhG2Kkp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:45 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 286AA3F114
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 10:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555240;
        bh=8EDO8hbetO1mnknXtDL482rftlukDehwkpBsBwJNSdE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=D989OQww4T54EB5kWFBLYsZFUxBekBV/D+b+vnQUNg2gNz7iKBroM+Y57/ztQU1BU
         ZtH3Lc5klXg8n5vZy6Ie/yQwZQsxoQnHoMlz3Y6mJE/5kV0js4h9eJcw1Y/443JS4Q
         5XgYUyRAtVpqN0X8YtAJXUVjQngE4ovh5byoe+wCGjvfmu677rcbfVgCQe4NYw842A
         NAusMGss7+SvizG3B5fOfeQOt4qr/6GpgEP3ZjVbtgfquEXtDLduhdzbM8v51tgx0J
         H6PKSLdgTZBvGrN7cTK/0+n0g6ho3E8Ekz1nZwDg9ULQqmGJMhz0Y/CnXJMhnHM4Hd
         Rn4jBrl+FgZog==
Received: by mail-ed1-f71.google.com with SMTP id c16-20020aa7d6100000b02903bc4c2a387bso2700309edr.21
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 03:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EDO8hbetO1mnknXtDL482rftlukDehwkpBsBwJNSdE=;
        b=itGHXac2swy4MiQHZw0ecw9HLu5Tm5o2OtoT/lO6AcNRRmdwAlxHrr0cRu46dTgn/u
         0TcccnOXLSYhe+AIaOsNgsGH2BgH1jrA5ouy2tSCFiq5wMLjsh9TXCpCqI66YrHFPJsM
         yJvmLrsT3BlOXQikPUoDw9LWMVU1XiYoChE69ipaBAB6oqoZk3iaTXyvsW/ryFNGekg3
         4V6QmxO7YD6vgTsF1JMoXgHlOu8w6id2eDf7/d70y4a+jdaCpBlO72/oLYtYHWxtRS+D
         LtmvhPOfbGHSqZKHoAKBPGDMHoafffbzrfZ9t4gcqTQPQj2fWxi54GlrCJswrFQywinC
         wJqA==
X-Gm-Message-State: AOAM533JrWWXIU5b0Wjec3qUcaVY7pFXP0lSwkIfFjf9J0hEF3cQG9q/
        CCl6GrSYmutXza+BBsQCjtx+3fYYJzmgY8RiBVbbiazGtNOrPyvV/mie3kRgvWjVn+gniMUXNoS
        VSd6n9I4RULund4FaSEPtVGOklvIPcaqKg2W37Kmsl1MV
X-Received: by 2002:a17:907:364:: with SMTP id rs4mr4101080ejb.56.1627555238864;
        Thu, 29 Jul 2021 03:40:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZOu9E6xI3XjXcxdCN71pcdo7KIqUHufVdue1M53+xuTdudckjsCWW6eu5CVaY3Tc87olLnA==
X-Received: by 2002:a17:907:364:: with SMTP id rs4mr4101068ejb.56.1627555238733;
        Thu, 29 Jul 2021 03:40:38 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 04/12] nfc: trf7970a: constify several pointers
Date:   Thu, 29 Jul 2021 12:40:14 +0200
Message-Id: <20210729104022.47761-5-krzysztof.kozlowski@canonical.com>
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
 drivers/nfc/trf7970a.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 1aed44629aaa..8890fcd59c39 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -643,7 +643,7 @@ static void trf7970a_send_err_upstream(struct trf7970a *trf, int errno)
 }
 
 static int trf7970a_transmit(struct trf7970a *trf, struct sk_buff *skb,
-			     unsigned int len, u8 *prefix,
+			     unsigned int len, const u8 *prefix,
 			     unsigned int prefix_len)
 {
 	struct spi_transfer t[2];
@@ -1387,9 +1387,10 @@ static int trf7970a_is_iso15693_write_or_lock(u8 cmd)
 	}
 }
 
-static int trf7970a_per_cmd_config(struct trf7970a *trf, struct sk_buff *skb)
+static int trf7970a_per_cmd_config(struct trf7970a *trf,
+				   const struct sk_buff *skb)
 {
-	u8 *req = skb->data;
+	const u8 *req = skb->data;
 	u8 special_fcn_reg1, iso_ctrl;
 	int ret;
 
@@ -1791,7 +1792,7 @@ static int _trf7970a_tg_listen(struct nfc_digital_dev *ddev, u16 timeout,
 static int trf7970a_tg_listen(struct nfc_digital_dev *ddev, u16 timeout,
 			      nfc_digital_cmd_complete_t cb, void *arg)
 {
-	struct trf7970a *trf = nfc_digital_get_drvdata(ddev);
+	const struct trf7970a *trf = nfc_digital_get_drvdata(ddev);
 
 	dev_dbg(trf->dev, "Listen - state: %d, timeout: %d ms\n",
 		trf->state, timeout);
@@ -1803,7 +1804,7 @@ static int trf7970a_tg_listen_md(struct nfc_digital_dev *ddev,
 				 u16 timeout, nfc_digital_cmd_complete_t cb,
 				 void *arg)
 {
-	struct trf7970a *trf = nfc_digital_get_drvdata(ddev);
+	const struct trf7970a *trf = nfc_digital_get_drvdata(ddev);
 	int ret;
 
 	dev_dbg(trf->dev, "Listen MD - state: %d, timeout: %d ms\n",
@@ -1824,7 +1825,7 @@ static int trf7970a_tg_listen_md(struct nfc_digital_dev *ddev,
 
 static int trf7970a_tg_get_rf_tech(struct nfc_digital_dev *ddev, u8 *rf_tech)
 {
-	struct trf7970a *trf = nfc_digital_get_drvdata(ddev);
+	const struct trf7970a *trf = nfc_digital_get_drvdata(ddev);
 
 	dev_dbg(trf->dev, "Get RF Tech - state: %d, rf_tech: %d\n",
 		trf->state, trf->md_rf_tech);
@@ -1974,7 +1975,7 @@ static void trf7970a_shutdown(struct trf7970a *trf)
 	trf7970a_power_down(trf);
 }
 
-static int trf7970a_get_autosuspend_delay(struct device_node *np)
+static int trf7970a_get_autosuspend_delay(const struct device_node *np)
 {
 	int autosuspend_delay, ret;
 
@@ -1987,7 +1988,7 @@ static int trf7970a_get_autosuspend_delay(struct device_node *np)
 
 static int trf7970a_probe(struct spi_device *spi)
 {
-	struct device_node *np = spi->dev.of_node;
+	const struct device_node *np = spi->dev.of_node;
 	struct trf7970a *trf;
 	int uvolts, autosuspend_delay, ret;
 	u32 clk_freq = TRF7970A_13MHZ_CLOCK_FREQUENCY;
-- 
2.27.0

