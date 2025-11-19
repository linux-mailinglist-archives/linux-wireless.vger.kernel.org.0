Return-Path: <linux-wireless+bounces-29115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D3DC6C5C9
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 03:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E3C34E1303
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 02:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB31274B29;
	Wed, 19 Nov 2025 02:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DdMFiZp+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JM0EQCHy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935F2749E0
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519098; cv=none; b=RHNt4xYqRe5p++eeuUQX2zBgU0wYJ1hCA1S+EcVQgFKMdM/q8YQPHk0AZjYhF80EVxH+gcPCD21qkq/of8Edv5ofuxcCnAdWiDIyV5GuiIsL66XtM+A6Ch1JlPClxM4l5lK9AMyWARi/boQSjMd+7X1PlFztM8cRP+d+y8vQ5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519098; c=relaxed/simple;
	bh=71Fnbxg/19pv5yxwO0pit6ed6DFdFIZu2ss7m9N0fgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lkkudLFlhfqOukKNqEp8Yh6pbhymd1BG5qdo50DdnByw+ttTP9A/mL4IwuCBU/uk/gRKIqMHcjIBq1Ye3UgBhusJx/0Xo4HzWNtoqdFpVqCtKY21x28J2UatnODEXy88ot4jw4bfkVXuPf+XY2bOrSSZRYWwbg8RbuNkUQpTVaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DdMFiZp+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JM0EQCHy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ1u9qV3165027
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 02:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=M782Qd31NYBZNKd3a0Hfmk
	YvhogEJxqedgY0I+voOOI=; b=DdMFiZp+jAkSDWCqACBm0qefxT1ubuEVzVU9Od
	pbbpEN7Vs0i2DMBJkj6dHClPHviUis+9jTVx/pBBAuQEYgnvQesFdmjCe1VMW8ml
	smxcwKwUPNVqEIXKll9FHFRcAmyQZ19nG+eVyqS5I4EYswaUr4Oa8AnjoJ0U+vVE
	kItKCN9xFT/NQD0yR8iqgbR8Bw9Duf+jljtpt9+XWXnAEB2TyR8311o7vqDxVXxy
	8Obu5pxzLM82TLbX4Zjrcp8wGm9XUC+ZxFRIjRoJOl65zwWXwsGAr7UddxlI5dBN
	MxaitnLTDGC40TlLaIlllNOblIMTkWRB0USvj9xi1C+pND8Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agvqgsf1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 02:24:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297dabf9fd0so80740855ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 18:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763519095; x=1764123895; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M782Qd31NYBZNKd3a0HfmkYvhogEJxqedgY0I+voOOI=;
        b=JM0EQCHyh3jnC+La/kbh7qOj4PR8cjQZoEDTeOu2zFGhbrMWQjl7CY3yVFcJD50gPY
         xvZzJ9ve0ZYToW5be/nN5mLkxfhWphIefLPgZhtIDO10n6kLD47OKh5pkxDYJvvfrLsX
         f913a4UmDsxuj1PKQmkcOFG5QgX3Evn4ROQz9zzpiLPbw4X/BP4WpNTHxTqlLDiBTSsZ
         aqdii8UjzqUWOPYIF0uVFYrcbtfJ0VRSdEE0WycrsaIaBJHTGOqIr6/RRfG3kNbr/ruz
         D4NFqXu6WOId3mv4X+IiLfpOHht/4+FW2gNiL2o8fDdekGcV1uJ0g91iW01IBddpa32A
         3M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763519095; x=1764123895;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M782Qd31NYBZNKd3a0HfmkYvhogEJxqedgY0I+voOOI=;
        b=GYDI5xRYQGDjWoTMpgHlaeIvVazflSzTppPL2yiXPL8BvZyKy+ieVo1Pnznxdg6HF0
         Hk1buJkyTHZRtkFVdiJhV7ZHfm472/C3FYkE0aquYBcATg8PzMXPt9USrKVOoUIl+MRd
         60cPhzyID1erooMjDNbIvbD1FdWlBa1lKeZYoI+WZGMZdC4zFLknBH+ECZKYfAd8yz70
         MVurIHPdwks8QigAgVs7xlqD02mPa01LpeaPe8xqRrxrlPi7XafwAowDrNWevcazp1Uf
         POuZsItPaSyYxeQMULhwcDS+u+Y61yUu3KUqAWeaahH43lsf9KaExA26Y6Y4prfR3z2a
         BbUA==
X-Gm-Message-State: AOJu0YylNv1bPkA2/DuriwSe6AvxlViCsNGz+yZJFw3moMZjU6i9Su2B
	RGbnuva4kYYIh0BEjqEHUynpuSRXtA7VXMuiHtsVIiCysuM0Wf5N2VZch3MyAkLgSPR8YWv9RUp
	HDeiTnuDdAOKI3b7x/ziqn6256kPHvoBSUSbO+giK2f2Fe146KuG6ktU9OnOsikbG8/2HwygrDd
	EK0Q==
X-Gm-Gg: ASbGnctiCR0//KdEHP8MUcaqRoVmc95ErIH7ahwUpiJlFBknVEYzlduda0npUMzAza/
	0UraLurztAM/OlvmSWaq1bNnrhOOzOVNG2S/IoeBT3kkp5FddSnQPhoYUK7C+Db3Ea1xC853YX1
	+O4g9NyNwvU5Yx7Lx3ctUYNjuFaa7uRDAA6bCbtbscvUtKZTbKjywPfCUDvzvlPZF1Had8MSNkB
	CjZLmufYvptUPSqlk4CtEZFmp010sTGkgER8UHJYxEWD6LodPQQa4F/VpmDxes4w9Crd6+DYMtH
	MuTxRTeNDfyspk2ZA2DbrvTJpLBj3XP8fiqErmJpp709bFg2BYEkxtq1SNsNUjCt0GmcBjaSdqj
	FPG+VfwmFFhiAdhVHcmjoIPsSCMCHB1GFDID+06N+E2vX8Alyqe2m6jRcIz0R1Ow=
X-Received: by 2002:a17:90b:1844:b0:340:b572:3b7d with SMTP id 98e67ed59e1d1-343fa528260mr20092898a91.19.1763519095255;
        Tue, 18 Nov 2025 18:24:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ1PLktoZEBxjtT9d5F+2ee2MpmVNcVOT9F5afI4O1pAmtd8OW64Xfxr81QiqzVrZh6bnarw==
X-Received: by 2002:a17:90b:1844:b0:340:b572:3b7d with SMTP id 98e67ed59e1d1-343fa528260mr20092875a91.19.1763519094734;
        Tue, 18 Nov 2025 18:24:54 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bc111e72sm811857a91.15.2025.11.18.18.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:24:54 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 10:24:47 +0800
Subject: [PATCH ath12k-ng] wifi: ath12k: move firmware stats request
 outside of atomic context
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-ath12k-ng-sleep-in-atomic-v1-1-5d1a726597db@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAG4qHWkC/41NSw6CMBC9ipm1Q5gGSnTlPQyLUgaYCC22SDSEu
 9uwcO3mJe+/QeQgHOF62iDwKlG8S4TOJ7CDcT2jtImDylVJRAWaZSD1QNdjHJlnFJckP4lF7rh
 ptanysmgg9efAnbyP7Tv8alAna5C4+PA5Xlc6An8crISEWlelLlp9Ka26+Riz58uM1k9TlgDqf
 d+/pAGJGdQAAAA=
X-Change-ID: 20251114-ath12k-ng-sleep-in-atomic-efebd6a7054b
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: INb4DqETt2EohUKtOtzUZYIs_0abuSHO
X-Proofpoint-GUID: INb4DqETt2EohUKtOtzUZYIs_0abuSHO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDAxNyBTYWx0ZWRfX4GWr1lUy83GP
 IfHtq4fxApYkomjFUT2HgLvXFUOe0RE0MFMCG7qHVtVd9Leaxp+GHtAD5/CSkA4M2NpuhG0Ux6b
 sq6OZCnd1femNNrPFxfpInM2mlnRNzp5cW6z5CdCEJQZIP3AMhjjUiazZcpFhcRHVw/+mqXb9wN
 HegZBnixnJbzqA2u2kvpIfWz41FC/56Hr7yRdXiAwdV4sybPV0OhVByTTpw8R3+evg6E5EriYsi
 o5SKMW1OpcOgREXC90tQwri1MA5XeU8oEq16iyQyZSkqSyu3yGG+JGiQVbmEtD/lxYl7+C+Xgr1
 vh/Gx4dqrDMMzEhaf6K7Vyz1NLQtCAqas650hs7gDDXP+2QQS3Ld31j0giHYM1F7Wy7BZ23NQTu
 fhwRxPc5MsyazZqm0dmJ30zUALkN+g==
X-Authority-Analysis: v=2.4 cv=LMJrgZW9 c=1 sm=1 tr=0 ts=691d2a78 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=1JFbABHWMOtqWNdtv10A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190017

In ath12k_mac_op_link_sta_statistics(), the atomic context scope
introduced by dp_lock also covers firmware stats request. Since that
request could block, below issue is hit:

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:575
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6866, name: iw
preempt_count: 201, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by iw/6866:
 #0:[...]
 #1:[...]
 #2: ffff9748f43230c8 (&dp->dp_lock){+.-.}-{3:3}, at:
ath12k_mac_op_link_sta_statistics+0xc6/0x380 [ath12k]
Preemption disabled at:
[<ffffffffc0349656>] ath12k_mac_op_link_sta_statistics+0xc6/0x380 [ath12k]
Call Trace:
 <TASK>
 show_stack
 dump_stack_lvl
 dump_stack
 __might_resched.cold
 __might_sleep
 __mutex_lock
 mutex_lock_nested
 ath12k_mac_get_fw_stats
 ath12k_mac_op_link_sta_statistics
 </TASK>

Since firmware stats request doesn't require protection from dp_lock, move
it outside to fix this issue.

While moving, also refine that code hunk to make function parameters get
populated when really necessary.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 44 ++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index aa80afebb69e..3649f58fef84 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12792,10 +12792,12 @@ void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 	db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
 			  ar->ab->wmi_ab.svc_map);
 
-	guard(spinlock_bh)(&ar->ab->dp->dp_lock);
+	spin_lock_bh(&ar->ab->dp->dp_lock);
 	peer = ath12k_dp_link_peer_find_by_addr(ar->ab->dp, arsta->addr);
-	if (!peer)
+	if (!peer) {
+		spin_unlock_bh(&ar->ab->dp->dp_lock);
 		return;
+	}
 
 	link_sinfo->rx_duration = peer->rx_duration;
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
@@ -12822,35 +12824,35 @@ void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
 
+	link_sinfo->signal_avg = ewma_avg_rssi_read(&peer->avg_rssi);
+	if (!db2dbm)
+		link_sinfo->signal_avg += ATH12K_DEFAULT_NOISE_FLOOR;
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+
+	link_sinfo->tx_retries = peer->tx_retry_count;
+	link_sinfo->tx_failed = peer->tx_retry_failed;
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+
 	/* TODO: Use real NF instead of default one. */
 	signal = peer->rssi_comb;
 
-	params.pdev_id = ar->pdev->pdev_id;
-	params.vdev_id = 0;
-	params.stats_id = WMI_REQUEST_VDEV_STAT;
+	spin_unlock_bh(&ar->ab->dp->dp_lock);
 
-	if (!signal &&
-	    ahsta->ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
-	    !(ath12k_mac_get_fw_stats(ar, &params)))
-		signal = arsta->rssi_beacon;
+	if (!signal && ahsta->ahvif->vdev_type == WMI_VDEV_TYPE_STA) {
+		params.pdev_id = ar->pdev->pdev_id;
+		params.vdev_id = 0;
+		params.stats_id = WMI_REQUEST_VDEV_STAT;
+
+		if (!ath12k_mac_get_fw_stats(ar, &params))
+			signal = arsta->rssi_beacon;
+	}
 
 	if (signal) {
 		link_sinfo->signal =
 			db2dbm ? signal : signal + ATH12K_DEFAULT_NOISE_FLOOR;
 		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 	}
-
-	link_sinfo->signal_avg = ewma_avg_rssi_read(&peer->avg_rssi);
-
-	if (!db2dbm)
-		link_sinfo->signal_avg += ATH12K_DEFAULT_NOISE_FLOOR;
-
-	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
-
-	link_sinfo->tx_retries = peer->tx_retry_count;
-	link_sinfo->tx_failed = peer->tx_retry_failed;
-	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
-	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 }
 EXPORT_SYMBOL(ath12k_mac_op_link_sta_statistics);
 

---
base-commit: 7cd7392a07782b8ad4aa6360e4be1967af2eab04
change-id: 20251114-ath12k-ng-sleep-in-atomic-efebd6a7054b

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


