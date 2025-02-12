Return-Path: <linux-wireless+bounces-18850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF5CA32A85
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 16:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D45162C51
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BCC2580D4;
	Wed, 12 Feb 2025 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OJGKYxq1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1408E212B06;
	Wed, 12 Feb 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375275; cv=none; b=CaI6IsAUqXKo/Uj0IE0I9XpnXvNkOFYuQwMGFZ+Zyiojb2KmjIrtE/dxbteWvODMJGCAS6IUv7JH0Ei8c96oSIpBn8jdYcMXhioqNDbxyClNajbbrV4Il1mSBu2SJtVRPEmF4rllNo3D6/3YkXbfo+ythgczaZFxz3ZL6d3mWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375275; c=relaxed/simple;
	bh=GOvQNyUVl9fP6G1phuIP+FuJTr0gdmOmVl0+2mbeB0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B/LBHxol6241R+rPF9jMwqb4nO4PimnMpIwh4/EA/sGAb4TcETY92V3wyZMLrECemwx5iR0BqZo9wkHxvf2iq0suRix7X63dR36E+iQU4ZWa/1QyrrSWUGy3Fs7lVJ8yNo/HSXja4NjdHs2seEesoAB9VTdWiOHISCvivy1Q8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OJGKYxq1; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 215B14318E;
	Wed, 12 Feb 2025 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739375271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0QDXdrnVYdl2WcxZmvLO4vqnkGNCkcX//xPR9QV5j4=;
	b=OJGKYxq1p8fQMxq/s+dbAehrnUH1vUoJgKdDfQzN/kLeINzgAdHGOH9scjrtLCWCJoCzdJ
	KPYnJ/+u856gAgcYxI0hMRNKgfH9FMQvubkV8fqnOqDJpzC/YBWyqE4iUFdUPQvHa2Lx8R
	XUJDmzm58mYI3QUxOvPIeJyalj2msDNUc+a24r+N2SCZIoedTj3FpHQ7QVQmtOc+mmHCsS
	C7XBTU2u2zpA3TMV+8nPxorGCQiVuhOvxEB8iHH9n5yZh/2NWgKusrHOtmGDRWRi3XHfJv
	9gH68xFvZvOfotnHyP5zIAbnHCcyh3FzytHAh8UuBbRR1+Pak28+uT98Eq41aw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 12 Feb 2025 16:46:23 +0100
Subject: [PATCH 04/12] wifi: wilc1000: allow to use acquire/release bus in
 other parts of driver
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-wilc3000_bt-v1-4-9609b784874e@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevgefhteffuefhheekkeelffffvdeugffgveejffdtvdffudehtedtieevteetnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrudeljegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

acquire_bus/release_bus is currently used only in wlan.c when needing to
access the main bus (SDIO or SPI). For wilc3000, the bluetooth part will
also need to perform some operations on the main bus (eg: bluetooth
firmware loading), so expose acquire/release_bus.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 5 +++--
 drivers/net/wireless/microchip/wilc1000/wlan.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index f2b13bd44273ebe2ee474eda047e82bf1287bd6e..a697caf73ac3ed06602c029c17773f50e3f8edb5 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -743,7 +743,7 @@ static int chip_wakeup(struct wilc *wilc)
 		return chip_wakeup_wilc3000(wilc);
 }
 
-static inline int acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
+int acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
 {
 	int ret = 0;
 
@@ -757,12 +757,13 @@ static inline int acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
 	return ret;
 }
 
-static inline int release_bus(struct wilc *wilc, enum bus_release release)
+int release_bus(struct wilc *wilc, enum bus_release release)
 {
 	int ret = 0;
 
 	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP && wilc->power_save_mode)
 		ret = chip_allow_sleep(wilc);
+
 	mutex_unlock(&wilc->hif_cs);
 
 	return ret;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index 65e79371014d9e60755cb0aa38e04d351e67bcfb..e45c2db0f5cd2de6844993dde15034ebbd93e73b 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -475,4 +475,7 @@ int wilc_wlan_init(struct net_device *dev);
 int wilc_get_chipid(struct wilc *wilc);
 int wilc_load_mac_from_nv(struct wilc *wilc);
 
+int acquire_bus(struct wilc *wilc, enum bus_acquire acquire);
+int release_bus(struct wilc *wilc, enum bus_release release);
+
 #endif

-- 
2.48.0


