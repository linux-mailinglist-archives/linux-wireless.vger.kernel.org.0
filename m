Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC6408DA2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 15:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbhIMN1z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 09:27:55 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34172
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240346AbhIMNZj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 09:25:39 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8FB7B40291
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 13:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539268;
        bh=KQ0ijwIeFsveeXdiNAQIdSvmUM7JWh6ALRqQaOVckDE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=JHdhHlDpHlmfCOtBj4u//FCtXZVMIbqJ8nG62pu7fkbiYuIe+to5PFM4koDu2R5hf
         5eAFOsEJ8DfgGwXWgF7fNVnn6+cEbJ528cLveqke1SukjiR9pSI2otxORjjbEvR6dK
         KXMiyZVTXWktZ2SuSDQk2/RI7wak+XxT7mmM3Y4JCwx0c0CVWNsLchlITPTyuhBkem
         cu2Lv0Hka5xyBx38WrP1RH5Sq5qWxkd10CD76aw0ZjeZH6O/5x27Kgh9Bk+R7BwhM5
         w9FO48hcUS4Cjo7b6LbuD4ZH0fnAbwCa+NuuQFzwIsyqz32g8pn6/FM/NuUQLhgPGu
         IGoWV76ycLkJQ==
Received: by mail-wr1-f69.google.com with SMTP id z2-20020a5d4c82000000b0015b140e0562so2675402wrs.7
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 06:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQ0ijwIeFsveeXdiNAQIdSvmUM7JWh6ALRqQaOVckDE=;
        b=QwOyT+Ml59Zs7kTdaUwZ1S8O9KH9lEwEKInGKNfsJSAo6P4TEwEj+DMierHLoGucbr
         jRZ3RRIwPFTp03kANZ/+6FG38K8k4EpRHM79Rk5t4rP0gjvSO1ntyMaCHN/W3SBI6orh
         PDOC2qNmz+CSrPtWUqbuN3SMWAP1blj8Tvxn7wPqtl6q9TTxDjmjzZE1pzQof33RRSPF
         wLQ0zxX52k+gw/gJsi8RoR6VULC/yN9sFUEeSYzolFA4mV1cGAnL4DNzQ1DmLt6YoW/l
         j3rSwvh5WMu/9GThXhIhin0hAmp3LcEtF+sLmF1rMJt8Sq+ijliSbe4hGv8gsQe6kwu0
         hvQg==
X-Gm-Message-State: AOAM533mEtpW+zIAwIyBl9F8Nkp5QZKGnQPk1zKk7hf7CPammJ0u+kEC
        RahhU1UMpVLhc6feIIyNQ9CwSq8ou9/r1hLy/7+fnd+uu1Kp3awg1+9TJ67R1ad/Xu6FR4X74IK
        tD1iP02gGRGT0kDi64yWE9DMKJwE0YI1jAjtowWBqCR+p
X-Received: by 2002:adf:b319:: with SMTP id j25mr8072583wrd.256.1631539268293;
        Mon, 13 Sep 2021 06:21:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXQGN4lsPt3X80FcvViXLzjEb2mk7vyuKiz1WyuQZmj2rN0DA8sZRymOZ4nkeEBwSNZW4Pfw==
X-Received: by 2002:adf:b319:: with SMTP id j25mr8072562wrd.256.1631539268146;
        Mon, 13 Sep 2021 06:21:08 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:21:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 14/15] nfc: microread: drop unneeded memory allocation fail messages
Date:   Mon, 13 Sep 2021 15:20:34 +0200
Message-Id: <20210913132035.242870-15-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

nfc_mei_phy_alloc() already prints an error message on memory allocation
failure.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/microread/mei.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nfc/microread/mei.c b/drivers/nfc/microread/mei.c
index 686be3381727..e2a77a5fc887 100644
--- a/drivers/nfc/microread/mei.c
+++ b/drivers/nfc/microread/mei.c
@@ -24,10 +24,8 @@ static int microread_mei_probe(struct mei_cl_device *cldev,
 	int r;
 
 	phy = nfc_mei_phy_alloc(cldev);
-	if (!phy) {
-		pr_err("Cannot allocate memory for microread mei phy.\n");
+	if (!phy)
 		return -ENOMEM;
-	}
 
 	r = microread_probe(phy, &mei_phy_ops, LLC_NOP_NAME,
 			    MEI_NFC_HEADER_SIZE, 0, MEI_NFC_MAX_HCI_PAYLOAD,
-- 
2.30.2

