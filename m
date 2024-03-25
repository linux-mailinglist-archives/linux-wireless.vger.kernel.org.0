Return-Path: <linux-wireless+bounces-5232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 906B988AE63
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 19:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A0E2A789C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2A3C125;
	Mon, 25 Mar 2024 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gPfgHXcr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FBB6FDC
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390446; cv=none; b=QI335MgyPDBL5+jjnaKk7NBzRY5EtgOA3/A5CwHuCx66Rr7/0JxP4ZzFoc5Bs2kSukm8bpPucRCaOPTIS2mHLiR4K2vaq1ZGpT3pBfI+aPMYRRDbqyn0yp4LyToZygq8CYBbxXi8BarKHPnhjFHrOZo6Lj57x6lbWO3UTvH6YJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390446; c=relaxed/simple;
	bh=W79W+mBghUKc1vEyjo8vqaGxDXCBbO5UbtS6vBEurc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ELgbcH92K+ranm9LD+UZjl8uz0pG3UjrofNXotP0LswK3p38QqJTAgguHauMW9blWTGS/0uOQaDQFmpmh6Q3MAVXV5WJ29LZOaOMzEzbZFXUr/+OejlLh1dYadri+H9NGGz38A1xXXRTdOV+PKb+7nFPLGhqN3UnxMtwUP0m1D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gPfgHXcr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PHgthm009317;
	Mon, 25 Mar 2024 18:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=G8FBi13BTKDzUtHlF8NPs7QlaZ4YzLKzWJpEwsPFkPw=; b=gP
	fgHXcrRT4zNzEvx6SJYxIBnATcg9BrQag+mkvXL2C5YuNsk8OJKVzjCI+3tZfPVy
	0XrpUdIECibmP2sKyFCvqRHp7FMDe4FlBZC1LNkoLL8+QtbxV5S57a3Hv8l+r2rA
	F1OlB24CYBHRGXaa4TGQo5qGjswGxnUWIs1aoBgrbOtx1jSD5+0/0qNXii8X06De
	VBhXBmd1/8w91rM7qa1DnWsHPlFddHNQkwGMvEsBV826QuYQlggF3uVj4mctl9WA
	OppW8lun2nY7efA2iXjRf9YuZ9uwy5YyPNp4wdZQqt8vMbon7JFtP/lHQ3MVgAk9
	jKiFhOUCpFrvSNzEgoyw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x319j9u13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 18:13:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PIDwGQ019262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 18:13:58 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 11:13:58 -0700
Message-ID: <bb630d5f-b1f4-4b21-93c4-ed80475582d0@quicinc.com>
Date: Mon, 25 Mar 2024 11:13:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] wifi: ath12k: Cache vdev configs before vdev
 create
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
 <20240320190943.3850106-8-quic_ramess@quicinc.com>
 <29d302e7-dbc5-4d39-b890-067a24a84782@quicinc.com>
 <a08b4b7a-7afc-4b1a-92f0-3eca65017175@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <a08b4b7a-7afc-4b1a-92f0-3eca65017175@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S6z-rHS-qQ76zshwczyzecZWiDK1IoVh
X-Proofpoint-GUID: S6z-rHS-qQ76zshwczyzecZWiDK1IoVh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_15,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxlogscore=925 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403250105

On 3/25/2024 10:49 AM, Rameshkumar Sundaram wrote:
> On 3/22/2024 2:34 AM, Jeff Johnson wrote:
>> On 3/20/2024 12:09 PM, Rameshkumar Sundaram wrote:
>>> +	struct ath12k_vif_cache cache;
>>
>> in my v4 comment I had suggested that this cache be a pointer.
>> instead you chose to add pointers to the subordinate records within the cache.
>> why take that approach?
>>
> Thought of making the actual cache objects as pointers, instead of 
> allocating memory for all type(key,tx) of caches during vdev create itself.
> So that well allocate required cache alone if needed. Thoughts ?

There is a tradeoff here.

This cache is temporary, but the allocation exists for the lifetime of the
struct. So by having a single pointer here you only waste one pointer, but at
the expense that for each object type you have to see if the cache is already
present, and if not, then allocate the cache.

I'm OK either way, but just wanted to point out that the current approach
wastes more memory when the cache isn't needed.

/jeff

