Return-Path: <linux-wireless+bounces-22997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B70FAB8438
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 12:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6D41BA302C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3D297138;
	Thu, 15 May 2025 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IjNzcljm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D5426AD0
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747305849; cv=none; b=F8plGBOwHFLd/sw8LUFw0vDda48dFRYuVY/tWm8f0d4YdSrOYObh/m5yqDBbb9L7lCJ6lvlGi36KGnsveQGDcmvMPXsuzku+wbNmleRydhsIm3oJsveMY4FT7F9GzzkL1yBqZ2FbI1kH4FMTQj1A/3Oh3f8rGecM6KqsD47dE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747305849; c=relaxed/simple;
	bh=vqRAsoa9jCv1ApLb5r/YyPB38DU8bHMH9BrH1XftyWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S/5f7E+kMB8eOoucmY/zSzniJ+HzPin9IpytE4farovXbxCVc0kc/huOavvkANu7jXmk6zd/mqt8hIOEBQGEMCI+V4VSlK/c41SYTEGH/SVG8GahZ+EdNjF7Q8ASFAxDHASAA2FZm5sAT7N+dEBFseoOarnoKwQmjwiYGeCltQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IjNzcljm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F8tBLi015942;
	Thu, 15 May 2025 10:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rft6n8fXBKWE/PoOMe4vR3FkzYNDQ+Duvoc/6hc64Do=; b=IjNzcljmwkFQVroq
	DtlCuf/302V3u/a/M8umluxyD911O/wQmsWidlhesVIL2nDQgK+tibhZxKJcD1st
	BIfacGn1yXvwgfdL7d1PoZkgD9lqMNVDEmdj1rDfl/7VAy/lSv527gbl+U5T9GEi
	ZyoAhafFiTQcNMTvylAkFvLqCskkdI8ldQ0ahaRxkLhVT57PWSudlIUk+pwRO6gz
	leNCMKB1C3T5zyRJq2SDeqsInxq/lqrJs9VH9JuGJDnN4u1Elr3cGNjCzH06i9+k
	afsncJhDvA0/jCOwP5VcX3I6DWvdJsjI185LUvGEQA5N7EbXB3B/iKm7j6EL1c2q
	NtH2Cw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcmx0br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 10:44:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FAi3ug027364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 10:44:03 GMT
Received: from [10.152.200.128] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 03:44:01 -0700
Message-ID: <9a7559cf-08c4-46ca-a263-4c912ebe0d06@quicinc.com>
Date: Thu, 15 May 2025 16:13:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix scan initiation failure
 handling
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250512065849.2833232-1-quic_vignc@quicinc.com>
 <52ff43fc-160c-4efe-ba9e-42a0c838fb3d@oss.qualcomm.com>
 <f0c8009a-829a-43f3-be03-c6b2a0b67883@quicinc.com>
 <ff4e8d8e-5835-4200-a479-baa0e44478f0@oss.qualcomm.com>
Content-Language: en-US
From: Vignesh C <quic_vignc@quicinc.com>
In-Reply-To: <ff4e8d8e-5835-4200-a479-baa0e44478f0@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T8NfU7bacvrJiywO0NBRLZ72ev8zHnKO
X-Authority-Analysis: v=2.4 cv=HZ4UTjE8 c=1 sm=1 tr=0 ts=6825c573 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=uWN3QdV81YwF6VYI-XUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: T8NfU7bacvrJiywO0NBRLZ72ev8zHnKO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDEwNSBTYWx0ZWRfX75iUfhy1TChb
 tqecFj6cylBbo3qo2L6579m0FsgT34kTU9TgJ8mJmaM0cH1yL14XBQb0f8KG43xc+yhM209TUDp
 73FXZI8Y9AgyBAYymc+PGulCWkdz37rv3BploULtLSUksrCCTWY0ccF+PpKwj8dWmRhazvQmWJD
 eobOnT2j/ik+Ri7+ws5QssjNIDbiowkjEwE1GknoyOf27+BGkXxEnjSuwLfFpmzYt4uT+Jv09y2
 CR41FgOYM1JX04ywePkL4CHrm8IL2v8iVDAd93hzW24rK9t8XpI1Y6zqkz2VsMnn2xdqhFF8EaO
 K3oIWe9+HWjX7+IrQfVVhpBXw2HVDiLfYJZAxd2J3SlfBkyQNJ8NNrdAC01HvLVYOQfhsd4wpht
 9a36/EDXWzjsjuKdJwROpx/Co0HQNEyiKVyXTUBUWzjILiDphBzLpIbru7u93xDQUPsqx6XS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_04,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150105



On 5/14/2025 7:17 PM, Jeff Johnson wrote:
> On 5/14/2025 4:48 AM, Vignesh C wrote:
>>
>>
>> On 5/13/2025 3:25 AM, Jeff Johnson wrote:
>>> On 5/11/2025 11:58 PM, Vignesh C wrote:
>>>> During a code review, it is observed that in the scenario
>>>> where scan initiation fails, the current code schedules the
>>>> ar->scan.timeout workqueue which is not necessary.
>>>
>>> Are there any user-visible effects?
>>>
>>
>> When MAC debug is enabled, the message 'mac scan started' is displayed, which is misleading in scan start failure scenario. Additionally, a scan timeout work-queue is scheduled to attempt aborting the scan, which is unnecessary in such cases.
> 
> Since there are no stability issues this is not a candidate for backporting
> 

Agreed.

>>
>>>>
>>>> In the scan initiation failure scenario, exit the code instead
>>>> of scheduling the ar->scan.timeout workqueue.
>>>>
>>>> Compile tested only.
>>>>
>>>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>>>
>>> If there are no user-visible effects then I'll drop the Fixes tag since there
>>> is no reason to backport this to stable kernel versions.
>>>
>>
>> Kindly refer the above comment and please let me know the next steps.
> 
> There are no actions required on your part.
> 
> I've made the change in the pending branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=4545ccf7efbd97566eb6d98738013bb6d72ced05

Thanks, Jeff.


