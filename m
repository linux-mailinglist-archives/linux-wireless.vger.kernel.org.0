Return-Path: <linux-wireless+bounces-22622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1EDAAB1F8
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7726E17BCF0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770952D3F85;
	Tue,  6 May 2025 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy5Iylk9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC12D47D7;
	Mon,  5 May 2025 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485650; cv=none; b=DiCX5nnajH6ocbx0M1JAMnU0rXvDB36yncliOzyeokqYKJ2k6iKESLcAWbcotKw4xNKu5b9icD+3y5XmgJ10VmOIzbMl8nwQShRBw1tYVkv07SVLD7A2WXjmwGr6yY8rDvHr+1heIj7JNC5btogwh64Tj4a4BkAdmA5XRLr1Rmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485650; c=relaxed/simple;
	bh=Wn8dJ/NGPoYlqMdnq5WorX0rvhxUqTVEwYyOUf3in3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QP06pq5KwRGvS2v9LwmC2WfDVz9pvG/H2TjfZn0pVl9Lo3Naths1s6SsITIKHAKPNLJrTiBW2EMNBU8JMkFeGNBSr8N/nkJ2FfkMNpu8we+qvOx3f2OcLjQbI+LlT0MZZ1+VXmargqZFrpkWqm7D9xqJNJUf73XNq1dB4FT1FEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy5Iylk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F95EC4CEED;
	Mon,  5 May 2025 22:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485649;
	bh=Wn8dJ/NGPoYlqMdnq5WorX0rvhxUqTVEwYyOUf3in3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zy5Iylk966Dh/3u9CZItFKkxQiQShTglzifDT9QFhDBnR/wGEQaQ7ibmPvPGpjpnX
	 wl2jp0q5ED0+mqfbdJ5IXIQT+WI45Ka5nfrT1wi9KiODoonReNOGN22el9iI4fTHof
	 A7q+E3OOTVlxNPqE3sLUdtU5DaCtv9YXQJR3TDUygK4SImj63WXQvmH7p3zhJ2YZbF
	 jU36K4YIOygpTA4BTf7S+R1Ed2mlLx6bwFhYVAR5X8UXUmPuo1th8/yn8C+VLEyv+X
	 8K5u98ZSAmFGBbODBvYNhxI5vfY8MRESC8oK1rW30DxrWbPLlgt5lw2jLhvaCy7mpQ
	 lMLLWa3ve17jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 405/486] wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
Date: Mon,  5 May 2025 18:38:01 -0400
Message-Id: <20250505223922.2682012-405-sashal@kernel.org>
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
index 4d9b8668e8b04..2708ee2f12a47 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -109,6 +109,7 @@
 #define BIT_SHIFT_ROM_PGE	16
 #define BIT_FW_INIT_RDY		BIT(15)
 #define BIT_FW_DW_RDY		BIT(14)
+#define BIT_CPU_CLK_SEL		(BIT(12) | BIT(13))
 #define BIT_RPWM_TOGGLE		BIT(7)
 #define BIT_RAM_DL_SEL		BIT(7)	/* legacy only */
 #define BIT_DMEM_CHKSUM_OK	BIT(6)
@@ -126,7 +127,7 @@
 				 BIT_CHECK_SUM_OK)
 #define FW_READY_LEGACY		(BIT_MCUFWDL_RDY | BIT_FWDL_CHK_RPT |	       \
 				 BIT_WINTINI_RDY | BIT_RAM_DL_SEL)
-#define FW_READY_MASK		0xffff
+#define FW_READY_MASK		(0xffff & ~BIT_CPU_CLK_SEL)
 
 #define REG_MCU_TST_CFG		0x84
 #define VAL_FW_TRIGGER		0x1
-- 
2.39.5


