Return-Path: <linux-wireless+bounces-17317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B77A08FD8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 12:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CBE160F44
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46AD20766F;
	Fri, 10 Jan 2025 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="WKhsSMlM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F62080F3
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510232; cv=none; b=KFYM7gc75UU0lMT8rggauF3Fw4oylWmLN3sC4A5Bn6Pt4uwJ0XRzzbuZ8n1i44dSP9c65BSaGfWaYY4nzPdk8Snf2Qh8LAxiEzAoO8oKq0iikZozcuHYnnRcgaM8lGVPa71wKUvxxJnm3RMuEtuMtRBQSxRHrTR0MCWOenx2ruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510232; c=relaxed/simple;
	bh=hIKr4cLrz9FvUczQwu5GqWwrW2V5zPUkgPNlGlgmS+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDRDzYDNGVCdtt7onvC2U0w+SxLiiQ2CPtH8A12HpI3aAuCg5fF6gmUINiRfg68Vt9C8hCw+Z7Y5E4m5p7G78O3uTOhGazIWQGmgoaH3K2tg4iDni8ZLU4CtCQN4xrALmcGHZl5ofRk5ko80ua8K0qFtSYNQVwjkl6FvgClFdy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=WKhsSMlM; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward204d.mail.yandex.net (Yandex) with ESMTPS id 28E2864727
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 14:50:47 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:2cca:0:640:9416:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id BDE3E60B3E;
	Fri, 10 Jan 2025 14:50:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aom7u72McGk0-f02P7h2e;
	Fri, 10 Jan 2025 14:50:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1736509837; bh=L5/znvdWlgx26fnzcPJsBhs5jPnzkp8j9akqIDBHPnc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=WKhsSMlM6a792xHG2aojAa5SJEd5MGjBesw/zX5PXc1W6ZC00S4JY0f1tvpkDNN42
	 lafwOWglUTkI1ATtP4iR/aYVsqp9tHhayU8ksXeAe3DXWezKL7cMq6OfOvpRajjfoN
	 1qsDS3zRk0pOeLmlh3WtNSrCzLiL61aZPG6RCG1U=
Authentication-Results: mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Fedor Pchelkin <pchelkin@ispras.ru>
Subject: [PATCH] wifi: ath10k: add extra output check in ath10k_wmi_event_debug_print()
Date: Fri, 10 Jan 2025 14:50:24 +0300
Message-ID: <20250110115024.1497597-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'ath10k_wmi_event_debug_print()', passing skb of the very weird
layout may produce debug output of the zero length. In such a case,
'if (skb->data[i - 1] == '\n')' will trigger an access beyond skb data
boundaries. So fix this by adding an extra check whether at least one
byte of the debug output was really emitted. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Suggested-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 5e061f7525a6..ca3237c7d5b0 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -4618,7 +4618,7 @@ void ath10k_wmi_event_debug_print(struct ath10k *ar, struct sk_buff *skb)
 		ath10k_warn(ar, "wmi debug print truncated: %d\n", skb->len);
 
 	/* for some reason the debug prints end with \n, remove that */
-	if (skb->data[i - 1] == '\n')
+	if (i && skb->data[i - 1] == '\n')
 		i--;
 
 	/* the last byte is always reserved for the null character */
-- 
2.47.1


