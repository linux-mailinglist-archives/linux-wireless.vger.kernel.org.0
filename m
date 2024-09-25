Return-Path: <linux-wireless+bounces-13198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92119985ED5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 15:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59348B24ABB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDC11D09E9;
	Wed, 25 Sep 2024 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxUKbAaD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F11D09E4;
	Wed, 25 Sep 2024 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266362; cv=none; b=FjkjeRxlIUBN6AykPm+xGBx+9EXWuZznVrRHjDcksoCOBF78DbztZfZzt+y3fI6jkluo4CB5HoAKdWbAHEC5GwhesM9X8EppGchUDqfeGOroL5f96858t4cbANcCbYL7ZI1EmTp+7kYT8HVgQt3+gVNQi358E117jMF2gmD3tGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266362; c=relaxed/simple;
	bh=XFpw46RUvANMMrGpwjQBMRik2aSTMy6PCzyMXd9vjD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFRXVXriRVcNfuW8aMoKSQJUegnOxvX05YdmUDD8fCKO4+ULe4RhLW9LY5XaoTjIfhjNHqLgXElq2Vfy2TBpdbe+br9JvFZxXn9A61eW+kRDwfiQgxs2nXzPkn9jcNIQFMdP8Pp1UCRJjrtNGV2xvDkhZz20AqChJLDVqYIiwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxUKbAaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3B1C4CEC3;
	Wed, 25 Sep 2024 12:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266361;
	bh=XFpw46RUvANMMrGpwjQBMRik2aSTMy6PCzyMXd9vjD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxUKbAaDCGTlbiyUuZuuBUxgtdxi5HmisAuUKJY8967w3Y+UzdryTJldOd5ptWAEm
	 WHq0tsYV07tVtBGiTj6+GfB4s4xJv0+44DVwojbzHXqtFEg8iW8fUimgYD00HarGQD
	 ON8PA1dRjbYtNksM9EjcNzLGBT7KaGcG+R9dXkqsf1ISh6/j0dYtK8mmHk5QVMrrEN
	 HFVcWUbzu7pub98xj9ddsUcMTvKwVMfg72izQZMcDo55Y9E8BcKsp39wTuHL8Tvx1S
	 UaxcBXqtKn3F/KhVaz3n6rza9X0Psy9G/UNvINdiLdFFYDYuNHTL7zTzYBKqy5qFXW
	 h0wNzBavaH6bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 029/139] wifi: rtw88: select WANT_DEV_COREDUMP
Date: Wed, 25 Sep 2024 08:07:29 -0400
Message-ID: <20240925121137.1307574-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index cffad1c012499..2af2bc613458d 100644
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


