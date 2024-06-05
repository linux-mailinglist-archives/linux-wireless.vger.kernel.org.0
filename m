Return-Path: <linux-wireless+bounces-8557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CB08FCE4C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 15:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D891F2C12A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776F21BBBFC;
	Wed,  5 Jun 2024 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Th/cJ/xy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46251BBBDC
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590082; cv=none; b=aVHgSCMQChRQR8IQVOtYdi9KU+U66HYDLUK4klyjuUG93azsFfCWyGxOEBRQ9lzYD3TuIZ7hl01j8nb18O2BYJn4E61UWu1afo6MdPc6de87J9pm8VC6yGUZoeDjZ/5eKSnNnBe/DY0Vmfh1On8jnY/cZFVPnklklyajltryV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590082; c=relaxed/simple;
	bh=7YEGyt6VpbZJTmA1DurKvExLFfDoDWv+Oy/mosUqzak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tg9faHRs/0/9p7NwhBYhTlRVsnMWxKFt1ju/yPXuyQoUPxld6jZz41Tm1HU/ksGagg/K7awjEFvKYRRC7wzfstBwTpM5dE/2TPrBe/cNzk4KgHXZkS0T4yc+NZq7eAhZhbqLoP2FYyk7jp7aqfLp2gUMR5jrI0MMP5hhsejNAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Th/cJ/xy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-421572bb0f0so7028555e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 05 Jun 2024 05:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717590079; x=1718194879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtrY9AQ1HMviMtXqdGs5v4k8JWTeW8ioeVqyYswS7I4=;
        b=Th/cJ/xyhyZYNvWsQcp4w3DeosDYk3UmjdWCHaIN44uaAreCV+EraCECChO5i3lDkT
         yajf3Xqvzi4s9nz7P4BwcHyvgtvOiCC8xPGCWI2V80ja18TzGKSanJ+UoAtb6kYPqAJi
         +Qr7bQXrvm09tyIFXFpJK+1p1AGPC/XO2ydqa1mBz+YAGkxGEMmRZnqqS4etS7slxlL6
         QANTANjYVQi8Nt90gbPY/rlwfOHkA2d6DmuzNFwrUjjdTf1MMsBO+FwR6v2YPY+USpTR
         FfzPEwuNP603rnovyPlqxXPDzivLHo8FC7x2fl8teUcigjRP1cA03S707/sCIofc3eIF
         y7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717590079; x=1718194879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtrY9AQ1HMviMtXqdGs5v4k8JWTeW8ioeVqyYswS7I4=;
        b=HTe1TBo0vhPpbfdzM7PPd61ROCOgM/e9ByEXZBYzfoqLh7bUHZx4XhT0ro+dtmhPke
         HSFXgtizD5oOqz1uRsDpzY90ZwB4lwEFDxjxcK1iximkQAmxNepq6DY8dirJjJahmBhy
         aVUJmsOFw7EX8loq0xUO4EbTR9ewqFAKH/N7RirPlTiN9lrvqpR+vMsiY6XTJJAZsSBk
         CPYgLr8Z4WA9y+PzCgusTQtVjjpq9nsX8HY9fjjc+ftf0ZfnwtXSl01NSn6bj3/CewiB
         WV6sWmtijrhPvregG9Nu00FEOzi3Us2Ld8KePF2C0KqXxS5v6pAHhpy1ZIPJvRdgcULc
         2BGA==
X-Gm-Message-State: AOJu0YyKtZdQHSeP00lK6JkRZJACyWyYqS9lD2/qe02ekr/iBz56FKmx
	pag3oI2Nh8CPNajr6tcbumwK7yF0GrllFiL23gkiHLYTL4L5XXp7qm9v5nQGWQ8=
X-Google-Smtp-Source: AGHT+IHX0hwMEdRN5Wsfn67SdyNgnl9018bU7fki5GYdi8OUdKMJ4OUu2nbQIpjUAkYySA+jeO1imQ==
X-Received: by 2002:a05:600c:1e02:b0:421:2abe:54e3 with SMTP id 5b1f17b1804b1-421562cf532mr18320735e9.2.1717590079340;
        Wed, 05 Jun 2024 05:21:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:d3dd:423:e1eb:d88b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215813ce64sm19634485e9.44.2024.06.05.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:21:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath12k@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390
Date: Wed,  5 Jun 2024 14:21:04 +0200
Message-ID: <20240605122106.23818-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605122106.23818-1-brgl@bgdev.pl>
References: <20240605122106.23818-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a PCI compatible for the ATH11K module on QCA6390 and describe the
power inputs from the PMU that it consumes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/wireless/qcom,ath11k-pci.yaml         | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index 41d023797d7d..8675d7d0215c 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -17,6 +17,7 @@ description: |
 properties:
   compatible:
     enum:
+      - pci17cb,1101  # QCA6390
       - pci17cb,1103  # WCN6855
 
   reg:
@@ -28,10 +29,55 @@ properties:
       string to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
 
+  vddrfacmn-supply:
+    description: VDD_RFA_CMN supply regulator handle
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vddwlcx-supply:
+    description: VDD_WL_CX supply regulator handle
+
+  vddwlmx-supply:
+    description: VDD_WL_MX supply regulator handle
+
+  vddrfa0p8-supply:
+    description: VDD_RFA_0P8 supply regulator handle
+
+  vddrfa1p2-supply:
+    description: VDD_RFA_1P2 supply regulator handle
+
+  vddrfa1p7-supply:
+    description: VDD_RFA_1P7 supply regulator handle
+
+  vddpcie0p9-supply:
+    description: VDD_PCIE_0P9 supply regulator handle
+
+  vddpcie1p8-supply:
+    description: VDD_PCIE_1P8 supply regulator handle
+
 required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: pci17cb,1101
+    then:
+      required:
+        - vddrfacmn-supply
+        - vddaon-supply
+        - vddwlcx-supply
+        - vddwlmx-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p7-supply
+        - vddpcie0p9-supply
+        - vddpcie1p8-supply
+
 additionalProperties: false
 
 examples:
-- 
2.40.1


