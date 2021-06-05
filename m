Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FCB39C4C9
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 03:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhFEBNK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Jun 2021 21:13:10 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:34350 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhFEBNK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Jun 2021 21:13:10 -0400
Received: by mail-wr1-f53.google.com with SMTP id q5so10967759wrm.1
        for <linux-wireless@vger.kernel.org>; Fri, 04 Jun 2021 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oAnhL/rLVHOlPObR2Xdk1DvWetZIgbSOpJEsqp74oTI=;
        b=GrHfUEWKjurl1ciAfg2VIP28dimAf7b7ofB33I17yzchXsa9ImRgc+F7SZyhcv7wIP
         fSnN/gjO9vjBV5/47XBSoai+YiIkMw7XLwtsLr9xHyFnnWuvktZCAIwj6UFxzLkU1g6V
         MsfCw1GkQi1k2GOth14jRaayjiS9BfS8D8a5uFjj1QcnEp3CkFAj1nKskH3nCc6kDvqT
         8b89DplyNeKLLXQHQuhDUcCXwm3pMz25CHl0RHSVzbHGWSNxDnwfh5ZfRI8jvOiGIQTN
         w7N7mDuJWvau4qcBKg5O+kcBDGlIL6pk8WqxjIL8ug7DeX8URxhGiHfcYsRq3sp3nK+3
         Ouyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAnhL/rLVHOlPObR2Xdk1DvWetZIgbSOpJEsqp74oTI=;
        b=TY7PB/LAOjJmSlSIqDh7OBQ+DUteXKXI8IJwwTVpcq9lUWm49avnsMBFyaw6eXK0pN
         PwvPd4DxYdnIHV+CSKSRa5ekz2C9PmywszwIld7cebtxiWPSD6HOIkMfQ8sxR6g42aF/
         ymM0Wbtx+8kkdBQa9Odw7x48xd9HLHKQVwQTMXvk+E3CSJUzQLFAcULkMdtTRRJL0sqG
         xnLDS272jGKK7U/vhDrz8HJwAAH5ahACrwOHTmFD4cKcF1evZafy9O8BFMkq9a65WOmy
         BohAa7n4QkgMbNd0LIzR2T66J8iliEOCw8zL3eH4kdFDYJBVwnV6A7NEyg+KAP0qVuGA
         aoGw==
X-Gm-Message-State: AOAM5301W5nR+3S8f/TlFov6zWdG8LeAsm4ZNIAGM50FrVcpLKL5gWQD
        Rbo6miHPm4MpAnjgMNnlPH/jw68X4nsdp0z5
X-Google-Smtp-Source: ABdhPJyTxlnuafkU8MqKdbGPUj2CQDrGQ6UTC7IOz5oA0QDCvXEZxJCHIXZY9r8bM0exu9/VeHSGaA==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr6156029wrs.176.1622855408301;
        Fri, 04 Jun 2021 18:10:08 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u8sm9594941wmq.29.2021.06.04.18.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:10:07 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 12/12] wcn36xx: Enable WOWLAN flags
Date:   Sat,  5 Jun 2021 02:11:40 +0100
Message-Id: <20210605011140.2004643-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
References: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
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

