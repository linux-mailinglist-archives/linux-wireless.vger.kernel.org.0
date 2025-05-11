Return-Path: <linux-wireless+bounces-22855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FEFAB29D5
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FE718922BC
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 17:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8A01885B8;
	Sun, 11 May 2025 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mNs3iEKS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117512AE90
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746983451; cv=none; b=q5Cv4LCKl/VLCgnHfoK61BuwWXDKx/gZGF4zRx7f3j6KxqPEDRNG3me/teIwVvEVff9INhLsUd+pTQIVQfDU31Uv3R2GC1UZxAnmg9VfQIW8Ez+/iosLPKCdZ8o8tD2Jg1mYSs18R31w8j8DrUB7Nxy8BaNOJ3onTaP3zgAI0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746983451; c=relaxed/simple;
	bh=JF+rUqx6oYrw+x7HkNBIKciDxDj+rznh3WdaVIU+nk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PQ0e+DAX1XNZW0KwZgMGS16s4q9SDANYt0qs/aHnBG8WSSwL7kTi5OGEFfjwv46LMPno1Idowpo7djD4qyVMQkeiSTLi075MIL9NBizHHUI/IMhaUFStAu/IGJi82MfVzfp+89DQMagJ8JDflAtdgXMH92KCCL6tTtw+15XlP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mNs3iEKS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BBeTR8032356;
	Sun, 11 May 2025 17:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jULC3smUbir2sQ8Ko3wZXrwIOaL6D5kKTtXX4HTwYSE=; b=mNs3iEKSm+nfI456
	SYHGfzdLvkz8093M/zWybOvmEshdkH6ErJkYiqtCDFAK213lw3WrpuYoMPbchfmG
	ESm2JB16Bz8Qys6NOrY4wiTEZp90TMSPzsZ9bMxK7+PJeMIrgh4bV0VLp7IN1+Ta
	APMkypOLYHDPDLHas+5zYeZuqAM8Iq/0A4uRQP9UibpNRcRrljWw+KOw+oAPF/I0
	GVDuHIJ2sdNe4tfGVZ2nIKRcOWjBXc17k42f5J5X3C2wtGejqi84ZmCXJAzOfmbx
	1mt7oXXBGmCGmFCRrCd7b5xT8dLZoo2USauMVbakKTYFWRV2U4GO4UExCZFK7Alp
	7HUG6w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hy15t7fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 17:10:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54BHAdwc026767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 17:10:39 GMT
Received: from [10.216.19.89] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 11 May
 2025 10:10:37 -0700
Message-ID: <d76df512-5098-6e14-113a-bd22fa3b6245@quicinc.com>
Date: Sun, 11 May 2025 22:40:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: ath12k: kernel BUG at net/core/skbuff.c:209!
Content-Language: en-US
To: Alexander Tsoy <alexander@tsoy.me>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <9073c24c1fe0e00a8b925548c90ab2f15f3df2b3.camel@tsoy.me>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <9073c24c1fe0e00a8b925548c90ab2f15f3df2b3.camel@tsoy.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ylV-n422_uWIhhS5cw8eTATS0HzsJDVZ
X-Proofpoint-ORIG-GUID: ylV-n422_uWIhhS5cw8eTATS0HzsJDVZ
X-Authority-Analysis: v=2.4 cv=P9U6hjAu c=1 sm=1 tr=0 ts=6820da10 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=Tz4NVP_pjGKKdwOvMcwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTExMDE3OSBTYWx0ZWRfX00No7bJ/RufP
 gLJ+jea5i7UFGEn4EDmZ++smhMWh7ZlQYC/ovybdqruK+HbQpgBnCSEDcUsM3GSJIy6/aFjLykk
 rUhZNsx8jAzrip24B1QtJbg7FmHpX7nyGv9uxNQOJc6Lj+TGWO3nvsYoN5ZbEBvW2LUgI3D5AEM
 LLrvxcg+qfRR8Lv64l6kqLM5VfDgfHtvmJ9glduqPBtDi5zMDXDDLdnqoQG9X9aoD8ihTNNMQUb
 P+pzlVsTBNFRDvOb+IKHhN49l7jTsEzeI7BA7kOT+LOJKpwsM8neEBsOvQZi4yoeXmMbqOmGtmF
 /3fQsToOBt6lyL5kwgDxYvEV7WeUuKlPeMLCoWmveinDNsAZbZVWQO9i9dqZUlr6g1TZ6EExmA5
 DAifvTsTmz0O2TEEdXe/nLh2LqkRJECCOLB7WdWwdYjLdAC8LswXy8ayzhyHWXlmZ2hFwYXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505110179



On 5/11/2025 12:30 AM, Alexander Tsoy wrote:
> Hello!
> 
> I recently got two QCNCM865 (wcn7850) cards and experience kernel
> panics on different systems and different kernel versions. Card info:
> 
> [   13.584230] ath12k_pci 0000:0b:00.0: BAR 0 [mem 0xfc200000-0xfc3fffff 64bit]: assigned
> [   13.584252] ath12k_pci 0000:0b:00.0: enabling device (0000 -> 0002)
> [   13.584636] ath12k_pci 0000:0b:00.0: MSI vectors: 16
> [   13.584644] ath12k_pci 0000:0b:00.0: Hardware name: wcn7850 hw2.0
> [   14.210605] ath12k_pci 0000:0b:00.0: chip_id 0x2 chip_family 0x4 board_id 0xff soc_id 0x40170200
> [   14.210613] ath12k_pci 0000:0b:00.0: fw_version 0x100301e1 fw_build_timestamp 2023-12-06 04:05 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> 
> Kernels I've tried so far: 6.12.24..6.12.28, 6.14.5, 6.15.0-rc5
> 
> Synthetic load like pumping traffic via netcat or iperf seems unable to
> trigger this bug, but something like downloading of Steam games or
> torrents is triggering this bug very quickly.
> 
> Any ideas on what's going on here? I'm ready to test any patch.
> 

Can you try with 
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?id=763216fe6c5df95d122c71ef34c342427c987820 
?

Vasanth

