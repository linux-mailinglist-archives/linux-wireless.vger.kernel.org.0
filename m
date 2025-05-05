Return-Path: <linux-wireless+bounces-22623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2570AAB68A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA23A3A7F1F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6808336B68;
	Tue,  6 May 2025 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/OJ9Sdu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0202D47D8;
	Mon,  5 May 2025 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485650; cv=none; b=tFFPGlIGJYv21Q2HIrcRcHl0KHCmUlncNnxK42TyLDvwPxbmRczRuEeY0CVFKBZmD7D9lq57StJ49bF5qOzky1ln0OmeuqtsjPCpZ0PcL8yhiTsMQPj2xSVg6Fxd5CKoeo+uU2iDT+1fE4GGEGtpndA/Q/GcsFSH+DL8zFN8Vm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485650; c=relaxed/simple;
	bh=2fQsUy3SCe3zT/fRk+gaeZgAzyoGtfKgFTLPHuQD9Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UumSSI+L73XYKY3siz5YqMJ45yv3Lu2pCJ/iOxR00QY9DBRnZR9heLsEZCF/+y+H0LIKM7LJCRfoTbIERuv/emr+14fGFPUtgAoJHH9PGMrUdjxM7y5DfILGx8eoVZBAIFeSGEx7pTcIhgZxTLv0fvJGLggcVcMw0Pdy5yfKJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/OJ9Sdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A778FC4CEEF;
	Mon,  5 May 2025 22:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485650;
	bh=2fQsUy3SCe3zT/fRk+gaeZgAzyoGtfKgFTLPHuQD9Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/OJ9Sdu5Hc5+mFDkPusGiWyIA01P5w1MVhVJf4+PKNLorcsqfifT88Pn/nvMLfff
	 K1ROpw2KBUTT6gUezQe8ayOVmbDb4aWQlMIYfhQqkwb/AsIW/6Z6FDdBPT5/4c+3im
	 unfXD9rkJAT++ATb/2gbXqK5HPH4y4le80Bo8A12raTicrovpldNKEIYbKAZEA7hK/
	 PKkNOYJKcBJB16ciXK9BSe69v/wYh6POcTvTT/ohkaQHE6hYBoFsSGRLK8ZDjmieCI
	 zaAXqnZCDO6XigqINgExRBIOtefOVA/RkAmNo86vw+ZJVKK6HOqXopAWq3Sc2r/O/a
	 qoH0qJnAS7R1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 406/486] wifi: rtw88: Fix __rtw_download_firmware() for RTL8814AU
Date: Mon,  5 May 2025 18:38:02 -0400
Message-Id: <20250505223922.2682012-406-sashal@kernel.org>
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
index 564f5988ee82a..d1c4f5cdcb21d 100644
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


