Return-Path: <linux-wireless+bounces-22647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7362AAB54B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA2C1C04F71
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1BE498CC2;
	Tue,  6 May 2025 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPUXAn2l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B338284B55;
	Mon,  5 May 2025 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487058; cv=none; b=cZ0BD/eeyDmfiJCbCoFhM8uRW/bDoXwU8YtoIyslish+wUCMKbQga5bdLAwLxZL7wzJic9UtAnH4E6sEfVvLSi3EB6JfurvXqPnh2sMlQK6stgx2tL3KHV/S3oNc8DIkF8hOBag+EOxIkzghAKw/2SXt0C/+r7ucJ1OAjUH2wl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487058; c=relaxed/simple;
	bh=6+NLqhCF3Kjmx7Us5b5nviG4k0V+VsQpYeHE8wNxAtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VzergF8f/SZEvv6yaeXu9GTepV/4rbuobXiytrbRRBhlpnLPos2cGGWGlIv0eMFNagzlM8pJ1FZOh8nTTskvd2fC7Ka9DtGTB3rH2NrzTZO+KbHStQ1QyVl1nY1bOkgFuE/q6KBIRk//AVF0hvJorqsCXKh6I6GhrnXyrCqrOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPUXAn2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795D6C4CEE4;
	Mon,  5 May 2025 23:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487058;
	bh=6+NLqhCF3Kjmx7Us5b5nviG4k0V+VsQpYeHE8wNxAtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPUXAn2ltSQXyCpKRHKzy9RNvlAh+ZS+IGy+QXO9AwhxJvk9OWmc53DdNcIXsOmmk
	 UM3POD5jPXk4F54tFPNydS3mGG6l0TZ3GvkxALehN3EBFBsHViS9o+wlm4G82oDUgu
	 B0hTqfPWlrPUtx35BUIGpxp04zvxGcosxRqNl3A30R4wBBvmKiDCRpyZID9uFozYWc
	 rKTlp+bjJag1ftvDrj3Q0WlTaghBYbRoNAFGkTYA18V3YPn2L99fZBnHbTWE1fKk/4
	 LBfRZ0A3KpeIfCn10BQUUaGhQ3TN+A3WXmLXA9FyQA/XeKjFSGVofLHCfGhD9zVFrA
	 4jsGHpnlyaxmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 131/153] wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
Date: Mon,  5 May 2025 19:12:58 -0400
Message-Id: <20250505231320.2695319-131-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 9e8243025cc06abc975c876dffda052073207ab3 ]

After the firmware is uploaded, download_firmware_validate() checks some
bits in REG_MCUFW_CTRL to see if everything went okay. The
RTL8814AU power on sequence sets bits 13 and 12 to 2, which this
function does not expect, so it thinks the firmware upload failed.

Make download_firmware_validate() ignore bits 13 and 12.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/049d2887-22fc-47b7-9e59-62627cb525f8@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/reg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index c0fb1e446245f..3e5bd64bc09c0 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -107,6 +107,7 @@
 #define BIT_SHIFT_ROM_PGE	16
 #define BIT_FW_INIT_RDY		BIT(15)
 #define BIT_FW_DW_RDY		BIT(14)
+#define BIT_CPU_CLK_SEL		(BIT(12) | BIT(13))
 #define BIT_RPWM_TOGGLE		BIT(7)
 #define BIT_RAM_DL_SEL		BIT(7)	/* legacy only */
 #define BIT_DMEM_CHKSUM_OK	BIT(6)
@@ -124,7 +125,7 @@
 				 BIT_CHECK_SUM_OK)
 #define FW_READY_LEGACY		(BIT_MCUFWDL_RDY | BIT_FWDL_CHK_RPT |	       \
 				 BIT_WINTINI_RDY | BIT_RAM_DL_SEL)
-#define FW_READY_MASK		0xffff
+#define FW_READY_MASK		(0xffff & ~BIT_CPU_CLK_SEL)
 
 #define REG_MCU_TST_CFG		0x84
 #define VAL_FW_TRIGGER		0x1
-- 
2.39.5


