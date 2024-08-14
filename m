Return-Path: <linux-wireless+bounces-11443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8759521F0
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 20:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484DF281F7D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CDA1B32A6;
	Wed, 14 Aug 2024 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CWuIs2vW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404211B0111
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723659690; cv=none; b=aJq+3vhXNKJROZrLxvlw1S9BH1aPBrqrFf79emfzpDKSzO/91Ds1vMoJtaFE+UIz5+EUTUSErYr4ctPz/pf+Srd9FQElitRLpYu7J3pfvLddTSR9aU6oQkhevAvdvYMF158XRIRR1DkX3E7Exat4BhHcGnMkKZCYHbcr2KNJTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723659690; c=relaxed/simple;
	bh=NTAHO3TPr1Uw5ITx11FLA0SxbVo5PTZnKVHeT5GsT2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SeW/4OSzdGTk2n4cNBHIWRnn/GPT5YazkvfcLGHTBXoFEoml4Z/rREWQz6jIf1nql4QjkcowY7IfLMpgKs1L7/fmKSxWlWXlNNu7+eRKtX/xP4qIi6rSsXZfngjP8wwpoeivtD+34l3Zg1bbb61PGflM+7LtLHj2uK8G0IzxWbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CWuIs2vW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBric0017044;
	Wed, 14 Aug 2024 18:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wMzv/7m+RdN5ew/Dxb8uzfg7Fad0Zsp1tO81SSp8axU=; b=CWuIs2vWHaoxRth/
	x998HT/76DBx0e4QqyFYA8CS6OBOAX3nytolmXGWo/pXqREdSoXGpO1zr3lvGVnw
	xo8hxj0wTLPMY/YFjiUwEjCm8kd7ErhbQXoNLnJCt24XVbxlCeSRcjMleR1Z4uJz
	gCTh+wxm1sHXLuLYewSJ0eYgLizYknrujmPB13SHyRUdPZ1wFHPw/x0CbYcsAhCV
	4/LojWxkQmut5A5mkutkvoEIqtmL0ltxDikilYVhqEeAoCbJPn0NWZwj0jao7uiC
	95usJQ/WvB5RI1YfCH8iDJIJc8AGbygTOtErNl6IHkCdCqCp63hBSQi+2TCvdBW/
	ejnZLQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410kywjd1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:21:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47EILIpe019619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:21:19 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 Aug
 2024 11:21:18 -0700
Message-ID: <0efa8cc7-43b9-4081-85ea-007e8e83f960@quicinc.com>
Date: Wed, 14 Aug 2024 11:21:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath12k: Refactor radio freq low and high
 information
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240814103423.3980958-1-quic_periyasa@quicinc.com>
 <20240814103423.3980958-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240814103423.3980958-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aATvlnsjK110Lil4XitBJQZJ2er0-ov6
X-Proofpoint-GUID: aATvlnsjK110Lil4XitBJQZJ2er0-ov6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_14,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140125

On 8/14/2024 3:34 AM, Karthikeyan Periyasamy wrote:
> Currently, radio stores the low frequency and high frequency information
> as a separate variables. However, cfg80211 already provides a suitable

nit: s/as a/as/

> data structure struct wiphy_radio_freq_range, to store this information
> efficiently. Additionally, for multi radio per wiphy infrastructure, this
> frequency range information is essential. Therefore, to enhance
> adaptibility and leverage existing structures, modify the storage of

nit: s/adaptibility /adaptability /

> frequency low and high information to the struct wiphy_radio_freq_range
> data structure.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00183-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

(Kalle can make the nit changes in the pending branch)
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


