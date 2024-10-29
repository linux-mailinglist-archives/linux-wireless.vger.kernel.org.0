Return-Path: <linux-wireless+bounces-14641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6AB9B4D4C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293091C22715
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE541917D9;
	Tue, 29 Oct 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eMQXxVDu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24D1925AA
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214879; cv=none; b=o/8IAcA4uo0d+B/reh4MReSg/H73JGX0ozM3txbYh6CXMSdBGm1c3/Otjwduh+nk4iv5dvhIpn1myQsP4aryUSUi5BW8RAaU2QWa6WVs+awJCBZgXJSMqMjUjuAsz+wxeWvfWvEKRIW9yWM5l9g62qf5JDUwpo399lHMoydwgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214879; c=relaxed/simple;
	bh=3Gn/ka6EM4x/fIgRAeXu0WhypBhIu9nZMC63TdremcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m0cSevdEWtpF8jgmC66oifsG82mEETqe80lB2iEZySoqXOMy0eW7tyfLQtqMGVAO9Tjn1NCI0xk1+dL/SO/CdLmojfDd1V2Ru0tkYLFCNXAGVUK+z5CQoAx1sBhJt3ISuciGjtGbD/ztrUCq8Sw4BmCcBVGoshcu7wRGU5i0XNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eMQXxVDu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T9plcu011999;
	Tue, 29 Oct 2024 15:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N3MdcoipdIRnK9+Ca03jplOSa94F+Bw1qnqwKNtfxiM=; b=eMQXxVDu55ankXke
	lfh8wmcOKo8G7oOVfFggMoM+DkGLkfVT7kwiZGkrKhTke7Ik+wYhFQUZrsEYli9L
	kLLnRf8Y88ab7QWdoxu8xmNlt/E6D4dR92KuDVIpnK66L0e2vO1aCwNvxBj+RI62
	/akxpInsWre8VlmDCQ3gWQBqsatIpM0vSTE9g9DmX8FRZhZifbLrMUOYFe++J0pX
	6qOJu6tkqooa/4N0G2Po5wz/UXph/IBT50EvABeyBeJznNYVM5DO9W3530oRjl/i
	94nuaio8x7qqkJfmpyRi+pfLbEd42TwgLO4JO46f+oIJogtY37foJm4OEy74rV9v
	wDAZbA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gr0x8teg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 15:14:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49TFEU0S017634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 15:14:30 GMT
Received: from [10.48.242.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 08:14:29 -0700
Message-ID: <2373b563-5866-40f1-8ce6-cc8e59df1adb@quicinc.com>
Date: Tue, 29 Oct 2024 08:14:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Suspend hardware before firmware mode off
 for WCN6750
To: Balaji Pothunoori <quic_bpothuno@quicinc.com>,
        <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241029083340.3010798-1-quic_bpothuno@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241029083340.3010798-1-quic_bpothuno@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k7N0lI4B_AABewCTCeJVrhos3_YJ7LpK
X-Proofpoint-GUID: k7N0lI4B_AABewCTCeJVrhos3_YJ7LpK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=851 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290116

On 10/29/2024 1:33 AM, Balaji Pothunoori wrote:
> During rmmod, the ath11k host driver sends a QMI MODE OFF command
> to firmware.
> As part of this command, firmware initiates WLAN de-initialization
> and accesses certain UMAC registers during this process.
> Currently, on WCN6750 WLAN hardware, the system is in a sleep state when
> firmware receives the QMI MODE OFF command.
> This results in a firmware/hardware reset while accessing the UMAC hardware
> registers during sleep state.
> 
> To avoid this, add logic to send WCN6750 hardware specific
> WMI_PDEV_SUSPEND_AND_DISABLE_INTR command to firmware prior to sending
> the QMI MODE OFF command.
> This will cause firmware to cease all activities and put the device in
> a powered-on state that prevents access to registers which have been
> powered off.
> 
> Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


