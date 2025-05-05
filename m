Return-Path: <linux-wireless+bounces-22599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377D2AAB02F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7B11B67BF1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5B53F216A;
	Mon,  5 May 2025 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X811aSzH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DACF3B63D6;
	Mon,  5 May 2025 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487283; cv=none; b=XVEOAnvX9AkjkSH0vtFTlBzbHYere1DJ+beJYI6hYtKXUpK434YoX+Xd6ic/hHbOUQH2TMHLHtD4feQtjm3QMCnqEIbXxlcuo+q9wtu5Vg6wPlmvydRAfXLPAkTt8aO6yC8/+MoUnMs6g1l5YqCrKQrZhJ3Z+0PAK5HgIK283oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487283; c=relaxed/simple;
	bh=v5TafSLJfjjrrWFmbdop66+wDPkUkPJh1rdsCCLnHN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUNQBKfgqnMkHK5znbPSVG1MHLOpxwSKm8Il1zFAv841N4irZzEpftxTdNkHsR6zrLUh9mV/41mz+nuTtVjqpK57eU8Iey/6XRgUUTZg2CdULAWcmXnS8rWMGc2DldfB1n/hYSygu1Qn06g5kAxQ2AGWxQj/3rrDn2PPirOmwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X811aSzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE12C4CEEF;
	Mon,  5 May 2025 23:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487281;
	bh=v5TafSLJfjjrrWFmbdop66+wDPkUkPJh1rdsCCLnHN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X811aSzHmrEKWLAsJqYI4OR3C+i3qjhrHjiYK1qVx6dD+defvfpY/CuZ+yqs53l5O
	 bqlhlV/ONkfNhodu5+5FPjU3gbb283lsn18BMQAc26cP0kjH4VHc94oGTzoRlfJAID
	 URzy9476iJQV2+pHU8ZbxN6zRZal2H3TejqpnzcvvaVwk0DqiCoJh2ssyYtge1RScm
	 4Q/XNHXv12kozvG9akxR1a7DhefHt58DLJgL7EmI7cqW69kYAjErbFBgxEDBFXQDsV
	 YzczevxxkjW5OeD6UAqSGAXoAJRRAeEx9V1BJV6QLyTG3pD/fK/4vLY6jlJ/Omi5CQ
	 bYP/JhmcuzlBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 097/114] wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
Date: Mon,  5 May 2025 19:18:00 -0400
Message-Id: <20250505231817.2697367-97-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 9088bfb2a3157..27de6eeb4ad68 100644
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


