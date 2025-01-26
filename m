Return-Path: <linux-wireless+bounces-17940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048E5A1C633
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 04:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14FF3A540F
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 03:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700861990D8;
	Sun, 26 Jan 2025 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e3BhZNg9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B57086346
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737861262; cv=none; b=XcGoltvZhD37x6heExMIXwyInnVXCBONkMRVNOYFIAK6XRta0YOnQT7x9z6VZBE3uakRkfR6rRhfMh7BR5KiB7jl5zKksjxsDMLh+MiMIlQ0bhbgLMzCC7qajvFnXlS/lFIZMMgnNwEAex5QEvBaC+lcQJ37C7Rig8RElqV1YbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737861262; c=relaxed/simple;
	bh=jL26En3TJkqBUHxRkbOj2aBBJbVO8dVQl9FWgsKqCjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EOuqjjrr2h9ZkGw0irYlyl0RghsT8eeB5dyRgu2RZQnvlVUsQDqkgELJ24OcYj2xpV0/SODT/qajKbLudI00+1R3YjVaPGpxjm69v/viq7+bp3M1ZzpHNPxFDsmEGPJCIOqk7hOzHvs7HcXhwuxvPs1/IpVNUy6CBwR+DGIoRuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e3BhZNg9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50Q2TcgX018344;
	Sun, 26 Jan 2025 03:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FRXUReabGoZcG6Oq0F2is6yZcmzA8B141Vsc4ngdqs0=; b=e3BhZNg9wFH29LOY
	Wa17924AwqRASRvQQKkF0Ka24+9QCKniYQyEXQVIs2w8lpnebD+lQGfR37NfWAOZ
	nZh+nIQkiMzBpxr8F8mHaDp0kxQGszBOAhd/1Hkiu6fV5A3cvRW/317gWsH4d5D8
	He/wSruM9ycMUmhRMMbRzb4iOt4LqYngYQIPOr9hLLKK5KyRtBITHu4pk7FLmy6O
	Ivp56uwKzYNRLWdREMHiSBDSQkkCxI9VfstrfA2jVp/385v3nY2aMDJoedKZ+vGU
	JIpKDcCpyavz6pmbeHTVO40+vnPQ4I7XCOkCeHeI3dgH0hO0Nm7cr/Kw6QHwLLyY
	nDh4+A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs2ch9gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jan 2025 03:14:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50Q3EDxO018405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jan 2025 03:14:13 GMT
Received: from [10.216.36.114] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 25 Jan
 2025 19:14:11 -0800
Message-ID: <64d6c0f7-a763-f988-5863-92d66cfb768b@quicinc.com>
Date: Sun, 26 Jan 2025 08:44:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: ath12k: fbx: fix ath12k_hal_tx_cmd_ext_desc_setup()
 info1 override
To: Nicolas Escande <nico.escande@gmail.com>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250124113352.93638-1-nico.escande@gmail.com>
 <a979cbc5-5cfe-160d-d5b9-9e5ed7513ed1@quicinc.com>
 <D7B63ACJOYD0.1XBZ5VB991KOW@gmail.com>
 <18b47227-6b77-a029-2e80-04a0455ac091@quicinc.com>
 <D7BFM42HW2NL.2IZS207VTCTJN@gmail.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <D7BFM42HW2NL.2IZS207VTCTJN@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ukLHRLLp030obmdakbtblW6KsK6-ujG2
X-Proofpoint-ORIG-GUID: ukLHRLLp030obmdakbtblW6KsK6-ujG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_01,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxlogscore=988 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501260023



On 1/26/2025 1:51 AM, Nicolas Escande wrote:
> On Sat Jan 25, 2025 at 3:54 PM CET, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 1/25/2025 6:23 PM, Nicolas Escande wrote:
>>> On Fri Jan 24, 2025 at 4:31 PM CET, Karthikeyan Periyasamy wrote:
>>>> On 1/24/2025 5:03 PM, Nicolas Escande wrote:
>>>>> Since inception there is an obvious typo laying around in
>>>>> ath12k_hal_tx_cmd_ext_desc_setup(). Instead of intitializing + adding
>>>>> flags to tcl_ext_cmd->info1, we initialize + override. This is needed to
>>>>> make broadcast frames work with ethernet encapsulation.
>>>>>
>>>>
>>>> SUPPORTS_TX_ENCAP_OFFLOAD not yet advertised by ath12k. How it work with
>>>> ethernet encapsulation ?
>>>
>>> Yes indeed, I made a small patch that adds the right hw features via a module
>>> param like one of your CLO patches did:
>>>
>>> +       if (ath12k_frame_mode == ATH12K_HW_TXRX_ETHERNET) {
>>> +               ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
>>> +               ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
>>> +       }
>>> +
>>>
>>> But maybe as this feature is not yet enabled upstream I need remove the fixes
>>> tag ? After all It seems that in native wifi this bug causes no harm...
>>>
>>
>> That's right, also you may want to remove fbx prefix in the patch title
>> as this change has nothing to do with any particular platform/hardware.
> Yep indeed that fbx thing is an oversight on my part. I'll send an updated v2.
> 
> So You guys prefer I remove the fixes tag then ?
> 

Sure also you need to mention "ethernet encapsulation enabled in future"

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

