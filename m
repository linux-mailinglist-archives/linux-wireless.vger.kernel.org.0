Return-Path: <linux-wireless+bounces-6578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C488AB11C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FFA1C20F5B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F357D07F;
	Fri, 19 Apr 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C4IcEJIF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47D31E893
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538491; cv=none; b=uhuhlB6d5TVyO34jwceyEmKdheo/aBNARAFZyxosa/rr4U1zu/reOg6bL/wKAAhZWPOsCEks9V41h/+ixUakmvoQ94AsN8RvhEPZkGm3rMEsxmvVrKa+8bbCJnyU6TqjdPzQ9UEF7heW/WmMcFCQFMTxgJX55OD1W0WV+dcqDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538491; c=relaxed/simple;
	bh=QgleWtzLIIsLPA8VO5aYl0KDRDZ7M6qlK9erElnpw8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E+886tGC0Vku3h+/dA3eOsA2RWwMtIlyakVAgcmRUH9IuvMn4+3+wvVmZ5v4sTZGC6zpbZLDUleG73AAmNLF3/eqSqOnc8n4K27u/+xm1VPD0BPXGGfZkre85VTy0k3W6pINlH1AANBYONMxTm89JZR3uxe4DFciB4/2SBpUMpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C4IcEJIF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JDp9DI011105;
	Fri, 19 Apr 2024 14:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sfSXhH4qGOV30gDA7bcJqB/xyZGAyNbZCGoYCwLQRsY=; b=C4
	IcEJIFdcR/hz+7ts0zZ22z3oGkzONonNyq4L5fntWpaaqpU0HSALd6iiyh1YqymZ
	rZYklC7HreXznQllFJw1CbZZVWm5FkenvmCXDNKwMj6sn1pIgyb0yZL3+zeoF7kF
	MvqBjWTiDUY1W9/ixfW6U89K0RvpXhm3EiP5mAz0Y01mYkfUEG/fzmWIiwayWMj3
	ZRdES3We8tpa/2GrPKTVq0mH6ZMVcccVDnuzl4W2OL+TrMvtNLMdnEm2zKIPtpog
	sOk69wUPRMGQFDw3NO2ES5U1ykKOGQhDDvOvPpfv2CUOTvJ16+neQlsZA3mt9sJp
	l4tnhIkbIn1WftjKcgmA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xksuvr4ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:54:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JEsivr000476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:54:44 GMT
Received: from [10.110.56.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 07:54:43 -0700
Message-ID: <3f7b52da-70b0-4e37-b2c2-eb0b1985b068@quicinc.com>
Date: Fri, 19 Apr 2024 07:54:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] wifi: ath12k: ACPI TAS support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240418162019.1246749-1-kvalo@kernel.org>
 <20240418162019.1246749-2-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240418162019.1246749-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RXK8rEFwnq2tAFqtovSEIGhhyWaTxiUT
X-Proofpoint-ORIG-GUID: RXK8rEFwnq2tAFqtovSEIGhhyWaTxiUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_10,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404190112

On 4/18/2024 9:20 AM, Kalle Valo wrote:
> From: Lingbo Kong <quic_lingbok@quicinc.com>
> 
> Currently, ath12k does not support Time-Average-SAR (TAS). In order to enable
> TAS read the tables from ACPI and send them to the firmware using
> WMI_PDEV_SET_BIOS_INTERFACE_CMDID command. Besides, ath12k registers an ACPI
> event callback so that ACPI can notify ath12k to get the updated SAR power
> table and sends it to the firmware when the device state is changed.
> 
> ACPI is only enabled for WCN7850 using struct ath12k_hw_params::acpi_guid
> field. Most likely QCN9274 will never support ACPI as the chip is not used in
> laptops.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/Makefile |   1 +
>  drivers/net/wireless/ath/ath12k/acpi.c   | 216 +++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/acpi.h   |  45 +++++
>  drivers/net/wireless/ath/ath12k/core.c   |   7 +
>  drivers/net/wireless/ath/ath12k/core.h   |  13 ++
>  drivers/net/wireless/ath/ath12k/hw.c     |  10 ++
>  drivers/net/wireless/ath/ath12k/hw.h     |   3 +
>  drivers/net/wireless/ath/ath12k/wmi.c    |  44 +++++
>  drivers/net/wireless/ath/ath12k/wmi.h    |  17 ++
>  9 files changed, 356 insertions(+)
>  create mode 100644 drivers/net/wireless/ath/ath12k/acpi.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/acpi.h

Pending update of the copyright on these two new files,
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



