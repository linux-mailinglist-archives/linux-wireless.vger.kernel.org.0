Return-Path: <linux-wireless+bounces-30316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3B9CF076A
	for <lists+linux-wireless@lfdr.de>; Sun, 04 Jan 2026 02:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 582D5300F887
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jan 2026 01:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B33A1E9B;
	Sun,  4 Jan 2026 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kallisti.us header.i=@kallisti.us header.b="iIJXRjT6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ravenhurst.kallisti.us (ravenhurst.kallisti.us [69.164.210.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30A1367
	for <linux-wireless@vger.kernel.org>; Sun,  4 Jan 2026 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.210.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767488449; cv=none; b=BXSO+Q9lOLC1jb5FSr4D6+Q6EPYKC7Rncvx5+XiBUXL/mjrm7FwiEeiNHy1ftk4xo9e+7uSBMGmGyQ0+xKLsdoyZvPCoSVgyL6NqVXZ0bwzMO6agSukjnwtAJizEnaDZwhOyll6c3tn2OxgZfiu0k8QlPPy8fteMrBT92smVook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767488449; c=relaxed/simple;
	bh=22EbgYA1NA77PlPLiqb0PPj0Y8xmSBtz76X4SOdE/tM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=scix6qIM6loO2cB7wE0dXigkTXiifbNk+Zhv9yiB5fdRG0FdOTVqaYPls4HVMefdaeJSUsBt7B3loZctH7LI4FqlAcJbN+OMuLW8YG333rIx09Z9+9RjHt8yICep1MljkLAi21DxTRBasJAo/6WnsDgc5LhbHGm664uGrYvwF1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kallisti.us; spf=pass smtp.mailfrom=kallisti.us; dkim=pass (2048-bit key) header.d=kallisti.us header.i=@kallisti.us header.b=iIJXRjT6; arc=none smtp.client-ip=69.164.210.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kallisti.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kallisti.us
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kallisti.us
	; s=20220106; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=shza/H2dQJXR6JluhC10VoHA78PjwQvcEkvEM14HAIs=; b=iIJXRjT619TuNfMsXRwcqEsur6
	lgE3VPCDm8f1wA7pw+IEn/9nctnSyq5orub5XaaY5tWmYUmy7jOb85N0unKcUJZwDUt58zsEGwIlN
	m4SMDjOb2hds/86RKk/pDCOJSSehU1n7REkpHqpPTD5TcfgTtPIcOI4+eGxv1E/tlia/GejxpN7TW
	8taoTx4smdtdY519u8gvxKUXk7afJvZDlS8dgkBVbJGCw+qBWm/1to6wvz3UEUXEadKcjAGEZJuGX
	8vl8YVAfnwP2+KChv0xVdSRRaCUaLRfC60A0gLukd8HXDbe+d54EH0qJvBnlObwgvp5KMmM9U9PjI
	GFsyhObg==;
Received: from [50.52.120.217] (helo=vanvanmojo.kallisti.us)
	by ravenhurst.kallisti.us with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <ross@kallisti.us>)
	id 1vcCU2-00000007agP-1q50;
	Sat, 03 Jan 2026 20:00:38 -0500
Date: Sat, 3 Jan 2026 17:00:34 -0800
From: Ross Vandegrift <ross@kallisti.us>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, ath11k@lists.infradead.org, 
	linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: ath11k: add pm quirk for Thinkpad Z13/Z16 Gen1
Message-ID: <wj7o2kmb7g54stdjvxp2hjqrnutnq3jbf4s2uh4ctvmlxdq7tf@nbkj2ebakhrd>
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
it fixes the issue for me on 21D4

Mark Pearson provided the other product IDs covering the second Z16 Gen1
and both Z13 Gen1 identifiers.  They share the same firmware, and folks
in the bugzilla report do indeed see the problem on Z13.

[1] - https://bugzilla.kernel.org/show_bug.cgi?id=219196

Signed-off-by: Ross Vandegrift <ross@kallisti.us>
---
 drivers/net/wireless/ath/ath11k/core.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 812686173ac8..03dddc1cd003 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -994,6 +994,34 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
 		},
 	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z13 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D2"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z13 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D3"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z16 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D4"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z16 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
+		},
+	},
 	{}
 };
 
-- 
2.47.3


