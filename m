Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D026D976F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 14:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbjDFMz6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 08:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbjDFMz4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 08:55:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E877EFE
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 05:55:54 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q14so40593674ljm.11
        for <linux-wireless@vger.kernel.org>; Thu, 06 Apr 2023 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680785752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKfeJKpGjF1z8fepfL0M/YcCWgT4m+ORbH6HWisxcE0=;
        b=u4YK9n+cFGCe0xwHiTaR2NTa6eft36hRLuDku9dcRjU7ZqjGdMdn6v9J5puEnO4yft
         CjbY/7jwagR4JB888Cr5e2pK8w/rTEhwAOfsgSIbrZDV4X45XmWUbnljWYluytdPDGYR
         L5PNBdjiC9pt18o+dHkiqOuyi4HTXj+vvYxIKUIIKiaalYoHmLcbwxVaiv9PGDC772wf
         q1iK9d5Uenk7N5gZvLRJiK68VexuD985hKzMZuYSvPcCTemWRy+eTm25gvPQREb2x2HW
         vjzwpd2hN/iW9Lpr1YNtNudSOLpUyb6wcrU6kgGJuPpp8NuTfV61nMdnYQ+l4QZ8vldM
         TcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680785752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKfeJKpGjF1z8fepfL0M/YcCWgT4m+ORbH6HWisxcE0=;
        b=FtGBCyxAq44MKdOEOHNgUtBWnDR1sLIj5ECiF1DrjBbRsHoxqdnFb/cYhBhgtZWZXe
         n+nx8n8ZDukS3CsgIY5Q6PJ3EIXhY3Z1dzrKO5mUBROeDEzabpSZdsJU/7GioT+07emI
         7mjd85PKvjGggCwxV5xMS9ZHazr5fbzqMmRuhjoymPuP9JMpmoFM7bIyS8b6NP2rIi1N
         LqbyIX3xQcMadBsijv6QcdYT2fZS95zjYDdRV7v311Cu8DYJqZ/jeTvf29t7miORkhbt
         8/Y/JTjQpZV7Bxnqk1DHn2H5dl7fasABEstC8saB9eCr2It5kviPh//ZGdbmy9DGMqNT
         dRow==
X-Gm-Message-State: AAQBX9dzXZYLoQr6WCGtHHzfEVE+ONVvaEWcnFadAsdbghggeEFjxFnS
        voPK/oIj8kyXpf1TmXs8OIm8bA==
X-Google-Smtp-Source: AKy350Y0FqKu5JlhPhhTVAkbRdvgy5Kf3Psf4l7xldNvhM8W5FxvqDRKB5O+xMaYbpKZnDeQpt4CQA==
X-Received: by 2002:a2e:9609:0:b0:2a6:2305:110c with SMTP id v9-20020a2e9609000000b002a62305110cmr2755001ljh.38.1680785752260;
        Thu, 06 Apr 2023 05:55:52 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id i13-20020a2e864d000000b00295765966d9sm276513ljj.86.2023.04.06.05.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 05:55:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 06 Apr 2023 14:55:44 +0200
Subject: [PATCH v3 1/2] dt-bindings: net: Convert ATH10K to YAML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-ath10k_bindings-v3-1-00895afc7764@linaro.org>
References: <20230406-topic-ath10k_bindings-v3-0-00895afc7764@linaro.org>
In-Reply-To: <20230406-topic-ath10k_bindings-v3-0-00895afc7764@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680785748; l=19573;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ZUmNU7oAB8LCcl1nGusWBMKfNfUGrdk74eYgEMMrxX4=;
 b=asNa1jl8Uo3Ud/paRwichJJxvsQC8ug49Vr4Kl0rlKjf274wqdn0Au37IbBMmDIHZPGuPXlM+OI+
 M4eI9ci+DTzTqHIoWT+szUWdXpbrxqctYdAP6Xtnx4hQNdqX6oMc
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert the ATH10K bindings to YAML.

Dropped properties that are absent at the current state of mainline:
- qcom,msi_addr
- qcom,msi_base

qcom,coexist-support and qcom,coexist-gpio-pin do very little and should
be reconsidered on the driver side, especially the latter one.

Somewhat based on the ath11k bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/net/wireless/qcom,ath10k.txt          | 215 -------------
 .../bindings/net/wireless/qcom,ath10k.yaml         | 357 +++++++++++++++++++++
 2 files changed, 357 insertions(+), 215 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
deleted file mode 100644
index b61c2d5a0ff7..000000000000
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
+++ /dev/null
@@ -1,215 +0,0 @@
-* Qualcomm Atheros ath10k wireless devices
-
-Required properties:
-- compatible: Should be one of the following:
-	* "qcom,ath10k"
-	* "qcom,ipq4019-wifi"
-	* "qcom,wcn3990-wifi"
-
-PCI based devices uses compatible string "qcom,ath10k" and takes calibration
-data along with board specific data via "qcom,ath10k-calibration-data".
-Rest of the properties are not applicable for PCI based devices.
-
-AHB based devices (i.e. ipq4019) uses compatible string "qcom,ipq4019-wifi"
-and also uses most of the properties defined in this doc (except
-"qcom,ath10k-calibration-data"). It uses "qcom,ath10k-pre-calibration-data"
-to carry pre calibration data.
-
-In general, entry "qcom,ath10k-pre-calibration-data" and
-"qcom,ath10k-calibration-data" conflict with each other and only one
-can be provided per device.
-
-SNOC based devices (i.e. wcn3990) uses compatible string "qcom,wcn3990-wifi".
-
-- reg: Address and length of the register set for the device.
-- reg-names: Must include the list of following reg names,
-	     "membase"
-- interrupts: reference to the list of 17 interrupt numbers for "qcom,ipq4019-wifi"
-	      compatible target.
-	      reference to the list of 12 interrupt numbers for "qcom,wcn3990-wifi"
-	      compatible target.
-	      Must contain interrupt-names property per entry for
-	      "qcom,ath10k", "qcom,ipq4019-wifi" compatible targets.
-
-- interrupt-names: Must include the entries for MSI interrupt
-		   names ("msi0" to "msi15") and legacy interrupt
-		   name ("legacy") for "qcom,ath10k", "qcom,ipq4019-wifi"
-		   compatible targets.
-
-Optional properties:
-- resets: Must contain an entry for each entry in reset-names.
-          See ../reset/reseti.txt for details.
-- reset-names: Must include the list of following reset names,
-	       "wifi_cpu_init"
-	       "wifi_radio_srif"
-	       "wifi_radio_warm"
-	       "wifi_radio_cold"
-	       "wifi_core_warm"
-	       "wifi_core_cold"
-- clocks: List of clock specifiers, must contain an entry for each required
-          entry in clock-names.
-- clock-names: Should contain the clock names "wifi_wcss_cmd", "wifi_wcss_ref",
-	       "wifi_wcss_rtc" for "qcom,ipq4019-wifi" compatible target and
-	       "cxo_ref_clk_pin" and optionally "qdss" for "qcom,wcn3990-wifi"
-	       compatible target.
-- qcom,msi_addr: MSI interrupt address.
-- qcom,msi_base: Base value to add before writing MSI data into
-		MSI address register.
-- qcom,ath10k-calibration-variant: string to search for in the board-2.bin
-				   variant list with the same bus and device
-				   specific ids
-- qcom,ath10k-calibration-data : calibration data + board specific data
-				 as an array, the length can vary between
-				 hw versions.
-- qcom,ath10k-pre-calibration-data : pre calibration data as an array,
-				     the length can vary between hw versions.
-- <supply-name>-supply: handle to the regulator device tree node
-			   optional "supply-name" are "vdd-0.8-cx-mx",
-			   "vdd-1.8-xo", "vdd-1.3-rfa", "vdd-3.3-ch0",
-			   and "vdd-3.3-ch1".
-- memory-region:
-	Usage: optional
-	Value type: <phandle>
-	Definition: reference to the reserved-memory for the msa region
-		    used by the wifi firmware running in Q6.
-- iommus:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: A list of phandle and IOMMU specifier pairs.
-- ext-fem-name:
-	Usage: Optional
-	Value type: string
-	Definition: Name of external front end module used. Some valid FEM names
-		    for example: "microsemi-lx5586", "sky85703-11"
-		    and "sky85803" etc.
-- qcom,snoc-host-cap-8bit-quirk:
-	Usage: Optional
-	Value type: <empty>
-	Definition: Quirk specifying that the firmware expects the 8bit version
-		    of the host capability QMI request
-- qcom,xo-cal-data: xo cal offset to be configured in xo trim register.
-
-- qcom,msa-fixed-perm: Boolean context flag to disable SCM call for statically
-		       mapped msa region.
-
-- qcom,coexist-support : should contain eithr "0" or "1" to indicate coex
-			 support by the hardware.
-- qcom,coexist-gpio-pin : gpio pin number  information to support coex
-			  which will be used by wifi firmware.
-
-* Subnodes
-The ath10k wifi node can contain one optional firmware subnode.
-Firmware subnode is needed when the platform does not have TustZone.
-The firmware subnode must have:
-
-- iommus:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: A list of phandle and IOMMU specifier pairs.
-
-
-Example (to supply PCI based wifi block details):
-
-In this example, the node is defined as child node of the PCI controller.
-
-pci {
-	pcie@0 {
-		reg = <0 0 0 0 0>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		device_type = "pci";
-
-		wifi@0,0 {
-			reg = <0 0 0 0 0>;
-			qcom,ath10k-calibration-data = [ 01 02 03 ... ];
-			ext-fem-name = "microsemi-lx5586";
-		};
-	};
-};
-
-Example (to supply ipq4019 SoC wifi block details):
-
-wifi0: wifi@a000000 {
-	compatible = "qcom,ipq4019-wifi";
-	reg = <0xa000000 0x200000>;
-	resets = <&gcc WIFI0_CPU_INIT_RESET>,
-		 <&gcc WIFI0_RADIO_SRIF_RESET>,
-		 <&gcc WIFI0_RADIO_WARM_RESET>,
-		 <&gcc WIFI0_RADIO_COLD_RESET>,
-		 <&gcc WIFI0_CORE_WARM_RESET>,
-		 <&gcc WIFI0_CORE_COLD_RESET>;
-	reset-names = "wifi_cpu_init",
-		      "wifi_radio_srif",
-		      "wifi_radio_warm",
-		      "wifi_radio_cold",
-		      "wifi_core_warm",
-		      "wifi_core_cold";
-	clocks = <&gcc GCC_WCSS2G_CLK>,
-		 <&gcc GCC_WCSS2G_REF_CLK>,
-		 <&gcc GCC_WCSS2G_RTC_CLK>;
-	clock-names = "wifi_wcss_cmd",
-		      "wifi_wcss_ref",
-		      "wifi_wcss_rtc";
-	interrupts = <0 0x20 0x1>,
-		     <0 0x21 0x1>,
-		     <0 0x22 0x1>,
-		     <0 0x23 0x1>,
-		     <0 0x24 0x1>,
-		     <0 0x25 0x1>,
-		     <0 0x26 0x1>,
-		     <0 0x27 0x1>,
-		     <0 0x28 0x1>,
-		     <0 0x29 0x1>,
-		     <0 0x2a 0x1>,
-		     <0 0x2b 0x1>,
-		     <0 0x2c 0x1>,
-		     <0 0x2d 0x1>,
-		     <0 0x2e 0x1>,
-		     <0 0x2f 0x1>,
-		     <0 0xa8 0x0>;
-	interrupt-names = "msi0",  "msi1",  "msi2",  "msi3",
-			  "msi4",  "msi5",  "msi6",  "msi7",
-			  "msi8",  "msi9",  "msi10", "msi11",
-			  "msi12", "msi13", "msi14", "msi15",
-			  "legacy";
-	qcom,msi_addr = <0x0b006040>;
-	qcom,msi_base = <0x40>;
-	qcom,ath10k-pre-calibration-data = [ 01 02 03 ... ];
-	qcom,coexist-support = <1>;
-	qcom,coexist-gpio-pin = <0x33>;
-};
-
-Example (to supply wcn3990 SoC wifi block details):
-
-wifi@18000000 {
-		compatible = "qcom,wcn3990-wifi";
-		reg = <0x18800000 0x800000>;
-		reg-names = "membase";
-		clocks = <&clock_gcc clk_rf_clk2_pin>;
-		clock-names = "cxo_ref_clk_pin";
-		interrupts =
-			<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
-		vdd-0.8-cx-mx-supply = <&pm8998_l5>;
-		vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-		vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-		vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
-		vdd-3.3-ch1-supply = <&vreg_l26a_3p3>;
-		memory-region = <&wifi_msa_mem>;
-		iommus = <&apps_smmu 0x0040 0x1>;
-		qcom,msa-fixed-perm;
-		wifi-firmware {
-			iommus = <&apps_iommu 0xc22 0x1>;
-		};
-};
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
new file mode 100644
index 000000000000..323c8c17404b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -0,0 +1,357 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/qcom,ath10k.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies ATH10K wireless devices
+
+maintainers:
+  - Kalle Valo <kvalo@kernel.org>
+
+description:
+  Qualcomm Technologies, Inc. IEEE 802.11ac devices.
+
+properties:
+  compatible:
+    enum:
+      - qcom,ath10k # SDIO-based devices
+      - qcom,ipq4019-wifi
+      - qcom,wcn3990-wifi # SNoC-based devices
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: membase
+
+  interrupts:
+    minItems: 12
+    maxItems: 17
+
+  interrupt-names:
+    minItems: 12
+    maxItems: 17
+
+  memory-region:
+    maxItems: 1
+    description:
+      Reference to the MSA memory region used by the Wi-Fi firmware
+      running on the Q6 core.
+
+  iommus:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+  resets:
+    maxItems: 6
+
+  reset-names:
+    items:
+      - const: wifi_cpu_init
+      - const: wifi_radio_srif
+      - const: wifi_radio_warm
+      - const: wifi_radio_cold
+      - const: wifi_core_warm
+      - const: wifi_core_cold
+
+  ext-fem-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Name of external front end module used.
+    enum:
+      - microsemi-lx5586
+      - sky85703-11
+      - sky85803
+
+  wifi-firmware:
+    type: object
+    additionalProperties: false
+    description: |
+      The ATH10K Wi-Fi node can contain one optional firmware subnode.
+      Firmware subnode is needed when the platform does not have Trustzone.
+    properties:
+      iommus:
+        maxItems: 1
+    required:
+      - iommus
+
+  qcom,ath10k-calibration-data:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description:
+      Calibration data + board-specific data as a byte array. The length
+      can vary between hardware versions.
+
+  qcom,ath10k-calibration-variant:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Unique variant identifier of the calibration data in board-2.bin
+      for designs with colliding bus and device specific ids
+
+  qcom,ath10k-pre-calibration-data:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description:
+      Pre-calibration data as a byte array. The length can vary between
+      hardware versions.
+
+  qcom,coexist-support:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [0, 1]
+    description:
+      Indicate coex support by the hardware.
+
+  qcom,coexist-gpio-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      COEX GPIO number provided to the Wi-Fi firmware.
+
+  qcom,msa-fixed-perm:
+    type: boolean
+    description:
+      Whether to skip executing an SCM call that reassigns the memory
+      region ownership.
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: State bits used by the AP to signal the WLAN Q6.
+    items:
+      - description: Signal bits used to enable/disable low power mode
+                     on WCN in the case of WoW (Wake on Wireless).
+
+  qcom,smem-state-names:
+    description: The names of the state bits used for SMP2P output.
+    items:
+      - const: wlan-smp2p-out
+
+  qcom,snoc-host-cap-8bit-quirk:
+    type: boolean
+    description:
+      Quirk specifying that the firmware expects the 8bit version
+      of the host capability QMI request
+
+  qcom,xo-cal-data:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      XO cal offset to be configured in XO trim register.
+
+  vdd-0.8-cx-mx-supply:
+    description: Main logic power rail
+
+  vdd-1.8-xo-supply:
+    description: Crystal oscillator supply
+
+  vdd-1.3-rfa-supply:
+    description: RFA supply
+
+  vdd-3.3-ch0-supply:
+    description: Primary Wi-Fi antenna supply
+
+  vdd-3.3-ch1-supply:
+    description: Secondary Wi-Fi antenna supply
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq4019-wifi
+    then:
+      properties:
+        interrupts:
+          minItems: 17
+          maxItems: 17
+
+        interrupt-names:
+          minItems: 17
+          items:
+            - const: msi0
+            - const: msi1
+            - const: msi2
+            - const: msi3
+            - const: msi4
+            - const: msi5
+            - const: msi6
+            - const: msi7
+            - const: msi8
+            - const: msi9
+            - const: msi10
+            - const: msi11
+            - const: msi12
+            - const: msi13
+            - const: msi14
+            - const: msi15
+            - const: legacy
+
+        clocks:
+          items:
+            - description: Wi-Fi command clock
+            - description: Wi-Fi reference clock
+            - description: Wi-Fi RTC clock
+
+        clock-names:
+          items:
+            - const: wifi_wcss_cmd
+            - const: wifi_wcss_ref
+            - const: wifi_wcss_rtc
+
+      required:
+        - clocks
+        - clock-names
+        - interrupts
+        - interrupt-names
+        - resets
+        - reset-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,wcn3990-wifi
+
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          items:
+            - description: XO reference clock
+            - description: Qualcomm Debug Subsystem clock
+
+        clock-names:
+          minItems: 1
+          items:
+            - const: cxo_ref_clk_pin
+            - const: qdss
+
+        interrupts:
+          items:
+            - description: CE0
+            - description: CE1
+            - description: CE2
+            - description: CE3
+            - description: CE4
+            - description: CE5
+            - description: CE6
+            - description: CE7
+            - description: CE8
+            - description: CE9
+            - description: CE10
+            - description: CE11
+
+      required:
+        - interrupts
+
+examples:
+  # SNoC
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    wifi@18800000 {
+      compatible = "qcom,wcn3990-wifi";
+      reg = <0x18800000 0x800000>;
+      reg-names = "membase";
+      memory-region = <&wlan_msa_mem>;
+      clocks = <&rpmcc RPM_SMD_RF_CLK2_PIN>;
+      clock-names = "cxo_ref_clk_pin";
+      interrupts = <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
+      iommus = <&anoc2_smmu 0x1900>,
+               <&anoc2_smmu 0x1901>;
+      qcom,snoc-host-cap-8bit-quirk;
+      vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
+      vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+      vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
+      vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+      vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
+
+      wifi-firmware {
+        iommus = <&apps_smmu 0x1c02 0x1>;
+      };
+    };
+
+  # AHB
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq4019.h>
+
+    wifi@a000000 {
+        compatible = "qcom,ipq4019-wifi";
+        reg = <0xa000000 0x200000>;
+        resets = <&gcc WIFI0_CPU_INIT_RESET>,
+                 <&gcc WIFI0_RADIO_SRIF_RESET>,
+                 <&gcc WIFI0_RADIO_WARM_RESET>,
+                 <&gcc WIFI0_RADIO_COLD_RESET>,
+                 <&gcc WIFI0_CORE_WARM_RESET>,
+                 <&gcc WIFI0_CORE_COLD_RESET>;
+        reset-names = "wifi_cpu_init",
+                      "wifi_radio_srif",
+                      "wifi_radio_warm",
+                      "wifi_radio_cold",
+                      "wifi_core_warm",
+                      "wifi_core_cold";
+        clocks = <&gcc GCC_WCSS2G_CLK>,
+                 <&gcc GCC_WCSS2G_REF_CLK>,
+                 <&gcc GCC_WCSS2G_RTC_CLK>;
+        clock-names = "wifi_wcss_cmd",
+                      "wifi_wcss_ref",
+                      "wifi_wcss_rtc";
+        interrupts = <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 33 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 40 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 41 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 42 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 43 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 45 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 47 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names =  "msi0",
+                           "msi1",
+                           "msi2",
+                           "msi3",
+                           "msi4",
+                           "msi5",
+                           "msi6",
+                           "msi7",
+                           "msi8",
+                           "msi9",
+                           "msi10",
+                           "msi11",
+                           "msi12",
+                           "msi13",
+                           "msi14",
+                           "msi15",
+                           "legacy";
+      };

-- 
2.40.0

