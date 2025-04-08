Return-Path: <linux-wireless+bounces-21272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC9A80FFE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 17:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2BC4C7BA4
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE46739AD6;
	Tue,  8 Apr 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="WJjNqqC2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward206a.mail.yandex.net (forward206a.mail.yandex.net [178.154.239.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D71A8407
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125901; cv=none; b=h/niDd1ObVBgDz5MeRWYTfCjMHqaTBWpgh+Tjktp9d9TW6qcxuAOah9qLQ84ANE38RLSE2klY034u6EhXMUZ/poAAzqoZUln3P54mbRGRPU5PFc3AxoTlz3012NBzX6J+4+jjBwcw9mNzLO6lZDHRJ/kia1Kkwh4JZqMBGCAFFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125901; c=relaxed/simple;
	bh=XZB7FY0wFnS2ajbk0Dhz5xZt4Zn0N2u176zFNyhItmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uru8kyA+wQaeXmqtVI0PDRTkBS1hPKUZUG+Zm6cmlTWTKxMb9PVax3hRVwkU4r4IaVAfwRPSS5dlHzHclZ7Rk2Ys4eIyiXWdOFvyE0sYe0eahKV9HHJvzF7QXt6gnyeIVUbSPhGQNxxU+Un3OEk5vXCPBHKie77v6ulpZN1yK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=WJjNqqC2; arc=none smtp.client-ip=178.154.239.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward206a.mail.yandex.net (Yandex) with ESMTPS id A1C0462A0E
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 18:18:05 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2ea0:0:640:5268:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id DB94F60A7F;
	Tue,  8 Apr 2025 18:17:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uHfq8gCLm8c0-vC6Ymm98;
	Tue, 08 Apr 2025 18:17:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1744125477; bh=iIvpXApKzSfHM7MU7wrNllj7Zcy75i9NXXOqEty0jYg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=WJjNqqC2ZqT6o4a21ymqkuIjlGm7IXjjt7Lnv49fwFe8ELFm8nXde5o3agICUGM1o
	 dNP2h2+K3oh9khSF18DdSPOq6Y4HuFsVoiDWjT/J+tZ57jwZQ4jMvJnnbyBNOVOLYt
	 jsZQ42YPOKZTW8/B6vgj7uCJZMSIDj2OSQvdm3Vw=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtlwifi: add array bounds check in rtl92d_dm_rxgain_tracking_thermalmeter()
Date: Tue,  8 Apr 2025 18:17:44 +0300
Message-ID: <20250408151744.3907215-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'rtl92d_dm_rxgain_tracking_thermalmeter()', add an extra 'index_mapping'
array bounds check and use the convenient 'array_index_nospec()' to protect
against spectre. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
index 20373ce998bf..44f1d3b40d22 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
@@ -139,6 +139,9 @@ static void rtl92d_dm_rxgain_tracking_thermalmeter(struct ieee80211_hw *hw)
 	u32 u4tmp;
 
 	idx = rtlpriv->efuse.eeprom_thermalmeter - rtlpriv->dm.thermalvalue_rxgain;
+	if (WARN_ON_ONCE(idx < 0 || idx >= ARRAY_SIZE(index_mapping)))
+		return;
+	idx = array_index_nospec(idx, ARRAY_SIZE(index_mapping));
 	u4tmp = index_mapping[idx] << 12;
 
 	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-- 
2.49.0


