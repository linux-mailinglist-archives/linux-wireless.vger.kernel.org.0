Return-Path: <linux-wireless+bounces-22016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8960EA9B69B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 20:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43BF61B62FFD
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7ED28FFD5;
	Thu, 24 Apr 2025 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="GcZBwvFW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D31624E5;
	Thu, 24 Apr 2025 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520106; cv=none; b=ceK/ruuPsQWv5/L2PPxG6UDh9o7mkCpTjH9lw/DdAC6MF7VfByQmDdXofzJXWU8HxyR8M/5P5r76mao4rHGlv+4AkCcEKrTxd7YlSAMnGONVt/TS7JyEyt6Mkh5+msu0X8FC1pM1TKrzTsp3+UWwZWcab9f91cYFiyEb1OMogGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520106; c=relaxed/simple;
	bh=UY7mwzK6h3h/JHCIa8gPjepYiPqxs1+ZGL7ML4m7Lc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I+eE2LlGME2Fbiy2qN5yFcF9Ai9nwnKakJKaJktI5vTsGBbvDfO1dY+MvFcg7jidenhyUXtBrUPf1CxMVK9VJEehQpPCUU6XKiJkj/3zYCtBcu/4tDI4nrJ7d2B7s9TrFL5Mhu774qTQjD1WNHb0wRZ206rB34IbxwnOQi7NjmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=GcZBwvFW; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id 2DC43689D4;
	Thu, 24 Apr 2025 21:33:56 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3bcd:0:640:dc38:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 075F160027;
	Thu, 24 Apr 2025 21:33:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kXVCAB2LZmI0-s6An8AkH;
	Thu, 24 Apr 2025 21:33:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1745519627; bh=9699AcloeCDb7D22U3eJAvZmA6C/RcO8yloHAzmxeEk=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=GcZBwvFWGhzYWKa9NQMASVuJBRpvlkYld+BsaOPqKfl13YUPViF8gaZJ3zpsyBMdb
	 KDLpkzrEiV8s0HNRIWdiY2w+lhHpUbJAc7sp9iNHRXI22CYeEJVLFWUXVfyurU0ZIJ
	 fjQCzYrIsxvJq1gI0U0TKhe8rIpXDy1K/E54Xurc=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Alexei Safin <a.safin@rosa.ru>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Alexei Safin <a.safin@rosa.ru>,
	Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iwlegacy: 4965: fix possible out-of-bounds access in il4965_tx_cmd_build_rate()
Date: Thu, 24 Apr 2025 21:33:38 +0300
Message-Id: <20250424183338.3277-1-a.safin@rosa.ru>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent out-of-bounds access in il4965_tx_cmd_build_rate() by rejecting
rate_idx values greater than or equal to RATE_COUNT_LEGACY.

Use a correct bounds check to avoid accessing il_rates[] with
an invalid index. The previous comparison allowed rate_idx to become
equal to RATE_COUNT_LEGACY, which exceeds the array limit.

Replace the check 'rate_idx > RATE_COUNT_LEGACY' with
'rate_idx >= RATE_COUNT_LEGACY' to ensure memory safety.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7ac9a364c172 ("iwlegacy: move under intel directory")
Signed-off-by: Alexei Safin <a.safin@rosa.ru>
---
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 78dee8ccfebf..f60d9b9798c1 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -1572,7 +1572,7 @@ il4965_tx_cmd_build_rate(struct il_priv *il,
 	 */
 	rate_idx = info->control.rates[0].idx;
 	if ((info->control.rates[0].flags & IEEE80211_TX_RC_MCS) || rate_idx < 0
-	    || rate_idx > RATE_COUNT_LEGACY)
+	    || rate_idx >= RATE_COUNT_LEGACY)
 		rate_idx = rate_lowest_index(&il->bands[info->band], sta);
 	/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
 	if (info->band == NL80211_BAND_5GHZ)
-- 
2.39.5 (Apple Git-154)


