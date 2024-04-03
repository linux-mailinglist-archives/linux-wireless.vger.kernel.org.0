Return-Path: <linux-wireless+bounces-5849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA10897902
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 21:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C1BB26BEE
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE265154C09;
	Wed,  3 Apr 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lZBC/PlQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38164154BE8
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172556; cv=none; b=W+DDMMfcfXGryeNvyGyX/uC7S0/9izOxY4LIM3CEYVKh94+1qQDV9EzeD/2dQMek0YxQltDlLmqrnxLAyMg4XMpXID+SEDFha6S2eMTmvgC5HM1oNpGuAagRy7C6QtjYfwcUTamo73tcJwq1Ras929WY5kvnj1AsLzRb0khUs6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172556; c=relaxed/simple;
	bh=TY4LWlE5BsfjItBFO3vYIoxw6whp1TVJsKeO4Io7h08=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IM03Xc8tvAzPyKPLIKV0I8bsjdcUHIECONW8o3bzCvqa9xfESKbEkJasZFJ5mLTbD6VnibMXBpa7V26youo/bwulia5aFNG1g4gnldP1CNeCh1lXOEvz/PrxqgafDoXc5MGKoR53DTdaU/rTo6AsPG/KR7EneDHqNRF4C33/HIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lZBC/PlQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433JCufE009313;
	Wed, 3 Apr 2024 19:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Lh+QfXVliJEet/I68QAud/iIxqeAK3JX5Qd0R5YQrIM=; b=lZ
	BC/PlQV3MJtySgAYNeooWdBTHqg9bBAaW+mJvGFyLRc6h0fwt/T54v07orNvzwLP
	VTZ8e82+oWnGFbpPLEIrq2a69v7FLQZ0Zj7b8LWdqGyHfgJMcJnTDFPT0P41wz0c
	gN+uTtIvbbRmuR6CgYRCM22a2j2Ml+1tDfjPaIMPyzunn+FIkceEZ4c6MlxUMygA
	I0UxIR7/Ige1S3+g09sC8o1pfMaS8v2rUTjmyXCkcuTdwCK0TRF9AsL2ahKEi1Jh
	kVRsLaerqtrzYCGVlhk00AncEf2lS1aa9+9v5Ukq2Bp00/bNu8yJsFWUDMyLYY3Q
	cMb463X9ZbwfuQzgDRFA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x993u0p2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 19:29:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433JT8K5012512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 19:29:08 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 12:29:07 -0700
Message-ID: <01689e50-3bff-464e-95ff-1b24bdac8a78@quicinc.com>
Date: Wed, 3 Apr 2024 12:29:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] [RESEND] wifi: ath12k: extend the link capable
 flag
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240403042056.1504209-1-quic_periyasa@quicinc.com>
 <20240403042056.1504209-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240403042056.1504209-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IMolaJF7bDGVrEojyRg9JXYAFH6l-OLV
X-Proofpoint-ORIG-GUID: IMolaJF7bDGVrEojyRg9JXYAFH6l-OLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_20,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=840 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030131

On 4/2/2024 9:20 PM, Karthikeyan Periyasamy wrote:
> Link capability categorized as Single Link Operation (SLO) and Multi Link
> Operation (MLO).
> 
>  - Intra-device SLO/MLO refers to links present within a device
>  - Inter-device SLO/MLO refers to links present across multiple devices
> 
> Currently, driver uses a boolean variable to represent intra-device SLO/MLO
> capability. To accommodate inter-device SLO/MLO capabilities within the
> same variable, modify the existing variable name and type. Define a new
> enumeration for the link capabilities to accommodate both intra-device
> and inter-device scenarios. Populate the enum based on the supported
> capabilities.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



