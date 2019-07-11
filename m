Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B96534C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2019 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfGKIqm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 04:46:42 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:41260 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbfGKIql (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 04:46:41 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id DDAD930C058;
        Thu, 11 Jul 2019 01:46:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com DDAD930C058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1562834799;
        bh=+Ugjn9rHFThHArwPvo789g7pbURBvq73nsHs/yYvbSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojxcfnbQppb1ir3xBA7rMhWEq0Lda3Hh0KOGfn6wPa3dZvIDIZ5BarNmUf6DQHIub
         QupK/0UwKJnSYU4jQgWYII0Soq8R4giPxPlfQ5gohg2119tT5olqS3UiaMrmNk6n/r
         ItjS5ZjHmBJZ624r8M68mWhAIlJ10Pg1QlDnyjgc=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id DEC1060CB1;
        Thu, 11 Jul 2019 01:46:39 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 149E0B02D0B; Thu, 11 Jul 2019 10:46:35 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 2/3] brcmfmac: enable DFS_OFFLOAD extended feature if supported
Date:   Thu, 11 Jul 2019 10:45:31 +0200
Message-Id: <1562834732-31508-3-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562834732-31508-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1562834732-31508-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the firmware supports 802.11h and the device can operate in 5GHz
band we can enable DFS_OFFLOAD extended feature.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 5 +++++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c  | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h  | 4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5168d42..3f72dc1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6733,6 +6733,11 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, struct brcmf_if *ifp)
 		}
 	}
 
+	if (wiphy->bands[NL80211_BAND_5GHZ] &&
+	    brcmf_feat_is_enabled(ifp, BRCMF_FEAT_DOT11H))
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_DFS_OFFLOAD);
+
 	wiphy_read_of_freq_limits(wiphy);
 
 	return 0;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index 73aff4e..2c3526a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -39,6 +39,7 @@ struct brcmf_feat_fwcap {
 	{ BRCMF_FEAT_P2P, "p2p" },
 	{ BRCMF_FEAT_MONITOR, "monitor" },
 	{ BRCMF_FEAT_MONITOR_FMT_RADIOTAP, "rtap" },
+	{ BRCMF_FEAT_DOT11H, "802.11h" }
 };
 
 #ifdef DEBUG
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
index f127eb2..736a817 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
@@ -25,6 +25,7 @@
  * MONITOR: firmware can pass monitor packets to host.
  * MONITOR_FMT_RADIOTAP: firmware provides monitor packets with radiotap header
  * MONITOR_FMT_HW_RX_HDR: firmware provides monitor packets with hw/ucode header
+ * DOT11H: firmware supports 802.11h
  */
 #define BRCMF_FEAT_LIST \
 	BRCMF_FEAT_DEF(MBSS) \
@@ -43,7 +44,8 @@
 	BRCMF_FEAT_DEF(FWSUP) \
 	BRCMF_FEAT_DEF(MONITOR) \
 	BRCMF_FEAT_DEF(MONITOR_FMT_RADIOTAP) \
-	BRCMF_FEAT_DEF(MONITOR_FMT_HW_RX_HDR)
+	BRCMF_FEAT_DEF(MONITOR_FMT_HW_RX_HDR) \
+	BRCMF_FEAT_DEF(DOT11H)
 
 /*
  * Quirks:
-- 
1.9.1

