Return-Path: <linux-wireless+bounces-19415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B78A43916
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 10:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5724519C5A0C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD0E269809;
	Tue, 25 Feb 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZvyjRDyW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75B261360
	for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474349; cv=none; b=jnbgDEkvPBnfkZNOKUnQN8XOibkJ2wHxo8XFwOAnXhREMrM/uS9Ix+A0sAqU7wOuoaNtHxsuzHlXShYiCmo7KZZ9N5zXqjDaZdx4tCdsIwdeyLowUB2QI9GjMkdItvE4fUP0Tj+CwRHxidud6OFJusIkhdAeljZgSJWGzDH/feQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474349; c=relaxed/simple;
	bh=8usnTAEFm1Piu5Yd2wL1LXpPE1HGz8E+rmzlqa0grM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tjT8npHIYZrgPn3yQT8Cr18riQBp71xA/3Vzq2NM1yJ9Qtd8LnQQDdZd5y8l9/9/iOT78+2qINtHm4jQ4ZCznwiA6HYP0jIdBPPBNACkxBTmMAoyK8yr5CwWFjnr572cYVxhaS0sd0au8QH394PPy82K0WlDBhRjKN1Ymq4NSqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZvyjRDyW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abc28af1ba4so46397766b.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 01:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740474346; x=1741079146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fY0h+JkzJEPC+Fr2bSYHihmywLYc/knwfAjtuNnsAeo=;
        b=ZvyjRDyWyuzvdhfxc4IqorIjCR9E6jeug4IXPPdsKBCVchDAiv4mAYAINQcYbY3lSJ
         KDLvG7PTyIB7vc7Aa2P7KhQUK51i8xXDZb37hU23vWK5kVDrIpytfdrgH1BuzRGgqFqs
         q0xS4mww45KeXQdJb6EgxtuATDkrLrTux7o7fDDv4QD7d+CKlSPS/lgSWkvQEHO6/hyY
         tgQvI+URPj0h+Uwws4ZJYYnQFWaF9Q1UvyRIao522uvXBY29COLOawly6AhUtU8IhauB
         7u6bJmjwigRTU5hiUIBkCY6ikmlMnAHj1ChfS91cQhDwDLjrrUvLZrY6rmQqmJS5TvA3
         LhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474346; x=1741079146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fY0h+JkzJEPC+Fr2bSYHihmywLYc/knwfAjtuNnsAeo=;
        b=pza2ZgfQCK1XH/yxx8tVDu8atFmZZ0gt6tMEt387+cMwDEVhqkVVzXt7D5UORUDN1P
         jd9g3LwM9tYASfNyJ45uzsBH7v2iPbPALzfMPkOOggyzjX24eY8v0ty189vPTWDktg54
         jO7gsBCyiRVvX3n3U45OdIPtHHEGhu3dKOHEESo2vamsQ0E6lsDuX0cWh+GMSZMP4H5j
         Le34o5baA7Y5WcIN9z1evFPHs2QwSrjfW5WpimYJRCw3gLVbACwtkOOaljJFUCe1L8jE
         Dkk4yWHM3IBJLBTTn/Am4MfhKcTK1XKvx+ZJjMK1akS00U0/Ne48OALSgIpGWwrfxwaP
         E01A==
X-Gm-Message-State: AOJu0YzNXhdkqYDbHIPNeMEQqq0aUD1BE8EPve7s0gFqnhU0zAi6xRkS
	HqrPrs7RVvPEGcri1yV9OeonttGGf0TPlUKiKb7flsviqLtAvYXYI4S/wKXy0WBgWzd6PYoTqxd
	0px4=
X-Gm-Gg: ASbGncs8SXFjg6sG8h5z2t4wyIFnezwJ1TEzN4mDznJquy6+GbAtfwF7FuL0zOA3rKd
	Co2nW9kpa/WSYv00JXJlnWRr8rdh6XD3eEilstNr3DeYV7549evXhhs0YRRCyz6Enu4zGIOjaBq
	zYcgDqNZgUy5QHihCQ43/FeoBYWKQcR2AO2JQ7y2JSqF/YhgMAgeSZwtnYQ3hUHU0K5lICI+sT3
	siMBi79KA7qD6B2jRdnHbhJaAjfh1OXCz1hYsiV2IEK1bTXMd/A7DA50ro4fGmIz/Iemo8FxWlg
	h6Ew80KJ0uZrexfCETo5VPnMLXhVx8666adFxPOm0yDnhiv+R1y3QH9pBGHEv5bSy34UQ3Qq9cE
	J
X-Google-Smtp-Source: AGHT+IGkqhINat7Gxz1iDEnab5crobr9JPjoaawiIMmvU8LrPtIbqlI6khHbhhpw1r11PcRLe2kLUA==
X-Received: by 2002:a17:907:3d8e:b0:ab3:2719:ca30 with SMTP id a640c23a62f3a-abc09bcce60mr682984466b.10.1740474345817;
        Tue, 25 Feb 2025 01:05:45 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d58sm106681566b.148.2025.02.25.01.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:05:45 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:05:33 +0100
Subject: [PATCH 2/5] dt-bindings: wireless: ath11k: Strip ath11k prefix
 from calibration property
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-b-wifi-qcom-calibration-variant-v1-2-3b2aa3f89c53@linaro.org>
References: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
In-Reply-To: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2961;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8usnTAEFm1Piu5Yd2wL1LXpPE1HGz8E+rmzlqa0grM8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvYfh6CpkJd8c70kQJfWzDAjgLHF01wrk68d68
 hSc3oJt3RyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72H4QAKCRDBN2bmhouD
 11UmD/wNk1W++Osvh3b2yso4MtXvuq3PwwRO5Yiz8g4FfR+ea8vdj3Um0ZQ6m48tUIyZ+JMX9St
 URu3XSQHi//YmHCI9eyHnkTUvxjvVLjgee37/OiwUTVMXN4xN6cKjHE1+mGQDP0JzPQGkdTDlIK
 TxSazB/bESJwr2RzDNB9MQIRwUDiWjAJ9oTP6661PQsMlRW0XF+H2OSJ+JDe1lPAbF7/wK4D9uL
 C1IG0uzI2RPu39ZzHnyo9uvdnE8SRQ+Xd+Dbzz4TH8zzEKXaVJljrMLWVF/A/oNGbsZxmRvi5Q6
 VDPw7Xfz5PIY/P++793HL5UFBlqQtl43wRKIOKFMaaUE6z60LM4a1YyMErH3vVXD5bcdeT/WE1q
 Ph+mzNZANDXPdL7CpefayVOEFupDOR5aijsD+z5gOF6pHSxk1HLL0jMRXW90/8PkxsyK5iQI47/
 ZMCrjf0D+KHE+V0sWqazBQyizUIfEDnvImMIrWx3YyPcza/apucuDYzppT4nD+/k4TKUZVBlaC+
 fAhFxaRn3YR9/2+0cbJAi3lyAfLdBTahyMEvV6OA2c83nf+a/jLiCyXikoVwOOrSzlIMJcXhEdd
 c+qjpbafFiIf04McwHGosxH8vkeAkYvgojJ4K+LDDM5tBGfmHfZpLsB3RdhAu3u2nFVm6w3VfMt
 cHMvTQ/ajd2nsBA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Devicetree properties describing exactly the same thing should be
reusable between device bindings.  All Qualcomm Atheros WiFi chips needs
certain calibration data, so properties should not be prefixed with
device family (ath11k).

Deprecate qcom,ath11k-calibration-variant and alike, so we gradually
switch to a common property.  This will also allow moving these
properties to common schema, if desired.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml        | 9 ++++++++-
 Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml  | 7 +++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index a4425cf196aba58e4181e690a0448236aee15e50..653b319fee880ef0944d8e35c545890b60611756 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -22,8 +22,15 @@ properties:
   reg:
     maxItems: 1
 
+  qcom,calibration-variant:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      string to uniquely identify variant of the calibration data for designs
+      with colliding bus and device ids
+
   qcom,ath11k-calibration-variant:
     $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
     description: |
       string to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
@@ -127,7 +134,7 @@ examples:
                 vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
                 vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
 
-                qcom,ath11k-calibration-variant = "LE_X13S";
+                qcom,calibration-variant = "LE_X13S";
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index a69ffb7b3cb884a4eeb51064cc1c8136b433f285..c089677702cf17f3016b054d21494d2a7706ce5d 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -41,8 +41,15 @@ properties:
         * reg
         * reg-names
 
+  qcom,calibration-variant:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      string to uniquely identify variant of the calibration data in the
+      board-2.bin for designs with colliding bus and device specific ids
+
   qcom,ath11k-calibration-variant:
     $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
     description:
       string to uniquely identify variant of the calibration data in the
       board-2.bin for designs with colliding bus and device specific ids

-- 
2.43.0


