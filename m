Return-Path: <linux-wireless+bounces-31288-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MGzJ/nEemmY+QEAu9opvQ
	(envelope-from <linux-wireless+bounces-31288-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 03:24:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D35AB18A
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 03:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8368A30125F9
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 02:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320533F361;
	Thu, 29 Jan 2026 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aqb/Mqty";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YGaY2kCa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9354739
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653467; cv=none; b=HZx+fVy7LaeJH+GpAgfYH5qlst+foo1+Q3LurtVAKEBhOFzrr0O4wXOaOAVmRWt+FJ4VUyWWTaQ7sVDiJHgv6QTyjdmRAcnjs7NxiG+TiiFb7NICqSEWO5i7i8lLlHTlHSGPlNy1Bi60xoT0Il1UNCLU7KSyGMmN+yFyXTBlhGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653467; c=relaxed/simple;
	bh=RhuKQ+WfiWRRiYAhaWTDU7LxmzOtU3OQKFx1658AllM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGyYcDlJlLD5gXC+BOIPGo8IGg52yAhbgfmuZKNp1ravRnADlxOWAZT52J2N8TQvsZSX8AKwZsoE6JojVFlM64TeqzvJI0EUBnb1eVT1C1aCkUl7OkvC5dRvLGPA1ViHlhVR7E/gDh3ffjtExjWNWIJZOylno3y859ZoWxGq7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aqb/Mqty; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YGaY2kCa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SNgsV6590367
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pY13GG9DO1zh5OeFJun0oKXROykALiQB3J38i+zIA6Q=; b=aqb/MqtydqLSOvSe
	LT9y4aprlaU3zwOc8p0a5TtoZOE8NccCyA//1McL1j3b/pUo8UaB2kVGrdGe9h/s
	CXeDLexydqP542UZgUpE3giyCu8K7Yscyd2WF9r0j1f95iVIdpXX3lmDoqE/1nFz
	dsizTAssVqFap8q+KwwhN4Y2Ffv92oWxWRpZ1Ru/fV5RfWwHmSxDByW3JC4kh+hy
	XUtoTWb0etybeaYgcsf8i2gOZScS43Jk/1RJnz27D2k05nKs7eISZlM4XhcMt9jY
	U2M4E8hTdkuvlKUsTqHKv0S288EexuRMG2Ze61eNwR0jIlwRYspJLH3gng8zNhLm
	Ib52pA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byna7huff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:24:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a784b2234dso12636335ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769653463; x=1770258263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pY13GG9DO1zh5OeFJun0oKXROykALiQB3J38i+zIA6Q=;
        b=YGaY2kCajXEzZoZaAyRtvJXui+mJO4lAxG9qje+s9kxGA4d54wKCygJ0xHuIEaU4Dm
         UlnPaxV1PIgT5l3KoZp0XykY/ldQRqPSSb7oGQTA4FrwBbIbdA0nOyWDgSgd2WgeX9MT
         PxRWI61Hr3Np2S+GxuDGBxnqzhKg97BjC+sLMLuoDV+h9kICPfe8UxB+oFRvrdUoPN8U
         zIDDTMBfj5AoM4LqpUV3LNW3GYoI9JePL3RkdqQPZyco7VFWauOBew6nyjCZ6kKZpQib
         vuRHB4s17KCUfl+CUMqvGUgq6w+yXaybubjTgb4MDQWNeDMMErOcEyYEXjfNGmwtu/fT
         RSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769653463; x=1770258263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pY13GG9DO1zh5OeFJun0oKXROykALiQB3J38i+zIA6Q=;
        b=MRTQV3jSSchC9BLE5AWsYLvVedn1hjSUH97oq+W94rivktKNFDKCBg+XAYjRAKu7Ql
         OOFcNAa2AdQfreOXUH19PKzsl4E8K80THOCC7Zwp9bJVKt2BwyFpsDLffTs3GgshAJ7D
         9mrMx4eZO6mwhVG0mQJ4H97jjaMoGhbbhrtgO5f5+51RA5TCDuGLbyM0DrC28oUu9EYN
         44eSEKeQJgPz67IGV3JA9IPPt4LlVshRm1y+XRfDTLo6uwXacmeBHWTD7e5axK8v0BIW
         MPw7SMqpIRkzwVcoPHVO1gkuEn5Nm5CzApasHwRe74pqud/2oK+sH7069HC+J0k9o8CY
         jpLA==
X-Gm-Message-State: AOJu0YwJo9FhwaWGrrIBuS4GYezjevysS688HGgPat5aZNS8qQmPhDLd
	DO1jauLrCGcClPC6Wq10sjDByVVESpw66X1LLfjjls61wLaC8y8aIp54oECkWMEpu1TT9edxV7V
	lUXLE09qHIQO3CPVKdzp5t33q6fOBA90KqMpFT+8qSKCyYYxBPXEn54mGElVsioK2kXb99UIKd6
	sUnzov
X-Gm-Gg: AZuq6aJGnyQNjvFU+l9DRbUJme0pEEeC5BrPHyUigIkV8YXKnhStIf7gdbOxK6P2MYB
	oT+hdEfkOACQP+Zk8/1yFdKIU0cyBaTE1RaIkTkeo0OI+TkT9J31DNoBs2CBNKNVZfIfzMinbno
	8KgsvwJa2xWggLaf+mLjISJr05tiqGHmJTHq80LZmOzZL6RJPHGfOcVoHL0mDId34aImN58+ysd
	wzHdqY//dg3xZjxGvMu6Zuc+sRKXsr/rB1JwR8/XJM5H58DTVlXSRcQAxGkfRLgOzXzt91Grd4f
	ovyTd+OlYLHEkRAi1CFQH/NAt5mjLBCzfcLkmdRPHZMjZS+DQhW+2Jbj4xLeJMDgIT4ETTTwdi4
	+XA0IGRft4BSggJET3lgC8qJPNIe75IQB1C/lHLU8lZbolMvbULKwtlFJKwss87Q=
X-Received: by 2002:a17:903:1a88:b0:2a0:f828:24a3 with SMTP id d9443c01a7336-2a870e18d4amr75738365ad.28.1769653463387;
        Wed, 28 Jan 2026 18:24:23 -0800 (PST)
X-Received: by 2002:a17:903:1a88:b0:2a0:f828:24a3 with SMTP id d9443c01a7336-2a870e18d4amr75738095ad.28.1769653462790;
        Wed, 28 Jan 2026 18:24:22 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d92a9sm33851035ad.69.2026.01.28.18.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:24:22 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 10:24:05 +0800
Subject: [PATCH ath-next 1/2] wifi: ath12k: use correct pdev id when
 requesting firmware stats
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-ath12k-fw-stats-fixes-v1-1-55d66064f4d5@oss.qualcomm.com>
References: <20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com>
In-Reply-To: <20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: HlSuRFdeD6l-ZGlB2QzS7X1k40-npxkT
X-Authority-Analysis: v=2.4 cv=J72nLQnS c=1 sm=1 tr=0 ts=697ac4d8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XAc05n2krQg3agKh30oA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: HlSuRFdeD6l-ZGlB2QzS7X1k40-npxkT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAxNiBTYWx0ZWRfXxoC02ZDb3K6g
 JzvvpuQidtrkOU7uiVb+JVbIVrRw9ShZATvsY/gCv9NMrXigxQbl2IaWX0se7TaL9KhwZZGhicR
 6cETjn2CFOQv+R/wA7Wj5FUhqT0VQcVSwlYvx6Dlq593sHtL9p/oXFZKtXyh/gLSOiVbwlm947k
 p0AtgdCggm6ZClNNvCRVg/RBEkpBKjE+/7F/lXvRanGbwyB2SkKhWlj8znT8du0Vc6PYUeijnQe
 2AuDCH5VsVSTVM+MU1FCCkKFbNlj2RUzn08BWO0Q4Df9RT6UzSFptjsbJcaX5f6VPmhw85ajAR4
 uXO6LoOfoZpncYfYs31HetxXQX+kVRhxAhG5mHlBs7Ruar8UN4W/XEEEPrQYdfE6JyqfIj3vZ3a
 HIe6HoS+6dNMtpxYIlNq/VEnzzvhGAGV/yy+tMXGFDVe18vpJ8bPXkhfkb3ciY4Een+yDR7QmMS
 I8KSJeoVotkCMIgWANw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290016
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31288-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 16D35AB18A
X-Rspamd-Action: no action

To get firmware statistics, currently ar->pdev->pdev_id is passed as an
argument to ath12k_mac_get_fw_stats() in ath12k_mac_op_sta_statistics().
For single pdev device like WCN7850, its value is 0 which represents the
SoC pdev id. As a result, WCN7850 firmware sends the same reply to host
twice, which further results in memory leak:

  unreferenced object 0xffff88812e286000 (size 192):
  comm "softirq", pid 0, jiffies 4294981997
  hex dump (first 32 bytes):
    10 a5 40 11 81 88 ff ff 10 a5 40 11 81 88 ff ff  ..@.......@.....
    00 00 00 00 00 00 00 00 80 ff ff ff 33 05 00 00  ............3...
  backtrace (crc cecc8c82):
    __kmalloc_cache_noprof
    ath12k_wmi_tlv_fw_stats_parse
    ath12k_wmi_tlv_iter
    ath12k_wmi_op_rx
    ath12k_htc_rx_completion_handler
    ath12k_ce_per_engine_service
    ath12k_pci_ce_workqueue
    process_one_work
    bh_worker
    tasklet_action
    handle_softirqs

Detailed explanation is:

  1. ath12k_mac_get_fw_stats() called in ath12k_mac_op_sta_statistics() to
     get vdev statistics, making the caller thread wait.
  2. firmware sends the first reply, ath12k_wmi_tlv_fw_stats_data_parse()
     allocates buffers to cache necessary information. Following that, in
     ath12k_wmi_fw_stats_process() if events of all started vdev haved been
     received, is_end flag is set hence the waiting thread gets waken up by
     the ar->fw_stats_done/->fw_stats_complete signals.
  3. ath12k_mac_get_fw_stats() wakes up and returns successfully.
     ath12k_mac_op_sta_statistics() saves required parameters and calls
     ath12k_fw_stats_reset() to free buffers allocated earlier.
  4. firmware sends the second reply. As usual, buffers are allocated and
     attached to the ar->fw_stats.vdevs list. Note this time there is no
     thread waiting, therefore no chance to free those buffers.
  5. ath12k module gets unloaded. If there has been no more firmware
     statistics request made since step 4, or if the request fails (see
     the example in the following patch), there is no chance to call
     ath12k_fw_stats_reset(). Consequently those buffers leak.

Actually for single pdev device, using SoC pdev id in
ath12k_mac_op_sta_statistics() is wrong, because the purpose is to get
statistics of a specific station, which is mapped to a specific pdev. That
said, the id of actual individual pdev should be fetched and used instead.
The helper ath12k_mac_get_target_pdev_id() serves for this purpose, hence
use it to fix this issue. Note it also works for other devices as well due
to the single_pdev_only check inside.

The same applies to ath12k_mac_op_get_txpower() and
ath12k_mac_op_link_sta_statistics() as well.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 79e7b04b5388 ("wifi: ath12k: report station mode signal strength")
Fixes: e92c658b056b ("wifi: ath12k: add get_txpower mac ops")
Fixes: ebebe66ec208 ("wifi: ath12k: fill link station statistics for MLO")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index cdb72439dcf4..46253347e357 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5264,7 +5264,7 @@ int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
 					 ar->last_tx_power_update))
 		goto send_tx_power;
 
-	params.pdev_id = ar->pdev->pdev_id;
+	params.pdev_id = ath12k_mac_get_target_pdev_id(ar);
 	params.vdev_id = arvif->vdev_id;
 	params.stats_id = WMI_REQUEST_PDEV_STAT;
 	ret = ath12k_mac_get_fw_stats(ar, &params);
@@ -13286,7 +13286,7 @@ void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	/* TODO: Use real NF instead of default one. */
 	signal = rate_info.rssi_comb;
 
-	params.pdev_id = ar->pdev->pdev_id;
+	params.pdev_id = ath12k_mac_get_target_pdev_id(ar);
 	params.vdev_id = 0;
 	params.stats_id = WMI_REQUEST_VDEV_STAT;
 
@@ -13414,7 +13414,7 @@ void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->ab->dp->dp_lock);
 
 	if (!signal && ahsta->ahvif->vdev_type == WMI_VDEV_TYPE_STA) {
-		params.pdev_id = ar->pdev->pdev_id;
+		params.pdev_id = ath12k_mac_get_target_pdev_id(ar);
 		params.vdev_id = 0;
 		params.stats_id = WMI_REQUEST_VDEV_STAT;
 

-- 
2.25.1


