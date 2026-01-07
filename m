Return-Path: <linux-wireless+bounces-30419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A84ECFC236
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 07:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 211ED30141CA
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 06:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5841B9475;
	Wed,  7 Jan 2026 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mBXTUiUw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VW3BInhQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FE10FD
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767765765; cv=none; b=qy3BjCXTDmkBVEY6kBPlP2VC1UNq6O4wPtDGmCwQykQTK/G647DIlz8oRK/yvjjZ/oRGC9hPISwUCHFcAGLudj0XEvJB/rs8z50WI283LxMvi3ObJfDzUIHURVFhOgeAKzNP/3jj/fh65LNgqjfFKbDNI+htqBh/0ROTXWygkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767765765; c=relaxed/simple;
	bh=Re+VdTYjvBEugsTEoLzXRA9ECQFb2SDg6YsAEZYwv/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RckwiZcqaJjB6ymuAIdAmMhbC0+8NWHU/hOZO5YPWeBtygBHNzQ6LwRfeQvF2OJ4MJPsCDjZObMF5psyVLeM8iBAnOro5hSnYna+zs5jy0OGVY0SwLfEQcgVz1Nus61AAW+Hbzgc12gW8KGXXxSAo1vE7AMS1/D12JQlxGJczXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mBXTUiUw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VW3BInhQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6074mDXQ1643104
	for <linux-wireless@vger.kernel.org>; Wed, 7 Jan 2026 06:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q+QPlNBjT4jczmwp4hItvR
	TCbrlQ/Q8cDIX7csc7JP0=; b=mBXTUiUw1aQqt5IAAbrcMKtUlKf2iOuaIUolPU
	IbFWmlAisWNLrVlVE058pQp+FNph2+h2G8drskjDTbjU1mfv4iCnIVCLcN39sEus
	u4oCW0AijTwUOhvn0JRxsPkjFV8HHo/lS+e9KYHYZP7UR+J3jVfmZ6ys2ScKmnuX
	GdO2tFzaD5WU1ooBQU9zbUZPvv/UVb8jpR5mMoJacM2qf4s+fmJc3yCQitp1Q9gl
	GJuSMMGeX6W/Wx3NDVVeggbxzGCPMatm6LHOn3Vigxz7kvcDLOPXBWXFMBUhD+ce
	Pf8yM2IFwyBXKDEyehUWyC0aAyNG+mh7vMaBxVOlwukhyu9A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhgsfg6ju-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 06:02:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a08cbeb87eso20389045ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 22:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767765761; x=1768370561; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q+QPlNBjT4jczmwp4hItvRTCbrlQ/Q8cDIX7csc7JP0=;
        b=VW3BInhQsaOPQOSr/uEZ9z7/FCE1MP/KvZbJRndRYH2u84PKBWArjVsqnq04zq2bK+
         TdmyH1FUO2qmK3bCRoRPOFHMFRPE4pQflCfog9TSm0r8aPPRJTLSWl/yTooqxTVIvh9B
         xE8sVArnKZM5U7FZRwopT1lXgS5lv7cZWF0fVENkE87nvXM3WcBCmmiX0JnQSWX5HtXO
         2xP/HAWajyD7+g2nFXOrSRBbx5JFz3Z30vXlJHw6X+Qcif0awcIExYSU82hzNcSKof30
         DFNrynvlXV31155SG3sCq/WD14ku9O9cxloRl/9zgjfPmKLWnzncB5HURvJY/SCJiZ0F
         eF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767765761; x=1768370561;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+QPlNBjT4jczmwp4hItvRTCbrlQ/Q8cDIX7csc7JP0=;
        b=c46S6YzAZCoFVVL6egSkQfTFuH54ES+YEGGw9JOagpGucrL7U3ViuEvCDcDsB1LcnE
         ImpFF23+0Yb9TVfyi4F4VqB7o4hBX6Fi8RVvc4D/VhDb9Ku+ZSXJ/+S4a3YOEgfa0Nhi
         zT+rEaeanMKgpGek8Wsb9Ph36hubCM5nlzyK1u1exBaPIN/NmisOnawGNLMZMkyG5tJp
         o8xA3q4EbUou4wUiIdcn+Gb+grpEkyE8XhRJHTIzBf1BS36lgajFi1y3twysIG3mV44o
         3K45sGdnYoEsHyIGaNFHiKIXDJZvooticNLK+ZR+EHdf0SzqqXLd8DMP7GPqTXVZb5vu
         F48w==
X-Gm-Message-State: AOJu0Yy9J7x3rSAFF0pVy6R5aOkGIX6ZLJEVUxujbqjdF2jlNI7jjNu4
	UTZTBHCUAIDG+TZh/kUWPBlIhBz0oQp7FaY0+GKFm7w5lWEhi4KS5f2AGyh1AH9hwVBaWlTMAXh
	4npu7txZMvMGW6i1RTV2VZOy/f9HszDtO9MexuBbdxQmV6YI0t48fvIw4+OAT96h35nl2hot3Dp
	3oow==
X-Gm-Gg: AY/fxX6kB7F94E/tx/hjBHrPoCe/7EhiohbUZxzx/45tkR6Soy60gnEbAB6qF8mRFhT
	ukE9mpF13MXGy84EMZU04koesaDeAkNl5aFN83GtyTDiFTij9A+tbsAE7ePvCunJFV8DmUGQ5PX
	oR9pwxQvG17V78Gq1eyVqCJs1/7pN8nz+fVLq+GBvTp4GJs2g8cdW4UGFjRp5gNmnDKGnyRXecN
	3As85fRLExyB4uBnI8If8HJBn6GIYP2vtLSSQaf9SwsGPr/98NmdZi4FWqInc0pWxT6it/yeU9U
	5FoMTtcSwPhFce+2Y7ZGUSrGcNT4VtWO+a0zgPb2wiII4RAAT8G6+QumEYv4adiwhYWDjPmk+lN
	u0O9glogKebALBQrXgwqG+VlhUkvEHGbWQb7wl6aKtf9bkZT0cOSJkKuS8utqNCXQCG4ahmvyl9
	Su1lnEGTvduzKBlOhuuLam7QOAIZZw5V+XVyAlNyHIMg==
X-Received: by 2002:a17:903:234c:b0:2a1:325d:821a with SMTP id d9443c01a7336-2a3ee4c2cc2mr10425405ad.60.1767765761196;
        Tue, 06 Jan 2026 22:02:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1XWXNrPSuKcZI7qNeK/ZZRAT2ATb079o65VjHGxrGtLTKcPKC7wkVMgsawt3Bw2oKBYlphw==
X-Received: by 2002:a17:903:234c:b0:2a1:325d:821a with SMTP id d9443c01a7336-2a3ee4c2cc2mr10425175ad.60.1767765760594;
        Tue, 06 Jan 2026 22:02:40 -0800 (PST)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48c2bsm37999395ad.26.2026.01.06.22.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:02:40 -0800 (PST)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Date: Wed, 07 Jan 2026 11:32:35 +0530
Subject: [PATCH ath-next] wifi: ath12k: cancel scan only on active scan
 vdev
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-scan_vdev-v1-1-b600aedc645a@qti.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPr2XWkC/22NzQqDMBCEX0X23EgMmv6c+h5FSrpZ60JNapIGi
 /juDZ57GfiY4ZsVIgWmCJdqhUCZI3tXoDlUgKNxTxJsC4OSSstGahHRuHu2lMW5tSccOqP1kaD
 s34EGXnbXDUwahaMlQV+akWPy4buf5Hbv//hyKxqhHmitxm5Aqa5z4nr+mBf6aapLQL9t2w9gk
 TR3swAAAA==
X-Change-ID: 20260106-scan_vdev-94d8cf5a667e
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA0NyBTYWx0ZWRfX9ZfrZkCDyu0Z
 9NXldBYK8rFvFZkh8DYPkmmh73o92o32JVtp8mcYHj/8GYLPnOpWZwA5i7OQ9Uho/jijIE7Rm6s
 9dVR5pfCoR7NGKYVFZ1H4Qwdh16UNiTQLXQ5ixTIUH730qL4lRtZTv3NhJJ9HWwRcJnLP8edR5i
 pufSikCmUWVVruTHeegL+McakdIoFbD+w2N0R/jhG17MmXxl73CDoRPmXjVgzrN6u+2jbGsiXVC
 uzItmgJG5AcVKGyERPF7qog3jtGsjcIuwkQiXlwq1repC+25LmKLegJP2M8q2KJidMC/GGe+d/q
 dZvVlDbOrwTpO58nGhVS4X51ot661tXAWrxx3Yx9EMYw7YMgQWfJxUf0LwoNC+kosKBP44ajuAo
 pznSyTDvksWA8HqHBaJMgUHUeSheLgadG+DgedNTobZ3cgI5KkzlPHR6lpsv/aasd7IiI74RRvA
 9ca5t/Ix3YIkkkyPVXQ==
X-Proofpoint-GUID: LRgmMOc_B5M5ap2McdZwwD1Qergl7WcR
X-Proofpoint-ORIG-GUID: LRgmMOc_B5M5ap2McdZwwD1Qergl7WcR
X-Authority-Analysis: v=2.4 cv=Abi83nXG c=1 sm=1 tr=0 ts=695df702 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=d9pQKImnaTiox7jRA24A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070047

Cancel the scheduled scan request only on the vdev that has an active
scan running. Currently, ahvif->links_map is used to obtain the links,
but this includes links for which no scan is scheduled. In failure cases
where the scan fails due to an invalid channel definition, other links
which are not yet brought up (vdev not created) may also be accessed,
leading to the following trace:

Unable to handle kernel paging request at virtual address 0000000000004c8c
pc : _raw_spin_lock_bh+0x1c/0x54
lr : ath12k_scan_abort+0x20/0xc8 [ath12k]

Call trace:
 _raw_spin_lock_bh+0x1c/0x54 (P)
 ath12k_mac_op_cancel_hw_scan+0xac/0xc4 [ath12k]
 ieee80211_scan_cancel+0xcc/0x12c [mac80211]
 ieee80211_do_stop+0x6c4/0x7a8 [mac80211]
 ieee80211_stop+0x60/0xd8 [mac80211]

Skip links that are not created or are not the current scan vdev. This
ensures only the scan for the matching links is aborted and avoids
aborting unrelated links during cancellation, thus aligning with how
start/cleanup manage ar->scan.arvif.

Also, remove the redundant arvif->is_started check from
ath12k_mac_op_cancel_hw_scan() that was introduced in commit 3863f014ad23
("wifi: ath12k: symmetrize scan vdev creation and deletion during HW
scan") to avoid deleting the scan interface if the scan is triggered on
the existing AP vdev as this use case is already handled in
ath12k_scan_vdev_clean_work().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: feed05f1526e ("wifi: ath12k: Split scan request for split band device")
Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2f4daee9e2f0..950ca7536612 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5606,7 +5606,8 @@ void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 
 	for_each_set_bit(link_id, &links_map, ATH12K_NUM_MAX_LINKS) {
 		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
-		if (!arvif || arvif->is_started)
+		if (!arvif || !arvif->is_created ||
+		    arvif->ar->scan.arvif != arvif)
 			continue;
 
 		ar = arvif->ar;

---
base-commit: 631ee338f04db713ba611883f28e94157ebb68e5
change-id: 20260106-scan_vdev-94d8cf5a667e


