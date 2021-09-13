Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794D7408DEE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbhIMNak (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 09:30:40 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57996
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241247AbhIMNXm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 09:23:42 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BA7573F4BE
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 13:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539255;
        bh=alAZCnXDBZFqFGCWdjT1NtYwVcFPW4mHC6+AQVNQmag=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DiHvUSDj8TvjNvAVoX5U6pEsOSih/KSUNCG94ei+WC8RkKpZl/xZuWDgoh3cMY/Ep
         JKdnaO7seOPk3NEYLvXEllNk09mTGa/X9dk+40bPkX9bwGG8Rpp1o6blGAF7oSPcvm
         4tHHFYNln/ws1PvF6kFez6nI6iFXfg5T+Jw5bBjD+v79hgkKKoNhSPMqb3FiLMXSti
         yKHievZQXsE2WxPMQrw+pa7mcNQkOvUS2OUFJcnbHC3YOPrwjklgu8brVt+ZP0wCF8
         SYNODSTLNCKDHMQ7mymSdbm5+Ni49s9rzyAJdi9Yyf2XoUVqe3sTz8qss+41jocfkg
         aYpBH/RrjLQfA==
Received: by mail-wm1-f72.google.com with SMTP id 5-20020a1c00050000b02902e67111d9f0so4913027wma.4
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 06:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alAZCnXDBZFqFGCWdjT1NtYwVcFPW4mHC6+AQVNQmag=;
        b=A+wZd0qf30PRhCmJS0MhpIvo8yw47T79V75u5JA04bZEIieLCuUC9ipjW3pk9ochKh
         NuPK0wwBV5IYLD8Ztsm7cjvfP7eCc8Aq16JIPTL/OXa6V1HoisZchEPUhZPbRW90LXWd
         NgVm4GKULZogyQKApGAYDyyDvKybLPlBkfdozEp1thhence9LIuqOP9UiiAYoXxKihYY
         VxCAm52lDablIyOMEXcb/35lj70B2I6dexKOgTjwTdr/l+tsf87pi0cDPSTPHi+ElOJl
         i4LMk7meZ8h7fXwih3Fs64JACwkObjVBfr+Lhmu4FoJa4zNyVh4y6XD8jJKI2K9igHN1
         y7Iw==
X-Gm-Message-State: AOAM530LbUCJIhNgcDU24xkbpOyEfDgWI3F/VKwQwvov6HEc9UpCYHLp
        Xra9tjSTTjKT/7nZ6+l8GK31QiIems1gT9+pDtGEzRy8dbjkq5m3eX/63XOWgoVpPzx0Il4goo0
        UtRzunPb6PWGj8VmY4IHLHEjBvcvk80A7Y8ISgSpMJbvV
X-Received: by 2002:a5d:6792:: with SMTP id v18mr12576738wru.416.1631539255420;
        Mon, 13 Sep 2021 06:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY6LXmCoBiMxgVg0ZBqajR5G6WaCpegfR/vq0xViC/Z1KjH8g67spH4c6MeVe7uNeK0A2zmQ==
X-Received: by 2002:a5d:6792:: with SMTP id v18mr12576720wru.416.1631539255299;
        Mon, 13 Sep 2021 06:20:55 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 08/15] nfc: pn544: drop unneeded memory allocation fail messages
Date:   Mon, 13 Sep 2021 15:20:28 +0200
Message-Id: <20210913132035.242870-9-krzysztof.kozlowski@canonical.com>
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
 drivers/nfc/pn544/mei.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nfc/pn544/mei.c b/drivers/nfc/pn544/mei.c
index a519fa0a53e2..c493f2dbd0e2 100644
--- a/drivers/nfc/pn544/mei.c
+++ b/drivers/nfc/pn544/mei.c
@@ -23,10 +23,8 @@ static int pn544_mei_probe(struct mei_cl_device *cldev,
 	int r;
 
 	phy = nfc_mei_phy_alloc(cldev);
-	if (!phy) {
-		pr_err("Cannot allocate memory for pn544 mei phy.\n");
+	if (!phy)
 		return -ENOMEM;
-	}
 
 	r = pn544_hci_probe(phy, &mei_phy_ops, LLC_NOP_NAME,
 			    MEI_NFC_HEADER_SIZE, 0, MEI_NFC_MAX_HCI_PAYLOAD,
-- 
2.30.2

