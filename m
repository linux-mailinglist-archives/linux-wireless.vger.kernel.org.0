Return-Path: <linux-wireless+bounces-17772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6DBA178F6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 09:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C005C3A2765
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 08:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE4414F9E2;
	Tue, 21 Jan 2025 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J21IpahK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0CE145A18
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737446439; cv=none; b=q6fli+BgQWE82Dk2+TJVcYvZ4DiU3tOHE6Q+tht/VdvmVC4E6Q9XiE+LjN+4oU/4B3axZpapk8NDVyOccSMqnfFXI0w57dUX6XEY8sg5oA+SC0tjctkPHjf/FCGOIotXPSA/hMw7R6QhUEDk0rd7VkvkMJJ5qoncP+//VLVQ6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737446439; c=relaxed/simple;
	bh=UCjSTD47UZoLCkNUIH4RHElQ7T2ojCZ3cMzsah/9X5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LH+cDiVwjG086btBWnj1Y1C/j8SrhXFMFwk7Pyg/70CfzkcOPynqseHufIRAGww3WRA0JsuWdukzp+NSbHufWG0ojwxJF0+VG2uQbaqmZ6eBkYd1rV+mNzZ7fNkm/MRkRQxhS7SMM1Rh8ZM5g/yFceUgk8KTwuGKDEMvVYPvSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J21IpahK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L7GK7j027236;
	Tue, 21 Jan 2025 08:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pxpKycdt7jDHWX7yNXRM9b6Ji6UXb6uxS2e0r6fhCuo=; b=J21IpahKjR9WgEtw
	QFvKVBZZ8TWL70XfWYOpIs1DRVY9sSPgJe42y4WAnqZIdvLMsEBLvvaBdXVrch8p
	BfjVfOx0NSctzuFjgoFY8X82nNZqfnFJ1Yxiv3MCDyn7g0x3u12CxQn7Ga25cjl1
	ol2hwHlLkPrnLtkeMSULTOb6vRqDANU+MijvzUlI5ll05mXw/PcfGf4Zpy+c/E9c
	bJ+SOYcWNZogPycb+C3swwUtTAV+x4XS3xvnJIH8PxXSwrhh2dTW3kTJjTCS7prH
	tef5KxRL9OV7g6Nf2s1sZPxCtvc+d4T/zCPiOKPsaUSia5Jqdz8an3Xh9VjURSOw
	fz/zvw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a71nr3bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 08:00:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50L80YD5016586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 08:00:34 GMT
Received: from [10.253.36.159] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 Jan
 2025 00:00:32 -0800
Message-ID: <12fad7bd-86cd-4c93-8fa2-35ec7b10f5e7@quicinc.com>
Date: Tue, 21 Jan 2025 16:00:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] wifi: ath11k: fix data out of sync for channel
 list for reg update
To: <ath11k@lists.infradead.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250117061737.1921-1-quic_kangyang@quicinc.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <20250117061737.1921-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EzpMOBbqkz_UmGZec5mUAb-wWhqGXE0a
X-Proofpoint-ORIG-GUID: EzpMOBbqkz_UmGZec5mUAb-wWhqGXE0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_04,2025-01-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210065



On 1/17/2025 2:17 PM, Kang Yang wrote:
> Currently there are two threads to updating/fetch data of channel
> list, and there are no synchronization for the data, it leads data out
> of sync for channel list when doing reg update.
> 
> So change the call flow to make sure the fetch data running after the
> update data finished, then data of channel list become synchronization.
> 
> Note: This patch-set is an old patch-set in public review written by
> Wen Gong. Just continue sending it for him.
> Link: https://lore.kernel.org/linux-wireless/20230329091235.19500-1-quic_wgong@quicinc.com/
> 
> v5:
>      1. rewrite commit message in patch#1.
>      2. update copyright in patch#1, #2.
> v4:
>      1. rewrite commit message in patch#1, #2.
>      2. use list_splice_tail_init() to move list entry.
>      3. use data_lock instead of adding a new lock.
> v3:
>      1. rebase on tag ath-202411251703.
>      2. add KASAN BUG report in patch #1.
> v2:
>      1. rewrite commit message for patch #1 and #2.
>      2. use a local list without the spinlock held for patch #2.
> 

Hi, jeff, aditya, vasanth, any comments on this patch-set?




