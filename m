Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A70E1291A2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2019 06:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLWFtf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 00:49:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42937 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfLWFtb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 00:49:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so8624262pfz.9
        for <linux-wireless@vger.kernel.org>; Sun, 22 Dec 2019 21:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TAbfRw81wKjdlTK4DIpia8dPfGxXFTyTxBsBiwwkkI=;
        b=kG4VoaiaWW1vD5ps1J4P+FfDOHsHkXtmjijWd4hvkskVttky6HDYPqWh67j5RsN1Pn
         tiW1BqPJcpvZ9hJ48esmhbOViZZtsrE/qTw5GClQSiw3gSVUdTtKCVGzmpbjYT5vq0Ne
         gY2Uvv/3+BfdXj2uaAJ9BA72SMu7mVJ59cClzrJfp2MwMSWEmoJabVRl2uqL4N71GHfq
         UzNh8Sdjkbu7GcvVNm2uZWhlHQkJVrp27DcBpQkKxNI1UfApVheLQ0JDrfhOl4Qh0Ywj
         0MJaMlG3OpwPIVYzwNW9Ft60xrlKy8q75gxSiSf+0+56sUe363slVJsofYp4rghVRfAq
         uDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TAbfRw81wKjdlTK4DIpia8dPfGxXFTyTxBsBiwwkkI=;
        b=Doi6kPZ1brJGdqbB4dwwhJWXfZrpEpeHGiyK/5FmUQkDfdlM7d8GJaAnLPD3jKxLHK
         yssYvEIN6s8oZrvgEMtIa8sJrjmSx37hGKAIgzKIU+vcQQ9KxDOasLSKSR+m3vfm9swI
         UN9izrhbpFchEYdnQOqvFNytIFEqFx/S0n4LYRkk5ud4U8wpJyA+AFHjdjzwdUZRs6pK
         9GG2EOwMg5U31gnaONCtFIJRY4B4Eh7qgAutf+bAP6O+GLd8C8SUu2TIK2I0ds/ZgnTI
         NaOwDb1o+fq6VbGXvzDw7ynGnTI+Da5QahRuur4uSpDlDAiRvVeAhtXr/nsM7jVcme4a
         6fKw==
X-Gm-Message-State: APjAAAV/YSgyyYHvnmXgtYJWlAj9MO9ZKBwgvlbQyR1vPbSTyVKAZL6u
        nMFM0vteR22Rx4sjtyO+N/XvSw==
X-Google-Smtp-Source: APXvYqxy4LnU/4UbJSEnuIjt2lbosN4Qr2FWETJStKyhLrZ1sLKFbK2FAuxj/bEHT6NhZ0QILwBT2w==
X-Received: by 2002:a63:fd43:: with SMTP id m3mr29595462pgj.164.1577080170792;
        Sun, 22 Dec 2019 21:49:30 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l14sm19731779pgt.42.2019.12.22.21.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 21:49:30 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Gross <agross@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: [PATCH 2/2] arm64: dts: qcom: sm8150: Specify qdss clock for wifi
Date:   Sun, 22 Dec 2019 21:48:55 -0800
Message-Id: <20191223054855.3020665-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223054855.3020665-1-bjorn.andersson@linaro.org>
References: <20191223054855.3020665-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The WiFi firmware on SM8150 requires the QDSS clock to be ticking, so
specify this clock for the wifi node.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 373fa098ebb2..0f0c9db3d484 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -929,8 +929,8 @@ wifi: wifi@18800000 {
 			reg = <0 0x18800000 0 0x800000>;
 			reg-names = "membase";
 			memory-region = <&wlan_mem>;
-			clock-names = "cxo_ref_clk_pin";
-			clocks = <&rpmhcc RPMH_RF_CLK2>;
+			clock-names = "cxo_ref_clk_pin", "qdss";
+			clocks = <&rpmhcc RPMH_RF_CLK2>, <&aoss_qmp>;
 			interrupts = <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.24.0

