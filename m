Return-Path: <linux-wireless+bounces-11760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E78695A4D6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 20:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4F9281D1C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 18:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7A1B3B21;
	Wed, 21 Aug 2024 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="s400D4QT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF5199926;
	Wed, 21 Aug 2024 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265860; cv=none; b=uVTHfk0z8fmdM9eOIEt3bji+6l5uHZQdU3ErKu+0GB+8Zh993EvJ94OTEXZZ7Y9QkCCWDYVT4wmc83h7WUsrHCu2qht3oBm3Ui92fpmQq+TZ3i03ySELaodioPua4UFk4Qge/V6vf5UImFgbyFw8I9S2zq99hBqunUntz2/Obiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265860; c=relaxed/simple;
	bh=MPaUWXSOINPvX+CQrC8RwBjzowmWjAgiYAP0P506RfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eg670FnQAREvmw/7CKDGZjiAJQKtnHds08YXybxmVrzSnEjBoxXdiaVfXB++PzeQn4ilT3dPZGNopnE7Di+rqq2y0zQutoz4WRVrAMey1Lfo0baXQ3ACuciFobkTsFKwyBHOBa6Sr1PLPtVXKzCbaRwITml5KmyFiuwGdmrDS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=s400D4QT; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 989EA88E3E;
	Wed, 21 Aug 2024 20:44:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724265857;
	bh=UTNdYiJdsko1ICNQhEaEuw73Vq8Ezc6W5FAdESZlgSY=;
	h=From:To:Cc:Subject:Date:From;
	b=s400D4QTVFlnWSAtgDffBkvqbtorHhaE3wRypjID8LaBOHKnJa7nenHx9pAB+sEbh
	 m6XqH1zAy0rnUzW8EPE+BCCRPSrArgSvYc/YDwBP0dex9rvvf2JCXFIEUKdLv4egMI
	 +/dyrAhUWIlSBn4Ynq+pWJyYGFnZl+5/HnMXTiBJhe4/YRtm4uXxs3n1a11xjbcrDE
	 NpZdDiaAFbQwpijLbhTyowMoqstjinQOIF1Cs8x6AtgDHKbfQVJZshlV+bBPw9Zu1X
	 /7Y2XywWPI7hAP11Hf1W5vMXP2TQOOel4erOFQe/uOYxy9rk8pn0pTd+xhLta6Nij0
	 aBcmysdhQOtLA==
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
Subject: [PATCH 1/2] dt-bindings: wireless: wilc1000: Document WILC3000 compatible string
Date: Wed, 21 Aug 2024 20:42:32 +0200
Message-ID: <20240821184356.163816-1-marex@denx.de>
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
 .../devicetree/bindings/net/wireless/microchip,wilc1000.yaml  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
index 2460ccc082371..1bf3496c21e64 100644
--- a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
@@ -16,7 +16,9 @@ description:
 
 properties:
   compatible:
-    const: microchip,wilc1000
+    enum:
+      - microchip,wilc1000
+      - microchip,wilc3000
 
   reg: true
 
-- 
2.43.0


