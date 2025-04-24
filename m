Return-Path: <linux-wireless+bounces-22017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4449A9B6CF
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 20:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3619A927F5A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 18:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C4328F513;
	Thu, 24 Apr 2025 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="NQaIx+3H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C7290BC0;
	Thu, 24 Apr 2025 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520781; cv=none; b=f43VPU0lXBRD7g5Xh2e92j4rNJQwnN0yJyyV5rrakFBLI75ZFZRQriCMulQ+YFdRHriS9w8Yhkz5BatdWzCrlwQldx27/2Z+Bpqp1EcG9b+iFQL4bEeIYHhnpi+qclLoVqwZu6Qs7Zpjju99EJbGZ+vSPnVCJB8Lp4vVhH6BHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520781; c=relaxed/simple;
	bh=OygmFMPByzJxZQZ/STA64KpZbimdRAppuLQsI9S0AGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=izdCf0/eDERdiZPv/A5YrFEIo+CAfeKnNvQb4x85nK643ZpSTPkry6HHy3GZ4AC0hiYyKo8pVLGVcsNF+8wMD8ANpPzzpSZq6kggBPjwpgc7kVwAzcwfzb4wIqVKHeoy6LM89n8F3V/l+8xWYO+YRhaaja6rM02+Q/57q1we2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=NQaIx+3H; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bca8:0:640:45be:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id E49B860983;
	Thu, 24 Apr 2025 21:52:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kqV2ll1LoCg0-foSXLjIP;
	Thu, 24 Apr 2025 21:52:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1745520768; bh=eUvSEcjM3P32iq/WojbrYA0IxejTJGbUaeImRlzSclk=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=NQaIx+3H/okY2atnyMu/dUv32bXBU42WHY0TqPoEtI0QKqKM7F3Odw+FQWp5HAGP6
	 ZBAvJn6f8+pj2lYidSh1sQvnQfLx+lIlahix+d3S1hqxecKxU2QdhvbrLawUMkm1uH
	 iP7xJkGEjh2ox33wGR52SZk9Q6JftyrFHnOSesUA=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
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
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] iwlegacy: 4965: fix possible out-of-bounds access in il4965_tx_cmd_build_rate()
Date: Thu, 24 Apr 2025 21:52:44 +0300
Message-Id: <20250424185244.3562-1-a.safin@rosa.ru>
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
v2: change reciepent
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


