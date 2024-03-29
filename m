Return-Path: <linux-wireless+bounces-5617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82381892331
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 19:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D429284876
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE6130E5D;
	Fri, 29 Mar 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NZ3RdQ46"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B381DA4C
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736207; cv=none; b=GA7itOIEK/Gecw9IOJUYCUurShby688CRm1WnF7xKp63WjnCjL+kkSJIniOyj5haLQruism0DLIgeaynNRjaizAcZnfX3Ca6CBwEr1F33RzEck+Fb6yBsLFOAHbi0TrS0JNY+XR1hDxNh6Yf1pGHqrfgP62EqpPEZsF/P+XyYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736207; c=relaxed/simple;
	bh=EVK67ifCVAD2ch7bb+EmqDJmNBIjIQZM5cVTfu9nBHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PhELqSzJBzBswMuhfiJvAtTCYAvcd9278ryAnN9K5s0ticBptSZq4IDhWdieNPdEUldi8MbNiUpl7PezVo/0PaV8V/UbXkITSU4I8bsi6Y5vPQThdOt2vsE6wPwX1KDcCGxgj6qKmJ6qC9yjilFb/PzgBC8qIFjkWI3PhhpZT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NZ3RdQ46; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THseLB010407;
	Fri, 29 Mar 2024 18:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dr/p/SBFDRBlZfBqMJFfIe3aS5XOZ9GBwJ9t/vr2iK8=; b=NZ
	3RdQ46Eo1/pnsx1dl+0Gjzq8WU52evEpC+VOK/S2GImphDIIvGZ0RLP1ag3/q8mY
	IjrNyPe7Mtv6d+GTkOUlKZamgPE8TpV9GDWFgBm2HHoSAQqTmO4/fMsWw231n1cD
	pwFIIbZ5lA5T5m4a8tTMUHbUVG0Bb3RLkjPNA+xZkJjCV/8zSo+bhhBD2D75QQmk
	tq5jhpJxhEwodg1ok+RqsBiNMem8heIjCBf/LB0Jxt3fKSE5KyHcZnFqOta99hQe
	LYgs0HVSNtTah6OFaF99TUN42DLM2dnkAAXjGK55jho4viKHzENl9+/ev6+8ovpg
	wEfpLlS1n3IhGLn5ZKcw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5xcy0kvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:16:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TIGgFD029432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:16:42 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 11:16:41 -0700
Message-ID: <f24ad7c3-85a4-4b92-87e3-75b45802ce27@quicinc.com>
Date: Fri, 29 Mar 2024 11:16:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] wifi: ath12k: Correct 6 GHz frequency value in rx
 status
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
 <20240329173926.17741-3-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240329173926.17741-3-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tqfWtZovy9fbqkeir2Rc-IYGT8UUH_iX
X-Proofpoint-ORIG-GUID: tqfWtZovy9fbqkeir2Rc-IYGT8UUH_iX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=779 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290162

On 3/29/2024 10:39 AM, Pradeep Kumar Chitrapu wrote:
> The frequency in the rx status is currently being filled
> incorrectly for the 6 GHz band. The channel number received is
> invalid in this case, resulting in packet drops. Fix this
> issue by correcting the frequency calculation.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


