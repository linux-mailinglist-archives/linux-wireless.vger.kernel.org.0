Return-Path: <linux-wireless+bounces-6884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90228B2ABD
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 23:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F16286CFB
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 21:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB9A155726;
	Thu, 25 Apr 2024 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X86CrYxu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC0155723
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080490; cv=none; b=V3xqPa93G3UrQd3fX06DWT/Lsu2vb/lFj7dcrMQ2Jd4UkdEHOCOJXCicI5nZS37kauzfPDSCQWvKyRmf/WkJjlbR4T9PdODrDfOR2n9iww/xchkWCzQbRAM3wz74mJoaP7yIoTpzGDhBBMVNkd0ScagVG1nJJmPxFwt58mptLf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080490; c=relaxed/simple;
	bh=tlMZpCZC1e80fWRUstU6w6jZsDm7d2rC533yb3Dll1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TxifsluaYpY8nUuJyI3c3h4+oeO73hVjA0cWtFOjnw9AEjN1u0XYdPoNUYGJSw3+K41tXCbq+VNSDyoJetf0lh81vb9M34tcefi9HTveAl9PbsyLsThjfKJ0inFBhrT/ZPD+U0kDVVxP/Xofaa9Q1V07C5ZYyGThqESGCz6bLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X86CrYxu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PLS7xN017011;
	Thu, 25 Apr 2024 21:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OCLaS5h6YpS+Lv7aT7LZMP0TrNKIoNJ7s5cn/oUJ/wQ=; b=X8
	6CrYxuzi+OFUS/fe4apMnWfkFGoOka6cwFbIdUS90hXldOLDRY08WRNQpHCtTw8g
	OqdnDeTZqg11Q7CFrRw2o6ijeiRoCSZGDoqdbarI7v6e/Zf1o+gd+ILDfFY57nrX
	pe8qMTqh4a+++KVrm1+FtSDMhbqBjSvCXMXZ7Ghu8YIvwHmEMroY2+9kGvXQaOl7
	de3yY8MVfXaPq/jHGTpt1IMT2L/RYQaqfwdE0WCgyMxBjDqurSBIknzGUH3vs3dh
	dGcb0dI/T37oY3nNN22rN+T73Q94oD/nrKd0NCLWmnBWi0MhJigIZAZ83zj5BH+2
	ECUWH+vZ2rZIw8k+GiAQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenh3r3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:28:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PLS672030774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:28:06 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 14:28:05 -0700
Message-ID: <2db05958-510c-4628-9e51-aa8bfc8646b3@quicinc.com>
Date: Thu, 25 Apr 2024 14:28:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] wifi: ath12k: Add ath12k_get_num_hw api
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
 <20240425055759.1181165-4-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425055759.1181165-4-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8BzfhfHctUekR0Y-R3Idrcd9DQROcUbk
X-Proofpoint-GUID: 8BzfhfHctUekR0Y-R3Idrcd9DQROcUbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=615 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250156

On 4/24/2024 10:57 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, one or more ath12k_hw is part of device (ath12k_base) but
> in future, ath12k_hw would be part of device group (ath12k_hw_group).
> Hence, num_hw under device would be moved to device group.
> 
> To facilitate above transition, add helper ath12k_get_num_hw() api to
> get the number of radios per device. In future, this helper would be
> able to get the number of radios in a device group.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


