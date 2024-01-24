Return-Path: <linux-wireless+bounces-2423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C69839E8C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 03:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C451C23A55
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 02:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF44F15D2;
	Wed, 24 Jan 2024 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PKMGLTtd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28C3C0B
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 02:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062139; cv=none; b=FENOjt8aWeEE4/RuIzHA9Dx7Z+qrtkGTo/CgGQKVl6uQkB29fZNuoD4+l4cCyiDjgJ9mENk3OvuKlxNjMTx91fHhdzd29OfyBmBtTz6eK72KslucstqCPYDmT844WPdLcn89YWu2SylUuuuPLrCc/LZFu0Gb49fM9G7R1IwCRlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062139; c=relaxed/simple;
	bh=IHA3egyCDlqzIYMV+yFakosssLbw7cRQYb7DaInVVjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=McYI6JTVG/T51QGSloRUzkne1wy7aLhD5z0Kp4acJ83FX5T9wex1t7n8ShMv/EqL6jdcIEBh5H6dpmVOJo5t+ENATT0B0OaYD70UYVH7HvpDZH9rvYvK2VXzqEjPJ6JNbVtkhwi5UVsofqHkwaQlfvAFmVaq1Mm3hwC2FEfSavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PKMGLTtd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O10Jri015738;
	Wed, 24 Jan 2024 02:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CeljonlehUh1fFPuYgO+4Ggh9DflsM1FG8kOjLWSceA=; b=PK
	MGLTtd1tPX/lsz7bc5aIK/jzvoRkFpD/iheAiIvveKEUsO19ad7nOWoDSuUA/V17
	GQ4jERfyes5xyUB2BFZmOKbZq9s1kjy/wKGpqhmGhvWFENO9guDg5ILAISO4ROvd
	kDDD9Li6qSYOmYET4zJ8a9+9VIe5z0KFyk8wqod7pG2mppiZIrn1rW8SxUWOdkxe
	mkn4wkNdSHeKyW6jOvVOB9GFXxiSLCimxtXIpGsCjmQeFdho+VidRR1MdrXcItwF
	CnLJ6U3k6CbuPbFtBIrMLgsFrSyDKGbC0oMyENN7Tfrfu9WeP/lAUXSVx51TQBJS
	/T4Xhpy8e44rXO3Bzlww==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmgwghh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:08:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O28sFE013310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:08:54 GMT
Received: from [10.110.18.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 18:08:53 -0800
Message-ID: <db9e61c1-707e-4ab6-b474-261c3a8e115a@quicinc.com>
Date: Tue, 23 Jan 2024 18:08:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] wifi: ath11k: rename ath11k_start_vdev_delay()
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240123025700.2929-1-quic_bqiang@quicinc.com>
 <20240123025700.2929-3-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240123025700.2929-3-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JEpgPNF_UXLIi9ijCsGhiHCzj5ykvxxW
X-Proofpoint-ORIG-GUID: JEpgPNF_UXLIi9ijCsGhiHCzj5ykvxxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=598 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240014

On 1/22/2024 6:56 PM, Baochen Qiang wrote:
> Rename ath11k_start_vdev_delay() as ath11k_mac_start_vdev_delay()
> to follow naming convention.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


