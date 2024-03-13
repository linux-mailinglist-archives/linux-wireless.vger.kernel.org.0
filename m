Return-Path: <linux-wireless+bounces-4680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D987AA05
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 16:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C0AB22A73
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08D446A2;
	Wed, 13 Mar 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bf4/ENen"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF28446D5
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342374; cv=none; b=ffP/8buLYihlzAPfJU7+zWJBNYxF+p/XqMfeAsiYcoZSQwabyLC8tzhEd9Zs4aZYpxJc8bBggE3d7EIMzHARcX4EfQKMFQB5bErVw5X6ydjNoQzDgUEO60sfgO6n6RsCSDAvBOcADcW/PFO1nO1cwp0hvRrMjL3MH9Gr8KRm49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342374; c=relaxed/simple;
	bh=uMZAZLui5LZm03/4mLkDoB1VmsoENROCh8/Tg5btZbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fRmkWYxCsAhCxC9VDy/9Y9K5LftyC5+mqW0tV9mVGFGHO2dwdrLSKmRewj1JpCmSKRExGFXFEAWbHprfmMopxpDzxcDwUnksD69UQLgwI8ybaKbPCjIN1qeb8+EKZxGEAKpNkKJel8h19gVILh0C/a3f9AYvsqrj1mte22vvZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bf4/ENen; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DCSTVO032409;
	Wed, 13 Mar 2024 15:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UA04qnuG9mPDr6gf73looLo9QneIYVq4T7oMMn5DEeU=; b=Bf
	4/ENenDhaSrhrs/1LOPX7XJgrfR6ZVCJlnpU7T9MPDEXvKEP+RyEa8P1gXKNhSOb
	rujOOiqI2nAHk7pDVRJxCgShGD+6lQd8qOHa1m88i2jvCCP6aTFeZC2SlUOx/IKe
	dWyPRiuxcMe1rkjo54Bnk9vr+rb0WU5wXnRNUVMGrwBCAZMdR1oVQGs55xI6BAog
	6nSBEdqigkDOWpg5uw39RhJ5fQnFTwYuX7p3Y5+2CksE8DLfsdT8Vqfs6TVxrSmF
	R2nHyGWOSn+r95mF/239O4seJAyUnVtXhRt15UDRvlgla8OMq1ejIvRpd6Uc9gL7
	AmYt284wqZJWZyo7Gzdg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuapeghas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 15:06:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DF63Ys022535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 15:06:03 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 08:06:03 -0700
Message-ID: <605a673e-3686-47d0-b71b-1e314fde65db@quicinc.com>
Date: Wed, 13 Mar 2024 08:06:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] wifi: ath12k: add multiple radio support in a
 single MAC HW un/register
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-2-quic_ramess@quicinc.com>
 <4a527729-2bf8-47ce-8275-d36b76bde95c@quicinc.com>
 <3178cf8c-d328-4fe2-b3be-f5c4c908f20f@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <3178cf8c-d328-4fe2-b3be-f5c4c908f20f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DrfVzUE-fZ63G8kTimOrk-dYyobf-BHh
X-Proofpoint-GUID: DrfVzUE-fZ63G8kTimOrk-dYyobf-BHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=895 spamscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130113

On 3/13/2024 5:57 AM, Rameshkumar Sundaram wrote:
> On 3/13/2024 3:23 AM, Jeff Johnson wrote:
>> and guess we have to figure out how to suppress the ath12k-check issues with
>> this macro
> ath12k-check complains about the reuse of ah and index arguments which 
> may get evaluated multiple times if its an arithmetic expression, But 
> areas where we use the macro in our code aren't doing so.
> Do you have any suggestions here ? or shall we go back and use this 
> for-loop inline.

The macro makes sense -- we'll need to update the overrides in ath12k-check.

/jeff



