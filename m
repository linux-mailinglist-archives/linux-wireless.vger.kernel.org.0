Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7366408D92
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 15:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbhIMN1c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 09:27:32 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34274
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241734AbhIMNZ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 09:25:27 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6652C40281
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539254;
        bh=NBr1U4LAwKajfkWi8d66f/F7DJmWNcP01ndf/w7qpqs=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=eKne7l7JsWA9Oyqv1ej25m2CyAPojw00ksawllNBhUEzH0ZbiNYz83s/f9tfqky5F
         nIdM5nruK+ENQJgamMXhOKzqvqbmCXZ0H7gNdv623agZNW7W2TuB96pz0byZuS9kyg
         1gIsNpbQ/fU/u2CvHGQ7E4mmq4mZF83AJeCB6w2dhSVcMdPe8ZpB4/rbC/mVA9BAH3
         jRY1ekDZCtXtrgeMFeSLZzbPulME9H2eq2URilg78BcpkGrFBSPkCj3QHpTJIw+OJb
         fpCvjHdVDEuROrY95Re+jRus9/7YOom1q421gYqjLlWq7zNYRyfRgH8AR48iUwxE9P
         KRmlgh5GimozA==
Received: by mail-wr1-f70.google.com with SMTP id z1-20020adfec81000000b0015b085dbde3so2656958wrn.14
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 06:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBr1U4LAwKajfkWi8d66f/F7DJmWNcP01ndf/w7qpqs=;
        b=Ubd1mB+EyZGNZ2raG4Wyd3mrgkc7EuWZ6t7cnNZw8NerroNk0nU+WYhDvPchUomBuj
         XEnMgDdUcTiw1Ybmyvq1I3dgPoi6DybFY7Gr8at0S2Y37+cb5nssL1H8WLxUWcxfWHc4
         2eOK6U9Y9mVrhJqNJV9sOnp1YptppSuS/HhxL21E0yXEv5ptVARYN0e2GzkHo4t3oOfp
         fbYXmXGVDlwTGYYIONTTt9TOSszvhcc60WUhIBDbHvcX6SmTTnvX8dWACOIGpwc782tO
         w7g2oDakyjE0m4yEFl5wEhfTq3W61EVbmGFNzRHm+ETjrO+Kvul157lqt+XWmd/AwOYy
         crig==
X-Gm-Message-State: AOAM531kXnbJ5LtlbZcpx+pgZYwPMWDtg+gI9c3G0AhkRIS6x1HwI0RJ
        /XAmE8gJP7UHenrZYJxHjhtqTQbhXwFZmsm5jDBIOD1oJX3YpnwZRlniaxBEp02sNiCliyXCDYp
        Pf3t6hl67U+YZjU+XoYU+iFC0R2ZqNSC1Bj8jgsRuOlk0
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr11300819wmc.3.1631539253795;
        Mon, 13 Sep 2021 06:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4mhlijtrqBRrwe325QIJTV+NH9oRbw4vOfFD3MMxQ/lm7QV3e8395RpL+PFPpNFF13sZ40A==
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr11300790wmc.3.1631539253600;
        Mon, 13 Sep 2021 06:20:53 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 07/15] nfc: pn544: drop unneeded debug prints
Date:   Mon, 13 Sep 2021 15:20:27 +0200
Message-Id: <20210913132035.242870-8-krzysztof.kozlowski@canonical.com>
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
 drivers/nfc/pn544/mei.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nfc/pn544/mei.c b/drivers/nfc/pn544/mei.c
index 5c10aac085a4..a519fa0a53e2 100644
--- a/drivers/nfc/pn544/mei.c
+++ b/drivers/nfc/pn544/mei.c
@@ -22,8 +22,6 @@ static int pn544_mei_probe(struct mei_cl_device *cldev,
 	struct nfc_mei_phy *phy;
 	int r;
 
-	pr_info("Probing NFC pn544\n");
-
 	phy = nfc_mei_phy_alloc(cldev);
 	if (!phy) {
 		pr_err("Cannot allocate memory for pn544 mei phy.\n");
@@ -46,8 +44,6 @@ static void pn544_mei_remove(struct mei_cl_device *cldev)
 {
 	struct nfc_mei_phy *phy = mei_cldev_get_drvdata(cldev);
 
-	pr_info("Removing pn544\n");
-
 	pn544_hci_remove(phy->hdev);
 
 	nfc_mei_phy_free(phy);
-- 
2.30.2

