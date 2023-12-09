Return-Path: <linux-wireless+bounces-591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0880B527
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Dec 2023 17:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C998328105B
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Dec 2023 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A3A179A8;
	Sat,  9 Dec 2023 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoGJUM7r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16CB13A
	for <linux-wireless@vger.kernel.org>; Sat,  9 Dec 2023 08:05:11 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b5155e154so37454735e9.3
        for <linux-wireless@vger.kernel.org>; Sat, 09 Dec 2023 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702137910; x=1702742710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbsPZUF4ysy0Z2Xnr5Uq7PdWYL0AABtRsCTOnasJIcc=;
        b=xoGJUM7rfbBmtwsgiY0O1yvMYTlFDOoQczLgB/MlOsCyMIcbkdqQmom9a5Jj5iPvKs
         JKzoxg3F7qyXecj9zCmHCTXLvSUNm5fN06QIpRsja3SThHwH7sdSm506dkyGQr5laJIM
         74/n6q0QDuocVfJz3l5zN5LxHfy+O/vNHvqNluOP7DNP6/4UTLKSlwZIFktRnRScG5wI
         ya7QkbpdvLzpzUGObDk05zr4soz8DnjZNdx0AsetYbCKhZv4iDXl/ao0JPeHz5S6DQx9
         PX+yl0kx3IFDF1Nzyz1f/9lDvmui5C90HNByMN+7LzhJ2ziz+s8ZQY1DiHYIOs9l9doq
         cvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702137910; x=1702742710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbsPZUF4ysy0Z2Xnr5Uq7PdWYL0AABtRsCTOnasJIcc=;
        b=or8k2ipsXXZgeT8vPrOg9NrHWe/F6knlYjvnJp+mmsNskYSuzd3jlmqiMEuvI1UJHZ
         NIYFKsML9OKOcB0Gv3dRaTQDowwQII6hRLJpZiFqHd1ujJqA5LLqKgCcdEhiWV3dwHD3
         CbTmAtZllHD8K+/8njMWrcgthevedVS6TXRx9ZzHaK1HSiHpu9gLDfn9HeYB+yARE9qS
         0H0hca094L2WJ9jN4FHvFZqb2eVbfvYhz8yWVmrAL5Q6eL8Wz38mFi3JJB8Ekez01W3X
         HiwGGkdCSSoUp7vIJMM/qhaenNFNHxXISTXzVlPBiIhXxY9zT3nnT1vNN6VBN0jim8sE
         Ro8g==
X-Gm-Message-State: AOJu0YzsN/QlXjIrwq9pMBpb3jxdcMq8MUcWn3bKRhgBdxZUyGIWhCO0
	xdZlDsInY9oH8YkhHSrwVKTKxg==
X-Google-Smtp-Source: AGHT+IFkLcBZfcLMdnzbi+IoTj6s/20AM06M7UlkM7GEdf6A91oFcd3ajlkYSGSjJjvizw73O5wocg==
X-Received: by 2002:a05:600c:45c9:b0:40b:5e21:bdce with SMTP id s9-20020a05600c45c900b0040b5e21bdcemr840742wmo.93.1702137909793;
        Sat, 09 Dec 2023 08:05:09 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id mt39-20020a17090761a700b00a0ad10b3f68sm2343077ejc.205.2023.12.09.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 08:05:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	van Spriel <arend@broadcom.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dt-bindings: net: wireless: brcm,bcm4329-fmac: allow local-mac-address
Date: Sat,  9 Dec 2023 17:05:05 +0100
Message-Id: <20231209160505.237843-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some boards come with local-mac-address property.  Allow it, and
mac-address as well, to fix dtbs_check warnings like:

  apple/t8103-j456.dtb: network@0,0: Unevaluated properties are not allowed ('local-mac-address' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 4aa521f1be8c..4c8a7950c83e 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -67,6 +67,9 @@ properties:
     description: Name for the OOB IRQ, this must be set to "host-wake".
     const: host-wake
 
+  local-mac-address: true
+  mac-address: true
+
   brcm,drive-strength:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Drive strength used for the SDIO pins on the device in mA.
@@ -148,6 +151,8 @@ examples:
         interrupt-parent = <&gpio>;
         interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
         interrupt-names = "host-wake";
+        /* To be filled by the bootloader */
+        local-mac-address = [00 00 00 00 00 00];
         reset-gpios = <&gpio 23 GPIO_ACTIVE_LOW>;
         brcm,ccode-map = "JP-JP-78", "US-Q2-86";
       };
-- 
2.34.1


