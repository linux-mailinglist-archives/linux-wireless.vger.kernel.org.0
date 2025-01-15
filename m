Return-Path: <linux-wireless+bounces-17549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 717CBA12269
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 12:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B3B3A468E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 11:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024CD20CCD1;
	Wed, 15 Jan 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b5K/NmBC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E21E98F7;
	Wed, 15 Jan 2025 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940082; cv=none; b=W+Zp2VLJxeyl2sZg9biOitZrCioGaEba2ld0U21gmoko+2cWthOaiSe+1dqTokvaIsofzk0c4VleXSCN0fbwZw14onfZpe8z4hYQFlGPyWy6wAsRYE+qfBmZ8KMzxjiebVe4JQrWvJPjDI9QP9LILuu7ifKRgIuKJA7SL7PNy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940082; c=relaxed/simple;
	bh=LAVpqBQbrB+xc2TWWIsR2/vhfQVmph1Vo9fFlm9RiHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BJaGmELetvrKSwwPp9rEOYtnSRLbLys0EawNThLTRTzCqNiFOSsWL3El8wm2fVHWKWUmRp5pakZnbuFsQQRF5kmZpD2OOBv6TNLFYUm7UE418PA2v5fIZJWo0rTfMsfifjXAsS/tJ/dYdQw5lRJiKX7j85/ExtZ9hJt19bg2VX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b5K/NmBC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F5mlD1019020;
	Wed, 15 Jan 2025 11:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G6TWdJkF3Y1ubZwXE/wBzC/CRLynck9u4qE88briiAA=; b=b5K/NmBC3cBfiDAS
	f/RbzM4JswcMLqVhQk9XfUhBJdq9fz8QKkoVKpqD7P0fqA/Vy1dDGb/V3dmLYcHg
	/xaw6+h6mmwYBzZs8rW8hr0LJsqfOJ19y4T0YMG2qSvcsYdi6o5BJR27Z1gA9VOy
	hpFxBJy+skMwczI7bZk82wepWHPlV9uEi79UlCXcEKaNIdYiTBhlD7E4e34VC05Z
	tgq888Y4g10fKIcih0VLkLf+yluj7/JyWVBf6xETi/OKErrTWlTzVfimaNQuvBBl
	B0PZkGqtyC8Q/ak/sdn0rXSnW/yqLvjzX8X/OMyMzcKvxkARR0+OSXWM3nH/0swc
	w9ytyQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44676vrtuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 11:21:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FBL3IB009351
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 11:21:03 GMT
Received: from [10.231.195.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 Jan
 2025 03:21:00 -0800
Message-ID: <4ef22e4e-1ef8-4c16-ae01-06adf23415f8@quicinc.com>
Date: Wed, 15 Jan 2025 19:20:58 +0800
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
References: <1090a0e4-6a19-422f-83ad-4566e5c86015@quicinc.com>
 <20250115110621.134716-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20250115110621.134716-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UXBEBmyVQqbZ-IibjGRUwSju5cX6qDES
X-Proofpoint-GUID: UXBEBmyVQqbZ-IibjGRUwSju5cX6qDES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=650 mlxscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150085



On 1/15/2025 7:06 PM, Jose Ignacio Tornos Martinez wrote:
> Hello Yuriy,
> 
> Buff ... again the same that was already in the thread ...
> As I commented, if you want to have a common interface combination, please
> go ahead with yours, and then we can see on our own.
> 
> Thanks
> 
> Best regards
> Jose Ignacio
> 
Yeah, as I commented, the common interface combination can work, and 
https://lore.kernel.org/all/90c806db-9d75-4c25-88f5-252da80b5d40@ionic.de/ 
also help to verify in QCA6390.

And just I saw your email to me ask it, so I just wonder what's issue do 
you meet. We can find some from your logs.

If you want to check it yourself, pls go ahead.


Thanks,
Yuriy

