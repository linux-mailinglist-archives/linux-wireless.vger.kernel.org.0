Return-Path: <linux-wireless+bounces-2581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FC983E818
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 01:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FF1284E5F
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 00:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625BD199;
	Sat, 27 Jan 2024 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e6w0t7kw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D293318E
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314498; cv=none; b=jg7L28zN/E3x1g7742ZzSoPBcJYXaDup65TBw/p37RGixAbI9zWVHsgTZjpYnRB/bbBBAqiuGBWle+g0KmTikBCG6ks3XKjpBisjUGiax01I7UZvK2+lOseK7vVTRrvS8XOlteAVM1QsRQqOJkdUF2YXBfC8nlRYp4qXhK/fYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314498; c=relaxed/simple;
	bh=a4FVZbcSAbB+T6h/RLkb6dJRxJbGNAiH73+gBZ2Y4VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ftgOSMtJ4WwHWW9SCSI1Ds+NFADlMBri+XBmJAvMHFX2XRmYLp7CP0NOwRSzCMV3+UrFQbiCPmNQe4LQ9xWYVOx/DjzK9bsU0w94WwLeJd7zCu9D/IGrBH/Ws8qoO93ksuvw5gFbC3Jq8Lec2vR8BKWxX0YmAF2O97cQvoWkC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e6w0t7kw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40R0EruU028044;
	Sat, 27 Jan 2024 00:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Nq8trNqA5rhUqeQlwvfDJOPIriZ8I0jPzHKpy56Kzj8=; b=e6
	w0t7kwsOASiyyvAgBikNlRBf2bAC1+tmJuEEFxy43fH2ey5R1v95QgkqXzDgN5pZ
	EvFSbZqXwsrIoTzwSEA51ZYH5fsgHdJ3R5p/zr4K1FqqfAzUsGQgYrCOwoaPWjan
	Lwr3GaV27zXztiwDitZi8up+DIOOKdto2YwTQ3WJ4ZVtAjrrvjOo6aj5mIvR7kEj
	0W+i7Mvz0zgfqce2/yo8JTkQyP5oUydBpBMCIJMHY58ZzrOgFNjxX+bQZW2f2AmT
	JDovTqdGUq0sybnYfKntIRfMhzDdeI010CmCfZ8U6F0+3aA8hxmqV+6BWlziKpme
	dYvDOxZhZY2dXul6ftYQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv6c8j74q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:14:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R0Eqwe032656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:14:52 GMT
Received: from [10.110.0.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 16:14:52 -0800
Message-ID: <804b00d6-992e-4446-9855-79a392ab5a68@quicinc.com>
Date: Fri, 26 Jan 2024 16:14:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] wifi: ath12k: add P2P IE in beacon template
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
 <20240126115231.356658-3-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240126115231.356658-3-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F_AOda4pHZWww9XWMv5GL5z9d7IhpOK4
X-Proofpoint-ORIG-GUID: F_AOda4pHZWww9XWMv5GL5z9d7IhpOK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=832
 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401270000

On 1/26/2024 3:52 AM, Kang Yang wrote:
> P2P Element is a necessary component of P2P protocol communication.
> It contains the Vendor Specific Information Element which includes
> the WFA OUI and an OUI Type indicating P2P.
> 
> Add P2P IE in beacon template, and implement WMI interface for it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


