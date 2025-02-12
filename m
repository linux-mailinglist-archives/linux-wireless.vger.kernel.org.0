Return-Path: <linux-wireless+bounces-18863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA36A32F3C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 20:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6C93A75C8
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D53261387;
	Wed, 12 Feb 2025 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="JgLa8KsE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C551260A4E;
	Wed, 12 Feb 2025 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387405; cv=none; b=oIks1yYWcUOYLTVJpxAtgr29u6ISMU7TR77NxCk1+uUdYfn1UAYoWk0ttKw0RngOgLhD553eGCaRolu1DEMW08S/oIme4b79UYBo2AKGQh3ddxnNbbR2MXGu3NBEjN2Z8bjvZ2puOJ+nkDmoq4uXOufgEVJS5SWx3U3JrxbjDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387405; c=relaxed/simple;
	bh=3YhrClgMV1aKi0S4z5olXFmU2m1U1F09UvqrHJPICx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FswYNfS33tenJuIWYHgv4E12hll3fktjHqeIB7GUBf/L/RxAURngDNAwVlowWeOfXOK41meySj24ym7yancoXoLrRpMk0twQUdpsJXeJyZAL+E8OmAf1Kt4hafsbhNjSMOZa7sGMoLeiIx8jFc72r/cXrqSbHKq5yihuDLAkopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-proske.de; spf=pass smtp.mailfrom=matthias-proske.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=JgLa8KsE; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-proske.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthias-proske.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id 93B07601DA;
	Wed, 12 Feb 2025 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1739386880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q+TDqPY/j9LuymxqoSxnd/KR0pzmWLDlKhqHng4rETU=;
	b=JgLa8KsEvxf83OU/YJW3Jxvkg79AMmbPexqGyMa1YFE3lWzQ9K24njhnA1T2zFciGesa60
	cq295GydBWSzqjYKdViddtlnAJj5hun6/0rZUe3lZekuVJSPtJVwUdeGdKepT5u0L2GTZP
	260a6iSPy9Sh9uTweqcOIfsFZmXhgDQ=
Received: from localhost.localdomain (unknown [217.26.232.248])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 8CC40360077;
	Wed, 12 Feb 2025 19:01:19 +0000 (UTC)
From: Matthias Proske <email@matthias-proske.de>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Norbert van Bolhuis <nvbolhuis@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ondrej Jirman <megi@xff.cz>,
	Erick Archer <erick.archer@outlook.com>,
	Matthias Proske <email@matthias-proske.de>,
	Jacobe Zang <jacobe.zang@wesion.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: keep power during suspend if board requires it
Date: Wed, 12 Feb 2025 19:59:35 +0100
Message-ID: <20250212185941.146958-2-email@matthias-proske.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 87371727-d5df-497f-88f1-efc5d1639e48

After commit 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card
unless WOWL is used"), the wifi adapter by default is turned off on
suspend and then re-probed on resume.

This conflicts with some embedded boards that require to remain powered.
They will fail on resume with:

brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
ieee80211 phy1: brcmf_bus_started: failed: -110
ieee80211 phy1: brcmf_attach: dongle is not responding: err=-110
brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed

This commit checks for the Device Tree property 'cap-power-off-cards'.
If this property is not set, it means that we do not have the capability
to power off and should therefore remain powered.

Signed-off-by: Matthias Proske <email@matthias-proske.de>
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 60eb95fc19a5..6bc107476a2a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1172,6 +1172,7 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
 	struct brcmf_bus *bus_if;
 	struct brcmf_sdio_dev *sdiodev;
 	mmc_pm_flag_t sdio_flags;
+	bool cap_power_off;
 	int ret = 0;
 
 	func = container_of(dev, struct sdio_func, dev);
@@ -1179,19 +1180,23 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
 	if (func->num != 1)
 		return 0;
 
+	cap_power_off = !!(func->card->host->caps & MMC_CAP_POWER_OFF_CARD);
 
 	bus_if = dev_get_drvdata(dev);
 	sdiodev = bus_if->bus_priv.sdio;
 
-	if (sdiodev->wowl_enabled) {
+	if (sdiodev->wowl_enabled || !cap_power_off) {
 		brcmf_sdiod_freezer_on(sdiodev);
 		brcmf_sdio_wd_timer(sdiodev->bus, 0);
 
 		sdio_flags = MMC_PM_KEEP_POWER;
-		if (sdiodev->settings->bus.sdio.oob_irq_supported)
-			enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
-		else
-			sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
+
+		if (sdiodev->wowl_enabled) {
+			if (sdiodev->settings->bus.sdio.oob_irq_supported)
+				enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
+			else
+				sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
+		}
 
 		if (sdio_set_host_pm_flags(sdiodev->func1, sdio_flags))
 			brcmf_err("Failed to set pm_flags %x\n", sdio_flags);
@@ -1213,18 +1218,19 @@ static int brcmf_ops_sdio_resume(struct device *dev)
 	struct brcmf_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
 	struct sdio_func *func = container_of(dev, struct sdio_func, dev);
 	int ret = 0;
+	bool cap_power_off = !!(func->card->host->caps & MMC_CAP_POWER_OFF_CARD);
 
 	brcmf_dbg(SDIO, "Enter: F%d\n", func->num);
 	if (func->num != 2)
 		return 0;
 
-	if (!sdiodev->wowl_enabled) {
+	if (!sdiodev->wowl_enabled && cap_power_off) {
 		/* bus was powered off and device removed, probe again */
 		ret = brcmf_sdiod_probe(sdiodev);
 		if (ret)
 			brcmf_err("Failed to probe device on resume\n");
 	} else {
-		if (sdiodev->settings->bus.sdio.oob_irq_supported)
+		if (sdiodev->wowl_enabled && sdiodev->settings->bus.sdio.oob_irq_supported)
 			disable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
 
 		brcmf_sdiod_freezer_off(sdiodev);
-- 
2.48.1


