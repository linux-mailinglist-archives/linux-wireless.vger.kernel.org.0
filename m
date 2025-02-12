Return-Path: <linux-wireless+bounces-18857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301BA32AAF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDCD1688EC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00E2261390;
	Wed, 12 Feb 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M/Zjyda5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96326137A;
	Wed, 12 Feb 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375283; cv=none; b=UWObZH77aAmlyPf1il85dGfPmuPfCAc414kD9fQvEFuY+i5+sXyJYQJXJpRfPWqreQr8ubPGSowxxmoH7ajWnvnQv9EhlmA3JgZcUkQjtAFlN1iA4esfF4emXzPqfIBajvAUV+AxtQHTmyTALyaDvUdyyRYRfpKZEUE6Td6sKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375283; c=relaxed/simple;
	bh=7Nuvq0/XaKtH4YYZYU9GOiSo9SqvZGltin6mD5/9gJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PBGRRb8U9ZhWSxZT2RZUergO/jH4OF9JnOiahA3PtiqfeRm4tFflnYspijAtRmamtYHYIdkHZb8534TfhR/FVUhmLUhtZJ54B5I9/rrLOPP9OmGp0liaU+yLwfWb/GCwXcaqOf8I0vyE/6Zp9KdZWenlZnKePd9kBtEtjGPshYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M/Zjyda5; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C692440FC;
	Wed, 12 Feb 2025 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739375279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9mJBeQJc9XrbJbz/UPw2MShuHNEjyFKhfrVFDRUvK8=;
	b=M/Zjyda56Eh4V0dsM4qeR+/eslwZfJQPAYgKb1WzvTTfRW0i8U2TNFAM697MotdutEeiXS
	3xlhRpa+zc4gqJOl3N+yWbCuPQqt0mNQhCmyS4XZe5folQvFmsDQNBoD6EULajikDVFBsP
	HrOMnHdt/+LXGxmMKEWfW3Y1weQVEV/PiIXJiIFfSOdJp2BKbLcvpf8tTaxgoHuFPyiRMc
	wc+39CjNGKTgTNcbM6p5h510bNColfVX6zgHbV9YhjxA6u4Rt0lNl2f2eD+k9vr+yhe2sb
	bzTvNkDwqqOAYIGi3uAeV5NKiabl/obLsnlyLNiWkpE5+6SRQnCa8G/PiEtNiA==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 12 Feb 2025 16:46:30 +0100
Subject: [PATCH 11/12] ARM: dts: at91-sama5d27_wlsom1: update bluetooth
 chip description
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-wilc3000_bt-v1-11-9609b784874e@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevgefhteffuefhheekkeelffffvdeugffgveejffdtvdffudehtedtieevteetnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgepkeenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrudeljegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

The SAMA5D27 WLSOM1 plaftorm embeds a wilc3000 chip exposing 802.11b/g/n
and bluetooth 5. The current description for this chip does not expose
the bluetooth part: it only configures the relevant flexcom peripheral
to set it as uart, and relies on user to trigger the corresponding hci
device creation in kernel through hci_attach. Now that a bluetooth
driver is available and handles the device creation, replace the bare
uart description with a proper bluetooth node.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi   |  8 ++++++++
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 10 ----------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
index ef11606a82b31c2f745141cdac1318805f473273..10d48a9ef92c9621a8885feebda6119d3f61af75 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -50,10 +50,18 @@ wifi_pwrseq: wifi_pwrseq {
 
 &flx1 {
 	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "okay";
 
 	uart6: serial@200 {
 		pinctrl-0 = <&pinctrl_flx1_default>;
 		pinctrl-names = "default";
+		atmel,use-dma-rx;
+		atmel,use-dma-tx;
+		status = "okay";
+		bluetooth: bluetooth@0 {
+			compatible = "microchip,wilc3000-bt";
+			wlan = <&wilc>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
index 15239834d886edbf9e732ac461a92ac9eea42ae5..8b89ee0b47ccb6e60b67f3e4db6caa827ce9c0bc 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
@@ -85,16 +85,6 @@ uart5: serial@200 {
 	};
 };
 
-&flx1 {
-	status = "okay";
-
-	uart6: serial@200 {
-		atmel,use-dma-rx;
-		atmel,use-dma-tx;
-		status = "okay";
-	};
-};
-
 &macb0 {
 	status = "okay";
 };

-- 
2.48.0


