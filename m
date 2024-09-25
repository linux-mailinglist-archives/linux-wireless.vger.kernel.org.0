Return-Path: <linux-wireless+bounces-13157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F79858AB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CB61C236F3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522B119048D;
	Wed, 25 Sep 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgpoUBEl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C419048A;
	Wed, 25 Sep 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264276; cv=none; b=VCkPpyq4TjUlOV9vso7wtmxqvCmgKUGsbk5cKHdi8IJkPdePPX8U5L8CWbpVK4bsUZwfS5dtLgKHoC2BnFtyMR/NtP9wW9rykiDTjccMhPir7aAZMHnV1w0ePnhIJrZcR+Ebv+1QgvkcoE5gdpk0ZN2GwDdEshnUMMe1okcVEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264276; c=relaxed/simple;
	bh=XUvp1HTqSV48vWlFvmxSBx3xYUqsmfNhAH3JCFO2g7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arJUVvG/NkYxih9ku5Y0ReOTgXb8SnrweXn0TJKH+B8h2uJGG2yaI/IZWCCE13S+x/WMuh+5QzYrRP3H+e0FMGIWpmfH9sspif/r509eZBbcyiMbG1MFlO26h59q6Z70NmTjs15buhZ/WPjZUieJN8uiCFeMYYeUPbDu5sWgKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgpoUBEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3EDC4CEC3;
	Wed, 25 Sep 2024 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264275;
	bh=XUvp1HTqSV48vWlFvmxSBx3xYUqsmfNhAH3JCFO2g7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HgpoUBElhShrIWSlWpeUtu7/JrDHK/J8f1zF1HVPY3j2sO7n8gjZDwjXKAXnuHMLg
	 e0Go/doFZLnOGeylEyH21SMJ5+trX5sbtyMIelDOW9BDY4QDeLUuS4r9dOA2QiRqVf
	 QM+s9qAE0MzuyUIY1RwLrprpkn1yqlapJOamTTt0mzIBUuGIZpuowejvkMZjD0WzJF
	 WZgv5pbId1D3eXqkOYwlZeyemXqmFNlaDHnRk8on05BBHTaij5yqyw9a+cwycjW0Zx
	 sqZmu94io7C5kL0TPv+zsqlvcS7mtiaIrQHoiBzAQ8NrpeeeHSnH04KKtYhCqiHdfe
	 R8pEycZwjPrKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 035/244] wifi: rtw88: select WANT_DEV_COREDUMP
Date: Wed, 25 Sep 2024 07:24:16 -0400
Message-ID: <20240925113641.1297102-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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


