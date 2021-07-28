Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9863D9710
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jul 2021 22:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhG1Uu5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jul 2021 16:50:57 -0400
Received: from relay.smtp-ext.broadcom.com ([192.19.166.231]:51528 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231585AbhG1Uuz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jul 2021 16:50:55 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 36F4C7FFB;
        Wed, 28 Jul 2021 13:50:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 36F4C7FFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1627505453;
        bh=pXW71pS+p3CCgT4cUmc+lQ1OU/pTWXyjI3bzzqGVrsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFPCzzWPwS7TtnrCN2oRg4Xnsh0OYUTP9l5aAw3Hy9Kgnk9wjoOYK8qxbmBn5pgqh
         xk4XHLU81OuQvfE43uQ0y++T7OataE7iu9NwVLZ02J/BCNUJn9LjOm8OtuThlLjn4W
         WC4XGWp5hHmZpChGJrJO5shyfo73hSIa54H3c9ZM=
Received: from bld-bun-01.bun.broadcom.net (bld-bun-01.bun.broadcom.net [10.176.128.83])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 708681874BD;
        Wed, 28 Jul 2021 13:50:52 -0700 (PDT)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 2/4] brcmfmac: increase core revision column aligning core list
Date:   Wed, 28 Jul 2021 22:50:32 +0200
Message-Id: <1627505434-9544-3-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1627505434-9544-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1627505434-9544-1-git-send-email-arend.vanspriel@broadcom.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some cores are getting a revision greater that 99 thus messing up
the column alignment in the list of cores. So adding a digit for
the core revision.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 85653a95a60c..da4fd40b5275 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -529,7 +529,7 @@ static int brcmf_chip_cores_check(struct brcmf_chip_priv *ci)
 	int idx = 1;
 
 	list_for_each_entry(core, &ci->cores, list) {
-		brcmf_dbg(INFO, " [%-2d] core 0x%x:%-2d base 0x%08x wrap 0x%08x\n",
+		brcmf_dbg(INFO, " [%-2d] core 0x%x:%-3d base 0x%08x wrap 0x%08x\n",
 			  idx++, core->pub.id, core->pub.rev, core->pub.base,
 			  core->wrapbase);
 
-- 
2.27.0

