Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5816534A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2019 10:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfGKIqj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 04:46:39 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:41224 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728028AbfGKIqj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 04:46:39 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 67A9030C04B;
        Thu, 11 Jul 2019 01:46:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 67A9030C04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1562834798;
        bh=VMOoCMRf3w8TlT+wpeyhL0UDeXsWKaU7XDiG0Te/6yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hsiZGvQqo9rc1lIWsFopFGgdXQ/S2HCi59EbvTP4UW2JSwPS+mIxiQDFSnZyTsAL1
         EgHbD1M4bZCkpUB0jc2YFk3SOSjG4OYX8lfQHMaCv7FAbVuHD6sXTe3vlOznt7zoog
         PD+0vH/CEBwDWgJOeF/NoVPcaX6hXqyIpFJ8LKNI=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 9C66660CB1;
        Thu, 11 Jul 2019 01:46:38 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 143BCB02A3D; Thu, 11 Jul 2019 10:46:35 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 3/3] brcmfmac: allow 160MHz in custom regulatory rules
Date:   Thu, 11 Jul 2019 10:45:32 +0200
Message-Id: <1562834732-31508-4-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562834732-31508-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1562834732-31508-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The driver has custom regulatory rules which had maximum bandwidth
for 5GHz channels set to 80MHz. As a consequence the driver can
not use 160MHz in AP mode even when the device supports it. So
relax the rules allowing 160MHz. After wiphy_register() the channel
flags are updated according what the device actually supports.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 3f72dc1..b692689 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -189,9 +189,9 @@ static bool check_vif_up(struct brcmf_cfg80211_vif *vif)
 		 */
 		REG_RULE(2484-10, 2484+10, 20, 6, 20, 0),
 		/* IEEE 802.11a, channel 36..64 */
-		REG_RULE(5150-10, 5350+10, 80, 6, 20, 0),
+		REG_RULE(5150-10, 5350+10, 160, 6, 20, 0),
 		/* IEEE 802.11a, channel 100..165 */
-		REG_RULE(5470-10, 5850+10, 80, 6, 20, 0), }
+		REG_RULE(5470-10, 5850+10, 160, 6, 20, 0), }
 };
 
 /* Note: brcmf_cipher_suites is an array of int defining which cipher suites
-- 
1.9.1

