Return-Path: <linux-wireless+bounces-6580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE7B8AB11E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 16:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF151C211E6
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29C77D07F;
	Fri, 19 Apr 2024 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QbB6M1wj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531331E893
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538526; cv=none; b=fJE5qpT5Fu+SyTas46zrvdHJwLX/20hk6XVzBsv+M50WUfMB8HwK9qGbBAPn2DUiPbBnRMhtYIWRB2Ee0wS0Mh5z2lYPOhNeCPeHf20c7MWa31iEWGjXFOmBa2MjG81B5C9M/SdNQBXVwftiNDxQ3Dc12O07fvg7g3PO3CRxkDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538526; c=relaxed/simple;
	bh=mP46mwP76nUozmIudmEjh3LZE8WY2PN+hZRhlnBIod0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cVglUe1VLtauf5xaF1yIFt4sQD2nyfsRyKS/QO3AvVsHiP3jziiu7RxgdkKKBSuCzRnx09+V7ROVaotN1mAG3YYWI4omuZSj7k/053gIqiCWZ1btECw2XBJKFBEF25k2+Bf3ZXLJubVc+8+2l9BOGYJGJcoEqIMpP3PwP8ptfrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QbB6M1wj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43J5u9Dr010237;
	Fri, 19 Apr 2024 14:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=NLOvtlL/JJAvBaLgqLGuq46Heq1oHvD25UnazPKKfLA=; b=Qb
	B6M1wj+hrMdlpaJVs34vZ983nN352KCXU0uvL0tyqC2kEe8Ru3uWoUjzxNWKExd0
	IcIzxLfFvuvJnZNxcReQ68txpF36XgOApHV8QnMibfZ4tSK/PrUlDkZklKNBE8Y6
	61RC2v/p1VodTyIYRyQDDq09YRfLw7aT9AeIGeTB/rBHiQOLvCyB/eqVvk8ohu48
	5R0OvSp2hAb7Ttxd6TpToZWoP8GvoJ4Djn4ox/WPVMvusDgJyfnxK96ovg8D0C1M
	0KDA6mvsFq9FhXt/oDDLHOXMKs1DF1Ihd8ahsNwNWq5IlIjE2HPOhwLu9yaJycA9
	7F5YfX1jW+Dj+Z8x6r2w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xkaw7sx4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:55:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JEtHFA020092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:55:17 GMT
Received: from [10.110.56.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 07:55:17 -0700
Message-ID: <4f9ab4ca-595c-4208-96c3-89f709b74b1b@quicinc.com>
Date: Fri, 19 Apr 2024 07:55:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] wifi: ath12k: ACPI CCA threshold support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240418162019.1246749-1-kvalo@kernel.org>
 <20240418162019.1246749-4-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240418162019.1246749-4-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RZrZJKGtoJkUbqeTtd1D-8mH-xwg6T0M
X-Proofpoint-GUID: RZrZJKGtoJkUbqeTtd1D-8mH-xwg6T0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_10,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190112

On 4/18/2024 9:20 AM, Kalle Valo wrote:
> From: Lingbo Kong <quic_lingbok@quicinc.com>
> 
> Currently, ath12k does not have the ability to adjust Clear Channel Assessment
> (CCA) threshold values to meet the regulatory requirements. Get the values from
> ACPI and send them to the firmware using ath12k_wmi_set_bios_cmd() function.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


