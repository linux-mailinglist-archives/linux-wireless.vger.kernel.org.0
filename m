Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B381A60D1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2020 00:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgDLWG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Apr 2020 18:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgDLWG5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Apr 2020 18:06:57 -0400
X-Greylist: delayed 8400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Apr 2020 15:06:57 PDT
Received: from 16.mo5.mail-out.ovh.net (16.mo5.mail-out.ovh.net [87.98.174.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF9AC0A88B5
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2020 15:06:57 -0700 (PDT)
Received: from player778.ha.ovh.net (unknown [10.108.35.12])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 4992A2788F2
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2020 19:19:04 +0200 (CEST)
Received: from nilsand.re (host86-180-230-78.range86-180.btcentralplus.com [86.180.230.78])
        (Authenticated sender: nils@nilsand.re)
        by player778.ha.ovh.net (Postfix) with ESMTPSA id 8461C115C2297;
        Sun, 12 Apr 2020 17:19:01 +0000 (UTC)
Date:   Sun, 12 Apr 2020 18:19:00 +0100
From:   Nils =?utf-8?Q?ANDR=C3=89-CHANG?= <nils@nilsand.re>
To:     trivial@kernel.org
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org
Subject: [PATCH] Formatting: remove leading space
Message-ID: <20200412171900.xzedxhzd56gox5kf@nixos>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5586433862969558194
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrvdejgdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkgggtugfgsehtkeertddttddunecuhfhrohhmpefpihhlshcutefpfffttmdqvefjtefpifcuoehnihhlshesnhhilhhsrghnugdrrhgvqeenucfkpheptddrtddrtddrtddpkeeirddukedtrddvfedtrdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepnhhilhhssehnihhlshgrnhgurdhrvgdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Nils ANDRÉ-CHANG <nils@nilsand.re>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index b684a5b6d904..22a17ae09e94 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -961,7 +961,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43340),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43341),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43362),
- 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43364),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43364),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4335_4339),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4339),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43430),
-- 
2.25.0

