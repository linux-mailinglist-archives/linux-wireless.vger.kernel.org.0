Return-Path: <linux-wireless+bounces-14750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635939B6C42
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 19:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27778282459
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 18:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AD219F103;
	Wed, 30 Oct 2024 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cuWnyPbV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F91BD9E2
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313591; cv=none; b=RZO8QsuWzuRhtFMg6/bQfjGRJPRVv92LH0u1y/g72XmDBcgLSK5YMdOcnk/8ozGcdhRdSJ6PXXHZuU2AZIhkwPbPgjLQpw1+sGQnWOU1KuCiDbuh3Rm2WFMEFVUSqrmTkEe/QZEOHzGYMwPIcPilyT2iVITUKfzAFHrm/dWAWDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313591; c=relaxed/simple;
	bh=VQ6ghMZyTnZ2wZestltg2id5Qm5/1zbQPd9NLxbp0Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EUqX6pu9tYnHQK48yvAZXDb5aZ77BJ5T7bVD/FLnLtkEzpjsJsI1UkYjUm3Rh+avwqU45eIIO437Dkd4r/VfE5v3/T0JHCnYhS3FsZwiQGsxJsfxN9s/sYBBXj2ItkQYFmdMZdnMRBrM9oIW/rDKxi4S+Or30zvlPs7YpAHc7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cuWnyPbV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UCHauh020808;
	Wed, 30 Oct 2024 18:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M9QhOA+Vw9A8PwlsZGdJ5McLnsxFQcU0sieog6mh1lk=; b=cuWnyPbV8MXWclbR
	6S1OElMyagRoh2AXv25E3AcyGY65nu0CYyg0bgDpvmzi6NU33RXd9hCAEsQSfuo0
	RLYqwh7herBi7ojkEWyT1Qvx5vPx9gvPvOnk5zdzE8DTs8ckEPnMNvB9AQmUFXfd
	oDSvk/Bw613R3SI2ew4Is2hSwSPvD++AySmlZiz3Z2ESdftVwisQMwT/N2sCb1Sc
	Xm8VH3U3PO1LWXAtGw3bWq/pRbHpTUKi6Va1rURRyfM1mMbu6OevD1pOlrq4PvL6
	VSL2V93Z3escoAp2Ttnnekci2zrNc+o/PyM68mSVX0f9SteH7Pr60KZhUmg0l8zi
	0HTmOw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kmp0h28j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 18:39:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UIdTXo016001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 18:39:29 GMT
Received: from [10.48.242.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 30 Oct
 2024 11:39:28 -0700
Message-ID: <b5a6ab4e-67bb-4888-818b-175d7dd3dd96@quicinc.com>
Date: Wed, 30 Oct 2024 11:39:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] wifi: ath12k: Refactor sta state machine
To: Kalle Valo <kvalo@kernel.org>, Aditya Kumar Singh <quic_adisi@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
 <20241023133004.2253830-4-kvalo@kernel.org>
 <a4b92b80-ec57-4db3-acd7-9c6c7644d7c9@quicinc.com>
 <875xpahqc5.fsf@kernel.org>
 <cd19db4a-953d-4230-85b1-695140bb185c@quicinc.com>
 <87frodfnsq.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <87frodfnsq.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1RtdzbMBnYNEZCNCwJyGdAWwB2wmvkW0
X-Proofpoint-ORIG-GUID: 1RtdzbMBnYNEZCNCwJyGdAWwB2wmvkW0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=845
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300147

On 10/30/2024 11:28 AM, Kalle Valo wrote:
> Aditya Kumar Singh <quic_adisi@quicinc.com> writes:
>> May be the comment in the code could be re-written as below?
>>
>> /* Driver must clear the keys during the state change from
>>  * IEEE80211_STA_AUTHORIZED to IEEE80211_STA_ASSOC, since after
>>  * returning from here, mac80211 is going to delete the keys
>>  * in __sta_info_destroy_part2(). This will ensure that the driver does
>>  * not retain stale key references after mac80211 deletes the keys.
>>  */
> 
> Looks good to me, I'll add that if it's ok for Jeff as well.
> 

Definitely ok, thanks for the clarification

