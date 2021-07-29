Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637BD3DA13B
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 12:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbhG2Kkm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 06:40:42 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:34450
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236072AbhG2Kkl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:41 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 7E3A23F230
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555237;
        bh=Cw3WxWMdLZ5M5UUT98hz5uB4oSAZN8UMdeHX+1yibmU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UA6W0mJepY+O8jhv0HDxrEZOfnFjSdBLv6/CymMIE833Vk6y7kg7C/1AsFH47TtpN
         BiV2vbnX0ApVhRNwH39E1KJVGGQqebXNJy934Xi9GQHev1+tLd8CM3GlSviElvf3g/
         5WECRMGgd8pqUavUveux178EATYz8klg+8PUcRLUGCRB7spU6t5mbUHN61BSPhGYsR
         HgHclX9OBvGeip8QjJikSCBAKK4HOaJ4tGUts0qAjroirzIYFdtRvJ5HsJH9jpBvZw
         dhw1/KtUOWyWjdNj89WyQStEc/UpeyY/h+m6xZLS6rodq7IH2MQjmHeHISc+wYJMq1
         ffG2z1SZ6yqeQ==
Received: by mail-ed1-f70.google.com with SMTP id d6-20020a50f6860000b02903bc068b7717so2748660edn.11
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 03:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cw3WxWMdLZ5M5UUT98hz5uB4oSAZN8UMdeHX+1yibmU=;
        b=qyrWeRRWiaka54CfOMLe5sifKoZ/P/BN3Jy7CCS/rQ+NE7M/eP8G5shfJM4s9mC3ke
         uWzzVMm8krLdwpA78/Ylw+6Ngpe/8V/vFnO/1jgMfarZSPE8xndUhgiLvY3EhYpR3PjD
         M9tlgDQzHryT3RJnrNC+Bk3RYCqJoO/EyjZ28T0wh7Q/1sLim1v5NonbCMkRNCDMDe8O
         aNJ9++tj9/zTIAkmHLkWYRdB4TCQ4xFoUHmD2+iAFmJG44scJlZGTASHj5S3iZWDBpZP
         dOTYswoAxZg0qgG3G9SlpdEFedY+yflCcw8Au7QoRKxw/F1ocQ/gDghqqMEh+56sIi6a
         SoEw==
X-Gm-Message-State: AOAM533aNjBcV4GF4MmOffNBKrb+PGg4aq3W1t89RhgwyXW7G+Osp7Hu
        r+WVcQAw0Jdtv989sdVMzsoxvxJhBoNS5oI75d84DyrrTpPCwAGu6pIF9Ub5vMLfcSvZQotHFBS
        3HxxFsqGJVBGrpstLYdYKab/kk56hmXDDkjs6E4SQVj5B
X-Received: by 2002:a17:907:1190:: with SMTP id uz16mr3961129ejb.543.1627555236309;
        Thu, 29 Jul 2021 03:40:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyelGCc7LxjALvK3umx0eo+PexaLLnBk1cGkBUbydBmcQuE3sbk2nmw8yhHldZtMsl1cgWHbw==
X-Received: by 2002:a17:907:1190:: with SMTP id uz16mr3961115ejb.543.1627555236127;
        Thu, 29 Jul 2021 03:40:36 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 02/12] nfc: mei_phy: constify buffer passed to mei_nfc_send()
Date:   Thu, 29 Jul 2021 12:40:12 +0200
Message-Id: <20210729104022.47761-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The buffer passed to mei_nfc_send() can be const for correctness and
safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/mei_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/mei_phy.c b/drivers/nfc/mei_phy.c
index 41146bb99474..f9cca885beec 100644
--- a/drivers/nfc/mei_phy.c
+++ b/drivers/nfc/mei_phy.c
@@ -202,7 +202,7 @@ static int mei_nfc_connect(struct nfc_mei_phy *phy)
 	return r;
 }
 
-static int mei_nfc_send(struct nfc_mei_phy *phy, u8 *buf, size_t length)
+static int mei_nfc_send(struct nfc_mei_phy *phy, const u8 *buf, size_t length)
 {
 	struct mei_nfc_hdr *hdr;
 	u8 *mei_buf;
-- 
2.27.0

