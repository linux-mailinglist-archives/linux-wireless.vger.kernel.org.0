Return-Path: <linux-wireless+bounces-21140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF483A7AA46
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 21:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9677F3ADA5F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80322586CC;
	Thu,  3 Apr 2025 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ3bPRcR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32F2586C8;
	Thu,  3 Apr 2025 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706991; cv=none; b=GCAr6U55PPNRAMHtAODKimgDh/tHZJIb3DSbFbBxys0gQC2saYuOJrJ7alfgUcEX8vGNWnGgZ6dwsMBjmORJ2q4T+Z6y/iXwp179T+i7kQqyfoz07KUYLrbqT5ooZ+ZzyTHny9NLdbdQiUBfUMr+q7s1gQDs7YHpPIDMe1WBtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706991; c=relaxed/simple;
	bh=UbRoaPQiaPriiA58VAy2/csM024QjLTwPDPpJTqe79I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUkQ6STpcw8jVfpd4wMdiRS0AhugDiphfw5gqISLMDvV4X32fiNBnc2d/FITKRZqEng58j/ui9EyujoEDDQ54kCh6zAVBCNGEYIX8O5pPRblCyCFERNim6TZQziZpqQzB9DrEQ51myo1zSr/mcotWeYMbjRflg6WCH1y+Nen1uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ3bPRcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C641C4CEE3;
	Thu,  3 Apr 2025 19:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706991;
	bh=UbRoaPQiaPriiA58VAy2/csM024QjLTwPDPpJTqe79I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQ3bPRcRK0uqXoXpyIymwwYbRsUjR+x18djjFDnBuGqbUopgN9RaD0VgOSNxp5BUP
	 8yHBXgpz5fWyy0tjDP3Bzl/t1L67OcKCbNokFwNKn69jKBHpz9yrig562AStrL9pPD
	 MT4MSrwKkwGYl9O0kk4J1u1tv7JeHkqgWn/agBiZ7z2b0PfeEcXDvrqClW607dM4qI
	 XgeX1KWm26GbGHNzgU6FX59mCMCJmbLTORhR1+VMHIKNfz0PeOZpP0KQek3LTtofDR
	 1J9S7WpBPhiYo0wNW7D1MU558DdPzSaDxaqpPVAOq+xxbxBRoVu6adGReaQK7rZW0c
	 hW/0Acf6uV72w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 25/54] wifi: rtw88: Add support for Mercusys MA30N and D-Link DWA-T185 rev. A1
Date: Thu,  3 Apr 2025 15:01:40 -0400
Message-Id: <20250403190209.2675485-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Zenm Chen <zenmchen@gmail.com>

[ Upstream commit 80c4668d024ff7b5427d90b5fad655ce9461c7b1 ]

Add two more USB IDs found in
https://github.com/RinCat/RTL88x2BU-Linux-Driver
to support Mercusys MA30N and D-Link DWA-T185 rev. A1.

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250210073610.4174-1-zenmchen@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
index 8883300fc6adb..572d1f31832ee 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
@@ -73,6 +73,10 @@ static const struct usb_device_id rtw_8822bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* ELECOM WDB-867DU3S */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0107, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* Mercusys MA30H */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x010a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* Mercusys MA30N */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3322, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* D-Link DWA-T185 rev. A1 */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8822bu_id_table);
-- 
2.39.5


