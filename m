Return-Path: <linux-wireless+bounces-18304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA3DA25E91
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853A0169041
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0872046BF;
	Mon,  3 Feb 2025 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VAluHkvc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E673209F24
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595923; cv=none; b=Hpnp13QRpmOx47Vbc0ignpmGcjPrfd1aThjxoA3VbvvQfkuI7MHK7vCx6DlIlGbAQbFwJfrAO0b2eAFRwIWukTefYghcIb+l40G0e70rCdc4R0qnqWDUYKUdtM2sFD1Xp5Z0WWyzNYASx3NMTib+GRV++iusyFzRHd3Pm2oQHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595923; c=relaxed/simple;
	bh=gAH3q74n9hsRiE7JbJ5bzYC8aeqOHHSPMga46VCY8Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7bqwiCajHc1mCjLKLOzKo5HAYHtNVFxpfvpPUkv+SpHl2XKeZY6Hg68feiC3Doe3UhFWb7xjcQAFmnA69XdE+zgEkQGY2SUIgl2z0PD9f7YZ77mqtYc1JasUtQOPKEdjvpJAEMRuOD1i6LS+WFcGfSpa0aGkRTRf0GrggvLAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VAluHkvc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513EPasn014958
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 15:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	960Pc7C6/z2kp86Pu3/RiBBRIL3TdKpE7pdMs2K6Q50=; b=VAluHkvc3D5jN174
	5XETurrxkeTeqWHEfez76lRY22KTBbSmNPnRlRxOXGowKuVbU+31Mq7uPLUDEvZZ
	RGYWbgybvNYIMVnZQGj1PUrkw0izBpsLMTuucvp4Fi7VAduvOfs95+2nV7Lygjj3
	RP+OFVDaQr9dq85iLJlhoS86BhRUUoYzGGtzNkTFgqgbrimSUCHf8klNRRo5syUN
	Qm83g3Cu0VtWdyuk1Md9KWBrJus+ilIcf3zpJCfWbvx5KHGOkvXjh9GzbpCqf3wI
	pKRYX/FQFVFOpF+YkjN7tp+Ei0IL4DAVafxXud7yLdDDIhHU6kimWrtl/vlogawK
	bP+vUg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jqtnhft6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 15:18:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21dcc9f3c8aso69314415ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 07:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738595919; x=1739200719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=960Pc7C6/z2kp86Pu3/RiBBRIL3TdKpE7pdMs2K6Q50=;
        b=MuJAfbB4x9qOduazCJF0jXOI9MjFl96MskhWF/NPkPxRtmLzc9M2aG6MvrBbfyuBeT
         0Rj6vI6eb3OxXThAtfw8rwYLFt5C+tGoDJwtXNkp7g7831TeYLMuIa/IecNKnDT1rd/U
         jqmXhxWuduhNw07ItMTs+lg7di6uz3bv3VDp5cJgPldbm8+wLIpS+WfZsr3Vq+99YZAT
         7GRW+T2NJFILM34dae+CBySdzVZImcSOnB7lSKEN58Ew5KHXOx7As9HTRvEraYnDFQqL
         yleTHH0OnwCSN4Bf9vmT0bhfR3Bx760CEWYWBTzvfRJEHHPcF/MBehIwQffpcZxCcJXI
         CYtQ==
X-Gm-Message-State: AOJu0Yx2W/yqkyI4T0/8qp64hqhH/NSDiiz8RMaE1EV4MDieWd7pIWQR
	0uuXDSKez2o1w6/y1Lu1fcd42OLjnFC30TQDnZ3bZjqwPfgg9hI5nTmidLYLQCoRvetMJJLQB0F
	02LD381a1SBWBA0tyGiT7fyT+5TyMHdEWe/9ETbqz24ZTUSXzk9VF6CJPxB40mA8SBQ==
X-Gm-Gg: ASbGncunw0QjdAGFubZYr8MJceQ/JgYsoWwPEukSZ0QmGl37xz3koc8WdTUWC4GjcZp
	hcrNRrt+NSIEvuJOHvW/4OJozVfL1GPPTL3hWroMADrji9Zc1WAioh0uvIt4BHhFEE7rmzCkVPz
	G+dzPwPvd7oohYgcublAAWrljx1BOXaCDd9NtDEFELydftlWzXTAOq0MZKT9DPgeOsIAqXlolWt
	wJAYNY1ulz2igH9FuTvNtGKJ2Mzh13W4Q0A+dOGD5bWA2H5+STF+Ipl4T7yOOZbyLgkz71axG3B
	QYRSKPRql0dOJ9BzaXc8I+nwv8xdNSE0hWoktR/VNA==
X-Received: by 2002:a17:902:e546:b0:216:485f:bf90 with SMTP id d9443c01a7336-21dd7d7f85cmr297001405ad.27.1738595918871;
        Mon, 03 Feb 2025 07:18:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE71/YCq0vhxjrNAqWGNtyl9CIs/2eGQA5lKiB7X8kCPwWGf2XVShhMC/W+fgZISaTCW25uRA==
X-Received: by 2002:a17:902:e546:b0:216:485f:bf90 with SMTP id d9443c01a7336-21dd7d7f85cmr297001105ad.27.1738595918475;
        Mon, 03 Feb 2025 07:18:38 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31ee0a7sm78689475ad.18.2025.02.03.07.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 07:18:38 -0800 (PST)
Message-ID: <14f4fcc5-b39e-495e-bdee-ef37fcca2d32@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 20:48:35 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] wifi: ath12k: Add Support to Calculate and Display
 TPC Values
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
References: <20250130061104.962124-1-quic_rdevanat@quicinc.com>
 <20250130061104.962124-3-quic_rdevanat@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250130061104.962124-3-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xoL80MHcBY_gnl97kAycKEwHJ-fo5Cwj
X-Proofpoint-ORIG-GUID: xoL80MHcBY_gnl97kAycKEwHJ-fo5Cwj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030112

On 1/30/25 11:41, Roopni Devanathan wrote:
> From: Sowmiya Sree Elavalagan<quic_ssreeela@quicinc.com>
> 
> Transmit Power Control(TPC) stats should display per chain TPC value per
> radio. Add debugfs support to read and display TPC stats type and TPC
> stats. Take power values for each preamble type, rate and NSS combination
> from a particular index from each power arrays based on number of chains,
> NSS, modes, MCS and tx beamforming enabled/disabled parameters. Minimum
> of the values taken from reg power table, rates and Conformance Test
> Limit(CTL) array table should give the TPC which is in 0.25 dBm steps.
> 
> Sample Output:
> -------------
> echo 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/tpc_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/tpc_stats
> 
> *************** TPC config **************
> * powers are in 0.25 dBm steps
> reg domain-22           chan freq-5955
> power limit-126         max reg-domain Power-252
> No.of tx chain-4        No.of rates-1164
> **************** SU WITH TXBF ****************
>                                  TPC values for Active chains
> Rate idx Preamble Rate code     1-Chain 2-Chain 3-Chain 4-Chain
> 4        OFDM    0x000          39      15      1       -9
> 5        OFDM    0x001          39      15      1       -9
> .....
> 12       HT20    0x200          40      16      2       -8
> 13       HT20    0x201          40      16      2       -8
> .....
> 44       HT40    0x200          88      88      88      88
> 45       HT40    0x201          88      88      88      88
> .....
> 76       VHT20   0x300          40      16      2       -8
> 77       VHT20   0x301          40      16      2       -8
> .....
> 172      VHT40   0x300          88      88      88      88
> 173      VHT40   0x301          88      88      88      88
> .....
> 412      HE20    0x400          88      88      88      88
> 413      HE20    0x401          88      88      88      88
> .....
> 508      HE40    0x400          76      76      76      76
> 509      HE40    0x401          76      76      76      76
> .....
> 748      EHT20   0x50e          88      88      88      88
> 749      EHT20   0x50f          88      88      88      88
> .....
> 812      EHT40   0x50e          88      88      88      88
> 813      EHT40   0x50f          88      88      88      88
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan<quic_ssreeela@quicinc.com>
> Co-developed-by: Ramya Gnanasekar<quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar<quic_rgnanase@quicinc.com>
> Co-developed-by: Roopni Devanathan<quic_rdevanat@quicinc.com>
> Signed-off-by: Roopni Devanathan<quic_rdevanat@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>


-- 
Aditya

