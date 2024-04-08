Return-Path: <linux-wireless+bounces-5983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939489CE63
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 00:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C231F231E2
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 22:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE35149DF1;
	Mon,  8 Apr 2024 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I/B3AeWX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25F149DF3
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614656; cv=none; b=KwVRGUvVdSCkglM5dlh2Pj7+etK14CRgSIbw8P9AwADcqyyBDNgaRvKXds3vHu/J8puyX4UB5Kpf7TskEsIIDvpfXQZwQtvza829tSU9/WvpSWpRFmqU1QMNiYjATX2TkvVI3Tl/dZoxA8coX1/QWBdvZ6tQ2hQvn0xX1nVVHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614656; c=relaxed/simple;
	bh=qxRAdtvSjiVNzgxTTc6ERQCXgQ4NLRC/YefAt29m7pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V9GJLvLFNHPuHg/qD8Ke/bfXwgRBtzdc1AF0Su4Q6xNmYYP/pFScHV3O0mSKSJFM48FUJlA98JU8Z8NBf4HVBs6rbyxuYuVf1dnGlZNGspqEPlycwmB9Ai5RNmGty/v/BI0+iX7RZqkqNmWSr4nZNvrhsEqc89S/wlO4bRpQhH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I/B3AeWX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438LjMtB019930;
	Mon, 8 Apr 2024 22:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=koDuQfpxUFo1k/ekgS+CUpvO88C5zUgz/+EPOBCXrTs=; b=I/
	B3AeWX6C+DC5WH3FhMOBAqu5cnWn0GDB8HuZKRr9jNy1k6PuyCTL3iE/xNnnT0zq
	6ktWCqqdxohD2PnOMYvefhjXqhVVM4J86PorEdAaP7Nu2zgMIgqa33cW78W8haQ1
	v7mjyUxVZwj5cdGoCaqMycyY7S5MNsRyIDvKoJiYqRzbqs/qMIV0Beo81ueJryz3
	5yirMgPMC9YPsNpqfSiAsbkDxN6OjzIGcjmQwXKQh0A6KTdOdsWhiPGueMAhFSfp
	qqu3yhTC89+aalrTa3a7uwjmkATj1st6ktOO1nPz+SiRVD5BQJ0SX5M2TExSDiiJ
	YTZoMdXhicAU/9HaKuzg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcr4hr3b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 22:17:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438MHSw3027125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 22:17:28 GMT
Received: from [10.110.80.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 15:17:28 -0700
Message-ID: <0935a9ff-34b1-45f5-ae24-ab05386d03d4@quicinc.com>
Date: Mon, 8 Apr 2024 15:17:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] wifi: ath12k: displace the Tx and Rx descriptor in
 cookie conversion table
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240408040547.837639-1-quic_periyasa@quicinc.com>
 <20240408040547.837639-4-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240408040547.837639-4-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XWpvWPya0WKDsszGlRsoDf23GIepc0oH
X-Proofpoint-ORIG-GUID: XWpvWPya0WKDsszGlRsoDf23GIepc0oH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=408 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080170

On 4/7/2024 9:05 PM, Karthikeyan Periyasamy wrote:
> In the hardware cookie conversion table configuration, place the Rx
> descriptor at the end. This will allow for easier addition of partner
> device Rx descriptors in the future to support multi-device MLO.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


