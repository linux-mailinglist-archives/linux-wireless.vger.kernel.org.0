Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F853F0DA2
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 23:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhHRVpm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 17:45:42 -0400
Received: from phobos.denx.de ([85.214.62.61]:44286 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234045AbhHRVpl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 17:45:41 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:14c:485:504a:609d:5443:34fc:77bc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 101F6804E7;
        Wed, 18 Aug 2021 23:45:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1629323104;
        bh=NWf6JmEEvSLlYTGA0z2y6P2/u/8zsC+hN4OppuKmJws=;
        h=From:To:Cc:Subject:Date:From;
        b=g9DrdKzLPX2kUCBeXLVWp1Awj6Ryu9tl4IGW4B8whjo0syjPVskhO9IVRlcaWPvFm
         M2F5Cin+EYacL8PV2RNC4C1CQKK1VOKpkBeYQ+IKekju9SNatoEzJcrwJPElu6lZv1
         iQtOzbmlpt8sCfAylHt0lnXRayXyNLwYtcZfUt/JL7FAmJulWGq03ThJht7h260lCn
         TCfaH6VQ+eFksvGyrnSlzRLDuN7GHHYy4z0g0UQlVNzTph9MmvW8TkRDp3uqNUcX9J
         egTvS06H8LNi6UgMcJyWO2hN+UsEsmlocce/boTQjOMp3GSCXkv5Ug11YypNwx8PD6
         Z5f5n+4Iw/yPw==
From:   Fabio Estevam <festevam@denx.de>
To:     kvalo@codeaurora.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        hch@lst.de, erik.stromdahl@gmail.com, peter.oh@eero.com,
        aspriel@gmail.com, marex@denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] ath10k: Do not call dma_alloc_coherent() for SDIO and USB
Date:   Wed, 18 Aug 2021 18:44:51 -0300
Message-Id: <20210818214451.1969739-1-festevam@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When running the "hostapd" application on a i.MX7-based board with
an ath10k device connected via SDIO, the following warning is seen:

------------[ cut here ]------------
 WARNING: CPU: 0 PID: 489 at kernel/dma/mapping.c:427 dma_alloc_attrs+0xd0/0x114
 Modules linked in: ath10k_sdio ath10k_core ath
 CPU: 0 PID: 489 Comm: hostapd Not tainted 5.10.48-stable-standard #1
 Hardware name: Freescale i.MX7 Dual (Device Tree)
 [<c0111378>] (unwind_backtrace) from [<c010bc04>] (show_stack+0x10/0x14)
 [<c010bc04>] (show_stack) from [<c0e26094>] (dump_stack+0xdc/0x104)
 [<c0e26094>] (dump_stack) from [<c0125574>] (__warn+0xd8/0x114)
 [<c0125574>] (__warn) from [<c0e20ecc>] (warn_slowpath_fmt+0x60/0xbc)
 [<c0e20ecc>] (warn_slowpath_fmt) from [<c01b9eac>] (dma_alloc_attrs+0xd0/0x114)
 [<c01b9eac>] (dma_alloc_attrs) from [<bf01373c>] (ath10k_add_interface+0x2f0/0x1094 [ath10k_core])
 [<bf01373c>] (ath10k_add_interface [ath10k_core]) from [<c0d94470>] (drv_add_interface+0x88/0x2fc)
 
As explained by Christoph Hellwig:

"Looking at the ath10k code ar->dev is set by ath10k_core_create, which
has multiple callers.

For ath10k_pci_probe it is a pci_dev, which should always have a
dma_mask.

For ath10k_ahb_probe is a device tree probed platform_device,
which should have a dma mask.

For ath10k_sdio_probe it is a sdio_func, which from my understanding is
a virtual device can't do DMA itself.

For ath10k_snoc_probe it is a platform device with an explicit
dma_set_mask_and_coherent and above so the dma_mask is set.

For ath10k_usb_probe it is an usb device which can't do USB."

Fix the problem by not calling dma_alloc_coherent() when the device
is not DMA capable, such as SDIO and USB.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Simplify the check by comparing against ATH10K_DEV_TYPE_HL

 drivers/net/wireless/ath/ath10k/mac.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index c272b290fa73..e85c3f107d2e 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5576,15 +5576,17 @@ static int ath10k_add_interface(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_ADHOC ||
 	    vif->type == NL80211_IFTYPE_MESH_POINT ||
 	    vif->type == NL80211_IFTYPE_AP) {
-		arvif->beacon_buf = dma_alloc_coherent(ar->dev,
-						       IEEE80211_MAX_FRAME_LEN,
-						       &arvif->beacon_paddr,
-						       GFP_ATOMIC);
-		if (!arvif->beacon_buf) {
-			ret = -ENOMEM;
-			ath10k_warn(ar, "failed to allocate beacon buffer: %d\n",
-				    ret);
-			goto err;
+		if (ar->bus_param.dev_type != ATH10K_DEV_TYPE_HL) {
+			arvif->beacon_buf = dma_alloc_coherent(ar->dev,
+							       IEEE80211_MAX_FRAME_LEN,
+							       &arvif->beacon_paddr,
+							       GFP_ATOMIC);
+			if (!arvif->beacon_buf) {
+				ret = -ENOMEM;
+				ath10k_warn(ar, "failed to allocate beacon buffer: %d\n",
+					    ret);
+				goto err;
+			}
 		}
 	}
 	if (test_bit(ATH10K_FLAG_HW_CRYPTO_DISABLED, &ar->dev_flags))
-- 
2.25.1

