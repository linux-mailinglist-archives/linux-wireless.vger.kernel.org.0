Return-Path: <linux-wireless+bounces-3427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 325CD850D8D
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 07:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8611FB21300
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 06:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE5B3C2F;
	Mon, 12 Feb 2024 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mgEbFA1c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3CF3C15
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720044; cv=none; b=i0nFWOCd3yPcuhWzJtzQWpWHx8BP21EOzShF/1sBXmNTpkV1/5CFczjNR4eC0HdBnRCd1p1wNsnqDE0Wsud1Til5qCjZUEHfjSZRrPBVCA5RsZpXa1anT798z7GyWVysH88Fim+BsyJoy3XLTyZd5S6xCQzppTmgWK9U6OXtwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720044; c=relaxed/simple;
	bh=CGHSt/bV/jixrl1jO24lPB3CYPoMRq8twHpIMMVC7QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DOOnQgbfWWSHzFQo4HhbillXovgPKnCyvA3ag7bvFzpshw4LRFPorGdTQQFbz8F/n7JPGn2T1R296kK0+5xw5n1mxpXw9hpRnZpQ+LAKik9XovYNMdXFb9zXH5Bj+G0cpEXtyILWVfKkCseCPKsUfvkPesS+8b8O7+Iy1DrPASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mgEbFA1c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C6KGBi007124;
	Mon, 12 Feb 2024 06:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bLZpEPDgrw+SzzGdOiOp+DkKaBEF7+S/rESHaZe7RW4=; b=mg
	EbFA1cGMkwcxDwSbWZ12eCJ8i4tKlDcNxOsVb4/vx6V55/JCBut/YKENBF89RDzU
	Df5v+9Ny7wD0ajDwTVLUgkdmx45fN8+mMEeJZWNwVSCI7WCxWZ7f0L+Q3Mj/zPYG
	ngexoiqshqeQ6j6aQNK3cDb9aRQEAMZIK/g9/jM4OAfWp6f4YZwSu01KHSVcBEzU
	GohD562wmEC8NBQNAlR5rO3vwxjDHFSxOIJflAnNpRBPjsBr/bBdD6tADJj9xcni
	aoD+FYu1CpQhlYPwBYjSBKUC8MLP3IwAolwfr/lECAFijXMwEWr+GLkDw/ijI/Np
	VCE6OmQ2M+Nqh0lRmAFQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62ps2kwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 06:40:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41C6ebja029869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 06:40:37 GMT
Received: from [10.216.20.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 11 Feb
 2024 22:40:36 -0800
Message-ID: <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
Date: Mon, 12 Feb 2024 12:10:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
 <20240130140918.1172387-5-quic_adisi@quicinc.com>
 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qEwC_3fW-ZNHANburtKi4W4oWW829wy4
X-Proofpoint-GUID: qEwC_3fW-ZNHANburtKi4W4oWW829wy4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_05,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=997
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120048

On 2/8/24 19:35, Johannes Berg wrote:
> On Thu, 2024-02-08 at 14:48 +0100, Johannes Berg wrote:
>> On Tue, 2024-01-30 at 19:39 +0530, Aditya Kumar Singh wrote:
>>> Add changes to start a channel switch as well as finalize it on link basis
>>> in order to support CSA with MLO as well.
>>>
>>
>> FYI, this had a number of conflicts with my other work - please check
>> the tree now.
>>
> 
> Also here btw, some hostap test with hwsim would be nice - though again
> don't know how well hostapd supports all this yet.
> 
> johannes

Sure, I will rebase on latest ToT and will add some hwsim test cases (if 
supported well in hostapd) as well.


