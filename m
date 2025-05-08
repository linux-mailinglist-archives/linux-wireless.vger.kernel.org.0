Return-Path: <linux-wireless+bounces-22732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F8AAAF625
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 10:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FE23ADEBC
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 08:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84DB21018F;
	Thu,  8 May 2025 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gx9YyZr1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5276BFC0
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694658; cv=none; b=QPVXXJwRmWZAfM2r/Zi7mdBwrVrlPA51aK0d1RaaDa0vJsBVDMP7h5/XGD0gamTMttT0y4I/7Mw2qbldu1j/vEWRlNkrkKM32XObJPgjYBQT+VwM3b+ldiFPY/k5nGRhdaZY6RHyB/5QbA1UHSWgRDsfOwvT8Uh/pwZjKoDyMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694658; c=relaxed/simple;
	bh=plztPfnSBOY8ZAP6WWx5UNsdHdpUzaBb0V4rFUEMf7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hi+R/0ABpgWZvmWfXrY3QJpmmZaHWG9AIRpbeuK1XezS3Rin/Iz3I4d98PzwJ11+P1AD7j5+mG2lasZngTZmzjfhVws0hp2JJqBEJUgm1XA61pdroKOtF390el8PUJU4n11mqrivspXICwvPRGWhjHvUM7ngnaDSww2JnjzY3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gx9YyZr1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484X8GO009179;
	Thu, 8 May 2025 08:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Db/B0c/yGcTM7WsaV02goRIDdI2FooG3zm/YJ1hovTw=; b=gx9YyZr1giklMKG2
	dq+YSsChxu5L9qloZNfxvnLfKw2m5hQxHg08WE8LRYLooXs0IumTdF3Kva6/oHVO
	KATmWypJ5jMfV/YuJlQNMw7uKy/KKrJmATkL+6FpWqGiQ4uelc6M/Xoss6op7Yk3
	8Yr/bQerKD2efbvgUQoQ9wvHNKkoZQqf32S2BMGmkw3GbLKz1idWX1DCdmMx82ni
	0E5BaV5eLMX/+KehkO9gmuC5FMRItUPB22W+sAHsj+5QCywmpAK3qlM7UC3V9SNc
	gBP9iNV0hULaXlVZkNcw9hRC1KPngNqRhuLKOxunk2tDxtPM9GkHpvPVSN9jKiiu
	aTdtog==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnperncy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 08:57:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5488vW1w015059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 May 2025 08:57:32 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 8 May 2025
 01:57:31 -0700
Message-ID: <0ff81c57-5b11-4511-aef9-062afa5a18fb@quicinc.com>
Date: Thu, 8 May 2025 14:27:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 04/11] wifi: cfg80211: reorg sinfo
 structure elements for MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <20250415042030.1246187-5-quic_sarishar@quicinc.com>
 <fa49a2d4927868be689ed8464aa27c3aad2f03b6.camel@sipsolutions.net>
 <cc89028a-c785-4f83-9c17-8c98b087748c@quicinc.com>
 <4997fc7c851086822d631a47275aa9ccaa6979c2.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <4997fc7c851086822d631a47275aa9ccaa6979c2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA4MCBTYWx0ZWRfX59Jtd4ffsFZ5
 Dn+Q997lItC56vqkJv6odbWkgvOnyRb00TpESDsWZ4VgCtJvzEvUKrWovOrka8f4tgMHNvNOm7Y
 QmIwVctyZtxFl7yx3TJrWzfClvTfoN3L4mzL0OykbWIt5eOIq+jcYXQ+RXESVRlCLCMpub8jC7m
 uk45gzPBmhK5fZ38Nw4Oxby+EM6BqvxKqaPFKLGffTurMInneYEe/ECI4g+XpOmm8fdZiHl21Sw
 uzDgtXQBZ9TZy2F1kGwO5C1HY9m2m8Va5pug+ZuTFphxtxk26rbLkkv+EKjqK4Knh9VGBq5por5
 1//sF7pY5DAJZ0tUXWQf3oz3J4Y1nxVUrPMrNqy3ZIoYMj7PsKnC1IKMWnMa4Rm5f55Rn0GeKRy
 YbQATrYg1+kz/7JC8MtvQ4GHkg6AH6V8iSS4Q7yuivexvSUOMSM1BZFae6Rtk7SekS/onr7u
X-Proofpoint-ORIG-GUID: tD5ac-5Hotstu3ezbuHmtS1g75WJBTPu
X-Proofpoint-GUID: tD5ac-5Hotstu3ezbuHmtS1g75WJBTPu
X-Authority-Analysis: v=2.4 cv=Yt4PR5YX c=1 sm=1 tr=0 ts=681c71fd cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=xoEoQZ9qeWIopXNXAPEA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=613 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080080

On 5/7/2025 6:17 PM, Johannes Berg wrote:
> On Tue, 2025-05-06 at 09:22 +0530, Sarika Sharma wrote:
>>
>> Will allocate memory during get_station() call only, in
>> cfg80211 for all possible links(sinfo->links[]).
>>
>> Going to implement that approach and send V7 for review.
> 
> Maybe hold off on that for now, I'd really like to have fewer changes to
> all the drivers.
> 
> I also realize that you guys have stuff waiting for this, so I think to
> make that work better we can also do things in stages and nail down the
> userspace API mostly first, do what's needed to support it, and defer
> bigger cleanups for later.

Sure.

> 
> johannes


