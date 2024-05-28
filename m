Return-Path: <linux-wireless+bounces-8176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0BE8D170F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4134B1F213AF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E02213D8A5;
	Tue, 28 May 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J7mujtiV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737617E8F3;
	Tue, 28 May 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887878; cv=none; b=VpCTTPudTMEHQnrHn6MvkgigBi/kLtlqn28gil/xYmMmrwo1jeEpdG6955HHH0tcZqDoi4UGvpMXnSPcVXsDhXWmbAvfwozAUvNXMtJX1OOzRPpwo4yEwyAFDRfnX2Ovky0w6RmjCmLngU4VA69IPoYNw9gSj1R/gF+cW+G/rS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887878; c=relaxed/simple;
	bh=NBVtuUL21VTqpumFWGrktrwmTrAumjJzvLFNX8RXO1M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=FtxuDTi3N/QhzNiK3+i5k2P3QNgkQ4RDbNwfuOBNvIn9/pbG0yeHQ3cNmIcuk8ftzyUZ8ocv73RHTd5a5kC9GbBce5gy7u8OkCsz3gJkU2kG6lIu4vZYxRWiAe11xhOLLixv0sBE/g66t3Qz+7mBcxE5p0O4whsAG2L0q9wZTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J7mujtiV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PfGnzg4p0KPeEdVtxHFMLkm7NDRotPoeUjFEFun08h8=; b=J7mujtiVpZoR+55wIVq4Am1X3F
	2UNPARm/w4386spkel+5aGZfWeRWVoCZm7fSrgOYiT71oV7mZ5vCKsQ5Ztcy9YwUsuKoWGAtsk5Y9
	FrFmRYoRC9mYeO56dTT2pKabd4sZTFsgEhNvKYzz2aAshEE9R2fdDID8BMfXoAk5Xh7TRk10KBMIM
	KLg/COqYC4BU8XPlEZ1han+VqdQObvYWaXuBOOwJvZtEgdL5LDCJLouecWX7EX5Nl1v2sfem/2ida
	5mwNcuxbSlJncL4hb7Y/EVxQ4qD9KUPQV4QJIxBQ1j/DKD5xChshoXpwG+14ncCngyP5tQEMD62Ni
	JVpKbZGQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51426 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sBsxp-0004Xq-2K;
	Tue, 28 May 2024 10:17:49 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sBsxs-00E8vc-DD; Tue, 28 May 2024 10:17:52 +0100
In-Reply-To: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	 Michael Nemanov <michael.nemanov@ti.com>,
	 linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 3/8] wifi: wlcore: improve code in
 wlcore_fw_status()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sBsxs-00E8vc-DD@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 10:17:52 +0100

Referring to status->counters.tx_lnk_free_pkts[i] multiple times leads
to less efficient code. Cache this value in a local variable. This
also makes the code clearer.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/wireless/ti/wlcore/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index ef12169f8044..a98b26dc3cb8 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -412,18 +412,18 @@ static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
 
 
 	for_each_set_bit(i, wl->links_map, wl->num_links) {
-		u8 diff;
+		u8 diff, tx_lnk_free_pkts;
 		lnk = &wl->links[i];
 
 		/* prevent wrap-around in freed-packets counter */
-		diff = (status->counters.tx_lnk_free_pkts[i] -
-		       lnk->prev_freed_pkts) & 0xff;
+		tx_lnk_free_pkts = status->counters.tx_lnk_free_pkts[i];
+		diff = (tx_lnk_free_pkts - lnk->prev_freed_pkts) & 0xff;
 
 		if (diff == 0)
 			continue;
 
 		lnk->allocated_pkts -= diff;
-		lnk->prev_freed_pkts = status->counters.tx_lnk_free_pkts[i];
+		lnk->prev_freed_pkts = tx_lnk_free_pkts;
 
 		/* accumulate the prev_freed_pkts counter */
 		lnk->total_freed_pkts += diff;
-- 
2.30.2


