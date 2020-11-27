Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF242C6B32
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Nov 2020 18:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbgK0R6g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Nov 2020 12:58:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732609AbgK0R6a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Nov 2020 12:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606499909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=4LunoHOSViYokVYuRCQyRja8YCLtsagi9dLGWhl23qk=;
        b=J+X0KHhY3a9WUY2q47gY3A6Rv1Zgz2tYurLlO7wew49c7pBDzA9cky4OOzOPZobNhYG+f/
        BLSDsqg1SRc125GAtHDNXGGqJB4lMivGZ8cCfLPwQqWiiAQXCVPRiayfrH4/++shc5/usu
        UBGxaLrASix8iYIe6zZMdcS8Fb1NGtk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-ieBRc8oWO0aZAQ6v2_Uubw-1; Fri, 27 Nov 2020 12:58:28 -0500
X-MC-Unique: ieBRc8oWO0aZAQ6v2_Uubw-1
Received: by mail-qt1-f197.google.com with SMTP id o12so3390387qtw.14
        for <linux-wireless@vger.kernel.org>; Fri, 27 Nov 2020 09:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4LunoHOSViYokVYuRCQyRja8YCLtsagi9dLGWhl23qk=;
        b=N9RcN6uCXiG70sHs6syCaaMNf9Zifr2JLyGH7qepo4OnyuPsUByVH8UtRr3ZURe6QF
         MtS/KH8Hy96ajVy8kZxINUP07mtOZqyG1ZqXspDwowVJbsJt7tFSo9MO2blBE90AIIA+
         fYbOSLkLDynD/zuQSL0Ukcm23wBaynG2DKiz3HiMsJECT/HxrVsaN69AFLlkoQxw6LU7
         8rKp6vRB3J2wfzIDjKHUXrk6oGyLDr74kU5bWnbPBdlkbDersk+kqsA4ZvcHMphilIqX
         O03KV2bKhHeEp9tK3LmeJg7IEkEaNErDjsoDFY8vEOCTSmeBC0YNvn64LvQ+5Z8WbRjK
         nzxw==
X-Gm-Message-State: AOAM5337E6xpQzjwh0oHUQ7jLzFJlC7BQL3hAHuEwEiozs2sivhJLzCA
        o9zJPpAH+I6x2boglrkRkd6AFNfQwcJjzMDfiqlrOz4V6CbgBm9iG/zYrO9ZnPKV5SRjXKECvvA
        I5E3dDJW31RN1TqOw3FWkkvh74uE=
X-Received: by 2002:ac8:6b11:: with SMTP id w17mr9671573qts.150.1606499907467;
        Fri, 27 Nov 2020 09:58:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqc/CVfNGFpfgITGO2zbYhtL/kIf2QRQ37Phb2eGz1BpPgYqPvhZRP+ayREWsyzYkbW84qZg==
X-Received: by 2002:ac8:6b11:: with SMTP id w17mr9671560qts.150.1606499907295;
        Fri, 27 Nov 2020 09:58:27 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s68sm6416127qkc.43.2020.11.27.09.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:58:26 -0800 (PST)
From:   trix@redhat.com
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        bigeasy@linutronix.de, mpe@ellerman.id.au, lee.jones@linaro.org,
        kieran.bingham+renesas@ideasonboard.com, dan.carpenter@oracle.com,
        adobriyan@gmail.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: cisco: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 09:58:21 -0800
Message-Id: <20201127175821.2756988-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/cisco/airo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 74acf9af2adb..ba62bb2995d9 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -5785,7 +5785,7 @@ static int airo_get_quality (StatusRid *status_rid, CapabilityRid *cap_rid)
 }
 
 #define airo_get_max_quality(cap_rid) (memcmp((cap_rid)->prodName, "350", 3) ? 0x20 : 0xa0)
-#define airo_get_avg_quality(cap_rid) (memcmp((cap_rid)->prodName, "350", 3) ? 0x10 : 0x50);
+#define airo_get_avg_quality(cap_rid) (memcmp((cap_rid)->prodName, "350", 3) ? 0x10 : 0x50)
 
 /*------------------------------------------------------------------*/
 /*
-- 
2.18.4

