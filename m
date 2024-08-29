Return-Path: <linux-wireless+bounces-12191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1E89636F8
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 02:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA33B23670
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 00:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF4E101C4;
	Thu, 29 Aug 2024 00:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="C+V61WXw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D91849;
	Thu, 29 Aug 2024 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724892342; cv=none; b=qouY7AV3g+Naa0Pq1u9ZBXymOJz/9OgpBHIhQvd43/VxMmaSe1iuKYrtTqB9T1rEjR2qLg03wx2Ll+FkiOXdVb8eKqgrkoApHcEXsa+JfuyuNoNNUM/Dbkf8WaUFLX5aodmu7bfD84LtCl8hviSOu39fiRl355ITJZLhB5MIq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724892342; c=relaxed/simple;
	bh=vCQMUcJy/hZ3Zoy/YP0clLZx7pwb794hb6ScNapZUp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eiu+EEST6Xg5UpJ/kMt3walsnbk1XHlT/YKpNVn7F8BiBa+ov4AglesrgM2Nxsyi8OB7/P72osvdKYiw1jHnno2PdC6qkpihKQbh8FgAv+EKThTuvVdzc8sfMWxkMOf5TfLjpOnw56PSei0+xDbrirKUIIm5uM8WdZEWKy19Yfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=C+V61WXw; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9379087F3B;
	Thu, 29 Aug 2024 02:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724892338;
	bh=WA0rT1dfe51e0ay6zmz8IO2cS0uHxuese6NkJJ3tMwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=C+V61WXw0SU1jXTO5kaTEVtww+neuUAQb2giWpgKaRjfZuEOOlodlLOLdkVXQQFqV
	 qUjsjMeyfK4c1No7cqA1QY3Zpq9uoEFCD/Jj6yLaqX0pkOAXtx2YDVXpmoBMUt8N1j
	 BpqwreFjD9zLrw5rjVhHEeheQuJfqGvcukxgQ81X1LdK6eORrREd0jJS+0iY0gTQG9
	 sY9VuTaylMjnq9HGc/EjEHlR+ZnfBJfm1XUngZze6KWnQaMwFDQuiNxosF0ZxK9Sni
	 df3lLCmto62a1slq0MoPJOqIMmei45jsd63sq/ZV7yWQX77wn+4IS17afPaFuUBahA
	 M9GW+Ub4aza7A==
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
Subject: [PATCH v4 1/5] dt-bindings: wireless: wilc1000: Document WILC3000 compatible string
Date: Thu, 29 Aug 2024 02:44:59 +0200
Message-ID: <20240829004510.178016-1-marex@denx.de>
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
Cc: Marek Vasut <marex@denx.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: - Use WILC1000 as fallback compatible string for WILC3000
V3: - Swap the wilc1000/wilc3000 compatible order
V4: - Add RB from Krzysztof
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


