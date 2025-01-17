Return-Path: <linux-wireless+bounces-17665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC786A1585B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 20:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35ED73A8929
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067A91A83F5;
	Fri, 17 Jan 2025 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="kr1QDCl/";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="SDRadiYE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3DB1A256B
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143374; cv=none; b=efQ1wfSWSFfStIdXMpiJ12Tnj+l5+iOkV0hzdNMix1I152Y7csAXgiA/LVkMBmkeRRUfHzFeFQw36dGTQ1b1UyRoIG+Ju9Vickzsd8bK1VDa+j3Gn4iWXO68qDCz68jIk4+814SjVk+uSfEHjLXWmEIUhAVVyUPNT4xVtrAf44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143374; c=relaxed/simple;
	bh=QDjtg/vpm93iydWubIhe0cOsU3IjjZ83/PWLu6IURo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n7fdaI5I4c8HdQHxI0QUbQHBqdmhHWFvGOPblF/QCVsMraaZmHi9uSycAoDusd0w+2WOzzQH4lAAX0q4+4XMn9wBaS6LNgS7Y0HAAbPhVmAKsuF42HI0FFaYXafybr0TEWd2KyYG0ea94sx9XAvDwCdJot0xFvyK3KtCSEi7djk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=kr1QDCl/; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=SDRadiYE; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1737142462; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=nqLyocNQWSekMDBFwqG+Wyvol9ScQupxsUOjyFpXlYU=;
 b=kr1QDCl//m3xo4aGPD52ypWqLPAgAR1PfL02VK99+Xqtz8MsT2awh7Acs1PCZEO4t3Uas
 rCLy1ow5fun3oXY4jXyESnnVdeJl/oo0qHDbQJbYrE1N0YS2HTHSzyRD0HGzqhJPrkwRIGF
 yUenAbAXEWBh2INoFquvLLH7Q9p5QzE0vsSYlakhmzwomjFMnwgsIoEENs1xZvcoq7nempF
 rNhzDun7cOLQVIFBV7tjv0ZjJn1Dra7Jnd7j4dfh/owvQEQO1ebTSF5TUyFl2HjyBqHMqsx
 x/8hdVD4ZOzT+7pPOqAIFVJ9kTPquq8eZ/i2mATJjuF2hGrapxrsceUtCrWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1737142462; h=from : subject
 : to : message-id : date;
 bh=nqLyocNQWSekMDBFwqG+Wyvol9ScQupxsUOjyFpXlYU=;
 b=SDRadiYEahDPHNgxaPKAZKPCcbYGh9TzZBOtGYxzKtTQRlIDQ1D6K7boiwNzPygmt8xUC
 zP3P2ojtb8Tpfh2RGLrg+nR6+APVj+xA0VsWDHe87d+u4pBaU2hkDujKbLYO6gO+b/bB1z4
 9IAj36J7pelztgp7O08WhtIUj7RDrxCxSYr+goqBo2MEc7I9fOvCIw5uMy+9zcZwDtO1Zlk
 cQ5VDU0RP+cFWt02QWYorwAOEzO0XBNkFiPCDJbhZ2XihruZ/yE3/0vFZdZXXvN2fKu2SwC
 dCrAugmk5M8Ka0g0Qg6yLuk6h/3Kdrs1rhqSyl7QHWm2Rm1iZcnmQc4Yx5ew==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tYs6k-FnQW0hPqndm-m5Sk;
	Fri, 17 Jan 2025 19:34:18 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH] wifi: ath12k: remove return for empty tx bitrate in mac_op_sta_statistics
Date: Fri, 17 Jan 2025 20:30:53 +0100
Message-Id: <a4bdebd14f5dbec653b75277097917910344f244.1737142154.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sFbIzu7jfk
X-smtpcorp-track: bgW2vrXFRHUU.IdNDh_2JKB6W.YbzyIQhyTYw

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
 drivers/net/wireless/ath/ath12k/mac.c | 29 +++++++++++++--------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d493ec812055..cbc79ec7ac47 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8912,21 +8912,20 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
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
+		}
+		sinfo->txrate.flags = arsta->txrate.flags;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	}
 
 	/* TODO: Use real NF instead of default one. */
 	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
-- 
2.40.0


