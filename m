Return-Path: <linux-wireless+bounces-13459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F098EDD4
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 13:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D836B24460
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101A718593E;
	Thu,  3 Oct 2024 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ALedOsC1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A217CA00;
	Thu,  3 Oct 2024 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954171; cv=none; b=A5jWSuPPRvJtK2ieHXwwEyeYhmy/vIOfVdrV1yIwSEXBC81RsIjeEM+fAR90vMaeEx2e77j6zUAgB1WqyGx8MQ71DiYMkd1n7Q+oZbrUn/1Y8iIP+6zIJGWkVVoOtB3OlLP1ORnRwU0ypE9L4RNmytr6UbqXr4fkPll9++bIIJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954171; c=relaxed/simple;
	bh=kr8KkzqZqD7v494nJHUD9nRrTnPXw7FF2KUsOWYi+Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PF5QAEOB3ubcV8HqZFGwdHYVXKfy9VYvzq6EMc28KFBjrpR7Qs6MrAIpsbGYGQmIQvxRTxT3FKvCywW+xIJg0PDX1rmCpEc+Cb8b1Y3tPwpKkEx3DG26z6XyiFwpZtS9MnWV1yetijH2TvBp65bjNF3TC95o3FLPHO446t2rV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ALedOsC1; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4B62788B89;
	Thu,  3 Oct 2024 13:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727954162;
	bh=tcFmzDMbR5wEJTwT8WTvhkLx7TkTCIPPzwFiS9tBW8I=;
	h=From:To:Cc:Subject:Date:From;
	b=ALedOsC1yEiZOBA+gKNpfbZZrauTvIzp6ojNvEXIYbq159bTpCSy3iNdqOhnU9fU2
	 YNxESMeOJ30B37aez54BEF0K6tzFQYH+1kx7SrXPHZkqmZzwSGabQaqctSmVLPwY4g
	 gGreHQVHiwlRAUJgMkNFUV4uYACSK1+xm/FCmgQNKbCaj8XlO402OGoQ41ow7tOpNk
	 NMavcD72T8nqInWX//K5Bc5DmOlVz0LuixkrU+/CMeNkzKQteBAd+LrJv6f0k1Tfgc
	 0b1ncpGFxSdVWtp0Ks06735DNBgh6+2twWeWRJqEUFK8ZM+UJghj9MVwNs4wMUweXF
	 cG2Yltqr+QIhw==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v7 1/7] dt-bindings: wireless: wilc1000: Document WILC3000 compatible string
Date: Thu,  3 Oct 2024 13:14:35 +0200
Message-ID: <20241003111529.41232-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Document compatible string for the WILC3000 chip. The chip is similar
to WILC1000, except that the register layout is slightly different and
it does not support WPA3/SAE.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: - Use WILC1000 as fallback compatible string for WILC3000
V3: - Swap the wilc1000/wilc3000 compatible order
V4: - Add RB from Krzysztof
V5: No change
V6: - Rebase on next-20240926
V7: - Rebase on next-20241003 / wireless-next/main 5a4d42c1688c
      with v2 wifi: wilc1000: Keep slot powered on during suspend/resume
---
 .../bindings/net/wireless/microchip,wilc1000.yaml           | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
index 2460ccc082371..5d40f22765bb6 100644
--- a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
@@ -16,7 +16,11 @@ description:
 
 properties:
   compatible:
-    const: microchip,wilc1000
+    oneOf:
+      - items:
+          - const: microchip,wilc3000
+          - const: microchip,wilc1000
+      - const: microchip,wilc1000
 
   reg: true
 
-- 
2.45.2


