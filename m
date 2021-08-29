Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A6B3FABBA
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhH2NOw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 09:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbhH2NOL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 09:14:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A080C06124C
        for <linux-wireless@vger.kernel.org>; Sun, 29 Aug 2021 06:13:19 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y6so20758346lje.2
        for <linux-wireless@vger.kernel.org>; Sun, 29 Aug 2021 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fc0GoKyWHbaDUKZRwzSCHWvKPWvkUL1O7EIfFaZFJjw=;
        b=WQjfSpbDrca+TOUsx7LwhVaGrRBw15QNw+k8AifBRmN6Tknlp8y6aVICUXUBvylUpq
         uGv51n11OdQTIadbRhZQmI9BtBq8J8LBAm9FF3Aqsu9TrIpFHQOXVy/np/qx/wtktiz5
         eZez1juG+7yTWP4/9NDpSOtxfe6BxtSpYdzWNhLss+vjKlxzRNwg9RPMzm2vj7qw3ujJ
         OalyFCdnhscPZmVb2M8epnfeHo1w1VrszaxI627DnOOL7mTOzkuz5DNgJ/8TzriwIMIS
         wqEDRCFeqOjMKKQOKXZfRIDktRNVjC9iRgicsgcgfr7PsIcbQ8LTpabdRX4M6A65zYWs
         gCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fc0GoKyWHbaDUKZRwzSCHWvKPWvkUL1O7EIfFaZFJjw=;
        b=ERLA/oZh+fQvvxw1GDwmPsjy1XE33DXU2M5xKyj3ih1QwRs9fTwgGDq0jVTCqOCI+C
         nWBPzE/br8lIDtzaV2fZE+0DhGXN0Zq4F950lwB7Nz54x/2rEUXzZ1jpqPF7ZsbJuMQQ
         MT9ZdUrovy53p21WuyY+MBSlmnC6OQbn9rHE8edJsIkjCplR6U7DAn9FupvWOIPU5V9S
         0EkefXBR+KxpLt2Lbm2CeNC8eqhEAZRKy15YUjgoQdLWsp+DreOD8uqfztX2BLFVakQo
         XT3XvvZAJK0KbVzKJlw0IxO7NjpiEJz7XYu4+GVx+qbez7tDJnrOgg1VzmMWhF5uuZ3o
         cADw==
X-Gm-Message-State: AOAM530OEq+EJBhhDy1iYKpxY4oYzvafgbekxvmQfs4Y5OZoXgDMNNyy
        u531C/VaJwZcOuQjwD0deeYEsw==
X-Google-Smtp-Source: ABdhPJypZoaN+ASZJ3NqAmr3XTNDUu2bTb8GflG+YgnD2AtkVNJ4BjIFdS2A06lO0E9Etdnu2Vv0BA==
X-Received: by 2002:a2e:9b14:: with SMTP id u20mr16296284lji.21.1630242797711;
        Sun, 29 Aug 2021 06:13:17 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x13sm712503lfq.262.2021.08.29.06.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 06:13:17 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [RFC v2 10/13] arm64: dts: qcom: qrb5165-rb5: add bluetooth support
Date:   Sun, 29 Aug 2021 16:13:02 +0300
Message-Id: <20210829131305.534417-11-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210829131305.534417-1-dmitry.baryshkov@linaro.org>
References: <20210829131305.534417-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for the bluetooth part of the QCA6391 BT+WiFi chip present
on the RB5 board. WiFi is not supported yet, as it requires separate
handling of the PCIe device power.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 8ac96f8e79d4..326330f528fc 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -19,6 +19,7 @@ / {
 
 	aliases {
 		serial0 = &uart12;
+		serial1 = &uart6;
 		sdhc2 = &sdhc_2;
 	};
 
@@ -98,6 +99,25 @@ lt9611_3v3: lt9611-3v3 {
 		regulator-always-on;
 	};
 
+	qca_pwrseq: qca-pwrseq {
+		compatible = "qcom,qca6390-pwrseq";
+
+		#pwrseq-cells = <1>;
+
+		vddaon-supply = <&vreg_s6a_0p95>;
+		vddpmu-supply = <&vreg_s2f_0p95>;
+		vddrfa1-supply = <&vreg_s2f_0p95>;
+		vddrfa2-supply = <&vreg_s8c_1p3>;
+		vddrfa3-supply = <&vreg_s5a_1p9>;
+		vddpcie1-supply = <&vreg_s8c_1p3>;
+		vddpcie2-supply = <&vreg_s5a_1p9>;
+		vddio-supply = <&vreg_s4a_1p8>;
+
+		bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+		wifi-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 124 GPIO_ACTIVE_HIGH>;
+	};
+
 	thermal-zones {
 		conn-thermal {
 			polling-delay-passive = <0>;
@@ -804,6 +824,26 @@ lt9611_rst_pin: lt9611-rst-pin {
 	};
 };
 
+&qup_uart6_default {
+	ctsrx {
+		pins = "gpio16", "gpio19";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	rts {
+		pins = "gpio17";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tx {
+		pins = "gpio18";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -1193,6 +1233,16 @@ sdc2_card_det_n: sd-card-det-n {
 	};
 };
 
+&uart6 {
+	status = "okay";
+	bluetooth {
+		compatible = "qcom,qca6390-bt";
+		clocks = <&sleep_clk>;
+
+		bt-pwrseq = <&qca_pwrseq 1>;
+	};
+};
+
 &uart12 {
 	status = "okay";
 };
-- 
2.33.0

