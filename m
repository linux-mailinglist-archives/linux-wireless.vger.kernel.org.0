Return-Path: <linux-wireless+bounces-2194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A239831D24
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 17:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52ACC284FA0
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180AA2C18D;
	Thu, 18 Jan 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V2m/5Qx+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985632C183
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593782; cv=none; b=gsK7d8+3KZOWAaRb5ToM9pp08Oq92/ODhbnOG0Q4IJefHwIcHsZ8kLzUyqkuSc6tJisiSD5b/S8fZT6a4i3MY5I2cNiNdHoxMXN7OtVEHUta6gu5vMX6NRgmMwW9oiYzII9zqF7x9EerXb4I7KB8M5xnIRz6KpWPSLt9oXRoaEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593782; c=relaxed/simple;
	bh=H+rHfk87s6FAIoklaEjBHeqxGCqoP55wZ3XDAMjlhnc=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=pElFBybb1NoQFWsnGmokZoxCPlfkv0ImyfxmLx6zm2a3LbTlLU64bAQtnJlfQ1Ugmqx4ejKSYEGTpQhYnuGuf8LsgBqLwliXqdHkILDO2x9Yl7Q47asB6GbZlTWAxsVFda8MrfdfRQnDqLP2+2E3x0okX/dIjjLJdulZuGEaThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V2m/5Qx+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I62LLL008862;
	Thu, 18 Jan 2024 16:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2/c3cKyx1hLO3tyFUUGCn9PRx3UYBx3Lah6nksrs3/k=; b=V2
	m/5Qx+CFPycIoqxO/IZIQDvVVeIFGQYt09GeR/eYNqs5KlLyH7xpSvAmf2JaeYwT
	cZZkhOUFBpoyx93j3fSzV0Wp4vMoF5oZdptTDRoSL3RuPvg7oaPIkjMWHsw3LjHm
	ZktoBwfz8aq+Pa621265s3+TMh2FnwsZ0IIw8b4n0YqAoHM32KSEbXdlxN8AeEJI
	nPE1/6O3XgcCQ8NsJgw2AMeFG8JKvJDCiszlskSK3+/p4dTfd9766KKSYOcI6ZlO
	4C8x+WPpikv7vV9kJLRrtQcGxDTIXCjvtkVSogbuizUc/dxcpBQWdio8NwCEZxKG
	9dRk8rpWOnvACWRoWheg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpx8shfb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:02:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IG2t6r015993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:02:55 GMT
Received: from [10.110.99.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 18 Jan
 2024 08:02:54 -0800
Message-ID: <ae765cc9-31c6-49f4-8061-5bc7671e36a8@quicinc.com>
Date: Thu, 18 Jan 2024 08:02:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] wifi: ath12k: Refactor the mac80211 hw access from
 link/radio
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240118010320.3918136-1-quic_periyasa@quicinc.com>
 <20240118010320.3918136-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240118010320.3918136-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CKDY6Sebcv2KBEhR_HZAN99-GpagChOf
X-Proofpoint-GUID: CKDY6Sebcv2KBEhR_HZAN99-GpagChOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxlogscore=568 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401180117

On 1/17/2024 5:03 PM, Karthikeyan Periyasamy wrote:
> Currently, mac80211 hardware accesses link/radio structure directly in
> multiple locations. Introduce helper function to avoid this direct
> access, as this change will facilitate refactoring for Multi-link
> operation support.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


