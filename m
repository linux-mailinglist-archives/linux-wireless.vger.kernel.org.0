Return-Path: <linux-wireless+bounces-2335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D07836FA1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 19:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F781F30D79
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 18:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAC43EA88;
	Mon, 22 Jan 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BWlPRqfM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE63EA69
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945706; cv=none; b=QEvOfZJ/3e0ZYHgO5Nu+cOFsWq1YSDvCtV4s3/rHn7g7omSZgxg1ybJoHDYD5MZQjbnREefw2I/V+0/4NIKS0R+eSfAi0banO5mNB0VOYcu0Kog189PR4HCa217I+b8McSYD2M0z2Y3OL8YR3CvE03Bv34XapyOj6dIdrmqToPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945706; c=relaxed/simple;
	bh=YBeB6YSEa4WZsVF6NoHNYckEPVqWxf2qJxDTBqt1DYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WMEQtZx01OTLLzr+Z4hj9nnd7y7iknsonXTc4cNsNPXPG3Ryoifm78JRLvFQ6bSI7UjcDWcVUJVRJsi0yIZPdRmsDWcd8bYkQYsj7MdTevJVe2RXhsBiUw1R+7yxxCrL4AIQABPLpadNkbTIk6tjfzCQl+Nv6MELr8i9XkZL8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BWlPRqfM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MEvNTh014268;
	Mon, 22 Jan 2024 17:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=skADsusE5cYMrUI6vixhB2mBE0F8QCvNnRSX6mz4n2I=; b=BW
	lPRqfMxVKzllUJ16yxV7s9piBJaYC0OUPG3W+b0ZpmabMtHaMD3qYBrch1yL12LP
	9MRm3Mb9HW1DRYyov8+Ly9aHA0NW0HMazbaE4zLZe5SIQOu0Gs2nF1FGOQ0wQiLk
	524lJX8wf5mwTGP8FHUKhelNIk7H+wWcm8L5yhA1Hg30LlEAYA1IgMb299RYAplN
	SagyPTQXcnQQR4MkA14otzSJxobjAaEabK+qgAtopErY9mrv63cXhkTicURY6fvC
	VdRWr3o6EgSNmiDABSwhd06EZDbmyASeUdALSFwC3xX0hUynAVeDuuOCe8U2cHgj
	HoIb5CfOl+RDLVc1JoWQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vssw9gg8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:48:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MHmKSV022172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:48:20 GMT
Received: from [10.110.26.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 09:48:19 -0800
Message-ID: <f410e661-e46c-4ec3-8775-fe80f26418fc@quicinc.com>
Date: Mon, 22 Jan 2024 09:48:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath12k: add processing for TWT disable event
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240122085336.3985-1-quic_lingbok@quicinc.com>
 <20240122085336.3985-3-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240122085336.3985-3-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7yOyQSXJQ4Qso2Fa-BAvnHlhiQ2cCzvL
X-Proofpoint-ORIG-GUID: 7yOyQSXJQ4Qso2Fa-BAvnHlhiQ2cCzvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 mlxlogscore=646 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220124

On 1/22/2024 12:53 AM, Lingbo Kong wrote:
> When ath12k send TWT disable command to firmware, firmware will return a
> TWT disable event to ath12k. Through the analysis of TWT disable event
> status, we can easily obtain the status of TWT disable command. It can be
> more convenient to debug TWT.
> 
> This patch works with WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


