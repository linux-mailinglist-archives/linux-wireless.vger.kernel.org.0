Return-Path: <linux-wireless+bounces-12502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9501596C578
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 19:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73191C20F12
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B811983CA0;
	Wed,  4 Sep 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XtSMkypc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A644376
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471075; cv=none; b=ry6716MvgZ4nGfyzH54vnqHdGQWTE73KCHnFLOxZMbIDzjyrm1K80dDmZZxx1+HHutpbr6OlU24HKL25tf8h0XYYV6yLxDszCCTQdYpPRdsu0EgNue7fxzS9QT3GvvBzMgSmXIkM9G/kl/K+pB8BS0o3IblMOE8c6jUbUhkzEBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471075; c=relaxed/simple;
	bh=/KrAqjup17PKOpMeVm0M4zEqRm2on2xEOmRmgbx6fVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a/+MK7eX3fx2wUk+x7tWJSpD+eqg0Fq98L0Vx4vUrWsQL+2fPIbv6fBN+r+PdUo9obhHrJwoI2VMKMCgdv0+/G6ZOUzI4veMCxsrmmexmiQNhouVWN83FOjVsWCN9ttsssHlmHDZAjjWHvhuKxyIuNrrdNxU/IgEcT1KmEws9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XtSMkypc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484AUmJZ010617;
	Wed, 4 Sep 2024 17:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nb2WfbAzhEtZm4ZzGkKQiikMPZLxi1bKX/rDYc1ct00=; b=XtSMkypc3ZFbhNsm
	CAW7tSYVBRmIodDinTR9gwWUMnoleYRYaKUX157P8iA51xN4HprZY0IRfOBriEZm
	Ky7P8mEp3MeaTk+M4xpXjUQ9ySg7CGsyeZf60tWocrq3awgiGZdqduWHTIcWvtvG
	fBkkK4On2339umXGWOjdTEWqn+A4NKJ+eqrTs04AjeaFYxAQX9YY3p9Qi7uEoV/L
	xMQoI0ydJ1mygHefJtheEeyZ+KZTTi+joX3XSKcbXdUCSc6gbLkxPIF2MkCdnPLg
	Szz4IJrgtgSP8FSHF9Cq5J7R3/LX2u+sjXYhsHilwWI+NLC9oFkyFG0yAc2V1oYX
	GK4ETA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bvbkkdjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 17:31:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484HV6RO028481
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 17:31:06 GMT
Received: from [10.111.180.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 10:31:06 -0700
Message-ID: <8b7d9777-e239-4173-bec5-607e15b98130@quicinc.com>
Date: Wed, 4 Sep 2024 10:31:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: add USB device ID for Atheros QCA9377-7
To: Tomas Paukrt <tomaspaukrt@email.cz>, <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <22t.ZbsX.5bWREDtSGGB.1cqQpF@seznam.cz>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <22t.ZbsX.5bWREDtSGGB.1cqQpF@seznam.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X9n80iZPUtfJzds4W0Yp194yJf-dcHS8
X-Proofpoint-GUID: X9n80iZPUtfJzds4W0Yp194yJf-dcHS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1011
 mlxlogscore=785 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040133

On 8/30/2024 4:28 AM, Tomas Paukrt wrote:
> Add USB device ID for modules based on Atheros QCA9377-7 chipset like
> 8devices BLUE bean or SparkLAN WUBQ-159ACN.
> 
> Tested-on: QCA9377 hw1.1 USB
Since Tested-on is not an official upstream tag there should be a blank line
between it and the official tags.

Also the Tested-on tag should include the firmware version information as well.

See
<https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#tested-on_tag>

> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
> ---
>  drivers/net/wireless/ath/ath10k/usb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/ath/ath10k/usb.c
> index 3b51b7f..60441ff 100644
> --- a/drivers/net/wireless/ath/ath10k/usb.c
> +++ b/drivers/net/wireless/ath/ath10k/usb.c
> @@ -1106,6 +1106,7 @@ static int ath10k_usb_pm_resume(struct usb_interface *interface)
>  
>  /* table of devices that work with this driver */
>  static struct usb_device_id ath10k_usb_ids[] = {
> +	{USB_DEVICE(0x0cf3, 0x9378)}, /* Atheros QCA9377-7 */
>  	{USB_DEVICE(0x13b1, 0x0042)}, /* Linksys WUSB6100M */
>  	{ /* Terminating entry */ },
>  };


