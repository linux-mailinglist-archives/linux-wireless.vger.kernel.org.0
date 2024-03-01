Return-Path: <linux-wireless+bounces-4297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6157E86E5A8
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 17:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5B63B2552E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB062900;
	Fri,  1 Mar 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="icYIQHBG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A772571
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310750; cv=none; b=hgGcorbIBUMvCwuwNPKd9cbWhNxYuFqq1XCJHF4StIQDDK+hXdnXr7lqbpQ6sVBaZO9VkKV3AsbmU+xSVp5M9LSQhQd2bK6d8LZvbfxFK+Am1zDN0PN8jBMGafGplobuPpaGXbfQMPC/2mZSU73/WqaWldO+YA2COKF+JFgoenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310750; c=relaxed/simple;
	bh=A+ukIUKU6aBcTiWaSYzzRhilA4Ef+6EVlJnNGCB7UiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g5jOC7wC+ClHOpFVK1qyhwdSP5z8VPCTHVVcsRWzQ46Ta64KMYOCraDdH6nhcF5Vt7TYOXHQzEN1Q1eo4IX1kXCUHUEAMia7YI+JghnVXI1Z67fXrmSu+pseG0tCprJLasDd9zSyzvBjTpjiKAvDGbaEF2DHumwJ+0moOPL3vic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=icYIQHBG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421FxhnG010343;
	Fri, 1 Mar 2024 16:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eSf337a1gJtu6y6yeLmG/RPIJD+iwTIvRdU9+bSmbQA=; b=ic
	YIQHBGzyRezMw2j+mFhfDtmU3JKJR97JqqYTprPtPu9zYivLBH7ZsyBffXb379Ji
	NgQ2V/AqjKc/f0/pjHs7jW+SYZLIZdBy+a67Fxm/T2yUeNCK5ah3aPj+SBa9UXmW
	Tafoabjguo/vXERnBfoKfeeEPhVEm2iDl6w5LRtAFBhEo7k5GcsbeSdo/5U7KoTT
	YnqqDZ3l/eYbxt0R19TyeZfd22SIkyG5FAw6e7GoYitco7DE6XsJTKYX1ctDKc91
	Dt8ziMl+w6X/fxYY7plNe3JydtQqQLVxho9ZvajNiOr3TXtqMJ4bZMbhmXGQmKO5
	JkPn8GLkAb0/fu5qr7KA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wk4rvt1y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 16:32:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 421GWOt9003675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 16:32:24 GMT
Received: from [10.110.42.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Mar
 2024 08:32:23 -0800
Message-ID: <6d02fd91-73fd-4438-8e60-427eb5c9198b@quicinc.com>
Date: Fri, 1 Mar 2024 08:32:22 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] wifi: ath11k: add P2P IE in beacon template
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240228093537.25052-1-quic_kangyang@quicinc.com>
 <20240228093537.25052-3-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240228093537.25052-3-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gGosYOFdXuO-yGNze7YwsAfXMNkJrL6I
X-Proofpoint-GUID: gGosYOFdXuO-yGNze7YwsAfXMNkJrL6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_17,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=965 clxscore=1015
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403010136

On 2/28/2024 1:35 AM, Kang Yang wrote:
> P2P Element is a necessary component of P2P protocol communication.
> It contains the Vendor Specific Information Element which includes
> the WFA OUI and an OUI Type indicating P2P.
> 
> Add P2P IE in beacon template, and implement WMI interface for it.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.2
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


