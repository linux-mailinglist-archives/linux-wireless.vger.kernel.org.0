Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBFF3D4A55
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jul 2021 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhGXVJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jul 2021 17:09:37 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:58740
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhGXVJ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jul 2021 17:09:27 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 274323F35E
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 21:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627163398;
        bh=i+Q0llccIqMx5SsL7f2qLyVatbD4Rx39C8icqgEfdwA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZE6LNOG2hJpweE4zSCqDYvmZ8Kc6rnkdC4+3YdLKjFu45IREKSf6SLC4D/DipF7k/
         9jN/X6ElGPGUk49wzMjWa5sNdja52gczIe7/wcJUNtW3OeI3jcWF7iMO6z2yxDKr/U
         47YsMCztjjn81PzrLo21uKU8L1YiQ3W0G8rL7XTwgQGZ3wiuJBhO8Vtwlb6wsmB2cW
         PvVcR42rTS+RIZN7qw+xBsxHJSO3N2FHvxdJdkI62oHwyzOmvvQsjQJmgD+YoEsHKN
         C8QfRB8JaLYDwcGp2zXflsWqhdh7coZ3NRPo5VksFtE7CERJWl8NNNFtJaczXUvHw9
         cWCMTFoc4Lvrw==
Received: by mail-ej1-f72.google.com with SMTP id pv7-20020a1709072087b02905119310d7b9so1025969ejb.23
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 14:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+Q0llccIqMx5SsL7f2qLyVatbD4Rx39C8icqgEfdwA=;
        b=NqZid3ARkCxUVdFNmnA2/Mh6SdZCkp4qaqMidIwE+2UH7Nl8rGv6BFKGcVf/w4pNlu
         xHzxyRXLGmZewgi+FgGKkUlAaq8uCcghEFd+jzlNhOqTGIuVtQvQWsHshzqlkR9wnq69
         j3XUcST8fzsJejL8iEAROiNegiImlwioIALQ8fgVE9ghvbmcoz2o5+xW3b9QhwR/3biK
         yDEGXR5h2rQew9/l5f6BjoYwAjbnNLtIinoJ6NbYup6+WV3oe5y+tRNyUGE84e1JQZmP
         GHKgoWGPNUDJP0P6nEt924Bc6e992f3ljS9oP5f3keIUr0ucxHW1WCIlwfHb4K27HFOz
         JwBA==
X-Gm-Message-State: AOAM530vjsuEMhqBFRvuPuEy49PGvB2rtN4N22v3Zg/1P6j2CXDdDJJm
        q9IYg8oIemt29NwTRoOYkbm9Hg1yjHjtIDLVw+B/ZbzGzD8eIRmcsFmEX7YHU6EG55ByjgIgcEo
        2ndEXBnTr7TWZv2IMP22YNSgPVKNO992xDie8yyQPmkg4
X-Received: by 2002:a05:6402:430e:: with SMTP id m14mr10296157edc.120.1627163397543;
        Sat, 24 Jul 2021 14:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymDQtRzFb9UEZAtt6Ovb/j39XIvk8E2P6p5LIuQnS1n8kjgb+MF7fTYK1hCJjwQajwuR/7Qw==
X-Received: by 2002:a05:6402:430e:: with SMTP id m14mr10296138edc.120.1627163397361;
        Sat, 24 Jul 2021 14:49:57 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id s10sm12821908ejc.39.2021.07.24.14.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 14:49:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 12/12] nfc: constify nfc_digital_ops
Date:   Sat, 24 Jul 2021 23:49:28 +0200
Message-Id: <20210724214928.122096-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
References: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Neither the core nor the drivers modify the passed pointer to struct
nfc_digital_ops, so make it a pointer to const for correctness and safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/nfcsim.c      | 2 +-
 drivers/nfc/port100.c     | 2 +-
 drivers/nfc/st95hf/core.c | 2 +-
 drivers/nfc/trf7970a.c    | 2 +-
 include/net/nfc/digital.h | 4 ++--
 net/nfc/digital_core.c    | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index a9864fcdfba6..143dc49b815b 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -320,7 +320,7 @@ static int nfcsim_tg_listen(struct nfc_digital_dev *ddev, u16 timeout,
 	return nfcsim_send(ddev, NULL, timeout, cb, arg);
 }
 
-static struct nfc_digital_ops nfcsim_digital_ops = {
+static const struct nfc_digital_ops nfcsim_digital_ops = {
 	.in_configure_hw = nfcsim_in_configure_hw,
 	.in_send_cmd = nfcsim_in_send_cmd,
 
diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 1d614f9d864a..ccb5c5fab905 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -1463,7 +1463,7 @@ static int port100_listen(struct nfc_digital_dev *ddev, u16 timeout,
 	return port100_tg_send_cmd(ddev, skb, timeout, cb, arg);
 }
 
-static struct nfc_digital_ops port100_digital_ops = {
+static const struct nfc_digital_ops port100_digital_ops = {
 	.in_configure_hw = port100_in_configure_hw,
 	.in_send_cmd = port100_in_send_cmd,
 
diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 2dc788c363fd..993818742570 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1037,7 +1037,7 @@ static void st95hf_abort_cmd(struct nfc_digital_dev *ddev)
 {
 }
 
-static struct nfc_digital_ops st95hf_nfc_digital_ops = {
+static const struct nfc_digital_ops st95hf_nfc_digital_ops = {
 	.in_configure_hw = st95hf_in_configure_hw,
 	.in_send_cmd = st95hf_in_send_cmd,
 
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 33978022ae47..1aed44629aaa 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -1861,7 +1861,7 @@ static void trf7970a_abort_cmd(struct nfc_digital_dev *ddev)
 	mutex_unlock(&trf->lock);
 }
 
-static struct nfc_digital_ops trf7970a_nfc_ops = {
+static const struct nfc_digital_ops trf7970a_nfc_ops = {
 	.in_configure_hw	= trf7970a_in_configure_hw,
 	.in_send_cmd		= trf7970a_send_cmd,
 	.tg_configure_hw	= trf7970a_tg_configure_hw,
diff --git a/include/net/nfc/digital.h b/include/net/nfc/digital.h
index 963db96bcbbb..bb3e8fdc0692 100644
--- a/include/net/nfc/digital.h
+++ b/include/net/nfc/digital.h
@@ -191,7 +191,7 @@ struct digital_poll_tech {
 
 struct nfc_digital_dev {
 	struct nfc_dev *nfc_dev;
-	struct nfc_digital_ops *ops;
+	const struct nfc_digital_ops *ops;
 
 	u32 protocols;
 
@@ -236,7 +236,7 @@ struct nfc_digital_dev {
 	void (*skb_add_crc)(struct sk_buff *skb);
 };
 
-struct nfc_digital_dev *nfc_digital_allocate_device(struct nfc_digital_ops *ops,
+struct nfc_digital_dev *nfc_digital_allocate_device(const struct nfc_digital_ops *ops,
 						    __u32 supported_protocols,
 						    __u32 driver_capabilities,
 						    int tx_headroom,
diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
index 8f2572decccd..fefc03674f4f 100644
--- a/net/nfc/digital_core.c
+++ b/net/nfc/digital_core.c
@@ -745,7 +745,7 @@ static const struct nfc_ops digital_nfc_ops = {
 	.im_transceive = digital_in_send,
 };
 
-struct nfc_digital_dev *nfc_digital_allocate_device(struct nfc_digital_ops *ops,
+struct nfc_digital_dev *nfc_digital_allocate_device(const struct nfc_digital_ops *ops,
 					    __u32 supported_protocols,
 					    __u32 driver_capabilities,
 					    int tx_headroom, int tx_tailroom)
-- 
2.27.0

