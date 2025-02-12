Return-Path: <linux-wireless+bounces-18852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FD7A32A8F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 16:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D22167727
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88329253B51;
	Wed, 12 Feb 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TjZ/AkzY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17E2566D7;
	Wed, 12 Feb 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375277; cv=none; b=aAyTIJeLR0KZIcFGeGb7whkL6j9fjxy7NHgjpqo8e9m6AdiECO253puLK2Rrq1tytFkfQm1Ql6plzeoaQnp+cEPSVfJ04Nd+qoo1NytLXsfycZRfTTyZb8RisGXsvoqz1wod+eWcwhasCkA7kBi4fPEU9G7B+87+kH9ZWbAKakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375277; c=relaxed/simple;
	bh=xAmGyU91V+m4Q7kGIo3hv+45LYipGVyiZmeFoNFG190=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HOwLCNm1ik/E+3nHJQBXKEBRwej6M/bV6x2YhF5TIGPWtckJR1AJhOKPuXHuwhgqg1Xmc56Fmo8pXTvqwnXYLSiSyxiluToHE8wcluFaI5p2s8YctrLmP9RJgyFVF54Jv2fMIOBKdpv1I14Mjf7Q9HLV3Zu6jSInvXodfWOKn3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TjZ/AkzY; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D0FA440FC;
	Wed, 12 Feb 2025 15:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739375273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSlKEKgzm/q54egNWa8O2T+4J35Hi0UxWaRxNxaH0z0=;
	b=TjZ/AkzYBhFedMs08HnK2oPOp6dXjcONfnjOmvCeVY5yD1HgW2rZK1tK9BIt9Q7pqBJYXM
	jYJbWmd+ejh+BLMlLWDafz5mHwh/O7xNF6pK/P8aDakRyOBG62CoB7YzeQGv83sOTcjApk
	SMWRhwtEVnVGV+bymbbS/YDY266W7IAXQYfm7N52QcqA9xD/CMc/odRIGEqCmv/K5CGAFH
	UBwMwGzp9Tvpt4awsN2oxlifbSxp7cEwZ1yRsNL1e0wZOx1fLVvenTvahnFd5AsTHz0D7n
	602Uyye/ALCwG8XYAfhIBXoX04BI8r9In1S5/ai7cWsYZdzFuQri43BFeewxXQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 12 Feb 2025 16:46:25 +0100
Subject: [PATCH 06/12] wifi: wilc1000: remove timeout parameter from
 set_power_mgmt
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-wilc3000_bt-v1-6-9609b784874e@bootlin.com>
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

While the timeout parameter is part for the cfg80211 ops set_power_mgmt,
wilc currently does not uses it (it processes only the boolean value).

Remove the unused parameter from the driver-specific function.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 2 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      | 2 +-
 drivers/net/wireless/microchip/wilc1000/hif.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 393fff618f919c5a6d3f4a7d894b187399455fb8..ff8c1a40634cee9960777eb017f6b2905e6399a5 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1348,7 +1348,7 @@ static int set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
 	if (!priv->hif_drv)
 		return -EIO;
 
-	wilc_set_power_mgmt(vif, enabled, timeout);
+	wilc_set_power_mgmt(vif, enabled);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index bba53307b960d996032f56affead0cd0922902a4..3b14d560bc295844d873ed966592f031f6b50206 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1932,7 +1932,7 @@ int wilc_edit_station(struct wilc_vif *vif, const u8 *mac,
 	return result;
 }
 
-int wilc_set_power_mgmt(struct wilc_vif *vif, bool enabled, u32 timeout)
+int wilc_set_power_mgmt(struct wilc_vif *vif, bool enabled)
 {
 	struct wilc *wilc = vif->wilc;
 	struct wid wid;
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wireless/microchip/wilc1000/hif.h
index 96eeaf31d23777e0392699240479b341529bfd42..5ecf6ba293a598823d09de43b597f8d54d375a7c 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -192,7 +192,7 @@ int wilc_del_allstation(struct wilc_vif *vif, u8 mac_addr[][ETH_ALEN]);
 int wilc_del_station(struct wilc_vif *vif, const u8 *mac_addr);
 int wilc_edit_station(struct wilc_vif *vif, const u8 *mac,
 		      struct station_parameters *params);
-int wilc_set_power_mgmt(struct wilc_vif *vif, bool enabled, u32 timeout);
+int wilc_set_power_mgmt(struct wilc_vif *vif, bool enabled);
 int wilc_setup_multicast_filter(struct wilc_vif *vif, u32 enabled, u32 count,
 				u8 *mc_list);
 int wilc_remain_on_channel(struct wilc_vif *vif, u64 cookie, u16 chan,

-- 
2.48.0


