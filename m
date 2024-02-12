Return-Path: <linux-wireless+bounces-3482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B77851D53
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 19:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DC7283013
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 18:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507DE45C12;
	Mon, 12 Feb 2024 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UYAJt5vI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54145BE7
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763869; cv=none; b=UTNHSzY9lVZFfh03dy5wxgEmCUPp/GHhH2BvEk8nzzwEobb3zJS/D3zJe7SGPq9J8XY2aHipWJ2ItaCwTFk0QF8wwK8rWYQyiZTa3ZwkC83568flKFJJleNRBdJgE+xD9g6MkxbkEM3YR5vJbcK0r+X1iLLVcaUavkFUBSr2BqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763869; c=relaxed/simple;
	bh=E/OYe9wZyRNZy5r51yUWMDAr89tlHYzmtN0dZi7JcEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qxSr+6RxJPGicO8FjEy0lEmj8KLwxGesPGzLmpYiqTn6SWUpYBx3Uvpr1p+Rt3dwlFogOP1llpqgkY1OFc5Qk1wamHx5oGuu4QOyVJA0GE1e49EUl8umQ2NJN2EikPpuSsO2JV2+Sok5qlrn+s/15w+Z6ucpR2pCw19oG+DMaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UYAJt5vI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CAHpPe030063;
	Mon, 12 Feb 2024 18:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=a5FAmrMc0kqIxRx8gaeSWxhsDsd0KEDgkDv9PNyrtMc=; b=UY
	AJt5vIgW9TmMVNyK2rXhOGDq7zKouMgm3lL9CQh24bK3Kzv/E8L8nSWuYJkreiX+
	iZaBTkLY6TKeKrOss8PSx5MLYGNxGN61sHMEl0dhSD27WthAJmQBiAHyayHGAfiH
	tEyGuRuCRq1u47YQGAOaqmsBL+5OatBWlOfkItk2yvnBtV8d13b4cseNfSZ9k6B+
	lerD7ZYEpQqDJBpmDNHk1PC1+l3v9W9DvS4LXSDfptT2edyXSAxMPjbK0v9YsMM1
	g9+TihGIRmTovd0mF2eA/BgHnUf6KQKovfAGeLZzKtk3NTxgBxMs1v42UoC7O0G5
	ljGH10tgfVwvwnkudIAg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7hew95tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:50:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CIow8e016169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:50:58 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 10:50:57 -0800
Message-ID: <b1ae203d-11ef-4b20-b1cb-29285366edd8@quicinc.com>
Date: Mon, 12 Feb 2024 10:50:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Remove unused scan_flags from struct
 ath12k_wmi_scan_req_arg
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240211145548.1939610-1-nico.escande@gmail.com>
 <20240211145548.1939610-3-nico.escande@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240211145548.1939610-3-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xLhLfDhpxrj2SNYzOm8mQZ0Lv5s2I9wf
X-Proofpoint-ORIG-GUID: xLhLfDhpxrj2SNYzOm8mQZ0Lv5s2I9wf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=373 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120144

On 2/11/2024 6:55 AM, Nicolas Escande wrote:
> As we did for ath11k lets remove the unused scan_flags from struct
> ath12k_wmi_scan_req_arg. This will prevent us from using out of sync values
> between WMI_SCAN_XXX & scan_f_xxx bitfield. 
> While at it remove the underlying wrapping struct/union construct as it serves
> no purpose anymore.
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


