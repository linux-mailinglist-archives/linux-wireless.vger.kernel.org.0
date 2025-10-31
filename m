Return-Path: <linux-wireless+bounces-28432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60273C23254
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 04:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687A71A63F60
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 03:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9AA253944;
	Fri, 31 Oct 2025 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A49V15ay";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UIQ8jEUB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C47619CD06
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880725; cv=none; b=VX0BIx6jj5wHtAJGpVi50b/Q0zCuuvCYV9ILMarA4P6256QCcDy71IaEZpapCWvS6mlBJidLR3RrM5uNsMBQsdhGKdf7lw68e8w1W6rfcQdhX2QkHEYYfWJYs31Y9RU2HVoo8xCCK+yHy9qT75kQhh1xNa7yeinwHJ+JCnzF6rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880725; c=relaxed/simple;
	bh=MNd4uttjhXnPgo8Ds9v7M9zGAeO4P3TSf3+w7gtySDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLrH2a63EmRyV604659Hy+D7WQwUZyN10CEZ9HEv17jONTYMvyidxD5yq4oIuc2jpGjWZxGSsBnIXjabNQRvmLhPjdX3PYyEFh0UrpoaNnImSvQSYYqtKvXT/meEHREtvNk2chejErnXkjObrCtcJ6hSNl9rwbFDbt+dHpX7+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A49V15ay; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UIQ8jEUB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59ULC9ev872728
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 03:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lUXjvY7OoRdcYQcgv7P8x8g67gGxIlqbdGmnJsZIYDw=; b=A49V15ayV4g66Kl/
	R/iUdVFguJC1JTLWJIVw5O2PTKgiBz4I/8KVE9K7+GON4LGPt1FkiAyyJ3ajntud
	RUReqNop2J3ZQxt187g7zzEOreVbjm7maD4W38xuqFygx8KHbaUZEzSVVopCRnZI
	EnJUcAUdLDCUceBj5fksRKdxDvqdwUezSrWEzi6HCnCPSmTU1rwP8JSYjpNckmz1
	pAL8u14GGI0eJ4IJZ9GfPpetjINpPqssixkSg0Sk0UjS7MSovKh59oIUJffrNqLZ
	rYY57NOxkB8b5qq+sVCku6X4bRES1Ufwuahyfe61zGh3gXf1A5gYltGnMjFHbSL5
	WXZ/qw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4fqn0qs7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 03:18:42 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-3d4410ec086so4699651fac.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 20:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761880721; x=1762485521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUXjvY7OoRdcYQcgv7P8x8g67gGxIlqbdGmnJsZIYDw=;
        b=UIQ8jEUBETbG8zvhqBQfAK4lk/T87wuxGYw9+CweWPEPb+CgZixJgRyw8yHp95busU
         BqNnouux6k9SFQosANb9NUkOjhTuN7veM1MxgCnGsYQ2IPW5QLTIBNuG9UzlYwGgRkbw
         JIDdef4cuuwkf3NtB1N2ElT1wqO8RQfmGtcp2lamC+kY7r1j+VsUr8R5mJ3jGEtc/Kfm
         phZj5E2evE1OXEE4MfsuuCROOeHfgD3s+rDGbIICo0GaS5QlsG03S4QJcW3UI7lA6wFm
         qn+osQoSHmcFOpn8CW8MzhgqjtpOR5quaof42qaLOdmpmauV6Cnio5wkuBRmCEuqv18+
         aQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761880721; x=1762485521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUXjvY7OoRdcYQcgv7P8x8g67gGxIlqbdGmnJsZIYDw=;
        b=vbpLSFNCzif9f3rETDP82UbqmW0LALiwINrVeuoo//G6JEAjpn9Xt46+Hu+I53itng
         wO3p+PYfwoSnORirTszW6xXJXHM3Ddq6M4JqA//HbllLEz8EHYsdJkiXfG5LKrdqNnBw
         AVeHhh7CHTMOMpB+QRVFJyKXSUQGrPl6lkf++3h0w16Kw+83ykk5VWsSc14v+xM8188L
         qodWKgtU0DUI8WA6t+DxCCwyrlGIYOt2LWyVZPeeWuz7EmRRrkIEwtO2hyyhZaucoJZB
         E7wIBHdZKhKLa3aAqYlqB4gaGkgD17g+cz3VV9CvMUGvgZzU5+z8Sz/YyY4jq2Fmy7sp
         gNxg==
X-Gm-Message-State: AOJu0YxgocQnmyj39WmSz1XdrHif8+0oWEcOPIKX3spGJuNRwXxygOwZ
	ETssAV9fCsdZyEXF9MjW24oNAZi9VDbFd9kj7aQMqkIeQXvoZmEOgIBX4jtgL/2eWGsSa7EM6hw
	2fiGQQg7QHf2pgSe1T1HVPaRD9A5t2JyF1Uqhonm5r2XpmLNTT+iiCAgjqjo6vlIuKh2reWesJn
	dVdQ==
X-Gm-Gg: ASbGnct8vp6X6jU+y1Q/zZZGDSwZCUOPYdAQUEBW84mnjGlGfpOidkAVKVEvaLhof5E
	gjFKab1FVp9kSrpBsGymyNtu1mek8MKQ2Nq/hP+Mn/GyB1V+iHsJ2lT8BaPPAHSMwDwMmlM4JK4
	Mnqj7GW4Igiwo2YRxHbnpACglH4b7GK1yYHXXVW3XUt7p2E/rk9S4t1L8aAMrM0uVWowTVbIEyv
	IKSx79fSBJ+WG6b0mgMlUQWqcBZE0mU+7/pLsfBKSFUYlx4/GmFuui91d9jm7cpehuOWG9XbgZ2
	EHbKia29IDhefVZ5dQpb03cK47cn97vshZvchsIMA1Ct4YuvyA9KxorxAiFup6x5Yxb531oCnb/
	pLKF7RMSvv3lHCU5w4B5ToI2EOA+cQ3p6zOJjmaDSmdckjx61whpcxx0nFOelS/WacLRRQZMpgg
	H6LzYlgbio5HheTk6dfFxraRifHDHhMnY=
X-Received: by 2002:a05:6a20:158a:b0:343:6c90:77aa with SMTP id adf61e73a8af0-348bcf39118mr2868783637.29.1761880078494;
        Thu, 30 Oct 2025 20:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnCeW+sXqFa++BIza19zHKtf9ItARuqpC7NRlsI0vHs1Q8l174lemlpy6YJLzFFfjp6C1fRA==
X-Received: by 2002:a05:6a20:158a:b0:343:6c90:77aa with SMTP id adf61e73a8af0-348bcf39118mr2868749637.29.1761880077922;
        Thu, 30 Oct 2025 20:07:57 -0700 (PDT)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db0a2663sm372130b3a.48.2025.10.30.20.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:07:57 -0700 (PDT)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 08:37:46 +0530
Subject: [PATCH ath-next 2/2] wifi: ath12k: Fix timeout error during beacon
 stats retrieval
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-beacon_stats-v1-2-f52fce7b03ac@qti.qualcomm.com>
References: <20251031-beacon_stats-v1-0-f52fce7b03ac@qti.qualcomm.com>
In-Reply-To: <20251031-beacon_stats-v1-0-f52fce7b03ac@qti.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Authority-Analysis: v=2.4 cv=RL2+3oi+ c=1 sm=1 tr=0 ts=69042a92 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=5huyMihl6BJtPKl8yXUA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-ORIG-GUID: Yp-cm1g6xJX2r_PCYQWqvDo-GgBtq7X8
X-Proofpoint-GUID: Yp-cm1g6xJX2r_PCYQWqvDo-GgBtq7X8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyNyBTYWx0ZWRfX1J1U8+Y0wY16
 ffI7rUirAf9wyXhSnyqK+fy+1a3aPRpIUzIINDPfstXa9erYWX5zXF/NkP1/C/nCN44fmniabSD
 BNwmNCgKPZpQIpfTjrlI2tDEa0+3t2v2oD9UwPkn1cyS9OC9tw9LQzBhAUaH7lo9i5e4NVGrBd6
 iVK5s4CHXD4mIkTHSNNzk53wjs5INAAFgMGXGUH5Jk4qJqEujD6JvH1i1b4VxU3DVPkE86213ck
 lkv0XfIHo1RtwZt8/9HLJe+fjZLHSYBbFbl+eHrt10VEDS72yqer++Rz3wayXgJYusmXQN2VNla
 VCVKTcr5mq6LtfjxuutLO0qGNfaAAzFaGmbsnUTX6EiyLYRPy9PE6dYTfGUUrx5RAymeE+wNTsR
 8U/xo52yQ/mI7+BE6tcdqt6sae6NiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310027

Currently, for beacon_stats, ath12k_mac_get_fw_stats() is called
for each started BSS on the specified hardware.
ath12k_mac_get_fw_stats() will wait for the fw_stats_done completion
after fetching the requested data from firmware. For the beacon_stats,
fw_stats_done completion will be set only when stats are received for
all BSSes. However, for other stats like vdev_stats or pdev_stats, there
is one request to the firmware for all enabled BSSes. Since beacon_stats
is fetched individually for all BSSes enabled in that pdev, waiting for
the completion event results in a timeout error when multiple BSSes are
enabled.

Avoid this by completing the fw_stats_done immediately after
updating the requested BSS's beacon stats in the list. Subsequently,
this list will be used to display the beacon stats for all enabled
BSSes in the requested pdev.

Additionally, remove 'num_bcn_recvd' from the ath12k_fw_stats struct
as it is no longer needed.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: 9fe4669ae919 ("wifi: ath12k: Request beacon stats from firmware")
Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  2 --
 drivers/net/wireless/ath/ath12k/core.h |  1 -
 drivers/net/wireless/ath/ath12k/wmi.c  | 10 +---------
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 5d494c5cdc0da3189640751b8d191fa939ac3ff5..f0994f3918f5c36380b3409f9a7889f06c8e0f34 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -1250,7 +1249,6 @@ void ath12k_fw_stats_reset(struct ath12k *ar)
 	spin_lock_bh(&ar->data_lock);
 	ath12k_fw_stats_free(&ar->fw_stats);
 	ar->fw_stats.num_vdev_recvd = 0;
-	ar->fw_stats.num_bcn_recvd = 0;
 	spin_unlock_bh(&ar->data_lock);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 41da0efaa85478fbe294f958cbcf458b5ca07204..3c1e0069be1e77007245cec2cb289212c12baf4a 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -646,7 +646,6 @@ struct ath12k_fw_stats {
 	struct list_head vdevs;
 	struct list_head bcn;
 	u32 num_vdev_recvd;
-	u32 num_bcn_recvd;
 };
 
 struct ath12k_dbg_htt_stats {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index f812da24b21e68893327d61fe0ff9deb222bd54b..be8b2943094f8f4a12d625189c11315f1397e42d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -8485,18 +8485,10 @@ static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
 			ath12k_warn(ab, "empty beacon stats");
 			return;
 		}
-		/* Mark end until we reached the count of all started VDEVs
-		 * within the PDEV
-		 */
-		if (ar->num_started_vdevs)
-			is_end = ((++ar->fw_stats.num_bcn_recvd) ==
-				  ar->num_started_vdevs);
 
 		list_splice_tail_init(&stats->bcn,
 				      &ar->fw_stats.bcn);
-
-		if (is_end)
-			complete(&ar->fw_stats_done);
+		complete(&ar->fw_stats_done);
 	}
 }
 

-- 
2.34.1


