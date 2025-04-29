Return-Path: <linux-wireless+bounces-22199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8BCAA0BDA
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 14:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFBD3B456C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 12:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9052BD5BD;
	Tue, 29 Apr 2025 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nkSJBQ3t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7554654
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930483; cv=none; b=uaCJ1rkIns7TTXK+dgh79Y2p2SPzyw1A846eSjGK8s7nqfSUwyC5qRcWrO2eOSbGmiJCtYBApHY6xipNcy6AvKhRICRkYSqO0Fkx9tBAiQ5Uy8xftBIqBC66TunMqJEVRKn/2kaCveMX24E0iebDsEytSFzKM2iL6HvUcZuQqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930483; c=relaxed/simple;
	bh=CYqUdYW8swGcNMGjnWlrGiWdvcxPkSzsjb3lRyofXn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iIVDhDjLtomGmWdc4qTIfy7HUWzL9WUCihdRJ0beTAwwpl0QaiGbODOVxoTzBbTrFI+QcWPqFoxgXzVPnXfdg7TjWUlBLovLutb/X/DHYeB1VBJ38cftCdrACqzdzYKFCoI0kRb5aBVSCBFlxdnKfNn0sqbJXLXeEwE/BNGTf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nkSJBQ3t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TA1Bd7015407;
	Tue, 29 Apr 2025 12:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	101iQVq/5J/MuRjI8xN5yS8V9vTfuEeQBhotIUnXp6o=; b=nkSJBQ3t6g2maRdH
	XZG+cdb6B2ZMiSEudJiA4Vh67R9q3ny9NTtDJEFcFj0g+GnsoXaaIbCq7ILEFui6
	evrsxH7sIen0iE3eVEq6eI6/kldTUlKSgsXi3clo/ca2S9p3SrgVdCPZr0ZKMk96
	B74467/dljCEd7xawPVlBkL68x4qQKOB3vMGjcK1shNKnFu2tZwbJN+2tQYmk9VC
	PqGY6oyEkLHdG8uEZ9v5688gP1OR/DAlk9XTAnYirmWW9U3mQcqr/csMkISxzTgw
	CXE/3JrrU+/HxJptAOf9OpZN0hyBVVybKivdXWIW+tVh5lRs7CJKbLoyU6aTvbDZ
	dLDUxg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468qjwvh67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 12:41:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53TCfG8c017190
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 12:41:16 GMT
Received: from [10.216.33.157] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Apr
 2025 05:41:15 -0700
Message-ID: <28403304-bb8c-432b-9130-40af69bf8c66@quicinc.com>
Date: Tue, 29 Apr 2025 18:11:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/2] wifi: ath12k: Reorder and relocate the
 release of resources in ath12k_core_deinit()
To: Yingying Tang <quic_yintang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250423055650.16230-1-quic_yintang@quicinc.com>
 <20250423055650.16230-2-quic_yintang@quicinc.com>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <20250423055650.16230-2-quic_yintang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xbQNKI0vgqPKktPTpLhhtD5pfLLwPZiM
X-Proofpoint-GUID: xbQNKI0vgqPKktPTpLhhtD5pfLLwPZiM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA5NSBTYWx0ZWRfXxrMSiqaf4uTG fnMlcxAYsFcuWwvec8hPadxaMJZpHBRc3vbKTGzpBokS0Ox+qunrQU5XzvwSUE21iPMBBIgr1LD S0U/PNeW0HPErnadijQzCaN20FmmGkbRpb7GJnI6oobKDeParZEF57riR//gVZ6RZgG9MSVY5qF
 IY2kRg8MkEm0HNtLU87/TwM0aWeXav6ITgkMsyGID8FHA6v7mjHCp0EBwY62Co2U1TxF0qcLcuv IUbHv+RQV5xnSR0KIgMDTyjosOyan3Xlb5iNFxpPgY7O74QaCiNorH9wjhQQ9a3wVCkDRQOAzwK jgto6mTiSDNNIo7XmEzO1ZXMtVteVzAZJGwiLfeVFDB3G0QDyuSvoBPyDszOHiS46guhczmXP7R
 mSJribXfcouIZxvEppqzlYEi8cYO0mfVWwdekUMWoDlgky7Yjh1YBcRFTc9+F/9TR5vvFyl/
X-Authority-Analysis: v=2.4 cv=c/urQQ9l c=1 sm=1 tr=0 ts=6810c8ed cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=1n_hH0Y3tB8GNVd_w_QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=459
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290095

On 4/23/2025 11:26 AM, Yingying Tang wrote:
> Ath12k panic notifier is registered in driver loading process. But it is not
> unregistered if ATH12K_FLAG_QMI_FAIL is set(e.g. load BDF failed) and unload
> driver. It causes a dirty node in panic notifier list since ath12k panic
> notifier is not unregistered from list but the buffer of this node is freed
> in driver unloading process. If load driver again there will be a page fault
> error due to this dirty node in panic notifier list.
> 
> This issue is caused by asymmetry between ath12k_core_init() and
> ath12k_core_deinit(). Reorder and relocate the release of resources in
> ath12k_core_deinit() to avoid this asymmetry issue.
> 
> Call Trace:
> <TASK>
> ? show_regs+0x67/0x70
> ? __die_body+0x20/0x70
> ? __die+0x2b/0x40
> ? page_fault_oops+0x15d/0x500
> ? search_bpf_extables+0x63/0x90
> ? notifier_chain_register+0x21/0xe0
> ? search_exception_tables+0x5f/0x70
> ? kernelmode_fixup_or_oops.isra.0+0x61/0x80
> ? __bad_area_nosemaphore+0x179/0x240
> ? bad_area_nosemaphore+0x16/0x20
> ? do_user_addr_fault+0x312/0x7f0
> ? prb_read_valid+0x1c/0x30
> ? exc_page_fault+0x78/0x180
> ? asm_exc_page_fault+0x27/0x30
> ? notifier_chain_register+0x21/0xe0
> ? notifier_chain_register+0x55/0xe0
> atomic_notifier_chain_register+0x2c/0x50
> ath12k_core_init+0x7e/0x110 [ath12k]
> ath12k_pci_probe+0xaba/0xba0 [ath12k]
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN8750 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

I guess this Tested-on tag should be
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Not sure if this can be taken care while merging in pending branch? or re-spin is
required?

