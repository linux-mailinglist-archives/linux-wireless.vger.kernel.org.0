Return-Path: <linux-wireless+bounces-6210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0538A2481
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 05:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAB81C212BD
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 03:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C1217BCE;
	Fri, 12 Apr 2024 03:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LzLhBMr0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEA5179A7
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712893882; cv=none; b=ZBnHssNEYDWWWbt3S0xITjMMklYSLGhb6Op1o+DPtAw531yY8baQbLfYSitR8PfrmC1LygXAtebsnw1Fvz75iIS04eabtf/ipBZqrjhgmIAFw8UimdzRZgXXFvKoc8MGAvi1oZohXqOn+IoZ05kdr/CrnB6XbwwVLWXaNva7UVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712893882; c=relaxed/simple;
	bh=FLBjEPTjc9+9e+xMOQAGYKAZQVdLpyk1Iv0VRWv2sQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Evd5aWKVXuvDyC4qRe8apOPbKONKS/SX5IL8XZKABOto+f2cUw/0rj37RBS+lyn3oGNwK8BPZ7q5WQTuOt1fxKgZc+yt+g8az03L9pW5+lU5M3d5O+xIR2h7Hhuuu9FmS/fhn3URq65kXU3bfxiP0lbhVNqZg44U78nhnPOqb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LzLhBMr0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C2k2WO011223;
	Fri, 12 Apr 2024 03:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1r/E0101GQWKHBcIZz1azRURcntQtHEWDtn2SyCVTw4=; b=Lz
	LhBMr0voHCQrFhE+t1lYPhf2M34S/JQYAIIv/WqJAZn3WH8XzSoEEZ1FmIVIkG1C
	WYmvNuTtyrv75LrdV/Itttmqkbf+ADcDllMrFWWKCoRWvf9aRIfYGjzk77IwC3vw
	CXUbwQK/IrMzDXuA5WKcgtc+/MvQ8yykH3P38znGe3wmo7V921ksNSlA+Ya2W+jW
	yWJDM1dCoa9mkalUs/jwi/Xq8R9q7cvvCeCM46BwS1Tygrl9PgvadC1yDkO8le91
	Ivye5/tz1UAh2KdQNtjrvS7IOaHKa0U6rjuTiNmFYr6INjyz89uPNVS5bpWi753v
	QQeWokevclRt6tMIcE0w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeskt0cy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 03:51:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C3p3f9002745
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 03:51:03 GMT
Received: from [10.216.26.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 20:50:59 -0700
Message-ID: <6ff353e2-785a-f2ce-8d3b-acc8e79a64cf@quicinc.com>
Date: Fri, 12 Apr 2024 09:20:54 +0530
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
To: <mbizon@freebox.fr>, Jeff Johnson <quic_jjohnson@quicinc.com>,
        Ben Greear
	<greearb@candelatech.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
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
 <aa9e1d54-bb5f-37cc-335f-c9970ab13789@candelatech.com>
 <0cfe990b-182b-4ceb-b5b4-2989fefedb2f@quicinc.com>
 <29f7ecb6d7c208c3614f37616943d5f97bb134d3.camel@freebox.fr>
 <5fc2f2d2-7403-79d2-8909-ddda918ff8d5@quicinc.com>
 <af70ee81e583f58dada3dde87ac335137c4038b0.camel@freebox.fr>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <af70ee81e583f58dada3dde87ac335137c4038b0.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qUwxcKRjabywxA8BngawRbqn-uuaeM0T
X-Proofpoint-ORIG-GUID: qUwxcKRjabywxA8BngawRbqn-uuaeM0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=628 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404120026



On 4/11/2024 10:09 PM, Maxime Bizon wrote:
> 
> On Thu, 2024-04-11 at 21:56 +0530, Vasanthakumar Thiagarajan wrote:
> 
> Hello,
> 
> Thanks for making it clear,
> 
> 
>>> For example, starting a 5Ghz AP in ax-only mode, and at the same
>>> time
>>> creating a STA interface on 2.4GHz ?
> 
>> Yes, such use cases continue to be supported in single wiphy mode.
> 
> Understood, but I see some corner cases.
> 
> 
> For example, assume two bands AP hardware, 2.4GHz and 5GHz.
> 
> Previously:
>    - phy0 is 2.4Ghz
>    - phy1 is 5Ghz
>    - iw phy phy0 interface create wlan0 type managed
>    - iw dev wlan0 scan
> 
> => will only scan 2.4Ghz
> 
> 
> With single phy approach:
>    - phy0 is 2.4Ghz + 5Ghz concurrent
>    - # iw phy phy0 interface create wlan0 type managed
>    - # iw dev wlan0 scan
> 
> => will scan both bands ?
> 

Yes, both the bands will be scanned if freq list is not given

>    - <starting from previous state>
>    - # iw phy phy0 interface create wlan1 type __ap
>    - # hostapd -i wlan1 <config>
>    - # iw dev wlan0 scan
> 
> => what will happen then ?
>

Scan will be carried out on all the radios including the one on which AP interface is 
running. Scan with freq list can be used not to disturb the radio of AP interface.

> > Same goes for hostapd ACS, I assume specifying freqlist becomes
> mandatory or we can't predict which band the AP will be on ?
> 

If no freq list is given, ACS will run through all the bands and select a channel from any 
of the bands. But this can be optimized to do ACS and channels selection on a particular 
band using channellist/freqlist hostapd configurations.

Vasanth

