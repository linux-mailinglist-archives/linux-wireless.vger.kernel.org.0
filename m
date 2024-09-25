Return-Path: <linux-wireless+bounces-13170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454F2985C19
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 14:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035D6287446
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 12:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E7B18953F;
	Wed, 25 Sep 2024 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIpQSq7x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F5E170A3E;
	Wed, 25 Sep 2024 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265507; cv=none; b=qcDeNt505TqoRmWK0xOhUoyuowvkjQhgK6SRGqjsDyxzy78bKkT5T+/s7EKetvkcukRhJ0NyKVFdo74gOYx5AEsDsA0I4jt/nI2yzUJ/NzzWz+zD1K3mn4vI0ID/nxbx06tX0I1jpLfwsLb4iMd8AjF90QI4xBC1Jvw6O6dHSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265507; c=relaxed/simple;
	bh=DHKg4G/Asx6z3gXHGGyKUwxi9cSsvXk2f1FXaNNbvXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fnOXMNDJBydfvKHMOrtUyHgdq1KtdC+MlnSwjHWtYVoobsVQ5Nn5HK41tMqQHIoMIOI4DvjkW1P3z1gy7ULY/uLMxDIGMjr0x+ILodNz/CFtkbCC+K7HzgzT9cTK5vHLF3J7UQXkFrfJ2Wg4/hKKSOKnGIVJkqcX2qK0tRRIYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIpQSq7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC3FC4CEC7;
	Wed, 25 Sep 2024 11:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265506;
	bh=DHKg4G/Asx6z3gXHGGyKUwxi9cSsvXk2f1FXaNNbvXE=;
	h=From:To:Cc:Subject:Date:From;
	b=bIpQSq7xLVwQaRNvDVED3scuFjhCJj7tTdnC+U2jBWrEjq+fczreIyNqxLogobzLj
	 CnWsmmYfOUYYP8uHU1nRwgMEB2rVrHaYZK2U4Kgf9ru1RqgM97ditagjsBmRbNGxRS
	 jsa09p2LuoK3Rv6Gted35EEdlTzZHkRDI4oCcw3TR+X0ZBlRkoyXWE72UqbEiDcwwE
	 56IgTwDs1MhI6wzu65+b2O8LopNZtPRrkcds4u25kRB5i3ZjRcXcMfBiABDJkEtZ6s
	 6/ecJcdzWqXTXmCb3SfbEVC5qmnc6wOxq6GOGCVq7EnSCh5+pKy192f3GIBvGZf4G7
	 yyjJrTYKCBGqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 001/197] wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()
Date: Wed, 25 Sep 2024 07:50:20 -0400
Message-ID: <20240925115823.1303019-1-sashal@kernel.org>
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
X-stable-base: Linux 6.10.11
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
index d84e3ee7b5d90..886a102e5b025 100644
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


