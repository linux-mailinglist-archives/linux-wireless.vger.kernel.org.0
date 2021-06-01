Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6906C397624
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhFAPKW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 11:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbhFAPKS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 11:10:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9F3C06175F
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 08:08:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r13so7939416wmq.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oAnhL/rLVHOlPObR2Xdk1DvWetZIgbSOpJEsqp74oTI=;
        b=td7Ky7vIlMGR0lzB9NGPGL4DZjzHaMJwurupmI6h/cvMBTHZd5bT55tplls//PeW3r
         NQQFaw9Iqpf41xUP6IlbAkhxbl2y5YUyoP3LbQHZHBNhj6nNDFn/sBbPZoo9xBI6GCpV
         bMd5+BJyY0YHfBtzilzIwN+9BQQ2idaM+THk8nixSlUBtiDrx+dZ2DfKOkIevtAEJXLf
         xxFRiKkB8SXfO+JW0pOguRDmiQ/WTqNu6c97ZscjQnWjL4FV1rW6NlY3JpLZko9t8DbQ
         K/+ezRt5IF8/cmDI6E9hcHkNtQHPKP7/73V44zlBZ/DfBcbUwYC9K6eKNgH+V9x3lnoV
         w87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAnhL/rLVHOlPObR2Xdk1DvWetZIgbSOpJEsqp74oTI=;
        b=DYNnHtyye/gdYW8Q5VKvk/EVoBBnXjFyT9CE2T2asYkf1zMm9XGAKXprxt7mkZbvfc
         U7gc8u0Czk1i3nTQAl7zrXUCaQkdJTXuiWAJdvlOZb0VBgkKzdPs/iovMUCgbKgn6Sd9
         Pu8AuDp6CsnaBGNGrrkaVbfi7U343ILAknx4jb6SPy8537KxwTlqe7XNm+XfHYefEVwG
         zEU5EEiFIiX47be1J8EJq1yJO+rZNvYed3NLfZheMdO1x76P01xhCNNqylyfgWfgciQf
         VoiTM9Dn/jAvCYyqrjZYTHG17uuGCwMPprAC8Gcn5RuLg4RocrDOCnUWs/9JoiRCyEVC
         eSsw==
X-Gm-Message-State: AOAM530jxdzgCTP4QSmJSdF0dxMiTFgBvVSL8yv8frKPeEvBu7T+nbOs
        NPvjofhGY3w8Cdab4NWEWT1RGTPqASv7BypI
X-Google-Smtp-Source: ABdhPJwJqafd48wum43RL99sem9jK7q+JKlxRuEBH5mmFrXHbPEl5wWGgnzFCJaBdpka04kl1SCeSQ==
X-Received: by 2002:a1c:4b0d:: with SMTP id y13mr7381400wma.179.1622560114474;
        Tue, 01 Jun 2021 08:08:34 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o129sm2822237wmo.22.2021.06.01.08.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:08:34 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v5 12/12] wcn36xx: Enable WOWLAN flags
Date:   Tue,  1 Jun 2021 16:10:01 +0100
Message-Id: <20210601151001.1450540-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
References: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable flags for

- Magic packet
- GTK rekey

Previous patches implemented the necessary code to switch these two on.
Standalone magic packet absent GTK rekey is pretty useless, so it makes
sense to flag both at once.

Once done it is possible for wcn36xx firmware to

1. Respond to ipv4 and ipv6 ARP/NS lookup requests
2. Bring the system out of suspend when a magic packet is received.
   Magic in our case is a simple ipv4 or ipv6 unicast.
3. GTK rekey whilst in suspend
   Once we wake from suspend the GTK will be updated as necessary

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index c697b9f3633a..3a4e383b3a6c 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -173,7 +173,9 @@ static struct ieee80211_supported_band wcn_band_5ghz = {
 #ifdef CONFIG_PM
 
 static const struct wiphy_wowlan_support wowlan_support = {
-	.flags = WIPHY_WOWLAN_ANY
+	.flags = WIPHY_WOWLAN_ANY	|
+		 WIPHY_WOWLAN_MAGIC_PKT	|
+		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY
 };
 
 #endif
-- 
2.30.1

