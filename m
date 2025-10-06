Return-Path: <linux-wireless+bounces-27828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0625BBEC91
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 19:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7911895B8C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6612248A8;
	Mon,  6 Oct 2025 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HhfEKCM7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36113E41A
	for <linux-wireless@vger.kernel.org>; Mon,  6 Oct 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770758; cv=none; b=kjw+uJ7YEK57JOpCgKvptyx+JNtg9X3q4tb28rGVUufokz4fYa2KZ+21QRdTnb712UPGkzGIMY1l2MRrKyATPNyIGc+0/+JmDjuVCPBjM0GN/RTMwO03/qmIuxeQWjeL1ktwgHClWWBtpmVKWsaDU3PXyg7dfRHxIYY4g5rVbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770758; c=relaxed/simple;
	bh=dVCwtO+Ey2dRFBAjyEMguxQgMhCxoSbfTKX2zSwD0pk=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=T0o8DLLvPfBcq5nEt95wo+YP6jXeAekcwYZWTxFu6MYMboUJcFGkcdneNYLO728ikIFPIn4kntpJkCTf6NfTDkCypjKN8tPOJYFZn50takDuTCHTElkAOHnyITktFPUKWuBHDtTax6yRDAyJCxFuV7C1JfUldvQ1Vtt5r/DeHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HhfEKCM7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596F1hG9028624
	for <linux-wireless@vger.kernel.org>; Mon, 6 Oct 2025 17:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6uX8yMRU+RN3y5an9EtPvm
	iOJ+b25K/dHy7f3R3KmZc=; b=HhfEKCM7fnl6+pfb6gMNDtWYFwhTCpKvfexTHX
	/6/ZpRxP+xywLmYoKsHZAntTl94M8R/tQ/KqOBR7AYO+TWq8SnCLaaQsy0NyEGFS
	c414gNyua2Iax/hlGlP+oMNv4HDkX+cmyQleuPE4jNILGSat6IjSVP2/f1J76GPj
	FXr6dVGZ9nqiS7XGZ6WDGrC38ga7DNRYgrXfQm8PG6ODhtuSxIcVQKJhXKbhqFxZ
	5mcG3aL6Acadq+TBYu+FJ5jmV+iwOlSKUHMr2aMlGHqqXKf6a1N44H6ntqer11Ht
	FR8AxXlURGLwjkqjeyw6ktLpbCFXCo8U/od+WUQnmV5Xuoiw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jthpvqgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 17:12:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b552f91033cso6071422a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 10:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759770754; x=1760375554;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6uX8yMRU+RN3y5an9EtPvmiOJ+b25K/dHy7f3R3KmZc=;
        b=UQC83l5k8hZdLYHOIcUolw1rnZ1tIHR+WcWylDMJT9SeI8N8Ry9h5P2ZAY3smEye2Y
         fQ3woMR1tmYFjXrtz7bMrjLUyYvIOzzPc1/ya6l5PKr5NX7SO4lJwkHJs+C/JlkdIUME
         G/iNeFCIKVRApGndrxb8/wxkz1S6oACpb56ipON2yf0rM9d9LyCCn5NJKi1z9eN+Qz6p
         19DC7jOd/dlEdhXMViWKxz4Tzr5W0as3zL/vpeblrupAsFRYO5PMNuh5owgdsbbXlyBf
         J1/9xdWxID8HStlBOcmWgxPgiAVPYghN3HWYDpJuUudoXU7WzFpjDX/s8dbukTgIzwHq
         wygw==
X-Gm-Message-State: AOJu0YyaQbulU4r54SjXY0nkCltsPsEDEebMLrI6ncBi8AdwBmi1DPs0
	R952GDJlpBdQYxfkdnok5eJ+nVb/5VEyMyZ8RjHmdICA0gBG+kSbWA+d2ai6U/anSjiPT0rUdvL
	awpLmvRQ+o/r/JfDUmqGyWSSLxrefbEQsLcoqhvjWj850SWY4fHDbf7FWIVL28ZHSAXi8lnfXhE
	1apA==
X-Gm-Gg: ASbGnctlzd75MJiooM+r5BuiHJjmP+FVcNCwB+ZkFlwh6HjCin+gPNpRNlwtAsSwNk1
	+CjxI82uWzQh1RT9YDHpW1KF9tNHWDuzmlxgpDPMX0+AEc9D6dyDW9tYL7Qtn29eyNurdq4Wrb4
	4VihqyTe2NCkwSGhM0F1/pL4P9tM+w/oLKdtkdf4h0KgmDEV4tRXfM61dGZpZZmCD3SqPnKynQn
	zLWmPRUnFHhxP0xLRHr+k4myrLFrV8zkgQVsTQwPJOwYbFYq51ru4+vWGvi786yQ+r8Riv5T4xG
	zQLbslflNpiuWqqHsf1J0XLkMnfxQQuITCPKzsOv3RaOUJLuPt084ri6uVweNjZ1144ILKUTvxf
	t7xKpSg==
X-Received: by 2002:a05:6a20:72a8:b0:2c9:1323:f7f8 with SMTP id adf61e73a8af0-32b61dfb938mr17494040637.6.1759770754491;
        Mon, 06 Oct 2025 10:12:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcFsQ5Cj8EuYVNyQn76xpACvpnbuvWlGVRXDAN6Io60+FOAQqunJFYDQCHg/w+DzTzrjT7CQ==
X-Received: by 2002:a05:6a20:72a8:b0:2c9:1323:f7f8 with SMTP id adf61e73a8af0-32b61dfb938mr17494007637.6.1759770754025;
        Mon, 06 Oct 2025 10:12:34 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b609ba636c2sm12363691a12.16.2025.10.06.10.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 10:12:33 -0700 (PDT)
Message-ID: <45843a5f-011f-4751-b9bc-004768b1454e@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 10:12:32 -0700
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
Subject: pull-request: ath-current-20251006
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oD90QHcRUYQog-kNQXdFKlyFxN0khmio
X-Authority-Analysis: v=2.4 cv=N5gk1m9B c=1 sm=1 tr=0 ts=68e3f883 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=NTglem7-DTcMTCxUeT4A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNiBTYWx0ZWRfX3DQICCWh9f/k
 6zq0MGLUPetqEvHmCxUsN5jQZUXHF97B0MhKjBOHi9LU/GMLDJnrikREPhty+9bSTCPDfgPQqfH
 SYwjVOC3p6y5b/5MvX9SkRlBzy/0v+k090YDc54xDupArSMZmU/cRFXhm8wv1noxYz3O/4CvDgQ
 GVk86kEhfZ++W6lcd5kcrIVRe+OXSpEwvBV9rEO4x2vw50ecGeSAGbWX3Lkvx/Ob5Vnlryong2L
 MG7BicTyw+mRpWlr5Sd700isjxJoi7DYsCN53/PUcV7rwuUBYSdChFRLTZUlz2u6hgNmFI/EmyD
 5qVW9MNvnr/HkWNP7VuKIL1775FDOcBkYa8BcxhaN7NEEsFGrAx5kZDfUFtK/wCRwIsKbIF4BsV
 akiJbAFyQ2a+4xS2f9fiB+QRO2r+7w==
X-Proofpoint-ORIG-GUID: oD90QHcRUYQog-kNQXdFKlyFxN0khmio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040016

The following changes since commit 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4:

  Merge tag 'net-6.17-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-25 08:23:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20251006

for you to fetch changes up to 9c78e747dd4fee6c36fcc926212e20032055cf9d:

  wifi: ath11k: avoid bit operation on key flags (2025-10-06 09:48:55 -0700)

----------------------------------------------------------------
ath.git update for v6.18-rc1

Fix memory leaks in both ath10k and ath12k.
Fix a sparse issue in ath11k.
Allow ath11k suspend/resume to work on more Lenovo laptops.

----------------------------------------------------------------
Karthik M (1):
      wifi: ath12k: free skb during idr cleanup callback

Loic Poulain (1):
      wifi: ath10k: Fix memory leak on unsupported WMI command

Mark Pearson (1):
      wifi: ath11k: Add missing platform IDs for quirk table

Rameshkumar Sundaram (1):
      wifi: ath11k: avoid bit operation on key flags

 drivers/net/wireless/ath/ath10k/wmi.c  |  1 +
 drivers/net/wireless/ath/ath11k/core.c | 54 ++++++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/mac.c  | 10 +++----
 drivers/net/wireless/ath/ath12k/mac.c  | 34 +++++++++++----------
 4 files changed, 72 insertions(+), 27 deletions(-)

