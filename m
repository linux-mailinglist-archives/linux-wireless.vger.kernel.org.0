Return-Path: <linux-wireless+bounces-10777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F90943C3B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B781C21AC8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991281AD40F;
	Thu,  1 Aug 2024 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sutiCheL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4621369B0;
	Thu,  1 Aug 2024 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471399; cv=none; b=s+TxR387pMzEfLxF9m6fOT/doec60qpuDxmTlMx2Ca7Eekm0waphPbJHqr0hgE/j6phfZFayyZntEx3SBfDvJG6oC0HOEFoCWtyNklzSaAodgAhStfSK2fv/fU1aUrdPgW9mqfdgn4n+oVprcqTV/KS1BLdt3qY/wLqPFwbzlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471399; c=relaxed/simple;
	bh=xKmG+h3e/pfzKAgMRNuiHHVyFsZSiwtJDc2oAsA24Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCi24A/sj09iRZXbh/K7ayrMEczZGPUDH2v6Qs1YKBdq4zJ3h6byQOfDEUduyx/jIlTvRvkb2mLs5MIcbn5aJzKft7XM9oWu7sGA6aFWIInoNMkqXzS9I+sVEoYTyvGXjC9fmEFFX0SDqHLgSmKyyOSOIHveXjunwx0rG4haHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sutiCheL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E9CC116B1;
	Thu,  1 Aug 2024 00:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471399;
	bh=xKmG+h3e/pfzKAgMRNuiHHVyFsZSiwtJDc2oAsA24Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sutiCheLBgEaKEA9PGxAUlelgLiztsg5Ge37ux+gqdM1MgCF+TI7iZujCsk63H7Tm
	 0FAHMmv67LXpTQzzpyC5orpo85NJ0XzOvEwFcyYju0To0OZ7e0cUpx50Jhrt5TjDah
	 JjPFX6FQkQ0Uh5Uk+4LcjWjtl7l1C8zK7hIiP7tlKAX+XsnlF5DJT7Uc6bj9sYqlkD
	 Q8J+faRwH3qW78a92BRSMOiBvrHM6bLw5Ydl0+sHoTA2CNlMLtYPDct9XeFQ/ydhak
	 Z0kAqrL20iolFH1N51oiE6L1u0+yBHHcs7MSdgfw/VblFzoBMrIhCuz2L2o5aoN7Lf
	 U6Yx2zYc49lJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aaradhana Sahu <quic_aarasahu@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 086/121] wifi: ath12k: fix uninitialize symbol error on ath12k_peer_assoc_h_he()
Date: Wed, 31 Jul 2024 20:00:24 -0400
Message-ID: <20240801000834.3930818-86-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Aaradhana Sahu <quic_aarasahu@quicinc.com>

[ Upstream commit 19b77e7c656a3e125319cc3ef347b397cf042bf6 ]

Smatch throws following errors

drivers/net/wireless/ath/ath12k/mac.c:1922 ath12k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_80'.
drivers/net/wireless/ath/ath12k/mac.c:1922 ath12k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_160'.
drivers/net/wireless/ath/ath12k/mac.c:1924 ath12k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_80'.

In ath12k_peer_assoc_h_he() rx_mcs_80 and rx_mcs_160 variables
remain uninitialized in the following conditions:
1. Whenever the value of mcs_80 become equal to
   IEEE80211_HE_MCS_NOT_SUPPORTED then rx_mcs_80 remains uninitialized.
2. Whenever phy capability is not supported 160 channel width and
   value of mcs_160 become equal to IEEE80211_HE_MCS_NOT_SUPPORTED
   then rx_mcs_160 remains uninitialized.

Initialize these variables during declaration.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240611031017.297927-3-quic_aarasahu@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 805cb084484a4..678a08ab22f03 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1881,7 +1881,9 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 {
 	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
 	int i;
-	u8 ampdu_factor, rx_mcs_80, rx_mcs_160, max_nss;
+	u8 ampdu_factor, max_nss;
+	u8 rx_mcs_80 = IEEE80211_HE_MCS_NOT_SUPPORTED;
+	u8 rx_mcs_160 = IEEE80211_HE_MCS_NOT_SUPPORTED;
 	u16 mcs_160_map, mcs_80_map;
 	bool support_160;
 	u16 v;
-- 
2.43.0


