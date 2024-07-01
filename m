Return-Path: <linux-wireless+bounces-9804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F421291EB6E
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 01:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E83B1F2266E
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 23:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354DF172BA6;
	Mon,  1 Jul 2024 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KO93Vx2H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB662F29
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877321; cv=none; b=q7TI8966XSshFkDOMQh0RA0qgPlEiG/UnK7jzUzRRE0uZgys5xHyWGOsjHep6jCUEYt/TOrsEfrs0rWnhMuuvFvqk1Ssp4WcoYkq8RHNjsGWHPI53gQrMkp8T34cZapCalhISWCTAxiVS2RmA/UKILDB8aak8HrA9oNYK6zgV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877321; c=relaxed/simple;
	bh=Vo8YL4MIGADGjml0+c9tf5luBbhSLeWW5RwcCdvftLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lcwOwJtyHmT9qHOVKa5O4MjT0cAzbiuZ0V1vDCMSem8RpK5+HzBNBp+1F1ZKNAAribAH5w86kDPGO2j8W/cDVjbNMdUswzUZYaVn8zAvQ8aqyonWSgZGEtL+QRp0+rakzQaZwsGgfSAKBr2NHv7TRLHFYJ2Q9/1ZELIBNapqcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KO93Vx2H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461BMMoY031391;
	Mon, 1 Jul 2024 23:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RcDTrnpdteMkm/mS5fV30rbis65miMqsA/vvLE72Yjs=; b=KO93Vx2HYAJIyfjY
	4acZ8cnKOLZQ3LO138pVcdLCv6ZFgVT8E16Q01rQyzKMCL3s/sHAAroL4SPt8L8K
	4ZYQRy+zsLPMHJY2BOZIJARywfBd4a2BcLdPG3RZKSs+r8b6MFtX9PVwCucoR6f0
	SBrYj0bMUni6ST2QXau5EE6lL4xa+I35VDjbudMg4JNDw0k6tMluJuZ4v/4wWNP5
	C1bUniIaspUlN7Pd4TG8qQxQCVVO1zLH+gdT+d98Uyw3Cp4lkVPESpkhQczf42EX
	o3GirjdVh/tHkrI4l5jG2P8eULw4pMBHzL6YStzCcVXbbUOefjp+2otncPz0QOcK
	OIbqBg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402bj85dnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:41:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461Nfvx9015630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 23:41:57 GMT
Received: from [10.48.245.148] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 16:41:56 -0700
Message-ID: <1de53467-3c67-4678-b37a-f6087fea22cf@quicinc.com>
Date: Mon, 1 Jul 2024 16:41:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/8] wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set
 to mac_register api
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240628095139.292952-1-quic_hprem@quicinc.com>
 <20240628095139.292952-6-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240628095139.292952-6-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -K_pbK-2n4oNTFIjIJ09ye1rAwB_4Sx6
X-Proofpoint-GUID: -K_pbK-2n4oNTFIjIJ09ye1rAwB_4Sx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407010176

On 6/28/2024 2:51 AM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> When hardware device group abstraction is introduced, in future, a group
> abstraction is registered to mac80211 rather than a particular device.
> Hence, setting ATH12K_FLAG_REGISTERED in QMI firmware ready event might not
> be ideal.
> 
> Add changes to move set/unset of ATH12K_FLAG_REGISTERED flag inside
> ath12k_mac_register() and ath12k_mac_unregister() respectively.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



