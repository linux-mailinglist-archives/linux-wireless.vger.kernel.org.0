Return-Path: <linux-wireless+bounces-13189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFAC985E57
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 15:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2FD283313
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C77017C9AF;
	Wed, 25 Sep 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLPlk8t5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112681AB4;
	Wed, 25 Sep 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266300; cv=none; b=ZC2ErCDY33YrpmSAypwxfwgvB8IRl8F2GgaJaflCU+NJ5FFQPgtF+UEpQXCrSVzNveATV5qigHva3Z/O8wcEX+ZchMkMskADf7INWqwpxUyXcg+MBmLH+rleYUrfAAXomhTcnabpz9w8cdcgL952+7WbqhIzKarcmvaRlXiqRa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266300; c=relaxed/simple;
	bh=H3WswCX31WbKLjBejmaLiRprmM8lk+Py/aH6yCQt4cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tIoK/Z3oBpT9OdCxTNWJCRqyelnAIyQPmda5oGOQCZKhqsr5qFKVDEpqVVY6CWSyfnhfhlFMbJYy6munomUD7ezLkXmk0GT9LUZiZZCcwNjeldNSt5PDUxtkbJlHoA3wrCtfr48Y7iCLvQb4AnNTjU7j2Byez9Kr5DrO80syWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLPlk8t5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC94C4CEC3;
	Wed, 25 Sep 2024 12:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266299;
	bh=H3WswCX31WbKLjBejmaLiRprmM8lk+Py/aH6yCQt4cg=;
	h=From:To:Cc:Subject:Date:From;
	b=rLPlk8t5vFhHa7LAbXmAd5eTqCWL4BFSgKi6b7LakPOTByV0hvsBBsaerbz7sCTK1
	 Hj0s1vtb2uOKkbL/fF16TSmZupU+J7eftxBc+5RGuunaHXLj+aOYw5lJy4TpdjoEPu
	 McsNPvlxXaI/Eeeinu8jO04V3VOVgASAu8qQenxuhsmIWlaM5Pv6OIkK8KNVNsX9IF
	 pgS3jrYVMcFCa8IWNRWHjiWzccP5dR8kg0FGQRZtQ2kABq10teXAACmYBcZLC6fLYd
	 /S4Nf97m30xC2wzDbSzfKBpi/YoKkyBv2MjWDpSoWSXCMX3qhwI8Q4PpMsB9nc0vKY
	 f0cvrHCoRBdCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 001/139] wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()
Date: Wed, 25 Sep 2024 08:07:01 -0400
Message-ID: <20240925121137.1307574-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Dmitry Kandybka <d.kandybka@gmail.com>

[ Upstream commit 3f66f26703093886db81f0610b97a6794511917c ]

In 'ath9k_get_et_stats()', promote TX stats counters to 'u64'
to avoid possible integer overflow. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240725111743.14422-1-d.kandybka@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index a0376a6787b8d..aaad285042864 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1325,11 +1325,11 @@ void ath9k_get_et_stats(struct ieee80211_hw *hw,
 	struct ath_softc *sc = hw->priv;
 	int i = 0;
 
-	data[i++] = (sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_pkts_all +
+	data[i++] = ((u64)sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_pkts_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BK)].tx_pkts_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VI)].tx_pkts_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VO)].tx_pkts_all);
-	data[i++] = (sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_bytes_all +
+	data[i++] = ((u64)sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_bytes_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BK)].tx_bytes_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VI)].tx_bytes_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VO)].tx_bytes_all);
-- 
2.43.0


