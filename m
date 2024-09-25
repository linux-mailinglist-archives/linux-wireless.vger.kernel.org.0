Return-Path: <linux-wireless+bounces-13179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D451F985C9B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 14:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D6DB24C9B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA721CF7D9;
	Wed, 25 Sep 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJJJDcb6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0747B1CF7AC;
	Wed, 25 Sep 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265576; cv=none; b=g9xvI7R3BTau0uTXbbxabcHiFofo1cv2+sskz2cquSuvrCTCna5oFkpTHxqHaDKI2EOMAheCLXA0r3zpW2Jqb202L4NLlDPBMevyZ/rLO7zDPKUSZ+pFHFKl/Oa8RN3Nw4TSQAFmYmzxDJOvXBW8B7B/N1oW3SgGR7urRiJSYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265576; c=relaxed/simple;
	bh=XUvp1HTqSV48vWlFvmxSBx3xYUqsmfNhAH3JCFO2g7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1D5B2HcQYPNNjq++qfC/cPzM/OFmJI3T+TbDSz48DrTfgNN0K0eerzf4ZqI93Mr0DNt/fbt9rRpHGOVFQ7pxMgj3H5xEq7oD9RgXA+9EXPGQQrlcwRc9Tb7ZiXG5sEaQcdjLQcV61MlP4uVBa2XCQVRBAHGdT2WPreUq5O7tZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJJJDcb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F53C4CECF;
	Wed, 25 Sep 2024 11:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265575;
	bh=XUvp1HTqSV48vWlFvmxSBx3xYUqsmfNhAH3JCFO2g7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJJJDcb6FihDnBJ/hZAZUiP1BSbWsfTG/tQkd8emljfMwRhiAeWDLkkq+sdHCsu/7
	 XQq4epewqnMiQEqSRlZEupXURiulBgZf2BTCtvWRwzJRgvfDSaUb/xzo0GsH78ccX4
	 qovd+gum3Z0popQ/5ZLQ0VurrkbTCPKNyPY9RnhDBPJLtp412k8T5QAOWIxjyUNiCW
	 zRetUTQwbUa5DEwh1TvEE5z2QCvIx23Bl1+MGxgSNzLIKx+8hYzrgNURIHVtjcBv1d
	 lb2uOrSdvwGV1TkdZkQMhskAq4OM9c0Ggi0ueZaDpOcOAUpMJGihMOrVnw3NltB+O0
	 ysZ8EG0jLB9lw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 031/197] wifi: rtw88: select WANT_DEV_COREDUMP
Date: Wed, 25 Sep 2024 07:50:50 -0400
Message-ID: <20240925115823.1303019-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit 7e989b0c1e33210c07340bf5228aa83ea52515b5 ]

We have invoked device coredump when fw crash.
Should select WANT_DEV_COREDUMP by ourselves.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240718070616.42217-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 22838ede03cd8..02b0d698413be 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -12,6 +12,7 @@ if RTW88
 
 config RTW88_CORE
 	tristate
+	select WANT_DEV_COREDUMP
 
 config RTW88_PCI
 	tristate
-- 
2.43.0


