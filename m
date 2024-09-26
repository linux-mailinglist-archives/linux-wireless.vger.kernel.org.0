Return-Path: <linux-wireless+bounces-13238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E509879D0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 21:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A008286CCC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 19:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9720F17C985;
	Thu, 26 Sep 2024 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="plqy3B8l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17EF15C148;
	Thu, 26 Sep 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380657; cv=none; b=VaFx4MlMzOmXsj0wRPXr/OB7Ri/dsbJi9qyybP4dyHeWX5iyyBEiezjIXw1TAxqEF1FKTSg2XIGJM4Kpfi+VRWjcCHNX+vddvkZ1OjrU5QATqzdc9PKU7WceTc+RqovUX10KfYKWRyp1H260WCCANmFe6kgEfDJ3tO/2+V016N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380657; c=relaxed/simple;
	bh=uU77YpHQVhIUgrwrGUJq2xZhAXkSIVNh/1aVMgULDA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o25fdj0Kkf+X3uLH83yiJCviSY6QiC3XBTcDhifSqs4KROff9tmdAzQ/mqxNaHt70QO8gLBazXF40DWcotyVz4NCFpXezoAHtNSi9fqJRMosZRU06qCYGiqhHucr9ua8eIhyVlbK4HL5dyHLrG7K5qffoIOX8aAgXLnMZfrHV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=plqy3B8l; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 530C588DAC;
	Thu, 26 Sep 2024 21:57:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727380654;
	bh=HLbhG025gn4ZmbUZCLrc4upsh7MPxA8iYk4BxSTCMR0=;
	h=From:To:Cc:Subject:Date:From;
	b=plqy3B8lA/iDjRSBHghFa4u1+rEyFc1lIQVmO+YxbuM3nx3RtGyAywZ8AFLE1Fjuk
	 gCA5UegdtgtdaDIPrBOPN3BsRFVIY/pXbUpxMnJ1Ppf2/XqJFyXonJOisIF9xsexYP
	 H8yd/1i3D8PFmmH2NgZb5hZRabwUjmPeyzhCyc7v+TY0M4McVWhx5X9AKdu8fcFYAz
	 5Sh3iQAh78hkq6ddxN7QRzU/SzQ0DdOHLtW/sQSHGKQFiNBkfeqiJUvKe9LKCFFdqh
	 yBXM1+DUYBgjbLmG9wtutbhvcdmY2slmAhD2vGYbUECw+u4VRYCGh5JrVQJSD6TXOf
	 jci1H7tOenQHQ==
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
Subject: [PATCH v6 1/7] dt-bindings: wireless: wilc1000: Document WILC3000 compatible string
Date: Thu, 26 Sep 2024 21:55:41 +0200
Message-ID: <20240926195700.2823751-1-marex@denx.de>
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


