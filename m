Return-Path: <linux-wireless+bounces-7405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A473E8C1C52
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 04:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDAA1F2161F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 02:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFCC13B5B3;
	Fri, 10 May 2024 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Eg0e7OUb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E66ECF
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307327; cv=none; b=dSW6EKdEWWRvDF2Y3myX4SoWB44wD0pyKs5ul/m37egMrASW4zGqF5+ej/HetMO50iTB0cztHZNPayQT9heqoaPIz8L5hiFOf3h7O7G31fkwwHjGR+6XsAmjmTvps5gMukOgwD3Da+uoxgH7KUDABMCw86LMipq9yjtnjJIw1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307327; c=relaxed/simple;
	bh=M5L0MlGAVBRN71CuVe6AAxxhKE7LN8n26xfxchY6ZR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V2syojeeMrSx3DC6ENqFBczgfx2fLS0neu0dZ3onNnIr2mXJV5RcDrMD860ajpwp4968d7A+RskJzShWi1StYilbLoVzA9MiIveTIB0LGkidJEDpAIm0CDtyekazFGY63eqV+okTyjpY6EUtVTNGPxh3r/r1Ol+a8KZ2cQuz6Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Eg0e7OUb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A1AumS011180;
	Fri, 10 May 2024 02:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tZDF65rKA/SURu8YBPvrY0OUBrRMgux8b5P1ZGF+JaY=; b=Eg
	0e7OUbLvsv2DtIiLpHH2owsGbwTcHqSkv54yvngagHW6UxvuV/J8H7Ifh1H6Yiwn
	IfoDsP7r8AjMq+ac2hjULftY2YKnU2OQTItAookJ+QLvA8cV50df8Tf6GIskKmkb
	u8+zFUZ/8z0vq8zpMAhgPPpNevHtnsi6wFhhC3Kigac0MaYCuhzFrcQNyb2YmQVk
	76holSeszSHcEjubwRuvVhnGbGWwLr3N4sk01onGNexzJR9Np+p1vEznY70zD7iR
	T//WWj5nyeyjzL7h5H2Z2GLJPrsy39CbdvM0xVzzV8owuEurGREZBODb4zk53NZ4
	D8t7EidByecZpwqrqMVg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w20bec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:15:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A2FGs4022150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:15:16 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 19:15:15 -0700
Message-ID: <0a6d561b-635d-4af1-83b2-83303f6b5b10@quicinc.com>
Date: Thu, 9 May 2024 19:15:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] wifi: ath12k: Refactor core start api
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240507045702.2858954-1-quic_hprem@quicinc.com>
 <20240507045702.2858954-2-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240507045702.2858954-2-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: esyjHDL1YZDCGmNSLbRW6lrPLHvm5iU-
X-Proofpoint-ORIG-GUID: esyjHDL1YZDCGmNSLbRW6lrPLHvm5iU-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_01,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=755
 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100015

On 5/6/2024 9:56 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Hardware device group abstraction would be introduced, in future,
> where radios across different devices can be grouped together to
> support multi-link operation and register as a device group to mac80211.
> 
> Currently, ath12k_mac_allocate() and ath12k_mac_register() APIs are part
> of ath12k_core_start() and ath12k_core_pdev_create() respectively and are
> based on per device (ath12k_base). These APIs can be decoupled and moved
> out to ath12k_core_qmi_firmware_ready() itself.
> 
> This refactor would be helpful for device group abstraction when mac80211
> allocate and register will be changed from per device (ath12k_base) to
> per device group (ath12k_hw_group).
> 
> Add changes to move allocate and register APIs from existing one and modify
> corresponding deinit sequence.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


