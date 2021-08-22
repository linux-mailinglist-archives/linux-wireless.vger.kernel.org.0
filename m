Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B323F4150
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Aug 2021 21:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhHVTub (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Aug 2021 15:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhHVTub (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Aug 2021 15:50:31 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58CDC061575
        for <linux-wireless@vger.kernel.org>; Sun, 22 Aug 2021 12:49:49 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id x9-20020a056830278900b0051b8be1192fso9735841otu.7
        for <linux-wireless@vger.kernel.org>; Sun, 22 Aug 2021 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CC9gKDezogjb3lBxOHKaNmmDUKbBZiDh5x9l+iGH4VU=;
        b=oumz+cXSoOQIjDzllwHY8cjjgF1T2JfEz7EmGXaIT2lWViEzeJ6hLW8pbMxOjTLOpJ
         UqVOCQ4nmlEQNbVHQyc5C8I1Ng+WMUt9Uwn3YOU0HGkdtS6k4jRiCGHqesY2zU2RPk/Z
         mLjpnXhU1WepNP51YhNsFJZ/1EQ26WvW0jSLExrLMU/VQF/6i9nN7gxwPI/6BjMJUHtD
         Sk6RrveZrvK1VqtH67yG2l//rlNeoQIyKVgDVjYHDZAOt9lPsL/AYedwNsdFhTwnURh1
         1+8w6aTqnZIMjcZc309GtwwLWWfiNEjnhsHQzbaikeC28///0CQncezzTTNRlrUH2Nu3
         KhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=CC9gKDezogjb3lBxOHKaNmmDUKbBZiDh5x9l+iGH4VU=;
        b=YeG+NIX1dQWK4CqH2I3EQo+Dm9FM3hLo+M+8br+Ud95U62lHdISXmT3e+N+7R/UFQ2
         /BjDEwinjKRgTdOe9nDefLuDPw01jyHKiTny0SYg9F4JBi6slHw4+ssOcBH5+uvvNXTC
         awaHJ+givyijP8oJ8BQkoOumbvmJPHhlV0KU6m4l1bNW+JtFkrwul9uye68clH821GY9
         5zY8U0kSomOfgvYiSLE/KV5vPnwCy04Eez1KjhrDefZsQPV5KJRJwxJipNiN2ZBRyCmD
         Y6pnX9qNu0fI90/MbK+KIajJOge0NPRytxwJEq4VfAB8XgypSNeUr5qhZh5xjrUgf/bC
         iQHw==
X-Gm-Message-State: AOAM5328XRXhv+0nN0V+7wWTqXxd0zKAs0zZow8LEk7QvNAMvEZdDIQv
        4gzUGqK+UWK8Yu08eTppU4Y=
X-Google-Smtp-Source: ABdhPJzs7OhnwgvBMm+uhlqHDlDPikn4riEUmCIS3VIkrQmBUoBpcqSPBWnJJiznz6flS7GZZB9W8Q==
X-Received: by 2002:a9d:450b:: with SMTP id w11mr24555134ote.254.1629661789153;
        Sun, 22 Aug 2021 12:49:49 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com. [2603:8090:2005:39b3::1023])
        by smtp.gmail.com with ESMTPSA id l4sm1759904oth.4.2021.08.22.12.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 12:49:48 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Ugo=20R=C3=A9mery?= <ugo.remery@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v3] rtw88: add quirk to disable pci caps on HP Pavilion 14-ce0xxx
Date:   Sun, 22 Aug 2021 14:49:32 -0500
Message-Id: <20210822194932.29630-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ugo Rémery <ugo.remery@gmail.com>

    8821CE causes random freezes on HP Pavilion 14-ce0019nf. Add a quirk
    to disable pci ASPM capability.

Signed-off-by: =?UTF-8?q?Ugo=20R=C3=A9mery?= <ugo.remery@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - add s-o-b line
v3 - added s-o-b line for =?UTF-8?q?Ugo=20R=C3=A9mery
---
 drivers/net/wireless/realtek/rtw88/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index e7d17ab8f113..31ee859d379b 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1701,6 +1701,15 @@ static const struct dmi_system_id rtw88_pci_quirks[] = {
 		},
 		.driver_data = (void *)BIT(QUIRK_DIS_PCI_CAP_ASPM),
 	},
+	{
+		.callback = disable_pci_caps,
+		.ident = "HP HP Pavilion Laptop 14-ce0xxx",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Laptop 14-ce0xxx"),
+		},
+		.driver_data = (void *)BIT(QUIRK_DIS_PCI_CAP_ASPM),
+	},
 	{}
 };
 
-- 
2.32.0

