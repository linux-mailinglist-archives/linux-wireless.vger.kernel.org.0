Return-Path: <linux-wireless+bounces-21769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 361FCA94B08
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0C7188E9BA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FA256C6C;
	Mon, 21 Apr 2025 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="omIdHyeH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20F1C5F09
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202938; cv=none; b=N4AE+1DTeFBbBt9ZuNP8C4rQMh3EyotO9jSRhNMIQweG9mP5VfTkKDbZpO5wRInPztoa2jOHtDftFSeyb4A5XdJIb6NCiS9wkC0xDvUBEV6/E0xjo4gign8gDWp9oV22QfvQdf4KGSG2ZdncngLCwrfOT7RmwOBGJU3Zq6Y8K+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202938; c=relaxed/simple;
	bh=2H63ECqU4tGrVWHPeAJlEIDJAvikbP4o8aJ93V2LBw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DDXw4x2HmVOmh4ShDVLaknGPMhr6Y9QqCAkkz9jjiIzwc+NL2cYEQiGy5ddnteO1eNymH1MS0IUCm2DtmyhcDLqkX9kuV2hNEL7bWQQKd8uqkMf+FChi7NW85cNbRCMapfJUOe6UntMGZgSjuHqw9H8z8Kpr6OSRXaUTG4838Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=omIdHyeH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNs579015322
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0HA4SvxXPkNjqmu/OEk8aILevxWwlvc4QXZ
	MbQvkR/A=; b=omIdHyeHH5KjS0Uc+k3GJSf8KSlgYhpIhM9RVJDch/0l0a9cgOP
	dRRXdaZMzO8pNBYk5i8bBUlMhdwdVHDyheC5+dBCrq8WKo+WmkosuIAjF9EtRHQo
	RYAvx1srtWFbiZOu+rENT7pC3Jp/IRNoMZSmJ52MpJW7ZCJMwyXrHQ+0i3h0KUvY
	dr3ZXpq2tgXcEltvICpu9jLvrNRZITYaGX+xZ+E6TjsePms3tkioEjYQmRAZr4F3
	im1/QucmSyx2Tajua81Pp1IhQcaUG0/9wb+bcWzTgC7R/xa2D1l4+RK672ETUFCU
	geTh+iD6VbT8Ty203CYD3rCictk5opXXMMA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4641hhjx5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-223fd6e9408so28648875ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202919; x=1745807719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HA4SvxXPkNjqmu/OEk8aILevxWwlvc4QXZMbQvkR/A=;
        b=o1ElExxVutqHPCd9qnhK7uBxEJ3gsymliRSgFBA7rsCuRRp+bT2hbXMgWjmv4DNCEf
         kn+ySgye8MnVhI8ezRT1KIPn37LzkhBpVl+71HCUjDBIO5WUu7lNLk5HDLZRkoAgYI1r
         PanzbpXTuHpcmk1pnfivHKLVv6ARwvQtGWQcelXSeQF7wplJeFGxFkqI1jwCeywBSeT/
         kBYOO5AVfuqqNEJutXFopWJSRpmVydqpQjwAdb+mP08KPjMu+edzbx+rB4d9We44Zrll
         gceM+OY8wozKfwlgvntpFoUkz828gSwT547dkNzPx3aIdt/3fHwOFU3sacRcQLXHx8R2
         Z23w==
X-Gm-Message-State: AOJu0YxWJsdxBootvVzBfJ16eBZ2GXvBO7TK+D+dTR2pyKxhaW8Skf/n
	wV+WVdmqEJtTbR9jn+FYO5ZHRJUyDSkdBnxplPOtto5BNbmh/QFpcIDlKY74X6Jo+BI9JnapPPA
	8eLbVgDr9hntpxnveA/5+h0tpgb6YPs721QBv95VfXCYlOUEbp9gW0hfq5xuClJdD+g==
X-Gm-Gg: ASbGncsHCO4VS+NgAyOJuTIH/6FJOloRDbIFRSi+6aJ1R6IYNWOSdSjHA/dcK0qhKtN
	MVzJS+Zzmhsyx8q/uUbpU9WxjzqwsXBPlBj7iYAWt10a5MzO0TOsmTRCLwb/4EyZqJCRvNYC530
	3uzOtP5/VytJMKaJm+wYrpQ3KPzXGzUAokr/QcytALTjhzr6x9bT6Q5PvamIP+YG2wP0S0RolBb
	0MPBonjhZyEoFealpUDRHDBWzHAyk6iXOV5VmeO2Z5ShJnFAx+NgCuMlTQi/3cL0qdmGJEVzfBm
	Z1fkkYN0elPPmGRcXH8ggnlGaMT3X3NOAKy94AJbMEFwfM4wZodFBGNCEfHQNaj3c4Lvrkd82as
	yWbAb6+4dEwA=
X-Received: by 2002:a17:903:1b24:b0:224:24d3:60fb with SMTP id d9443c01a7336-22c50bf10c4mr155615185ad.10.1745202919629;
        Sun, 20 Apr 2025 19:35:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQJ47ziGF7GgPHar6q2l1sd/nPC+MWx2QEN7DD7xSH9OTOVnJrGD8wQxFmR6MPaxuMDlbZeA==
X-Received: by 2002:a17:903:1b24:b0:224:24d3:60fb with SMTP id d9443c01a7336-22c50bf10c4mr155614995ad.10.1745202919300;
        Sun, 20 Apr 2025 19:35:19 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:18 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 00/13] wifi: ath12k: add monitor mode support for WCN7850
Date: Mon, 21 Apr 2025 10:34:31 +0800
Message-Id: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Fe43xI+6 c=1 sm=1 tr=0 ts=6805aef7 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=cN5TtCRrlyR05RTW2EMA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: UtugZwMpYPwCFkoYLGich2R2Ve020F9u
X-Proofpoint-ORIG-GUID: UtugZwMpYPwCFkoYLGich2R2Ve020F9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210018

Currently, monitor mode is not support on WCN7850. Thus add ring
configuration, interrupt configuration and ring process function to
support it.

Kang Yang (13):
  wifi: ath12k: parse msdu_end tlv in
    ath12k_dp_mon_rx_parse_status_tlv()
  wifi: ath12k: avoid call ath12k_dp_mon_parse_rx_dest_tlv() for WCN7850
  wifi: ath12k: add srng config template for mon status ring
  wifi: ath12k: add ring config for monitor mode on WCN7850
  wifi: ath12k: add interrupt configuration for mon status ring
  wifi: ath12k: add monitor mode handler by monitor status ring
    interrupt
  wifi: ath12k: add support to reap and process monitor status ring
  wifi: ath12k: fix macro definition HAL_RX_MSDU_PKT_LENGTH_GET
  wifi: ath12k: use ath12k_buffer_addr in
    ath12k_dp_rx_link_desc_return()
  wifi: ath12k: add support to reap and process mon dest ring
  wifi: ath12k: init monitor parameters for WCN7850
  wifi: ath12k: use different packet offset for WCN7850
  wifi: ath12k: enable monitor mode for WCN7850

 drivers/net/wireless/ath/ath12k/dp.c       |  28 +-
 drivers/net/wireless/ath/ath12k/dp.h       |  23 +
 drivers/net/wireless/ath/ath12k/dp_mon.c   | 816 +++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/dp_mon.h   |   3 +
 drivers/net/wireless/ath/ath12k/dp_rx.c    | 122 ++-
 drivers/net/wireless/ath/ath12k/dp_rx.h    |  10 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c    |  38 +
 drivers/net/wireless/ath/ath12k/hal.c      |  38 +-
 drivers/net/wireless/ath/ath12k/hal.h      |   4 +
 drivers/net/wireless/ath/ath12k/hal_desc.h |   2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c   |  96 ++-
 drivers/net/wireless/ath/ath12k/hal_rx.h   |  12 +-
 drivers/net/wireless/ath/ath12k/hw.c       |  12 +-
 drivers/net/wireless/ath/ath12k/hw.h       |   1 +
 drivers/net/wireless/ath/ath12k/pci.c      |   3 +-
 15 files changed, 1127 insertions(+), 81 deletions(-)


base-commit: d33705bb41ff786b537f8ed50a187a474db111c1
-- 
2.34.1


