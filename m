Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7EA34218F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhCSQO2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhCSQOF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:14:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA5C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:14:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x13so9671569wrs.9
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mV90VGp68UpB1XdgClwAqFevTATKxZfnnJBOM1WpO7w=;
        b=FJSdSqNZFiH/vI0np1Ctn/xVLQ06o4mNg6aH3Vi5uniaZ/nzoLLNuKdqM9yD/W2EtI
         6ARINNL0XzrXZcH6tToNhW5WJMaEwDsNcDVgGGSFl/AG07lRbzalSF4MczRPxsYMFWgz
         45Pc6pz7T6kitwbeidHuIqi/SWML0xGXyyzij5kW5FsMO17I/upT+R3CulJSbQsPXc6U
         8XOSddWHB1TjZrcj1rz4gXAl/6RZsj1PapanvEGrB6K0u0JsItdMCqAPmUKN543y3T+a
         Sb73QVjRMX71wKIusaCmGYCrMRssfU2s3Zubsn5FL7OkfX1FpAUJSCQYzK1KJWNuqn/H
         oWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mV90VGp68UpB1XdgClwAqFevTATKxZfnnJBOM1WpO7w=;
        b=M4SiwsKFNkKYkyv7MT/qg4PIXgL1ie4bndFjBnny6bx9Zg/QPRavfKkQyvp6aZP+Ay
         vB+LsWyF9tOpQH55Xi+4Ni20z5w7eAeWr2XmDGMf99bagsoVIxrFsblADCLPiQNjdEUK
         y+D3uC33vCo9tCbBNmT/abiHCFS91RDZNAW+p+8hB8qO2QUXr98Wsau8rY4C/y1qRVG1
         G0FWKWWDCaNXx9EXCtA/BO/AHDjL3vXzceHjMym8cPJDSAGDUND/9tQBRLWaDETevoGY
         Pwt95TeGkgAma7TfGX57zC43aqM4KNgaFRUGdbmpGssblb+hfCIA+uiRA3+h2uSlOhLU
         PSHg==
X-Gm-Message-State: AOAM533+W9dnD0aT409mrG6k5fM1Z6HVLFNNbNiVYOJ+YiNmUvwJwr/q
        9So8Es/c+0dISac5x1swXcZFfQ==
X-Google-Smtp-Source: ABdhPJyob3ULFe7YeDxjF4kEAmCdapq6j180qoW1OeLgw5eZCdCF3exQU+sluP+B4n63Lc0L0xuE/w==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr5413318wrp.112.1616170443791;
        Fri, 19 Mar 2021 09:14:03 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h8sm8432495wrt.94.2021.03.19.09.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:14:03 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v3 12/12] wcn36xx: Enable WOWLAN flags
Date:   Fri, 19 Mar 2021 16:15:20 +0000
Message-Id: <20210319161520.3590510-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
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

