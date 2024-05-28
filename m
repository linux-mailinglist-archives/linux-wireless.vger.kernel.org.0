Return-Path: <linux-wireless+bounces-8175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFA38D170C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FA3285AF2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A99757FF;
	Tue, 28 May 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MQXGTzXl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148117E8F3;
	Tue, 28 May 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887873; cv=none; b=Z3kzGQEib6+7lqsxqzoSn+6RC1n/e195zdS4LJMjklE2/4jHiT4Grr6s2Lx5Unu/W9h9RhfBimIOp8NkiydcO1LX01M2lT1PvjObewnHERsYcZwgb9ypZHApIJCjYVBG1b544Izfd4mjUpay1RPNvZMP7FRsXCFAJNiAuZGfFcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887873; c=relaxed/simple;
	bh=ZNawznvhW5dSCU+ahFKTpAmKncLydZSOo3fHfgKcY6U=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Yfq1k7ER74isFM/ipfycAnGYqVIuzJlGLhQ9zuHSlBo22WGCnhkxS7Mi2MfS6xc1I/y0qfFCKD3u/TB15u4Ymejwg088iL/rXYThKunGITsPf7Xaunloc1gaBc/kmFrI8ctL6ypOzcktUvVUcCXbrMkwByZMm80td4ZPeKRL32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MQXGTzXl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s8Qr2bA8Hr30r+AbrQ3AL9uhD/eb6MQygnNFwPbBHoY=; b=MQXGTzXlC9AZhmbZSkuOcO6jAH
	t9PVOi7yGULEDlv4WzNOMhC8dCxXgG3WL9lavBglZt1mbZRCvO+j5l1V6dmitAy0ejR/XDv2JJETu
	QSKKGDAtVpUbx6sct0MHOBWL7VIbjQAvN+cO4UNtVHtcOcVus3BmsgU+I4Mpy/Z7rmlUvMTAQRxKD
	/dZs9DEH1fkBUSpQ03+d1B9KmvO7321RnaDqukeYi8czu55AKLosgBXbmd9C0wyPiSIf4RIHgrQWJ
	oFEiPkYqevuvW6LJGlvQM9AMkJTU2MmI9PM+QNEYuYdsARxXyDz6immhMr0X/tRkfvyraFOajor/Q
	ltc5O0WQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37010 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sBsxk-0004Xh-1s;
	Tue, 28 May 2024 10:17:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sBsxn-00E8vW-9h; Tue, 28 May 2024 10:17:47 +0100
In-Reply-To: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	 Michael Nemanov <michael.nemanov@ti.com>,
	 linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 2/8] wifi: wl18xx: make
 wl18xx_tx_immediate_complete() more efficient
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sBsxn-00E8vW-9h@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 10:17:47 +0100

wl18xx_tx_immediate_complete() iterates through the completed transmit
descriptors in a circular fashion, and in doing so uses a modulus
operation that is not a power of two. This leads to inefficient code
generation, which can be easily solved by providing a helper to
increment to the next descriptor. Use this more efficient solution.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/wireless/ti/wl18xx/tx.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ti/wl18xx/tx.c b/drivers/net/wireless/ti/wl18xx/tx.c
index 55d9b0861c53..beef393853ef 100644
--- a/drivers/net/wireless/ti/wl18xx/tx.c
+++ b/drivers/net/wireless/ti/wl18xx/tx.c
@@ -129,6 +129,14 @@ static void wl18xx_tx_complete_packet(struct wl1271 *wl, u8 tx_stat_byte)
 	wl1271_free_tx_id(wl, id);
 }
 
+static u8 wl18xx_next_tx_idx(u8 idx)
+{
+	if (++idx >= WL18XX_FW_MAX_TX_STATUS_DESC)
+		idx = 0;
+
+	return idx;
+}
+
 void wl18xx_tx_immediate_complete(struct wl1271 *wl)
 {
 	struct wl18xx_fw_status_priv *status_priv =
@@ -161,9 +169,8 @@ void wl18xx_tx_immediate_complete(struct wl1271 *wl)
 		return;
 	}
 
-	for (i = priv->last_fw_rls_idx;
-	     i != status_priv->fw_release_idx;
-	     i = (i + 1) % WL18XX_FW_MAX_TX_STATUS_DESC) {
+	for (i = priv->last_fw_rls_idx; i != status_priv->fw_release_idx;
+	     i = wl18xx_next_tx_idx(i)) {
 		wl18xx_tx_complete_packet(wl,
 			status_priv->released_tx_desc[i]);
 
-- 
2.30.2


