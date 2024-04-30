Return-Path: <linux-wireless+bounces-7068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5F8B7FF4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 20:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8D11F235F5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57A190663;
	Tue, 30 Apr 2024 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cUqgPvR4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA418412A
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502563; cv=none; b=Zej/eJjmPALUM7bl42ypzQ1LkvTLmz1ZK2RPkYVAZglOUcNKfFrAfgHUp9lfVGWO2XrL0yEKC7ivCbGylfKAJ1OO+JnxewUA6Y2BWTR2sSto0OS3+rSlm8c89Zq5Udi5sh2LDj3lAfohrThybwU7GAePh2ZKlt4G3z41LG78PPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502563; c=relaxed/simple;
	bh=m3e+DNiScoQANSCSL7fSH+oqD9xBV/nnp2mLL1wUNSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bdN3wfo1dC6lGOEfrxxAq0R1oaa8VkM7ySjaleoK+K/eK5ssqLnv3v99tNefE2bEJ//Z/eY9ay9jAZZNF6Ujb02FIavv6nSgGZvtiR9Ytyn8wSJPuQjO8WuWDhP9Mt7MFMgHs4XrzsL71ey66Z30GQTnKhBpF/xROJB5fXyH0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cUqgPvR4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UDoJl3008265;
	Tue, 30 Apr 2024 18:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kRZ14mxC8d07XCdoMoa5RtYRF7xwfFXScdD4Cm7odQo=; b=cU
	qgPvR4uHnvwbK/2KERyVs2NGIhTcluhhPC2nmNoBL3H3EmV9E76WBq3qR3EMHVvd
	z4zt64CC3N7HKhP5D/CFb6t1tutUl0W86rX0u9vIXm9WxM5o4DCz00LPzRWfbJTW
	A9ErNBXUPI6GP4ZapUR6R5NcsWj0pfBxY/awtFx+6NztoEwcowgTuYICT+hQTO14
	KGkcg7FYz+CmH5qkaFiUZxpoVUWYWdfTXCTb0uhAjqMabMbMIEBoj91pCaOrLuM4
	bwvBm9FaPG1cv0oD4fQNW5TBnBrxo3SC6pTqL+iClzNehkVHomqVTaA3uKGxZjPe
	ZoMlcKe4Us8LU8K9Sr1g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtw1hhp0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 18:42:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UIgZZx020232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 18:42:35 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 11:42:35 -0700
Message-ID: <26854263-0a16-4b27-9de3-be3d159b8e40@quicinc.com>
Date: Tue, 30 Apr 2024 11:42:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] wifi: ath12k: Replace "chip" with "device" in hal
 Rx return buffer manager
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
 <20240430165811.1377182-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240430165811.1377182-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 13J2nSjpYB9xutHNVAcwu8kPuNLkGePO
X-Proofpoint-ORIG-GUID: 13J2nSjpYB9xutHNVAcwu8kPuNLkGePO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_11,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=745 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300134

On 4/30/2024 9:58 AM, Karthikeyan Periyasamy wrote:
> Prefer the term "device" over "chip". Therefore, modify the relavant terms

Kalle, can you fix in pending (if there isn't a respin):

s/relavant /relevant /

> in hal Rx return buffer manager to use "device" instead.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


