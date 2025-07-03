Return-Path: <linux-wireless+bounces-24783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C27FAF67E5
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 04:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC43F4E43C3
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 02:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5047F1D5173;
	Thu,  3 Jul 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DuHUAMO0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B046619F11B
	for <linux-wireless@vger.kernel.org>; Thu,  3 Jul 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751509200; cv=none; b=qJLpgoPJQA9uJpVWodzoUKmJNtwzuJ5hHCakRtbM7Ap3yMtqkgN3EbIMhRnUKJWfTqYMw2r1VbTHg+IscLCaWnBalKvkaYTN7hnq5O4gFB0EIVWjQGtfhTv1TAxQI2R1aYYP0BmWtLX694C0DXZ5YhqtGNNolbv4U5X/5iE3FXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751509200; c=relaxed/simple;
	bh=rnEUDMnYf8STp5GPvVbg/Y3l1whTuYYaxsE/wbhNOXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuNzRQmw0LgLi11L7yQww7kYwLFQE3XEW1vjj5Tyneoiw61gLY/WRsC9viXr7NBoDNqDiltS++8xHjU2IZMd3+i1Wj/4QGwVtPVTKXhWyCbVZLzeJM6i1fADKOOxeRBZ4clV2aSK75fixeBgonn8VM/O8e+qjsT6g9JF6mH1vaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DuHUAMO0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Jd4QK020476
	for <linux-wireless@vger.kernel.org>; Thu, 3 Jul 2025 02:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8SgoQMCb+yk35vcEdpnooOFtFCFlzwJMMzcRzUpYFpU=; b=DuHUAMO0wJJ826x9
	2hFz2U8l84fCq0lDxIDdk7LI/JRjI5ffzrJ3OtmkS6dvTo/u/vfAFgw+lSYsNYGj
	lLWb0WgecX2zpCu/9Xie9g/KS5Kh0zuS4QC0ScXvU8EQX+USdX++NI1qvLJxWdkO
	fPQlRDIA5sPgLw27bg0GQJO1jd/gi/J4TjxZOXYZU4bJhj1IG4NS72aE+dz3NryL
	Z58KsHBiGbO15jmX6kMGiElLhEaV7FcMICq+rECbM6QTJhBlGhQFahu9cjGDhstO
	ol85ejBTl9ixSx4UguVWEFuh6i+LWDOitCm1TZEZmzdGniquEM3oX1LpXw/B10A9
	59poJQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47mhxn5d1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 03 Jul 2025 02:19:57 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31bd4c3359so2904962a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 19:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751509196; x=1752113996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SgoQMCb+yk35vcEdpnooOFtFCFlzwJMMzcRzUpYFpU=;
        b=aIZsage6CrIH5zKPlrl5c8NZ4aK/TAoUAdW9hq/meSMB5HpwTKYprw2YkLImHDFCbZ
         4Zq5H7fhqT/oVvhvbbf43Zuw7DvG76ROjhwfYl7lv/hJWXNK2JKwTWf+hdlMWcki618W
         oLL72jSnMkOcRh5LYfzy5w1ObSPyMf4vYnSPoRt+jeZ5nn0xV3DFNnmXdtgaQIivlVJS
         vxYtbW/pUKae9CbPasK94jbHMJuUstn3haW9Sg37QeTPdiX5ScRAAyI0SaZfj1MAlwpt
         cEVW93derLEriBGvkzAO2xHFFw78/KLxaju/bEYSFVNoWCrZiolXvAYmFqLFltjXvtAf
         rnqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0LrzgMUOBhazcV9jQE/W4ISfH8VYo+LeT6svQldIXprSq/6IP0T/NKv48QNqMfu+oQVkAco9+gZ8Y8wwD0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm9U6mGLPebOul4JJ6nfC5ge30tpbAQ+B5rH+71CS/uRkqZu/w
	tt0CWczZEmLppywqJlL08giRKI1CEdzsancPzbBitMP3R9nf9JxblPHsS95GhOze4m+hvq+0NLa
	5LRlxuWay01YoX/wWD4kIV7QzYt9QqxnB1fTgcvCxs2dIPjDMReM4tFcXWGHIoTRthhxLkw==
X-Gm-Gg: ASbGncuBcIyUBFz2E12Zsipw97UfjzHpz7nJqJIeUlzO4mkGL+byEqCYsa/2zLPH/5m
	U/C2jN8KtN7393rKhAd3MFzD8o/YhDOoLvOY7U1GeITQVLS/q4sOl6x5l+6oBQN8s+3gKbj28k2
	CpQ1O5sSp0QlO9sYpjUF4gNNh1rF894aCmm6Fz2uC63FC/swJuAoPvbNjHISLjN3n4N/Bd64sl+
	Z321W3vZ/jUf4KJ6oh8RqTS+jjsKtukUw/uYhQFWFcN1Fyo7lisetxsxlLDORV+zyyjFo+LFpl+
	IlJ1fX2+2HNxtgscUm9V337XXoU9F8rzLF1P5MvLBfbn7hpzGGNl/Wuv0tpYX4rAMhaqor4urge
	D77wFbiG9ERtsfGA=
X-Received: by 2002:a17:903:22cf:b0:234:8c64:7885 with SMTP id d9443c01a7336-23c6e594071mr82030025ad.53.1751509196034;
        Wed, 02 Jul 2025 19:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTss5kyY0B6320sF3R/MAVC1HUnXlJ+1X/RIYQnabOP0u++yoy3pq4btZm9MwuOzM1nPMzMQ==
X-Received: by 2002:a17:903:22cf:b0:234:8c64:7885 with SMTP id d9443c01a7336-23c6e594071mr82029645ad.53.1751509195566;
        Wed, 02 Jul 2025 19:19:55 -0700 (PDT)
Received: from [10.133.33.139] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b8ec2sm140834865ad.183.2025.07.02.19.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 19:19:55 -0700 (PDT)
Message-ID: <979be2a9-9d0b-4382-8519-2f6fbcac5375@oss.qualcomm.com>
Date: Thu, 3 Jul 2025 10:19:51 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Matt Mower <mowerm@gmail.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Robin Murphy <robin.murphy@arm.com>,
        Jeff Johnson <jjohnson@kernel.org>, will@kernel.org, joro@8bytes.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        1107521@bugs.debian.org, iommu@lists.linux.dev
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com>
 <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com>
 <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
 <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com>
 <CAPDiVH-xPDmx-KQx7YJY=7+kwJNbGY-rEu-w+cz18p=kjnKFsw@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <CAPDiVH-xPDmx-KQx7YJY=7+kwJNbGY-rEu-w+cz18p=kjnKFsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDAxNiBTYWx0ZWRfXzX4aKrCIr405
 YtJcACTBpHOiqscRIQdlLzlLID5l6ScfhEGUumbTdmFsnoWnSULEUffgrLTJDjckz/74Szw78/E
 roJND/Vr+5Tsj3V7mLmyNKTVI3QOEXGgL/BzqMzyqpEAUyps2fcGhSdDYAwbHwdG50txaiDfmal
 mtMuXu0kls4U5DWKExgoVudtE0es2zdMNJaCSTs19ux3ba5DijT4myE6U4+Wb5+TaMA68ZwiyKy
 dTnajHAW3B/XNvbL4MRQRlmPbdaZ+YsDM9ZFmQ3aSV+LmsNSQMzG3YwkYjmewsT4N6YmVRf3Q0A
 zuR/lxZ+Vf8/fsLZOUJ9FiGAqUy7T/SOd9p0TmiSWkvwaw1045NGVNgCwHDXwPR+yCw+jLvZ9t/
 bP5Xb0Wjbr0LdthCqrXKMO19nRscHTGWjZAWvI+HXn7sJMGvJu/bQmRMplzfLaReCvxEiJFy
X-Authority-Analysis: v=2.4 cv=EbvIQOmC c=1 sm=1 tr=0 ts=6865e8cd cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=1xDctz_ZAAAA:8 a=x-Jbw-KjGOrRcKConVEA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=1a1P4aADmYxDp9Cj9Seq:22
X-Proofpoint-ORIG-GUID: 1D7OxvMbcBuWipuRjRkW5vbs_45pP_qO
X-Proofpoint-GUID: 1D7OxvMbcBuWipuRjRkW5vbs_45pP_qO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030016



On 7/2/2025 10:53 PM, Matt Mower wrote:
>> Matt, could you help enable verbose ath12k log to verify my guess?
> 
> Here are kernel logs with ath12k debugging enabled:

Thanks Matt.

I see firmware crash before IOMMU fault in both logs, which verifies my guess.

> 1. WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>    https://cmphys.com/ath12k/dmesg-6.12.35-ath12kdebug-fw0x100301e1-20250702.log

[   91.625809] ath12k_pci 0000:c2:00.0: mhi notify status reason MHI_CB_EE_RDDM
[   91.625916] ath12k_pci 0000:c2:00.0: reset starting
[   91.674375] ath12k_pci 0000:c2:00.0: waiting recovery start...
[   91.679445] ath12k_pci 0000:c2:00.0: setting mhi state: POWER_OFF(3)
[   91.680721] ath12k_pci 0000:c2:00.0: qmi wifi fw del server
[   91.680754] ath12k_pci 0000:c2:00.0: setting mhi state: DEINIT(1)
[   91.681842] ath12k_pci 0000:c2:00.0: cookie:0x0
[   91.681858] ath12k_pci 0000:c2:00.0: WLAON_WARM_SW_ENTRY 0x14c4e54
[   91.687109] ath12k_pci 0000:c2:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010
address=0xfe980000 flags=0x0020]


> 2. WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>    https://cmphys.com/ath12k/dmesg-6.12.35-ath12kdebug-fw0x1108811c-20250702.log
> 

[  113.621429] ath12k_pci 0000:c2:00.0: mhi notify status reason MHI_CB_EE_RDDM
[  113.621794] ath12k_pci 0000:c2:00.0: reset starting
[  113.670134] ath12k_pci 0000:c2:00.0: waiting recovery start...
[  113.675177] ath12k_pci 0000:c2:00.0: setting mhi state: POWER_OFF(3)
[  113.676331] ath12k_pci 0000:c2:00.0: setting mhi state: DEINIT(1)
[  113.676581] ath12k_pci 0000:c2:00.0: qmi wifi fw del server
[  113.676874] ath12k_pci 0000:c2:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010
address=0xfea50000 flags=0x0020]

> I captured these after setting CONFIG_ATH12K_DEBUG=y and running "echo
> 0xffffffff > /sys/module/ath12k/parameters/debug_mask" during boot
> (using @reboot in crontab).

Unfortunately I can not tell the root cause to the firmware crash from host log.
Internally I will try to repro this issue, in the meanwhile, Matt, could you help do some
more work to narrow down the problematic change?


