Return-Path: <linux-wireless+bounces-18847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C46A32A76
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 16:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C1A16421A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856FD22068F;
	Wed, 12 Feb 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GqpzyR3I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851A207667;
	Wed, 12 Feb 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375272; cv=none; b=l8Eobbf43zqqgS1nTCif7WJN4SNHSmkv1sMyZjHHMsSQGdXr3hzXRK0HGj1q7B9jmt4+gyGYTWE7ev0T4ryvWe9zU5Cj8GgknLzkSCPzMXS+b9bh5TzZF1fjJuDwSkCq5y8GeUbpIbTMYXf7sQrz32KbRZvcJiiEtKnOgYPTTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375272; c=relaxed/simple;
	bh=JiiR9fVcT1igBQ8zQ9MI3IXIacvn9Y0GMWLLsV26JlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RrS0bteHymRvaRPppfNm8iyJOAIxGPmN+GAjVHWsVS7RBGKDT9Z1iwhx6h60HksTR3UZo9VrNXhXd4gg/zddssuBG19PKKvw1sIWoMV7Y4OP7G2xR3dkFMEfUbr9M4BaUxXAyxtwl5HD42NN90NzUJlxiMtjfnhNVwXscuyZtmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GqpzyR3I; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2981440F0;
	Wed, 12 Feb 2025 15:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739375267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeJr9FDsSYw8HIYplOiopf+69p0J/ihX2v3ROipEQ7M=;
	b=GqpzyR3I4uTG51rFsmP2OeUzCa08P781lS4wsNvNHRNmd/hynSxYClZvWG9WFq2IegO/w1
	A51zUmwAIb0tOVWCNvmAm9n0/A10chDETCHI+1HKsHM/Ovz2OSajwF00FkXJnJE/C15SAs
	1GkkhvqpLHoqtvNznIDUPJ/QO7jw2R03OEZe0dPHPfZ/rAprtx/OaRnE5ajysaKp7aiJaD
	NJAPcz7JIiZ2rrwNQdGBgQQl82Varuc7mZ5G61xLisFjCSzBSTTEG6P398TclZh2xpV16S
	ECf/mp+xCkm4t/Rvk0jOMaTYbLNCBc6adWLKI2NJXyi9GNSzbQy7l/aWePLSdw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 12 Feb 2025 16:46:20 +0100
Subject: [PATCH 01/12] dt-bindings: bluetooth: describe wilc 3000 bluetooth
 chip
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-wilc3000_bt-v1-1-9609b784874e@bootlin.com>
References: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
In-Reply-To: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Marek Vasut <marex@denx.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjedtjeetgeduueefffevueeuheffudffleehhffgjeefkeeguefhvdejvdekjeeknecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgduledvrdduieekrddurdduleejngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhit
 ggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

WILC3000 is a combo chip providing 802.11b/g/n and Bluetooth 5. The wlan
part is exposed either through SDIO or SPI interface, and the bluetooth
part is exposed through uart. The notable peculiarity of this chip is
that the bluetooth part is not fully autonomous: its firmware is not
loaded through UART interface but through SDIO/SPI interface, so the
bluetooth description needs a reference to the wlan part to get access
to the corresponding bus.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 .../net/bluetooth/microchip,wilc3000-bt.yaml       | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/microchip,wilc3000-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/microchip,wilc3000-bt.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2a83ca3ad90b26fd619b574bc343bee9654a1e43
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/microchip,wilc3000-bt.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/microchip,wilc3000-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Bluetooth chips
+
+description:
+  This binding describes UART-attached Microchip bluetooth chips. These
+  chips are dual-radio chips supporting WiFi and Bluetooth. The bluetooth
+  side works with standard HCI commands over 4-wires UART (with flow
+  control)
+
+maintainers:
+  - Alexis Lothoré <alexis.lothore@bootlin.com>
+
+properties:
+  compatible:
+    enum:
+      - microchip,wilc3000-bt
+
+  wlan:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the wlan part of the combo chip
+
+required:
+  - compatible
+  - wlan
+
+additionalProperties: false
+
+examples:
+  - |
+    serial {
+        bluetooth {
+            compatible = "microchip,wilc3000-bt";
+            wlan = <&wifi>;
+        };
+    };

-- 
2.48.0


