Return-Path: <linux-wireless+bounces-5844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0718977FB
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 20:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E91A1C25DCA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 18:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52B315357D;
	Wed,  3 Apr 2024 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a51MeFgM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680261534F2
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168235; cv=none; b=J4WdR1+AXX4hndgM1xfqGumPXIyCfaZ+hwWLy5dN8agFnDO0U1k80yoTwOMokMNF0ZnggMt5VdviFQ8Hv2Ynea7FuWc4044EpnQUfuPJ0yJma4N3OrTGkf5qhrpMCfAfxhFRnGYbvz4+pw2Mn71qTy6Nwg6Sig7l7tGPjArKq3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168235; c=relaxed/simple;
	bh=PKyMarkrkyYCkhPVIc567C3oKSh9v6Z3TkPV9r/MvCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dOE3zOO6xiHHb0MJJjxZX9ejtdfoVgf85L0ZeD7gATrnnCFv5OKNNlEY8JFfXRWh3DGSs4yuce7z8fhrY8oqWwuDjYRQXPOH1roEVuWvKI03GbSNJuKg1oHQ2TNI7vhstATZBmL7jwgyKmsTZ7p1K/2wX9iLN/FK8axAmJw1p6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a51MeFgM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4338YN6L001154;
	Wed, 3 Apr 2024 18:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TWDUWxBSYoimwLvgq0wf+wYP293NBJ4nq2WDYb/B9P4=; b=a5
	1MeFgMHhUaU2AUB/Z75kTFgLX730j20TEH1fy3BViRBrowxwu+lc8hueIOYLMOep
	sGHZTaYN5NFO1Cy1DUUzfWwkM+SbSu//Aa9W5n+cW/KabjTHmt/FfP51/el4pb8W
	n0ndYfnCL3IxlfZ8f4HKbYvfzKL+HO+qzij29v2fLsFSPaXoMi1d9SosTV0Yi6UT
	7jdjy9SDU8JSia/jMU7U5gp0NcKYWyoD0BukavGlU08CT/v2+mWeJf2nyfph5Yq1
	stGZhCf1rT9fC4TPOYExEJgWM7Oq5tR2kuIjy0GqfXPqE0HhVCx7R4J+Dmv3Yaur
	yz8GkcvIybAFwNaRKhbA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93pw9fcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 18:17:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433IHA0C021097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 18:17:10 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 11:17:10 -0700
Message-ID: <4f12a0f1-cd66-4310-853b-f805b839950f@quicinc.com>
Date: Wed, 3 Apr 2024 11:17:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] wifi: ath12k: configure MBSSID parameters in AP mode
Content-Language: en-US
To: Aloka Dixit <quic_alokad@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
 <20240402210538.7308-6-quic_alokad@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240402210538.7308-6-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QKDc43U2j9N1hOqC4xIqHgp_JrN8C29U
X-Proofpoint-ORIG-GUID: QKDc43U2j9N1hOqC4xIqHgp_JrN8C29U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_19,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=750
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404030122

On 4/2/2024 2:05 PM, Aloka Dixit wrote:
> Include MBSSID parameters in WMI vdev up operation.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



