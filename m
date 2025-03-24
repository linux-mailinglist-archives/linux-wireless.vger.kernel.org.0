Return-Path: <linux-wireless+bounces-20724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044EDA6D437
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 07:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F2F16BAA5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 06:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97AD18DB3D;
	Mon, 24 Mar 2025 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1VApnjZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C061D1B4F0E;
	Mon, 24 Mar 2025 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797502; cv=none; b=W57Xo+veWI8ReWslqAnCpVsphY3lrk1kKL7lvbNOphjQvWmwLPGuXqZ13dpKZUDncvXr04EFswWeAbg2FPec4XlmAGMIo3vTt/vyg2jjY0qtwxvLdarsgHaxrmENasqCgYO8jSpj3KtqU61kprt8RDKBSxbfONXNfywDqk6IxTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797502; c=relaxed/simple;
	bh=9XXXo3EWZtEobiajEK/dAZklZgfyP4VnNuDdDAvYcz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P9HSaVhwrXHbtBQ2LKQDTHv6MVOBEbgoieT473XjnUAZiGBIC1uLkDalUYY+gAZwFaHYtpDcdMKOOz0CBYbD9ERaAUgsH5OrAVtOIyTt3pxK7zxeiL8aC253uxLNLkqC7nXayeUplNm7kOIJMavTcn1OJIbAzsEoej0Mh/sMIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1VApnjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33183C4CEEA;
	Mon, 24 Mar 2025 06:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742797502;
	bh=9XXXo3EWZtEobiajEK/dAZklZgfyP4VnNuDdDAvYcz4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=o1VApnjZqBgmj6Mn6l0B+/7J8UV/5HCarFDwFRGPWpNB2lMe4LWw8HdZ/up7oF1Ii
	 xFwYrE97kSNtVwi1a1t51GoX7q/xejRw4/j9yTmUNMhbQlkSXyxYwygNv4bgsiM4Hs
	 hq6efF+UQ40WBYdj1OgBGtUMn77ee5ozDYGN6h8JWDx7I7pViVf37tbZ/sRWrilJ/h
	 MpDDhh7Tyi5dWbQtWzXWhmtSOqLbt5Gc9ta1G0ELHIDlBhRSucmcXmbdFFOnuMpnwr
	 bpRolNp7kGQcVvPULcoZrvgZC1HKuYtIKtohUdsgASlV5fE8Bd5dHMuBDmwJ+SX4RK
	 qjgunBCTF/mHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A65FC36008;
	Mon, 24 Mar 2025 06:25:02 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 24 Mar 2025 10:24:59 +0400
Subject: [PATCH] wifi: ath11k: support fetching mac address from nvmem
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-ath11k-nvmem-v1-1-d82bdf72820e@outlook.com>
X-B4-Tracking: v=1; b=H4sIALv64GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMT3cSSDEPDbN28stzUXF3LJJM0U5M0ExNDCwsloJaCotS0zAqwcdG
 xtbUAm2N0AF4AAAA=
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742797500; l=1623;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=KFf/U6jpX3DLdf5cfXG9vG8Hbqcu1hFbIGhlckUUI7s=;
 b=PoKhNSfsaNEQZQFXjHirGqsZeV20EcazdhX8I5TzQPa2R5lvPNK6z6IzkvT152fkvWA0wqYRc
 pYhUAbz+GmRA9jGIGq7rRxXYScv+jjqoQr0WP0xU9nY4HQw+aRbHwa9
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Many embedded devices with ath11k wifi chips store their mac address in
nvmem partitions. Currently, the ath11k driver supports getting the
mac address from the 'mac-address', 'local-mac-address', and 'address'
device tree properties only. As such, add support for obtaining the mac
address from nvmem if defined in a 'mac-address' cell by replacing the
call to device_get_mac_address by of_get_mac_address which does exactly
the same as the former but tries to get it from nvmem if it is not set
by above mentioned DT properties,

Tested-on: IPQ5018, QCN6122, and QCN9074

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 97816916abac..49af6b9fc867 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9,6 +9,7 @@
 #include <linux/etherdevice.h>
 #include <linux/bitfield.h>
 #include <linux/inetdevice.h>
+#include <linux/of_net.h>
 #include <net/if_inet6.h>
 #include <net/ipv6.h>
 
@@ -10379,7 +10380,7 @@ int ath11k_mac_register(struct ath11k_base *ab)
 	if (ret)
 		return ret;
 
-	device_get_mac_address(ab->dev, mac_addr);
+	of_get_mac_address(ab->dev->of_node, mac_addr);
 
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];

---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250324-ath11k-nvmem-9b4f54f44188

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



