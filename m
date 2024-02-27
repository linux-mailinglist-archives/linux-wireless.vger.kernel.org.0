Return-Path: <linux-wireless+bounces-4045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B99F28687F9
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 04:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72684289FB0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 03:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241354D10A;
	Tue, 27 Feb 2024 03:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pTdbxWmA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4084D11B
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005582; cv=none; b=ZnfhXpWLQez1rQXL8l46xoRhfx70qlGIcuTpByjg73Sb7HgBQ+LHhqq0/l2dibdyNCxzYtbVJfDhamO4wOudxL9dHQ+0rZIBd2XOEh5tsbmUfEo0olV8eYTRVY02QzBKeXpOdKCS1GdaurEHMNdFbsqoEUvdEo+HdErWNYLeUf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005582; c=relaxed/simple;
	bh=HYTIRWQJd8dW5pDyMzuFvSQrc99QfvMn2nLmBGGeFLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qQXi9BkOmq1i85PMpnoVqfLgmRVsXnx4vI5vROF/3ES5yHo5HuKS/l9mB1aHKpl4LIysmn4tLklITpQpshtd7MB/6l9K834k6Dn/kqjB8p3S2w57IVsHfVs153sMfbsTS3rjD7h29bjTSp4M+0Wm3smwVXRzoprVhwybhkkP49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pTdbxWmA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R3CCtX013851;
	Tue, 27 Feb 2024 03:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iFRCUoDiSjcwAOVG1YaWHUWRrAIfaro3M2rEHC4hU5c=; b=pT
	dbxWmAmkUPsQJTsIofK3zOOWWUurC016Op7BbTZQmYQbf7bJUoyoTckpmQhZdeix
	7hh2MD4VSYxyGhrHyfUv+T/jxP5NmQqyxaTUOQHLrPbt7+f270vlJCjwE6gAhlYI
	WfJFLpcaOPzouwA3P3W3krCRPmBt1kjwrtQvzkzWDXgDLcCVIO7I5aGeNsamCqDQ
	Iu8e5Dr+HrMkIptXFWkiM23aNVctgpnqyXFv9vQ0rxLICOcB7PAO7/CY4b6tmpYY
	RILy+e50qNZp8+wap4qSdZRvqIfldTGMvn8wfpR8h7FtgmQ3HvgECpgwjkH3nGuy
	ZHQsbBZN3jIRDbkSu+HQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh6ws84m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 03:46:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R3kGYt001055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 03:46:16 GMT
Received: from [10.110.113.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 19:46:16 -0800
Message-ID: <e2b7a7d3-c318-41a3-81d0-c6a30ac5941d@quicinc.com>
Date: Mon, 26 Feb 2024 19:46:15 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath10k: poll service ready message before
 failing
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240227030409.89702-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240227030409.89702-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YMVGaPuGpksqaJcBC84SpsKMv_F7LsEf
X-Proofpoint-GUID: YMVGaPuGpksqaJcBC84SpsKMv_F7LsEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=739 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402270028

On 2/26/2024 7:04 PM, Baochen Qiang wrote:
> Currently host relies on CE interrupts to get notified that
> the service ready message is ready. This results in timeout
> issue if the interrupt is not fired, due to some unknown
> reasons. See below logs:
> 
> [76321.937866] ath10k_pci 0000:02:00.0: wmi service ready event not received
> ...
> [76322.016738] ath10k_pci 0000:02:00.0: Could not init core: -110
> 
> And finally it causes WLAN interface bring up failure.
> 
> Change to give it one more chance here by polling CE rings,
> before failing directly.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> 
> Fixes: 5e3dd157d7e7 ("ath10k: mac80211 driver for Qualcomm Atheros 802.11ac CQA98xx devices")
> Reported-by: James Prestwood <prestwoj@gmail.com>
> Link: https://lore.kernel.org/linux-wireless/304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


