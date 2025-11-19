Return-Path: <linux-wireless+bounces-29119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41060C6D0A4
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 08:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D0893522FE
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 07:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE1731813A;
	Wed, 19 Nov 2025 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWzfF13q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D22F2910;
	Wed, 19 Nov 2025 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536327; cv=none; b=KM6dEVVtTB3moCD/sbJZDxLHodHrOfUlFDA/Uc0eDZ8/84pIsrGhDHOJDdsW+/cSG3AqQcTWYOcdSrFBYtnCTOdQK0hN09ir1sMPphimvpqNF0qtukEVrPuW/wHUbZP1/mSnaBuuVRkuUEvHN6xtfXkPHOocWKHq2Ps8nkHEqe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536327; c=relaxed/simple;
	bh=heRLluAsb1fBA0IdSBZn+pz0ZdFL4+ZY2/X2upJQjDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjnlN5FDnauVEySZYPDDCLEC4iDMqxomK/+54Cyv+DY34B1/EZa4LmGrWlYJ9uIkKCbSJm+0bpktkv2SRwcLxBgpYQ2ISXk4v7zOSbgHLhfoWmYnz92kIIppvi9T1RCwpzXNQgj1gDmUK4OQ7mjiyfenUW+PnhQI+VtiuNxXawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWzfF13q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D538C2BC9E;
	Wed, 19 Nov 2025 07:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763536326;
	bh=heRLluAsb1fBA0IdSBZn+pz0ZdFL4+ZY2/X2upJQjDI=;
	h=From:To:Cc:Subject:Date:From;
	b=DWzfF13qeg73czjIp8HxciyZFDrzXB3xnBHNg/ItM/69mxo9elBzjGeY/3AGof9AD
	 dqnium8MTnVUOm5vSl0PhnUGPSKLVJNePPAJlp5sDvCOOeku0Sqm/nFhPbPPzeNPMw
	 XCFobJ2W9yTFeNFJGKyEz98412D7g4kuuENqUI/kLV10y5UvJFuPWqK7aM/SHBx31n
	 5PSAhvnvfgSxKSMxomeFCd/pG41oc7tvZePVxCOd4YuMTiH7PykagsvlbGvXkkydMG
	 AsWKXRQyMoJqzYBtBE7lZZDT2qhNQlWcfoakZM0rkGXALRpkuEzj5AGGLo4iuNt54F
	 QQoxg6LnyfyXA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Vincent Danjean <vdanjean@debian.org>,
	1119093@bugs.debian.org,
	Salvatore Bonaccorso <carnil@debian.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath5k: do not access array OOB
Date: Wed, 19 Nov 2025 08:12:01 +0100
Message-ID: <20251119071201.792814-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
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

---
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
2.51.1


