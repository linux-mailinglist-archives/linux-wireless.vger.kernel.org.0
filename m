Return-Path: <linux-wireless+bounces-22575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35464AAAAFA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB94D7A7A57
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64EB2F54BC;
	Mon,  5 May 2025 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FB6onXyA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651D37A8BE;
	Mon,  5 May 2025 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486152; cv=none; b=YOtgYhptefRJ6OCbQR93gfQE5F163AO20gUNw8MG0QKtrIsBHIQ1POR/D/AgPZ0iAK5Mc3QWuWAS9W29pHEUYfg1FUSlu65VjOfOt7JlAzLukV0wCrI1+fWxMPvE7BJ7wuZpULf+7hHd65Z1aJvwWjXTylEgcHW9obP2gkOjtb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486152; c=relaxed/simple;
	bh=Ek2yXqEcPOO5vIme0d19P+yp0bbbfmyrXBbXy5lriEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UObCYXueORENFHmDUVlmuvVnNaD9hmCfW2XOimdNd5wzCB3HNjQIONGOFyW9W2+ys/HdazSIsWjGNvw/fpZirogeYYuUdPqMgx5eJtw6Vf/s4poWrAOj3kFPzuf0KkvvOiNmIbomx348wl7CdUvO5MkUftRGT1tWJJEgbNWkej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FB6onXyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD11C4CEEF;
	Mon,  5 May 2025 23:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486152;
	bh=Ek2yXqEcPOO5vIme0d19P+yp0bbbfmyrXBbXy5lriEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FB6onXyApUQ42zC91LItU4EEJbeqf2NF4MB2FC7GXMYKAOkm0YqZWF7BCdmDvpRAC
	 wUYSepzsFq33HwQO94PeOUiYJBOJeApSbKFkC4xkuu/RKiMNuYto09DGz80tAmGw18
	 TErZiVb/Njc8hZ8XMDVCVusYfMtYSaaiU1akGAD7PONFlEP+wyJbNBAQ9obaoY4Vs5
	 Lqg6181f7mJEd7WEccHW6y2GBQ+dEfzU8GderQN6nRUnVqqb7iXlFZP3O/I+bGJeZo
	 bFhf4oNnZAihOTNn/VlrRmn2yGQVn2IuZ8NtOtjunyHibwC5M44zWShXyCv2Va+xZx
	 GeU0xUWrGeRtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 180/294] wifi: rtw89: fw: propagate error code from rtw89_h2c_tx()
Date: Mon,  5 May 2025 18:54:40 -0400
Message-Id: <20250505225634.2688578-180-sashal@kernel.org>
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
index a8e2efae6e526..89b0a7970508e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -755,7 +755,6 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 l
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
-		ret = -1;
 		goto fail;
 	}
 
@@ -816,7 +815,6 @@ static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 		ret = rtw89_h2c_tx(rtwdev, skb, true);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to send h2c\n");
-			ret = -1;
 			goto fail;
 		}
 
-- 
2.39.5


