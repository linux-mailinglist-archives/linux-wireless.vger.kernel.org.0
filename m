Return-Path: <linux-wireless+bounces-8174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB28D170A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1766EB2334D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0013F9CC;
	Tue, 28 May 2024 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bnHzTT10"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6227317E8F3;
	Tue, 28 May 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887868; cv=none; b=SibUHkH+SJSb9Y9OGGFJTMezJb3PnynIjEGEu/f8/ns0j9girT23KX1Kj74F0BhP+R7dvc3g/sQMAya6Xb5Rzdam27AuLBDCW54FYRlSVG3L+v0BNY9dUwl4mNvfnoZQuzIKpQVfz12LPPnein6zXrgdPEokonhLhj+jgWo6WlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887868; c=relaxed/simple;
	bh=0nyQIlu5xVsGZoE/lFFn1UadS4mZECJUtykGucszjaM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Bu4v0/UFGwxynsTfA1D4QjRZUJmNMWjdDPDY2A/rnuvLJv30K83gP6TsbAV5MhNmwhr90LI3gpd5ks7WdGimhjKpCUxnOSCT0P9G66S5HeoLedm/FO/rN1gHABhxPSKzb45RccijFYHvcTDxnfBbaqhASvU3yg+Gtr+Ygo7xl0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bnHzTT10; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u6V23a4CaKODr1VkTAbDdbOLU9vRsWQDsBrqjogTQHs=; b=bnHzTT10LQ8+Nji5i/v0CM7kp+
	ryT8UToGKrFvQWN3uD2o+bCmY6fuk8peQ6Y3giK2680DaiHnyhDoRjpPAtR7XQptcJxDnDNv2D2Y9
	vJJtpwRfZIM8GxSUcUgCuRGMOf4itaxsLRYIvqrMFyuRVoSTM4zL6z+Z7agen9XAeJqaO+UEnufaU
	r1rIohJFtDUnDszYkoSmfYsKHlVCrgjVUYdi0PWtgqAFAJ/mk3G+QHFPk8sYE974SlKyXujqWrc/k
	t9ZVXG/whfZjBIJ78oPdcpVZ9cKcJqkcasBuZi7yDkq5IrUBGovXJBLbzzy581MicYnwdCBRIlDFN
	OKY6FrLA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37006 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sBsxf-0004XY-1s;
	Tue, 28 May 2024 10:17:39 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sBsxi-00E8vQ-5r; Tue, 28 May 2024 10:17:42 +0100
In-Reply-To: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	 Michael Nemanov <michael.nemanov@ti.com>,
	 linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 1/8] wifi: wlcore: correctness fix fwlog reading
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sBsxi-00E8vQ-5r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 10:17:42 +0100

Fix the calculation of clear_offset, which may overflow the end of
the buffer. However, this is harmless if it does because in that case
it will be recalculated when we copy the chunk of messages at the
start of the buffer.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/wireless/ti/wlcore/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/event.c b/drivers/net/wireless/ti/wlcore/event.c
index 2499dc908305..6c3a8ea9613e 100644
--- a/drivers/net/wireless/ti/wlcore/event.c
+++ b/drivers/net/wireless/ti/wlcore/event.c
@@ -83,7 +83,7 @@ int wlcore_event_fw_logger(struct wl1271 *wl)
 	/* Copy initial part up to the end of ring buffer */
 	len = min(actual_len, available_len);
 	wl12xx_copy_fwlog(wl, &buffer[start_loc], len);
-	clear_ptr = addr_ptr + start_loc + actual_len;
+	clear_ptr = addr_ptr + start_loc + len;
 	if (clear_ptr == buff_end_ptr)
 		clear_ptr = buff_start_ptr;
 
-- 
2.30.2


