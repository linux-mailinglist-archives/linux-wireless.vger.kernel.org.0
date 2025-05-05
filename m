Return-Path: <linux-wireless+bounces-22641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C13AAB46D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6341F3A485F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20823477997;
	Tue,  6 May 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d215BN0I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACD12EEBF9;
	Mon,  5 May 2025 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486654; cv=none; b=ddRwvS+jjnz+G1H0Y5uKbR9lK591hFrlXdZGhUROiHd1lxBDFxNr1BvB09V6W3ySccvg0JGtKYz5B4V9W3ZCJ/N2lDpxMM2Sha9WzovrJ1252FB/ag9CbCYN47t/wauLPectAbqf/taZQmGhYQh7UTuK3ba4xsXtxCWfX545q/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486654; c=relaxed/simple;
	bh=TYh/0K8l5itOK887KQGJmTaJDIL0FULokbgPttmwIdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZjLNm5PlylJtZGCIZvojP6dHOyAVC4O9llJwwEe8/WFcYtfUEWa7w3VNYOvqSpOgCU7ajiwwrhG6IdRIrXpD3Mqn7SmjGWXk/ULarphvPRe+eHMSXC5sWxknGVjRIAymWfcu8+JWV2SuEEK+L2mTFLDr4SxqgMt09jeHc7N2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d215BN0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4343C4CEE4;
	Mon,  5 May 2025 23:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486654;
	bh=TYh/0K8l5itOK887KQGJmTaJDIL0FULokbgPttmwIdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d215BN0ITJDsoVifjkJc2ZZrGlftw28wqXDzbE5JoAaDfg36RS1rK2MzEfJZZ0wKu
	 dqK3ERwuV7fEodNQcPYaMxhDY4ZK6vO/jaCbRPrUY3J1Cb8j+318VzEeirGrtvrCfR
	 HFUaQdzw2rpK7YA1DDOy5UReG+QhH0QclEEhYgw8i5dDLwAqfbg50eC2SBdjCyN6fE
	 pYsAx6HkIake3hV0gAkpD37ir5KyqmaqhwM8PpYwykGJ3yuAWjAoyVqd9HAOaktGa+
	 fT4Jrtl5ySJi/ZIChN0PUAsylR1I29N4KEkk3VV4j9li1WTgOZeAZAcvadDil13z/R
	 q+/pioPjitiNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 139/212] wifi: rtw89: fw: propagate error code from rtw89_h2c_tx()
Date: Mon,  5 May 2025 19:05:11 -0400
Message-Id: <20250505230624.2692522-139-sashal@kernel.org>
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
index 1d57a8c5e97df..0f022a5192ac6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -373,7 +373,6 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 l
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
-		ret = -1;
 		goto fail;
 	}
 
@@ -434,7 +433,6 @@ static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 		ret = rtw89_h2c_tx(rtwdev, skb, true);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to send h2c\n");
-			ret = -1;
 			goto fail;
 		}
 
-- 
2.39.5


