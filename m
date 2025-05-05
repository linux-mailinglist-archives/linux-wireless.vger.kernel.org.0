Return-Path: <linux-wireless+bounces-22513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CB4AAA542
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535F2188CC0F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 23:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58F62868B6;
	Mon,  5 May 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3rqcI1x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4112868AE;
	Mon,  5 May 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484138; cv=none; b=Avu7J70DiitMKC0AXgiGACM9LzDGn4aHwA2I2u4ZtuAQjGd8CkMqnTMlbvKu1P0SsOJKqr7nOPMlD62nQK9NAT/6PpAPOc7JukGhEoS0rF8oEa+2rkPJbBHvv7I4ZhA8I+1JV5rKPc/qb/CiWZVTiQAAhjHVHioAxNxPsGZTqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484138; c=relaxed/simple;
	bh=M9perzCJeduGSWITNUpvAch4kzTyB48NgLkNOHS/g14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F1Rn5+U0/AN0i/apkJWi6PCJvBnnTINAQ0k6fUAN9UV4QofS5AbKi4qFP4IWFtmOgZzeYzKeuN8ZV3Bev61HeL/BpptDizV6G4IjYJhUKzaozQ34j0kUvfXNPXAAEOzAGyOlB3UZBt8Ls/GYgj2Pfs7XHAfRo5/K9fTgcLwJYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3rqcI1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF94C4CEEF;
	Mon,  5 May 2025 22:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484138;
	bh=M9perzCJeduGSWITNUpvAch4kzTyB48NgLkNOHS/g14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3rqcI1xb4SeT4zSCNHRoleKTf4/+XGilukk/a9JZokz5Y0SWUaK/vLNsOpBAXrBJ
	 goT4Q5yrixNcuR1BQba2Vhd7j9S9We93Kfcgd8LelTpJBiQ2tepJO6xfJxt3XWg2IA
	 LJxpB3P9hdaxn3qYNpGpG42RxZ8zOPNG7W62v1m22K+BWlKWPaFgHOtZ4/k5GQ87Zd
	 BKbdCAIOxcuYUT4F6E7FD3jzCbhZCyrJytq00ae9VbPLwNKMQWTnR9FhK/4Q1TTs2G
	 oK1jYHufU+l64Eke+0kXZsLgtDfDK/6FZWMi5EWc+8sW2N42HF0pXmWImifx+p5ejq
	 6QN++ObXKdCkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 368/642] wifi: rtw89: fw: propagate error code from rtw89_h2c_tx()
Date: Mon,  5 May 2025 18:09:44 -0400
Message-Id: <20250505221419.2672473-368-sashal@kernel.org>
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

[ Upstream commit 56e1acaa0f80620b8e2c3410db35b4b975782b0a ]

The error code should be propagated to callers during downloading firmware
header and body. Remove unnecessary assignment of -1.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250217064308.43559-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2f3869c700696..4727eeb55b486 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1322,7 +1322,6 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev,
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
-		ret = -1;
 		goto fail;
 	}
 
@@ -1409,7 +1408,6 @@ static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 		ret = rtw89_h2c_tx(rtwdev, skb, true);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to send h2c\n");
-			ret = -1;
 			goto fail;
 		}
 
-- 
2.39.5


