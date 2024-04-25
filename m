Return-Path: <linux-wireless+bounces-6858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8188B279C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301DC28665F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58914BFB1;
	Thu, 25 Apr 2024 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jwwx2+uY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC998528D
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714066329; cv=none; b=lLPaDpP8SkUULXITYXuwTjbuFYx+tUCMJsjlxdGo0ikjgXdi+Bfgca2Z7dWOYVhKXgg2hvE8ty5umIWpFaeOjCeauU+hlEVktguVnfVofilkH2WBBCOsy8e7zG0FxzhqiVB3ftN48AdAqnFe7kwb+Dw55TccDQJCGuCAW84c9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714066329; c=relaxed/simple;
	bh=cXHmFCm23KOaA+fNT1KQ7Jto2ETXIZW2QuIE1TTgZ3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tpc+tZSTg/9N6YQjnALgooSPONOsXycMFVt0mxjl3yjlybeW2FXCLjTP9B2Hdr5QbBed/hwPu/fLf0cn9/7GNkwnTyHHNRwl2YMXWm3nPPWhqlV1ODt3HUtio5cMjF2DmlKEOHE124j+gryp3AWsWhRWH57PH6cDLYsfmunTQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jwwx2+uY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PAxPpL020059;
	Thu, 25 Apr 2024 17:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=A1J9xCEHnJqEEI/CVe9T1ZVmK0X5pRO4R286AMXokBk=; b=jw
	wx2+uYAa8W60IuFgeV9TXNAH2vuxxAdynrGgsKWb80xwS4PtNcYYSEZgp2HgDxwK
	fRMO5LgNJJ3fd5J4ZJp8TYDU2ogxL70wSJltR4Mrz7e6YXWXs9HCYQSraN3Zp1do
	V4uDv1hPRyqe+ey0RrYMTLWkm0jjVcmCndvfRSPvCzI7deNz1bPG5NRE204ykfn/
	aZee0dbVDOUxGyLBcUobPZf7CCBsvF0p/6eMfaWr0SikIa5SOlp6lgqiUY2VaPsU
	YmQAXM9XWMbzg20pDJtWn5pcU1p99ZhRPc8aLdTyOe01KPjVDz/JpXoqOnmpU3lr
	RuVo99LRyLSIaR27vs0w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenh38dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:32:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PHW31r014958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:32:03 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 10:32:03 -0700
Message-ID: <aa21d6de-85f9-4733-9fb2-45fb8eee0a47@quicinc.com>
Date: Thu, 25 Apr 2024 10:32:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/6] wifi: ath12k: add channel 2 into 6 GHz channel
 list
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
 <20240424191141.32549-2-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240424191141.32549-2-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tUqVo_fH0PG_vpdQHQnSArAgxFgxrj8r
X-Proofpoint-GUID: tUqVo_fH0PG_vpdQHQnSArAgxFgxrj8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=882 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250126

On 4/24/2024 12:11 PM, Pradeep Kumar Chitrapu wrote:
> Add support for the 6 GHz channel 2 with center frequency
> 5935 MHz and operating class 136 per IEEE Std 802.11ax-2021,
> Table E-4.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

I gave the following in v2 which you should have propagated to v3 since there
were no changes

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


