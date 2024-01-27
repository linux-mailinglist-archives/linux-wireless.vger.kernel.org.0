Return-Path: <linux-wireless+bounces-2594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE983EB23
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 06:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C41B1C215D9
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 05:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB512E41;
	Sat, 27 Jan 2024 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CH8LUhmz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB858BED
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706331681; cv=none; b=ZKh/IBj/PwYduh48heMahRipoyymOTaCSjY1ac4MmVEuxYRJRxK57ULLPUDx3/P+drw8O2J59McBunJDEJqWOInZsphizrDZcabAWIBc+3hVUwQjtssTDUAAQux/8UOABd6wh+8UuaY1VK46tsYNENYEJv5mDFXLM890kCxlUv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706331681; c=relaxed/simple;
	bh=7MdehxmRpL1IAoMQKQVhNrPzwvsjBj+p72YhGEJTtaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RLESWkQr20iUvKouswxoUvMrWnhOM8+yWS0ES0sHox737Kjb0e4Ddyjgil1fDhnpoNU03EEQR4Qz4B7cweARNlSelWgcph09gq8lhYO4cJsefpWoTb1MdzBIrTxCjqgNtQMgplMx6v5hvPcVYp8TnQgTEo4/SfauXEWb9bs5Fyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CH8LUhmz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40R4oOGM008475;
	Sat, 27 Jan 2024 05:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QYjMnHx6/j05OYVYeOVhjSfnS0a2RtYcSqaqn+Nx8S0=; b=CH
	8LUhmzViC906l0I88iXoOCCc9jnvJaMrChzosNvsrWeIbSF6kyNmLlSQViwlIjL5
	3bbgMqy1A2yPpCZT0lSnqAv14gO3OXk0rL9BvH9GpbJ9G2IjrQd2pTshra3HyQw2
	eAD0/9+nbMtdQ5nxIrPhsIzSZxyxj0YthYX9VuH7g1iXtR6WxditYCJ/s3p6pmuP
	ibEli0qwfiMntEvtbtdvKHFGtUcTQ1Le3CSAamWWmXGWRYRBmJ5oOp6HTJlUz0Xd
	x/GF2VuqBv1G60ga24RnBsK5nDh7HtUNX6EMCer+9eEcpdIgpgNmf45iiuZYon0s
	vqLhyVyDb9ylDKYFEBaw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvse4r3yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 05:01:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R519kD003263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 05:01:09 GMT
Received: from [10.216.58.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 21:01:08 -0800
Message-ID: <ca28cb35-ebe9-4f20-8a71-a9fcef1decbc@quicinc.com>
Date: Sat, 27 Jan 2024 10:31:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] wifi: mac80211: update beacon counters per link
 basis
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240125130410.827701-1-quic_adisi@quicinc.com>
 <20240125130410.827701-4-quic_adisi@quicinc.com>
 <dca9bc4a793f338d4681f3a2a1f2e326f0b5d9ec.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <dca9bc4a793f338d4681f3a2a1f2e326f0b5d9ec.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lZKn_3CmL6vQgkLcMqI6uqqxr05VNIeJ
X-Proofpoint-GUID: lZKn_3CmL6vQgkLcMqI6uqqxr05VNIeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=424
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270034

On 1/26/24 15:01, Johannes Berg wrote:
> On Thu, 2024-01-25 at 18:34 +0530, Aditya Kumar Singh wrote:
>> Currently, function to update beacon counter uses deflink to fetch
>> the beacon and then update the counter. However, with MLO, there is
>> a need to update the counter for the beacon in a particular link.
>>
>> Add support to use link_id in order to fetch the beacon from a particular
>> link data during beacon update counter.
>>
> 
> Seems it would make sense to put this patch _before_ patch 2, since
> otherwise in patch 2 it would appear to be kind of working but then not
> really work?
> 

You are right! I will move this to before [2] then followed by 
csa_finish() changes and then last patch would be to start csa process 
on given link. Looks fine?


