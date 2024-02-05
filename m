Return-Path: <linux-wireless+bounces-3180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAED84A824
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E391A28A1E0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB901386C8;
	Mon,  5 Feb 2024 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LstfVTsF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA601386BC;
	Mon,  5 Feb 2024 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166266; cv=none; b=mkIiUkDcrHKHExDbF0pbAnOkoVfZw2VasB5i9xV6PTGhFNCvb0C+feYGHXaE05lwkt6uLX0rGa0iMCxToShyDuey6ATzDfVsVY885E3kgrpkygNu3zPG+aodVINf5xlKqrkcPZH33NoZl2RsCxWNJZk5qRz2PqXIcA1Lasm2CXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166266; c=relaxed/simple;
	bh=vQirxtGuigMN/0Rn0eLAvFQzJ+WGBoW9ePK4iBJJ/OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qPVE0gzfW8ZmNR6++4UR4gNxqH/nf+86YprQg8fewPlr+kkKCqhclZ+Xk2u45w2tJA9k0kT0r0/MxAYbg+DFgvmtaXImpu3tgTW+WAwkUWkprtHqh/QYBv3TdHXu2JVawqdAUW0hdEXUS5Efs5P1EugLhotLX2uBhRZvp3sGn3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LstfVTsF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415Kgjrg013057;
	Mon, 5 Feb 2024 20:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+GazEYcOfj78Iv0+lnmZ8xLRg78Ggjpx3nxYAAFeqvU=; b=Ls
	tfVTsFCedBpR3yoAmG6F45iw8P02Rf3jbtEpYPKArRpYFnMDkqi+RKrAe6RFhdOF
	13G32h4rzsNdOOhL0KveFLGJzpTI+NO5HixU3gaOxUfjR689uCXVSFRn2BawTwfc
	CImh0kGSRnvGxr7fciTCLP2y2Gmadc1VGqjJwpGe+HE5P1r/Smh0Js/etSMrKVpM
	e1dQKhl4vMLil/c/TtFndT3Lid4h1u74SCDRHRt99Eq8+lOhBUzlyQ8ASjdO9t6R
	vVn9M0Yf0F637S/wMG4tXrhDjzYQf6GeUN7MhOsVZ0lyhNQRZ5QaO3mxJEYqWsRg
	C6XeAWiQMkHslaYyPVvw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2v729pba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 20:50:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415KooVE008944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 20:50:50 GMT
Received: from [10.110.62.200] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:50:49 -0800
Message-ID: <b3c7578e-d8d1-4f3f-9cd7-eb3fda57aae4@quicinc.com>
Date: Mon, 5 Feb 2024 12:50:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix uninitialized use of ret in
 ath12k_mac_allocate()
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>, <kvalo@kernel.org>
CC: <morbo@google.com>, <justinstitt@google.com>, <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <llvm@lists.linux.dev>, <patches@lists.linux.dev>
References: <20240205-ath12k-mac-wuninitialized-v1-1-3fda7b17357f@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240205-ath12k-mac-wuninitialized-v1-1-3fda7b17357f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1eWMtrjngK4Z-rmsMQgfwWnFjBCRDPj3
X-Proofpoint-ORIG-GUID: 1eWMtrjngK4Z-rmsMQgfwWnFjBCRDPj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1011 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 mlxlogscore=727
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050155

On 2/5/2024 11:49 AM, Nathan Chancellor wrote:
> Clang warns (or errors with CONFIG_WERROR=y):
> 
>   drivers/net/wireless/ath/ath12k/mac.c:8060:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>    8060 |         return ret;
>         |                ^~~
>   drivers/net/wireless/ath/ath12k/mac.c:8022:9: note: initialize the variable 'ret' to silence this warning
>    8022 |         int ret, i, j;
>         |                ^
>         |                 = 0
>   1 error generated.
> 
> Commit 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211
> hw") added a completely uninitialized use of ret. Prior to that change,
> -ENOMEM was returned to the callers of ath12k_mac_allocate() whenever
> ath12k_mac_hw_allocate() failed. Assign that value to ret to make sure
> it is always initialized when used and clear up the warning.
> 
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1989i
> Fixes: 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211 hw")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


