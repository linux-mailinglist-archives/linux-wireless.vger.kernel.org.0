Return-Path: <linux-wireless+bounces-22630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CE6AAB2A3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78363A9CA1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359C142843D;
	Tue,  6 May 2025 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1WbDt5V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC5278758;
	Mon,  5 May 2025 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485750; cv=none; b=TDgkymKySVcyhFIgD/KXUWenbQoN6d4GaWIV9NRFX1V3ATcWcPOYkJxKZKJdlUj6hW1Ws+QgleflhJ0H9rBC417S3mbxtCp1QHwWqzbaIBLr6xmx6lxtmfgnSIeoHxOBkL3NuWIfXnKRJeRJqMt5vxh92Pgr5cWmkYAvmGszcVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485750; c=relaxed/simple;
	bh=oICzpjc+PidZ180DElfETsb3v6xdVVeNPNtBIvsbBgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzztMhfylBt/g/UGGJ53hIcIVnbs2SngfU4ZbpfKUbszrzAxF0PH3GOJ/RE+0tcnpVVbzIEIM2z8Ri8ViTCAGDpAx6ZNHbH5OkdUyHXSgY2FkWKX2eZWMpZkN72ADefphlquAk6YSptwdiOOTCgRQDXaH2EuuGyY/OC41mq8oLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1WbDt5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C21C4CEF3;
	Mon,  5 May 2025 22:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485750;
	bh=oICzpjc+PidZ180DElfETsb3v6xdVVeNPNtBIvsbBgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1WbDt5V+u3psTUzj1NJuCAURkHQf2ban4xiRvGzUmxUGqRX/VeHnf2Q+NY9FqoPF
	 5lc0YbM5iasDBFSB79Fl/tiFZvMCyA0rMIrEiJutw2tMTvB2Z7Zf5+uSGre1Btf2EP
	 7hUmcEU8xLav/cqgEid7zgvqpEkuwAxGpnknqv+xAWdJD9C+HlBGcuxPMFoEH1GJt8
	 BFMiXXUdNt1ZJYIs4KITiFNAUH0N96OD/nVXI5RAaikW7Ty6eNkiXY3ZzxgmbJJxbL
	 0+QF5ax8elOzC5Vh3MXDciDXtqcp+wZuheH2/bydify2Fm+sYs13pF+vOKJPWTP9gG
	 jG456t1gMwb5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Soeren Moch <smoch@web.de>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	Jes.Sorensen@gmail.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 462/486] wifi: rtl8xxxu: retry firmware download on error
Date: Mon,  5 May 2025 18:38:58 -0400
Message-Id: <20250505223922.2682012-462-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 4ce0c05c51291..569856ca677f6 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -860,9 +860,10 @@ rtl8xxxu_writeN(struct rtl8xxxu_priv *priv, u16 addr, u8 *buf, u16 len)
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
 
@@ -4064,8 +4065,14 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
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


