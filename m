Return-Path: <linux-wireless+bounces-6880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB7E8B2A90
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 23:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BEA8B214DD
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C0F153BF2;
	Thu, 25 Apr 2024 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="THuOPsRO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9A2149DE3
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079793; cv=none; b=mEhFJmTZGJhaetW19iTBZ5Ugvs/KY8qk5DZ1BpndciYYZlm5kIIiTVXJN2dTKM20RlPd30EUYHrIXAuZBbN989jYQLsRODoihP73P9yPnLqk+lEIdWs+dgajJaLTMEhQiHMM6qZ1CviOlMypbAwtbPeFlWBZwtm9Zy9gJfDttGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079793; c=relaxed/simple;
	bh=dHCUR3liH2Ibxu6hxaHk5/LOnt6pHLHGP3mTOv4aOaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FucVk1LzNz+BBrMOuDV6X6HOVNrwVGoOxqkD65HhK0AmkcJg5KXQrnD+hnkWg86TbXprjnmf0yw4zdrudtAa+ki2fLzU04rXnbfeCdtiJmneYJGZClKTWRFxMz3Lb8uQcffdj0ocTqi3Nj6AJGhKx0Rfs/ewpfTJ3v2CrzFfhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=THuOPsRO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PLBEqI013148;
	Thu, 25 Apr 2024 21:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rxGSDVvQ1FZALIQBbXM4Ytp4HFywu6rbTy1+umk7Szs=; b=TH
	uOPsRO7ZZ2e9YluzjBVCzog9iAqQqlHZ4YnuJhAwOmMPKq4B5X31NH4OJxNagEGR
	ZcN4B7tNmKUsB3QGSQaAuuFH7di7J+1V+TSahTwdSFhFybY3/J96sk0yh3jqDGn5
	KeV1xVRVKOY2dEYfOypieDaCLqP5PekRLDYcpl1MfN5bFVgBsiAZMIlIWoGody/4
	Shrxuh1xzP5GlHduc5J7yc46Aq6c8gYz7jm2T6I/c0TO6eI3whDlG+Rqn4z4ZQ0g
	YEOAh5xTiEv62jPSyo+dhf8qmJL5zd5KX6y7OCzlg1aC86u03QVkqx+QOuRBLJcK
	PaTC+8r18sd6zAOUOH/w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqtph8khs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:16:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PLGP1k020602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:16:26 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 14:16:25 -0700
Message-ID: <bf8b66d0-5d9f-4df1-a867-81bb1e3cd9bf@quicinc.com>
Date: Thu, 25 Apr 2024 14:16:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] wifi: ath12k: Add lock to protect the hardware
 state
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240425090307.3233434-1-quic_periyasa@quicinc.com>
 <20240425090307.3233434-4-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425090307.3233434-4-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 22uEt75-NkBI6KRWYU6BfiVENalMfIf5
X-Proofpoint-ORIG-GUID: 22uEt75-NkBI6KRWYU6BfiVENalMfIf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=539 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250154

On 4/25/2024 2:03 AM, Karthikeyan Periyasamy wrote:
> Currently, hardware state is not protected across the reconfigure
> operations. However, in single wiphy models, multiple radio/links is
> exposed as a MAC hardware (ieee80211_hw) through the driver hardware
> abstraction (ath12k_hw) layer. In such scenario, we need to protect
> hardware state across the multiple radio/link at the driver hardware
> abstraction (ath12k_hw) layer. Therefore, introduce a new mutex in
> the ath12k_hw layer.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

I know there are concerns with adding a new lock, however this design has
already been productized with QSDK/OpenWrt, so the current goal is to get
upstream on par with QSDK/OpenWrt, and after that we can revisit the locking
model.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


