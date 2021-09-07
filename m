Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD15402891
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 14:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344457AbhIGMUv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 08:20:51 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33686
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344477AbhIGMUC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 08:20:02 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6A1EB40824
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017119;
        bh=KQ0ijwIeFsveeXdiNAQIdSvmUM7JWh6ALRqQaOVckDE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=wdnn4Cu+1kPZwLD8NSz8v4+gilcSmMUNzV19dgbI8z7OTYIm2VXD0H26q7CVS0LZj
         yljS/ufJWBhbS/vOu54tXmjjowYXkYptc6MqU18Wu+GLPJlOKcSag9KpzRK6VWHUI5
         1UaA7r+j6H8qnaWHjz902P+1V2FL2pYJB1kMH6o2b57CIKo7Lj8XUYHNk8EUlefj4Z
         /dqXgfX117aM2QSFadNarzKjSA520y5UEYG2gUt+GsfJge7We8YCLW+HoMusrEaUJP
         0Glsx42KKI0/e3z4u5KoSbsxyo9sqE8RhUF9U//V8EP2zp3H+3p6wXArsOsrhXbo54
         dTAhJ7X/hTHqA==
Received: by mail-wr1-f69.google.com with SMTP id j1-20020adff541000000b001593715d384so2046623wrp.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 05:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQ0ijwIeFsveeXdiNAQIdSvmUM7JWh6ALRqQaOVckDE=;
        b=FO0fSO/GW/DYpyfNbK699+bVkaYvAMrIUJrY9A1xMc/c1mhqRx6+JDaV0MPPxawjxd
         GHNHvK74bU+FS3wZqRsg5m01OUS1DGoKprxoZL2EavEbwbXPL9IhIwmZnQ/gTP5TqbM0
         EqHVcl3zvkCvyP4PJm94yBwkrNTUncMTgpajrpSdaqBl03FbX2x7Qb8qPf8UuYW1lJAd
         uJzGsuh/vgn3fGgbrKopgrLTOTMB2K0nHA29rQYFEivZdHreTJXCDYcHt/qPma3hYWpz
         BHSQmQ4SU56j255JLgo2vKGuuwt2TbGDjUFnkR/WGkeKWw+DPlXhi6eM4cawxIhXcEFg
         7d6A==
X-Gm-Message-State: AOAM533qOpIosH58BnH2N3YroDFMKKU0uJCttbXN0V/jcRdS4g1AaBsG
        Va4+bZhAvQHiP4+6JdTQ1MtCkuqfEM+TL8u5mUDqRVayCTtz74kJmo7CCVnjeeMmq1HDFcrjEuC
        kZLNJeR7D5C0Y1X253XmvsvJknnpbb4MOHbJrd02b+idI
X-Received: by 2002:a1c:4e02:: with SMTP id g2mr3721764wmh.64.1631017119172;
        Tue, 07 Sep 2021 05:18:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQnetzmuiPkZxY5ujifiMc0ZSDMSRGclmWVVBN7PzhHJltL2XOpfe1Q53piPXGFgUJqPpP0w==
X-Received: by 2002:a1c:4e02:: with SMTP id g2mr3721745wmh.64.1631017119053;
        Tue, 07 Sep 2021 05:18:39 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 14/15] nfc: microread: drop unneeded memory allocation fail messages
Date:   Tue,  7 Sep 2021 14:18:15 +0200
Message-Id: <20210907121816.37750-15-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
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

