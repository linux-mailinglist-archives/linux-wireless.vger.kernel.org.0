Return-Path: <linux-wireless+bounces-19688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF8FA4B9E3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 09:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44523189315F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 08:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7711EEA57;
	Mon,  3 Mar 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="XI8SQK7g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B171EE7AD;
	Mon,  3 Mar 2025 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991740; cv=none; b=ljqr25FWT7r5QVXAhuw5113NBTJAnt+7lGrj7/IVoqANvKgoH4dfyayttstlKjP/39E/q+HgXTa8OJonqH0WjDha93X+9PKTbaqo7JgwO3DMcF1nN+xdkTRFcK2SDJ5LWlSlugkjLGCfvrNDANNLF8hs39Bu1qxRB1RHUSEy1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991740; c=relaxed/simple;
	bh=dlzlgK1uuPwJmnwi9znbAsJgAX3BfyutzQnKO6E48gM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Wd+itwxcAOOkbjJOpSVpGmw4ODSrK1w6z5SbXDIbG/NcOXD1BaE9vnj5xxpt03JP5lHct16U5A+rk3ALGEwYuv9vkSKjPq914wt7wuQfhGVxM3kbT1DJG1bMDUtFlEWdMlgwvUi3c0a7CTNge1Bi0MllVASCeKmNJdobzkPpmzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=XI8SQK7g; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTP id 5238mbWO013501-5238mbWQ013501
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Mon, 3 Mar 2025 11:48:37 +0300
Received: from EX1.crpt.local (192.168.60.3) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 3 Mar
 2025 11:48:36 +0300
Received: from EX1.crpt.local ([192.168.60.3]) by EX1.crpt.local
 ([192.168.60.3]) with mapi id 15.01.2507.044; Mon, 3 Mar 2025 11:48:36 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, Jeff Johnson
	<jjohnson@kernel.org>, Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
	Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>, Govindaraj Saminathan
	<quic_gsamin@quicinc.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "ath11k@lists.infradead.org"
	<ath11k@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH] ath11k: fix overflow in tx stats calculation
Thread-Topic: [PATCH] ath11k: fix overflow in tx stats calculation
Thread-Index: AQHbjBkN1hoxjWOKr0amjmSVfS9ptA==
Date: Mon, 3 Mar 2025 08:48:36 +0000
Message-ID: <20250303084831.61876-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=GXCR2/qllsmPA+9VDf1WpC/D25nO4d0B9V4QL8xXBpM=;
 b=XI8SQK7gVFOwGxTsYVEGbivOvCizx/6U/Qwcox6F8Zbuq9xSWNt/b+EZaxDRoROTS3cGZgX/Vnd2
	B2ehybR+dUFKd3Yvy/L2h9t3BD2LUsiFSqA3JGZGlpvrOkNDbq7j0TOxreJ1xem6/SXbMmpvO4xy
	OrF/dT56ewIB6smBikaPuXWac3mfxgAqrMdqdsbZqiLga/osIpPmOMVnToH9gzM+L1lDxroPtHLj
	DwXgBhAwhfLidHW/9cs4gvq+KOmqcaK3Rby2BiAPwuAHJvcX7mas6mHoWZUGPRBL16BPK9C8UjM8
	C8xkwcx1Pa3cEZXehsh9HzH+zesrkQXhXkvX0w==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Size of variable peer_stats->succ_bytes equals four bytes.
Size of variable peer_stats->retry_bytes equals four bytes.

The expression peer_stats->succ_bytes+peer_stats->retry_bytes is currently
being evaluated using 32-bit arithmetic. So during the addition an
overflow may occur.

Since a value of type 'u64' is used to store the eventual he, it is
necessary to perform the 64-bit arithmetic to avoid overflow during the
multiplication.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
      =20
Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wi=
reless/ath/ath11k/debugfs_sta.c
index f56a24b6c8da..982a7add6ea6 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -69,26 +69,26 @@ void ath11k_debugfs_sta_add_tx_stats(struct ath11k_sta =
*arsta,
=20
 		if (txrate->flags & RATE_INFO_FLAGS_HE_MCS) {
 			STATS_OP_FMT(AMPDU).he[0][mcs] +=3D
-			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			peer_stats->succ_bytes + (u64)peer_stats->retry_bytes;
 			STATS_OP_FMT(AMPDU).he[1][mcs] +=3D
 			peer_stats->succ_pkts + peer_stats->retry_pkts;
 		} else if (txrate->flags & RATE_INFO_FLAGS_MCS) {
 			STATS_OP_FMT(AMPDU).ht[0][mcs] +=3D
-			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			peer_stats->succ_bytes + (u64)peer_stats->retry_bytes;
 			STATS_OP_FMT(AMPDU).ht[1][mcs] +=3D
 			peer_stats->succ_pkts + peer_stats->retry_pkts;
 		} else {
 			STATS_OP_FMT(AMPDU).vht[0][mcs] +=3D
-			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			peer_stats->succ_bytes + (u64)peer_stats->retry_bytes;
 			STATS_OP_FMT(AMPDU).vht[1][mcs] +=3D
 			peer_stats->succ_pkts + peer_stats->retry_pkts;
 		}
 		STATS_OP_FMT(AMPDU).bw[0][bw] +=3D
-			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			peer_stats->succ_bytes + (u64)peer_stats->retry_bytes;
 		STATS_OP_FMT(AMPDU).nss[0][nss] +=3D
-			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			peer_stats->succ_bytes + (u64)peer_stats->retry_bytes;
 		STATS_OP_FMT(AMPDU).gi[0][gi] +=3D
-			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			peer_stats->succ_bytes + (u64)peer_stats->retry_bytes;
 		STATS_OP_FMT(AMPDU).bw[1][bw] +=3D
 			peer_stats->succ_pkts + peer_stats->retry_pkts;
 		STATS_OP_FMT(AMPDU).nss[1][nss] +=3D
--=20
2.43.0

