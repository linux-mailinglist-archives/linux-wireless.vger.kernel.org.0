Return-Path: <linux-wireless+bounces-11320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B294F632
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 19:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070AD1F21EEC
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD3313A3F2;
	Mon, 12 Aug 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ELKTB661"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF1139587
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485549; cv=none; b=hVkQyNNoacUrmEKLsIlVG1gc2Xr3OFOpaG+BGb0gPor1CeBHlFbekNImp8h9jcOJDTtoLrXSeUFvRhzRcHgF2Co5N88qvr1Cpp2rIBBpHbxf0lELoodtLiZJK/UZ1EHVEHrKWgtH993yYX9nkIWlhHkz52bdq1GKsDTNb9vXh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485549; c=relaxed/simple;
	bh=mpeieSKPRzeco+LsbfvKemDbuWs2duXrBKlssOFTFi8=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=AyCEXyn1kbB1lDFwCZpyRGG/wsUWvOO9aETVvpgDp/HMJYLzyLKmKmp2gN8v/eAFV9jiDVFTG4PWXJgvIDHEMkgNfvOXkIeZm2GvvSEruaQeRbexhifeMXNX0EvVDsFkKrBfIl1AsTIlWS4rdaNLcMuMjhCiGBCC8WeuMK0+qgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ELKTB661; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CDScQo016336;
	Mon, 12 Aug 2024 17:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wUz2FIX5UUY+h6DUG+Cmyh
	L4KEOUH3lMPGJGgeZOyPY=; b=ELKTB661Qy51LQR0+8rqiN6nAm9q53u7XTglER
	5E9hKNyh5cHmwPC96e7kY+rKv96MyQUR1XBrYg7tfb8uTGtqfpMCiDSiYC69W+Xs
	bx1O49M6sE/9SPy2+aHS9bEabaZ7zkIqklGrN/sKHkOCemQ6K10jmvZF5YvzLufA
	6QIulhWJc9U29UMzoEzJPS2wumKvN7vl7otI/usaX6pN3P5YpHNv3RHBST/p883p
	TocpTYss5L0uSbWkwHuEiZqytN07t0K40OmnzYdNRUh7IZooWpWz6sjkTfiicBBz
	7a30wl7H8lskxx4yP6daHqnBHoC1APj9OcwDsdyKGq+iZCbA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1chn08x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 17:59:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47CHx4hJ028312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 17:59:04 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 12 Aug
 2024 10:59:03 -0700
Message-ID: <9ee38166-782b-409d-a2df-e2cee6e2ae21@quicinc.com>
Date: Mon, 12 Aug 2024 10:59:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: <ath10k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>,
        <quic_kvalo@quicinc.com>
Subject: pull-request: ath-next-20240812
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l5OIy6VUHr5cJlGyn1YBqDOUdMrxCW7C
X-Proofpoint-ORIG-GUID: l5OIy6VUHr5cJlGyn1YBqDOUdMrxCW7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_11,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408120133

The following changes since commit c1cacb01f35589bd41360cdb7535afc792c08a7c:

  Merge tag 'ath-next-20240702' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2024-07-03 16:57:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20240812

for you to fetch changes up to 89fbe672bd0e5e5c39600fcc7a3bca0b8a212d23:

  Revert "wifi: ath9k: use devm for request_irq()" (2024-08-10 10:21:58 +0300)

----------------------------------------------------------------
ath.git patches for v6.12

This is a fairly light pull request since ath12k is still working on
MLO-related changes, and the other drivers are mostly in maintenance
mode with a few cleanups and bug fixes.

Major changes:

ath12k

* DebugFS support for transmit DE stats
* Make ASPM support hardware-dependent
* Align BSS Channel information command and message with firmware

ath11k

* Use work queue for beacon tx events

ath9k

* Use devm for gpio_request_one
* Use unmanaged PCI functions in ath9k_pci_owl_loader()

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: ath12k: restore ASPM for supported hardwares only

Baochen Qiang (1):
      wifi: ath12k: fix invalid AMPDU factor calculation in ath12k_peer_assoc_h_he()

Dinesh Karthikeyan (1):
      wifi: ath12k: Support Transmit DE stats

Dmitry Kandybka (1):
      wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()

Heiner Kallweit (1):
      wifi: ath9k: use unmanaged PCI functions in ath9k_pci_owl_loader

Kang Yang (1):
      wifi: ath11k: use work queue to process beacon tx event

Karthikeyan Periyasamy (2):
      wifi: ath12k: fix array out-of-bound access in SoC stats
      wifi: ath11k: fix array out-of-bound access in SoC stats

P Praneesh (2):
      wifi: ath12k: fix BSS chan info request WMI command
      wifi: ath12k: match WMI BSS chan info structure with firmware definition

Rosen Penev (2):
      wifi: ath9k: use devm for request_irq()
      wifi: ath9k: use devm for gpio_request_one()

Thorsten Blum (1):
      wifi: ath9k: Use swap() to improve ath9k_hw_get_nf_hist_mid()

Toke Høiland-Jørgensen (2):
      wifi: ath9k: Remove error checks when creating debugfs entries
      Revert "wifi: ath9k: use devm for request_irq()"

 drivers/net/wireless/ath/ath11k/core.h             |   1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  12 +
 drivers/net/wireless/ath/ath11k/wmi.c              |   4 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 354 +++++++++++++++++++++
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    | 126 ++++++++
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   2 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   6 +
 drivers/net/wireless/ath/ath12k/hw.h               |   1 +
 drivers/net/wireless/ath/ath12k/mac.c              |   5 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   3 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   1 +
 drivers/net/wireless/ath/ath12k/wmi.h              |   3 +-
 .../net/wireless/ath/ath9k/ath9k_pci_owl_loader.c  |   8 +-
 drivers/net/wireless/ath/ath9k/calib.c             |   7 +-
 drivers/net/wireless/ath/ath9k/debug.c             |   6 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 -
 drivers/net/wireless/ath/ath9k/hw.c                |   6 +-
 18 files changed, 521 insertions(+), 28 deletions(-)

