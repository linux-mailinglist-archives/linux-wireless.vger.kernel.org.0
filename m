Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5F428E49
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 15:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhJKNli (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 09:41:38 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42404
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237150AbhJKNlb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 09:41:31 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 40C4440000
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633959570;
        bh=Caod7f/lk82yPL9l72YPa9/xdZxrVhuurClzVai7YFo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CdstOsIuUqQkW+etuNFTUjYwMjQFkxCkWW+9uHrMnBxETVRjWMibImMgNv/x2mBTk
         rWCYSxc2ZNkiJHDwcDChqALlE48j1dataBMPL+Zhf06/bVmTcFnGd74E2m9Uw0vIoa
         zFcYjLoewAtziYaOa2DkZ5Wr/qy7yhNvZkU33hkSAOMPEJ99OlyL2FeoY72RscZVV9
         Kei6lckt5JmwCEGCISD2KYY7+papd0UG1dfTMH9P5gM2sI/49F0CVwi2BQnR27gH+H
         SsfPMtDEI1PxlHo9In+0f0Ns/+JBchT9B263BvWDrkvbFoKJ0mxwZZNobH8sXwfIa9
         86ToBtKdRkyug==
Received: by mail-lf1-f72.google.com with SMTP id s8-20020ac25c48000000b003faf62e104eso12747795lfp.22
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 06:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Caod7f/lk82yPL9l72YPa9/xdZxrVhuurClzVai7YFo=;
        b=7aztrIIH5RzHAUMB27f774xtOOygMEDPnpaLgPyBMywc2wS++7g+ERfRgxrYJuiDqF
         CbZCVJ/VrJwUMPGaezfdbbIUSXAzDt7Y0ngfyh13KlyilDJH7m49LFP62HCyhBgmjmWM
         0viHubRW4dFG/E2hAgacbdL+ZcF29e9oqJtV4EFtste+/fa2vLnZReRXBzJ4QqvpmfIT
         ZBlZ4hRZVotCc3Z5MoebT56d3zktXyQnwjoTxyRaR6VFZEouCOgE4L3sggNacxx22XXB
         YSN1sB5eYqDk9j3Lgh4YmGhnTT1vTSRyquZVQF4alOmIVeWEFFqPtxlnOLllKHMQR3+Z
         M3mw==
X-Gm-Message-State: AOAM533FbJRu9fuOzqp+jSsG25yKKWcb9sFOItlpb6wVu5YDhzWIHWcW
        Clc8l4J8IRV0zgr9B/osEYIeok6Rstn/cPj4bmQGD3X5rcqwbdfmEusnTDAjrUDKDSMSy3TBFzg
        IVCSd3UN3AJcWIb9oyb942k5RaVqEPxfNF5SUsVlWC5zA
X-Received: by 2002:a05:6512:23a0:: with SMTP id c32mr28315078lfv.166.1633959568235;
        Mon, 11 Oct 2021 06:39:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZiDLQW+5zqCPlBUX+HccXn6LAIXSmaJCIzfqIdMJzGyKW6xXiv/0sl+AlXYBAwxKOQrbchw==
X-Received: by 2002:a05:6512:23a0:: with SMTP id c32mr28315053lfv.166.1633959568082;
        Mon, 11 Oct 2021 06:39:28 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a21sm738971lff.37.2021.10.11.06.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 06:39:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Cc:     joe@perches.com
Subject: [PATCH v3 7/7] nfc: microread: drop unneeded debug prints
Date:   Mon, 11 Oct 2021 15:38:35 +0200
Message-Id: <20211011133835.236347-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011133835.236347-1-krzysztof.kozlowski@canonical.com>
References: <20211011133835.236347-1-krzysztof.kozlowski@canonical.com>
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
index 00689e18dc46..e2a77a5fc887 100644
--- a/drivers/nfc/microread/mei.c
+++ b/drivers/nfc/microread/mei.c
@@ -23,8 +23,6 @@ static int microread_mei_probe(struct mei_cl_device *cldev,
 	struct nfc_mei_phy *phy;
 	int r;
 
-	pr_info("Probing NFC microread\n");
-
 	phy = nfc_mei_phy_alloc(cldev);
 	if (!phy)
 		return -ENOMEM;
-- 
2.30.2

