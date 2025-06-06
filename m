Return-Path: <linux-wireless+bounces-23797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D39ACFDA5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 09:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51006178853
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 07:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7F1283FEF;
	Fri,  6 Jun 2025 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rf/IuWwU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F04B25F98C;
	Fri,  6 Jun 2025 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749195832; cv=none; b=GQqGbpOySG4/TBFdVqAl0Hs8AY7EOga4Vo6lCxtF42nvIiGRZwXgvjsTs6s1T1TmyHEibD2KDKSX8uIS+YiVGH7pHDDatQQr9qT6I8SnMydJCF3yi8EOJ/1NIyF4IaUKHj2z6ZTTCHFU3j/NlI4gd1wJgwryHsze+Z7kOXAiMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749195832; c=relaxed/simple;
	bh=yOTxnf0MNIgRnQyoM0bcoADdXzJwoUdRrf874ml8Lgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QsRS3DhB+xpNSuMJB2wuLI0ZYf554l22Wb1EnconuPFQN2S2uAuW+XnirYO6sY1pI1qrlyUf3OGwopno3rZDm0qeXjwKdeKb3wwriMmeKe5a7blyqvXpUPDKW3Iu15pyoSARQvNPlZ/p/PBYsB3G/p6NZQly/vwxUczNagFZBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rf/IuWwU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5566ZWlM004261;
	Fri, 6 Jun 2025 07:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kvMimh7QmZo25zRmksscLKSebUu4yESVGPBM/YkSIME=; b=Rf/IuWwUqko5Pe7u
	X/bFEkzJ8d61kOBJ4BZ1NhoKswDCH669TrkSGe/qiiMXhn0fJqGEmlO6JbcOIewg
	vfzgqS+lrpCNXJhMXxDezxZV2ymD/mv74jGy/+GZWvb8pM+WhR8fX5H5lGl0wKQ/
	hu9OyV8xMtf7tVr1NevW+wP5QC0cfDoocdOoh9iuwh16jh02GQ+kxxQaqxJqsuyL
	IW6wQCnUX9r+fMHsUEVpIBOA7QqKLfQ7g8s3P0HJorMB3j+KfKomdy+tE8LkF/Hr
	kH0vxauasnCjd1Ikc2q/c83omqHRBtMYrgNCsWd+MD4VF/MAOPPY65G8/XMucOgP
	tDvtYg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8s3wkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 07:43:44 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5567hduY011523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Jun 2025 07:43:39 GMT
Received: from [10.133.33.151] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Jun 2025
 00:43:37 -0700
Message-ID: <5330f0fd-5896-4426-92cf-8e8b39b19c14@quicinc.com>
Date: Fri, 6 Jun 2025 15:43:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
To: Baochen Qiang <quic_bqiang@quicinc.com>, Johan Hovold <johan@kernel.org>
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
 <bc2afbd6-2876-4f36-81cf-ad8960588a02@quicinc.com>
 <d3ec49ab-964b-4c50-a6ea-534b6c6e336b@quicinc.com>
 <06daee91-709e-4a98-b7ff-8233d33877b9@quicinc.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <06daee91-709e-4a98-b7ff-8233d33877b9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DWHs2zIX55j2eP5Dt9zGkwh4Ho0TqsAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA3MSBTYWx0ZWRfX7TfnkOcqDlxy
 ZYoAqFVH+P9hOTXH7Z5D9cIeT0OB1lZrEGURVjGYhhEybFvFizmL6Xb3tSlanLYD/C6pi3Zp5V9
 +5UJUNjSsSME8vHg2D2lCCxoaluYl9e6SHQrexCaJPwq8etk5wyvOFSoL6xKj6mcTekBIUPVhU3
 uUb1fNaZTzIBYuVa7+F6HOwT1zlhSrRgEMF0OJA+1ZT72Qq8DAffYNwPHL2aoXwkObWn9FxgWJq
 G0DBhgyUCQ3rU2VIk57MuwBZ3wPHZJxtcZjM1GB1FVQO0gX2255oDGr6IRwE+Zj54OVCz/RMuRV
 +6Rn+3eOeK47NhdxqYMIDVRcfJkGJeQfXSgOR08fONwsNCVGiwsoQ7ZWCOcRWwOAeV1xwH0ws5h
 wM/QrTe1HmsSDkOUTpMao7KaVjhBkOQmFTZ+MXOUH0oM5EE9hr4dvVn8caHkk5PM5yfQvdV3
X-Authority-Analysis: v=2.4 cv=RdWQC0tv c=1 sm=1 tr=0 ts=68429c31 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=3zI7SI0Xz8OAuioJ69MA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DWHs2zIX55j2eP5Dt9zGkwh4Ho0TqsAE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506060071



On 6/6/2025 10:02 AM, Baochen Qiang wrote:
> 
> 
> On 6/6/2025 8:52 AM, Miaoqing Pan wrote:
>>
>>
>> On 6/5/2025 6:54 PM, Baochen Qiang wrote:
>>>
>>>
>>> On 6/5/2025 6:17 PM, Johan Hovold wrote:
>>>> On Thu, Jun 05, 2025 at 12:01:29PM +0800, Miaoqing Pan wrote:
>>>>> On 6/5/2025 12:24 AM, Jeff Johnson wrote:
>>>>>> On 6/3/2025 7:34 PM, Miaoqing Pan wrote:
>>>>>>> We previously had extensive discussions on this topic in the
>>>>>>> https://lore.kernel.org/linux-wireless/ecfe850c-b263-4bee-b888-
>>>>>>> c34178e690fc@quicinc.com/
>>>>>>> thread. On my platform, dma_rmb() did not work as expected. The issue
>>>>>>> only disappeared after disabling PCIe endpoint relaxed ordering in
>>>>>>> firmware side. So it seems that HP was updated (Memory write) before
>>>>>>> descriptor (Memory write), which led to the problem.
>>>>>>
>>>>>> Have all ath11k and ath12k firmware been updated to prevent this problem from
>>>>>> the firmware side?
>>>>>>
>>>>> No, as this is not a widespread issue, and addressing it would require
>>>>> modifying the core underlying modules of the firmware. Therefore, we
>>>>> chose not to proceed with that approach but instead used the workaround
>>>>> patch I previously submitted.
>>>
>>> If firmware has a concern, how about doing it in host? As I know it is only a register in
>>> PCI config space?
>>>
>>
>> No, host can only configure the RC, while the initialization of the EP can only be
>> configured on the firmware side.
> 
> Are you talking about this specific register or whole configuration space? If it is the
> latter case we already have something similar (such as disabling ASPM) done in host side.
> Just curious why not for your issue.
> 

ath11k_pci_aspm_disable() disables ASPM for RC, not works here. But we 
can configured via WMI, which was one of our previous fix options. If 
there are new questions, we can discuss internally.


>>
>>>>
>>>> I strongly suggest you fix this at the firmware level rather than try to
>>>> work around it in the kernel to avoid playing whack-a-mole whenever a
>>>> new (hard to track down) bug shows up.
>>>>
>>>> The barriers should be enough, but if they are not then the firmware
>>>> must be fixed.
>>>>
>>>> Johan
>>>
>> This is beyond our control. After nearly three months of effort, we have decided to
>> abandon it.
>>
> 


