Return-Path: <linux-wireless+bounces-22095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C795A9D822
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 08:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98D61BC568C
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 06:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A44193402;
	Sat, 26 Apr 2025 06:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUJE9DtM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179C62F56;
	Sat, 26 Apr 2025 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647781; cv=none; b=BZcrP2SZtHkTMsJPdFoQS5GEyWqkW9ttjppQIxzSsZ3No/fy5jeRhB4fAE3zu8eKnIB7isKt5RZHTOeCALpnYpapMcdDezBqx4T5FwfpIpzbU9qsRemJUB1pYPGGtWD9sa1uKv6APuKa1V1uGn2tlO/XoJht/K/6ABKySB8eQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647781; c=relaxed/simple;
	bh=4TMaCYRtXdLs2mtxZ3wa8KEQeMZjc4VukWX9LxoX40Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lEb0I4NDBXwkRKOYjCLTwwtMLyWPc7l+mrCSSuouiHA1Sz51x/pXWdoPZqlhOWksRAcfxKfID79UdeZgEt/msxZtjN8Mly6dJKdnlUkyvfSfRFKgOtie7ZnttjLqRy9P49tiW3bJhqXz8jWjl3C14hhQkYLXwcKtT/qBfkoVqjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUJE9DtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896A4C4CEE2;
	Sat, 26 Apr 2025 06:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745647780;
	bh=4TMaCYRtXdLs2mtxZ3wa8KEQeMZjc4VukWX9LxoX40Y=;
	h=From:To:Cc:Subject:Date:From;
	b=AUJE9DtMjRABgBccdSJ3AEIQzTlsolUXOqM/rIxmKwXWdcs/A8m/Gma7VL4TYQ5OH
	 IbXplzIAoWFTKq/6ZGu0j2KmePOf/vKHdc04Y2r6R1rA05A4jETMj27tiyBhaBOXVA
	 DNf29iLEP2gw/z9NjnTDAiLZBAlNsqyclLnRPOJfjl3HSLFtNkc80A+gqLLc+QTuth
	 EP3QwDigRz/xk7Zqu08ZeZLEPLizyUEh4Tx4voy+MYhBSmrBI3B3G6u7Hr5lSYFNPi
	 J45bycISURg0zJalL3cESk+EZG+xLWz/GqLV+UDYsE02YlNNOD87zWe+FCRvAH/Xcc
	 50bAM9eEbyaNQ==
From: Kees Cook <kees@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: rtw89: fw: Remove "const" on allocation type
Date: Fri, 25 Apr 2025 23:09:36 -0700
Message-Id: <20250426060935.work.049-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; i=kees@kernel.org; h=from:subject:message-id; bh=4TMaCYRtXdLs2mtxZ3wa8KEQeMZjc4VukWX9LxoX40Y=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8FQt2balQfeHfvvGP5r6PRj+5HsYKOa5++an3sex7r cfL6+drdZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEwkpI2R4fJCwbPLSzS65zrd kQ27PPFb/OpGlVy2RLmzDHPkK5ccEWFkmC5WILPD5uvbdf3n9kxl9DHc/i1+asUyecHbsXO+84d +YQMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct rtw89_reg2_def *" but the returned type,
while technically matching, will be const qualified. As there isn't a
general way to discard "const" qualifiers, adjust the returned type to
match the assigned type. No change in allocation size results.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8643b17866f8..3836813c50e9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1018,7 +1018,7 @@ int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
 	}
 
 	n_regs = le32_to_cpu(elm->size) / sizeof(tbl->regs[0]);
-	regs = kcalloc(n_regs, sizeof(tbl->regs[0]), GFP_KERNEL);
+	regs = kcalloc(n_regs, sizeof(*regs), GFP_KERNEL);
 	if (!regs)
 		goto out;
 
-- 
2.34.1


