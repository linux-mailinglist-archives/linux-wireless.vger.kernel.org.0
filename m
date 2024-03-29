Return-Path: <linux-wireless+bounces-5616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4839892329
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 19:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E438283B83
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E333DB8C;
	Fri, 29 Mar 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GdFlsLPR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4234AEED
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735757; cv=none; b=k1QWsxk6pb6DbZUzfp404QOdki8CUNHmKU+lh10QrgZ+WdU8ez/bGM4h99DkFO9UCTmtVoVtsmNh5OVdrgZSpoABZ+M2Gckfi8TX8ljdIdeWa18Qv3R9b8x3I9ppym0aLN6j+kczdHo2nDSnKiEV9ZD0ELO9oIuXy12Sqrsrqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735757; c=relaxed/simple;
	bh=GCFJi9MHCTvvJn34RQlGSvQfL+KM6l35iDA84lNXiVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q5iqtkLqLhdJSvvG3RCgPMyEfoGFZFLZKz3GMS7wVOPH0g2ZhQOS48NbLLzQAm3MGjy23TMvY+OlvlpKD2BXuN35wsZxNw9ZhcivxnYg6RNsQV8qPufCH8pih0RLmL2KaJafQeGDAB4rCbaHKfz5wvxQYkyNIy3OgZygHG8SFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GdFlsLPR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TI0EDK027938;
	Fri, 29 Mar 2024 18:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=I4TTYBJyRZxep2K/QWXTyYve76sM9egdZKsbk3RTkwQ=; b=Gd
	FlsLPRcVkVhduFdMQF/Ueol4JbpiYNo6nMPkEJWTCMzkYHdEUM8PV1m1+/fEKwxp
	QPQxac8QuhsN91md7M2D6beuZXpG40jjA2Zt6SUMMCkaBLjdVoyBqcsjslOzoPC/
	G12theqA0HyndPLJ357ptkpWx+YOu0V7RFVUCSBh8NVBGPkQ7uOnf2yoyNulEW7k
	BvfdKvwM6YLaxBHwj7z407ZONNmxOu3l7JjXbSKvtv0ONxfk7eRjZ1KoABQemxNj
	XJG5NarcSKdEb0Ou2xOZbfbLXCmCJNVDKIOXujNUKW5CxeadA/rmzanwODqk7CTO
	0or4rq/ccdhEsQSEtzQg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5vn98ve2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:09:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TI9Dir026721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:09:13 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 11:09:12 -0700
Message-ID: <05bad09b-c5a6-4478-aa9c-a5a71176c203@quicinc.com>
Date: Fri, 29 Mar 2024 11:09:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] wifi: ath12k: add channel 2 into 6 GHz channel
 list
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
 <20240329173926.17741-2-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240329173926.17741-2-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0XN9fXctRMHdWUk_ilGnzsCrPpXcVztF
X-Proofpoint-GUID: 0XN9fXctRMHdWUk_ilGnzsCrPpXcVztF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=843
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290161

On 3/29/2024 10:39 AM, Pradeep Kumar Chitrapu wrote:
> Add support for the 6 GHz channel 2 with center frequency
> 5935 MHz and operating class 136 per IEEE Std 802.11ax-2021,
> Table E-4.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


