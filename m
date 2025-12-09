Return-Path: <linux-wireless+bounces-29623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC78CAF8EE
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 11:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EBCF3000CCA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 10:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14410327C0E;
	Tue,  9 Dec 2025 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjhqe/72"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6250326D63;
	Tue,  9 Dec 2025 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274706; cv=none; b=pDTfrR8M1P90x1ggqHzMteCw4ojlzevQ/X2p88UL940NbXxDRTsfIACZ9GIXzWxIsjllyge4drcxcK30UIBN3BkImNCd23HJYMS+mcFPZTwP15THKhnMvpb5VYLOjtkkAFk7GjtDbc5UsvaeF3JbSpqa6HS11t3stpiURj0NlYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274706; c=relaxed/simple;
	bh=91hUbJvY6ZGTi0uV89SCx4Rd0OaoIOWRMu57EeKv0q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjD3WTjRawfxkD14KQVRV1hq7drVPpiLY54shGj1/0zNeh7RLWVY1ZVXvvE2pFEGOZFbpz195U6TvtbE5NboYSDR2fuIfcsA7U9YDV0LjP5GMq2TKPHa93vE71UEj6Xvs1bA12EQ981YmaeRtlZi8qO8qNerg65lc/VNMF4HQck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjhqe/72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F729C4CEF5;
	Tue,  9 Dec 2025 10:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765274703;
	bh=91hUbJvY6ZGTi0uV89SCx4Rd0OaoIOWRMu57EeKv0q4=;
	h=From:To:Cc:Subject:Date:From;
	b=hjhqe/72bfI3wS6JmfVOWc9BStaBwZn/IY6D+9WNd4j5ak1ZWKz8KoLXz7+JWOJ78
	 yx/8obdl7w7GiN0rYWndiSoC1VE1uDaedw6gAYeTkzI6NwuQ2ahqngtk3XY8cAHUXn
	 dUKM0RQC+pb/mFWG6ENoKDxfgHTdyt+1/GNsaHBxU2Ep5Jpl9jQtCvWGoH9pKZP++F
	 u0nWqVao0+iDsYesQxoAkpg73cbOkBmU33xleSYPPZ00Cy/4vYfJj4miBNoW9yb0Dv
	 mr0j9hr2v1PWo9JfotXLLByhCeBWVqDxHUr/mMdiOXQHjTaxJJEfEB78IEVnDpXYER
	 N/zORyZoGMlgw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Vincent Danjean <vdanjean@debian.org>,
	stable@vger.kernel.org,
	1119093@bugs.debian.org,
	Salvatore Bonaccorso <carnil@debian.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: ath5k: do not access array OOB
Date: Tue,  9 Dec 2025 11:04:59 +0100
Message-ID: <20251209100459.2253198-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vincent reports:
> The ath5k driver seems to do an array-index-out-of-bounds access as
> shown by the UBSAN kernel message:
> UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath5k/base.c:1741:20
> index 4 is out of range for type 'ieee80211_tx_rate [4]'
> ...
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x5d/0x80
>  ubsan_epilogue+0x5/0x2b
>  __ubsan_handle_out_of_bounds.cold+0x46/0x4b
>  ath5k_tasklet_tx+0x4e0/0x560 [ath5k]
>  tasklet_action_common+0xb5/0x1c0

It is real. 'ts->ts_final_idx' can be 3 on 5212, so:
   info->status.rates[ts->ts_final_idx + 1].idx = -1;
with the array defined as:
   struct ieee80211_tx_rate rates[IEEE80211_TX_MAX_RATES];
while the size is:
   #define IEEE80211_TX_MAX_RATES  4
is indeed bogus.

Set this 'idx = -1' sentinel only if the array index is less than the
array size. As mac80211 will not look at rates beyond the size
(IEEE80211_TX_MAX_RATES).

Note: The effect of the OOB write is negligible. It just overwrites the
next member of info->status, i.e. ack_signal.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reported-by: Vincent Danjean <vdanjean@debian.org>
Link: https://lore.kernel.org/all/aQYUkIaT87ccDCin@eldamar.lan
Closes: https://bugs.debian.org/1119093
Fixes: 6d7b97b23e11 ("ath5k: fix tx status reporting issues")
Cc: stable@vger.kernel.org

---
[v2] added Fixes + Cc: stable

Cc: 1119093@bugs.debian.org
Cc: Salvatore Bonaccorso <carnil@debian.org>
Cc: Nick Kossifidis <mickflemm@gmail.com>,
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ath/ath5k/base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index 4d88b02ffa79..917e1b087924 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -1738,7 +1738,8 @@ ath5k_tx_frame_completed(struct ath5k_hw *ah, struct sk_buff *skb,
 	}
 
 	info->status.rates[ts->ts_final_idx].count = ts->ts_final_retry;
-	info->status.rates[ts->ts_final_idx + 1].idx = -1;
+	if (ts->ts_final_idx + 1 < IEEE80211_TX_MAX_RATES)
+		info->status.rates[ts->ts_final_idx + 1].idx = -1;
 
 	if (unlikely(ts->ts_status)) {
 		ah->stats.ack_fail++;
-- 
2.52.0


