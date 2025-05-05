Return-Path: <linux-wireless+bounces-22531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 443E6AAA6E1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3E7188582E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB9330532;
	Mon,  5 May 2025 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUwyIJvF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A7F330523;
	Mon,  5 May 2025 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484542; cv=none; b=AvOSsotqFdXSLHZVwLir8OAWYByPTN+grJk3WPOX705CkTXmLcrDfeAe5wkSLERu+3MsIohF03itbIiwhx7rWdyfWY3iAo7+NnysS6R3gt2lhAUKs2OYYD9hTfZrObskKzTge5M4KMIhocZ1sqb7ukDKM1ivRoBRK5rw6L6oGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484542; c=relaxed/simple;
	bh=go1vLks7IVXgKX16cXgUwyUjtlS3iHwVc1oco+MWEPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EL2OSl7OmjRJBduWGze9hNwXe72KS94+zM1+/G0CMEzmpFil5810fKRiUXgpmTupzV/Vg5QX2P58/TtVlf30OjsowsOLVOo8yDT0f49QwGWZi7/3D6HbEjxEt6KnlTSecsym2IEoJeeu5qv9kRzIIz48qidUv+VkW3IqhtAHZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUwyIJvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A77C4CEEE;
	Mon,  5 May 2025 22:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484542;
	bh=go1vLks7IVXgKX16cXgUwyUjtlS3iHwVc1oco+MWEPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUwyIJvFsMSwsUoUzcCj23suHXqGv+/b1WWNywMp17ilsHS02ZxxGY1tV1hAxogTO
	 qC8l4lpkgxdOihEWPnGzv+IdT9xahBjIPt9fPEnkwEIUeeYwdYzu8Ydp/99ICh2qkS
	 IowSQURc5Pa27RZD8xVqYKZJN+mg/umi8xiu8ALrROGwRjL1jscF3M3prcrlzg9ALi
	 1YHcq4U3CqkSl0i3w8jeMuGbUGQJ9a0LWR748FxinsLfyAS7MTwpsz+biqu9FOdUoG
	 bISTyIdAVgzpkeTAeGxC5hnwusB9VsjGPzZOh1ju3L5gFeeSo0IO27oGL1L9Ijj+xb
	 Sa3YbQa5lNOEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 525/642] wifi: rtw88: Fix __rtw_download_firmware() for RTL8814AU
Date: Mon,  5 May 2025 18:12:21 -0400
Message-Id: <20250505221419.2672473-525-sashal@kernel.org>
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
index ea6406df42b3d..0491f501c1383 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -785,7 +785,8 @@ static int __rtw_download_firmware(struct rtw_dev *rtwdev,
 	if (!check_firmware_size(data, size))
 		return -EINVAL;
 
-	if (!ltecoex_read_reg(rtwdev, 0x38, &ltecoex_bckp))
+	if (rtwdev->chip->ltecoex_addr &&
+	    !ltecoex_read_reg(rtwdev, 0x38, &ltecoex_bckp))
 		return -EBUSY;
 
 	wlan_cpu_enable(rtwdev, false);
@@ -803,7 +804,8 @@ static int __rtw_download_firmware(struct rtw_dev *rtwdev,
 
 	wlan_cpu_enable(rtwdev, true);
 
-	if (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
+	if (rtwdev->chip->ltecoex_addr &&
+	    !ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
 		ret = -EBUSY;
 		goto dlfw_fail;
 	}
-- 
2.39.5


