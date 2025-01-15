Return-Path: <linux-wireless+bounces-17551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85858A12374
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 13:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3BC3A15D7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5432475E4;
	Wed, 15 Jan 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ewxLHq3/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D22475CD;
	Wed, 15 Jan 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942693; cv=none; b=StqnCCimHUhd4BUMvhBLbtY47qzw4o3aFQpDZ7w8xqemBELXrml4C+WOERaHKHQslzEcSxzzMWJZSz+nGgJ8cFpRe8RjeFqEp/CbEentlQAyUc/+5SOPlsvk/lBbRF77cVSK/wur1EJDsgi5N00XW26UM9zdQX3tLmB00tYTpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942693; c=relaxed/simple;
	bh=d/LWIZORKoN62n6QyqcEscYhCdc3RQuGVwlyOTd9pHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SGKovOTMzLbWSx8gkGGmzx0EJsV4CiooXRIgBAbsvG1VxPhZqsypNXq23vELGDLqkiBE7zsCMPXJFDozTqz89nSU9yyQFKu9BBz+ypjpQufe48nI0DBjX+3uoiXpkvVDxrx7nxDFB1JlZxgj+s7Tw+aPu3WegFKZ59semPIneKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ewxLHq3/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FAwX7f008660;
	Wed, 15 Jan 2025 12:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5NF90EhPkBYJ6ERmHnU333VvDKfrgGInc+0vaF1q/t0=; b=ewxLHq3/bincRcCW
	X1Sd+kNI6Tvd+QiFoi0M4nWXi1bhrfb/K8S8LoXk6sy/aEoekQihqjFIcvGRQRjT
	vp43YsRzKKQWKlE08/zVSXqf5vVDtv4UZ4vnWiVGkudO+Fimo3D+FQSlFNPbtJ8Q
	pxDbGneogzNLBBBJjxW7xlFjF4e94K7z3AwgAV9jwL/2okzW57stWOmtkl4J5/ub
	OfGBGta8KOgIYvCaNSp5UMpYE5i4df0/xM8XAfAOhbOlHOgX5OybU84aL2uyfYVl
	ScyFH3HMg7ygDjNzde7TwloTVDXS3MAKXEWthO4lyZCH85QHpEjdOVkgK3bEoc83
	fngfaA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 446bqx86gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 12:04:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FC4iWu013729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 12:04:44 GMT
Received: from [10.231.195.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 Jan
 2025 04:04:41 -0800
Message-ID: <d410576f-2fc7-4de1-af51-29fbe8b14948@quicinc.com>
Date: Wed, 15 Jan 2025 20:04:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <quic_cjhuang@quicinc.com>, <vbenes@redhat.com>
References: <4ef22e4e-1ef8-4c16-ae01-06adf23415f8@quicinc.com>
 <20250115115500.136864-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20250115115500.136864-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8fsCAObsBGAHM8FHS4Lt4gqJrIdAmdTN
X-Proofpoint-GUID: 8fsCAObsBGAHM8FHS4Lt4gqJrIdAmdTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=846 impostorscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150091



On 1/15/2025 7:55 PM, Jose Ignacio Tornos Martinez wrote:
> Hello Yuriy,
> 
> It is just a matter of the number of resoruces available.
> But before any further investigation/adjustment from us, I would like to
> confirm that your interface combination is what it is going to be used
> (I haven't seen it in ath/wireless/wireless-next/...).
> Are you going to proceed with that?
> 
> Thanks
> 
> Best regards
> Jose Ignacio
> 
Hi, Jose

If all ath11k-supported platforms pass verification, will use it. As you 
can see, some platforms have already passed verification, and now it 
seems that only your platform is encountering issues, so we want to 
figure out where the problem is occurring.

Thanks,
Yuriy

