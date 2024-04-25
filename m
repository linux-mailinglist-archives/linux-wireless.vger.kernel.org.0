Return-Path: <linux-wireless+bounces-6879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D7B8B2A79
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 23:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8C91C22226
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 21:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22126155336;
	Thu, 25 Apr 2024 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cg3jO6Cx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7637143
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079483; cv=none; b=RmrEeUgPzTtew4Yx/NxVdNob9kc12gz5opjsoYhciGcLgQzgW5owFFzAxJNPazHRSHg5V4BoumDQqFKAoCFwY/gUjrX2Tc+uRt91UzCZTI2cnsers2Fg7EV2OdeTD+7lvHNxcFO986AE9rWqO9ald8Wot7sVfFL1iaAzbykeT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079483; c=relaxed/simple;
	bh=zB3BJ+hCkvD5yRuBfyXRYuvNrc/glhpdy85Pcv27Ssg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bOSlykqibadBPT3jhgKPHtKTrkjazavuHUnjpJqbXE0xCI/9nmwZ5jV10ZBWXtacpBwdFCCeWMjwMpVKD2bQYUUlKVU7h3DsPrsKass/x0jJJbuBHU1ok1LZmSZTS96hLe36prJU7nXGEDxHCUYdsog8wzvLSNfMGQFfFfeBDY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cg3jO6Cx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PKdkEX013627;
	Thu, 25 Apr 2024 21:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=N9zebjNukAn603CxHTQw142WIlEvJ7NuTANKadwCDGI=; b=cg
	3jO6Cx236P7fRUqQz0FlD8umgTVWgRTJ/TEsVOJbBcbDMqAFIzBGi3hqg84ooP2g
	+FyoBopydcHZz0HGmZpea5IDZwzBt6Ph5bIYgeOeNKQpn0AdNaKx+/8mJhAgsKu8
	qaY05uW0nvd+Hsl4RIlr98MqTz/1L/gMQPLBZomyuDCanACVOohJKTgo8kw4DQ9q
	l3ipd9pcIoPF5IJsRmeEnQ8d3wobO7W+gBlq1WskWC8/67+xmwbi/WGZt+csGUM/
	ehWAuMc8cG1nQlnCWVwa+aWI/rqUaZDS9+JeQcC/e6ipUXhpqC1bBwE2YbWjQX0U
	LatG3aSzDSzg2+UpG+Zg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqengkr9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:11:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PLBFjI031939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:11:15 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 14:11:15 -0700
Message-ID: <60886a38-52ac-4b4b-9119-10c0473f3326@quicinc.com>
Date: Thu, 25 Apr 2024 14:11:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] wifi: ath12k: Refactor the hardware state
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240425090307.3233434-1-quic_periyasa@quicinc.com>
 <20240425090307.3233434-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425090307.3233434-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AEmlITDFAWrE3xhN8lEeF8QctvBxsU37
X-Proofpoint-ORIG-GUID: AEmlITDFAWrE3xhN8lEeF8QctvBxsU37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=605 phishscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250154

On 4/25/2024 2:03 AM, Karthikeyan Periyasamy wrote:
> Currently, in multi wiphy models, the mac80211 hardware state is maintained
> within the radio/link structure. However, in single wiphy models, the
> mac80211 hardware state is needed at the hardware abstraction layer
> (ath12k_hw). Therefore, move the hardware state from the radio/link
> structure to the hardware abstraction layer (ath12k_hw). Additionally,
> update the naming convention of the state enums to enhance clarity and
> consistency.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


