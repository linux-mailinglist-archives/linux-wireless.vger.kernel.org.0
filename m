Return-Path: <linux-wireless+bounces-2589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2926E83E874
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 01:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FB5284FCA
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 00:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2C39B;
	Sat, 27 Jan 2024 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l/Vqa1AR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6229370
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315254; cv=none; b=q23e8hl2qvRKFUuUktvC2CSzWtfCSWYIz1XYuE0HsWEg+cgyiclTQDU5fUIFcI/lI0HmuM5ldqpuuN+1iWlegw353KCykeMh4lb42r7uCUgRDntiK/XMCk1ab3sCPOtCYJRGiT96q0Heurv0tKjF+Nf4YEMluQRKC+d1Gm4SXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315254; c=relaxed/simple;
	bh=KuOGzQyPcHqoznZQm1ZtfI4dvZMS4/a/6UllfNa7uK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hi25fZIF0sbkjg8VfMQtvYuMcCgs7Jcu+NPXM+xhxg8Tzt66245fYYYwLRiQYGg5qHGxzNmVH7o9ohItuGubDG02bpHYquCeTS7/TUIJuhYP7X7Mn9v86Y5CX6qkGiQKY8psaOzmCXAcUdGU6m5t7EfcFkdYvgrBXMk1skWkA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l/Vqa1AR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QMjRKR004509;
	Sat, 27 Jan 2024 00:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oYqBeE+d7Jkv9UDgvNeadLc+YD8wc3vcZYOX4duMb8k=; b=l/
	Vqa1ARnO+LWjuYJXPWKotFrm32JsIIboL3Q7V6FOSKUDJjNZrphTBg5nNiHzDvB2
	Vr8H6XSy0SEYqpOPzwPwWsasQo3UCFLVH7/aVeUiGnGUGkZ+LqJOBO9EAqnNt8vP
	Xud36O+suUXu96R6c1/hPu6pn9psp9kxP5eQEvXcXXg5tVH66qCYVcZTt4Muq3SL
	oXjUsAHofNaqOgm8Bx6deRXonuC2zm6pOlVPn60bj+j1moIaWfEWyvc6Kp4oQErs
	77pARVc2EMYQeoO0GxoY0ROjoW4I9XLAOIBbUieHd0TmfT2VUEw2Dtx1mkKDb4qu
	U4b2LXRM21x8vds+Vs/g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvgy8grsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:27:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R0RFk3001735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:27:15 GMT
Received: from [10.110.0.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 16:27:14 -0800
Message-ID: <a56065cd-e531-4fc7-955d-2bbff46ef82d@quicinc.com>
Date: Fri, 26 Jan 2024 16:27:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] wifi: ath12k: advertise P2P dev support for
 WCN7850
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
 <20240126115231.356658-12-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240126115231.356658-12-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wvrtcdmm7rJFsbqF2X-wkSGNOd7OFu8i
X-Proofpoint-ORIG-GUID: Wvrtcdmm7rJFsbqF2X-wkSGNOd7OFu8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=517
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270002

On 1/26/2024 3:52 AM, Kang Yang wrote:
> Now that all the necessary pieces are implemented we can enable P2P
> support for WCN7850.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


