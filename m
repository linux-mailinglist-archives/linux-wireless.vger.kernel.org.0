Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7940F4D7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 11:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbhIQJem (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 05:34:42 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49110
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240289AbhIQJei (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 05:34:38 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 016DB4025C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Sep 2021 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631871196;
        bh=tTVAXZIbg+nscSqjGmCmN2vkVa6NbzShnNR0nlGi+3E=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=CwGvvE5kJnLvBrKvdUvQXkLh2nIj75e1qnOzVHo/cGFraidGEkRdU406EgK33B2Bl
         d0jjxYIta+TPYHXYtdYMoEebn6pIVFCOEJZPLqC0KEru11pRndAE2GKLvRxUCOP2JN
         CSyroi7SKNJjV1XZ/TNC4+6ZvrYabTDIO3ssbpP6wUsJpvFvI32tWK2gqvuCO2uG0m
         z1EHFWbsgs2DwQvZAzcGcT8MnCNJXZcuIJH1Y1vBXUX+tbdPLvGtWEgFmcggS21wzy
         NZH2L0ivF07dXVfxM+DjGkspT2zUY0JHdywKcL7R9J8gsbwv0aK8w3OvJ2W7oD87hT
         zHbVDKtdEufYg==
Received: by mail-wr1-f70.google.com with SMTP id v1-20020adfc401000000b0015e11f71e65so3507720wrf.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Sep 2021 02:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tTVAXZIbg+nscSqjGmCmN2vkVa6NbzShnNR0nlGi+3E=;
        b=Mc9Bpv7/5Pby1tvSproFWaiy4LPugmUMwCSE5FRwtHd8eYqsyFjOt3tdD2NtG7VLlZ
         D5LvabY4sfBrpcQ5TDxEzXv9w3snhYUonGc5d7KSLsGERtEbOm/fTASLUPpO8nG3C1gC
         pEODAxC8F5Cm4P7/CedLXjczJVHcenEbcnMpy0vPVsoUMWY0KMfe35xatuBRsNd/CJvg
         MT688PskABG6cV4LoTiz/LmPHLlH5sAko6YvZgA/AdvtsIyAdHXDb4MrTJZhktyHbO43
         sAK7Vl37LWZ4/z+q3+CDJhWP+/W66tVmeO78Hi87XUyb2sCw6JHlrvbB9SciXo6JR0ak
         oGaQ==
X-Gm-Message-State: AOAM531j1wCnGZSmmow2hF6qkGIhGJusCSOJVbA3Fl/6BBeMfrSoCPrb
        sxKaIHJcUomuYMsj9WJ0oRwtd5MeGH2/BKd5JX4S4O7OjtoUxuVliwIiJEOIrJRWrpTyq6nRYlr
        iISdgeU+pL8gjPYm28/PQJXrpUtqpIYM1pf1s2zFd+K7/
X-Received: by 2002:adf:c14c:: with SMTP id w12mr11065391wre.115.1631871195642;
        Fri, 17 Sep 2021 02:33:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm1hfXlP9qxMJBeO0j1bvcei+pQ6mYrjdqgYy9bQhs+1gR0op82yXutPeFLLb3ukLhOIeHeg==
X-Received: by 2002:adf:c14c:: with SMTP id w12mr11065374wre.115.1631871195486;
        Fri, 17 Sep 2021 02:33:15 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n66sm5770333wmn.2.2021.09.17.02.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:33:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulrich Kunitz <kune@deine-taler.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, zd1211-devs@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Drake <drake@endlessos.org>,
        Daniel Drake <dsd@laptop.org>
Subject: [PATCH] MAINTAINERS: zd1211rw: Move Daniel Drake to credits
Date:   Fri, 17 Sep 2021 11:32:36 +0200
Message-Id: <20210917093236.21424-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Daniel Drake's @gentoo.org email bounces (is listed as retired Gentoo
developer) and there was no activity from him regarding zd1211rw driver.

Cc: Daniel Drake <drake@endlessos.org>
Cc: Daniel Drake <dsd@laptop.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 CREDITS     | 1 +
 MAINTAINERS | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 7ef7b136e71d..d8f63e8329e8 100644
--- a/CREDITS
+++ b/CREDITS
@@ -971,6 +971,7 @@ D: PowerPC
 N: Daniel Drake
 E: dsd@gentoo.org
 D: USBAT02 CompactFlash support in usb-storage
+D: ZD1211RW wireless driver
 S: UK
 
 N: Oleg Drokin
diff --git a/MAINTAINERS b/MAINTAINERS
index 15a5fd8323f7..92326aa23f35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20750,7 +20750,6 @@ S:	Maintained
 F:	mm/zbud.c
 
 ZD1211RW WIRELESS DRIVER
-M:	Daniel Drake <dsd@gentoo.org>
 M:	Ulrich Kunitz <kune@deine-taler.de>
 L:	linux-wireless@vger.kernel.org
 L:	zd1211-devs@lists.sourceforge.net (subscribers-only)
-- 
2.30.2

