Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A671640287A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbhIGMUQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 08:20:16 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33512
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344084AbhIGMTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:36 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 269534079A
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017109;
        bh=ZvGFi5U4zjTh+pnHq+nIFd+NOwEdjR6IPvbXckjfAj8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CYmZKOFezy++0nWrJ0qjVWtfMiOWvQOpGEgJa5q4iKLsqlpefchLg23Ub/gM222S0
         vVQuzstVUJJ55pPsrhd1xq2Bx7rGzjV3gZf5/0vcrLWpY1pTp68cmr9PwYZvneF12y
         N90H03myEkZCMusRkIjFmP5c0Dnc2pFnvISKyhwqp/WW9EJs8pQh2NwuaMiHRjeOjh
         JuWtop/COEI8b9xCAayiM7NnQXoNSIJNfPkBgWdLk4Qs/0IPL6OH+fhIajKyuyUozE
         2IZBIpGmOyTH56mhmHku0agMe+UzlEkyp7b19JWY4yJpn2TqVc9+6V8Ng0yZGs416V
         mBUYOCCyXd9GA==
Received: by mail-wr1-f70.google.com with SMTP id t15-20020a5d42cf000000b001565f9c9ee8so2055487wrr.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 05:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvGFi5U4zjTh+pnHq+nIFd+NOwEdjR6IPvbXckjfAj8=;
        b=F0tVGLDMkOa+Oz1r5Evs2GuQoLOrBd2YI6UqJgq0X3VUIw5O8QwzzcloFCeLqc3j9U
         d6XO7JAh8y6tVG06H67ewelFSGgilg2wl859xEd/tDlm2OU5Bel3L1PKuiKpUetdO2CH
         eKUUCQAce8US3aQoLuAiE6DXXPHSOLAIjmfAlFiU5X/DnQ9Scqg8U6r2bNm0jkfyUHWd
         DgPeyrxbUt/n9ojOH0qvSd+cFP3eT+8FurPatUR6QZyoAdpSwqRWo0eeF+oKcxYslE4D
         WGljiLkYMbwq0CnFZb+sAfb2PPRwJm1/ksQ5OqfSk9W9X/dF1YS1A1ECyZtQWCe1k9qJ
         jvCA==
X-Gm-Message-State: AOAM530IdEI2sfwuKeP8QgNnXy/Ok96z6umRVw1I71gqzaUYv5BfIK3X
        r8dX4VYLal9mnbOAb5JzXK5cBe/MtAIxo9mSqW5vWVVZwn8z9Q5z9UNVi8YcU/JsxXYKYKkeeo3
        hgKGoASujL1OFRaBPcTGrJntH1Zf2FUctfEqIH+FAohqr
X-Received: by 2002:a05:6000:1623:: with SMTP id v3mr18866642wrb.288.1631017108011;
        Tue, 07 Sep 2021 05:18:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPP0rxMIlB99OlQytxsYXswgaB3Zazfam9ab+Im0W3DSjzmYqWwvuiOBFhSweZVXznCZOlRw==
X-Received: by 2002:a05:6000:1623:: with SMTP id v3mr18866621wrb.288.1631017107888;
        Tue, 07 Sep 2021 05:18:27 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 05/15] nfc: pn533: drop unneeded debug prints
Date:   Tue,  7 Sep 2021 14:18:06 +0200
Message-Id: <20210907121816.37750-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn533/i2c.c   | 1 -
 drivers/nfc/pn533/pn533.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
index e6bf8cfe3aa7..91d4a035eb63 100644
--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -138,7 +138,6 @@ static irqreturn_t pn533_i2c_irq_thread_fn(int irq, void *data)
 	}
 
 	client = phy->i2c_dev;
-	dev_dbg(&client->dev, "IRQ\n");
 
 	if (phy->hard_fault != 0)
 		return IRQ_HANDLED;
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index 2f3f3fe9a0ba..c5f127fe2d45 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1235,8 +1235,6 @@ static void pn533_listen_mode_timer(struct timer_list *t)
 {
 	struct pn533 *dev = from_timer(dev, t, listen_timer);
 
-	dev_dbg(dev->dev, "Listen mode timeout\n");
-
 	dev->cancel_listen = 1;
 
 	pn533_poll_next_mod(dev);
-- 
2.30.2

