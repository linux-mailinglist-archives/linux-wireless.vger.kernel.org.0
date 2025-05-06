Return-Path: <linux-wireless+bounces-22660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE63AAC1C6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 12:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517FB3B80A2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 10:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAE724728E;
	Tue,  6 May 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V2Goup39"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D620C028
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746528910; cv=none; b=WPh5hF8zhi0nGKWbV25dcysHcteEFR9gMZpS/hIuMj3AahT/RiPPRhxzpTpSqzkzarQC5DiIYcHUULST2oJzx7q3TAPfxh1kAaFmNqXuYmjvzMLV3oubRQo5LlCvsZNl+DSVhR89gi1gR7p7MnAmqlj9EomnhLMFjy3HQYkvlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746528910; c=relaxed/simple;
	bh=dkPTGPnLRWPhIxtSt2h9ChOvmywKDIEbvFUueJUMhRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uP9NS1fONfgdYIw4RSzLLypsobnJWBpygjYOuu4Dv90jnnwP6d52VgFlfDZyJSg7dKE4sd3Hh7dDgYXWpPc5ETF9kGoL8ql+eYhsZHt+4yCxzEGQlVPQgpEUMftiX/a04Y8QNhstqSsQ6CdnSZ0/BOsJsKMMjtUyCXX1qGNAE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V2Goup39; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546966kH026557;
	Tue, 6 May 2025 10:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l8dGx5ZXQnOJPW7nhdspPXNU1jTCt4yWyRTSl5aO91M=; b=V2Goup392neAxniM
	5oyvuf9f6joEEKeRzl/rewzT5nfrPE03vLlfANNkO136eAJZkk2XBnNWpwPN7eQe
	BTmpvU6/czL23QM8/qKRY+/KbHtGI1Y378tyJCDF6JIAv3cs+MYAEjYUfGc75x/B
	palgSPR83vm+gQLvnsR271LW5uomryy28wjExvWEHgBIL3WuNRU48Q2LD6KOrL1E
	dwQvD+y36lvLObHgLEw4w/xVRDh1uKVq19MFAaOTXUHLUq+kqTyk5xLzcGdBHN98
	ivF30OyEOzZ3l8IlCIDZb5XNg0sfs0aDI72444R5Kq/RPDXLm56RM0q/REs0P0RK
	DFoGLw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5wg1x2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 10:55:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 546At32U016770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 May 2025 10:55:03 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 6 May 2025
 03:55:01 -0700
Message-ID: <ae88ba1a-d5fb-492c-810c-562932584f12@quicinc.com>
Date: Tue, 6 May 2025 18:54:58 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k-firmware: Module no longer loads with current git firmware
To: Walt Holman <waltholman09@gmail.com>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
References: <CAMb39_ngQs8=FUML5QXMh2RmEZBZ2NwUHefhGoTkGtHat+KWJA@mail.gmail.com>
 <dc0abf98-862b-47f5-ae71-749c68cffc73@quicinc.com>
 <CAMb39_kUUv24q6QUq9B9+TEUMrUhu12-8WJadzB53nMPhcAZSQ@mail.gmail.com>
 <ef81db9e-99cb-4802-b17f-94eb623a8b32@quicinc.com>
 <CAMb39_m+4dNBDbkZmn-rDA7T+u84y-dx1jSfmPNWnse=R1=gCw@mail.gmail.com>
 <18788f02-e374-4aa6-ac4a-fd53bc93754c@quicinc.com>
 <CAMb39_=G_TEL1pbeF_PAZLQh-JOFcncSfqZChPmEj63NjsEOLA@mail.gmail.com>
 <16ccbe02-b315-40d1-8600-232b592d4dd6@quicinc.com>
 <CAMb39_n4tyrzS=-j0L+ekJVer=KiZyDYFhMqrrcpr9py_itU9w@mail.gmail.com>
 <0933d8d6-5b72-40df-95f8-69f6fbbdfde7@oss.qualcomm.com>
 <CAMb39_nHO_TbHPQawdLVY8nt3yt4wDuEHyEuzMa-p5Ab1n94sA@mail.gmail.com>
 <CAMb39_nQ-uyKAqCz1HEUDt5qjszbhzf3oikVcvzHcVwt4_qt=A@mail.gmail.com>
 <CAMb39_n89hBL_GvfXb7Jw9h5-h-+Qg-3GyqvpahL7MT5ewpvJw@mail.gmail.com>
 <CAMb39_=YPYg0q7Lf0sMgTx5QwKOqcyJrZR7kTspyXEDa6qz9Bw@mail.gmail.com>
 <CAMb39_m5Wm-5xjxYEJg4RxPZc1rdq0BkAJk_Q0B9APC3CAeORA@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <CAMb39_m5Wm-5xjxYEJg4RxPZc1rdq0BkAJk_Q0B9APC3CAeORA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5sH1lPW80jfv-v0sBqs3k9gucxH303f_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEwNCBTYWx0ZWRfXxJzwt+EpQVTl
 K7RbxE5CvAGLwBogCKQ3YqPPLeKjWbfdHaXsWvepge73C/d9Fk/o7uy2M1rw405YSKcI+XQB+gf
 IZt6ZzhrSjTLOFUBX4U8V75RNH3fCHKVOC/4tdYeek4WfR+3pWc2jBfd+swDgf2gJ/11mMspZR9
 I6JXsmXwYbC3LcH9i3cuQE3UUJk1R0zjGhrWc1ixr9J1IVagJJmjHZVeVe/N/eAFoNZE3eFiJTS
 +19SWrGjqicGyV/DpIsKgLYlHhWmi/4EFtb9iK68Lbv2caa8YglXfClDoEGUY+zqVpsVnsG1DCs
 DUutNhHwtX+KKMA6IaU3aCzIh29GYbqAWrNlPIvhCBHyqxIlIwq5A7zi3c+Rj2zwFszWjB56AG/
 /9vjovXN1U4fhq5cryp6Y/7HQdY20RIhEfoi0apxizPGt8h+nYPfRxxZ0uvZ3SK5yTczyPK8
X-Authority-Analysis: v=2.4 cv=dPemmPZb c=1 sm=1 tr=0 ts=6819ea88 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=qPgCAv-Wz5QOtFbVBs8A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: 5sH1lPW80jfv-v0sBqs3k9gucxH303f_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060104



On 5/2/2025 3:02 PM, Walt Holman wrote:
> Hello,
> 
> In my never ending quest for 6ghz WiFi, I saw there was updated
> firmware posted to the kernel.org linux-firmware GIT repository.
> However, my ath12k module fails to operate with the updated firmware.
> I've attached a debug log of the firmware loading logs to this email.
> I've tried loading in both 6.14.5 just now, and 6.15.0-rc. Is this
> firmware needing an updated driver that is not in the current stable
> or RC kernels?

recently we got several similar reports, we are checking into this. will update later.



