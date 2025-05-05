Return-Path: <linux-wireless+bounces-22514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2C2AAA521
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CF37A3FD0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 23:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254D230CC07;
	Mon,  5 May 2025 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q58Jj07g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018130CC01;
	Mon,  5 May 2025 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484140; cv=none; b=GfF0zpZV0UVoM/AC3qBOOngOK16gQU8BOctMZSTtGn8Hr0i3tNN+xGae3inivUvU/2P+vL5JNv39eECoYC1Nyb6hEGw5H2+u3wVUgxmNi3MjTROz3RiNuaYKHt5r9EZqsyM/MaSxHtmwUhQDk4iezXBNEzudnZSwCuPlZcHUWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484140; c=relaxed/simple;
	bh=UH8ZABIqaBiwVgJgu03o+gMkuv97GHKtMKpCwTPPHdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+HGABho33l8w+1mhHkN2Flj8Okl6ckNS4TZgGccVB36As6s9dseZLtw3IydLvD2TsAGu5locp9ePVFm4QHCbrAQFTpi4za+O+f5rvVBlEEaIPK+b+psjXzXEkXDdOKLQ3l9+gPgiQOdtXYCG0LXruXQ/s60YzmWNelWHwEl+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q58Jj07g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C970EC4CEED;
	Mon,  5 May 2025 22:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484139;
	bh=UH8ZABIqaBiwVgJgu03o+gMkuv97GHKtMKpCwTPPHdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q58Jj07gOBPck4rm2EZzwwoG4LFRu1RWVo2Hf+htWDvKj8j12CZqfLrW6QBpNxVQ7
	 bex0AbAYfif/fkV/UgN+w2Iw45wBq53lpl2Pqm4ITv1bQnlemttpoUKc8hYtCFZ4KO
	 Flx+xabZGv/LqT/ROI1jWsXIYJRkOFlYeKzOlrzNNTWy7IuxiCNRDX3fwIw1pbOhK5
	 bYv8QQUGJXQT6VCDROFR1fZUAs+dV+vQOe43hyTtIr4OId6Ik13YYpbj3/FX2oadhS
	 Da/y3ctWSTnfwhrP3FrEXWsJUJ9zJVswqBhPLI2q9MlhrFNfnOXVVoIYUZTXZ6dExA
	 Ha0PXwvKH2TrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 369/642] wifi: rtw89: fw: get sb_sel_ver via get_unaligned_le32()
Date: Mon,  5 May 2025 18:09:45 -0400
Message-Id: <20250505221419.2672473-369-sashal@kernel.org>
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

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 2f9da853f4d848d23bade4c22931ea0f5a011674 ]

The sb_sel_ver is selection version for secure boot recorded in firmware
binary data, and its size is 4 and offset is 58 (not natural alignment).
Use get_unaligned_le32() to get this value safely. Find this by reviewing.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250217064308.43559-3-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4727eeb55b486..3164ff69803a1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -314,7 +314,7 @@ static int __parse_formatted_mssc(struct rtw89_dev *rtwdev,
 	if (!sec->secure_boot)
 		goto out;
 
-	sb_sel_ver = le32_to_cpu(section_content->sb_sel_ver.v);
+	sb_sel_ver = get_unaligned_le32(&section_content->sb_sel_ver.v);
 	if (sb_sel_ver && sb_sel_ver != sec->sb_sel_mgn)
 		goto ignore;
 
-- 
2.39.5


