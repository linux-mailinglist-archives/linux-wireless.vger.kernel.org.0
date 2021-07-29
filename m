Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D1A3DA14E
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 12:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbhG2Kk7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 06:40:59 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47886
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236619AbhG2Kku (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:50 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 773D83F23B
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555246;
        bh=BZIMPFV8uXC9L/K0xzDgkM9m6seQbMO32c9dNbfWa80=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=BTaP1d8ydrV0hgqkvf/+UhufeiCSWdGIGAW4o196Prd6ZEqDC2WF3iYjM848wn9Dj
         VPKZ8ix+0RfiaO26QLgqT7Z/1agpsiRaeCzPIDc0jHdLJiHnmltOES+3nX113AcY88
         +9XVJP0/1JjYJRM/nSMyX2LE7f615J6AwEZ5nXupdTkR5itCw5mz66kXyZpHPcGBLf
         7rS9vDW9u8VlblQ0tv8KO25uGVKV/GU21bs4JxY77fjIaBCJ+MIo8nWAzep7v78vAn
         zsvgWkvLVPIgGMNqKzHht81g6NPRQxwWcEhaWWYlvOLySc15W0153dZ6YFCDSDaOt+
         mclQZNrRELrLA==
Received: by mail-ej1-f71.google.com with SMTP id x5-20020a1709064bc5b02905305454f5d1so1824426ejv.10
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 03:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZIMPFV8uXC9L/K0xzDgkM9m6seQbMO32c9dNbfWa80=;
        b=rvSnTLorUe+9llMw397CUtWWYrWPkNbV0qrkLZ/7uVbv/N07EZXWxUX5WHwiDxPVAC
         wMRxCyfK3TdlYtBEUR+yJNl6ePGWmkTb3aZmRmv6jeKKSPG0fjuIHlFHbDKXH9NH6b2d
         qJYWpAe7WjBC/3IjC2Hf3+msIueOIHvWr6LXQS6r5GHH6zhLYYnbjx9SzJwWbuJY6T52
         rK6eZVal2T1ZJfEaDJR67IUlQkSl5DR/QJFZkcAbtfqVVrF6lJVx0WkiUOaofReQ/g3C
         XknKtknAHJdQPqZhEQN6MTDeL15F+cFhgUOmsD+BpzLVIN82CQ52jHUwMUYlBJo8vNCM
         caAQ==
X-Gm-Message-State: AOAM5309+64ffcSpcIXVEs8sQbkH5WbU+IB2/yx6N/lxLZXE4fQuDiz9
        8ivCBtdHmF722KEmSlBA8e7HkCWag3UWca2RBV5W4m+yEp7uXInSJ4dFVv63uDpoGC0sPNrF3lq
        Q1LBFlVmRoTzxrPci0PTjh0CGGNOHTcWyB+6K0c05hSPt
X-Received: by 2002:a17:906:b0c5:: with SMTP id bk5mr3881342ejb.428.1627555246144;
        Thu, 29 Jul 2021 03:40:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygcbnz2mL1I+EM9Bv/vZsYeICNIGIdcaZXywSSZmph4zECffAhqDCrnUSC3LB/1TyQegjgiQ==
X-Received: by 2002:a17:906:b0c5:: with SMTP id bk5mr3881326ejb.428.1627555246020;
        Thu, 29 Jul 2021 03:40:46 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 10/12] nfc: microread: constify several pointers
Date:   Thu, 29 Jul 2021 12:40:20 +0200
Message-Id: <20210729104022.47761-11-krzysztof.kozlowski@canonical.com>
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
 drivers/nfc/microread/i2c.c       | 2 +-
 drivers/nfc/microread/microread.c | 4 ++--
 drivers/nfc/microread/microread.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/microread/i2c.c b/drivers/nfc/microread/i2c.c
index f91760c78455..86f593c73ed6 100644
--- a/drivers/nfc/microread/i2c.c
+++ b/drivers/nfc/microread/i2c.c
@@ -73,7 +73,7 @@ static void microread_i2c_remove_len_crc(struct sk_buff *skb)
 	skb_trim(skb, MICROREAD_I2C_FRAME_TAILROOM);
 }
 
-static int check_crc(struct sk_buff *skb)
+static int check_crc(const struct sk_buff *skb)
 {
 	int i;
 	u8 crc = 0;
diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 8e847524937c..9d83ccebd434 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -358,7 +358,7 @@ static int microread_complete_target_discovered(struct nfc_hci_dev *hdev,
 static void microread_im_transceive_cb(void *context, struct sk_buff *skb,
 				       int err)
 {
-	struct microread_info *info = context;
+	const struct microread_info *info = context;
 
 	switch (info->async_cb_type) {
 	case MICROREAD_CB_TYPE_READER_ALL:
@@ -642,7 +642,7 @@ static const struct nfc_hci_ops microread_hci_ops = {
 };
 
 int microread_probe(void *phy_id, const struct nfc_phy_ops *phy_ops,
-		    char *llc_name, int phy_headroom, int phy_tailroom,
+		    const char *llc_name, int phy_headroom, int phy_tailroom,
 		    int phy_payload, struct nfc_hci_dev **hdev)
 {
 	struct microread_info *info;
diff --git a/drivers/nfc/microread/microread.h b/drivers/nfc/microread/microread.h
index 76152d7aa53c..2ee7ccfa22dd 100644
--- a/drivers/nfc/microread/microread.h
+++ b/drivers/nfc/microread/microread.h
@@ -11,7 +11,7 @@
 #define DRIVER_DESC "NFC driver for microread"
 
 int microread_probe(void *phy_id, const struct nfc_phy_ops *phy_ops,
-		    char *llc_name, int phy_headroom, int phy_tailroom,
+		    const char *llc_name, int phy_headroom, int phy_tailroom,
 		    int phy_payload, struct nfc_hci_dev **hdev);
 
 void microread_remove(struct nfc_hci_dev *hdev);
-- 
2.27.0

