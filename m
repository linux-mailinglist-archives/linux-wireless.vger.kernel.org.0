Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF73B15F2DF
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 19:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgBNPvT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 10:51:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730729AbgBNPvS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 10:51:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 890CB2168B;
        Fri, 14 Feb 2020 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695477;
        bh=a/JbiaU6A10GtmsEI/rx+V/8XXumfKNN7zGs8yipPCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wNO1mdywvv4ZtQ8+g4yT4e/9eZJk1dXv6qgUUYDrBu/me1neYILUI+FRXtwdKj7Q4
         ALZbOSI78oV/ni+oRxPNyT9J+HJzlZr/T1RMcH2BoFbXJxcKZsL54vIE22n9+37bIu
         gHS1YDHJi5WL5JVzAuIK86VjHzTOwkhMzkTzmP9s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 110/542] brcmfmac: sdio: Fix OOB interrupt initialization on brcm43362
Date:   Fri, 14 Feb 2020 10:41:42 -0500
Message-Id: <20200214154854.6746-110-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

[ Upstream commit 8c8e60fb86a90a30721bbd797f58f96b3980dcc1 ]

Commit 262f2b53f679 ("brcmfmac: call brcmf_attach() just before calling
brcmf_bus_started()") changed the initialization order of the brcmfmac
SDIO driver. Unfortunately since brcmf_sdiod_intr_register() is now
called before the sdiodev->bus_if initialization, it reads the wrong
chip ID and fails to initialize the GPIO on brcm43362. Thus the chip
cannot send interrupts and fails to probe:

[   12.517023] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
[   12.531214] ieee80211 phy0: brcmf_bus_started: failed: -110
[   12.536976] ieee80211 phy0: brcmf_attach: dongle is not responding: err=-110
[   12.566467] brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed

Initialize the bus interface earlier to ensure that
brcmf_sdiod_intr_register() properly sets up the OOB interrupt.

BugLink: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=908438
Fixes: 262f2b53f679 ("brcmfmac: call brcmf_attach() just before calling brcmf_bus_started()")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/sdio.c  | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 1dea0178832ea..a935993a3c514 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4226,6 +4226,12 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 	}
 
 	if (err == 0) {
+		/* Assign bus interface call back */
+		sdiod->bus_if->dev = sdiod->dev;
+		sdiod->bus_if->ops = &brcmf_sdio_bus_ops;
+		sdiod->bus_if->chip = bus->ci->chip;
+		sdiod->bus_if->chiprev = bus->ci->chiprev;
+
 		/* Allow full data communication using DPC from now on. */
 		brcmf_sdiod_change_state(bus->sdiodev, BRCMF_SDIOD_DATA);
 
@@ -4242,12 +4248,6 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 
 	sdio_release_host(sdiod->func1);
 
-	/* Assign bus interface call back */
-	sdiod->bus_if->dev = sdiod->dev;
-	sdiod->bus_if->ops = &brcmf_sdio_bus_ops;
-	sdiod->bus_if->chip = bus->ci->chip;
-	sdiod->bus_if->chiprev = bus->ci->chiprev;
-
 	err = brcmf_alloc(sdiod->dev, sdiod->settings);
 	if (err) {
 		brcmf_err("brcmf_alloc failed\n");
-- 
2.20.1

