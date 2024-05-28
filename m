Return-Path: <linux-wireless+bounces-8177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AFA8D1711
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F59F1C22E97
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032FC13D88B;
	Tue, 28 May 2024 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xd/2TId0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C531DA5F;
	Tue, 28 May 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887882; cv=none; b=BKCLlyNfUHJGRREu5iap0dcApo0QUhrxI9P2Ty7eElhBMRtoWPxV7sMJg3kQicFo4oCkTr46CPzsrJyH7viMWoaZwp0I0ZQ5bo0veW5uBnnboMD/rHwYEUPkgOzkPYZLRqwZ2CbprflywSTBzz/um/yF10A65g9rbr5o+CsTdKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887882; c=relaxed/simple;
	bh=LwXrmwTw34TzKIJXUTrMzBXzUMAcfJpcVULiuNUyxZ8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=iiaeZpPC7lvJZTIIqaCBv1/pPQd9+/pLokjLhAUHB47mb+RcO48WKxS4LgCh+k3JlBJDVNt7DExTGMxDVkE/qg3Z0+tEEiTwOQwYeCoU34Y7gwrKV68bFP1COfKY+jovdO3drOO9zV+QfNlAuQMucGUFfG1Tcn6nsD+TXzkxa8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xd/2TId0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qvnXOqeSbN57VD1xQ/WachONgqYyaHMsTEDVjptCkv4=; b=xd/2TId0MrNuDId8S2fH7u3Zar
	koEvIXkcXRNJx7VQfzkI0Kxg4RqEGCRDB15GiOSBe4n5gvR3RSduFyXecoo2aLlmGx7lddOz1vJGR
	fP+zyjtvyEjtiWP23NJn1FAIa5wsXmvEkHHwkkw068jJXkpu+pdXnXobwrFzrBGPiwxSV4VWfu0WC
	v4RlYeKq/YUqI/dg6Ti8gm3WEj7ex0Mq0akHXSyQnG0O82xoJE4v9ROeAiZbQKak8zs5zdLOtPiK9
	BsUTpufs10mcUGUKNhYtVfmEUnIA5MObLZl5w/Sy0ph97xCpbuFbsNj3vT3PgWQOX97Oc572KnqRB
	3zK4yeCw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51436 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sBsxu-0004Xz-2m;
	Tue, 28 May 2024 10:17:54 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sBsxx-00E8vi-Gf; Tue, 28 May 2024 10:17:57 +0100
In-Reply-To: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	 Michael Nemanov <michael.nemanov@ti.com>,
	 linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 4/8] wifi: wlcore: pass "status" to
 wlcore_hw_convert_fw_status()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sBsxx-00E8vi-Gf@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 10:17:57 +0100

wlcore_fw_status() is passed a pointer to the struct wl_fw_status to
decode the status into, which is always wl->fw_status. Rather than
referencing wl->fw_status within wlcore_fw_status(), use the supplied
argument so that we access this member in a consistent manner.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/wireless/ti/wlcore/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index a98b26dc3cb8..3defe49c5120 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -392,7 +392,7 @@ static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
 	if (ret < 0)
 		return ret;
 
-	wlcore_hw_convert_fw_status(wl, wl->raw_fw_status, wl->fw_status);
+	wlcore_hw_convert_fw_status(wl, wl->raw_fw_status, status);
 
 	wl1271_debug(DEBUG_IRQ, "intr: 0x%x (fw_rx_counter = %d, "
 		     "drv_rx_counter = %d, tx_results_counter = %d)",
-- 
2.30.2


