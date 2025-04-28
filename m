Return-Path: <linux-wireless+bounces-22143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16429A9F443
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 17:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653C417AC43
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5191F1D63C0;
	Mon, 28 Apr 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YFHvPG7x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0827149C64
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853595; cv=none; b=CF6PNWvBltsdSNDrwTjkwrV//NNqu5Gagq3o1pRXPxZfWrq+vka0ExJmGJQLAni/oXY765LfQ1Pb+gCkr3I7f0xbh7QX0eLng1OMbevG0n5IO0Hg7ZSqgKGtwH4NCUizFj+BaKSsxowpHtN8yfjoGWpgGdESPHLq1yr7AWSYrag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853595; c=relaxed/simple;
	bh=9J18/rK5WEtAUURGsBkt1se2uguYQ00s4SB6hZ4Rzq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dUpSfYio7uh4AG711S89YRHsZxY9eVVRG43h+3rf88/BQtV/jUQaWQTCHd+QofJQcnhDBgx/Lq94YMk/hUf94rSbaafZn+MXGPSQn49q7sAJ20mYGadXyBsLjK4A+uwsPX3ZgepmA3nIyD1oLN7d+ppS3d+mxEl12tfHjAfQUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YFHvPG7x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S8lmcT023726
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 15:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wyusSksr69Cv3nJpMPWpnt+Cd1CfyWw0302
	tw0j2jXM=; b=YFHvPG7xB0kY6NqI68d2bwmFMEoi6h1Fh5J8GOiQEPDu/AxiJ6x
	ghvBv7iUybwPORS2Xpw/wiSdjKvrxJsOqWjo1JjtglJ7Apj2kTHR/4GIv+HprYRt
	NpMCu3GIog0wnQmXNRXXGm0fJkCSH0JOVsrdR4iWK7I5w1rlYZcL78vk9AuJ9sXO
	P3/l0DLQuydmuuPjdfQ3NjfJjB/LKaNBALjGngzi89CetsZc/pZsTcoZ9nePHKgz
	7NfW2bmB0WlNdKSTkPHW0/kOfAZ9EaUpoevYPJfQMiVcfNEQltcesbJU3S66G1A7
	jhn6LESOv3DGIRD44c/CWmAkSR6zpC10frA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468qq5gqww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 15:19:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2264e5b2b7cso44227335ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 08:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745853592; x=1746458392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyusSksr69Cv3nJpMPWpnt+Cd1CfyWw0302tw0j2jXM=;
        b=dX1mEgoPbQZrDhYigAlTJfZD7KZ3lQhAwQfToEEEhq8w8VKZEb7sJviBsTf9f0QDH+
         zbA6SYn3xLlPOOiW+Bz2y+aowMmeMcUoE6Y7tLMk8ItNW0vesvaiVTZ0OkcbPNYTW2bh
         Ihciiw5tXXYyfiKmr9kJf7l3ueso9Sjcvba8sVPNjTeqCZEMdYoD53KQWEQErWt5qedR
         YovnT0I1J0Oz/FiiV2wepSaOWgESAhx5ozdGduIHhD3ylZISlMCEFYVGph5REy6TCSaB
         WXvlO3cWEfDZzjp4QdT6p3uufsemVdFRN3iJVxlzrNRzPKvuQfYeTWJ9A+4YOXgJ2gue
         8KRQ==
X-Gm-Message-State: AOJu0Yx3LmqJUnsTEsYAwFGMz5mZrKv1jQvqfJaEJrpUCR1qM3PE0INB
	RrGFGwh+cIYilHB6yAl2tZGdRDq9mLOhoQXVfHFSFKflyVTAcXv3kaCn4aCEGF2baxkbRzwDiBB
	9vydyJl3f85TQEl3ynKKHDUv+GZR72A86ENKPuQLk6hODfUxSuzwMokJLZFmucbRAfsvNA1vPFQ
	==
X-Gm-Gg: ASbGncvbneGnYuSBGKirbZtncwXwLWgqiHrTrsVg5WsV8QVPKYURgyQPOJS/pwjHH9g
	ZtRRPKZVBjfS9AH0PJ0cZOtMyy0h10oN7Uiqe/1XK+Leo3AN8G1A0FXXqY7gipHhEuPvI7TeB2n
	cdhJ7O7z+932MSVNq4xQ6TIKoaw4Q7knqTcJKK4LZRBMkq4KafFIhTnFUb3cmR2HfUO6Ngglki2
	4vVyhV50lIcYQ7VmZn3gY4B/G6Cui4t2DbGflIuUHrKuUcjbfoCLCATQVP64R4oyChGqAiPLMj8
	ptD5VFIOcP6v9Hsv2sL1/GHX9xQ1wD3TK8sEf6IFILR6+yS5fHxiM+v3tU33IhA0e5lJSnGKEmG
	X2GxGMCxepBnBk7A4v4to+jI97zmb9YQ3zBg2ykYg
X-Received: by 2002:a17:902:d486:b0:224:1001:6787 with SMTP id d9443c01a7336-22de5ec197amr549635ad.4.1745853591636;
        Mon, 28 Apr 2025 08:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmoPwxEVydKt3L3CKGS9MhZxpEWoNM+XBG4zdC94mMzrvyReTgE956dSSWbqK5ImIcNvIPqA==
X-Received: by 2002:a17:902:d486:b0:224:1001:6787 with SMTP id d9443c01a7336-22de5ec197amr549245ad.4.1745853591256;
        Mon, 28 Apr 2025 08:19:51 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100c13sm84134515ad.162.2025.04.28.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 08:19:50 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] Add split-phy scan support in single wiphy
Date: Mon, 28 Apr 2025 20:49:25 +0530
Message-Id: <20250428151927.1169783-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lrEHaozfb2VvB7ARQsKDPtkr3Ye9wTEx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyNSBTYWx0ZWRfX8xR2D3LT7/Cr dXhoyTkJc/uCyJ0oTlF15T5Zh3SrpaY+eLFaGAhaIzE8VYUAR48Y3kxKjB+W8d4tt8+FpIfvv+i jZ2lRzwJnop0sjF3v9MR8NPmDTmDZWnX7ecxjKq3vbkO/F80OUXVtqe5oFU32n4y05wTWGWAyKH
 IoIf+KdQpx+RAEBSvRNbnrm4YHfAZPzBnE/NRATMdiv33R0tgKcw+oUGvl/a12q/dCDrqijtg1z bDkAXWHz4SdAQPVdCYC2zqqDUuRHEGQzjZ2nP58uLklbG6eK8Nzq5mYaAStgfLrhCUUdTZy5sZ+ lVF14yd71BBiA17rpm2prxthi3RCluIrBAS88fLp+vXr7Wog2tEs9RkDAPT7irpuOiA8pS0WX2n
 n+s/DrUfLU7/ybHRxxHx2R50DlSI1vLJltzYlzNq5fFg31rEypiFyOpQg7PEoFmoYAh+w1d9
X-Authority-Analysis: v=2.4 cv=QP1oRhLL c=1 sm=1 tr=0 ts=680f9c98 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1ZOo-ZK77t7PqXeEs4UA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: lrEHaozfb2VvB7ARQsKDPtkr3Ye9wTEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280125

When two split-phy devices having supported frequency range in same band
(as mentioned below) are combined into an ath12k HW group, they will be part
of same wiphy and hence the channel list (wiphy->bands[]) will be common
for all of the radios (ar).

1 - 2.4 GHz + 5 GHz Low band
2 - 5 GHz High band + 6 GHz

When a scan is triggered with frequency list containing frequencies of
both  5 GHz low and 5 GHz high, mac80211 generates a single scan request
to driver with both the frequencies. This is because mac80211 splits the
the scan request based on band.
This results in driver scheduling scan for both frequencies in same radio,
as driver always assumes that the scan request frequency list from
mac80211 only contains frequencies for one radio.
Split the scan request frequency list based on the supported frequency
ranges of radios in a band and schedule scan to corresponding radios.

Since the scan request is split in ath12k driver internally, wait for
all radios to complete their scan and report the same to mac80211.

Depends-on: https://lore.kernel.org/linux-wireless/20250417-fix_scan_vdev_handling-v3-0-9ec42513d26b@oss.qualcomm.com/
Depends-on: https://lore.kernel.org/linux-wireless/20250417073954.632994-1-rameshkumar.sundaram@oss.qualcomm.com/

Rameshkumar Sundaram (2):
  wifi: ath12k: Prepare ahvif scan link for parallel scan
  wifi: ath12k: Split scan request for split band device

 drivers/net/wireless/ath/ath12k/core.h |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 197 +++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/mac.h  |   7 +-
 3 files changed, 160 insertions(+), 48 deletions(-)


base-commit: 21346cd925c2567d5f56cdb1421c94815ac10221
prerequisite-patch-id: 621a0dbeb6269fcaf27c808f951d9e2a2c3ac8f7
prerequisite-patch-id: a9eebd8a3cc3b1ed9ed3574ce9fee088af9c5798
-- 
2.34.1


