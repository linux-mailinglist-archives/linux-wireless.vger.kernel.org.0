Return-Path: <linux-wireless+bounces-22579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B22AAAB71
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79BBF7AEC6F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479243B11EE;
	Mon,  5 May 2025 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbsv0nd6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4452E62B0;
	Mon,  5 May 2025 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486361; cv=none; b=Ea6WsxGKRh8/rFSHoP9CwVKOKCMC+99BtmpRvtSyyXzPJtmOqagTu7bcXEaOAVHT4MZom/nLKOMhCTZfCiRJ4jmJPLu9kfWOamgM8hPbrjIspxBxwnt42bSOwhJKT3Qs1hXb0IUkqjZC+R2+4CdSIOBNWKK9I9b9TuRWpRqPByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486361; c=relaxed/simple;
	bh=/9BGlDgL7w9Q+zIZrKDXUM0AN8AxUkl6CWSvTa3RhDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UiV3UQoFACIsmwefR1m+BN20r15ZNT7+omySFxzY9yuFWY0/bmYNuufRnDFEtXknD20JcSm3hPqG8jOkMDontSaAOuCCJyrTGgNedplGpzguwhNcyeCk7shg2B8o6BE7iOYxxHywKUJ0ZYjj0Z+vAkx1LHH/vgC8x48l37VvCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jbsv0nd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57D3C4CEED;
	Mon,  5 May 2025 23:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486361;
	bh=/9BGlDgL7w9Q+zIZrKDXUM0AN8AxUkl6CWSvTa3RhDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jbsv0nd6VnAtk/r6RJ1APjmGYxGGY/u9GcHY8LjXm9eWdiRUHSo/nNo2KLRt8zOTp
	 XhHkws6zwVkIs218owj1DHKjyN7J1CJSgsn9/llC2+PHAL6dVwZu2FywnapW3o6mI1
	 cNf0RiZ7+jbmJU3GurMdEVZjj2Y1bboq7UB6WEnDEV2/uF620XlTAXDcN4RE0z7/ET
	 +C+Cy95beiwX/J0Nz7HOZXSzwLpTwvKM76cWVsM6VNueeLntHR3XDTJAF93sMJdBR8
	 W9QyBFWiQ6C7JZ8YwSoisPeGthT68Fq4XyD2NpttWCExXlr+F5pwJtkXl3SCLR/zZ/
	 +Z2ERovry9KOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Soeren Moch <smoch@web.de>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	Jes.Sorensen@gmail.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 281/294] wifi: rtl8xxxu: retry firmware download on error
Date: Mon,  5 May 2025 18:56:21 -0400
Message-Id: <20250505225634.2688578-281-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Soeren Moch <smoch@web.de>

[ Upstream commit 3d3e28feca7ac8c6cf2a390dbbe1f97e3feb7f36 ]

Occasionally there is an EPROTO error during firmware download.
This error is converted to EAGAIN in the download function.
But nobody tries again and so device probe fails.

Implement download retry to fix this.

This error was observed (and fix tested) on a tbs2910 board [1]
with an embedded RTL8188EU (0bda:8179) device behind a USB hub.

[1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts

Signed-off-by: Soeren Moch <smoch@web.de>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250127194828.599379-1-smoch@web.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 6e47dde938909..05e77d2bda373 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -900,9 +900,10 @@ rtl8xxxu_writeN(struct rtl8xxxu_priv *priv, u16 addr, u8 *buf, u16 len)
 	return len;
 
 write_error:
-	dev_info(&udev->dev,
-		 "%s: Failed to write block at addr: %04x size: %04x\n",
-		 __func__, addr, blocksize);
+	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_REG_WRITE)
+		dev_info(&udev->dev,
+			 "%s: Failed to write block at addr: %04x size: %04x\n",
+			 __func__, addr, blocksize);
 	return -EAGAIN;
 }
 
@@ -4073,8 +4074,14 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	 */
 	rtl8xxxu_write16(priv, REG_TRXFF_BNDY + 2, fops->trxff_boundary);
 
-	ret = rtl8xxxu_download_firmware(priv);
-	dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
+	for (int retry = 5; retry >= 0 ; retry--) {
+		ret = rtl8xxxu_download_firmware(priv);
+		dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
+		if (ret != -EAGAIN)
+			break;
+		if (retry)
+			dev_dbg(dev, "%s: retry firmware download\n", __func__);
+	}
 	if (ret)
 		goto exit;
 	ret = rtl8xxxu_start_firmware(priv);
-- 
2.39.5


