Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889AE3D4A3E
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jul 2021 23:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhGXVIN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jul 2021 17:08:13 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:43814
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229964AbhGXVHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jul 2021 17:07:43 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 00CB83F352
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 21:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627163292;
        bh=HMf7kqYi2lIBuMtdvTj3OQjTri7oTHLzgmpSExYTBzw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=f6M8baFGvdeMwcUPfGXvnxECTTzTmXEnXNhdEP6r2KHsqEalNMz2I9tmdrQNTQc1W
         8na6i1lE4XHUFDQZQ3WJdBccwGYzK2ClaCSo1XO/M5JU07U66I4NhFlHeRIjQzpZRR
         vKDLwUDNeJ+iIjgZ6Mz3/qWDkJS3u9V9bsj/4p/GlKvoum81qGOdALiMbI4Jhc1b5c
         vbjddqGPnngMD+onevXfpkDWs4N00iPpIl5D5KS1dEBihw1ET2VlHbzOHSUsUlrNw9
         mYPxg/lRUaQ8/R1oZTzKt8mnDJCGyGiZo7W6bY5Hc/SRcDCL63b0zpfiCODSCSaj6Q
         mmlpNHTnIWLtw==
Received: by mail-ed1-f72.google.com with SMTP id c1-20020aa7df010000b02903bb5c6f746eso452024edy.10
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 14:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HMf7kqYi2lIBuMtdvTj3OQjTri7oTHLzgmpSExYTBzw=;
        b=EY1qRoLDC6A4QIwt8s/pOyzfs8SSo+vGgk6ozW1NsnJ9eIgg6oZuXbFyTWgGIbtmhM
         0mIREFI4cwhEcq5ivJMWbDG8SCcH3Cgf6EDKvqxGE90Rk51GH3K5lzwl51fd3/FrwVIp
         twi0yYcAlknRmEDCEr2HzkUyVsoT7GpZkbllfxK0s8FjwYAfV8ORVijJxwwefQ9Hb10f
         V7BVhmawPHo9uFf+Awc6bXTw8zRfXHBoIio30utAhjeTFT3fXW2UEXXOqBN3y82WyN/h
         3AmipTUe5XNOzgdwYjDrGgiz8QH3YUtsuGbCa8xP/UOKkJ6172KNJanfaW501YNevOW3
         vSHA==
X-Gm-Message-State: AOAM533J7ZQOgJMTxcJT4omKWpH5swy5SwUn8Q829e1hc+E3ifjCPTO2
        A1ifRTAfluZu9pwjSc3VBZaG7YanqY4iaqk32C5PV7e5Cy34xb1Mu1yB8zSwmsLyxfszOPLqcQo
        CAeRdDlsuxsIGjLBqjJFS93GvJMs3DTc4zxObHVh19s5i
X-Received: by 2002:a50:8a89:: with SMTP id j9mr12845882edj.226.1627163291309;
        Sat, 24 Jul 2021 14:48:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd4RK7rN/a4XS7Agkz5BbHQ1x3eZGsYYyx6EQXs4h6bYFyxMm86+u03VzFoh6LPSZbpiQ4BQ==
X-Received: by 2002:a50:8a89:: with SMTP id j9mr12845871edj.226.1627163291195;
        Sat, 24 Jul 2021 14:48:11 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id j5sm8383005edv.10.2021.07.24.14.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 14:48:10 -0700 (PDT)
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
Subject: [PATCH 03/12] nfc: s3fwrn5: constify nci_ops
Date:   Sat, 24 Jul 2021 23:47:34 +0200
Message-Id: <20210724214743.121884-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
References: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

s3fwrn5 driver modifies static struct nci_ops only to set prop_ops.
Since prop_ops is build time constant with known size, it can be made
const.  This allows to removeo the function setting the prop_ops -
s3fwrn5_nci_get_prop_ops().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/s3fwrn5/core.c | 7 +++----
 drivers/nfc/s3fwrn5/nci.c  | 8 +-------
 drivers/nfc/s3fwrn5/nci.h  | 2 +-
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/nfc/s3fwrn5/core.c b/drivers/nfc/s3fwrn5/core.c
index 865d3e3d1528..1c412007fabb 100644
--- a/drivers/nfc/s3fwrn5/core.c
+++ b/drivers/nfc/s3fwrn5/core.c
@@ -143,11 +143,13 @@ static int s3fwrn5_nci_post_setup(struct nci_dev *ndev)
 	return nci_core_init(info->ndev);
 }
 
-static struct nci_ops s3fwrn5_nci_ops = {
+static const struct nci_ops s3fwrn5_nci_ops = {
 	.open = s3fwrn5_nci_open,
 	.close = s3fwrn5_nci_close,
 	.send = s3fwrn5_nci_send,
 	.post_setup = s3fwrn5_nci_post_setup,
+	.prop_ops = s3fwrn5_nci_prop_ops,
+	.n_prop_ops = ARRAY_SIZE(s3fwrn5_nci_prop_ops),
 };
 
 int s3fwrn5_probe(struct nci_dev **ndev, void *phy_id, struct device *pdev,
@@ -167,9 +169,6 @@ int s3fwrn5_probe(struct nci_dev **ndev, void *phy_id, struct device *pdev,
 
 	s3fwrn5_set_mode(info, S3FWRN5_MODE_COLD);
 
-	s3fwrn5_nci_get_prop_ops(&s3fwrn5_nci_ops.prop_ops,
-		&s3fwrn5_nci_ops.n_prop_ops);
-
 	info->ndev = nci_allocate_device(&s3fwrn5_nci_ops,
 		S3FWRN5_NFC_PROTOCOLS, 0, 0);
 	if (!info->ndev)
diff --git a/drivers/nfc/s3fwrn5/nci.c b/drivers/nfc/s3fwrn5/nci.c
index f042d3eaf8f6..819e3474a437 100644
--- a/drivers/nfc/s3fwrn5/nci.c
+++ b/drivers/nfc/s3fwrn5/nci.c
@@ -20,7 +20,7 @@ static int s3fwrn5_nci_prop_rsp(struct nci_dev *ndev, struct sk_buff *skb)
 	return 0;
 }
 
-static struct nci_driver_ops s3fwrn5_nci_prop_ops[] = {
+struct nci_driver_ops s3fwrn5_nci_prop_ops[4] = {
 	{
 		.opcode = nci_opcode_pack(NCI_GID_PROPRIETARY,
 				NCI_PROP_SET_RFREG),
@@ -43,12 +43,6 @@ static struct nci_driver_ops s3fwrn5_nci_prop_ops[] = {
 	},
 };
 
-void s3fwrn5_nci_get_prop_ops(struct nci_driver_ops **ops, size_t *n)
-{
-	*ops = s3fwrn5_nci_prop_ops;
-	*n = ARRAY_SIZE(s3fwrn5_nci_prop_ops);
-}
-
 #define S3FWRN5_RFREG_SECTION_SIZE 252
 
 int s3fwrn5_nci_rf_configure(struct s3fwrn5_info *info, const char *fw_name)
diff --git a/drivers/nfc/s3fwrn5/nci.h b/drivers/nfc/s3fwrn5/nci.h
index a80f0fb082a8..5c22c5315f79 100644
--- a/drivers/nfc/s3fwrn5/nci.h
+++ b/drivers/nfc/s3fwrn5/nci.h
@@ -50,7 +50,7 @@ struct nci_prop_fw_cfg_rsp {
 	__u8 status;
 };
 
-void s3fwrn5_nci_get_prop_ops(struct nci_driver_ops **ops, size_t *n);
+extern struct nci_driver_ops s3fwrn5_nci_prop_ops[4];
 int s3fwrn5_nci_rf_configure(struct s3fwrn5_info *info, const char *fw_name);
 
 #endif /* __LOCAL_S3FWRN5_NCI_H_ */
-- 
2.27.0

