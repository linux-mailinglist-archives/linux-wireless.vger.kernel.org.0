Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CF13D970F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jul 2021 22:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhG1Uu4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jul 2021 16:50:56 -0400
Received: from relay.smtp-ext.broadcom.com ([192.19.11.229]:55038 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231576AbhG1Uuz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jul 2021 16:50:55 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 5F3BB2E231;
        Wed, 28 Jul 2021 13:50:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 5F3BB2E231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1627505452;
        bh=as60YL7L/yzZs6Fj3OBVPd5Fc1Ox3jxy11CnUEiVlu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcnrF34cGIGriqJgrQhNngdUdwTO6/FecYK8N8PCBh3RIipzXMF4brO1TYmtxvY2u
         mKzmP0CffTFNESXEV74FGp5UBBmwaLrse9WENdETd1m9pi40K3iMEhwdeUFKu2uoWJ
         PMg/TWSMW9/wupbjkURRjS48Ru6fFxXtzHcNq0ZM=
Received: from bld-bun-01.bun.broadcom.net (bld-bun-01.bun.broadcom.net [10.176.128.83])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 61B331874BF;
        Wed, 28 Jul 2021 13:50:51 -0700 (PDT)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 1/4] brcmfmac: use different error value for invalid ram base address
Date:   Wed, 28 Jul 2021 22:50:31 +0200
Message-Id: <1627505434-9544-2-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1627505434-9544-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1627505434-9544-1-git-send-email-arend.vanspriel@broadcom.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The function brcmf_chip_tcm_rambase() returns 0 as invalid ram base
address. However, upcoming chips have ram base address starting at
zero so we have to find a more appropriate invalid value to return.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 45037decba40..85653a95a60c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -139,6 +139,8 @@ struct sbconfig {
 	u32 sbidhigh;	/* identification */
 };
 
+#define INVALID_RAMBASE			((u32)(~0))
+
 /* bankidx and bankinfo reg defines corerev >= 8 */
 #define SOCRAM_BANKINFO_RETNTRAM_MASK	0x00010000
 #define SOCRAM_BANKINFO_SZMASK		0x0000007f
@@ -731,7 +733,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
 		brcmf_err("unknown chip: %s\n", ci->pub.name);
 		break;
 	}
-	return 0;
+	return INVALID_RAMBASE;
 }
 
 int brcmf_chip_get_raminfo(struct brcmf_chip *pub)
@@ -746,7 +748,7 @@ int brcmf_chip_get_raminfo(struct brcmf_chip *pub)
 		mem_core = container_of(mem, struct brcmf_core_priv, pub);
 		ci->pub.ramsize = brcmf_chip_tcm_ramsize(mem_core);
 		ci->pub.rambase = brcmf_chip_tcm_rambase(ci);
-		if (!ci->pub.rambase) {
+		if (ci->pub.rambase == INVALID_RAMBASE) {
 			brcmf_err("RAM base not provided with ARM CR4 core\n");
 			return -EINVAL;
 		}
@@ -757,7 +759,7 @@ int brcmf_chip_get_raminfo(struct brcmf_chip *pub)
 						pub);
 			ci->pub.ramsize = brcmf_chip_sysmem_ramsize(mem_core);
 			ci->pub.rambase = brcmf_chip_tcm_rambase(ci);
-			if (!ci->pub.rambase) {
+			if (ci->pub.rambase == INVALID_RAMBASE) {
 				brcmf_err("RAM base not provided with ARM CA7 core\n");
 				return -EINVAL;
 			}
-- 
2.27.0

