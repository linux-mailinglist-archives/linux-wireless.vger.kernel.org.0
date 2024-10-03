Return-Path: <linux-wireless+bounces-13472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6735998F04A
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6931F220AB
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 13:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DDB770F1;
	Thu,  3 Oct 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="gjAIvCmy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5B1E495;
	Thu,  3 Oct 2024 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961924; cv=none; b=qtVzpKnYRpjeuWVLaIhaRWDJI1w6F/MXWSnmzYFI8L+R340/n5tH3AZytDGm4DB0Wrfk4l8MCzNvHj+UYX5yFIMEK6eG1tF3xR7zpbNkPsBFPnugSl+dkx7hpsaoINWlL1MMN7ugCLIlmZFxfPRHnR3d/j91ewhBAxHMmUrfS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961924; c=relaxed/simple;
	bh=37Li2jcZeeq53+fzhPuLuodhRdQGGS07//C5RIKdjRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P955Zw/7m+XcZANzgcd2wSsTgtTnAB2GvV9kdoYs3NNRGU6786oeGdPGf4xQB2jx0CS2yVUE1tIJKgRUkAa1+Bx1wwIRI+TiyyAOAkHFK8s1Rz/4RBgAUA61G6+/2/iAr7RjxbvYnTBSCRbiY+d3jwCvD/iYTeZjsAVqnmi5FPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=gjAIvCmy; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 11E0388C78;
	Thu,  3 Oct 2024 15:25:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727961920;
	bh=UQLE2jGTSayd6gs8cpOiqXeOpHuG+5raSNDTLfhZL5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=gjAIvCmyM8Wn/Q9EwVxm22v4CqqTo1sz5Gsu77QD90JBfPHdvMMS8FqoPoo0lXVjU
	 a1ui2azw1u6X5b3dOkwbdNT2/VfSLPGDiDjkLzez4xuo+5sZu8tsvd+fjFFKyDdyZu
	 8Yt7vunRUBLLdh9aa3IV9xz19amaH/lkw9aiW6YpJjmRaUX648H6DUbYYFkwPwO5yV
	 1Kjl0Ybuso+QNaiRZeImwWV1/X4lEJGky7sV5oufrF9D6uTnw4S9lG0YvteXrsgvMI
	 bzsQ+X/0yFeS40tHqODTjEvmc/yOCuw/aicN/HF6hVvqm1CkgQepRSoxeQ1umzzQZX
	 40We6LM+Xx27w==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: wilc1000: Set MAC after operation mode
Date: Thu,  3 Oct 2024 15:24:17 +0200
Message-ID: <20241003132504.52233-1-marex@denx.de>
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

Fixes: 83d9b54ee5d4 ("wifi: wilc1000: read MAC address from fuse at probe")
Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org
---
V2: Add TB, Fixes, CC Stable
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


