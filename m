Return-Path: <linux-wireless+bounces-2422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 396BB839E87
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 03:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDC028416C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 02:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5424D15D2;
	Wed, 24 Jan 2024 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b9je8fhG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C817CB
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061933; cv=none; b=VX08ME2Ur7IrzCpcL/+IrzgBhWaC2oYsZLDoUAh9G5PzAm/y8jorhJG59ZQjc56sDeBlZxIjpCX4+Rn9Gi33w6VVL5J3vagNrT2qxGa69C4dKAHaRwV89GGp/vN8dGALi1v7Y9rxt9k6cb6KK5LkWcPipLU5BqFP+AlpQ81306Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061933; c=relaxed/simple;
	bh=KstsyO1Mx1LJmZwV62OoVUuIW+HmyfZBTP+51Yjlu28=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FSMQr2j6HeG2lZSwBtanc/V1cpJbbYfdGNtfZwKmkhZ9EgKBIYuBZs9m9K/fI0OotUFuJ2Qg26qzYyzoMQQssZVpsMYJOzKrFerWGfOq706Lj8GkUYL2ZmMolV3BtlR1Uhh6VnRxqIF5BGHeu49C3hLXJMHOMFUTUgBkfW1O/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b9je8fhG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O1MLlK027786;
	Wed, 24 Jan 2024 02:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hFM3A5wdfalwDIuvbgvDQpirBIvU/6tTYfF061b1NdM=; b=b9
	je8fhGo8krWu9SrSOKKIkXJ9hR8RO7mzeADUCzEL4ULmjvyvkWt9OyZMmYXOdUiR
	ZAPMjz18KI66v4QIeFwot+j7xtDsmZd4BakL9QvQqslKLhsIVB4EoHhjl3K2XZ4w
	py6vAcQuj/iVdyhgOUxPoi4oxmmWT/BCi+8jjCoHjpJM1KjfsD32WIn3vEAXxU07
	PCOQxzHxgre3cHZb4dZmBhUNuIvVwD+DkmHTraFdaFvnSd+lQk3N7F7FG0IYX40l
	NH+p8ltrJgidKKGffkbbNmEKbL2sKaXMQ9ez0MlL61EUV7hjOcDmnxDGtXZxqqh8
	uoK87UBhfQ6/rJkH0niA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmmeggq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:05:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O25OjX015018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:05:24 GMT
Received: from [10.110.18.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 18:05:24 -0800
Message-ID: <bb75794e-e475-4736-9dcd-a4c9e9633e8c@quicinc.com>
Date: Tue, 23 Jan 2024 18:05:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: ath11k: remove invalid peer create logic
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240123025700.2929-1-quic_bqiang@quicinc.com>
 <20240123025700.2929-2-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240123025700.2929-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bc7B1m2UTwaAegkYv9IgBIer6ptsGMZ2
X-Proofpoint-ORIG-GUID: Bc7B1m2UTwaAegkYv9IgBIer6ptsGMZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxlogscore=880
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240014

On 1/22/2024 6:56 PM, Baochen Qiang wrote:
> In ath11k_mac_op_assign_vif_chanctx(), there is a logic to
> create peer using ar->mac_addr for a STA vdev. This is invalid
> because a STA vdev should have a peer created using AP's
> MAC address. Besides, if we run into that logic, it means a peer
> has already been created earlier, we should not create it again.
> So remove it.
> 
> This is found during code review.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/mac.c | 16 ----------------
My Qualcomm Innovation Center copyright checker reports:
drivers/net/wireless/ath/ath11k/mac.c copyright missing 2024

Kalle can fix this in the pending branch

Actual code change LGTM so
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


