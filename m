Return-Path: <linux-wireless+bounces-4645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE70879F17
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 23:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61351F22689
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 22:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB7027456;
	Tue, 12 Mar 2024 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XaefvKwG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE15660
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283725; cv=none; b=Cpe9lHtn3y/1TRgjQAqv+kwp+NOzu58l5zWjSlzhlwiROnUlZExsiHFRUv2YBZZrrp0v0qMey7ex6M//5ool5N1h+PXE/AcPQgBmsThicT42v+io9KXKvgnzY83xD/PDO4iavrDFTRHnN2P8Sm+VNfixcs/xj/1B7HRJaNeNWIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283725; c=relaxed/simple;
	bh=obUuk0ZzNESk8MiMhT0Ie8pX5s4WJuUnQy1qbMdO8EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Damq+6VmStJOq8FkbyZlWt2mhBmJgSPOS517NKvKUIh3kvxT3xiQW6HzpKdVybNeuz3pZTuSfG7XLNxuiFR2IncjrXt3KGxbWz1aRpk/rp4d6rffvIISe9WnRX/Is4N5NS5NCfPwHK6Em975HJ241vPDpSmzTGcUi8T+oA9S5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XaefvKwG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CMS7JL027809;
	Tue, 12 Mar 2024 22:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=521apfSareIjgLtEAkDimZR8oBHYm2c69veAK80ZYjs=; b=Xa
	efvKwGaeRD/qCoS3uku1+krgIJ23jSinCO2EN4QlF+3BtFFcBH6mK8RySlHazSg3
	XEOPcQ2u8aBBSlcNsMt7AmBqzWNNGN/U4WvA8B1O1/w8E/fR5GVKWDEvr1V0cSNb
	y25CbV6aG+Gc1+bANRoT/NXyRzjwtVypU/Tw04D+b6zP90Bf55m+5IEerxX3xNJT
	VfW7bNplhFuKbHOGo1/kSZtuUZ06AA4IIiJE4FH5AbjCFdMpP7hZbR2Y3AbnjpaJ
	oj8+/R1mEK61Gsu9CcFGoxDXjUbgvFZpapPmL+PLJ8gNBVP7gynconCduO2GfhZ1
	FDclOLNxxDwrtUXusymw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtgc3ja95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 22:48:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CMmdgc009513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 22:48:39 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 15:48:38 -0700
Message-ID: <ec68d61e-241f-4d7a-93ba-ae3d3a21d342@quicinc.com>
Date: Tue, 12 Mar 2024 15:48:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] wifi: ath12k: fetch correct radio based on vdev
 status
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-7-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240312135557.1778379-7-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o3oZW54E5U_S67XdExeC4oDVjNBt7xlp
X-Proofpoint-GUID: o3oZW54E5U_S67XdExeC4oDVjNBt7xlp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_14,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=790 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120175

On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> For ops which passes the vif info, fetch the radio(ar)
> to be used for corresponding functions based on the
> the vdev creation status. If the vdev is not created yet,
> which could happen when the ops are called before channel
> is assigned for the vif, the data needs to be cached and this
> is done in followup changes.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


