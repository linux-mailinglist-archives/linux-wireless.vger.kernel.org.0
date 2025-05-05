Return-Path: <linux-wireless+bounces-22636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F045BAAB370
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FF73A47DD
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF952376EB;
	Tue,  6 May 2025 00:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YANSsYWx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2FF28851A;
	Mon,  5 May 2025 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486304; cv=none; b=ng6ZRZCDvt+hn042nMDRFeVRMjGtOtYzrmPbn7TfMfkX+IPZzby6Xy166vndpd+gRKQxiU/dLlJ/Ia3dJjIwhrrwIffprJWRlIF0YEw06QkszwWUjoWVMeSAh4YKI7RzIv/kZYcw1TvWFX4RQvoCHSjYJzJVJhb5g5gLyKnpbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486304; c=relaxed/simple;
	bh=B9tOZS/ox7jmTR6yugzjfNVVHlOv4OVJ2ggf44z3mFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fk4MVE2DD7gziSKcDNt6SzOqBZQlYWpPSjgMLPVgB4rcsUI+NarNojjCbgNTQX801llmTYeud6o2yn+0Vlj15cNkkYqp/umGMe6zn3cIYGEELBm3iU+x3OnIgMg7lgVb/7OyC5y1xKM+Y+lvTWLYtOavZbPzLv5bL6dkdmTVt2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YANSsYWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D47CC4CEE4;
	Mon,  5 May 2025 23:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486303;
	bh=B9tOZS/ox7jmTR6yugzjfNVVHlOv4OVJ2ggf44z3mFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YANSsYWxAtrkYCsvR4+qahilZ1X81abErWDSwG98+mXL1BjqMEf4Kw9uOf0bYxhK6
	 W2YMk4stKf/I13z8uq6TjwBiKCqYH9UvyuCKvUnooldPziof+9+vcw6T4I0utS1QnQ
	 bC7WKcx2lUFvukLAvtrMlNxZbw8rc9ipttMDVRjaaCNoFg1EKosWKLLsTQk6FKJB0/
	 k7W/YhalMOXtmIid+BlzAT2Fq1mJCnvpUJV6x0THTXJZEtSU8v/tZNAtsVxSR/XBCp
	 Y2FpAvX22VHAWrHENc/zN5XMVoy2vBDD1/Nn1W0entvQDznzOTHProJ8XJoZ/mF9EE
	 9V8HXITYiVDOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 248/294] wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
Date: Mon,  5 May 2025 18:55:48 -0400
Message-Id: <20250505225634.2688578-248-sashal@kernel.org>
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
index 7c6c11d50ff30..0e76bc07bddef 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -108,6 +108,7 @@
 #define BIT_SHIFT_ROM_PGE	16
 #define BIT_FW_INIT_RDY		BIT(15)
 #define BIT_FW_DW_RDY		BIT(14)
+#define BIT_CPU_CLK_SEL		(BIT(12) | BIT(13))
 #define BIT_RPWM_TOGGLE		BIT(7)
 #define BIT_RAM_DL_SEL		BIT(7)	/* legacy only */
 #define BIT_DMEM_CHKSUM_OK	BIT(6)
@@ -125,7 +126,7 @@
 				 BIT_CHECK_SUM_OK)
 #define FW_READY_LEGACY		(BIT_MCUFWDL_RDY | BIT_FWDL_CHK_RPT |	       \
 				 BIT_WINTINI_RDY | BIT_RAM_DL_SEL)
-#define FW_READY_MASK		0xffff
+#define FW_READY_MASK		(0xffff & ~BIT_CPU_CLK_SEL)
 
 #define REG_MCU_TST_CFG		0x84
 #define VAL_FW_TRIGGER		0x1
-- 
2.39.5


