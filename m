Return-Path: <linux-wireless+bounces-6375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C30358A6875
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B08B2233E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1C127E36;
	Tue, 16 Apr 2024 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zln7zYJc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46487127E24
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263501; cv=none; b=JyiWyrh8IXaRgkOMNDE4Prr+Z4zulVAj/goURqVdSDZEP6NhYKsWysivcaDZtUsXb0txTeuC1n3wTIyAKLGU0NFYD835wtHOOS0dg7s2IB7K+ACjqGufSl81SKVeSyMZWSekK6vbki4TzgQ6He8jfvn0sZHDHH0r0pfTK4Tf00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263501; c=relaxed/simple;
	bh=ft9NgT6PN7pdnuVTTZIb9lOi47nAXcJTkfkAf6rARN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K76f4tPP9By/la2jR4U376egX98zWoVRavJHlMjdkvDpT1GAoOAABXjVXru9jnvier8u3j+WbS2tyj4fg1F3gmcaMnLUPSW2tPC1AbqUikiUSdcmoz1mg8oSHwf8aiaHspyXDXHF8wJw8NwHsYu6AidJyZdDJk8H1j1hpurb3oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zln7zYJc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G9OSL6029316;
	Tue, 16 Apr 2024 10:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ft9NgT6PN7pdnuVTTZIb9lOi47nAXcJTkfkAf6rARN0=; b=Zl
	n7zYJcGHps0Wt4Rm5c6gKESfMINK9D+700YoDJOn8/pe5ZTpoSxhAhWfbJw0xM6o
	x1w4g9p3yead/keqX2zOiMkwYw9Rptda9C7qbHrgigJ2sMsRRJE2Um825UJujnql
	Ms5g6tQcTYIAUVLipBV/Dzor8uZ+A1zLcuQNpwlklTjZW03EE8sfeV0ECUTDoQVs
	BT0NxHCz0Fzi7UiS1+w4IQzB/e49P22HQlhQCstJPX2RLFv7r1MhulMp9f6a7HkJ
	cbT8ozmjJ4TnorDjFSoivkI0APgJRyJ6MJ75a7rrCU/Fh/p/NPOj0ot2ClD9gIQu
	NOjlCAmXiybmbhn9MHEw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhpnrr539-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 10:31:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43GAVRia017469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 10:31:27 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 03:31:25 -0700
Message-ID: <9465c006-fa33-1eeb-f4e9-f926ff04bd1c@quicinc.com>
Date: Tue, 16 Apr 2024 18:31:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 00/10] wifi: ath12k: support suspend/resume
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <aea9f68d-4862-439c-a52f-d6463e6edca9@quicinc.com>
 <76ef11b2-c477-ff11-df72-e8d934c00831@quicinc.com>
 <874jc1yam1.fsf@kernel.org>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <874jc1yam1.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HyM3dsMeVCcEDby4XDIwkXhg3js7ajKO
X-Proofpoint-ORIG-GUID: HyM3dsMeVCcEDby4XDIwkXhg3js7ajKO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_08,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=652
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160064


On 4/16/2024 4:28 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>
>>> patch 6 of this series conflicts with:
>>> wifi: ath12k: add support to handle beacon miss for WCN7850
>>>
>>> So I was not able to take this series into my local verification tree
>>>
>>> patch 7 of this series conflicts with:
>>> wifi: ath12k: fix mac id extraction when MSDU spillover in rx error path
>>>
>>> So this conflicts with a patch already in the pending branch
>>>
>>> So FYI at some point you'll need to rebase.
>> So I should rebase after these two patches got merged in master branch?
> No need to rebase at this time. In the pending branch I was able to fix
> the conflict in patch 7. Please check:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=b92086862c7be6e6810eca204052cada50fc0f5f
Thanks and LGTM.

