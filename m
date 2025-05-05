Return-Path: <linux-wireless+bounces-22612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6C1AAB129
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9743F3A305E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A4330AA7;
	Tue,  6 May 2025 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtC5zoat"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08CD2D611D;
	Mon,  5 May 2025 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485361; cv=none; b=MnD/KzflHxCIE+gqTPoSVx8T4O2g8ZRJ+AX08xsxJ9uYeCxipn2DSHVi0BrmixPrslGapPUgaverN4JvxW51X1xH8f2qk8aJ4W3tZoIqJwXIaaAxo8OchWWq2QbReeuqO8xN0Spf57CIqVua1WYCbChaCnZlRoDzNiQ4ZrukbGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485361; c=relaxed/simple;
	bh=9oRd9mrW1VwUKoyg2Pnljh1nQ71LBCVypmmvGOkODSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFQmJKp3SbuB4onTTRq4xdUbGI1bgp96m4NFvQcOGwi8YNzC8G928liRnNC8DpeZxFkV2nW/P84ltojj4kPc7QTSGtG/k/572y1+kGayCElI6E/tNy52UDBnIChQ2uTksKd2ivoveiEzLdAbWJe+OL6cx6XcWhEcc/sezOgk0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtC5zoat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02AEC4CEF1;
	Mon,  5 May 2025 22:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485360;
	bh=9oRd9mrW1VwUKoyg2Pnljh1nQ71LBCVypmmvGOkODSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtC5zoatYp4CYhIcAGVO9ycEFFk5QJuiX5f1bSo4ttRRmLdIy0K4tHieZ0cSN0o1A
	 Lch7Nj0ilcXvEUd+nK+U6RYndMCMzbpBpHcGunbY4MRMAYn1ATKeIiVVXByUttu060
	 fQSpz+aU3NfoLIVow8Na2InZWAYklDT9zJkBfqy8PqHFXlFZ+qnbgvtZpNnp7TmmDT
	 nh8vMtywBSZJanX8X4GUkAbeIJ5jvlQKZb9h22ozpWsc6NDEufHpjDFNg1wMzgTKiu
	 h4ASkgwtl5YAsiOjSEnbqd/ozEJzsy/naW7ibzqS5BpgUhVSkzVA+qLSD4o2hFUUBs
	 +GLCgFvb/t+2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 288/486] wifi: rtw89: fw: get sb_sel_ver via get_unaligned_le32()
Date: Mon,  5 May 2025 18:36:04 -0400
Message-Id: <20250505223922.2682012-288-sashal@kernel.org>
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
index 9d26502a2885a..f0e87af68d8cb 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -285,7 +285,7 @@ static int __parse_formatted_mssc(struct rtw89_dev *rtwdev,
 	if (!sec->secure_boot)
 		goto out;
 
-	sb_sel_ver = le32_to_cpu(section_content->sb_sel_ver.v);
+	sb_sel_ver = get_unaligned_le32(&section_content->sb_sel_ver.v);
 	if (sb_sel_ver && sb_sel_ver != sec->sb_sel_mgn)
 		goto ignore;
 
-- 
2.39.5


