Return-Path: <linux-wireless+bounces-22635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE36AAB6F6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 08:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148D64A420D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082152367D9;
	Tue,  6 May 2025 00:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiYfBGVj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B24E288517;
	Mon,  5 May 2025 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486304; cv=none; b=ngTdcuwQ30afCkq3oUgAaSfk6hrLHNltnQUxM8Q6wpVxuXoAEKjdTgv8Mvp/H8sR7l5EHDJaPpCGAZFW9Tm4gP/9uzGZx6Z03Wiq6OV/K4I6jmPANcq40oy8meI+ypxXUwlekL5T6MFYmrlIcfClIO3ANHFyhG4R2bvzr9RlVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486304; c=relaxed/simple;
	bh=ZUVlvVIgB8YwlAUdLgIvckTa1jUf28nkG3tmq2gjBdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKPN+V/vzmGNMYPTx3TDssPEroG3bMdKezapmiGSYhANjXPeAXUD/fVAG3PGpO2j3YB/DUebVcy8gfGmxga8BFIh3hjsUVbyYCy8X0KFLmybuMleS6b5fYDpxR+OF0rnDvOXlywEiwpeIYXeisifiH1Li0Vr8Up4/9jFox+tU1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiYfBGVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6033C4CEEF;
	Mon,  5 May 2025 23:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486304;
	bh=ZUVlvVIgB8YwlAUdLgIvckTa1jUf28nkG3tmq2gjBdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiYfBGVjNbJXNRgSwhZ1C/MfRtjYkKwlaICRLzfYgV6suvmksMHadr/1uk5M2/Lxi
	 KMs6HqYxUda8l4jMfDElci+xWys2QdBC9kgWSqPSxMR2PAtYTH6Cd3LZS9zT3dc6VM
	 hfsEBv3M2BqU+V5HS9G0rwLaR0KnK8V9y/+tSIuvQdooSiQ1z5XCyGfkj/JIZasRXc
	 Zj7tJqYFxbucJAXWnFgfT90/Y1Gi6DPsdLT9Ev5ipQ12JZRb+57GqD81D5ebp6JNPN
	 NA3Rkczu0fVAGVHBvMSR5vAvNXIbnXu+aiZLUDcxMr2uoZKhrFwXMibV2IPYP2J1f5
	 vKfN6NGMkxRtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 249/294] wifi: rtw88: Fix __rtw_download_firmware() for RTL8814AU
Date: Mon,  5 May 2025 18:55:49 -0400
Message-Id: <20250505225634.2688578-249-sashal@kernel.org>
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

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 8425f5c8f04dbcf11ade78f984a494fc0b90e7a0 ]

Don't call ltecoex_read_reg() and ltecoex_reg_write() when the
ltecoex_addr member of struct rtw_chip_info is NULL. The RTL8814AU
doesn't have this feature.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/55b5641f-094e-4f94-9f79-ac053733f2cf@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 0c1c1ff31085c..929182424b8b8 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -783,7 +783,8 @@ static int __rtw_download_firmware(struct rtw_dev *rtwdev,
 	if (!check_firmware_size(data, size))
 		return -EINVAL;
 
-	if (!ltecoex_read_reg(rtwdev, 0x38, &ltecoex_bckp))
+	if (rtwdev->chip->ltecoex_addr &&
+	    !ltecoex_read_reg(rtwdev, 0x38, &ltecoex_bckp))
 		return -EBUSY;
 
 	wlan_cpu_enable(rtwdev, false);
@@ -801,7 +802,8 @@ static int __rtw_download_firmware(struct rtw_dev *rtwdev,
 
 	wlan_cpu_enable(rtwdev, true);
 
-	if (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
+	if (rtwdev->chip->ltecoex_addr &&
+	    !ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
 		ret = -EBUSY;
 		goto dlfw_fail;
 	}
-- 
2.39.5


