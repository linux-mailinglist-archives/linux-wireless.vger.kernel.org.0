Return-Path: <linux-wireless+bounces-3703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38C485870E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 21:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DA01C24B87
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 20:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDD714F9EE;
	Fri, 16 Feb 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zm7jveLW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B114D456
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115609; cv=none; b=r2ICo7oFLE1taYVjCTHjORWrAyLtxQ5OnCzXAXI4dF6hS5YV3KrdVToWT4/A/ruNB+tvrO7+/lqOHtFp2dOTUyLPz2Fbhk9TsxIZUFc2EZf77LRjkywRFi6yb4w3jwDU+7JfkNtRNKuWf7cXqgrhhFTjCDm8st7k6TPd5xMtF6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115609; c=relaxed/simple;
	bh=KPOrp8LPSUDq6IOAE4mPfTWcsTyUCeGoXHAEp71vpf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikPnS7zfedWAD+BSusZiAz2rCqu0wz84EhSJG0qXxJdNlgcZbiDDNSe77Q+x/+0X91PXEOpNqK/pgFCigHaPN/mWVLF5cjmbGGSpk0jTqisAAueMsYq9WujQTtNs4ofU2IeAmPuCdGkw2I3eLPJdpiW5gRt4paD0VUnpCn6Xv50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zm7jveLW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412393ea2a0so7618705e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 12:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115605; x=1708720405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5nC77QhQSBlcsUVXNEDIX3kn3g283v1vwONwQpCCWg=;
        b=zm7jveLWaQvt/lezHPz9PHmJh5+DMATnqk0WVN1qgs1gnmJHT7RpMHu7ihyk03pAhl
         uetvcNgK4PPo+DqlByOtyI2BN+XOkIRQo1/ltNgwujScmPPGMt1bq24qW7sTRPVWAaFT
         8zHFxWnE+IAkBWVYAOhHFcQiFdz6EdLb3Q0AKHIHityc9RPpgcKA7818vaZkilnzXaFU
         99nGoXX8iASr5LntfJBqgkxSdC+FSCLYJgwyts9IT3zB4utDjELdqFn7+R+n6FMCsX25
         Zeh6J/IaaS6s2Tb0RUcyNcruAoiJS7syqrPrdRhd9J1e+X7O8p4LlTeERUtKxnL+pHPD
         s9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115605; x=1708720405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5nC77QhQSBlcsUVXNEDIX3kn3g283v1vwONwQpCCWg=;
        b=n7Kp+uHI3hdUQkzgm6zNVgERoBXhPhRr9KMkEMGheYsRU5IJ4PiUyJ7YaCw6f1Tagu
         Gb2fe/V398TI2FFbbY/n5w5sex8Lv7xYhITHdd2eYeKdUkZI+FbBpJ1LaPGF61FpC0p6
         nFCgYQDkmh2uxNZ5QqPg4HMDTokTao2deEZUqG4wZ6+Vt07c8mgR2krpsd+klLffPxVF
         jz37mdpMFIyG+LA53N+Up6NJy3FQRmHdh+54tzRl+YAAx1F1OzhrmlxNq98EVrU/ESEc
         oUSpWPoKF8rF680bcHIREgYKukSSssPPB589hRCpeKef+kgheC1JCuoH7qZh0Z5lfZ9Q
         aVsA==
X-Forwarded-Encrypted: i=1; AJvYcCVReG6fdnzv5RCbRHGs8Kehz7IjrMKiiZ7FJm7gmH/91SYRNF4UrrfDFzF70KRjFanQKkcBNjmgdA/lFuQXSD6HyD1BRnZOwoUQm4HpCZU=
X-Gm-Message-State: AOJu0YwHaYWFyO/HK3WibhnO6Zyw2Bw7P6Fs0r9ruZS2ZnryDg30e0Wh
	FMkVebBhzT3g6gLers4gv0dJy4sAvzywp7Zvm1sRtDQQA6Ly61fct7HCjPt58qM=
X-Google-Smtp-Source: AGHT+IEkPmEwWu14kQGv5R1Lwesa1KAhBlsFwwGo+rcDfqAPB+2TTrwOswrMYt6s8NA+Tefu42gDRQ==
X-Received: by 2002:a05:600c:3594:b0:412:62:86f8 with SMTP id p20-20020a05600c359400b00412006286f8mr4602389wmq.4.1708115605434;
        Fri, 16 Feb 2024 12:33:25 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:25 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 09/18] arm64: dts: qcom: qrb5165-rb5: model the PMU of the QCA6391
Date: Fri, 16 Feb 2024 21:32:06 +0100
Message-Id: <20240216203215.40870-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a node for the PMU module of the QCA6391 present on the RB5 board.
Assign its LDO power outputs to the existing Bluetooth module. Add a
node for the PCIe port to sm8250.dtsi and define the WLAN node on it in
the board's .dts and also make it consume the power outputs of the PMU.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 123 +++++++++++++++++++++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi     |  10 ++
 2 files changed, 122 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index cd0db4f31d4a..3331a3e5aaa8 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -108,6 +108,87 @@ lt9611_3v3: lt9611-3v3 {
 		regulator-always-on;
 	};
 
+	qca6390-pmu {
+		compatible = "qcom,qca6390-pmu";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
+
+		vddaon-supply = <&vreg_s6a_0p95>;
+		vddpmu-supply = <&vreg_s2f_0p95>;
+		vddrfa0p95-supply = <&vreg_s2f_0p95>;
+		vddrfa1p3-supply = <&vreg_s8c_1p3>;
+		vddrfa1p9-supply = <&vreg_s5a_1p9>;
+		vddpcie1p3-supply = <&vreg_s8c_1p3>;
+		vddpcie1p9-supply = <&vreg_s5a_1p9>;
+		vddio-supply = <&vreg_s4a_1p8>;
+
+		wlan-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+				regulator-min-microvolt = <760000>;
+				regulator-max-microvolt = <840000>;
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+				regulator-min-microvolt = <540000>;
+				regulator-max-microvolt = <840000>;
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+				regulator-min-microvolt = <760000>;
+				regulator-max-microvolt = <840000>;
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <890000>;
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <890000>;
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+				regulator-min-microvolt = <760000>;
+				regulator-max-microvolt = <840000>;
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+				regulator-min-microvolt = <1187000>;
+				regulator-max-microvolt = <1313000>;
+			};
+
+			vreg_pmu_rfa_1p7: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+				regulator-min-microvolt = <1710000>;
+				regulator-max-microvolt = <1890000>;
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+				regulator-min-microvolt = <870000>;
+				regulator-max-microvolt = <970000>;
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+				regulator-min-microvolt = <1710000>;
+				regulator-max-microvolt = <1890000>;
+			};
+		};
+	};
+
 	thermal-zones {
 		conn-thermal {
 			polling-delay-passive = <0>;
@@ -734,6 +815,23 @@ &pcie0_phy {
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
 
+&pcieport0 {
+	wifi@0 {
+		compatible = "pci17cb,1101";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+	};
+};
+
 &pcie1 {
 	status = "okay";
 };
@@ -1303,6 +1401,14 @@ sdc2_card_det_n: sd-card-det-n-state {
 		function = "gpio";
 		bias-pull-up;
 	};
+
+	wlan_en_state: wlan-default-state {
+		pins = "gpio20";
+		function = "gpio";
+		drive-strength = <16>;
+		output-low;
+		bias-pull-up;
+	};
 };
 
 &uart6 {
@@ -1311,17 +1417,12 @@ &uart6 {
 	bluetooth {
 		compatible = "qcom,qca6390-bt";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&bt_en_state>;
-
-		enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
-
-		vddio-supply = <&vreg_s4a_1p8>;
-		vddpmu-supply = <&vreg_s2f_0p95>;
-		vddaon-supply = <&vreg_s6a_0p95>;
-		vddrfa0p9-supply = <&vreg_s2f_0p95>;
-		vddrfa1p3-supply = <&vreg_s8c_1p3>;
-		vddrfa1p9-supply = <&vreg_s5a_1p9>;
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index f3c70b87efad..29d2ccb5b389 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2203,6 +2203,16 @@ pcie0: pcie@1c00000 {
 			dma-coherent;
 
 			status = "disabled";
+
+			pcieport0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				bus-range = <0x01 0xff>;
+			};
 		};
 
 		pcie0_phy: phy@1c06000 {
-- 
2.40.1


