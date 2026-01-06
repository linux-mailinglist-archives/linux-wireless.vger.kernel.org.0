Return-Path: <linux-wireless+bounces-30365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B670CF62FA
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 02:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A41CD30DFBE7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 01:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B548128B7EA;
	Tue,  6 Jan 2026 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MBPrWdRH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K2fDUrC2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495DC28506B
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661285; cv=none; b=bal0pmSW1klC/G9z6Dr07oK+yA0R1mPovuNiCDZ0A1aorHVOqkm6/wQCXL+fjG0j3D2nu7BXk+G+RbbOLa0ozxsWvZxy2GpgQKDCrtYF7n5D3sherVyjzTu9j+2Ea3hDWp2w6fQcMSTyONdOjvX4FwAujM7C3lMfKNRCBGVjXso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661285; c=relaxed/simple;
	bh=+qQ1M2lLHUY9VOnTAxKFSWl8p7pJdw4ZlpXlukoKYNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2/LL1BnE2cidjfAA7BLcrzI8Ih4ZX1trJSo2yIhhqxVugbJ0hBFwQImk0CDr/GfSiDsZMV2X3cgC0+E3zyBBBQlTUfkap3D8UEbi5lYtk9pnic0zSB1PQRnfnJWgjK29TiDiyR/sBfxP6ZVNgu79rbUmmcUxPyt+Rz9jaZ8cY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MBPrWdRH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K2fDUrC2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060oUQR2107206
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 01:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WwsEluQ14kvyyo1kpLGYuEKcRxriDaAn9HIc9tdqUWY=; b=MBPrWdRHhWco0L9w
	Wzhis6nlrn9HefrVu3jsK5KGssGZrmbr6VGnq8wmPBAnw3Vev3xPLgjGAKqMRLBO
	zK8fgsK7sYqhByJKhp6KvFNgOef7CzH5hetIKP2gbANqtryh93Q+QlG+yinNHq46
	stgiEpYe75hmYwkgrBqONiJ1NFIcqF5He+qC5McEoV4MODyGZW4OtVdeGqos2iBl
	jlLWZBxFvhRiVwtGYRyEqS95aXenn9bAGNHE7ptN1AtquZrhsq3xaP//tlHS8oAt
	3aZYwmvH0IrksRqGD+HS3j/ClMMIuvcg34bPo0gBCJnxGsfGUA7IdIHD9qy1xURm
	4dch3w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgr7380qp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 01:01:22 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-93f39594413so597051241.3
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 17:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661281; x=1768266081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwsEluQ14kvyyo1kpLGYuEKcRxriDaAn9HIc9tdqUWY=;
        b=K2fDUrC22qmbf5AqSoVJRLXYMLmp1+seOc4mQwg6jJfC7JgWcaJGJuKUbeu3ms/+iu
         8vedW/uiN4dlNEZdOB+zQ7zbJUzmziczgmBnsT7XT5NbXuqQThW6Q+lQiGeJ3Kd4AZIC
         gUd8gpaZhcXpluQ4Lfy/5vs5QJeXajHr/+iHk+sKZUVe+KTo58JhK46hEKMUC6mjFxHd
         XkmFDBD/CNdAsMTVUPXthOSW6fHY0rq7tZFD9gac+w8JXzHfQw2A4pND+YyQzsQhQnC4
         fsZC4aTJxEaa879+EXGEcITidBzUOhFchkqg8qg/uE34dd7zNwc6NJxHDNwhfT+/XIiK
         9P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661281; x=1768266081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WwsEluQ14kvyyo1kpLGYuEKcRxriDaAn9HIc9tdqUWY=;
        b=O+9LVgk3b4QKWCpuU6H+1E398Bk3b7/R44de9Ix1ANWn2p/GtZUkEHanr/AdJhskEO
         sV3v89KS857CXQF7RF2W4bpdbI13C7py9/mZRyBzcX88fAA87XNP2Uw+3129eR4MY+/A
         mWeHg0LshGmlLL2mi3SIGwBnyDCI87C7IcGfy/4XzI91dymSkWM/UDsUkBw3QIVfZfw/
         rHTXV2zHywnbfWqrkaN4EwWpsXzJFnrmCiGXieWy/4+f/BhqsIHI/H90PebWvw3O6/SQ
         Z+7UJAIGhaEp8RIUA/G0e8E8qivBAxGQrRbwWtS7z/kvmYE98VGiuoZjRKwtS2Z0GUS4
         clpg==
X-Forwarded-Encrypted: i=1; AJvYcCU9L24KX+4u8/ekN2E3y1uyen0JxMRovyyCqjPOkA9xKzLIaN3B4CZUoPfhoByYO/ZqA9SjjwzQs347wwS98Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYtOaejj480z3kZ3SiHMVe4R7wz5mc58FVNV3BSq5yNoWqEA79
	tYBGHbVVePHhLdzFudDYwIb5IpP5bG4byrmd+LCC4HWvLHTLhhe8he5jfrilIskZ0+CAwiXpbqF
	aMFZu1oDrDi0lW1rvWkEw05Y/T/pVDNjRUSHEnS3igfLoMiAtscTvFPl2X0EXiWlt9+t+gg==
X-Gm-Gg: AY/fxX7fyzHRwOjT3sdy5r+K7iuKQHy/qq8S6MsDtSj4OujdlsSLjd36Pj584psQskG
	xx3YWqeimKQJOo4hHVAmmRUvvOCGr+hJKxJfuVdQ1tLEsEne1xV6ENCyqwrQjzclBBaokse2NYS
	f0vaHLM09QKCjq5+I+dQu2h5YnoDYa61C3GwHWExXCCpXBr/BPqWMCMsnd5OYOYGECGeQlRdsVI
	+LzMUrrRV+SdGTu5BRO+PWQY8RhHUoCOvD/dFC53yW3VAiU2T1+kOUA6kPPBlwsqvAVgksp+Icy
	93GU2d35jafkQNubtcpCtKtkzygMcceUPuhW6kPBTTqIHuZAihnzGZYoC7mRf0rJtPo4EJgeJO/
	lUwWYuksdqFtP0y1iV1FwJonar7Q/WBJBs+xwqVIXQxfrUPZQrJz7pNProcfhzpkaqUgNgyK1vo
	uSvSZSgyuzwjDyDatd3CK4J28=
X-Received: by 2002:a05:6102:2c0c:b0:5de:db29:5c07 with SMTP id ada2fe7eead31-5ec74374a4dmr390665137.19.1767661280484;
        Mon, 05 Jan 2026 17:01:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTMyPJnKFkiDK1RC32Rqs91GGXh4vJyLuMHRfMmaOQNSZheCMQ2vOq/C/rF03ydAJzzHnqhw==
X-Received: by 2002:a05:6102:2c0c:b0:5de:db29:5c07 with SMTP id ada2fe7eead31-5ec74374a4dmr390644137.19.1767661278503;
        Mon, 05 Jan 2026 17:01:18 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:17 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:11 +0200
Subject: [PATCH v2 01/14] regulator: dt-bindings: qcom,wcn3990-pmu:
 describe PMUs on WCN39xx
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-1-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3229;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+qQ1M2lLHUY9VOnTAxKFSWl8p7pJdw4ZlpXlukoKYNk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7YEuFI1nPjM70ASOG40vYKExegfcu1r/tK9
 2GnG/rfayaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2AAKCRCLPIo+Aiko
 1clWB/sExA7rsq4oLHQT9hWULFIGtTpyJtnzQg8pR/3v0pSialanL32mFSrGGXJosXZlMSADkQS
 jI745zddSU4ZO4i/OOOyGFHb0DkcxLhZ1sOqLV8CPnN6bhXLcinlx45zRgV/2GiUOzim62Uy9tg
 DQeCbnZALFYDl4mbp9KwltSrvokRQa29qO8Yigori7j0CGma9fghC1WAw4ihN2fh3YokfLARbeq
 oJX8E+iWvckASgO1ogQz08Wy+PqnU3QNwRbYwbf/9AS+OaleQ/APJCH1vhJpVnd0fSM+Cib7tor
 ZEhQgg3xvYypLZM5R6ZpjFrtH9LOg872JKLO4tGSMP0HA05l
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=QrxTHFyd c=1 sm=1 tr=0 ts=695c5ee2 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=Ged_dzZm240b16LGnFsA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: Yq4zhe57-houQ-SaHASMYvln_A1sphDN
X-Proofpoint-GUID: Yq4zhe57-houQ-SaHASMYvln_A1sphDN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX3OnygGwyQcQ8
 EqxWrirmkOTI+rBsyo/5vXv9yxqqZwmtjtlrO8GVC7PeOEGGT+1ljLuKsNPmNPENJ6JlWlJj8JP
 FtmLCY+EXW+GEsRW1RVIRI29cd/cSQmmglv778nXy25o0zeobOc4QsGjaqHrDCB52LbYgoeGDrF
 N4/CNSIG7x89pYFMfSm85kZ/fsJDJJoDW+SO6hmLV6irTWfYxnk48Gz2S7JO7wpQSlJ2Vjot8a9
 txal3VBUd1GSHunsmuimvLspp/ZsV7oO+vr7M8SrflVY/ESGY5zVJke/Bk6rbkdL0yb5l5HbtWT
 0Y+50LFK7lHyD8KvyzUc57MaKbhGxUKqUAtvvwT58SHdsQghYuIc3L7xO8I/SDVKpHo6KijTOMQ
 8CHLEYpPX167O5KrXZ8CIZHI6yX7Wm2359MzaqIWw0Zh76uY5W4poNGmm+zCZdY8Qltu7kIQx2y
 ma191lYvt6ufQib2gzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

WCN3990 and other similar WiFi/BT chips incorporate a simple on-chip PMU
(clearly described as such in the documentation). Provide DT schema
covering other Qualcomm WiFi/BT chips to cover these devices too.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/regulator/qcom,wcn3990-pmu.yaml       | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml
new file mode 100644
index 000000000000..9a7abc878b83
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,wcn3990-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. WCN3990 PMU Regulators
+
+maintainers:
+  - Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
+
+description:
+  The WCN3990 package contains discrete modules for WLAN and Bluetooth. They
+  are powered by the Power Management Unit (PMU) that takes inputs from the
+  host and provides LDO outputs. This document describes this module.
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcn3950-pmu
+      - qcom,wcn3988-pmu
+      - qcom,wcn3990-pmu
+      - qcom,wcn3991-pmu
+      - qcom,wcn3998-pmu
+
+  vddio-supply:
+    description: VDD_IO supply regulator handle
+
+  vddxo-supply:
+    description: VDD_XTAL supply regulator handle
+
+  vddrf-supply:
+    description: VDD_RF supply regulator handle
+
+  vddch0-supply:
+    description: chain 0 supply regulator handle
+
+  vddch1-supply:
+    description: chain 1 supply regulator handle
+
+  swctrl-gpios:
+    maxItems: 1
+    description: GPIO line indicating the state of the clock supply to the BT module
+
+  clocks:
+    maxItems: 1
+    description: Reference clock handle
+
+  regulators:
+    type: object
+    description:
+      LDO outputs of the PMU
+
+    patternProperties:
+      "^ldo[0-9]$":
+        $ref: regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - regulators
+  - vddio-supply
+  - vddxo-supply
+  - vddrf-supply
+  - vddch0-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    pmu {
+        compatible = "qcom,wcn3990-pmu";
+
+        vddio-supply = <&vreg_io>;
+        vddxo-supply = <&vreg_xo>;
+        vddrf-supply = <&vreg_rf>;
+        vddch0-supply = <&vreg_ch0>;
+
+        regulators {
+            vreg_pmu_io: ldo0 {
+                regulator-name = "vreg_pmu_io";
+            };
+
+            vreg_pmu_xo: ldo1 {
+                regulator-name = "vreg_pmu_xo";
+            };
+
+            vreg_pmu_rf: ldo2 {
+                regulator-name = "vreg_pmu_rf";
+            };
+
+            vreg_pmu_ch0: ldo3 {
+                regulator-name = "vreg_pmu_ch0";
+            };
+        };
+    };

-- 
2.47.3


