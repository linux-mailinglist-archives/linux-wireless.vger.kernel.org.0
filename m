Return-Path: <linux-wireless+bounces-4439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA48873B12
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 16:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C905D1F2A46D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A0F133402;
	Wed,  6 Mar 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dzNKKK9l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F262130E57
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739959; cv=none; b=OcDpriTrQ9EqBPGqQhreYKYd1FXi43BnUaCb/lN7iXsDul2gUTvZfWatr35fGhu156+IAqah0VGe+SE7A2DgLiJqd1p9uxYCb6x0DP8Ts9ePL5mnq6MPeGm/vwA3WaJnAdGOigf0hTrRzmQizGWCwV7UAwG7Kq92NYCzQOMP2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739959; c=relaxed/simple;
	bh=nYFlwHuuzG8tOa4OTBmHXIIYqZZ3BLjtIy1Ma+1IT5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MjOmNIOX0DHESWHSYUThetazpQ4vxFRXNEAuVFND9CqjH5uoJSfBo4d1jByfyJdmPlt4Iuw6mq6dU7juZTD/HBMKt6H56ZQIkWgglGdBd3EXAabmrRJ0XrjLy/FYGZ3CD5th5MG1Hh065vLJkkZFAbrKYNB4KRRI9wH9vdySj8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dzNKKK9l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426CGdeF025716;
	Wed, 6 Mar 2024 15:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZriVnAkAbNTgRPbl8ful3yh9KHAVXDxhg+h2EDfcoAE=; b=dz
	NKKK9lbpzOOWFHrRj08M8/DvG/FQRnX6/CVpyRblQO7wNaddq5/my54b1YrNzG9v
	3wM9I+gH9lJPCYqycJfxbqAiVjtO0oBkFEFohnA1Faz2CsKvI1DkflFj5Zxd6L4I
	/KWGbMK4A1v8Q1DSJDt5tzXn5LqiuHwrlB20UghNqR0SkWlWEnNi4gdlCqxz4NU2
	S8rOwlZ0yI0D9V/G5EyKzYFNHBUE2vUMVcNVxFZ1iiXeoTlVAtjhj1hJdWB78xtI
	4GXQ2uG3OeKyYfmFaK/W/ROiXuoak+EHhgohPyygJDl1x2IU0iGWS1RNGI/fPFma
	sGuq9uxLUja2vcYpLNIQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpmu8rwjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:45:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426FjmiE003729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 15:45:48 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 07:45:47 -0800
Message-ID: <c967dfb5-03c0-4871-95ad-84ea8728c6ce@quicinc.com>
Date: Wed, 6 Mar 2024 07:45:46 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: adjust a comment to reflect reality
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Kevin Lo <kevlo@kevlo.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <ZeWEqGVibkMg2APi@ns.kevlo.org> <87le6vhgdg.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87le6vhgdg.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L1Gv-fVlc-suDaHt93KH1v__P5lue00G
X-Proofpoint-ORIG-GUID: L1Gv-fVlc-suDaHt93KH1v__P5lue00G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=754 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060126

On 3/6/2024 1:14 AM, Kalle Valo wrote:
> Kevin Lo <kevlo@kevlo.org> writes:
> 
>> On QCA6390/QCN9074/WCN6855, MHISTATUS may still have SYSERR bit set
>> after SOC_GLOBAL_RESET.
>>
>> changes for v2:
>> - update comment about resetting MHICTRL to clear SYSERR
>>
>> Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> 
> This didn't apply and I manually edited the patch. I also removed the
> changelog from the commit message, please check my changes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=709cd1c88a11bc1969cf573575b0a2027e720146
> 
LGTM

