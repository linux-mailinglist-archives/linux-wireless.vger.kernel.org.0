Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6713DA156
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 12:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbhG2KlR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 06:41:17 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47840
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236430AbhG2Kkr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:47 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id DD1CE3F114
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 10:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555243;
        bh=vQB6RRzmQQRlWh6S5blKR75hWps+lidsZcEbJz9OF3k=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nml0jDSXVy3lXLhxTJ8QN4KV0wYeNSWSr68dcZw6YBXHAj3kOn5Wdr7b2OBtWDLhZ
         4CmrfjLIEmWIF0CDcXcU2pqGh87u0rIhe9+fDPv0J5OUdZNra7JuYnr0+FFqHHK2Yn
         l4Z6sZp3SvVsi5BYE0/GPZQjjriuj2nY+zETK8CNo0GlqEx1uBfwAT1MhH3899+cyQ
         fnqJs5qMwxPnj0tVkXnSqAADuzI/aTemgJaJJkK+utVvbUT46CPwEQIooZNGe6LgF0
         7mfdfd5stXg/O5HnVDsmz0q51+j1sXhjV7qVE7wgMl3Lfmvg1uogOVwW94LiEsE5tQ
         yOEMgSm/rfMhQ==
Received: by mail-ej1-f69.google.com with SMTP id qf6-20020a1709077f06b029057e66b6665aso1840958ejc.18
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 03:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQB6RRzmQQRlWh6S5blKR75hWps+lidsZcEbJz9OF3k=;
        b=Fm5n/NiJjHets3nrqh/V4nSoC04vrUWxLuAnXIET3FjO60cLXvUXhjNDCOuI9XwWns
         Gj3BnBjo6SDsYtq+ywcOTaI9WOwmc20mAX5KHi3WhlDXHOXYw5JZaKaV3TdmLMeQ7OSg
         ci4MtAkzuycmOmgz9Cuoah+nNhOI5CEqArGgV+yabWu90rFMUthC2CJTpjEoQDIxRy12
         fQn0pxQSWegDcQOE0x7dgiTuNw2xEY76a0g4AHq4KKF5XfEuvBRr1IDY6xIJYOFek4Z4
         d/00oWaPISXmTKmOrvqsCvT9WqqnQNwgDxJWJHynTQAVxQ3D7L7V05XLw/V3dFD3Gx5B
         jQFg==
X-Gm-Message-State: AOAM530E+YGAryUs4kve55jSaGSgashw3JPvtFd236uj2v4HHuRDdJpw
        DII1NM7cAcLj8cqEfl8gTVVr0ISLka+fcxm33VHQLkcRsyXDEABlsdk+2SGgSzfsRWOL2gJdGt/
        V8ZYZfdjYiKluXzbQyOdM9siJoDjTDiA4786AxbcFjEUl
X-Received: by 2002:a50:da0e:: with SMTP id z14mr5301144edj.73.1627555243684;
        Thu, 29 Jul 2021 03:40:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwijoO/q/+k8GRTBBEBcEUFMonWljYAnQQgqcZHQasMq3+MlfMPzmN1xs3UX4P2zxHnMrP0CQ==
X-Received: by 2002:a50:da0e:: with SMTP id z14mr5301127edj.73.1627555243524;
        Thu, 29 Jul 2021 03:40:43 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 08/12] nfc: fdp: use unsigned int as loop iterator
Date:   Thu, 29 Jul 2021 12:40:18 +0200
Message-Id: <20210729104022.47761-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loop iterators are simple integers, no point to optimize the size and
use u8.  It only raises the question whether the variable is used in
some other context.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/fdp/fdp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/fdp/fdp.c b/drivers/nfc/fdp/fdp.c
index 650a140bea46..3f5fba922c4d 100644
--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -611,7 +611,8 @@ static int fdp_nci_core_get_config_rsp_packet(struct nci_dev *ndev,
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 	struct nci_core_get_config_rsp *rsp = (void *) skb->data;
-	u8 i, *p;
+	unsigned int i;
+	u8 *p;
 
 	if (rsp->status == NCI_STATUS_OK) {
 
-- 
2.27.0

