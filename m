Return-Path: <linux-wireless+bounces-30164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C47CE80BE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 20:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71CFF300B2A9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 19:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BF83A1E94;
	Mon, 29 Dec 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kallisti.us header.i=@kallisti.us header.b="GL2QuF2a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ravenhurst.kallisti.us (ravenhurst.kallisti.us [69.164.210.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2B10F1
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.210.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767036830; cv=none; b=RpZ4UrUglpizXMIrOF+Vwpb8k0Oy0VBslc7RB5HGRWTVmNyLkk9ube5AV+3ia7MTcl9VRbCS/2vNP8lQkUil7DFMG3LG4YjMgdgq18CyBQSgMthTxr+jyVrPLAoMV4BQSClLEqn9B5VZNH8CdTjDPR1LjHQfdTXTeO2pWLf7c04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767036830; c=relaxed/simple;
	bh=Oe/dpeOePNqWlvKHi7bC6wOKh0bRRV9CfjacYIrtkmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sx/TDDDfXa7nZJGuzy3cuHkwZGQNKlL8WnF1NYqgNf1bwCBXw16HhAtqLtHp7IulN8OI2jHDaDLtikNMCk9lyHQgvdq+STSwZ/euOg7LUiZarBgrvLMon4yc3o7xPTvdkbLL5cAihAFoHKO1i/EhCzXSuAzN9iNxewMp909eeSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kallisti.us; spf=pass smtp.mailfrom=kallisti.us; dkim=pass (2048-bit key) header.d=kallisti.us header.i=@kallisti.us header.b=GL2QuF2a; arc=none smtp.client-ip=69.164.210.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kallisti.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kallisti.us
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kallisti.us
	; s=20220106; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qjp8rl3nPGoDuaselUVmykEowQaimV2zANlt7iKEMWo=; b=GL2QuF2a8Sc+cMz4VpJQy+tmXn
	/ZWJ9ef0eNZjKGXFILpehcH3xbDbmJxJ9rzYpTJyUwHOdA8YL52bMxVRMtdXYen4dRyC0nySUaoev
	XPHgV2/UR9aNsFGsYIXzB+Pd3955cK1L3dLABDGnUxYFZgW7dz0bKme1rWcIVCjxZ4wc60a3CrXvO
	7d4usFoVwDlL08v12kbXuwvM09LKpHUmOgNLcqTrw2KTpYYavOdYNf20ymPj5cgEcsfrBZlheBwRc
	roPtxCnVkdtomq9QKdGf+Ft9n84F9gfKF7nKl3Ir9oE5OEFbeSA9ngiGwLu7/33r/6X6xWNac+gbe
	Eg0mB4LA==;
Received: from [50.52.120.217] (helo=vanvanmojo.kallisti.us)
	by ravenhurst.kallisti.us with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <ross@kallisti.us>)
	id 1vaIPz-000000072eQ-1Zad;
	Mon, 29 Dec 2025 13:56:35 -0500
Date: Mon, 29 Dec 2025 10:56:31 -0800
From: Ross Vandegrift <ross@kallisti.us>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, ath11k@lists.infradead.org, 
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath11k: add pm quirk for Thinkpad Z16 Gen1
Message-ID: <lqdj7qwifphuvho2ag6fi25y63on2lzur7of6yt5prz3rxveur@zofllv7qgf2w>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Z16 Gen1 has the wakeup-from-suspend issues from [1] but was never added
to the appropriate quirk list.  I've tested this patch on top of 6.18.2,
it fixes the issue for me.

There's normally a second DMI product id, but I don't know what it is.
I also suspect Z13 Gen1 should be added too.  Mark, do you have those?

[1] - https://bugzilla.kernel.org/show_bug.cgi?id=219196

Signed-off-by: Ross Vandegrift <ross@kallisti.us>
---
 drivers/net/wireless/ath/ath11k/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 812686173ac8..1c910db69738 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -994,6 +994,13 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
 		},
 	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z16 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D4"),
+		},
+	},
 	{}
 };
 
-- 
2.47.3


