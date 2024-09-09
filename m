Return-Path: <linux-wireless+bounces-12679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF2B971DAA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7EC2841C9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C08A1C683;
	Mon,  9 Sep 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kKLesKZ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC41CD1F
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894759; cv=none; b=YW8/KHJtN4/Gk+66kFPfcvUK1KbJT4gvYhjU3FwY7DDnbKiEXZ4KOGDaWCKtOlK/E0LXxOJ4LKezI2qYT5D/PLYp7/1XN5oLgd0UEILnoBe9zyDoguaJiArGl1JkGLxhOEhtaFYWPc+InOn6A90CPyrSRFHLpLVXcWQ8BvTQWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894759; c=relaxed/simple;
	bh=naF3u/x8sUXTUVagxnitStmmSW7noRXnrpPqNPA8+Ic=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=s2cNDVsIS79HkboJT1kEGBV5PmLM0cdhDCzh6LAYTIgtVdd4giV+Iy7sYJh8SrG607jlU9EOst4emA8NwLKHN+kpeNmmScouDCd1SG8EejSChpA0NnmYEQqtjlTb0Lr50izdN5ORQgDjmndcmb4n5PRG9JVjeXWNl3C/zJuMKGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kKLesKZ7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489DRRC1024766;
	Mon, 9 Sep 2024 15:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=A7QaaZrrEyCSWOUzDG1W4t
	46JElHBefqJS0I36xNoKA=; b=kKLesKZ73051ALJNzYuZoA3bre0Pb+bwvBKspy
	16LTdaoBxbOkYjMD+2KTTq/TTejqtdWi61bRYukuPfQukCdsFieZRAhUIHiZL0ce
	TX5loq/2dmd3iyFKj8r21Bt2rTd7SlQQsxeZ30203Ms+Qnu7kZoVc8+f/aaIC61X
	vNwEvnXKP2/9L6FEG8QAygSYwVZ12Z2u+WfCJm3P6woc6yvUXvQSnHBsFqkqZQcS
	RZLKMg977OACUEAcpOUsxNntaNPP9la1qvddb0JXEH91OF6bjv1zTWsshex0Fvxv
	VIrCONalwPpwhXwfP5JYFLtyMnxf4jYtKWLmWpi/0wZvo6tg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy5rb480-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 15:12:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 489FCLdn028693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 15:12:21 GMT
Received: from [10.111.181.163] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Sep 2024
 08:12:20 -0700
Message-ID: <13914e4d-92d4-4ccd-a7d5-86c5a17426e8@quicinc.com>
Date: Mon, 9 Sep 2024 08:12:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <linux-wireless@vger.kernel.org>
CC: <ath10k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>,
        <quic_kvalo@quicinc.com>
Subject: pull-request: ath-next-20240909
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5QM2Emhz1KwsWLxtp7a-Hz-PKffyJOfl
X-Proofpoint-ORIG-GUID: 5QM2Emhz1KwsWLxtp7a-Hz-PKffyJOfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=798 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409090120

The following changes since commit ae98f5c9fd8ba84cd408b41faa77e65bf1b4cdfa:

  Merge tag 'ath-next-20240812' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2024-08-13 12:58:32 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20240909

for you to fetch changes up to 02f454f9aa6255d99611d6a4e37edd08812878df:

  wifi: ath12k: Avoid -Wflex-array-member-not-at-end warnings (2024-09-05 19:20:21 +0300)

----------------------------------------------------------------
ath.git patches for v6.12

This is once again a fairly light pull request since ath12k is still
working on MLO-related changes, and the other drivers are mostly in
maintenance mode.

ath12k

* Fix a frame-larger-than warning seen with debug builds
* Fix flex-array-member-not-at-end warnings

ath11k

* Fix flex-array-member-not-at-end warnings

ath9k

* Fix a syzbot-reported issue on USB-based devices

----------------------------------------------------------------
Gustavo A. R. Silva (2):
      wifi: ath11k: Avoid -Wflex-array-member-not-at-end warnings
      wifi: ath12k: Avoid -Wflex-array-member-not-at-end warnings

Miaoqing Pan (1):
      wifi: ath12k: fix the stack frame size warning in ath12k_mac_op_hw_scan

Toke Høiland-Jørgensen (1):
      wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit

 drivers/net/wireless/ath/ath11k/core.h   |  8 ++++-
 drivers/net/wireless/ath/ath11k/dp.h     | 23 --------------
 drivers/net/wireless/ath/ath12k/core.h   |  8 ++++-
 drivers/net/wireless/ath/ath12k/dp.h     | 12 -------
 drivers/net/wireless/ath/ath12k/mac.c    | 54 ++++++++++++++++++--------------
 drivers/net/wireless/ath/ath9k/hif_usb.c |  6 ++--
 6 files changed, 46 insertions(+), 65 deletions(-)

