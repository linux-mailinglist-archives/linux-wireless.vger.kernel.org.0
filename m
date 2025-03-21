Return-Path: <linux-wireless+bounces-20647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39513A6B876
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 11:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D39189B312
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 10:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B82D1F2377;
	Fri, 21 Mar 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gIzMRrhZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB9EEB3;
	Fri, 21 Mar 2025 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551555; cv=none; b=lQPpROHPl0vj7WmyJmsT/0omvF4tj2pfYvxzZVLFzwEmZcMY3At6oGypXijtXd7bqRBiQFhKGcsXUXf0FXohRszP77jGIufvQiUEcwpwGlyaJJXfz7CIh86jW4AygxFFoCnBeXc58wfYaHiIkl7YbCA0/CjQ/Mbrl2L4sOPBWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551555; c=relaxed/simple;
	bh=5zGJESSrFyso4aAzqspLg1smoHuqkRgkzAl5UvK1ldk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pV07K945DqATQ80nFNDACM5e5HR0SQkZNgZodeyuBlkagXTj0y4oTomAUS3hI6FRXDeZ14ss0aMAsvKjSjNQESp21YICt8EUmMyuJs8Init09GPFF+vJL+gyIaIqMaSRxK4/KJpeUl1L24gdcIiw842fRY9N+2mzBKYTU1Ib4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gIzMRrhZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L8jqpG024431;
	Fri, 21 Mar 2025 10:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cownQeaNKotfNpnWP3evwhveSIqV0xcm9PmScvHDYKk=; b=gIzMRrhZILf/1/En
	CooEYLNz577v4ayQEKtBrzlyXAs5paeSu/QWEFGWmQUUGdPUBUixNxI6bArSozph
	0EUyeom1raTPYCoKIUFuM55g9BWAsTVyZ8s2EjqZfbQGyPreotL9x6EP/5ntna4r
	3lC0R8Sm6bj03N0Xo6/VTJvMrWyEFyrZ9bKisUFgz0hUQ4mRAysweySoQPZKHK2x
	Q23ChjHV0ldp5wM1d/hUVk8h1TjMaIm+oqOgt4FTxrKHgsOwtR+QpBfUp7YU1zV5
	wJsfyQgzXggPSS4XBJwFVLkEZ4lSN/lsF+6XvTjptbmYPcI811lzbWlBgBGujn09
	sXywOA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45gbngmh50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:05:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52LA5i8Y028204
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:05:44 GMT
Received: from [10.152.207.135] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Mar
 2025 03:05:39 -0700
Message-ID: <1b61a708-d003-4da6-978e-064df287d362@quicinc.com>
Date: Fri, 21 Mar 2025 15:35:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v11 08/13] wifi: ath12k: add AHB driver support
 for IPQ5332
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>
 <20250317204639.1864742-9-quic_rajkbhag@quicinc.com>
 <683b16dd-a3e9-4cc3-836a-95f3747d3c0a@oss.qualcomm.com>
 <0da16aae-2fa3-49a4-bdd3-f08a7655365f@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <0da16aae-2fa3-49a4-bdd3-f08a7655365f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d4VxAIqKQQdQWyHNq0GDdknruC3bLOFQ
X-Authority-Analysis: v=2.4 cv=MJ5gmNZl c=1 sm=1 tr=0 ts=67dd39f9 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=PCo5qUFWOPHZosJy6w4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d4VxAIqKQQdQWyHNq0GDdknruC3bLOFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=962 clxscore=1015
 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210074

On 3/18/2025 9:20 PM, Krzysztof Kozlowski wrote:
> On 18/03/2025 16:44, Jeff Johnson wrote:
>> On 3/17/2025 1:46 PM, Raj Kumar Bhagat wrote:
>>> +	hw_rev = (enum ath12k_hw_rev)of_device_get_match_data(&pdev->dev);
>>
>> kernel test robot warns:
>> cast to smaller integer type 'enum ath12k_hw_rev' from 'const void *'
>>
>> looks like others have fixed this by first casting to (uintptr_t)
>> a few examples:
>>
> Cast via (kernel_ulong_t)
> 

Thanks will update in next version.

