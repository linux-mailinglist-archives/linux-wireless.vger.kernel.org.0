Return-Path: <linux-wireless+bounces-19252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727F3A3EBDD
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 05:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE87119C39F9
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 04:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E66189F43;
	Fri, 21 Feb 2025 04:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h79Plbx/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594FE2594
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 04:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112249; cv=none; b=H7Sjpbyz6SLam83MpoWT4tQ5x6gXKd4Dax3696+8R7Tmh7zNgjW+odtWC6mOrWep/xOeEwPZq7CfxZc0+tHjlvn7FeyrXvCVyfUPTXh8oSPMnnA57c23tmB3nQ61T7grbFGDkyXFbZSX2AcurJXtCGzejro3i7/oO73XLwy6Ew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112249; c=relaxed/simple;
	bh=VrJtTCi8ZbSAC8Z4IrgHNhXNy6o0cFWXQaj8Q6co4is=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AsE/JEKNNUtNcLKd3KW9fJy6uXypYwU4SOywmZSH1sUcTDvVHfk82AqGUYsHjHjPnenZu0yQWdpkXuQmBdP2ZZNIVPLpLJTpka1TYFlIREr1wZmUW0seZnLnRf/Wao0NCqYNw7SHhOJEyWfFxAJjA71eBMP3vVI4zmtKAcIGLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h79Plbx/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KG9hFv014987;
	Fri, 21 Feb 2025 04:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X6H+iJj5fXuUl/GbRNZ5rIj8NChjAtHCM9QUQuRyyE4=; b=h79Plbx/XYf21+Zc
	J7/fc5/svgiPe6fVNX6ew+MJogBog+2GDxH6Oa7nIeY1B4vMz9PH/qpUMyF6zzfO
	Qy2sW3VURIqD5GP+jdcLn15OUO1Fnzn9/FA8eUwnsnf1Q0KyMglxyDERvZ+FPpy7
	I2RMTwmSaabgQAnrFoHINzyxd2f1OS9DbKPVfsR9r6KJOPltTT6eCy6NCIIgZ9LM
	M+d1F5NuyWOJL3WhoUvUtUCImiemoez/jJzZUox+ioEWXXvmAEvnyzLgyMj5S5md
	2dCyoiFbYqZuK/ZZ+zPnRWY9AMhnNpCP2p1eTitSoj43to588E4cbpbtviax+5Xw
	kAf1jw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy18cxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 04:30:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51L4UeRB025380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 04:30:40 GMT
Received: from [10.151.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Feb
 2025 20:30:39 -0800
Message-ID: <92e3bad0-404c-695f-730a-9de2a1758fcc@quicinc.com>
Date: Fri, 21 Feb 2025 10:00:35 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: mac80211: Add counter for all monitor interfaces
To: Alexander Wetzel <Alexander@wetzel-home.de>
CC: <linux-wireless@vger.kernel.org>,
        Johannes Berg
	<johannes@sipsolutions.net>
References: <20250220094139.61459-1-Alexander@wetzel-home.de>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20250220094139.61459-1-Alexander@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N97lHhlcCMYQ8PzYx8VDG1FGnDkqtQGm
X-Proofpoint-ORIG-GUID: N97lHhlcCMYQ8PzYx8VDG1FGnDkqtQGm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=924 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502210030



On 2/20/2025 3:11 PM, Alexander Wetzel wrote:
> Count open monitor interfaces regardless of the monitor interface type.
> The new counter virt_monitors takes over counting interfaces depending
> on the virtual monitor interface while monitors is used for all active
> monitor interfaces.
> 
> This fixes monitor packet mirroring when using MONITOR_FLAG_ACTIVE or
> NO_VIRTUAL_MONITOR interfaces.
> 
> Fixes: 286e69677065 ("wifi: mac80211: Drop cooked monitor support")
> Reported-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Closes: https://lore.kernel.org/r/cc715114-4e3b-619a-49dc-a4878075e1dc@quicinc.com
> Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
> ---
> This should fix the issue from the Reported-by above.
> I can't verify that myself, though. Can you confirm that solves the
> issue?
> 

Yes its working, no problem so far.


Tested-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

