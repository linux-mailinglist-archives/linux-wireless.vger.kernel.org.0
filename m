Return-Path: <linux-wireless+bounces-6289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EFA8A43B3
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Apr 2024 18:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EED71C219B4
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Apr 2024 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B35CDE6;
	Sun, 14 Apr 2024 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="feRxX39z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D10537E6
	for <linux-wireless@vger.kernel.org>; Sun, 14 Apr 2024 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713110594; cv=none; b=p0dBS9y9owjngiQfo6jisrQbX4dI4z4qCe6S3X1xB0ZFGaXYYspjMcf6BJ184buxOHVt7s4T8iIWHyc2DChSMBilJLpwlSw66CYOUt4bIvAwGEoBfgxnSHhGp9IDMm5U78mZe+kWmtDo4WC+gUf+f5ro66jDGhbQiyzbKHLMTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713110594; c=relaxed/simple;
	bh=uYA4pdbfgN0FfYN9rufke04YuBixmvnQMje5qi0pvCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HzY11iaPl+vOFyimD+y1KRX38kJeOQqUtZnjJtT24zukhw5jl3Y0nr25zI8q+mqJejcHxADIYPczgKar7MFudiICnVKdt9ag/8DrHOR1TylBn5lunXL50mPkexOXVOY7tez8on6rCVPPWr6zHSHsQ/sG2IoUI15gFG8nPU0RzV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=feRxX39z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EFj1Pm028162;
	Sun, 14 Apr 2024 16:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=b7sXiZWbVaQLVMJLEgLzIzQtQ1IA+NPXx9RazLpNY+M=; b=fe
	RxX39zWEBt/w/US795nZ4NdO6qb46x2CDwASEBcPULjrBSKSksV/TK3SBjud5iWs
	beEn9tPY0qn1e8MyKwm6gtBgOf7s34rk7FdApMQETAMHg6fB/PPaFct56J/PNFak
	3jSdHADmfMcdIsIp43uWiYVt+IsY4VTkcqtc+RBjTWlTdVIn0Zl9D0ne6c6pPxmr
	1v6DzeU1r76Ef/VWmh/bqK0vbFOPIdob4QxedDLL6sAmmRgQLoujehbpix4D+00O
	p4m/p/zu5W2Z8K5AxgKMnFdzPmwz0Oi7vjaPI9z2H3Ph8B3Gx6u927ZdJYUIzDUd
	t0e7ZOjsZ0gEJLiO5dvA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfj4yt0wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 16:03:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43EG33e3020547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 16:03:03 GMT
Received: from [10.216.32.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 14 Apr
 2024 09:02:50 -0700
Message-ID: <a97ebd67-4a6b-c9bd-f325-da05c9af0a38@quicinc.com>
Date: Sun, 14 Apr 2024 21:32:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-US
To: Ben Greear <greearb@candelatech.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
 <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
 <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com>
 <31f30c0e318904f3a082c7f213576ceb1f407141.camel@sipsolutions.net>
 <20b56e52-a5e2-70cd-a62a-8c4a3526c2cf@candelatech.com>
 <614bb8a8f1d9174ad7d87cf7636f657cda7b1ef9.camel@sipsolutions.net>
 <72f491f8-dd3a-0c9e-7490-4d51c86f2102@candelatech.com>
 <cb991a00-fce2-5a3d-c03f-579b44f922f5@quicinc.com>
 <87de72e9-1d3b-b401-a712-9fe8734515b6@candelatech.com>
 <31aa6b18-8ca4-e4ce-f693-e818fc7e6932@quicinc.com>
 <dbd51b99-8472-2641-7493-6b91e384b4b6@candelatech.com>
 <54807acb-b7dc-851e-27ce-49e09df5e1e4@candelatech.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <54807acb-b7dc-851e-27ce-49e09df5e1e4@candelatech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8KOfwoJ3EaZ087GL7VWHa7DigkoKi8eE
X-Proofpoint-GUID: 8KOfwoJ3EaZ087GL7VWHa7DigkoKi8eE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_05,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404140115



On 4/13/2024 9:10 PM, Ben Greear wrote:
> On 4/12/24 08:58, Ben Greear wrote:
>> On 4/12/24 07:31, Vasanthakumar Thiagarajan wrote:
> 
>>> As said, please feel free to propose an alternate solution to address the issue.
>>
>> I do not know the particulars of your driver or driver's needs, but at high level:
>>
>> *  Leave existing wiphy mapping as is.
>> *  Allow adding new combined wiphy(s) on top of groups of underlying physical wiphys.  
>> Sort of
>>     like bridges on top of Eth ports.
>> *  The combined wiphy would report underlying wiphy's capabilities (for instance, a 
>> combined wiphy on top of
>>     3 single band phys would report itself as tri-band).
>> *  The combined wiphy would add new netlink field listing of its underlying wiphys.  
>> User-space wanting to control the combined
>>     wiphy would generally configure the underlying phys (to set 2.4g channel to 6, you'd 
>> set the underlying 2.4g
>>     wiphy to channel 6)
>> *  This should require very minimal changes to user space, except of course for new code 
>> to actually utilize
>>     the new combined wiphy.
>> *  MLO links and any other logic that needs the combined view would live on the combined 
>> wiphy (I understand
>>     from Johannes' comments this is a needed feature.)
>> *  Or user can ignore that combined wiphy entirely and directly use underlying wiphys 
>> like we use them currently
>>     for sniffers, stations, aps, combinations thereof.
>> *  Advanced use case could allow combined wiphy to use subset of underlying radios (add 
>> combined wiphy on 2.4 and 5g, use 6g for
>>     dedicated mesh backhaul/whatever).
>> *  Interesting logic would be needed to deal with constraints to properly share the 
>> underlying resources (you could not
>>     add 16 ap bssid to 2.4 wiphy and also add 16 other ones to the combined wiphy that 
>> also uses 2.4 radio most likely,
>>     for instance).  But I think that logic has to be written
>>     either way and is not overly worse with this approach.
> 
> I had some further thoughts on this approach:
> 
> *  If someone has 2 QCA radio cards, and each radio card has 3 phys, would it be possible 
> to have a 6-link MLO
>     setup?
> 

As long as supported frequencies of the radios are not overlapping , it is technically 
possible to register 6 radios under one wiphy

> *  Could two be200 be combined into a multi-channel concurrent MLO setup with this approach?
> 

By nature, MLO device is multi-channel concurrent. Not quite sure about the
be200 capability.

> 
> *  For multi-phy arrangements like QCA ath12k and MTK7996, I think the default 
> configuration when the driver
>     loads should just be the physical phys by themselves (as mt7996, at least, does it 
> now).  This would be fully backwards compatible with
>     current user-space and operation. 

There can be configuration knobs in the driver to register it differently...

  But the phys would have netlink attributes that
> lets user-space
>     know combined phys (cphys?) can be created on top of them.  User-space that knows 
> about MLO can then
>     create the cphy(s) as wanted and build sta/vap/whatever on top of the cphys.
>

Not quite positive on the combined_phy+legacy_phy design as mentioned in the previous mail.

> *  For radios like be200 that are already designed to show a single phy to userspace, they 
> would not
>     need any significant change.

As mentioned, it is not lot of changes in hostapd/wpa_s. We'll post them once kernel
part is concluded.

Vasanth

