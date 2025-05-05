Return-Path: <linux-wireless+bounces-22613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C70BAAB0F7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920F31BC115D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64643330AB2;
	Tue,  6 May 2025 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlvnO/at"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDCD2D611A;
	Mon,  5 May 2025 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485360; cv=none; b=X9MznBHbIc8JU7bpwM2XEAoTEW1PlWWXxCfzFvOoPFPAKraMfqjqwY7jgt8QRUTLdJCyB1Tj5mo19YVVbzY7GY4Tr3Nadl5qwXdw5PaZcYSjRtvp2kPihKU9SWgDQZJvKq6X660PjkolGtZcfVZ53zny3fMwEgFXTv1toITpj2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485360; c=relaxed/simple;
	bh=HMZ3nO+106jsaZjEMJfbMC5DpoWEGIDhOs2S9vaJRT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gaYkmgJJdz7GwgQOJshjbDDnke6LsfhH2HQzrlcV+B2VDiCLiABxZUwPhCax5/n6yewuqcRTmw0eUUryNXg9zyoM5Cv2fPQerIZqT7PppId93zO8Qxzoxo761PPQxY1l2wNazdLeRiv9fxsCW01yzH70LqEQMjQsdlhIoy6XZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlvnO/at; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD50C4CEE4;
	Mon,  5 May 2025 22:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485359;
	bh=HMZ3nO+106jsaZjEMJfbMC5DpoWEGIDhOs2S9vaJRT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlvnO/atiCGK0xgrEY/wuf9yOhJZTKj6E7ousUHfBRYbycoLzfc4W9QmemXJU3Md4
	 cxZ+487E1zIRk//nngExc07XzvT3AQwhr+jL+54Yapc77cIMVzIVaq4qHjGTR3i/th
	 h9/7C2Z30Zz++2CCyDGzOr5VqkXux88scBpnz9UTBsWBHibHZ0M8KKxHbLyntlwxNb
	 8aAhr3b0k/vdVhJMw7Ioc8Bs4F5zcvO++Ik6UaTPN/EmTA3yjSVNLutQjdncCpclzz
	 b/UmlrwPv6kr2L5+bkf+56DLeqsMzB9yISbl94Vv7r9OZ9jvgcbqNBJ14ma3dKUdmz
	 Ofj4zJtqubqPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 287/486] wifi: rtw89: fw: propagate error code from rtw89_h2c_tx()
Date: Mon,  5 May 2025 18:36:03 -0400
Message-Id: <20250505223922.2682012-287-sashal@kernel.org>
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
index 620e076d1b597..9d26502a2885a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1234,7 +1234,6 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev,
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
-		ret = -1;
 		goto fail;
 	}
 
@@ -1311,7 +1310,6 @@ static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 		ret = rtw89_h2c_tx(rtwdev, skb, true);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to send h2c\n");
-			ret = -1;
 			goto fail;
 		}
 
-- 
2.39.5


