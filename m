Return-Path: <linux-wireless+bounces-11858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80BC95D2AE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 18:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171E81C228A9
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491FE18C330;
	Fri, 23 Aug 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="T0A7yk/5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839CF18BC10;
	Fri, 23 Aug 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429537; cv=none; b=FQ2OAcbNva5/bMU0iYEuAoA3u2zaOUiLoZXpO1dZQ6CKjbS9ZV2vNM4tXoP3D60MF5blEQyXgAHbjnhofScOsVuEY21YNEO6B13T1P+fnq3N7B0TBJc9mh3t5HTzCQXpH6e809KsAOWHoGkfLFR1czKpnXOYASAc5XoW0MM+BQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429537; c=relaxed/simple;
	bh=gK4TZBvWuPjmilbvWLlSoWRxmOVT1Vj+tmogyixsK0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pv/B2bEQL5aA7rkWVEVAEpR+g8hvreidv1Y+h1G4rcF9zsA9dlvUG0i2FAuMbaszqfdXAfWOiK6YQH1SOd4v0zV0BJTuk0un9/BKIfsoaG67W1I8nzs8Ac4VAK6V7t1HnmyhTz2s2uPAn3V054tVeyCf4PzGfir/1dMo+CMA4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=T0A7yk/5; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BE56388850;
	Fri, 23 Aug 2024 18:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724429528;
	bh=H21kCQs9TQ24efjEOpx9s+TtvXRN6/64soQvxrpKVbU=;
	h=From:To:Cc:Subject:Date:From;
	b=T0A7yk/5KQrdK2PPDj6fq4k1tgQ+16pqqwkJC8ig13QLx14+z5lsVUwNmyagjsdFO
	 pCMAx8XB0avGppfBA9ZY2gkA2T/0R78pdJcq0LyAtCRwy8Y31e1nP4C0kmj30MjBl3
	 E2iuHJjsJ8Fz6g60P/Ah/o63HcwvWIf6xZWdOsuMGbOmjOvVPUGaG4nz1a9prjPSzj
	 M9/6GMymc8LAbJHU3NigVd5JP3x/eihRV13eN3xpv8GPvt+XH873cf/TukEQzSBKai
	 w/+5RWv97QJGV8zGiQv1gKXF5AtM8qJvhUC5fqQLOpo4VIKnoKD3CZUKytV59mtPbK
	 dga/VMTzVSGMg==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
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
Subject: [PATCH v2 1/4] dt-bindings: wireless: wilc1000: Document WILC3000 compatible string
Date: Fri, 23 Aug 2024 18:08:56 +0200
Message-ID: <20240823161131.94305-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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
Cc: Marek Vasut <marex@denx.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: - Use WILC1000 as fallback compatible string for WILC3000
---
 .../bindings/net/wireless/microchip,wilc1000.yaml           | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
index 2460ccc082371..b8ee6cdab3c25 100644
--- a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
@@ -16,7 +16,11 @@ description:
 
 properties:
   compatible:
-    const: microchip,wilc1000
+    oneOf:
+      - items:
+          - const: microchip,wilc1000
+          - const: microchip,wilc3000
+      - const: microchip,wilc1000
 
   reg: true
 
-- 
2.43.0


