Return-Path: <linux-wireless+bounces-5885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F21899409
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 06:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F747B25B21
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 04:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33DA1CA87;
	Fri,  5 Apr 2024 04:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jU4KEJvF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D81CA81
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712290522; cv=none; b=hdVVRIEKfXoNNlnfKBW3xB2TIXUilpunmMH23MY0rV7CFiPM7/LxYRTlw27DE+r8AovvY+4L0DwS64+O6cNBGlaynIsb6Mr1k/2W9HsaOO25vFtE4lF9yfW0hTg0SaZBCS7SDvE6TAb5Q9PGjqzo4uXv+s9+b1fIvDSHwpLGsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712290522; c=relaxed/simple;
	bh=ngKP/OHGamdqtEzw63J4/ipzOKQNNaJckbIBJb3bqQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l6eTDHo/lQ8fOUsRjIQ/PbTTaCB1snZUFa+Vc/6EXm0iXYN4Nf/g2tcHHYqLwyeCk4akQAoRXGhibI+Vl2NdpUg3q88BBTI2q1e2VQD1KgjJO7kfAEbhcuf66GbnsIb3kRwU/k39V1D/dutEWJklAGOuFffvozU6kaR2xK/7XYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jU4KEJvF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4353gmWX005904;
	Fri, 5 Apr 2024 04:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3d0gVKTck3UuyEjnJ0xBS+0/x7AKNYdoDGzkl91jKZ4=; b=jU
	4KEJvFtw9Uv9JI4GDkKwisblXW58eFpfGfKwqioxIfsW2siUEAP+N6jtZNx2bv7v
	pkEREDgFFjpHIM3cZzotovrTqU4DP1wA/oAw4zXkqwzCt7q09AXCDF0FTYPvqJjW
	W9x0OyUMKiG+dKM8gCukhCfMUBes1Dd1vRTUphu7yviicJS//Gl05odN19AQfiMB
	MvN+hUvtSnNB8wHY5B2dWQaTOsDsWGFWcCOEbb7DfsY2LsFgjX8EzpYIO+5U0Zab
	Y7cD5us0XurOREFKo4F8rXFqS+3okBE3Fu+L6YGMSsT26Oh5Cq3Mi9ULVu9/nuMi
	BexszgndMMwyZb68HEUw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa7m5g6vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 04:15:08 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4354Ej1f002626
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 04:14:45 GMT
Received: from [10.152.203.89] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Apr 2024
 21:14:44 -0700
Message-ID: <1f0ae919-0562-4da0-8218-69cbb21e6068@quicinc.com>
Date: Fri, 5 Apr 2024 09:44:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] Add Multi-Link Reconfigure link removal support
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240404185950.776062-1-quic_mdharane@quicinc.com>
 <0ec145b0-b10f-4a89-a905-0bc804403f38@quicinc.com>
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
In-Reply-To: <0ec145b0-b10f-4a89-a905-0bc804403f38@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SwZWSdo-HFVa2sMH6lZMnyMGlnk5OLOl
X-Proofpoint-GUID: SwZWSdo-HFVa2sMH6lZMnyMGlnk5OLOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_03,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 mlxlogscore=540 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404050028



On 4/5/2024 1:07 AM, Jeff Johnson wrote:
> BTW for future reference your subject should contain both PATCH and RFC
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> "The summary phrase may be prefixed by tags enclosed in square brackets:
> “Subject: [PATCH <tag>...] <summary phrase>”. The tags are not considered part
> of the summary phrase, but describe how the patch should be treated. Common
> tags might include a version descriptor if the multiple versions of the patch
> have been sent out in response to comments (i.e., “v1, v2, v3”), or “RFC” to
> indicate a request for comments."
> 
> 
Sure Jeff, will take care from the next patchset.

Regards
Manish Dharanenthiran

