Return-Path: <linux-wireless+bounces-6188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E91E08A1C90
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 19:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250971C238CB
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 17:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F773BBCC;
	Thu, 11 Apr 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ByoUD1b1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07A3716F
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852826; cv=none; b=qilnwjYLFUPnRlHAgk9DFwRvhq6x7yuaDaILi/A8bHk52fWCyqrnQFou4FHIkEXiR1JMumRoa1CZtnQUr/tNAZsUG6TCBy7iDaGX4P939PYqDMZz8GdgwKjWqQSOuzORnWWbYsB0gX9ryrBsgKiXbTdyJXXwRvSw/yi1hOF/HLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852826; c=relaxed/simple;
	bh=kJEDQZ8bXQzfyzw5ZlXaBtxZbNO0eD6I3USfiNmN1cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F7WuErpf+tRQVYclSuRq1UaNvkUcAwuuvd1nzvsIYXnGzS9H+VEm5k84ilwsVYsX/mxdz23I6DyjeB7dwZj6scWxehBZQl2OOVLtKMAIcJt4H3sI4U0RJm5cjxmemhjMUnVIohjSJA4r7J3jXTc9HQLILYXrat9M1qQoMAWmlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ByoUD1b1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BE16dA007930;
	Thu, 11 Apr 2024 16:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=s5pL1GBk8amOh5CVYcd18lEHmXeHom2IBEBMJr627XA=; b=By
	oUD1b1i7VF7tfIExReo6Rj/sw7a0IYF5pyJZLdZrdHhiXagQU1+u80HXutwx27G8
	kpDt/Xujl02aVILPyClQfdkdJ3gCUSaWnl/sg+63ZfNA8ehyXDM/7H8Ki3fRGLxT
	BY/lPT3Wp7P425H30aoQifG2sbfpK/iBcwICUlWV6NA+vId1JfExfQqer8iDnV9k
	PQHDQ4TUs8RunmU4CZuqo3kcdleSeyL8URazNRqu9oJECZEqZJI5P/hnv8aOb2G2
	c/UUaeOYw9hHXbRx8krv9WHdW/qqChBP8Gzoa6gag8FkxMsyJyKqa9f0sl1S6dh5
	sLpbIa8xp8zzsmjglNHg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xebqx9r7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 16:26:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BGQpq0013575
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 16:26:51 GMT
Received: from [10.216.26.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 09:26:47 -0700
Message-ID: <5fc2f2d2-7403-79d2-8909-ddda918ff8d5@quicinc.com>
Date: Thu, 11 Apr 2024 21:56:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-US
To: <mbizon@freebox.fr>, Jeff Johnson <quic_jjohnson@quicinc.com>,
        Ben Greear
	<greearb@candelatech.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
 <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
 <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com>
 <31f30c0e318904f3a082c7f213576ceb1f407141.camel@sipsolutions.net>
 <20b56e52-a5e2-70cd-a62a-8c4a3526c2cf@candelatech.com>
 <614bb8a8f1d9174ad7d87cf7636f657cda7b1ef9.camel@sipsolutions.net>
 <aa9e1d54-bb5f-37cc-335f-c9970ab13789@candelatech.com>
 <0cfe990b-182b-4ceb-b5b4-2989fefedb2f@quicinc.com>
 <29f7ecb6d7c208c3614f37616943d5f97bb134d3.camel@freebox.fr>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <29f7ecb6d7c208c3614f37616943d5f97bb134d3.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fj1FBxwiLAHRjR5jz6eWOTQlZQ75x7ti
X-Proofpoint-ORIG-GUID: fj1FBxwiLAHRjR5jz6eWOTQlZQ75x7ti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_09,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=912 malwarescore=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110121



On 4/10/2024 11:38 PM, Maxime Bizon wrote:
> 
> On Wed, 2024-04-10 at 09:43 -0700, Jeff Johnson wrote:
> 
> 
> Hello Jeff,
> 
>> Ben, the patches we have posted so far allow ath12k to either have
>> each phy assigned to a separate wiphy (legacy operation) or have
>> multiple phys assigned to a single wiphy (required for MLO
>> operation). In an upcoming patch we'll introduce a DT-driven
> 
> When the physical wiphy are grouped in a logical single wiphy, can we
> still do "legacy" operations on the individual physical wiphy ?
> 

Please note that there will be only one wiphy when all the radios are
grouped together. However, there can be interfaces working concurrently
on each underlying radio advertised in this composite wiphy through
the proposed interface combination capability extensions.

> For example, starting a 5Ghz AP in ax-only mode, and at the same time
> creating a STA interface on 2.4GHz ?
> 

Yes, such use cases continue to be supported in single wiphy mode.

> If not that's a regression. Changing DT (imply reboot) does not really
> fix the issue.
>   

This is not the case really.

Vasanth

