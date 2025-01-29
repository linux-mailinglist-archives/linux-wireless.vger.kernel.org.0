Return-Path: <linux-wireless+bounces-18158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F40A2226F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 17:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E31D17A3A94
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A3B1DFE0A;
	Wed, 29 Jan 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="PqSkafCb";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="QxfFyk0f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9F1DF99D
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169964; cv=none; b=E5fzPLGXxP1TZngT9mQcRbg+9+/I2wmW6p2WMWcC3FZDpFXA5EBqrOKnq4QoA5vuNyVxw6ThdP76tuPtlDIfXhgxGWK0D15cpjnb/mn4pCKvXCU61xdJJgg0AlEqAiSayUyXt820yl1l910sLoiJbY3NJznVF2MvkuDkaKDgbrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169964; c=relaxed/simple;
	bh=vlR/mNTPKdf93728swy2ZznETWcIqOE2mb0rx2F285M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WfBeOZ5d5K9fUujvSZkPCRUpcE+ARY3IhL1QSgavATBIDJh/J47bNUNK+6vCEOAHN4Y2q7GLn3YTmucygQyOQYLMXrrRYKNoP1a6DGMS6YDKFmfKc0E/akSU9T0/YWfONBVaTsUAD/FFo4PzaT/elVUbHiVfIEOnVKofjFSOno4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=PqSkafCb; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=QxfFyk0f; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1738169955; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=yI14DNCfIlRuCxZ886YFaQ2/UtcUwqmz1COfGxdJOeo=;
 b=PqSkafCb17XgOydABrcC5PKT2z5ACLo/Huo1pVCUWfA0pciFGq61Pp/pHQXjUuGd06LKM
 9YPljMfR/xWXeSz5RHEhiiKcOSi+Mj1Cw2H1HMb9ffL615evZTNFmxT1O3fWBAkZScXYaDl
 J+GvDUVEEpm1LDOdC0Cn1yujNfeFRI11h19VcX7p5ZefsbgGL4VCdRP60VvP6Tkbm79L0IU
 07sr/XbhK8vp4kaHGs/SQeq+ekXeip60D9yeVz/7tK/g/gyPAjD05YBFoonyA3gaZKQT7e+
 nPfInw7Xp9R/hivI7qFYtTfOOSl52U2fX3PFXbMhiaWxbt/1mgqB7nihseJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1738169955; h=from : subject
 : to : message-id : date;
 bh=yI14DNCfIlRuCxZ886YFaQ2/UtcUwqmz1COfGxdJOeo=;
 b=QxfFyk0fuPvho0VsOVPF7nHW/qfN543eiIgsLBVUckYr6b2CebJ7VYmHN385jDKl0txSA
 GF4ZffTMzCjXTJ7hGrop3bUk3AJvRZMVq0TIuzW4+ttjDBH/umYJy18WWDCnvPXYg2Cf5kZ
 0FbIwx9sh8+R3+Lw6Dlf/3ckD3hr6T1rkyqazGFvr4Jpg4DN14v+lV+1MUC6hH88abdpzz0
 wNl/Ze+i6Y7XZtENHdcmHAlIPxDT3dTNml1F5fXR2k4x8fbkbJO5Ns7S/cWceZOxDPQCPVO
 hjOf0tI68feVr0Yc4gCEO3cQLvPZvow0+EwUPuLM78ZsVeG6ue04LGrbcIig==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tdBP9-FnQW0hPzWk4-mJHD;
	Wed, 29 Jan 2025 16:59:07 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2] wifi: ath12k: remove return for empty tx bitrate in mac_op_sta_statistics
Date: Wed, 29 Jan 2025 17:55:17 +0100
Message-Id: <38c2a7c4f7eaf57b9306bb95a9e6c42b7d987e05.1738169458.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sIr91F9xb_
X-smtpcorp-track: KoMcHzDzUiE3.pWuvcwuce-PD.q7FjhwbNYYv

Currently in ath12k_mac_op_sta_statistics() there is the following
logic:

    if (!arsta->txrate.legacy && !arsta->txrate.nss)
        return;

Because ath12k_sta_statistics is used to report many info to iw wlan0 link,
if it return for empty legacy and nss of arsta->txrate, then the other
stats after it will not be set.

To address this issue remove the return and instead invert the logic to set
the txrate logic if (arsta->txrate.legacy || arsta->txrate.nss).

The same was done also in both ath10k with commit 1cd6ba8ae33e ("ath10k:
remove return for NL80211_STA_INFO_TX_BITRATE") and ath11k as well with
commit 1d795645e1ee ("ath11k: remove return for empty tx bitrate in
mac_op_sta_statistics").

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
Changes in v2:
  - Rebase on ath-next

 drivers/net/wireless/ath/ath12k/mac.c | 33 +++++++++++++--------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4fb7e235be66..e9663c6ac72c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10170,23 +10170,22 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->tx_duration = arsta->tx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
 
-	if (!arsta->txrate.legacy && !arsta->txrate.nss)
-		return;
-
-	if (arsta->txrate.legacy) {
-		sinfo->txrate.legacy = arsta->txrate.legacy;
-	} else {
-		sinfo->txrate.mcs = arsta->txrate.mcs;
-		sinfo->txrate.nss = arsta->txrate.nss;
-		sinfo->txrate.bw = arsta->txrate.bw;
-		sinfo->txrate.he_gi = arsta->txrate.he_gi;
-		sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
-		sinfo->txrate.he_ru_alloc = arsta->txrate.he_ru_alloc;
-		sinfo->txrate.eht_gi = arsta->txrate.eht_gi;
-		sinfo->txrate.eht_ru_alloc = arsta->txrate.eht_ru_alloc;
-	}
-	sinfo->txrate.flags = arsta->txrate.flags;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	if (arsta->txrate.legacy || arsta->txrate.nss) {
+		if (arsta->txrate.legacy) {
+			sinfo->txrate.legacy = arsta->txrate.legacy;
+		} else {
+			sinfo->txrate.mcs = arsta->txrate.mcs;
+			sinfo->txrate.nss = arsta->txrate.nss;
+			sinfo->txrate.bw = arsta->txrate.bw;
+			sinfo->txrate.he_gi = arsta->txrate.he_gi;
+			sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
+			sinfo->txrate.he_ru_alloc = arsta->txrate.he_ru_alloc;
+			sinfo->txrate.eht_gi = arsta->txrate.eht_gi;
+			sinfo->txrate.eht_ru_alloc = arsta->txrate.eht_ru_alloc;
+		}
+		sinfo->txrate.flags = arsta->txrate.flags;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	}
 
 	/* TODO: Use real NF instead of default one. */
 	signal = arsta->rssi_comb;
-- 
2.40.0


