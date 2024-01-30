Return-Path: <linux-wireless+bounces-2836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9F8429E7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6251C21390
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C486ADC;
	Tue, 30 Jan 2024 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mqpO7oYE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34BA1292C2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633331; cv=none; b=tdXpbsXyG7vL1nnghGr+cGUT6hBh7zEir6RrFT0QCPa5kCg6LXF+6pkMvXMHds8HoYOyyAUl0A6p6SwGKA4Tp1SPiag7zqoNhhOeWbs8DZbQJfPK2SCrfNBPA+4Mp5xZiv2/rksglfprQmR9dR84r7QX1JpsoIr4I/gaYvupFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633331; c=relaxed/simple;
	bh=7WT6PII5+05uPP7MCAQKbCOP2E7sF1jnD0CySRwgXTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U7BsLfOBOkYjtKCilr7BYcXTy8eLafXT/xLY09Cc/DG49/JaEHZRxZ47rqvF55IqosFY5WOE85BGOMZCWz8ntQSCE99lLxIjAS+4/yrgCYDYh7zlt/HFBZlIswT2YDMk/MPXZpxLnLdvlNKEqmgW+RS80fDVMOOAcpCLODUe+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mqpO7oYE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U9fgmB002419;
	Tue, 30 Jan 2024 16:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6lcFIP57dwO2cmUlaJhC/Or/CCyRCQyFFe8KBceXjIU=; b=mq
	pO7oYEafFUvNIEEARhtMSe6YyOQQxt0TNzxL68KDtEa+ZERjQ8FKibr3TPrFOFwk
	/BUimB1aPKgQNs+JEJBMXd7/7pTW4Y8KC8npO76A3wuAkJOmUuBGaQ1MNYfLMksh
	m51AQR5ObbazRYkb4Wt7d+QKM5azupAKKuwHFbmANIhB52mz0+9LIO3jiAKW3Dnn
	sh0w0tpBtRRjCzp3LpWP9/uKugurczI0EALB6JHlcAzUOdYKMwW+JxZYzMwGhKVU
	TwQXSXZj1U5SiIuV3ahZAwXmLoF4S72ZW7bjU/DIJJZ9Q8DU0VVwCRRlnugk1Deg
	K+aRaTI5fkgPHaFVYAsw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxvwqs87p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 16:48:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UGmcUg029055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 16:48:38 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 08:48:38 -0800
Message-ID: <6e302c5f-0bb4-4c24-b2a6-708db8118cd9@quicinc.com>
Date: Tue, 30 Jan 2024 08:48:37 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] wifi: ath12k: fix broken structure
 wmi_vdev_create_cmd
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-2-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130040303.370590-2-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8Ro3g2NzOTFYhGiI48C4elO0v3Q1hTHX
X-Proofpoint-GUID: 8Ro3g2NzOTFYhGiI48C4elO0v3Q1hTHX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=612
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401300124

On 1/29/2024 8:02 PM, Kang Yang wrote:
> Current structure wmi_vdev_create_cmd is not matched to the firmware
> definition. So update it.
> 
> And update vdev_stats_id_valid for vdev_stats_id.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Note that if you respin a series, and if a given patch has not been
substantially modified, you should add any previously given tags to the
new patch since they are not automatically carried forward in patchwork.
That saves the reviewers the overhead of revisiting patches they've
already approved.



