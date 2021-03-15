Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A716833B23B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 13:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhCOMIp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 08:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhCOMIX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E3C061574
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d15so8557734wrv.5
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mV90VGp68UpB1XdgClwAqFevTATKxZfnnJBOM1WpO7w=;
        b=HsdkJyjKapsuHmADj0UbtPuLlN6DGjVY9sKHdYeHUqZLT6jVgdyZ0IZ9uIGuzxUiak
         z/6kAHWFvJ/TDWTfVIze1TCH9xDZabVLBbUakKvAZrDtA+aMFR+yLhlWf56jx1r408cc
         H4dAOnY6jpRLr49AKKAKzs2MmL09N/4rfO8M+ZNob9MsUqqDkA1VAp5TXIj8fFEPJuEy
         CEIYoZ+HrWmJjAsCg600CH7e793rAMSuS1OU0NBEOG3vrd1iM4fo9zvcOT8pyhiTXvjP
         TDE+BxxaeCvs/+Flb0+BhrYehXVKLVFmMnfi5fSStZiQjhr2iEoIa9MSS+AQ/YBZ3nbM
         HQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mV90VGp68UpB1XdgClwAqFevTATKxZfnnJBOM1WpO7w=;
        b=PnYfXrHkYiU0fI5Si8rC5NcsgWK9BrUu6e02hs4fZjKor78U/GG3m6uER35UueMsAQ
         hpI+wO7W34uocfVhc91w7AFEtBSiOJ8yulvBEHBoSGmwy4+y5pdiQC7DdTY+VZu7bbyl
         2hCCVeWt9jKUePr4wB2WgSks3TcF+PigRqprr0KyB8bse4ZGVbLEUBOjA3DaGO9537gX
         CaHljbf+IrwGRFBEpMdmNZx8wxylllc1OZb7PoWgXL2s6owmFd/1zXGvpfSRWGR7HAlc
         ug3LmbmaK/Y5B4+jtypBh+7dC/snaSSzoIHZ1/ldt+pAUY9esYvDU0RDdp7XFMqZTmNL
         hjWg==
X-Gm-Message-State: AOAM530PJcfKT8XFyKIEVzcmfuWZZrBtPeQ09d1T8qEBBrBeF/H/Krrx
        LDysnNdZ/LWJ/4lN7oT/3dZ3vA==
X-Google-Smtp-Source: ABdhPJyO8EGDeDROICLR4vtIlJrH3U9agiPdKnZmOCRBAnz3FzyIWlWd1lF+BPltkkoWqsWJXD55Yg==
X-Received: by 2002:adf:f78f:: with SMTP id q15mr26502346wrp.383.1615810101502;
        Mon, 15 Mar 2021 05:08:21 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm29239891wmk.0.2021.03.15.05.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:08:21 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2 12/12] wcn36xx: Enable WOWLAN flags
Date:   Mon, 15 Mar 2021 12:09:37 +0000
Message-Id: <20210315120937.2512341-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
References: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
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
---
 drivers/net/wireless/ath/wcn36xx/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index ddfc60e02389..7838d2056e54 100644
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

