Return-Path: <linux-wireless+bounces-18851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5761A32A94
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 16:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0266188A2B8
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C57C25A633;
	Wed, 12 Feb 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h9aQZ1VU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D56253B57;
	Wed, 12 Feb 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375277; cv=none; b=BXAe8WSzziiPU1OHWOq21fwUZoSIYQ9iAc0gragZwSWp1tEbkRoK8AsIz12q+Z7MAjIplKOjrG67QG1TKKYuRVKRPd3S1/244q3WdkF5xq3gcrAwL25xmwf+lCeYrdgghorKibCB0oJ2C9XF+0FIKkwcUBrYJ6kPDLDKcyKZIcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375277; c=relaxed/simple;
	bh=dFWgR2KJi9rrlMT6rS5NX5ube7zTK3kKjqLNnm+fCrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ln+RLLaYUeASqFc82e0zvmrEazxAj/wAmCqLW6lHPkLwyO8JDg7FmVatzfBpf5dCw+wmAuWCx/urakAx0mYLBi/exdQgjzmWztrjDBJxlhXjKQWOEmDj3dzITAGsMLnMtWe6WH+TsgXt0oFfk9MB+2EhwS6fsHWHS0ARbzWPXMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h9aQZ1VU; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46A5F440EF;
	Wed, 12 Feb 2025 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739375272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfTrS1OjRQIwj0wKN7rCzduFEiSKH12F8dOUfUGzre0=;
	b=h9aQZ1VUnpQBH1K35/5VnOQoGp5HDbCa5PiNnGEKScTKrRSC/mrTSXD1Sc0mhlkShKVw4B
	eShP7wCQ5x+h0ZnLV0PWAgA15HTmnm+5EAz079vSfxISf/mzMhJB8YXmiB/ZMDdI6idK2s
	L4rvtv58Yl8YoerEDFEXys0c+9XKRZO7t0/eVkANAuH+z3g9Gqv+fJwhKOA3GvJTmFcXf9
	xfqkAiG0l568TtGVF9YhElfj+bkDOinuUcXIU2SgIh3xuSC8ddRypSytU/Bhd7TghJRZRe
	uL0k8qYKFRE6jPczp1LrgpgAoorULwcjvPsustaPJdXmfuIzmiJJDYjzmr01mA==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 12 Feb 2025 16:46:24 +0100
Subject: [PATCH 05/12] wifi: wilc1000: do not depend on power save flag to
 wake up chip
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-wilc3000_bt-v1-5-9609b784874e@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevgefhteffuefhheekkeelffffvdeugffgveejffdtvdffudehtedtieevteetnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrudeljegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

The wilc chips family has at least two mechanisms dedicated to power save:
- a firmware configuration message, currently wired to the
  set_power_mgmt_ops of the cfg80211_ops structure (and so, configured
  through iw)
- dedicated raw registers which allow to wake up the chip each time we
  need to communicate with it and to allow it again to sleep once done:
  those registers are currently manipulated almost any time we are about
  to use the SDIO/SPI bus to drive the chip.

Those mechanisms are currently coupled together, and so the second
mechanism is driven only if the first one is enabled, but it is wrong:
even without the power save feature being configured in the wlan
firmware, there are cases where the wake up and clock registers need to
be written correctly, otherwise the chip stays unresponsive. The
downstream driver seems to acknowledge this issue, since the flag
matching the first feature has been completely removed.

Decouple those two features by removing the condition on the powersave
flag in acquire_bus/release_bus to make sure that the wakeup/allow_sleep
registers are actually written when the passed enums
(WILC_BUS_ACQUIRE_AND_WAKEUP, WILC_BUS_RELEASE_ALLOW_SLEEP) explicitly
require those writes.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index a697caf73ac3ed06602c029c17773f50e3f8edb5..1031f8153c76ca5761c1e91d03ba357a5c915774 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -748,7 +748,7 @@ int acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
 	int ret = 0;
 
 	mutex_lock(&wilc->hif_cs);
-	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP && wilc->power_save_mode) {
+	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP) {
 		ret = chip_wakeup(wilc);
 		if (ret)
 			mutex_unlock(&wilc->hif_cs);
@@ -761,7 +761,7 @@ int release_bus(struct wilc *wilc, enum bus_release release)
 {
 	int ret = 0;
 
-	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP && wilc->power_save_mode)
+	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP)
 		ret = chip_allow_sleep(wilc);
 
 	mutex_unlock(&wilc->hif_cs);

-- 
2.48.0


