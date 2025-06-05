Return-Path: <linux-wireless+bounces-23749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D662ACEE25
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF061891605
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E557C3C17;
	Thu,  5 Jun 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WChuD8cC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9621CC7D;
	Thu,  5 Jun 2025 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120902; cv=none; b=oG3QNV3pg7B2ikMcOKoz6+JUUxWQkixyULJXAkBSrINa9bk/zDxauEEQEkVSJOLGiiLaNESJ6BjVwQvP0JA4SOvEqBYfa0bXmOfocdROAFe2AQbCVa9t0dZcxAkNnUYRnDbvs+DidHVC9CLMKMzl222Ams/khbF2uKSzBziqpNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120902; c=relaxed/simple;
	bh=oL8UNlItjO09rTo/5XXHp2PV65ll8PtmJwdChEGWZRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ypstx+B1cbaZbVcG+X1IjicbEwNwSDbUCKYn7LU1wmU10Xc+cn9cT5KdvKnO3gALmuLf3Y8v5q0y1zmKKsn/yASi/1/5hBIFy2ngjGSf2HGHdNZw21EzpXRLPsXWtZvTn4SaWaYZMrssxHJ6Rz+/qPGKpm5FTDqXUy31OjVON0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WChuD8cC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5557vuRC032470;
	Thu, 5 Jun 2025 10:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	85+ceBbvXngkgMCPnXPPIeodiqDgYYYVEM3rpeazG10=; b=WChuD8cCU7ZxiJmq
	fXJK2w0Jrdzpf7KArYziGA6EZqQJxasAg9Of7J+AvDWA+b2hjxdlbs9hjWKIN6ra
	SifxyZSO8VWhbKHhzVbRb1Kfq+KF1WMlytTmDEKsPr2MEHlc5kw/X3oI2DULcE6d
	BTs5LcxCSFJ8IX12qOh3/UG0k3JwkhVm6ujrVCESffXaEno+hSX0USUUogUuc81c
	yEOH0jQ8nxmF/9x43/4odhXGpvG766G5pWW4icu5NqRvL/TAEc+7wD/z4UyxVImy
	39+t64K9WgnH/3CutS7meF5MBlI5lwRI2D7uYO2O32X+bI/HCV8Jaue1WP9ArvJD
	X/4Gmw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471sfuyw89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 10:54:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 555AsrRZ004235
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 10:54:53 GMT
Received: from [10.253.10.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Jun 2025
 03:54:50 -0700
Message-ID: <bc2afbd6-2876-4f36-81cf-ad8960588a02@quicinc.com>
Date: Thu, 5 Jun 2025 18:54:48 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
To: Johan Hovold <johan@kernel.org>, Miaoqing Pan <quic_miaoqing@quicinc.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
 <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
 <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
 <50555c1a-c200-4ac0-8dfb-424ff121b41d@oss.qualcomm.com>
 <03354d56-ed21-47e0-a52e-14f559ff3bfb@quicinc.com>
 <aEFupJ_nd9ryaTVt@hovoldconsulting.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <aEFupJ_nd9ryaTVt@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CY8I5Krl c=1 sm=1 tr=0 ts=6841777e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=DTG5F7EvfL9Zed4wNp8A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: H-rPxJXCvxRqa9JH4MYBZbZ804JfA2mL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA5NCBTYWx0ZWRfX5JbS4xF+m6V3
 RjURspgqSScU3yp6x+9pwC5B73Ai2FgHc+CmoiS4c1IbnUVbFK7ddh/p4FKHjocHjCy5e3i8sMU
 unUYo0mb2PPeaWcxg+bCWGFwIO8kkVJVtTdSPcU3/CacHWC9d4bbT/INYIUZ5r6WPtRebGRzoYe
 bsgY0zqy12OGpk7Vr42h+8IK5na3c5NhVQlSXCWLXFc8xKnLbITK2MdTIkb/xlHNx6G0bUh1vGo
 UEur7xdWl9z1XHPJYUChbpnySRtnis8HdBOQbW7jlmdpVejpQLIJnh++IMRSWqajfwVaHZta9CM
 560OyhyMkvqlesAoga/E4GySmkYfwOmHSeNIHr1dhpVLf7nyYymonpw0tKVWKerjaSWJ6TtEue9
 IOzOIZE+pwentze2bOm8dfRET1HWLYV3StrwywlUhVGNruwdpBW0AA4IlAmXaoN+Xy8kEQbg
X-Proofpoint-GUID: H-rPxJXCvxRqa9JH4MYBZbZ804JfA2mL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050094



On 6/5/2025 6:17 PM, Johan Hovold wrote:
> On Thu, Jun 05, 2025 at 12:01:29PM +0800, Miaoqing Pan wrote:
>> On 6/5/2025 12:24 AM, Jeff Johnson wrote:
>>> On 6/3/2025 7:34 PM, Miaoqing Pan wrote:
>>>> We previously had extensive discussions on this topic in the
>>>> https://lore.kernel.org/linux-wireless/ecfe850c-b263-4bee-b888-c34178e690fc@quicinc.com/
>>>> thread. On my platform, dma_rmb() did not work as expected. The issue
>>>> only disappeared after disabling PCIe endpoint relaxed ordering in
>>>> firmware side. So it seems that HP was updated (Memory write) before
>>>> descriptor (Memory write), which led to the problem.
>>>
>>> Have all ath11k and ath12k firmware been updated to prevent this problem from
>>> the firmware side?
>>>
>> No, as this is not a widespread issue, and addressing it would require 
>> modifying the core underlying modules of the firmware. Therefore, we 
>> chose not to proceed with that approach but instead used the workaround 
>> patch I previously submitted.

If firmware has a concern, how about doing it in host? As I know it is only a register in
PCI config space?

> 
> I strongly suggest you fix this at the firmware level rather than try to
> work around it in the kernel to avoid playing whack-a-mole whenever a
> new (hard to track down) bug shows up.
> 
> The barriers should be enough, but if they are not then the firmware
> must be fixed.
> 
> Johan


