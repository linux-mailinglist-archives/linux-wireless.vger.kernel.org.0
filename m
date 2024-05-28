Return-Path: <linux-wireless+bounces-8222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A75308D23EF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 21:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A77BB23D59
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A417B41D;
	Tue, 28 May 2024 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FrdXRgiM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45C17A937
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923039; cv=none; b=rAloj8XOiV635cobhwgIUM3eXi+20Q6djeRgrjY5xdNcQY/Hw5I1Hh7KSQXXLIJUZFf52dutfB/4kFUNS5I25d4z41Xlyy2v+8NOWR2eBjo4tJUkt0Vx7Ulom66Snx+REipJ4IwGzD0jy/OIe8+zAkIwueR440E7PbxZ06k+QkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923039; c=relaxed/simple;
	bh=9H/fLvvcSaR54ngs1jDyeEbhz4pnrOGHjYQGqnTjk+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ww0LE99ADzD8pRW7WuYrMk4QCApbW6gMLbEvIwEEeSd2JgchFkWEXNegvRmeQ10pHsk3h3Fivr1WjbwJb/Bx9D9fyNYTxNTHdXgJuj6EZOSagPgGIiuFOvJGtRdXfzMi/aj2jMxwjBKN2MLpVS/Ywm/30+bTCB/Ju4/M5lJLDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FrdXRgiM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-357ec504fcdso878064f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923034; x=1717527834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARukf9GYdWwhp4gmhZ7LfQBE2SXe7vwdt7HbV+J/3YA=;
        b=FrdXRgiMwj4LZnT2gzoELVBNBN3AYJqjl5qMM7y5XD0FZAiP3iaqR2eUBvwLnV0ykS
         +kdG6q8zrbp0wvo3qIpvU8m0wsoNFCxcYEhzy576AyPAVtMdR89ySFLkenMp9JnnKmA+
         Y7R3+PTpnfsXZD1rqFcl4aTH6rd5DxLX4L7THZitfx/vaVhzNoZeJKqMsr0IixfvAbTl
         i8OQGjFbJpSzZ08jW2qNqdyNrP6C1j9OrDFfPgF9bUuF5PbPju7SFWquEbLjSt8O6oLC
         43SCOoej6SzJgg2tzQkGt30bx2FxHUD9yJHa2XmcH7YKN1XoFl3nO/a3OwUSuacR+zuz
         eGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923034; x=1717527834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARukf9GYdWwhp4gmhZ7LfQBE2SXe7vwdt7HbV+J/3YA=;
        b=MxTWmF9gg5wFQG8Q5W5Q/RVFItE0pJzWafdTV5NWSvCMKe+nmS+X8nxOJFNC14Xc+g
         4f77dMSGt3YpDTrbLFezSblkJFNAsRLak+5BDmEHo06QWIHzHgYXuGSL7iRoNDhn0Dgz
         9C1hthtJqLsl6YyaLCIXq8xbLupo1K9WUqh7pkdIQ2J7juUjOrkmnJ/08iSE4pNxgMmA
         MbJJmqmH09tzoeeqhpcpXiPX8x0YcNlSeiFBWKEzpafPNtPgnEz524S9oJJd+/6HcIz0
         EH6590NEPTYWL0B/hJ35A7/q3FECuiYP7Kk5VuRiCfiNr5RVthFrEkM1shFVp7kLn27N
         pq+w==
X-Forwarded-Encrypted: i=1; AJvYcCUCbZHZLUuvH2RP3KQ3bNzaIj2z4jTPhWXIiGkkbaUCYvqhiXQ6kaAoeo08pIkzMQOgKQxFNInZrxRnGwWEO0kaWougve3EzVGIACinLFg=
X-Gm-Message-State: AOJu0Yz1yDLdpGwAJ8wQzajov6WJGgbwpkpc4AA3lZQb+cf0BrfJbjaA
	+vbPExSxXWaF2GtI/jd+mCUbwVO18HwWILhJv8V2a0tY7/1MXEeCer6L1c5gK3M=
X-Google-Smtp-Source: AGHT+IEAkjwH/NK3O6U5emPpYqfTemgtvoInaezOh9aGiKYT3aTB9vJVz1gN9oNBPFAqocFQQCD03Q==
X-Received: by 2002:a5d:4ec3:0:b0:351:ce05:7a30 with SMTP id ffacd0b85a97d-3552fdf23aemr9553489f8f.52.1716923034440;
        Tue, 28 May 2024 12:03:54 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:03:54 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:13 +0200
Subject: [PATCH v8 05/17] dt-bindings: net: wireless: describe the ath12k
 PCI module
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-5-d354d52b763c@linaro.org>
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
In-Reply-To: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 ath12k@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3338;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=tZHnqdJlDyCPsZfIWq38ZYfksNziOf582cWrfkALzlY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqNDFaR71/0ob5YGHxnuMESYLlibocsNBAnz
 W1cPnFAbMWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqjQAKCRARpy6gFHHX
 cnbuEACEzuQHw1lAFZBJuv8eQ94F2cid2ocs2SKvk4pscUFcmPb1a0OGPXsyq+QnlFm/cZYgWs5
 WyFAqy6UNQf1PIunzufvfdj2JTYonmpwk20C4C8smtqpjoTqjECeatk3JYCOwZSDau8l965dZ2Q
 sv8uGdFyOHUWrNp1n+3UkxZcJsD+rzRuI/BGAufafD/j688u9RoRhwAmELE42DG+NHmuZDgawH8
 jvbtppwHavVwS4kv+Bo5WTBGcFnXeqyQTRXf6ABjOCsM0djk6BDfwlNBb1RdJ2OqWQQ8QXKsh0B
 uQyGSqVpf1OYGj/Hr5bUbFH943wOJcmNSriDMWmadoQeZOeCz0GpqsnAWZ9sCPK/Zvt2UURh5hY
 Grm2kUfj2y/svdNprXYeZgm5YAlG3rLvz8RdqcyzjXbTrrKRI9l1ZjwKDJTxG/bUXjBc0Z3UZMB
 gWzgZUElhPrEs9dPlc4nVjPuJvmEw0B1oets0J5MMxtq1ia/q6gXiXAbx04DR9QBOgr//4z9am4
 lCadBjr75amBTpsnthAVDMGVB3Mckb1+9dt0cQ+xxrXaIC+0FiHrXWscNaxa78/O94NoxlxSAQQ
 G07XA6GbBefaR/gONcFxJBlrvJ/gtGkTDt1sq/myj1lZcmRVkA45nECDxHif7SpPmGx1ANwxYfw
 amjhhySJcc91Rdg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add device-tree bindings for the ATH12K module found in the WCN7850
package.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/wireless/qcom,ath12k.yaml         | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
new file mode 100644
index 000000000000..1b5884015b15
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2024 Linaro Limited
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies ath12k wireless devices (PCIe)
+
+maintainers:
+  - Jeff Johnson <quic_jjohnson@quicinc.com>
+  - Kalle Valo <kvalo@kernel.org>
+
+description:
+  Qualcomm Technologies IEEE 802.11be PCIe devices.
+
+properties:
+  compatible:
+    enum:
+      - pci17cb,1107  # WCN7850
+
+  reg:
+    maxItems: 1
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vddwlcx-supply:
+    description: VDD_WLCX supply regulator handle
+
+  vddwlmx-supply:
+    description: VDD_WLMX supply regulator handle
+
+  vddrfacmn-supply:
+    description: VDD_RFA_CMN supply regulator handle
+
+  vddrfa0p8-supply:
+    description: VDD_RFA_0P8 supply regulator handle
+
+  vddrfa1p2-supply:
+    description: VDD_RFA_1P2 supply regulator handle
+
+  vddrfa1p8-supply:
+    description: VDD_RFA_1P8 supply regulator handle
+
+  vddpcie0p9-supply:
+    description: VDD_PCIE_0P9 supply regulator handle
+
+  vddpcie1p8-supply:
+    description: VDD_PCIE_1P8 supply regulator handle
+
+required:
+  - compatible
+  - reg
+  - vddaon-supply
+  - vddwlcx-supply
+  - vddwlmx-supply
+  - vddrfacmn-supply
+  - vddrfa0p8-supply
+  - vddrfa1p2-supply
+  - vddrfa1p8-supply
+  - vddpcie0p9-supply
+  - vddpcie1p8-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/gpio/gpio.h>
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            bus-range = <0x01 0xff>;
+
+            wifi@0 {
+                compatible = "pci17cb,1107";
+                reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+                vddaon-supply = <&vreg_pmu_aon_0p59>;
+                vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+                vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+                vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+                vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+                vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+                vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+                vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+                vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+            };
+        };
+    };

-- 
2.43.0


