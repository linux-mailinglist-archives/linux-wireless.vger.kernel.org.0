Return-Path: <linux-wireless+bounces-2907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A65EF844964
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74661C21544
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331C208C1;
	Wed, 31 Jan 2024 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XngjLnKV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602938F8F
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735219; cv=none; b=AxQ9jjEHyyiLDns08bzEwIxv/K71cDCB6eJIwLpCM0zDlT26BYHWBjDH0BQm/LI7ZOWqpl0GUZSnLRnAPB+BePtWkgl6CKcR/0k4olAERyYAf7+2N3y0FI6owGd78FTIbfLsfEgV1TY4VU1fUYWkydEE5LXgc3oXVqm5+L3nVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735219; c=relaxed/simple;
	bh=f9X9txjX3uSMF9+CnCYy1rPoihtfrGV1bgg/OEg8LEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WBowOXcl0NGU46+p+hY3KNXpVDFK4xerMeo2jXABcPs1hzOqcuXOMFcNHMR1+J9eieODKpGlyCTX9t4FAIfcGxivWKcBZxbK6vn6hUe7m3+1Km/ftbXJ3kktk6VhbNlsPqIVzJOzQXF9hL7MgS4WI7W+Rw1w/gkyNmXCQT2y0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XngjLnKV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VJ0SxK029897;
	Wed, 31 Jan 2024 21:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8AdCxjrmHEg+OzU5QxypPVr6TDOJpA38ZPy5KupGHYY=; b=Xn
	gjLnKVvSBmt21oCjmHRIomjjhytbgUDTaY/Ht+E0wKetQ5pGwy9gRNFHssMU7dxF
	VBtbdjRvXiiN12hzl/b30H7MyUlSzMkMvnsolweKcGCHFfDGQR/FEG2coZyRIA42
	JN/JOppxWUWqx3jolMumlaqAMN7nG51ah4jmcjM0vF9FC978Vw7t7LKwGrQ5w+ji
	GGSKpcWnZaGiUaUggrKosRTti4SRT5JpfYQj+HTg7uas0F8txi8bxi01G1Batz4u
	X/HVnUwT8ZvTW0A5HqTFc6kLnDlsBSSDmWqaxiXQVuEcshCA4ujn31UBmacVG+8J
	gXE9tH9KdDwapFGjK86A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyj149xgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:06:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VL6re8021712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:06:53 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 13:06:52 -0800
Message-ID: <ad7d59ee-a43a-4f3b-862a-2193b8e4259a@quicinc.com>
Date: Wed, 31 Jan 2024 13:06:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] wifi: ath12k: fix firmware assert during insmod
 in memory segment mode
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-7-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129065724.2310207-7-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H_cFOyrX4S9F_c2UNf7wp5CNIvDNZiaQ
X-Proofpoint-ORIG-GUID: H_cFOyrX4S9F_c2UNf7wp5CNIvDNZiaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310163

On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
> From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> 
> In segment memory mode, firmware allocates memory segments of size
> 2 MB. This 2 MB memory is used by firmware for the number of peers.
> This number of peer is sent from host to firmware during WMI init
> command. For single-phy the number of peers sent is
> TARGET_NUM_PEERS_SINGLE = 529 (512 + 17). While for split-phy number
> of peers sent to firmware is TARGET_NUM_PEERS_DBS = 2 *(512 + 17) =
> 1058. With this 1058 number of peers firmware is unable to allocate
> memory in 2 MB segment and firmware crash is observed.
> 
> Hence, fix this firmware crash by reducing the number of stations
> TARGET_NUM_STATIONS for split-phy.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


