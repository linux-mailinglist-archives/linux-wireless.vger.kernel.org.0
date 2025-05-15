Return-Path: <linux-wireless+bounces-23027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B1AB8DF8
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 19:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBC14E6C2C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242F8207DE2;
	Thu, 15 May 2025 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GCF4Ryhe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F5146593
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330782; cv=none; b=aHPkm8egYot3ToaIvszLcJcESWHqqvKXFb3x4chbzu+QoRBplcdcczaDa08yxOR9axu5k0dtRDsrcZP0MWDpW9ZsFUlNe0dmLFvmTaC+8nFvvQieqfmBpyaJk1khh3Bfo7ov80HlLNw6YloXgRpt0cUKyNQebPoOB+2KFfCBolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330782; c=relaxed/simple;
	bh=CAfqa9rgedhYeT8oZNGArVm8hGu3nlNwIcXqYap55DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NFE+4b8E2oN9AMcpVlJEaeItM1GBwX3SpcHpCt/RZwf+U03n2sKpAf1SNJRZYqLaD2py/mw6/MUMLgUEBLGgry0BJGcTwx2fzMo4E971ZYnqRzXqcULxnbIPOeYLwrZVG1KCVOj6+lR1L3qJLTb+Mevdqm5fAkTs0DW2QR38mTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GCF4Ryhe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFZRZ031752;
	Thu, 15 May 2025 17:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yc26JWff4JZQARlz517EPYtzOgT2AE+PHqF7m1wO+gI=; b=GCF4RyhebxloC/H/
	2fj5Z0MxNZ8MoWJORDv2JuzczZD3yf2WDtc5uF9XyGVsi7ojD0ZFFdikTCgkuRsG
	bh4eH9MTEnrWborAA4f5hpGTYMzt1NlQjbJFvKF/nL5ev2GCjMcItQ9mI9jVlSPl
	ui2UvlXsGVgfPlnAjSNL5ECY8w0atrpIxt9TZMTxzDEyUUKJT98jOtV4b99hN3iT
	v6965goLbUzh+0ZI2fNxpAhzT0uko2glcyn3y/V5+qa+kIeqYQq4hWKKwEGRlMWM
	S/lfxDATRkbUo+4wYHteHltPKpELpQSz1+oEXVGhiH8bGnkI9LPql278dpNYwHb8
	MBV3jA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcr6xuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:39:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FHdZ6B023943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:39:35 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 10:39:34 -0700
Message-ID: <7d99344d-e6d6-4620-8679-d1087d193d75@quicinc.com>
Date: Thu, 15 May 2025 23:09:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 08/10] wifi: mac80211: extend support to
 fill link level sinfo structure
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-9-quic_sarishar@quicinc.com>
 <22c4f501ab25f4ebeed119db6948d73442b98948.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <22c4f501ab25f4ebeed119db6948d73442b98948.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lFCbJ6dlGRxvRCqZxNfvvoSdvAR3_H_X
X-Authority-Analysis: v=2.4 cv=Auju3P9P c=1 sm=1 tr=0 ts=682626d8 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=QKkOagDKjNMJwjAW230A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lFCbJ6dlGRxvRCqZxNfvvoSdvAR3_H_X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3MyBTYWx0ZWRfX1F9Se2YYd+vc
 NYwD7Bkx9fNaczaQQDQ9dafUvPTZuu0SY5XPFn9pVGSANxrP9XooyatNGv1KyJApq/9slwwZBlU
 qG/ikkl8cuElrj5sYGcRYmsaWpKeVh3cFJBD6yBBbdHHgIeC3cuLhUfQSkm10KRapa9oszbbQvD
 b7k1c3evHWqaDILCD7mqjYfGxo9Ovudv5i2uGvWJzkUiyx1K/rlbnxhIRS6CFgL34IKlx5R+Ly9
 ZaxoyT94u6hfp3LmYZtXohxgj/gpei4Ff6xMkGCp9JbfUlqjOn4o24HRQPK1OfFsL0IhX9sNVLq
 rdO1PQDME4akB3fhv2nqkP4sdd8oOsIHDZNmLp2wHjYppjBg+vqMr7R8VTCCO3Thk1xGFqSpYxV
 xH+Na4KKpbbTDv6dIWkI1yNBb3myn1vEtye/1l6g2fHe2eNY7OZdGKK1s1V2qytbSG098GAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=774
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150173

On 5/15/2025 5:11 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>>
>> +	if (sinfo->valid_links) {
>> +		struct ieee80211_link_data *link_sdata;
>>
> 
> That's always just called "link" elsewhere, maybe stick to that
> convention? There's no mention of link_sdata elsewhere anyway.
> 
> johannes

Sure.

