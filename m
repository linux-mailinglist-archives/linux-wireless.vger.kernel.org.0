Return-Path: <linux-wireless+bounces-23109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCE7ABA8C0
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 09:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425971BA16C1
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7FC1CAA6C;
	Sat, 17 May 2025 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="BrNLLp+g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A618DF62
	for <linux-wireless@vger.kernel.org>; Sat, 17 May 2025 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747468046; cv=none; b=SasDiS9UJmrZNb7BElYamk9Mu2aPWSHYUkQef+VnBtzU4Kalx0wvj7okRXdF8rOnd+VjGr6Tl7H8WNG0zyfwqFyme+U532Nk+3qQ7UdyEduPfGdhrm7SnoDikVo1a5mDkN6ZLqZsX/5/i4iW1fzQFb5dplgGdTnO6dBlpfYT9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747468046; c=relaxed/simple;
	bh=GzUx3qX8x8Ti/WYrmeDubgDgmu4jLi8bLsh1uhw67kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGHIQx5l4fl5RaHPjYloJcAMT4VQMMnCVo85L+3TpFmyKPTT6HybrUG35JFO5NbKcgfJG4L6RbJ9PboJi3Ch+aWvpHApq/KxqfYfWdE8P+Bjgv49kZPl1NC5qtCQFjIrYNFbb3BHiIPrYZf8+yeXkXomRzihAOrEDgOF4fjYmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=BrNLLp+g; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 25770 invoked from network); 17 May 2025 09:40:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1747467640; bh=vQzP50BnvI3iw2cFJFa5sluy2kEXYWbvimnAccLCu5M=;
          h=From:To:Cc:Subject;
          b=BrNLLp+garP4N8WaeTnMRagYwZpHQ7I6HOH5WNH4Or66u0Te/Ov1VGM9iPfCEzSjB
           XN9w+ZsSr4ZX61NM6YnIgi8YCUiRXXlKTDOIpT5E8fPJoiNjNOyVrmXIaeCUVe8Yv3
           9TqZ3dvokEroZDA0fRAShrlSZV9OaqDjv2q3FXMoq6XLwPfUGz1v/16BYOcck0frCz
           ens3cmATBAZRVvwFAd31wHxaX3Mn0vbOJQ2SZ1cFH0Dk8KdqA9XplRMraKMwSGtS0b
           PV3b9Daw6C526l/CjINRvEefI90nYXK33NQ7zAx5Iaeaj/odicvm9bPkof/5jSEys/
           lHLfHkeeJUgbQ==
Received: from 89-64-9-114.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.114])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <pchelkin@ispras.ru>; 17 May 2025 09:40:40 +0200
Date: Sat, 17 May 2025 09:40:40 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Alexei Safin <a.safin@rosa.ru>, lvc-project@linuxtesting.org,
	netdev@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH] wifi: iwlegacy: Check rate_idx range after addition
Message-ID: <20250517074040.GA96365@wp.pl>
References: <20250424185244.3562-1-a.safin@rosa.ru>
 <20250427063900.GA48509@wp.pl>
 <d57qkj2tj4bgfobgzbhcb4bceh327o35mgamy2yyfuvolg4ymo@7p7hbpyg5bxi>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57qkj2tj4bgfobgzbhcb4bceh327o35mgamy2yyfuvolg4ymo@7p7hbpyg5bxi>
X-WP-MailID: 779311392d6761ada01cae0109ceb9c8
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [sVOR]                               

Move rate_idx range check after we add IL_FIRST_OFDM_RATE for it
for 5GHz band.

Additionally use ">= RATE_COUNT" check instead of "> RATE_COUNT_LEGACY"
to avoid possible reviewers and static code analyzers confusion about
size of il_rate array.

Reported-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reported-by: Alexei Safin <a.safin@rosa.ru>
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index dc8c408902e6..2294ea43b4c7 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -1567,16 +1567,19 @@ il4965_tx_cmd_build_rate(struct il_priv *il,
 	/**
 	 * If the current TX rate stored in mac80211 has the MCS bit set, it's
 	 * not really a TX rate.  Thus, we use the lowest supported rate for
-	 * this band.  Also use the lowest supported rate if the stored rate
-	 * idx is invalid.
+	 * this band.
 	 */
 	rate_idx = info->control.rates[0].idx;
-	if ((info->control.rates[0].flags & IEEE80211_TX_RC_MCS) || rate_idx < 0
-	    || rate_idx > RATE_COUNT_LEGACY)
+	if (info->control.rates[0].flags & IEEE80211_TX_RC_MCS)
 		rate_idx = rate_lowest_index(&il->bands[info->band], sta);
-	/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
-	if (info->band == NL80211_BAND_5GHZ)
+	else if (info->band == NL80211_BAND_5GHZ)
+		/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
 		rate_idx += IL_FIRST_OFDM_RATE;
+
+	/* Use the lowest supported rate if the stored rate idx is invalid. */
+	if (rate_idx < 0 || rate_idx >= RATE_COUNT)
+		rate_idx = rate_lowest_index(&il->bands[info->band], sta);
+
 	/* Get PLCP rate for tx_cmd->rate_n_flags */
 	rate_plcp = il_rates[rate_idx].plcp;
 	/* Zero out flags for this packet */
-- 
2.25.4

