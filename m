Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E36408D70
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 15:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbhIMNZm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 09:25:42 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57992
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241235AbhIMNXk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 09:23:40 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0E6173F30E
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539252;
        bh=YdMV9AtCFFKriT3c6sHpvFf+xJsEOIFlGHmRsaTySis=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=HOAAKwvdpdmyH4tdpGVLfBqD7m7LYolgeZaXaejKnCYlIkAt+0WOppnAKz2z1uvmy
         lRxcsgqJWAwqztZgs00xu+3VwdmR9CGLiuhoKii77BVNDeUHux8Meo/97gXwRRJPEM
         PwgTSn2e9HlmD9jc03v9jgYNaB9RaT78pBDzO2uqEodYlGCIBj0zWUVLHhJl58x3Qe
         MsMZwM5ixJ0ZBKcn92c9ite40yrYPNabkOeaOqkx1eM/WTvsjHnLQXxPjA7ggLekS0
         MaA5GKbH0bFRmdgzhJ9EMJBf4BIGTPTUIP/kzuz7ZdA55D2tYE6xcoqiqEmzzdm+NX
         Pw18Y5UF936AA==
Received: by mail-wr1-f71.google.com with SMTP id u30-20020adfa19e000000b00159aba4fe42so2659007wru.9
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 06:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdMV9AtCFFKriT3c6sHpvFf+xJsEOIFlGHmRsaTySis=;
        b=tmANt7C0H3BUb3ZVKQsbZ3TmsMw8aPeVNcHX5FmhBA9IQWRreavCHRQ6+GaDlMTx6F
         lfCCHzRry53xo1BQuWYuGiu2eaJRPeczmiHMJiQbXYZLdg/2QI55tSf0LhzoKd3i+ppQ
         uFJHMwXNTB6CjhiBugeEY+i9BwiI5f8fadRICClaK+q91YGDqTqHbH7UPozHJq8UUjnd
         5DYQVNw0e3KRhhLJJCGDCusx4Ioqao+Ja6ySysQTOKcFzmgcIcpWINJ9DPfZNb0KkkCe
         aA1Qn3RuEBrzlV1u/gEEs5OurpBNW/d6ivh8A4YUt4Hh6y/0hh9O7QGSyB9JkgVWkiO9
         TkLg==
X-Gm-Message-State: AOAM533y327Yt8IwcHBfCef1KQ8XxjnVxEKuF2zPkKiWMSAcaD4123o5
        ffqLSHU4k38c3NBCZzTD2KBpIEYNZyIzHNhd1Ttr8Gcma/fnDFsVnBXNVYyTnlSAiFXge/B8gPY
        +6KUYcgmZdExF06hbSaahja7Vxng3BLMcAlZ8kVjpVf5L
X-Received: by 2002:a1c:a911:: with SMTP id s17mr11244118wme.84.1631539251774;
        Mon, 13 Sep 2021 06:20:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDKCa2J0aDKEwfGljc8lrJwSBXahWxEFgvrIqIssT5ml8sBzDELvL1CsHBBwjLD7+R1dAL1A==
X-Received: by 2002:a1c:a911:: with SMTP id s17mr11244098wme.84.1631539251649;
        Mon, 13 Sep 2021 06:20:51 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 06/15] nfc: pn533: use dev_err() instead of pr_err()
Date:   Mon, 13 Sep 2021 15:20:26 +0200
Message-Id: <20210913132035.242870-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Print error message with reference to a device.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn533/pn533.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index c5f127fe2d45..da180335422c 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -2171,7 +2171,7 @@ void pn533_recv_frame(struct pn533 *dev, struct sk_buff *skb, int status)
 	}
 
 	if (skb == NULL) {
-		pr_err("NULL Frame -> link is dead\n");
+		dev_err(dev->dev, "NULL Frame -> link is dead\n");
 		goto sched_wq;
 	}
 
-- 
2.30.2

