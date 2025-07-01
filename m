Return-Path: <linux-wireless+bounces-24744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9191EAF03F5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 21:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDCE44300F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 19:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4D2280022;
	Tue,  1 Jul 2025 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FzNCjAkQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183013774D;
	Tue,  1 Jul 2025 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398749; cv=none; b=LeRuoLdl4AyWPmLt1Re3t2tVs5ptkEwEvarky8t0b+KBgtCAAv3ANH3/gQ0+MspZmriSup5SQjT1M4lYvm0GnVassh+iq8k544yU91RAbbdmxg2839DhkYY4P9FT63gZkE6Jj/9nQ4hP7AJa6AjtVdbscWI5cURQXTKpTj4B9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398749; c=relaxed/simple;
	bh=X+oi+C+NeJe0ml2XjWB+XRwl9npgqiPcTQFoe7MgV48=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qa/y11iL3dyRP4aaQZp15am803DUVRErPKMD9g40HRfBxpXDpfo+x6ZJ7GVMISYHGC8cPCur4yeGiu3Fi31kk22xuNtzVL1isQrBjC4DVXKWgeEq8vwpyAEhHlDw/dkAvz++q4FNDBM+dOm9EP8LHhTNCiGCZjxdSp7qjifU87w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FzNCjAkQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561IUh8p029335;
	Tue, 1 Jul 2025 19:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qKfngTAurT4iyRTa3Xwc9PG5gvvKSpNISdr2PCKKsdM=; b=FzNCjAkQo1yDLX1S
	3M+3T0aI1LhYSlk0i6ZJ0T8ekgCNmOyJUcf4DFB64X3QWKmxE1464L9phQX/Gkfc
	ZgxL4Ys+pdoZo76SkVQ87gpgAACesoFbuBBkU361rwMYnGfmIUuO0n8thG8zKeV5
	7OAVmwmf+vDFF4yIfV74tGILXmaADUchmxl8PeBfojhWwNDqDcpIUKuHV4Le5QGs
	ywLJVi2NMJlnuLrAMnSefAVatjiMMSm96W1mbo4bSPfyDbo8NuP9mrEg6IXj7e6Q
	LjOVcS/CnvIxIHB/78GhSZnUmS82iEke3OGNFW0qozvy+gbp7d1MKxXtuUNVa0GN
	53HRJw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j95j1vmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 19:38:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 561Jco54017956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 19:38:50 GMT
Received: from [10.110.78.36] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 1 Jul
 2025 12:38:49 -0700
Message-ID: <4d87c56e-f198-4abf-a414-4b226178d164@quicinc.com>
Date: Tue, 1 Jul 2025 12:38:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DESIGN RFC] wifi: Robust AV streaming Design Proposal for AP
To: Ben Greear <greearb@candelatech.com>, <linux-wireless@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20250624205716.1052329-1-quic_rchoodam@quicinc.com>
 <0bc6c957-a0c4-c0f7-ed37-c8b44852c26c@candelatech.com>
Content-Language: en-US
From: Ramanathan Choodamani <quic_rchoodam@quicinc.com>
In-Reply-To: <0bc6c957-a0c4-c0f7-ed37-c8b44852c26c@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEzNiBTYWx0ZWRfX8i+amyYdqwGq
 6xZ0ml/tbqFl8DqhBxSSgNw2omD6nyiWsBrKb6MZL+9LaVywF8s/ecoTBEhme2aHxSOEqYM8lcS
 xZCRuBnJhFcNZdLJY1T87yzfgvDCmRGmIa//03llnzNPmNu2oF2VLQGnOIImEayaDlAgD9E+Inh
 mscCV6g3Yay8MhjIo04h8YuDB82xt9099bsmqsEFesMMKahg58+60XxWCle53PlRgS+nF9Kbjrc
 wc9ixnEGSJTp3vsezhDgzMToyT8LF9TN4IT6ldpvNfAhTbOD8DuVMhyNxqOZEdtDQeFTmOm8/pa
 GYmwQ4HW2cgO3gLUpFG0++wXLjb4n1Q8uAuQn1L1TLqXJ04AYV8OJleSFd1E0wbRAXokN5qNx4J
 5Wr3uu2T3z2+NsA4Cqn8tJMHxmFol/Quh+TuDjfp3Tg/FLm5ia0a7/rc21NSS7ShTagU/PlX
X-Proofpoint-ORIG-GUID: HFrjexPZOzL_bbnfJgOFo7qbQxIebGD6
X-Authority-Analysis: v=2.4 cv=EuHSrTcA c=1 sm=1 tr=0 ts=6864394a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=Ry8CqEVe23a1TkwwDiUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HFrjexPZOzL_bbnfJgOFo7qbQxIebGD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=963 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010136



On 6/24/2025 3:31 PM, Ben Greear wrote:
> On 6/24/25 13:57, Ramanathan Choodamani wrote:
>> ===================================
>> Robust AV streaming protocols - QoS
>> ===================================
>>
>> The Robust AV stream protocols are mobile centric protocols - meaning they
>> are initiated by a non-AP STA to the AP. These protocols are implemented
>> at the Access Point (AP) to classify packets sent to the non-AP STA which requests
>> classification using action frames. The non-AP STA initiates Robust AV streaming
>> action frames requesting for specific classification for the IP packets
>> destined to the non-AP STA from the AP. These parameters can be negotiated by both
>> AP and non-AP STA.
>>
>> Upon successful handshake, The AP classifies incoming individually addressed MSDUs
>> (Mac Service Data Unit) based upon parameters provided by the non-AP STA or
>> notifies the non-AP STA to transmit MSDUs with preferred parameters based upon
>> what was exchanged.
>>
>> Robust AV streaming improves AV (Audio and Video) streaming performance when
>> using IEEE Std 802.11 for consumer and enterprise applications.
>>
>> Let's look at the Robust AV streaming protocols which are implemented as a
>> part of this design.
> 
> Thank you for posting this and for the beautiful ascii diagrams!
> 
> Since this will be poking netfilter rules into the kernel,
> is there a good way to clean up all rules created by a previous
> hostapd process in case hostapd crashes or is killed hard and
> cannot do its own cleanup?  Maybe the rules could have some
> special marking that is configurable per hostapd (or per AP or BSS or something)
> so that a (re)started hostapd could clean up any leftovers from a
> previous instance?
> 
hostapd does its own cleanup (cleanup of stations and interfaces) 
when it receives SIGTERM.

An nft chain is created for each AP netdev/interface.

The nft rule handle (stored in internal hostapd data structure) and 
nft chain metadata can be used to cleanup/flush the nft rules as part of the 
interface cleanup.

> And, is there a mechanism to clean up flows that a buggy non-AP STA
> has requested but then forgot to terminate (like phone starts a video call,
> requests some QoS, then forgets to tell AP that it is done with the call
> and packets no longer need to be classified?)
> 
> Thanks,
> Ben
> 
The scs objects of the stations will be cleaned up during the station 
disconnect (by the AP which is maintaining them).
As part of this deletion, the nft rules are also deleted, using the 
stored nft rule handle.

/ram


