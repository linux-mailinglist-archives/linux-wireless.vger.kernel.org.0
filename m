Return-Path: <linux-wireless+bounces-10752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0EC9433DE
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 18:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81D81C20B0B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E001B29A7;
	Wed, 31 Jul 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H0r+o8/J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860021BBBC7
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442121; cv=none; b=Rt1XLy9FwvRqWWe9eShRNqY3GXmg1onQNbDE1RFRY3LRttxSpX0KlbsMsFLVu+OCMs24jTvYoxA6EAviGzDPMffkVstb3wsoBJyFG2hSBVIPyH7nMPnVuvZkYNBRF1TeX7KrAk/OEo7Kg6mZYLHzbZThVdk6LCZAT6+aIhl6Q6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442121; c=relaxed/simple;
	bh=Cb85amoL2UOWG6BrcgoaaygbWdLQrxavrW19axsnt+U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=SfjpPsX0N4z/DELQqRrMxJd3s2RyyQEeXtxT5rN7M77Pj2LxsrC6u0ETW1NAS+NqrRPzVOF0v0X/4dbQ1Vu8FtCuoFH2re7lYTTr99Pd1GJXlu2k2O+rEed6yslZtJGUlDPgc51vT5uBQNmW43fS6861RPH7vR+rXN1CwRgFN64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H0r+o8/J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VBSJZI027544;
	Wed, 31 Jul 2024 16:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	00tjIpiyLnqWxSkYft+WkprGEKeL90GzEW/ymr6DXy4=; b=H0r+o8/JeL2mlj+A
	5JnqlpYMcqMeyft0OMoFwieKKWnv2RMJM0717xV2HeAaVpRLGdcm1+Kluaoyr/O7
	JjtmHEN1oPkiMz1HmMY4Qjf2kYq6UgMq0b2ePe3aynldj+0RVBtoGLiYBpd2Vlws
	FrFQlauRQcv/3Cok2ar/7exDXXUNEYQ0U86pBVd5ULmYwoJB14b/QwJz3VUexogm
	mYPetj2F7OOGxaXFmcrqbrtSeYBR1IOlG13JfjzY2Js56ZnNpV0UrqsF177b0da8
	lsbWAT6xLV48rH4DLhaksEPYJ/Bz/vnUZ7769U4UbpBoHghn76WMte6My4dljIeS
	gKyJfg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40q232v12w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 16:08:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46VG8ZNZ005495
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 16:08:35 GMT
Received: from [10.111.177.34] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 09:08:34 -0700
Message-ID: <456b2407-81e7-43d5-ab31-61ca87e284cb@quicinc.com>
Date: Wed, 31 Jul 2024 09:08:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Refactor
 ath12k_qmi_alloc_target_mem_chunk function
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240730170910.3281816-1-quic_rajkbhag@quicinc.com>
 <20240730170910.3281816-2-quic_rajkbhag@quicinc.com>
 <4ed6f40e-f27a-4868-8670-c81d95a14a3d@quicinc.com>
In-Reply-To: <4ed6f40e-f27a-4868-8670-c81d95a14a3d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GEP5-b-7mhvyDvCeunb5njynno0tDLRd
X-Proofpoint-ORIG-GUID: GEP5-b-7mhvyDvCeunb5njynno0tDLRd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=708 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407310112

On 7/31/2024 8:45 AM, Jeff Johnson wrote:
> On 7/30/2024 10:09 AM, Raj Kumar Bhagat wrote:
>> +			ret = ath12k_qmi_alloc_chunk(ab, chunk);
> 
> seems like you need to test ret and return if non-zero here since currently if
> you get a bad ret in one loop but you continue and get a good ret on the
> remaining iterations then you'll end up returning success from this function.
> 
> In other words, your refactoring doesn't correct handle that the original
> "return -ENOMEM" would return from *this* function at this point

I see you handle this in patch 2, but that portion of patch 2 should be moved
to this patch


