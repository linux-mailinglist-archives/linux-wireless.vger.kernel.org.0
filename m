Return-Path: <linux-wireless+bounces-12857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA880978BC3
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2024 01:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A50288F2D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 23:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DD016F858;
	Fri, 13 Sep 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SKM/AnK+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ABC762DF;
	Fri, 13 Sep 2024 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269543; cv=none; b=HS5OSrbUbwctsAMnSegQuLmCEyaqHNRigbZxN7A+ko8b/I1+wMPL/adeUDmBONgS9qhdJ66XYHxDFSXKhrKtXAJi+LQwoyE3A+KbXCmcbgwKf+pJMAh1MmxSf3KsjnH+F6iRIHupMiWbyr7ttwzyJg+7EuAL0TRkU2McevCEyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269543; c=relaxed/simple;
	bh=Mp3LD4Gy9gL1JgCsgPpVmsoOy9gUPHa0UyuZIi4S3aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=INQNWqBizoSrtD7D41jNpYg27W6TQkdi8hPXfwObvNb2LnOLGx2VWMY7BpwK5NkMNA5VoCB++YhyI34KKbJ+ZKU1zMIaRj43as/q/4oe5vTc9VMMx0vB6+Ose68OLsGk4XKMl4daqFvdidIPnLvvKZvmZZEC88ayJcsZNekDT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SKM/AnK+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DATZc7019767;
	Fri, 13 Sep 2024 23:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3QFWJvsh0p+nExgBe0zxKaCw3UaPyS98VTmcoydLqy8=; b=SKM/AnK+TwJnT2Wm
	8edUiSgS/TP78pcedqRSQfvbR7x/L726l/BHGsavpFI4x8ptSrGDi0CX2vhfrida
	sdq+46T5TljK7EV7Zc3v9Zf9436Yht3yLHUlH/9lZIzkH3nnP8+Rz2dN3nFpUm8j
	eRXk9HtyjRUyfaANiNT1yw0/7u2smoyerJOiuVrhxzY2rsWaDsz3EyZ9M3yR10r/
	d4qcExjhOG2vxgAGJbg7oW0PZx7GQDrNktGU8kPTAncEV1z1g+xGYo0v9heqfmZM
	hbUdkB9ZzS8uM+lgCEkJe/3ZlIhuxL7cSVoxHftLvXlvL4c68qdKELqLSWguRAQJ
	SJ5hUg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy5p2acc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 23:18:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48DNIsfU025992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 23:18:54 GMT
Received: from [10.111.181.97] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Sep
 2024 16:18:53 -0700
Message-ID: <add42b03-3703-49db-857c-711c9ac1eec6@quicinc.com>
Date: Fri, 13 Sep 2024 16:18:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: fix typos
To: Andrew Kreimer <algonell@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20240913094818.14456-1-algonell@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240913094818.14456-1-algonell@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gv2OZ70UpYsWzbKVYqRJAjts975kraa4
X-Proofpoint-ORIG-GUID: Gv2OZ70UpYsWzbKVYqRJAjts975kraa4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=567 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130165

On 9/13/2024 2:48 AM, Andrew Kreimer wrote:
> Fix typos in comments.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


