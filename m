Return-Path: <linux-wireless+bounces-15691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC89C9D8AE0
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 18:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F547B22C45
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5E818C332;
	Mon, 25 Nov 2024 16:40:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336712500CB
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732552840; cv=none; b=IbEfJ9hpAaRG3GasT4tTUypmxLVqMVPlCb+DHszunZtq7i5rUl6mJX4K0oC7fP8UGDonY7vPHbzqOiovSFIyZJ75RO82a5pRw31PuaCGTp6kLYIsS5aFyWU+HM06lncDKZgt8RYxu+0aASpCuZ7HEIlca6lysI60DI1o10PoH/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732552840; c=relaxed/simple;
	bh=fS4CfjyA6T6MHOe1KCu2112vGm7y6uVKbi+dlw4qzs4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qIaDfi3oQcLZv4zbxprhLLErORUMPXzKcK8XOQqU2nJdbIShEID0MtXsf7IOCGv5DKo7s5y4NDN4zWU1OBRCMYB5urELR590O61t/Ul+kdqFvI2OZm5b4B4rORbUHlU3TEtzxx9wsJ4KiBvKRaW8G589MzsnGBX0u51dw+nkuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from localhost (p200300c597034590000000000000032b.dip0.t-ipconnect.de [IPv6:2003:c5:9703:4590::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 08816FA132;
	Mon, 25 Nov 2024 17:40:36 +0100 (CET)
From: Issam Hamdi <ih@simonwunderlich.de>
To: lkp@intel.com,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Cc: sw@simonwunderlich.de,
	Issam Hamdi <ih@simonwunderlich.de>
Subject: [RFC] wifi: intel: incorrect RSSI values on beacons from APs using legacy rates
Date: Mon, 25 Nov 2024 17:40:34 +0100
Message-Id: <20241125164034.2712936-1-ih@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We identified an issue where the RSSI values for beacons from
legacy rates AP are incorrect, consistently showing -128.

This issue was identified on the Intel AX210 WiFi chip with
firmware version "89.202a2f7b.0 ty-a0-gf-a0-89.ucode op_mode iwlmvm"

To reproduce this issue :
    - Setup an AP with legacy rates on the frequency 2422Mhz
    - And on the device with Intel AX210 chip run:
        iw phy0 interface add mon0 type monitor
        ip link set mon0 up
        iw dev mon0 set freq 2422
        tcpdump -i mon0 -v

After debugging, we discovered that the RSSI values become
correct when a printk() statement is added to the RX path
in the iwlwifi driver, as shown the patch below.

Alternatively, adding udelay() instead of printk() also corrects
the incorrect RSSI values; however, this approach leads to
firmware warnings and errors:

````
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1543,7 +1543,7 @@ restart:
         }

         IWL_DEBUG_RX(trans, "Q %d: HW = %d, SW = %d\n", rxq->id, r, i);
-
+        udelay(500);
         rxb = iwl_pcie_get_rxb(trans, rxq, i, &join);
         if (!rxb)
             goto out;
````

Additionally, we found that deleting all existing interfaces on
the PHY and then creating a monitor interface resolves this issue:
    iw dev wlan0 interface del   # In case we have wlan0 as the existing interface.
    iw phy0 interface add mon0 type monitor
    ip link set mon0 up
    iw dev mon0 set freq 2422

However, in this case, it will not be possible to execute the scan
command with the monitor interface to prompt the firmware to
trigger the country code.

Has anyone encountered this issue before or have any insights
into the potential root cause ?

Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index afb88eab8174..b0ce71e6260b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1544,6 +1544,8 @@ static int iwl_pcie_rx_handle(struct iwl_trans *trans, int queue, int budget)
 
 		IWL_DEBUG_RX(trans, "Q %d: HW = %d, SW = %d\n", rxq->id, r, i);
 
+		printk(KERN_DEBUG "Got new packet\n");
+
 		rxb = iwl_pcie_get_rxb(trans, rxq, i, &join);
 		if (!rxb)
 			goto out;

base-commit: 2b94751626a6d49bbe42a19cc1503bd391016bd5
-- 
2.39.2


