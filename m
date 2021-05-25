Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE85390289
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 15:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhEYNcY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 09:32:24 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:57674 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhEYNcY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 09:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1621949450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+usSC3YkdJ2wuce4/zm7jv3o4NfSTiNDKsYzW2Edm5M=;
        b=K1p6aZbpa29Z6vmjMizTRCkEp414eRbKlsfITYgunehLMVdvgOPxOztfDZW9SMriEtC7Zs
        zSebA6NRKAInf1T4dzJ+qJOl/FQqHrFRPjiAVD8PbQ19oQpmy6dzdizppP9TI+nBrC1ZB/
        t3uAU1ifIXGs5vruus1QmeiLBwQF7HM=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] ath11k: send beacon template after vdev_start/restart during csa
Date:   Tue, 25 May 2021 15:30:28 +0200
Message-Id: <20210525133028.2805615-1-sven@narfation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

Firmware has added assert if beacon template is received after
vdev_down. Firmware expects beacon template after vdev_start
and before vdev_up. This change is needed to support MBSSID EMA
cases in firmware.

Hence, Change the sequence in ath11k as expected from firmware.
This new change is not causing any issues with older
firmware.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1.r3-00011-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1.r4-00008-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
[sven@narfation.org: added tested-on/fixes information]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Patch from
https://source.codeaurora.org/quic/cc-qrdk/oss/system/feeds/wlan-open/tree/mac80211/patches/303-ath11k-send-beacon-template-after-vdev_start-restart.patch?h=NHSS.QSDK.11.4.0.5.r5

There are a lot more fixes which should have been submitted to upstream by
the actual developer

 drivers/net/wireless/ath/ath11k/mac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9d0ff150ec30..eb52332dbe3f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5379,11 +5379,6 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 		if (WARN_ON(!arvif->is_up))
 			continue;
 
-		ret = ath11k_mac_setup_bcn_tmpl(arvif);
-		if (ret)
-			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
-				    ret);
-
 		ret = ath11k_mac_vdev_restart(arvif, &vifs[i].new_ctx->def);
 		if (ret) {
 			ath11k_warn(ab, "failed to restart vdev %d: %d\n",
@@ -5391,6 +5386,11 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			continue;
 		}
 
+		ret = ath11k_mac_setup_bcn_tmpl(arvif);
+		if (ret)
+			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
+				    ret);
+
 		ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
 					 arvif->bssid);
 		if (ret) {
-- 
2.30.2

