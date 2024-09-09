Return-Path: <linux-wireless+bounces-12693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CCA9722B7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182B71C21BF6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6018A6DB;
	Mon,  9 Sep 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CjU9oRyB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94133187856;
	Mon,  9 Sep 2024 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910260; cv=none; b=C1fTDK9sOq+KGSR53b8J6f71BRgb6wlTl3oKgglSO8gaiORFEwZw5bXAaG9PNc+AGbi5wfIDMwaBfe5YqHQ1i/YlRLhZvOCYjDZ2kTMtzH7Cxo2yg63zt8grVHCzUg+n/aAhXxBiXWC8Bnlca2KJVfbOsuGVOK1Ju5t1gupXbsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910260; c=relaxed/simple;
	bh=YjTqvMzagJuYOyJovCgcMuy1VZe1LKi1pVIbHww1TFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DWlrcAjt05HI9Y9IOQYTnWBzXYMCzdO8F6Z/x+DOYYl7ZCKyGZ82hqsPIauumTL/LWx26WbcKU1EDPccR4y8dxUL9Z99/XRpSmtuH7RbnsT/btrmgNg0qXmBe0LY7Sx6vwEmX2X6N/9zjrpWhknpKTdPv/I3MTgeVTWxlb2roTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CjU9oRyB; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0DF3688E22;
	Mon,  9 Sep 2024 21:30:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725910253;
	bh=uh5AN6xDKGE1pzc2KNoilnB4rzgHoJXgd2N+hYXJPcg=;
	h=From:To:Cc:Subject:Date:From;
	b=CjU9oRyBgMnnDPUNHce+OXT2tiF+ffA3mGOwE793g72W4CTOrh/aN+5+bCa3Lonfc
	 D4F65NF2q3wpLsw9jAMnHpKDagujGnZvyUmcTpSt+IpZyOoT1KlOCek2Kj/QlGA26V
	 jt1tJA2aA9f66sBOvI92nOOHMblPg8DB1xKk+vZfd4LJ530ozj5BLVxhERsdT4UK6b
	 2elbjnRaF3wHZTa1JWwCDaoy3uwo8jOAQsGay4wTL4nrpwRCTxff9URo++skatbuRB
	 8f7fNqXbkrKbQf5p6hOa3xMFK1AtZmZBeSZ6TRvWHn/FXZvFLmmIYPIFGic/Pi2PJe
	 CRx8f6GyNNLpg==
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
Subject: [PATCH v5 1/9] dt-bindings: wireless: wilc1000: Document WILC3000 compatible string
Date: Mon,  9 Sep 2024 21:29:42 +0200
Message-ID: <20240909193035.69823-1-marex@denx.de>
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


