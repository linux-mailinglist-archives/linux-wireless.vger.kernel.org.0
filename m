Return-Path: <linux-wireless+bounces-13158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFF69858C9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527781F21170
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18DB1922D3;
	Wed, 25 Sep 2024 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWqb71Zd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA4181BA8;
	Wed, 25 Sep 2024 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264285; cv=none; b=fxd/uat8xEye12OLgVNbg8jpm7eC2PwcTWWr06UJmTSX5H6GWWPUKsBNkJVTB+9PjMrnRdYYSd6JHcU1nE2U164B9bZM0+e/5six+lhUfFO5Pos/R/gRspTQ23/H2wMRbtgzmHIaQaeRIiK3CMj/1GJ+xvdTDn2Y4M9JKIul9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264285; c=relaxed/simple;
	bh=MY0LPW//08MCUSpZ0OHSK4x40ijV3mQC1vs25PM+ryg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKjYGUYV9NiOzzsRQr2ckwd6CV7bMH3dkPIWjNO+WrwwlrGdi+uce68MemqySaEzH2t9WxS+IfKJgivEkRS6RzT0sgXJQJJm8i67Rt6vfUcWZq9cmUCsAiNRRx0SmEyrHgpXhL9dkMfYFrJGI22vP0+ZT6sTZ9mGCLIEO7HJg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWqb71Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0D6C4CEC3;
	Wed, 25 Sep 2024 11:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264285;
	bh=MY0LPW//08MCUSpZ0OHSK4x40ijV3mQC1vs25PM+ryg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWqb71Zduey5hdYMCLmT2N/3nZUymBZh1puAumvmhsujKYU/aT6kkmE7KVSLq+9Mg
	 quQDxgNS5h/1AAkVbSiFeO1anP0y3gMKxaanLhi5qNRrp0oJt4IxwfEt4paR7ABucj
	 hq58tE0Jt0IG3v0cYZecsYmPs+mnTMKfE5JmUkoZASKeW2oKQbqXnSSaNFS2M/Jw6w
	 cnGFSsNlYBBmaZKvvC6+CYqdS8rEp60/pjV0UothMZ5zL6WEL8WFsYVolAvK70RwIU
	 dmJaEVC0+F0fIpwXRzafp6jymBFwEh4W1SSh43Z6B6KEqozFsU+4I57xFjNtd5ZYYV
	 YE8DvfxBOY4jQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 039/244] wifi: rtw89: 885xb: reset IDMEM mode to prevent download firmware failure
Date: Wed, 25 Sep 2024 07:24:20 -0400
Message-ID: <20240925113641.1297102-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 80fb81bb46a57daedd5decbcc253ea48428a254e ]

For different firmware type, it could change IDMEM mode, so reset it to
default to avoid encountering error for RTL8851B/RTL8852B/RTL8852BT
if that kind of firmware was downloaded before.

    rtw89_8851be 0000:02:00.0: Firmware version 0.29.41.3, cmd version 0, type 5
    rtw89_8851be 0000:02:00.0: Firmware version 0.29.41.3, cmd version 0, type 3
    rtw89_8851be 0000:02:00.0: MAC has already powered on
    rtw89_8851be 0000:02:00.0: fw security fail
    rtw89_8851be 0000:02:00.0: download firmware fail
    rtw89_8851be 0000:02:00.0: [ERR]fwdl 0x1E0 = 0x62
    rtw89_8851be 0000:02:00.0: [ERR]fwdl 0x83F2 = 0x8
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f51c
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f524
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f51c
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f500
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f51c
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f53c
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f520
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f520
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f508
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f534
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f520
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f534
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f508
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f53c
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f524
    rtw89_8851be 0000:02:00.0: failed to setup chip information
    rtw89_8851be: probe of 0000:02:00.0 failed with error -16

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240724052626.12774-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e2399796aeb1e..297b1d98d2561 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3781,7 +3781,7 @@ static int rtw89_mac_enable_cpu_ax(struct rtw89_dev *rtwdev, u8 boot_reason,
 
 	rtw89_write32(rtwdev, R_AX_WCPU_FW_CTRL, val);
 
-	if (rtwdev->chip->chip_id == RTL8852B)
+	if (rtw89_is_rtl885xb(rtwdev))
 		rtw89_write32_mask(rtwdev, R_AX_SEC_CTRL,
 				   B_AX_SEC_IDMEM_SIZE_CONFIG_MASK, 0x2);
 
-- 
2.43.0


