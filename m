Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3CA437435
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 11:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhJVJFC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 05:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232448AbhJVJFA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 05:05:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1A2760FE7;
        Fri, 22 Oct 2021 09:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634893362;
        bh=29McBfiaOd89lZ7+URM05g/eg0SDCdoMuc0nkDNtj5w=;
        h=From:To:Cc:Subject:Date:From;
        b=u/kq4QsR7XGuYfV/CgfhEP9kGkfsaaaU1uwpU4/VU0c/BUHeYG36+ONt/xDcaTBdB
         tl7BZv+r5NlN3ggTfgAS6UUTdBs6TOQ0FZi0+H+dNHHrjf0qsLwht63aQEqD4mmKvD
         sY27QU+LF7BKApyDcDneh1HSWNip99B7pCOT+Kb6B8jodsLWxSNv8PTD9RdW6UyH84
         R/CwbDgy9NrVR7jbwdO7iLEFzPZjxH4nLU4W1N9yB75TVHt1YZfHGx/xzNs4WD+XUh
         TrkU15FcZRtk7zPJBesfwfH/qqIeSgwUNpi+LOiA3SQ1uFUC1H5LTT6+kQHdXkKWnU
         n7Hum8I8WHKzg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        rdunlap@infradead.org, sean.wang@mediatek.com, kvalo@codeaurora.org
Subject: [PATCH] mt76: mt7921: fix mt7921s Kconfig
Date:   Fri, 22 Oct 2021 11:02:31 +0200
Message-Id: <1ce6cb04ba1ab5aabd2b06b45fd8266537ef5359.1634893214.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add missing MMC dependency in mt7921s Kconfig

Fixes: 48fab5bbef409 ("mt76: mt7921: introduce mt7921s support")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
index ce3a06227901..71154fc2a87c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
@@ -19,6 +19,7 @@ config MT7921S
 	select MT76_SDIO
 	select MT7921_COMMON
 	depends on MAC80211
+	depends on MMC
 	help
 	  This adds support for MT7921S 802.11ax 2x2:2SS wireless devices.
 
-- 
2.31.1

