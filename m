Return-Path: <linux-wireless+bounces-12077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E0961456
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7C91F248DF
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3914E1CDFC4;
	Tue, 27 Aug 2024 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="jtl8hu8k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D28E54767;
	Tue, 27 Aug 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776896; cv=none; b=Y6GzcUdn+2KTTUqWudnz+YCGtb6UeIfhdgtlHeY7+TmC6Z/jYqjgnWy0CClUSedUMlBO+YZjD7MsvkSPsmg+RbA6KmJQ0MrXt8Sj8S65D5JJLdny1xZcjuvqiZlMBhmQV4LvNdV3Fk6YCzL2r5Qqq0f64ZBAJERwjX3Hx72f7Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776896; c=relaxed/simple;
	bh=O8Zqku3VJPn/bB8kEuRa1/1fieXJMnX+59WjC/hY9YU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I/UZ9Rc+47UgG1pcvMPzSlKou5JLET2e4ByNy/TFXuKtsRpHcLdAd223VzSRoWEYW4AtvsI+dgKO0rIOg2f1H/rS24H+d6/FVjBAhVDDlEu7FPBLZ2X+YMVAWxLW0n/OiS97eUqY3PXPURx5xNf7zmFTGb2EEguo0fXtFhlJBVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=jtl8hu8k; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6A7B4886A7;
	Tue, 27 Aug 2024 18:41:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724776892;
	bh=G04kViyzMxLTBAfMfuThnC65MquXy9lJNJNrl87Atus=;
	h=From:To:Cc:Subject:Date:From;
	b=jtl8hu8kv53kQBJZdcr+kAtrv0WtVhbpDFnn8e4ChZF1AZpoukBA3+PxvMV19F4kB
	 msWcYC79tWoGKg2NhdTwhPG2AkSTqi3HemKDpSn4vGJOX5BFV8LCcKtJJJZl7UqjNa
	 5ZG3Ytztsz2OOwJgGBRD8beAx2qhrIx+FV1f++X5WQYWPKNnZU2vmQ+6zERCYIVl8o
	 nig2z/Rqp3QeVNWL4SeHxn0jv9wE1GOtN/Te1/maM/yXwUuZURHye5ABm/zNuRsRxK
	 qsEi9pHoerXbnQyg8fDmVg24RcKp0jKr4wqVgdPkNHWeqn98sDx1593X0Y6ioZ74Fm
	 y+ggZwJc1PeWw==
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
Subject: [PATCH v3 1/5] dt-bindings: wireless: wilc1000: Document WILC3000 compatible string
Date: Tue, 27 Aug 2024 18:37:38 +0200
Message-ID: <20240827164042.53698-1-marex@denx.de>
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


