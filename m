Return-Path: <linux-wireless+bounces-3646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1008C856D23
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 19:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01C11F26166
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3171369AC;
	Thu, 15 Feb 2024 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BBtGbNNS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A57131E59
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023114; cv=none; b=f7i0Bbod4krBqmOAPzCePVSsvvw7htDDAOEoIHda/Vhurg77q3pgCZL1pXx0khAKXFKGG7x9HvcipxcwqDA7o9PnGNQXyfHMH3hX+DL7ORSl4gxLFqvoD2AL2tqUqQOnjGDh4m7nnd0ZZ/bkGmvY5c5RL8hClpqI5rLphYtgIPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023114; c=relaxed/simple;
	bh=CR4M0ODCJC2zaapmhMVNwP60I0PHx7yNiGJY6OchCxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VVKAyfmTQqWWrR50RajjL5ubMI9aUEu9KTNGYdDqbbpt+9fG8H/Tso6oLMEZVzdCaEv3O8aCjfd2KTWLY1kFs9YuvbXUlZw+M3bdstHbnb3/ZkL2Lk6n9+JyGHU3czZBfGBynyc36UoDSKvazFbrr5xRWSwbhQv6qBOWrVcE1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BBtGbNNS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FGtA4g002333;
	Thu, 15 Feb 2024 18:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KHEo/5KBkuYLfX5bl86qGG6QPAt0RezSuMYQta623sg=; b=BB
	tGbNNSGJd5RipxOjghO8qJtJIfEE9g6oOD8JlUeQng28XtlLIt+Y1R550gl3FPSd
	ogHg6tw9hgsQyU5VJN4ItBmytimZKPXTDpH4MhwiP5XLo1MiJZnaSbGU6DGPBzec
	kC6VKkh76U5cCov++H886Tkwghyark5KgeBsTuohM/Uztov8tr+jf+k63xIDPdnZ
	BdDsnPRoy+WIKBZuGRjFzb3Uzs8ROpkhPBI51dDx8hr5NK0SPhGD2cLiw+E060PJ
	cXRbMMBBcFtamixI7IogHBRqEBGnaBmpHsK3rBz3paiWsA7B+gYcpqiFv51zSRxz
	HaeD4KxXJx0nLgHUDmCA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9e4h1rpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 18:51:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41FIpFnN019417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 18:51:15 GMT
Received: from [10.110.88.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 15 Feb
 2024 10:51:15 -0800
Message-ID: <89bc5ff1-b049-49d1-b15a-4e01a4659c74@quicinc.com>
Date: Thu, 15 Feb 2024 10:51:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wireless: orphan qfnfmac and plfxlc drivers?
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?Q?Alexis_Lothor=C3=A9?=
	<alexis.lothore@bootlin.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
        Ajay Singh
	<ajay.kathat@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>, <srini.raju@purelifi.com>
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
 <02c155ff-f880-4e88-b600-9d632019729f@bootlin.com>
 <875xypejwt.fsf_-_@kernel.org> <871q9dej8j.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <871q9dej8j.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cettv4BatYPzecfx9B-VWn-INSkqRSNe
X-Proofpoint-ORIG-GUID: Cettv4BatYPzecfx9B-VWn-INSkqRSNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_18,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=944
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150151

On 2/15/2024 9:21 AM, Kalle Valo wrote:
> <imitsyanko@quantenna.com>: host mail.quantenna.com[50.87.249.29] said: 550 No
>     Such User Here (in reply to RCPT TO command)

Apparently Quantenna was acquired by ON Semi in 2019[1], and in 2022
they closed it down[2]. Seems pretty abandoned to me.

[1]
https://www.eetimes.com/on-semi-to-acquire-wi-fi-chip-vendor-quantenna-for-1-billion/
[2]
https://www.bizjournals.com/phoenix/news/2022/09/20/onsemi-close-down-quantenna.html


