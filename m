Return-Path: <linux-wireless+bounces-26167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD81B1C4B4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 13:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9852E560A38
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 11:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227E921CA0E;
	Wed,  6 Aug 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gj7cg3Mk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794793AC1C
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479081; cv=none; b=gEjdKxKdDWTSvnYoVg3g0Fqau6AguVGHtgS/PjemAVUiTu/qknLjt36RjP/vyDtNLkXlG4uw4lULaUpCgDG9DUH2s3eEb09bw7pdokhHwnrD/XLghEHs0mRiGZecDy1IH+Z3Ctv89C0usjReksA3MUEYTaYfq8s+zGE55Ysl4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479081; c=relaxed/simple;
	bh=Knoi2UMPz94ztDj5/5gSxhFI5iGccBnHBX7JewzBqXc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=seBQis2FkTnALDCxAsS9B0gAfbvIchzLO+f1Im53/6/nEC8ghAxSdYCcPEAXRwfP1+DArZwXfL6snoLty1xbrlRLmrnOYWS8GGfAd68fIKlx/srzhlgtxsRttwWSH3elBcJaZelxARpwRcB3gTcT1MxifHXluB+pvcZ4AT26Aog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gj7cg3Mk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765g81k032245
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 11:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=WtiBpRz0wprq
	dL+T05uhAHQTmTjB9b6wv16oJjaoicQ=; b=gj7cg3Mk4JMpuNmoDxj6Vwj37GFG
	veV/dmBD9cwZzOZTSWgvaVYtX6XMkhlKfcWrUInDWMdWIvOYvqFSedSrbzkJNCvu
	bc3+B6NXS1kAh+uIHIfY/nmY+JU/WWlF0Jjoq9oE3diU66hRQuZG3JpkZAdndWPN
	sUPNG2jRI0+PWjA7Hk+clrSlHHntadeVZTNrH57NeLdmA5fIn9AYhLFviWxHksCS
	e4O3IcZdalfsDz99dqpV3J4qPotWVogTWOtS6GnAp2IuwvJL3hSmjki8WxouMszk
	NT9i3ForXMTakFWUg+HH/rEEUjhhdJKjNAWrAF99ck5ySdPWxIQ/ua34cg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpybajbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 11:17:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3214259ce67so3687154a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 04:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754479077; x=1755083877;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtiBpRz0wprqdL+T05uhAHQTmTjB9b6wv16oJjaoicQ=;
        b=bsXIMPf0kxiyJpm3Js3HubrbGsnm8Q+jJp05uj+6tG5qavFqrmO/40g20GhXyzLbAW
         FB5HhMXHukYbZ4Jv4aRVpbIa4Q7bvoRpUz6enBCoeCLpJGr7pVKlDxMNWSVYSnn/nhhS
         SnU7bmCURibiEaN9k6wAsWWKGAEFvRWq6b860WwWso41vOrWuUAqFhDp22lwHxD/N9d0
         JvQQvGGFx9mhK0yIvRv4bCc+xlZtIkLGZr4FVCwSGr/Xx+SD/YMTqffvPDIJRHmQWAZ5
         iVRfQW66jJnVnbMLgYMr44jdtqzh0sNlmapSo4NlA7T/qURrYIncgs/3HSsaQhmJbnBF
         Hwbw==
X-Gm-Message-State: AOJu0Yxi7iSq6oUPqjQUIrZppA+RfqHcAYK1qDCa63T3Q7uRXPO81EYQ
	11lQqpS2AZYDVG2h6DkW21lEmmJt1APExEvLfLSlI39B2TVEkxWxgGmJ9pcVEj8+ERNzdOSsNES
	ahpiq79ROwHpneXuTnareOVlvMc/sxBI2vrNFMSQUnjwTZRfRHtgzkRcei4E70IAyOV+DJg==
X-Gm-Gg: ASbGncsRiB/5SxpWBItqI5ttDK1ZInccN0VpZoJ8pwp/PV0NbV+GrQxCKe1545GOzuZ
	iEYlrjkzkeroRnACjj5R5j4M9I05A3oT+9yE+gUdXJgzUjP7wt5QN7hixxXMCkKlNtk9+Ttg+tH
	k9PSXeXndXpJmpoRENZ4fpxgxnZZKqRZXS15ZdFw9sn2asFwiZjmGiCZJmKJ5QoBNLiKd0I/DeE
	ypaA4onNm+1uGgdgB3rvTGFW4MLkiu179uObL7grIl4b5dETNIpuEANP9JibMGbnGn4GVzICUB/
	VjcNfCIFQiwqqIZ5upoJGJPhqhnfodkT8seWtoY06W9qWDribCRbRjcJm3zXW9sm47MMbJe7w1s
	i9oCzhxW1nSVIVV7wQqQm8woeOP/vqCbAzzAMN1V86xTxR0meWOhnOiSBWNNnQnygOiMCnQcf7Q
	==
X-Received: by 2002:a17:90b:510b:b0:311:f99e:7f57 with SMTP id 98e67ed59e1d1-3216758d502mr2878172a91.23.1754479076953;
        Wed, 06 Aug 2025 04:17:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1XwnPNYoOYZYKfYeAC7wcfba4IX19JWDYTOJ++Z1aJvosC6lygulwki5g/MyHnuEzjnSJnw==
X-Received: by 2002:a17:90b:510b:b0:311:f99e:7f57 with SMTP id 98e67ed59e1d1-3216758d502mr2878135a91.23.1754479076482;
        Wed, 06 Aug 2025 04:17:56 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d9dafsm12984111a12.23.2025.08.06.04.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:17:55 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-current 0/7] wifi: ath12k: Fix Issues in REO RX Queue Updates
Date: Wed,  6 Aug 2025 16:47:43 +0530
Message-Id: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX7Yle+LlmXp+P
 9JpYq+4ABKIU/cpdXYjGxNUA2z3Z0wnKbrlAWDLmSAEMRR8djsZfJUT7LoP7vfQeaBc/0RW/yUc
 GSzXaPCrZmu6sqlfS1XyUXpT7GYXkGOwK/T40OxUo82OqYf1ZUGM1d0tuqW6Dn45lQeBv0Ftk1C
 lxBrCARrIWs0XPh2pviKPTs5YBcpBLlcPpgftUqgcLxEW+6YxFjWfuqu+ekWVKIvHbhLvX6sY2l
 k30GOMk6+bTxAa/sC2rCY+CZp5mQ4LmMkaEm2ygcoTaBJ0r9FwyjxKq1xmjWg3tQ5/0X+8vnRwt
 SphhaSPxE6+2EORjjDOhMDpQqD6U2O9PcyUJ0THeYGMKOSqy2G8lBGvrT1ITx1VgvMLK3Hr8kXE
 bnN0eB/K
X-Proofpoint-GUID: n_cUP3N2T6AchZuWy_rttt9l5KCvZr93
X-Authority-Analysis: v=2.4 cv=EavIQOmC c=1 sm=1 tr=0 ts=689339e6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=2OwXVqhp2XgA:10 a=xkmYrVTeFEw3W4icy9sA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: n_cUP3N2T6AchZuWy_rttt9l5KCvZr93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

During stress test scenarios, when the REO command ring becomes full,
the RX queue update command issued during peer deletion fails due to
insufficient space. In response, the host performs a dma_unmap and
frees the associated memory. However, the hardware still retains a
reference to the same memory address. If the kernel later reallocates
this address, unaware that the hardware is still using it, it can
lead to memory corruption-since the host might access or modify
memory that is still actively referenced by the hardware.

Implement a retry mechanism for the HAL_REO_CMD_UPDATE_RX_QUEUE
command during TID deletion to prevent memory corruption. Introduce
a new list, reo_cmd_update_rx_queue_list, in the dp structure to
track pending RX queue updates. Protect this list with
reo_rxq_flush_lock, which also ensures synchronized access to
reo_cmd_cache_flush_list. Defer memory release until hardware
confirms the virtual address is no longer in use, avoiding immediate
deallocation on command failure. Release memory for pending RX queue
updates via ath12k_dp_rx_reo_cmd_list_cleanup() on system reset
if hardware confirmation is not received.

Additionally, increase DP_REO_CMD_RING_SIZE to 256 to reduce the
likelihood of ring exhaustion. Use a 1KB cache flush command for
QoS TID descriptors to improve efficiency.

Manish Dharanenthiran (2):
  wifi: ath12k: Add Retry Mechanism for REO RX Queue Update Failures
  wifi: ath12k: Use 1KB Cache Flush Command for QoS TID Descriptors

Nithyanantham Paramasivam (5):
  wifi: ath12k: Increase DP_REO_CMD_RING_SIZE to 256
  wifi: ath12k: Refactor RX TID deletion handling into helper function
  wifi: ath12k: Refactor RX TID buffer cleanup into helper function
  wifi: ath12k: Refactor REO command to use ath12k_dp_rx_tid_rxq
  wifi: ath12k: Fix flush cache failure during RX queue update

 drivers/net/wireless/ath/ath12k/dp.c       |   2 +
 drivers/net/wireless/ath/ath12k/dp.h       |  12 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c    | 336 ++++++++++++++-------
 drivers/net/wireless/ath/ath12k/dp_rx.h    |  18 +-
 drivers/net/wireless/ath/ath12k/hal.h      |   1 +
 drivers/net/wireless/ath/ath12k/hal_desc.h |   1 +
 drivers/net/wireless/ath/ath12k/hal_rx.c   |   3 +
 7 files changed, 251 insertions(+), 122 deletions(-)


base-commit: 95bf875b89b48a95a82aca922eeaf19d52543028
-- 
2.17.1


