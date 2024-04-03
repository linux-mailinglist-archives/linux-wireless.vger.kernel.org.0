Return-Path: <linux-wireless+bounces-5813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF9C896DFF
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 13:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5178D1C25E90
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FAF1420A3;
	Wed,  3 Apr 2024 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X7zDRydP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6871420A5
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143284; cv=none; b=j0ldeAJvUF1SG/7+mNNFmIVrQMz0YH9aoZVYyJ0wun437jrL982kaOee3QocncDgrDQtOP3LIq9YG9VPy8ked0ZAIM5RpYIfTakFoPEFaGtp5/ANP51mDfCHyv3NNEoOQuotxkqiY+b8mZPP/jaHE3MZ42CPUNzHnsiX9iAYOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143284; c=relaxed/simple;
	bh=NtKU8+USW/X+9IPdP79q1Hjd/E5gGjo4KjceFszYa54=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mbJ7jf+dsTsGIYX/N3TM2CNza3Zp51w7DtzRylEVcAQMG9SKEGZp8lZ0BssyYzXEenm2r0oqlGlfQnVRR3SO1H6waQ7XYNhdStRsXndGoJ6TObjFpYfa78KQVORaCx9pRHV9LzKAAeK+hjz/qGdUqnAWzdUYXfZQE2YA6HTwqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X7zDRydP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4338g8O7021480;
	Wed, 3 Apr 2024 11:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oqkf5lQ/fDuGQnjKHJNVonlY9yGRjWaX2QxXO6E+zAc=; b=X7
	zDRydPnnRp7S0Z6dm5vzxbgn419CGVApA5eEFb2a7ptFQfKrIIoqCoHp0J9fbuO0
	7YOHAyBJalrNMLrUqz1LfhZdDpE7Xxa7RGBFKIXcs7vO6NdGPYb1Xl4YYwBWPs+y
	i46uNyxFpPo6ddpHgBkTf3QcwRbUSsMVHaUJKhNMlnuSAk7l7MSyaFMy/sIhRfp0
	xiWPmo6AzTlJA9yN6UQU1vvKTcrUDdGNgDEhXopsoOLFV/cqpmejvrCVxIsmMWP0
	mluD/JX/LXhrjzShplD32Jum+ji08uXv1R2L6ddrd8MsORHZUrwad+YnmH5AIfMl
	rXpsw3Xr3lJ1RHDY0geA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93u58b2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 11:21:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433BLE2j025828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 11:21:14 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 04:21:13 -0700
Message-ID: <9200cdc1-00ae-d3bb-1f3d-abb4ce993cf7@quicinc.com>
Date: Wed, 3 Apr 2024 16:51:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/2] [RESEND] wifi: ath12k: refactor the link capable
 flag
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240403042056.1504209-1-quic_periyasa@quicinc.com>
 <87o7aq68a3.fsf@kernel.org>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <87o7aq68a3.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Tzwxm9eqnnMIW3H6A0DCNe5yQdNU_LVI
X-Proofpoint-ORIG-GUID: Tzwxm9eqnnMIW3H6A0DCNe5yQdNU_LVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=766
 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030078



On 4/3/2024 4:08 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
> 
>> extend the link capable flag to accommodate inter-device capability.
>>
>> v2:
>>   - Rename the terminology from chip to device
>>
>> Karthikeyan Periyasamy (2):
>>    wifi: ath12k: extend the link capable flag
>>    wifi: ath12k: fix link capable flags
> 
> Why the resend? 

I missed the version log in the commit message.

I'm not really a fan of these "RESEND" versions. If you
> need to resend something simply just increase the version number (in
> this case to v3) and explain in the change log why you sent v3. That's a
> lot more clear for everyone than having "v2", "v2 RESEND", "v2 RESEND
> RESEND" and what not. It's not like we are running out of version
> numbers ;)
> 
> But no need to resend because of this :)
> 

Sure, i got it.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

