Return-Path: <linux-wireless+bounces-7486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BD78C296A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 19:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2AD1F22A72
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 17:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0F918654;
	Fri, 10 May 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YdtreYTY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2AC18637
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362798; cv=none; b=DFe0pLv2+X3IR6+RXh+aYyHLkipIG6EnsIjn5G39QPWNk76Sevh4rc7ZLCvtWUA01Ej9oT742e4rDRzecehzCriJQAP8Hz80ilPeq8cAgetbTPNtIn8Wplc9Pjl3OjgelcnDIqf1wbYg95EbMeiumD9lzm1DtLDqhFecawkNdi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362798; c=relaxed/simple;
	bh=elRYqIyWkR0V/hTWv2cAXi53eEbH9stFdFOTZ8fB3uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tgJFvmpegfOI1JTK5yqQOhlmAYJQ7USECYzUx07JIsKAk78G4Z3rbaRALvRVdyXHf9VF+4snHZ4De6RgmTmFFiBVWoG0v3EGmFdh8Y2aIrgN8zgo/5g8TlbUtR08nAHE31bb27IXwNWpypjQNMGSYnkuHw/CFQiJ4GYDcsKgGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YdtreYTY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AEKpxx025185;
	Fri, 10 May 2024 17:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kGB+dS0507lWvxd5R5gdo5SC59hSKHNNAU7QeHTQZx4=; b=Yd
	treYTYYf1y4R2libuDldDMU+9uCNRgn0zgsVSjh2qmbg4DH2oe2lELLhCWSVx+AR
	05/lEujOh0jq2xt7otP8LyFu+0tLCeyzohbFJRXlIxORi0gurPIactA6CLDpq756
	Y1h+A4ghwho/p+Rbu7fU/MoW3Lvad1SXS46dF+JImLbfmQKjaCJQtnl3BxkXXkoa
	iNdLWN9PO25lzwvc1K9oxu2T6+ovxc9vBA3l3rc14fvcxbmH+3PmQ+yaOB8TOl7b
	uvSavxxCNO96HPeXUiMJACRtbymX5iFKZ9kC+MEn1yDxXqtz81GN9ocdLla5hOo1
	a/aZuinLtQmf35uYwAmw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w2a33y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:39:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AHdo1i031078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:39:50 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 10:39:50 -0700
Message-ID: <b71eb68b-ea0a-4405-af12-554025160a41@quicinc.com>
Date: Fri, 10 May 2024 10:39:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] wifi: ath12k: implement hardware data filter
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240510064748.369452-1-quic_bqiang@quicinc.com>
 <20240510064748.369452-5-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240510064748.369452-5-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WdYPrvmQy_1CGx_XPW12PW5xbe0hYC95
X-Proofpoint-ORIG-GUID: WdYPrvmQy_1CGx_XPW12PW5xbe0hYC95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=816
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100126

On 5/9/2024 11:47 PM, Baochen Qiang wrote:
> Host needs to set hardware data filter before entering WoW to
> let firmware drop needless broadcast/multicast frames to avoid
> frequent wakeup. Host clears hardware data filter when leaving WoW.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


