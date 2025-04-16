Return-Path: <linux-wireless+bounces-21582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A49A8AE15
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 04:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D3C1897926
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ADA229B12;
	Wed, 16 Apr 2025 02:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pykj+XsY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94040228CB2
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769858; cv=none; b=f9PRSmv+K9hs+EFOJGLWkQNGp8jlRtNE3RS9ASYi2q0oZWYLfQrKhfIo31+p9FbWFleBaC2crkmEfZdWrAE1EME/CnLCwErbGhslBM8XKW+5FpCaTwrv8tkQa2KQJbO9UKXcLeNl+dUHZ7u1XfN4VpvnInTG1oPvFr9d3iaElP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769858; c=relaxed/simple;
	bh=TCu/esLRvnju6BBTAd+DBaD8yG2OnR7uSbNVaay6mQM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bENrsCRwg6tZwgpHeTzD0SF7cpbfODSFFnuItbtdbx63FJE6IQ8OPRe18qvpMIX595PxKJ4/B4/BLpC0VuejpkgwYgmSr3SCmnUWszVtPi0fAF+KyoX0mo5XEx6O68u3oJSteURZnB7n50gYP8086T7U4l6OzgvOPe9L9rMHZcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pykj+XsY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FI2hZj002474
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=OrtISGEA3SFy
	W8S+AUyrjuUbU86NuEPTPudr+ZzNkBc=; b=pykj+XsYC4ist0zjU68oq3phgWSh
	VDktj9kMd6PtJO7K+KLA+oaDdknxRDniRi7FHDQX6RWPUTzMLATmkTgylPSvvs+o
	hwGiytCRXNZdHS81DArRmTOaJQoQ5z5eEa1BWQqWvb7RkiZrphAGjNg/FDxA8Lh1
	qcDNrD1hFFcg7ctDGxnnkLi/JAb9yKg6MqtVqNKx4ogDcOn0lcvJIISbiKM39Oaa
	8V49rR1TF4TEFkpm/yd2QoSufRJ+Wn5iXQLdvb4DiArMs1UGXUls4HoqCYsNqKa7
	Fax3GypPklYEFz0+JXtMCJ1fnbmtMHBuwtllP/aoz0jb7tqa2Sxzk0NIRA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf4vj42r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:17:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso8482890a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744769854; x=1745374654;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrtISGEA3SFyW8S+AUyrjuUbU86NuEPTPudr+ZzNkBc=;
        b=sqQDN7Qh/1U0rL/VB6GLcmd1fSHjrrYJKTGnHPvzRTBRK5Cj/oaAIhRxwjEN8fexYK
         B0AFuwI0pozIsy/u2hbVfF4F+tRU+tP4s3RXywKPmdM+kE1aZpv8mlnvCUM5DfdAOBEA
         3Lw5nuV73MytPh9F1+BiPYAqmYtP9EI2xTu0Q9VqRvTLDEfm8olBOxqN/q6Mg+5ZQWWO
         faXaJW4PSTp6dX3pnDvoQ+7LDFgybqVhgRNzFefNck0NkIo1c3fGZsI9e9Vay6lyf/y8
         eINyF9RTAcr6l5kQS92vNT+WKEN2nQpmvG3Z1NvFi60UHVA8Hj4e0r/nrAI+G8a5j8wm
         sbnw==
X-Gm-Message-State: AOJu0Yw3sLnL77+QSrQlaODTXmnPyshjHHUf0mRc+qM/2s6hGPVc7nFQ
	Wmil8Iz4CPF1zrhF3XAmGeCg4IQtsg/OHjyFAqWwMPv6fLa8WldGZVdKf0CDZ6zNa6SjIfFwjiu
	KF8UVWk7gYv95h2+zKB9yJiQ+iDb2E+tQNLhzMXs5af5ttpdVz8KVj8pBlU3K/mrNSw==
X-Gm-Gg: ASbGnctM4ptv1Xbbl2pNsrXUI2HU7Btw7GbWbIFAc/GsxqxcVmhHMlKncHxne77rCFU
	mKadNjOqKoylPd1Yt6cJF7hheQP5Pfnz0Za/fMSh1CslYMZAzWMcDoY78Igq1GI7oii3jOPmj1N
	pEfma9/BRcdCJ7YYBczMNJ4bigfHFko9FTVNvTjxh/JXBlBlmCW3qWXkCvR741Lt6Hyk0roUix6
	iHSlKjwZtOoN/KxNm0xbp0dMjZ8I2l3W9J2rh6wHIG9MfcuHdJt/CBWfS40D0MsQkLp6yaesA2S
	NLEwduwnFnh6UaOuvokXK6y7yDEufZDoVl5WmaBYtYDmtRfCYe2iQGC6ucp427n14NzBdP7talI
	R/hmo1MmnVizkCYi0NBYBTFFO5McLqJPn0fCAzQDd2LbTmQ==
X-Received: by 2002:a17:90b:2811:b0:2ff:6fc3:79c3 with SMTP id 98e67ed59e1d1-3085eeb4950mr2356144a91.9.1744769854632;
        Tue, 15 Apr 2025 19:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbhVTPuLFueShCaT/rFALm6H1O4ogb8Kyz9h3ZBq3IoBywGStUHAirdJA2BDDW/kE4pUxTPw==
X-Received: by 2002:a17:90b:2811:b0:2ff:6fc3:79c3 with SMTP id 98e67ed59e1d1-3085eeb4950mr2356121a91.9.1744769854271;
        Tue, 15 Apr 2025 19:17:34 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6d18sm396452a91.2.2025.04.15.19.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 19:17:33 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: fix node corruption in ar->arvifs list
Date: Wed, 16 Apr 2025 07:47:24 +0530
Message-Id: <20250416021724.2162519-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: AY14JqPyQ7YPT6rIASWEDuzuPvGb3ddW
X-Authority-Analysis: v=2.4 cv=IZ6HWXqa c=1 sm=1 tr=0 ts=67ff133f cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=FH1iE1U44W5z0wy2VbUA:9 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: AY14JqPyQ7YPT6rIASWEDuzuPvGb3ddW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160017
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

In current WLAN recovery code flow, ath12k_core_halt() only reinitializes
the "arvifs" list head. This will cause the list node immediately following
the list head to become an invalid list node. Because the prev of that node
still points to the list head "arvifs", but the next of the list head
"arvifs" no longer points to that list node.

When a WLAN recovery occurs during the execution of a vif removal, and it
happens before the spin_lock_bh(&ar->data_lock) in
ath12k_mac_vdev_delete(), list_del() will detect the previously mentioned
situation, thereby triggering a kernel panic.

The fix is to remove and reinitialize all vif list nodes from the list head
"arvifs" during WLAN halt. The reinitialization is to make the list nodes
valid, ensuring that the list_del() in ath12k_mac_vdev_delete() can execute
normally.

Call trace:
__list_del_entry_valid_or_report+0xd4/0x100 (P)
ath12k_mac_remove_link_interface.isra.0+0xf8/0x2e4 [ath12k]
ath12k_scan_vdev_clean_work+0x40/0x164 [ath12k]
cfg80211_wiphy_work+0xfc/0x100
process_one_work+0x164/0x2d0
worker_thread+0x254/0x380
kthread+0xfc/0x100
ret_from_fork+0x10/0x20

The change is mostly copied from the ath11k patch:
https://lore.kernel.org/all/20250320053145.3445187-1-quic_stonez@quicinc.com/

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index b501d722df31..7eccd9cf9036 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1371,6 +1371,7 @@ static void ath12k_rfkill_work(struct work_struct *work)
 
 void ath12k_core_halt(struct ath12k *ar)
 {
+	struct list_head *pos, *n;
 	struct ath12k_base *ab = ar->ab;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -1387,7 +1388,12 @@ void ath12k_core_halt(struct ath12k *ar)
 
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx], NULL);
 	synchronize_rcu();
-	INIT_LIST_HEAD(&ar->arvifs);
+
+	spin_lock_bh(&ar->data_lock);
+	list_for_each_safe(pos, n, &ar->arvifs)
+		list_del_init(pos);
+	spin_unlock_bh(&ar->data_lock);
+
 	idr_init(&ar->txmgmt_idr);
 }
 

base-commit: 176f3009ae598d0523b267db319fe16f69577231
-- 
2.17.1


