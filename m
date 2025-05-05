Return-Path: <linux-wireless+bounces-22512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC1BAAA546
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D803BD6B9
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA2C2868A3;
	Mon,  5 May 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1UhILo8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13936286899;
	Mon,  5 May 2025 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484138; cv=none; b=FD97PzZUpgVRi+rI9x3k3fbaRIsnVw4tbJU9oNi76Oww2LOAjBYiBdwuVvoBWfl44/fVtH7zVL59tEEGOWUwTto7i9kGcJ/qoJJx4IKiNnyupoOkDxXv2hrGktb4qpX6dSjj/mBnJ8w9h295GBCUglUoZnntV7rMVzHDErmOUNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484138; c=relaxed/simple;
	bh=0PeuTbO+NKhSwoD3WIVNVMp/eT1XP+eyoWerkm2g7Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HQ2vlZXNtpM1ZIZFd72kufWy363JDbnSY6+iDuZNO6fBzKD8MrGb6YUzyL6eBRHYNvw5ohzjbWCKa8cKFTSqf8sm0Zi7BsPPkIyLDJmEsqc+ERbJzRIYIHZbxthmhXC2bIUT2thQ5801zysXHl7y7pA1waFdVr8WRu9/vYOAsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1UhILo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A45C4CEED;
	Mon,  5 May 2025 22:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484137;
	bh=0PeuTbO+NKhSwoD3WIVNVMp/eT1XP+eyoWerkm2g7Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j1UhILo8vv1om9THQnsE3TZ9oeTMy82f3QwWiQeKXtpwT+pvyXLcqVSHU05KO0RSh
	 aEolNsS0Mcc07GhdH+JSTuJ0touZ4KwEYzKZ2cOXPiYEJH5+lwrC7nL450VKnTcgaE
	 /964h7nLWp4KlmvQjmB/o1357luf8kuxeQzA2TSjvuu1EIEP5vvOq4RSg+GknW7Mtw
	 f/j88yJdt+BGm7TxAxG1E9YYGzhM8E/f1DCqHccEWYPyDX1wKMz+VCcyvssQ/NZ+nP
	 r9OzHzONtbmeQuwFPUKBAjzPnRjESefMlcP9VA7zOoRIsJ2I6KOYfj7PX/Lhgdc9Cr
	 FtkJAxSvWCx4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 367/642] wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
Date: Mon,  5 May 2025 18:09:43 -0400
Message-Id: <20250505221419.2672473-367-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit e66bca16638ee59e997f9d9a3711b3ae587d04d9 ]

rtw_mac_power_switch() checks bit 8 of REG_SYS_STATUS1 to see if the
chip is powered on. This bit appears to be always on in the RTL8814AU,
so ignore it.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/2f0fcffb-3067-4d95-a68c-f2f3a5a47921@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index cae9cca6dca3d..ea6406df42b3d 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -291,6 +291,7 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	if (rtw_read8(rtwdev, REG_CR) == 0xea)
 		cur_pwr = false;
 	else if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB &&
+		 chip->id != RTW_CHIP_TYPE_8814A &&
 		 (rtw_read8(rtwdev, REG_SYS_STATUS1 + 1) & BIT(0)))
 		cur_pwr = false;
 	else
-- 
2.39.5


