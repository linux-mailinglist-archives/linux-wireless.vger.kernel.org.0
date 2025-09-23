Return-Path: <linux-wireless+bounces-27593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF24DB93D54
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 03:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E9037A50E5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 01:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FAF1FBCA7;
	Tue, 23 Sep 2025 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8+EyJsc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4B81EDA2B
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590673; cv=none; b=j9LCw0UHOwV8aVV3Mu6sJix7w/dWsbHLnwtwPVweYLhydh3drX6+TtVEN4ZAL4FpqLyeE0NNeBS5h2Ow6sm6D4BRjUgReWBqf1Lt4/PJRBmBaPCGZ8SFMXc6Z2O7D8EDRT55UcipsPPhGkoBLeQB4DEiQ/g9TpsiJK/w96tC3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590673; c=relaxed/simple;
	bh=y4S275Miz+ukeFPKAE+lbt6Joirybg+jQCsav6T3FUc=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=D/BajSJUkV/wh4IZpMHcg+vwlUf629Pg8ubvVDgQT+HhGMhV5NESUAOgrSx5vbGiHttxCYrwxJnT854yTtgcqyalLIttAkS+RxrIVnvkMi6Qtx46eidxdkva3NNXiKm99TwStiuXop6AGKSztlpZSAeTCQH8MwqiEZ1ZcZd9SsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8+EyJsc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MGN3Wp020119
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 01:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1JeDdHV5OMjMXXGqdZHluK
	S1DigxdAJFFXWIOS411Uc=; b=m8+EyJsc8pMhq433LzgFis92OjtNP4PJxb3je0
	rucHf71pTa1V0OJkrJ+aHTL40uzMN9zz0HWTO5nxHr3hIqVAM13QmKR9mXodlx//
	J7sU3ENh2os/hlAKPBgLJVlH6tuyHxtY83dV1N3NUuv55Z/HrCRXh7Ym0Zor6hYM
	TiFWtox+76biLOwvqnrFwewsvGlcZC/tTOjpTeqOcHpooJGSnPVFycQ7Asy+8L4T
	aNCrEidOy3VgRrQBMSjiqOg0pQyjmRJx1xfCushhN7mqGG/qoA7UzrzxRBIHqMFk
	lFPkhxXXfpNpKELN9Je01cpbGnOoLS9Ar0KE3kx9y16MOpkQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kkhpsak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 01:24:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-272ed8c106eso14845125ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 18:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758590669; x=1759195469;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1JeDdHV5OMjMXXGqdZHluKS1DigxdAJFFXWIOS411Uc=;
        b=iHqBPbe5Jv6/1dZwWQmQI5rhhO+i5jLcTZZQfzR8rOVLnpdjs9hsOdzxr+vfRkSoAX
         nYAD34e6YM1XnRIpawpdIW+hSnt0j1ZggQ549SW/SEWglDaeC8SmAwpdfZMQ0gcvAWlj
         VgmUI2GI4CtZeQmXUgwdQJppsZs3uNb+eCCjPAo3jd1p5uL1OT3q/n55VpknNm+F1SIh
         rcZ/nDK0ZmgvxpxTKqUjODM8suIlX982LegBwePjP0ucqqA+ypDebAq/j4zOAQbpgs2a
         aylYTFRI5YVwDHbTYFI+piEegKYCafup1gZIsxQiQTqFgIi16hnLeXcSjj8hrtIMOyII
         E4zw==
X-Gm-Message-State: AOJu0Yy8NrDl0Ez3HbmL9lEpvpIu0v2B/XjGPopngDlTiz8KInMSsvFr
	4WcsM+kHT8NGmwYmTfkuFNF/LXM+sKzszbbvJ4NjQX6yqaKjtvygHX+gwjg1LGHGMKamMPZCJ2C
	XCzg2o0reFcecJB/MrxFElFQWKJHIdSxbGeJxiMRj9IOh1rEyIOVc55M7TKBOm8icpYY37ml8aa
	DXjA==
X-Gm-Gg: ASbGncs+m/V1Vdc8QU5Bm5zjzjkkekhFh+UtPVrFdtEdztNyZgPVlKhe2WClwGQcFYC
	RMJshTdi9C7JuM/cv0nfmXUO/DI87skKMzOuF41CaTSaR/66rczjq6oO3oyGt236YlDqPuebi+3
	9va4C4zjIcGeiD88G4MkdR9PQthdvtZJmry/52xA+8W/GqdjSWUh8hwHIzUJOXfN2ei0sKfwMqE
	mQYdcQhvqZMqeTwhwu+zWbmUlVNBJz8t/W36+bukjkC4/b5Mua4Hg3I3Xgl7WX8DngPZJS484Rg
	QZjXVsEIntzCzsBcDfYLpZqHyvXy9cLs+bmONGK9+nf9+SE5g7r9R+dEy8EgR15961mp4AkWAOc
	C
X-Received: by 2002:a17:902:e5cc:b0:273:1516:3ee7 with SMTP id d9443c01a7336-27cc9f5de0emr12493415ad.57.1758590669009;
        Mon, 22 Sep 2025 18:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKB1EHuApJ62SDwqDEhEZkHar/JouNGNIFwkq71/fiO4fenMyW2DpihA+6BHZq2wbmOIIZ4A==
X-Received: by 2002:a17:902:e5cc:b0:273:1516:3ee7 with SMTP id d9443c01a7336-27cc9f5de0emr12492935ad.57.1758590668549;
        Mon, 22 Sep 2025 18:24:28 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800530b7sm146509445ad.18.2025.09.22.18.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 18:24:27 -0700 (PDT)
Message-ID: <06c5cda9-6e0b-49ed-beed-ca73f6ce8903@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 18:24:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-next-20250922
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7njuOVJFfVBaY4HFnAOPQaRpnJct9o-Y
X-Proofpoint-GUID: 7njuOVJFfVBaY4HFnAOPQaRpnJct9o-Y
X-Authority-Analysis: v=2.4 cv=JMo7s9Kb c=1 sm=1 tr=0 ts=68d1f6ce cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=l7PpnQ8KDgTFq2VbNpgA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMiBTYWx0ZWRfX3AFg/wlGBz+b
 A3bZPuyyGOAXZCZS3xHWvTC1p+A4D3vgB/A/amWrY50CHiTwNFsW2LHu7P53N0UgGc5OGfKtK3o
 rKhjLeYGk1lIHZ+GeNlhkFIAkz/ju6TnqVQ+rtmIzEdtdv0oMR4eRRtdiZLwz4a+aAABcTi1cuw
 Z+/BvVI/ooCZkVEownztGcYqPwkRShN1UKgRlQBAuzLFyYdIoaKlPgb02Is19dlzBRyvS8Nts8d
 93q0qnYCUs4P8BEef3vE2lsDPVBb/9myHlQJqDrJ7iqvoqjbOhmcV5rsV6bSXeu5O8aRzs3wCqZ
 fPSe9X/zWjKU8OskA43ni4IiFgyAWXBe2pF4gTk4diHcSvqGhp/dhMMiOMNajqsXi5GA4qnd38j
 n6k7ZGCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200022

The following changes since commit d103f26a5c8599385acb2d2e01dfbaedb00fdc0a:

  Merge tag 'wireless-next-2025-09-11' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2025-09-11 17:50:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20250922

for you to fetch changes up to 32be3ca4cf78b309dfe7ba52fe2d7cc3c23c5634:

  wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again (2025-09-22 17:54:33 -0700)

----------------------------------------------------------------
ath.git patches for v6.18

Highlights for some specific drivers include:

ath10k:
Fix connection after GTK rekeying

ath12k:
Fix Issues in REO RX Queue Updates
Handle inactivity STA kickout event

And of course there is the usual set of cleanups and bug fixes across
the entire family of "ath" drivers.

----------------------------------------------------------------
Alexander Wilhelm (1):
      wifi: ath12k: enforce CPU endian format for all QMI data

Arnd Bergmann (1):
      wifi: ath10k: remove gpio number assignment

Arulanbu Balusamy (1):
      wifi: ath12k: Add support to handle reason inactivity STA kickout event for QCN9274/IPQ5332

Baochen Qiang (6):
      wifi: ath12k: initialize eirp_power before use
      wifi: ath12k: fix overflow warning on num_pwr_levels
      wifi: ath11k: downgrade log level for CE buffer enqueue failure
      wifi: ath12k: fix wrong logging ID used for CE
      wifi: ath12k: downgrade log level for CE buffer enqueue failure
      wifi: ath10k: avoid unnecessary wait for service ready message

Hari Chandrakanthan (1):
      wifi: ath12k: Fix peer lookup in ath12k_dp_mon_rx_deliver_msdu()

Kang Yang (3):
      wifi: ath12k: fix signal in radiotap for WCN7850
      wifi: ath12k: fix HAL_PHYRX_COMMON_USER_INFO handling in monitor mode
      wifi: ath12k: fix the fetching of combined rssi

Liao Yuanhong (1):
      wifi: ath11k: Remove redundant semicolon

Lingbo Kong (1):
      wifi: ath12k: report station mode per-chain signal strength

Loic Poulain (1):
      wifi: ath10k: Fix connection after GTK rekeying

Maharaja Kennadyrajan (2):
      wifi: ath12k: enhance the WMI_PEER_STA_KICKOUT event with reasons and RSSI reporting
      wifi: ath12k: Extend beacon miss handling for MLO non-AP STA

Manish Dharanenthiran (2):
      wifi: ath12k: Add Retry Mechanism for REO RX Queue Update Failures
      wifi: ath12k: Use 1KB Cache Flush Command for QoS TID Descriptors

Matvey Kovalev (1):
      wifi: ath11k: fix NULL dereference in ath11k_qmi_m3_load()

Muhammad Usama Anjum (1):
      wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again

Nithyanantham Paramasivam (5):
      wifi: ath12k: Increase DP_REO_CMD_RING_SIZE to 256
      wifi: ath12k: Refactor RX TID deletion handling into helper function
      wifi: ath12k: Refactor RX TID buffer cleanup into helper function
      wifi: ath12k: Refactor REO command to use ath12k_dp_rx_tid_rxq
      wifi: ath12k: Fix flush cache failure during RX queue update

Rob Herring (Arm) (1):
      wifi: ath: Use of_reserved_mem_region_to_resource() for "memory-region"

Roopni Devanathan (1):
      wifi: ath12k: Add support to set per-radio RTS threshold

Sriram R (1):
      wifi: ath12k: Add fallback for invalid channel number in PHY metadata

 drivers/net/wireless/ath/ath10k/leds.c     |   3 +-
 drivers/net/wireless/ath/ath10k/mac.c      |  12 +-
 drivers/net/wireless/ath/ath10k/snoc.c     |  14 +-
 drivers/net/wireless/ath/ath10k/wmi.c      |  39 ++--
 drivers/net/wireless/ath/ath11k/ahb.c      |  17 +-
 drivers/net/wireless/ath/ath11k/ce.c       |   3 +-
 drivers/net/wireless/ath/ath11k/core.c     |   6 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c    |   1 -
 drivers/net/wireless/ath/ath11k/hal.c      |  16 ++
 drivers/net/wireless/ath/ath11k/hal.h      |   1 +
 drivers/net/wireless/ath/ath11k/qmi.c      |  19 +-
 drivers/net/wireless/ath/ath12k/ce.c       |   5 +-
 drivers/net/wireless/ath/ath12k/core.h     |   7 +-
 drivers/net/wireless/ath/ath12k/debug.h    |   1 +
 drivers/net/wireless/ath/ath12k/dp.c       |   2 +
 drivers/net/wireless/ath/ath12k/dp.h       |  12 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c   |  56 +++--
 drivers/net/wireless/ath/ath12k/dp_rx.c    | 352 +++++++++++++++++++----------
 drivers/net/wireless/ath/ath12k/dp_rx.h    |  18 +-
 drivers/net/wireless/ath/ath12k/hal.h      |   1 +
 drivers/net/wireless/ath/ath12k/hal_desc.h |   1 +
 drivers/net/wireless/ath/ath12k/hal_rx.c   |   3 +
 drivers/net/wireless/ath/ath12k/hal_rx.h   |  12 +-
 drivers/net/wireless/ath/ath12k/mac.c      | 117 +++++++---
 drivers/net/wireless/ath/ath12k/mac.h      |   3 +-
 drivers/net/wireless/ath/ath12k/qmi.c      |  24 +-
 drivers/net/wireless/ath/ath12k/qmi.h      |  16 +-
 drivers/net/wireless/ath/ath12k/wmi.c      | 158 +++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.h      |  33 ++-
 29 files changed, 669 insertions(+), 283 deletions(-)

