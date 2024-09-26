Return-Path: <linux-wireless+bounces-13237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F349879C6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 21:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143D31C234EB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 19:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312317BEB8;
	Thu, 26 Sep 2024 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="b3m8r1BJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D8175B1
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380410; cv=none; b=h04KTids08gVeNmx5cI7kj9ZH/ibV8MnsFnB5xw5Ax9uHrhRaMNIcXP+70th7uu6QfEyHSNgiJW5e8qJIomuFvP/mB3MMQBswUP4o5AgtiekIosF34T9bGd5YLrkYvC19ZU334lfbK37Cd2Mxio5+NmfRden31oo8eaucEGkAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380410; c=relaxed/simple;
	bh=jnFhBBeU5B5DxOoCxl8etYCoykDCjz2bJOjJQubOixg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CqZtVoSGiCHmiSku0i4IjV+2sy9B6jXUIUA9oXlux878NGejQ+IQyWYFOT6MvFdjM3vqDawI1lXcLKeO7Kze8eHYkrE3gUGDd6lGlk9XKARTqmKur3+gvMhkrm3slcWbTWtlG2IXYvTqj0vHU0Q1hRqbnfmhkNWKjb4sItsF9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=b3m8r1BJ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1FAEF8857C;
	Thu, 26 Sep 2024 21:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727380407;
	bh=9K8NZm09JveWLOie5Qx4ybmqvqPrxlDebJ7sBB4fUz4=;
	h=From:To:Cc:Subject:Date:From;
	b=b3m8r1BJUPWcVefi2NbSjyK9v6FIpd4cWhoY8Y13P3h4JOjRN6c1ocWah5UprmWw/
	 4pn1TCkUFhYObtpV7RuYRfvbDJN5la0K2jlVy3nl9TxASNgxamUai2gKEshMJACxDg
	 2iPmRHxMNdPInEIshUqmm/xj6vY2ftxw4iiQ+QZUWWFib5GA3P9nauCDBhn3rcV/sS
	 UTQhMljYZds/FjOutkl7of/AGwQ3FVp51z1FmRHTvhMBxNSJ44WQ5dwRZgxafo9ZCb
	 oBG44ZNdn+eTCaBTmPUXxB45aA0QbFqtnBm9AsWvNWSDPR1UV80S7wy9h73J+Z7WCF
	 IJiNCgh4qVhVw==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH] wifi: wilc1000: Set MAC after operation mode
Date: Thu, 26 Sep 2024 21:52:40 +0200
Message-ID: <20240926195308.2823595-1-marex@denx.de>
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

It seems it is necessary to set WILC MAC address after operation mode,
otherwise the MAC address of the WILC MAC is reset back to what is in
nvmem. This causes a failure to associate with AP after the WILC MAC
address was overridden by userspace.

Test case:
"
ap$ cat << EOF > hostap.conf
interface=wlan0
ssid=ssid
hw_mode=g
channel=6
wpa=2
wpa_passphrase=pass
wpa_key_mgmt=WPA-PSK
EOF
ap$ hostapd -d hostap.conf
ap$ ifconfig wlan0 10.0.0.1
"

"
sta$ ifconfig wlan0 hw ether 00:11:22:33:44:55
sta$ wpa_supplicant -i wlan0 -c <(wpa_passphrase ssid pass)
sta$ ifconfig wlan0 10.0.0.2
sta$ ping 10.0.0.1 # fails without this patch
"

AP still indicates SA with original MAC address from nvmem without this patch:
"
nl80211: RX frame da=ff:ff:ff:ff:ff:ff sa=60:01:23:45:67:89 bssid=ff:ff:ff:ff:ff:ff ...
                                          ^^^^^^^^^^^^^^^^^
"

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 9ecf3fb29b558..8bc127c5a538c 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -608,6 +608,9 @@ static int wilc_mac_open(struct net_device *ndev)
 		return ret;
 	}
 
+	wilc_set_operation_mode(vif, wilc_get_vif_idx(vif), vif->iftype,
+				vif->idx);
+
 	netdev_dbg(ndev, "Mac address: %pM\n", ndev->dev_addr);
 	ret = wilc_set_mac_address(vif, ndev->dev_addr);
 	if (ret) {
@@ -618,9 +621,6 @@ static int wilc_mac_open(struct net_device *ndev)
 		return ret;
 	}
 
-	wilc_set_operation_mode(vif, wilc_get_vif_idx(vif), vif->iftype,
-				vif->idx);
-
 	mgmt_regs.interface_stypes = vif->mgmt_reg_stypes;
 	/* so we detect a change */
 	vif->mgmt_reg_stypes = 0;
-- 
2.45.2


