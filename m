Return-Path: <linux-wireless+bounces-7492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCCF8C2AD1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 21:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD031F239B3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 19:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2BB3E48C;
	Fri, 10 May 2024 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZEn2T/oH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554910965
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370827; cv=none; b=W8TgCybRoF200HjNbd4zBEDhZuiHeOqX8qEuTKCFQy+X+j4oCmH7X33RPqID1jYpfkCVoYZTmkw9vbDTirPfkKfaIz2Q2Y1bR1xe2BcvpGQ149DH+3jSve8ijLpEvClv/2f3FD5MrivAmTbhP9ri79eC/w84AeJOHUKpk/FNWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370827; c=relaxed/simple;
	bh=GFLuuHmutEr/cShgFTvu4Xnp13xUY5PCi1Waz+by32o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EfF+QlDPFKne73ww9sIJ95pgVOlx8NVR5mDL9vxiRMMV1qJpsg03wBWY0UxZP/XLbj49m4J22WpE79dN7ucwrmg48P7ohv8c4rpdHLC/xY2cX1+/FPGTNrciQm6Zqa6O3tkMKODnO2lmgMBz40rkbEFKKGCGiLn0NBfdty4ZT5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZEn2T/oH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44ADvQhf028312;
	Fri, 10 May 2024 19:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mxylWuMs6ARut6Y7G3bDTyI6GtLj+TpEJPahYFIO9S8=; b=ZE
	n2T/oHm4qeG3bWkRiMAAlaGLkSViUt03IsPKsVrlfEclnxX/xD+BFhoxjRiLpkS/
	NRRnC9B3bccDSeKjxFq+lIV0TngfwI0dypqqWQUpnPetoRENoQnBQhlrhnBZkG+Q
	aALYh8V28VgjyrJNYpowTYyM61VsMl0zlObd5W6oafq1WMelHxAPrtA4iibc7SLw
	SUZzfZYzsmOs+zlxFLa221NfekDEfCNFjKdV3nwSk4O1twJqNA6gd0XMunSHkRN8
	kmamGNzIMeioKKtxWzcno9DeojVDSUuYJ3b2j+pBGqbf5jzTX733PixVuB113MeN
	aQWn+415gG3vhyR3aBVg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w0tetx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 19:53:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AJrh0N003739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 19:53:43 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 12:53:42 -0700
Message-ID: <c40cf853-f709-4ccb-ad73-e6d688b14251@quicinc.com>
Date: Fri, 10 May 2024 12:53:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] wifi: ath12k: Fix Pdev id in HTT stats request for
 WCN7850
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Lingbo Kong <quic_lingbok@quicinc.com>
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
 <20240510050806.514126-4-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240510050806.514126-4-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MMQQapn_Np_SPGVk3qhUZcChkSGHEP7x
X-Proofpoint-ORIG-GUID: MMQQapn_Np_SPGVk3qhUZcChkSGHEP7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=952 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100142

On 5/9/2024 10:08 PM, Ramya Gnanasekar wrote:
> From: Lingbo Kong <quic_lingbok@quicinc.com>
> 
> Pdev id from mac phy capabilities will be sent as a part of
> HTT stats request to firmware. This causes issue with single pdev
> devices where fimrware does not respond to the stats request
> sent from host.
> 
> Single pdev devices firmware expects pdev id as 1 for 5GHz/6GHz
> phy and 2 for 2GHz band. Handle pdev id for single phy device
> while sending HTT stats request message to firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


