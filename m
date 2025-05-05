Return-Path: <linux-wireless+bounces-22585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB6DAAAC44
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882AC1B616D9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6809E3C275B;
	Mon,  5 May 2025 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riUc3N6X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA63389400;
	Mon,  5 May 2025 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486749; cv=none; b=Ucb1tvhA8wegEBRJJZM+s3AIUE3cmF3hZAsWcGMTdnW9xBNFaZjbEPY25B4GCGYLMLkstYBq/jJeU+0NKGVmM/NInMaB7hmfMVl2cZDYT73Nwt0ZwAX0xk3ZWItUkLLzHyOFButHtswqeWtJitX5X7lBA3smgPA8wuXtIsYUio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486749; c=relaxed/simple;
	bh=1EQ712AySPnJkTL3mTXCGfJDjF8LamyyXTEXoCwF+Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMwhUWP6V1CBNVgPZEZlQtHWifu/4njpUnyy+IXzV6DDoOFsmX+YEVgCXyLPpHTi/RiXw7JAfH3lqzJRl0uzbvwfwffnCSLuHdQ0CNyOlWMP/MUJW3XMh1kQofwqhi2Tk46FvlWTc/cBDO06SVB/cTHLyf/fAaRLOMZ5foUD+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riUc3N6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B500FC4CEE4;
	Mon,  5 May 2025 23:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486748;
	bh=1EQ712AySPnJkTL3mTXCGfJDjF8LamyyXTEXoCwF+Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=riUc3N6XRl41RI5Q3G/7iwwDPFEdmWzz7d7W1ddoUat+JnIHOlSpBdHOQIfh10IIX
	 RC2cClHy5zjdBzHUWBc8wbrAdmHI3VdBNVAqlFFaEEBmMSid/W6JwT2hefCegD3Z45
	 hH8blTrWvrVmXdjcP56B7/Ao5gIX12MkUR99YI5d/oQV/nNAZSUIGDgrnMwcWCPmxd
	 6a9pahiWe6w+45vUplp27j/QOm8HB+eQIWvVIbNAyktIzqeQyhq/LChA5W5qqvPvGz
	 G4RVpELqRqDOcKFMVH+VQor7aS9vkxyUUEhs78f6sAxMXX+P3Y/SluvW3JXE2C0ZX7
	 2DRBFB1CE4F2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 182/212] wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
Date: Mon,  5 May 2025 19:05:54 -0400
Message-Id: <20250505230624.2692522-182-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 03bd8dc53f72a..08628ba3419da 100644
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


