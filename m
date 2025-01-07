Return-Path: <linux-wireless+bounces-17119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7215A03486
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 02:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE6F18859BE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 01:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E50E134A8;
	Tue,  7 Jan 2025 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p7cw8yiZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8212F46
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736213276; cv=none; b=YnELAIjQRobNZvcXonKPdHnPYNGKZB23aW/XZhL6xMAS+LBWgIBj/cGsGvILXKMv6KAHCAEG3rdWFqti1Oc4k+EZz5LrZBf/68QZG09MhX5Giy3NGU6/GxgnbG5NSFN/BRwHNctcc6N8p/6jb5U8DKu+lhAjguvLHtLVX5WIu00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736213276; c=relaxed/simple;
	bh=fiYsqr8h7vSKHbiIzlC3jtXsPUXZAr4L1jZ+3/Iriwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dH0OGe/mRSO2/0WUd/segekBofykLN6nGRLQDaz1tRxMvxwH09VegFjWR/nQ5k7hExZVcR480yiHw0lWtdUsg7yt95AQ71jN47EHckV2E0LSaTVL+W7A17ZXUV+C28D47HLrCdCjGkl3wRpMyZGPyWbGf/mrp2u1HcNDypBv1w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p7cw8yiZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5070MYDq006449;
	Tue, 7 Jan 2025 01:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FzFz3ZS2SpifsNknJ1s18qEX0TT65AVdtP+7DJjCLMg=; b=p7cw8yiZU0uUkF/c
	g/BAKOr8mZOkMvJsk0fWAdNdQ0kr3tNEE/G0uH0TYAbv6AcsJIQmNxObyhYNgA2H
	EFQxJrvRXRf6y9CbRGXe8/gwYybtWz6uy3qU3kmLnxYeWl+AH3m0uDQqoJnqkROX
	F+AHF8OyZZgUIy/fGpPQuQgp/MHFFrVky4PYi85wnL6pGlw1JfPLBq8vD4wMgLMP
	QPhwSPYU2K9Q2oA2RmooipYd9gh3dyGHhjZmg1xCmU7mTo+IyhGCSTIJqTPQk0Az
	NMa6fycUMI5yaRV4biyzxMHQGgWghbjxMhUR9b4fpPtRQJB2k+P5jhJUJAVHx8Pr
	+Yh3Pw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440m4a0syk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 01:27:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5071RkPD017097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 01:27:46 GMT
Received: from [10.216.19.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 Jan 2025
 17:27:44 -0800
Message-ID: <33ce0af0-a2d4-415b-9b64-87e42192f933@quicinc.com>
Date: Tue, 7 Jan 2025 06:57:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix tx power, max reg power update to
 firmware
To: Santhosh Ramesh <quic_santrame@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sathishkumar Muruganandam
	<quic_murugana@quicinc.com>
References: <20240909073049.3423035-1-quic_santrame@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20240909073049.3423035-1-quic_santrame@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bvJkWwtbXjmZrx306RMBj2uP4W0lmEJF
X-Proofpoint-ORIG-GUID: bvJkWwtbXjmZrx306RMBj2uP4W0lmEJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070009

On 9/9/24 13:00, Santhosh Ramesh wrote:
> From: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
> 
> Currently, when the vdev start WMI cmd is sent from host, vdev related
> parameters such as max_reg_power, max_power, and max_antenna_gain are
> multiplied by 2 before being sent to the firmware. This is incorrect
> because the firmware uses 1 dBm steps for power calculations.
> 
> This leads to incorrect power values being used in the firmware and
> radio, potentially causing incorrect behavior.
> 
> Fix the update of max_reg_power, max_power, and max_antenna_gain values
> in the ath12k_mac_vdev_start_restart function, ensuring accurate
> power settings in the firmware by sending these values as-is,
> without multiplication.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

> Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
> Signed-off-by: Santhosh Ramesh <quic_santrame@quicinc.com>
> ---

Hi Jeff/Kalle,

It would be good, if Fixes tag can be added while applying this patch.


-- 
Aditya

