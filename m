Return-Path: <linux-wireless+bounces-34333-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F72GzHIz2lH0QYAu9opvQ
	(envelope-from <linux-wireless+bounces-34333-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 16:01:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9644394DFC
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 16:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63D0330D3A62
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF313270EDF;
	Fri,  3 Apr 2026 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="1iJCghLn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40623A6B8D
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224533; cv=none; b=Qo93oplaxlo82nysqZsglXFvoib7zzbZbfqaJJaf3HgCHWXj2KEvwv6OaxI0Ptr+mkb8p1UgOn9ReQYTB/dXLmOQ5hpqOXXO4gp8hd5BdBy9vJJn3qrDbHnLTIX9MIwndU9bv+2MZIzGwRXu4Okpows5YkAxXhjqtkvLyIxz77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224533; c=relaxed/simple;
	bh=akUQPIrMgPWRNFtOss4vuRIj1MAE0awNf856ZYFJhDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QMum6wkskJeej96qspOXjk4qVai/4lmA2NlXuwAGQgVq74GrPGsZfOv68V4zTOL2F4VJiXWlr1tDdQZ7O1UDcTkooBVrob/onfaczXDI9MUoOBgy2pYPyCnBDT498CUyB3H/ufASnCzO8rLh/C+f2z7vLGY/ULmsDEkvPB73H3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=1iJCghLn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b980b35534eso488203166b.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775224522; x=1775829322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPHsiCpdUUXRFvwRdI2OtsPeWnYw906MZTDdwum5VRU=;
        b=1iJCghLnvgfSUtBrShdDy/L79Y4llpI3oHKz2+th4NqH//TI3YsOLlElBFTCFSwQth
         s2TttnLzyVCC6TT5Hqh0S3Q7w5CPh/XN94iAhtFlUExUFSEIhKsLbO4qZxCx6C5nQE0q
         mYH4j3uW0hAoLlm/RAE91f0r9igUBigZ6Vqrlln4t9KiT0TsNpxOSxrJWqwpJlCtFDKf
         RtbRRm3bQVdadj9CquFjAM//SK5tmu5HgRQ5E8pZoWo+WQKvdSfGYpYmmHumpTel/6Ip
         2V6Z0ARw/Lm6cLIx72YKxhq0+CVyFeXaRhyWn2yk33YEzdE3v07YnrkbVenO4wpixqU/
         bGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224522; x=1775829322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EPHsiCpdUUXRFvwRdI2OtsPeWnYw906MZTDdwum5VRU=;
        b=KxvkIenZdCXVEfvtvbM0rrVGqv6jTTK5L/iJ/U2y+ICdOPCy01Ra63TPtOnWoJRCqN
         asEsprV/JndIp3fkUQk9vdhNuA3tni9KtVYwGGyAYQEcSXrj7YHPd72s9t+ObahstPbb
         1t86Si7awGIM8OjMwNBgmQFXMNNH+JSirBxERhiUzK6DljL1z/bdS4/Aq+LHL/xamNF/
         DYtIsdWlaiiODpAaf9Z2K3JiWe80BPE7BCMnD049c2DbHwUWFYA7DvbKhLgnqQxquL9W
         Od8tHHiu0UJpi+54iBGNgHQyJmKpOeAsdZzNtk4H/WIZMOTXtv6ObFfQtCsV64DksAF1
         PJXw==
X-Forwarded-Encrypted: i=1; AJvYcCWhypB7yOk59FcTgfjxiRGR3zlD0ceZRhT4IUC0KVDDtarWsCgkQjqH2WxANTk37+iwzjiAf/WyB1i3Yqx2Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkzmkk1p5BdDesr2qBgZch3nmocbHGknnUAEH1l5752ufpNssF
	o82OzOpXgMBVxJRMsrsEPbQxwZd9IUz8cDAY1J7Qo7dfkZkIegxYrNBQt/1Aneku5qY=
X-Gm-Gg: ATEYQzzucUzXrAmnJmR7APyl5D4uChrtCAmF9Xo6qnwo7hDX237c23HpmwIwW9SyDGK
	06Qq1tXNusYT6Mkp1xht2IhWOVZwGP4B3ZqY3TzFDmounL4aAKPS/D+CS/INiOo0y/VkYCENmTV
	ml9KCEJslYJ3Y9fMb/h0Q4byS+kvFrWAi7UEXdASOGCb7Qj3CVYwBV0zdJ0lW7LnEOlRrlUSe/q
	mbAc+RjkNJRcWPQ/gds76OtASfE9xgc42LsmSuQHUf42q3mZ2dwLAwZQjS73OrfyUYkomRAn6n8
	rOaSmO8GqLyazFg6hIKE370cdOO0jjFdv5P4qr04OVKBQl5kTVmfxngEetkHxFmG37UGusNWMEn
	tHC6MfDq9w8k/zvhkfChFOwLEGYEkMGXRicPuPbfZ7iNcHgNKwY3G1r0qBOzp36A5dyNBRCfjxf
	ym40D3j14nN4KObGFhsLMU43L2oxN4XkrkTAcXa5I6B5/0vYv4p5OPHrKaYTNeb0b0bDiaXE/Sw
	JrOzOLsgR0o7hva1pQqTo3TsA+YRHCDyg0QEQ==
X-Received: by 2002:a17:907:3d56:b0:b94:231f:26ca with SMTP id a640c23a62f3a-b9c46fedc37mr308190066b.20.1775224522291;
        Fri, 03 Apr 2026 06:55:22 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972e28sm198057266b.1.2026.04.03.06.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:55:21 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 03 Apr 2026 15:52:52 +0200
Subject: [PATCH v2 6/7] arm64: dts: qcom: milos-fairphone-fp6: Enable
 Bluetooth
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-milos-fp6-bt-wifi-v2-6-393322b27c5f@fairphone.com>
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alexander Koskovich <AKoskovich@pm.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775224512; l=5650;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=akUQPIrMgPWRNFtOss4vuRIj1MAE0awNf856ZYFJhDg=;
 b=dyYdc5Ec1aiox9qFG4Riy10GAz315VOhkO2VRCASezMRP6RTMEzf6wuziUmcu2DsGn7c72cho
 P8++lG8qX9OCFoKmQAwkmfYwCfcltX0EMy6Baz9Am39oTehVbjctRh/
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net];
	TAGGED_FROM(0.00)[bounces-34333-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C9644394DFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the nodes to describe the WCN6755 chip with its PMU and Bluetooth
parts.

Thanks to Alexander Koskovich for helping with the bringup, adding
'clocks' to the PMU node to make Bluetooth work.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 174 +++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
index c1899db46e71..db72418b7195 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -24,6 +24,7 @@ / {
 
 	aliases {
 		serial0 = &uart5;
+		serial1 = &uart11;
 	};
 
 	gpio-keys {
@@ -225,6 +226,67 @@ trip1 {
 			};
 		};
 	};
+
+	wcn6750-pmu {
+		compatible = "qcom,wcn6755-pmu", "qcom,wcn6750-pmu";
+
+		vddaon-supply = <&vreg_s3b>;
+		vddasd-supply = <&vreg_l7b>;
+		vddpmu-supply = <&vreg_s3b>;
+		vddrfa0p8-supply = <&vreg_s3b>;
+		vddrfa1p2-supply = <&vreg_s2b>;
+		vddrfa1p7-supply = <&vreg_s1b>;
+		vddrfa2p2-supply = <&vreg_s1j>;
+
+		bt-enable-gpios = <&tlmm 53 GPIO_ACTIVE_HIGH>;
+
+		clocks = <&rpmhcc RPMH_RF_CLK1>;
+
+		pinctrl-0 = <&bluetooth_enable_default>;
+		pinctrl-names = "default";
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -752,6 +814,39 @@ &pon_resin {
 	status = "okay";
 };
 
+&qup_uart11_cts {
+	/*
+	 * Configure a bias-bus-hold on CTS to lower power
+	 * usage when Bluetooth is turned off. Bus hold will
+	 * maintain a low power state regardless of whether
+	 * the Bluetooth module drives the pin in either
+	 * direction or leaves the pin fully unpowered.
+	 */
+	bias-bus-hold;
+};
+
+&qup_uart11_rts {
+	/* We'll drive RTS, so no pull */
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_uart11_rx {
+	/*
+	 * Configure a pull-up on RX. This is needed to avoid
+	 * garbage data when the TX pin of the Bluetooth module is
+	 * in tri-state (module powered off or not driving the
+	 * signal yet).
+	 */
+	bias-pull-up;
+};
+
+&qup_uart11_tx {
+	/* We'll drive TX, so no pull */
+	drive-strength = <2>;
+	bias-disable;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -810,6 +905,59 @@ &tlmm {
 			       <13 1>, /* NC */
 			       <63 2>; /* WLAN UART */
 
+	qup_uart11_sleep_cts: qup-uart11-sleep-cts-state {
+		pins = "gpio48";
+		function = "gpio";
+		/*
+		 * Configure a bias-bus-hold on CTS to lower power
+		 * usage when Bluetooth is turned off. Bus hold will
+		 * maintain a low power state regardless of whether
+		 * the Bluetooth module drives the pin in either
+		 * direction or leaves the pin fully unpowered.
+		 */
+		bias-bus-hold;
+	};
+
+	qup_uart11_sleep_rts: qup-uart11-sleep-rts-state {
+		pins = "gpio49";
+		function = "gpio";
+		/*
+		 * Configure pull-down on RTS. As RTS is active low
+		 * signal, pull it low to indicate the BT SoC that it
+		 * can wakeup the system anytime from suspend state by
+		 * pulling RX low (by sending wakeup bytes).
+		 */
+		bias-pull-down;
+	};
+
+	qup_uart11_sleep_tx: qup-uart11-sleep-tx-state {
+		pins = "gpio50";
+		function = "gpio";
+		/*
+		 * Configure pull-up on TX when it isn't actively driven
+		 * to prevent BT SoC from receiving garbage during sleep.
+		 */
+		bias-pull-up;
+	};
+
+	qup_uart11_sleep_rx: qup-uart11-sleep-rx-state {
+		pins = "gpio51";
+		function = "gpio";
+		/*
+		 * Configure a pull-up on RX. This is needed to avoid
+		 * garbage data when the TX pin of the Bluetooth module
+		 * is floating which may cause spurious wakeups.
+		 */
+		bias-pull-up;
+	};
+
+	bluetooth_enable_default: bluetooth-enable-default-state {
+		pins = "gpio53";
+		function = "gpio";
+		output-low;
+		bias-disable;
+	};
+
 	sdc2_card_det_n: sdc2-card-det-state {
 		pins = "gpio65";
 		function = "gpio";
@@ -836,6 +984,32 @@ &uart5 {
 	status = "okay";
 };
 
+&uart11 {
+	/delete-property/ interrupts;
+	interrupts-extended = <&intc GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&tlmm 51 IRQ_TYPE_EDGE_FALLING>;
+
+	pinctrl-1 =  <&qup_uart11_sleep_cts>,
+		     <&qup_uart11_sleep_rts>,
+		     <&qup_uart11_sleep_tx>,
+		     <&qup_uart11_sleep_rx>;
+	pinctrl-names = "default",
+			"sleep";
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn6755-bt", "qcom,wcn6750-bt";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+	};
+};
+
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 167 GPIO_ACTIVE_LOW>;
 

-- 
2.53.0


