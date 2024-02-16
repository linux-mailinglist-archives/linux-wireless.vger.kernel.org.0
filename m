Return-Path: <linux-wireless+bounces-3699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0A8586F4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 21:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EF01C210B2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9395A14AD12;
	Fri, 16 Feb 2024 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vNSW99UH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0DD1487FF
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115603; cv=none; b=qF3lBdXdXBBjkqT7KK8dLJfm0Cugtck/DDQH67VRs76+e2lr9/+lXn/MxvW6xbVmZj5/aI7TCDAFnx4Xya2e8h2z7BCeY27cEJbLCmsg8A4aDXkcyjeLxk/AYTHxkkmFLLNijZb8eldOXIeM0l0IKdTMFieEX8ciRwbdJgPwjag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115603; c=relaxed/simple;
	bh=O7nx4GuaEFpnnuUD6ygAdgpAn4wNrIX0dYYGgklGofM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X98B/ozfW945TCpl94G/hRcu2IWs7jZBqSjwwg9cDTvBia6/zpu8raQviz5+2VEtUr9PLXhUDAsdhYqIxHNV/WGoG8IVfpp8QtjeU/7nCWtLR8YpcJzrxedLIFSdaPWHXCu39oeAVev/h/u/7WMgxVkP2kCZq3gWGJSTUGAAuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vNSW99UH; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d09cf00214so15778781fa.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115598; x=1708720398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCxfUMaCEPLwwU/U5b6rWEOq2v1UOckbc/XqxqCn7/I=;
        b=vNSW99UHa1jexGB4uT35qe82IbU6ZjYwLgsG1TXnp0o9F6kUwIyOKAD2/+KlHR3Dzn
         Y2OeP4kXe/GSSKo3Dm1QWh3dwp8XUT1QdMrr12oYcAKtxNnqdh0vcptxu8ow6VD0IVAH
         x8xEStW2omL4NUBn1jA8/GA/Etj7RlY+xD2aRrFZQl+0LZjByzYRt1xoT63x+T+LbaBk
         AjCaRbncHsR3V3gwLY98GYBzxnKAdC6P3RgGKifTBdqOaL0Pemu4tQUu42K5F3n9875/
         P6zFgQ0iggZlgwRcEZ2OtIbBYRkkzoL4V0VdP0AEqsURX4x7cP2ddeGgwfFENnVZA96F
         r/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115598; x=1708720398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCxfUMaCEPLwwU/U5b6rWEOq2v1UOckbc/XqxqCn7/I=;
        b=usf/JiFcUhFR1YPf+jbAo8VpbC7i4uzJ4SrQn4lxZTwGl/1KkifIwzA972t6nIplwX
         Rt+l4suhFdx4thy/cCCRSdp4pBgkhqhMAhoHBg2K9XzUrZpxwcr+VV7b3FfP0UanTdsh
         NaR9A/OKkry7j9jv1PaGFTaOEizFzPbsPrIOj3l7VHNB+ZVf6UeePdxu+iOsK0h+5Gwj
         I4WkkXQ5pPPFUfjcfHb3gkzwGwvJlnUUEbVuDlUrdVEy0w6LiW8cu5RV1GtvzbL7Mm0j
         WjAE+BboZIZ5BfCDGi1QAuLiBZkeuMxpRkWxLmJrhKri3RIe7Tbb9ELll93flZe7SlNU
         H1kw==
X-Forwarded-Encrypted: i=1; AJvYcCWk8pMT8Sjk0jUBi3W733xl9PArQctsdzmWqM4zG31vJZePUoWtdeqC0gzO/wIwxmIcJ1R3dQm70Qqeop6G/C9j+UZi9m7y6l78hP0/S7Y=
X-Gm-Message-State: AOJu0YxuhuAfUQlw9IrKAyXDWAbkZPWUi9Pu5Q90opsNr/XH0S3DNNJ+
	mO69vGxkJV9Pnfaj0La5M+NIw0urpM14UoZP8X1BVFcnWAVwD52Brj+AAe1a7Dg=
X-Google-Smtp-Source: AGHT+IFAXOhWT1XmRLdjz3VCAvr/YH6TnW+qrkPk0m7YA7Kc63/Ou1aaEWcCkYoTCQIrVMOwhQ0h5w==
X-Received: by 2002:a2e:8812:0:b0:2d0:99b7:e68c with SMTP id x18-20020a2e8812000000b002d099b7e68cmr3478497ljh.15.1708115598736;
        Fri, 16 Feb 2024 12:33:18 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:18 -0800 (PST)
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
Subject: [PATCH v5 05/18] dt-bindings: new: wireless: qcom,ath11k: describe the ath11k on QCA6390
Date: Fri, 16 Feb 2024 21:32:02 +0100
Message-Id: <20240216203215.40870-6-brgl@bgdev.pl>
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

Add a PCI compatible for the ATH11K module on QCA6390 and describe the
power inputs from the PMU that it consumes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/wireless/qcom,ath11k-pci.yaml         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index 817f02a8b481..8530f01df6d9 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -16,6 +16,7 @@ description: |
 properties:
   compatible:
     enum:
+      - pci17cb,1101  # QCA6390
       - pci17cb,1103  # WCN6855
 
   reg:
@@ -27,6 +28,33 @@ properties:
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
-- 
2.40.1


