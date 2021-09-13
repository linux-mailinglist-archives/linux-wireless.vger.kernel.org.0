Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C168A408DA5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 15:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbhIMN17 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 09:27:59 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34170
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236172AbhIMNZi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 09:25:38 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C78E14028E
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 13:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539266;
        bh=AKOLSiNotprej29rkzU07CereuPK7jDMwjY+iTyzzwA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=miQX3ZyO2Si5M88Eae3XDTF1Zuq3JQtQFn4dHRPuWtVZ0a3shezfpZsaqxMC60Y42
         OC0Q+6gM7+qpFhUyVTuz02UC5OyAXCjXrxtEaPLFJMrjstWWHvIpaMfqIXGdMmzhYO
         TdSlPqRyGtITbYiXZc9ACAV/N7brxABfE5qdcBiTYODuF0yvLnYGzXHohiSPtxBTDn
         PKSMfpjg7g/AZTvEznopOGUCMIIz4XmrIDQxScqnWVlMAw8nns+oo2YWXxLYR7xHyR
         jkle5qe0LoxjoZzcxNlGMHaS43rvNdT+GLwKgVXkMjVjD62MGYJAvzvZtsf0gu15q4
         oL8tprYBu+gdg==
Received: by mail-wm1-f71.google.com with SMTP id m4-20020a05600c3b0400b00303b904380dso2609828wms.6
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 06:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKOLSiNotprej29rkzU07CereuPK7jDMwjY+iTyzzwA=;
        b=iPg7gaQ4Pmr+vGHk4XNFDOSYBq5qmz+pX8gUr0q2qH87p/zkdIMizo8RzK6eoza4Tt
         Qqe1PEG8lZ7zH13kCw9Xoj5ZmgKfOPOTvx0fYWnh8VGn01lLXY5KS07jmmyqZldc/shK
         Nj6scsFN/dD2mQeDs437NjsqnXcsUzpjIBcR305+4UxKCsY92HQlWyJfJlWSOFRv8HQE
         hTGdigyxm94BX9foyg9M6XRBNUel/75R6zddvD+sbd0DXzTwpoEutNaorgSu7KiO6XXJ
         nhXl9ls84/hNv3SLXRStmnVIw0leotjznXuNij3HrOG5l17hwIjmizpXQZ8k0XiFsVW3
         xMkQ==
X-Gm-Message-State: AOAM531JVgypjLLCLHYnpFL31qUAOaphmwKZSfSVOD0AncZjHXyKzq6K
        +9kbA3W4DRck0GD8bSumMcXlxagcDAJ6xlyrXOxwSCr3VQfT3JE3tFKMgOVDNYVEP+N08aKY47R
        7FHsscXdCDFaM/AqnMb/3onwJzSp++dcUfXjGkmOqzLDF
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr11120619wmp.173.1631539265712;
        Mon, 13 Sep 2021 06:21:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGKB8zsRCueVcnv/F/wvUaRLWvDTsfD6029ziTjUpm5OT7cpm9fnOgAqV38PdDEO3snD2i1w==
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr11120577wmp.173.1631539265398;
        Mon, 13 Sep 2021 06:21:05 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:21:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 13/15] nfc: microread: drop unneeded debug prints
Date:   Mon, 13 Sep 2021 15:20:33 +0200
Message-Id: <20210913132035.242870-14-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/microread/i2c.c | 4 ----
 drivers/nfc/microread/mei.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/nfc/microread/i2c.c b/drivers/nfc/microread/i2c.c
index 86f593c73ed6..067295124eb9 100644
--- a/drivers/nfc/microread/i2c.c
+++ b/drivers/nfc/microread/i2c.c
@@ -237,8 +237,6 @@ static int microread_i2c_probe(struct i2c_client *client,
 	struct microread_i2c_phy *phy;
 	int r;
 
-	dev_dbg(&client->dev, "client %p\n", client);
-
 	phy = devm_kzalloc(&client->dev, sizeof(struct microread_i2c_phy),
 			   GFP_KERNEL);
 	if (!phy)
@@ -262,8 +260,6 @@ static int microread_i2c_probe(struct i2c_client *client,
 	if (r < 0)
 		goto err_irq;
 
-	nfc_info(&client->dev, "Probed\n");
-
 	return 0;
 
 err_irq:
diff --git a/drivers/nfc/microread/mei.c b/drivers/nfc/microread/mei.c
index 8edf761a6b2a..686be3381727 100644
--- a/drivers/nfc/microread/mei.c
+++ b/drivers/nfc/microread/mei.c
@@ -23,8 +23,6 @@ static int microread_mei_probe(struct mei_cl_device *cldev,
 	struct nfc_mei_phy *phy;
 	int r;
 
-	pr_info("Probing NFC microread\n");
-
 	phy = nfc_mei_phy_alloc(cldev);
 	if (!phy) {
 		pr_err("Cannot allocate memory for microread mei phy.\n");
-- 
2.30.2

