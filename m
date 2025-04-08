Return-Path: <linux-wireless+bounces-21257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81842A7FA54
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 11:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD2F189543D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB58266B4D;
	Tue,  8 Apr 2025 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZpgxqaDm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C2264A72
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105849; cv=none; b=lWv+BJUF7sh7HL4jkn5O8cnCPIDM/vL8H/WhWEm731MwuC9n8kRy+rMT+19zcAcELHTPR2sFN/v1jqKyV9ns2hazpJljBc9bkm8U6bEnumK66tUeBCOmissHSLUZECuM68wKdqjAg4Snei9Q4QPeTGZlNL1v6hHgQMBc9cabeoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105849; c=relaxed/simple;
	bh=3VXG8rm99sc2RYKHuS0rm7696qHdUkkBgkQHNZ3UGpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1fV4YZwEcSlkr6puxICZVlrQaa4TjQqtN+9D29pcd05dCArBtMjU6YgJqeEIsnWZNTcBqmyTg6YGTRZq/RfT6ukuERNqTQBxHfDRDX4AJGJJU9cEc9zZtkbmsaJszXgc5V/8sq6SVrEyYxuiu5iY+r5GlukR+qwi4Be00Uwu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZpgxqaDm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GcpV029774
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 09:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nf+YD0JUduHNY62GZnwhY//dQoWGXvLoHNfYX/qspzk=; b=ZpgxqaDmhAJUGMyM
	ydcH6xdIqK39cv5NeNH8bng1vnDCun6CF0Ta0zwvWWIBsVq7IPQ4ZDpcaMtPdESC
	CjLOOFkonYOx2UCtvCX1El0CtGko64V3hqfeIRTBjN4v6LDDYr1EF6SjRv7MqV+h
	zqS1WUeBHinsZkbWUZjWYCf4jgjb/tuYWH+tlvV0J3FcWP6bqPLX2jCtyRCTVhsD
	OjDWtWiQYKLJzkf2GqdPqSwN9UXBFZyCxSsI8DQhADWfw2evUI/9l3HWpn3c3q9Q
	8ZbRwU9uPu1WLIFRz4CEI/wU1aBNB3ZJSVVr2BlUNALVt5W8IztyZsYToDVKQNX1
	Nyh5KA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrfayf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 09:50:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso5434808a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 02:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105834; x=1744710634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nf+YD0JUduHNY62GZnwhY//dQoWGXvLoHNfYX/qspzk=;
        b=YeaMVfjLW1YUC62Ljr5HXzmx28ATccL4jKg/nDDdJGOSMzQkqLR91zaiR7TahhhOuC
         /usZwoIcrA29NjdzLAi3Y42zpgy2nZglsdeY94rGz/holJyoB0hWMT23qgeHJTE4oxG4
         phMbH6BXyoEoHjiD41TqG8tkJnOMkJA26yvBBVp0fQigO+TlJHKcuK1s5NxasDcJrcUo
         X6YtGCS6Pvv2nkw2iD68C/++tmPaXVbpgWMjScNcbH/x31SiA/BrW0BVbkmd1nrfTCuu
         Mx5f02Ay2v4RaWRtS2D/Xp8SOWfU76CAdzazel/7Ur6dnswktaFhzzQdJFg5hqbNWVJe
         cm6g==
X-Forwarded-Encrypted: i=1; AJvYcCW4nLShBhI0B6MwUCL+3BoBsfhnT9mnxJFI00y3Kpn8/yRkDVdgZAWeP3xUQhe9DDtg5LnzrO1BhQ6oGPwh1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YznawWPlyYKTJ6iJoA+hrVx1WXeUTkLaS5XyneaVUhA/g4OoFj6
	0gDxuhHPFrsFoOTCYGR7K1OAG6X2TYKI0XgAX3uIn558RLOa3HzTpr/mLRvqiyDQzwIY1iAnVX7
	5dIuT8ezo41MWYwhtYo+zkBqAE2LjdiWN9CHE0PIHBpbiU1woD4XHcD4ShFag7+EG4A==
X-Gm-Gg: ASbGnct/JmGtrRn0boQ129yNUbDCax+xc/vALlmJVLf3hr0LLz99w3SXv/U7FtPCQvI
	iw4oyu2cdr6pJqGyv5kMkedo8ebWuw+ZWwtg68YAVY+PYB3SOJfX2RLhrkzvQNtHN8Qe8Lc9qg8
	COELIrrGdLp5FnXIiOEd9UKoiWdFfYUEjXz/ljXZ3lz+Y5u2TczMbZ9trnv5n6Yp+fWlrXqjkVR
	Tg7sqsUIL+sRZ72KMn9fxagLmMAeMLy1BkFGPzSJzD2LjUyUoMTNoqYhIg9VrPJMxhei6I9+9y6
	QCxSX3a/S0H8Y0KsfZxYsbBcnvUrRWZVs4oyXY6PTBm8T7D+fQ0k23qZiA==
X-Received: by 2002:a17:90b:2707:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-306d0bec159mr4286451a91.8.1744105833805;
        Tue, 08 Apr 2025 02:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc8riaw/43fthr3kZrTyHTspAfvT7Hvw0cgykTvgUbS5FIXnM7tvSbldKnJOZSfB56vzweSw==
X-Received: by 2002:a17:90b:2707:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-306d0bec159mr4286417a91.8.1744105833433;
        Tue, 08 Apr 2025 02:50:33 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad943sm96212295ad.23.2025.04.08.02.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 02:50:33 -0700 (PDT)
Message-ID: <ce8b30c9-45bc-740e-156c-dd51000d2982@oss.qualcomm.com>
Date: Tue, 8 Apr 2025 15:20:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v4 1/9] wifi: ath12k: fix SLUB BUG - Object
 already free in ath12k_reg_free()
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Harshitha Prem <quic_hprem@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
 <20250408-fix_reboot_issues_with_hw_grouping-v4-1-95e7bf048595@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250408-fix_reboot_issues_with_hw_grouping-v4-1-95e7bf048595@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HMsWpxQIHoLabCwG77OyNaz4k21zjsMf
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f4f176 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=QSDNZ9PZ-Eu8teISbnYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: HMsWpxQIHoLabCwG77OyNaz4k21zjsMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=474 bulkscore=2 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=2 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080070



On 4/8/2025 11:36 AM, Aditya Kumar Singh wrote:
> During rmmod of ath12k module with SLUB debug enabled, following print is
> seen -
> 
> =============================================================================
> BUG kmalloc-1k (Not tainted): Object already free
> -----------------------------------------------------------------------------
> 
> Allocated in ath12k_reg_build_regd+0x94/0xa20 [ath12k] age=10470 cpu=0 pid=0
>   __kmalloc_noprof+0xf4/0x368
>   ath12k_reg_build_regd+0x94/0xa20 [ath12k]
>   ath12k_wmi_op_rx+0x199c/0x2c14 [ath12k]
>   ath12k_htc_rx_completion_handler+0x398/0x554 [ath12k]
>   ath12k_ce_per_engine_service+0x248/0x368 [ath12k]
>   ath12k_pci_ce_workqueue+0x28/0x50 [ath12k]
>   process_one_work+0x14c/0x28c
>   bh_worker+0x22c/0x27c
>   workqueue_softirq_action+0x80/0x90
>   tasklet_action+0x14/0x3c
>   handle_softirqs+0x108/0x240
>   __do_softirq+0x14/0x20
> Freed in ath12k_reg_free+0x40/0x74 [ath12k] age=136 cpu=2 pid=166
>   kfree+0x148/0x248
>   ath12k_reg_free+0x40/0x74 [ath12k]
>   ath12k_core_hw_group_destroy+0x68/0xac [ath12k]
>   ath12k_core_deinit+0xd8/0x124 [ath12k]
>   ath12k_pci_remove+0x6c/0x130 [ath12k]
>   pci_device_remove+0x44/0xe8
>   device_remove+0x4c/0x80
>   device_release_driver_internal+0x1d0/0x22c
>   driver_detach+0x50/0x98
>   bus_remove_driver+0x70/0xf4
>   driver_unregister+0x30/0x60
>   pci_unregister_driver+0x24/0x9c
>   ath12k_pci_exit+0x18/0x24 [ath12k]
>   __arm64_sys_delete_module+0x1a0/0x2a8
>   invoke_syscall+0x48/0x110
>   el0_svc_common.constprop.0+0x40/0xe0
> Slab 0xfffffdffc0033600 objects=10 used=6 fp=0xffff000000cdcc00 flags=0x3fffe0000000240(workingset|head|node=0|zone=0|lastcpupid=0x1ffff)
> Object 0xffff000000cdcc00 @offset=19456 fp=0xffff000000cde400
> [...]
> 
> This issue arises because in ath12k_core_hw_group_destroy(), each device
> calls ath12k_core_soc_destroy() for itself and all its partners within the
> same group. Since ath12k_core_hw_group_destroy() is invoked for each
> device, this results in a double free condition, eventually causing the
> SLUB bug.
> 
> To resolve this, set the freed pointers to NULL. And since there could be
> a race condition to read these pointers, guard these with the available
> mutex lock.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

