Return-Path: <linux-wireless+bounces-22662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43105AAC1DE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 12:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8AA3A7B55
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB78214A7F;
	Tue,  6 May 2025 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RrHS5ZQ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9D20C028
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529143; cv=none; b=HSacNN55lEXfZrL6GQ2++RBJLNpNx0AQRxl64go8xsiz+2/Gh/ckVe5yeU2ZHsIy5od4wEk8/dF3nxonXzjFVr/J7PSrA0CbALohm0NNvKk/0IZ3K0FfBjVh6XBsecJkJ7/gj/p8lM1yvCMV57hdH43QZ7L1xRBuQ9qYDw5U7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529143; c=relaxed/simple;
	bh=ZaffNkWv6XP4ajVs0pu70l/y+pf4wgQCks8id/cbDnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m52lhpgytJhXbxInchW/CL3L0259d5lWBTmX3L2kMCKcYML8fhQfzDYfi2ivmBbrs8p0wIYEYcYdkR4RrY6pcIGwkEO/kO2W7ZjxBoC1bOUKxJfxlZGrHYk8HruYcIwZWIOUrYMMj2aG+26JGYFt54dOajpxx1Vm5RFsvp0EJpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RrHS5ZQ9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468rgdf002569
	for <linux-wireless@vger.kernel.org>; Tue, 6 May 2025 10:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2061bEl1csLnksK0JRW35eNhPvRK/Xk495AWAIZiW/c=; b=RrHS5ZQ9zZ4tpPjJ
	QCH4YGAHmH8v458X9rw7DKXdheiM4Qwtnn6+0CgN2Xn+lzloPi9HEaiWr0C5pp3h
	E2F0s4zkxWMsXk15kVRNCEdTcfset1WZCP7ii0onaduaJMyhGiVzzLEo5htnjz7G
	CNlWK0XyKGTFvfS+3Di6h3lKJ8nHvVGvxwRz0DsMCo7HVrbdM4iknVE7quRknDLY
	UzERHNbNTvIdYAbNJ9bXG34HmoMT7Oj+GaAxlUo/Wn2826pOj2gjUecPUP6G1tzy
	TO8efJae5nsWB4X69BNynroRsUNvlsk6xv+wV4r8H87uCTA/IYsrkVvvma6fmrDD
	xS5dPA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5w39xhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 10:59:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-229170fbe74so70173635ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 03:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746529140; x=1747133940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2061bEl1csLnksK0JRW35eNhPvRK/Xk495AWAIZiW/c=;
        b=BJe72AXBKsxwsAONNqShtHJy5xBjAF1C+wCVsYsvdYxB4hDWsYyt2IiOrnjoUQNWUL
         K24LTbsTKxFGv6mTOjvdX2ESR/WG+QcUI3cNf6oIu5/jG0KpkyQWIO1ZIPO6B/dXhtcE
         lzelw4CIYW7wCw44h62BHMOzJ2ESCRUoMEZjSEbTEvpLDjIZQa9ho3b7O8/NbCS2vKPP
         YD80UXUuLD11dTht3Hn/Sw62Y6XNW9ed3d1YVqZDha1k1Go41Q0syK5WupFCRF2USfnD
         RPzXCw6BE6JvsqFxjWpK54VyLFzry9dku8WN1yL86xAnRG4AlWO9by5E/0cNOBtWI6+b
         UgPg==
X-Gm-Message-State: AOJu0Yy/DbiVMbM0yFUZN/tWnIPrd3fanWXbKQ5ioSdmunnYVx5mbjGu
	Qnw93ZStkedcbN0BYvIpJFkuPHAGqR9hhVy1wr9x3E3MCH4wKmbKRt2uIP/rosgeFqcaLxsGztU
	j7IlqnVJr06+WM06Hco9PSfayDY0L2mOf1zGTHRIG+1u4q2o9HgbnMzvMnvLcLWbCI+JxemFoLg
	==
X-Gm-Gg: ASbGncvZPsdJafRXNDE/juJVSCjBuwdR8VFsJr193spylEiPaKPknNtevOxvMSbpKw+
	OUJz6wtmtUGQjRkr78cG8bi8DwTlTsbxCq87z42URRNsJMYvUK9/lZiMKdbDFBAIFjSIoU1D8Dq
	DCJn3p/E3GWEg97mqn4g9KO+vYXfOBBLmLfw+TEvRN2aKbUttkAJfHMnzsTJIyVYJpldjmbex9I
	yR0fCN5w/TRv0HB8sYTfTLBWDOlz8ABN1ekpABZNiYV1Hqu8IDOYXtFiqPARvJxqCJuOLOHm/2t
	c9zcu8XUohWtn62i2fDWWEYy+ryvnPOrbUxDuReajiH3Ye9oPY70
X-Received: by 2002:a17:902:ecc1:b0:224:a74:28d2 with SMTP id d9443c01a7336-22e1e91a300mr138664835ad.26.1746529140048;
        Tue, 06 May 2025 03:59:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9hKdv8WhmblBPJFWUbCI2w+Asxgw5LONkcDr6kztSSUnlhsuIWt4AuaOUxFxXGaZWIVLFzA==
X-Received: by 2002:a17:902:ecc1:b0:224:a74:28d2 with SMTP id d9443c01a7336-22e1e91a300mr138664605ad.26.1746529139584;
        Tue, 06 May 2025 03:58:59 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e998bsm70749135ad.67.2025.05.06.03.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 03:58:59 -0700 (PDT)
Message-ID: <40cb5219-9324-46fd-9ded-34d151f13a61@oss.qualcomm.com>
Date: Tue, 6 May 2025 16:28:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] Add split-phy scan support in single wiphy
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250428151927.1169783-1-rameshkumar.sundaram@oss.qualcomm.com>
 <de8d2a84-6b10-4166-97b5-13ea2544fd46@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <de8d2a84-6b10-4166-97b5-13ea2544fd46@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEwNSBTYWx0ZWRfX45wz0zNtSS/a
 BUden8nduMyykz2JLBkIY5ZNI+PUsF+uKgEcsiiHrmfnO0D4ElESb5F9NXj70w5N+wHok2Dcq7Q
 YwjsVvQ7TXGKHkgvRXFaybKudZCLSEpt1smfihQ5+3lXjxQo2nRCzgF06HvtIH1m8nuR8PJuJ93
 MSYIn8UFsivD74J9DRpu6ENI2zWf7aLPPnfm7oeip7Fn5o5oKow68xLMu2401Zw4jBrb5p237v6
 pqKVcPOxNwcGk2SOm0TkQpsk2t6xeHoAnkbLZ7zpAcjpBx3THVJvYIZlIBiJOrjX83IaBbv3APN
 69ptANoQk7aAKRSvnzJf4CA373OtNY0oYaXYLnLGFWcjIfbKNF1K7RLOyx7DCFV/kzFCcpJ42BS
 fC1fFOAr8kZrGQCcZhIkEiuDEvw/30cjoQSd7VxAPGa0OCseHa4gUi3HKyYR+ZqbjJ+3/Vs+
X-Proofpoint-GUID: G4oVwWRxeP0ghi51X_2OKHuKJAoCIOs4
X-Proofpoint-ORIG-GUID: G4oVwWRxeP0ghi51X_2OKHuKJAoCIOs4
X-Authority-Analysis: v=2.4 cv=W+s4VQWk c=1 sm=1 tr=0 ts=6819eb75 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=61KrlExVhF2ann4TZ64A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505060105



On 5/3/2025 2:25 AM, Jeff Johnson wrote:
> On 4/28/2025 8:19 AM, Rameshkumar Sundaram wrote:
>> When two split-phy devices having supported frequency range in same band
>> (as mentioned below) are combined into an ath12k HW group, they will be part
>> of same wiphy and hence the channel list (wiphy->bands[]) will be common
>> for all of the radios (ar).
>>
>> 1 - 2.4 GHz + 5 GHz Low band
>> 2 - 5 GHz High band + 6 GHz
>>
>> When a scan is triggered with frequency list containing frequencies of
>> both  5 GHz low and 5 GHz high, mac80211 generates a single scan request
>> to driver with both the frequencies. This is because mac80211 splits the
>> the scan request based on band.
>> This results in driver scheduling scan for both frequencies in same radio,
>> as driver always assumes that the scan request frequency list from
>> mac80211 only contains frequencies for one radio.
>> Split the scan request frequency list based on the supported frequency
>> ranges of radios in a band and schedule scan to corresponding radios.
>>
>> Since the scan request is split in ath12k driver internally, wait for
>> all radios to complete their scan and report the same to mac80211.
>>
>> Depends-on: https://lore.kernel.org/linux-wireless/20250417-fix_scan_vdev_handling-v3-0-9ec42513d26b@oss.qualcomm.com/
>> Depends-on: https://lore.kernel.org/linux-wireless/20250417073954.632994-1-rameshkumar.sundaram@oss.qualcomm.com/
>>
>> Rameshkumar Sundaram (2):
>>    wifi: ath12k: Prepare ahvif scan link for parallel scan
>>    wifi: ath12k: Split scan request for split band device
>>
>>   drivers/net/wireless/ath/ath12k/core.h |   4 +-
>>   drivers/net/wireless/ath/ath12k/mac.c  | 197 +++++++++++++++++++------
>>   drivers/net/wireless/ath/ath12k/mac.h  |   7 +-
>>   3 files changed, 160 insertions(+), 48 deletions(-)
>>
>>
>> base-commit: 21346cd925c2567d5f56cdb1421c94815ac10221
>> prerequisite-patch-id: 621a0dbeb6269fcaf27c808f951d9e2a2c3ac8f7
>> prerequisite-patch-id: a9eebd8a3cc3b1ed9ed3574ce9fee088af9c5798
> 
> While this series applies cleanly on top of ath-next + the dependencies, it
> does not apply cleanly on the pending branch (which already contains the
> dependencies).
> 
> Can you please rebase on ath/main-pending, and post a v2 with ath-pending as
> the destination branch tag? Don't worry if the patchwork bot ignores it due to
> an unknown branch tag.
> 
> /jeff


Sure, will rebase on ath/main-pending and post it.

-- 
--
Ramesh


