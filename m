Return-Path: <linux-wireless+bounces-15186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A049C43DD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 18:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B042812FB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAE91B4F30;
	Mon, 11 Nov 2024 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GKP5YPsp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E271AC445
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346637; cv=none; b=NvEoDV98s9XjoBT+6Ci1GBGq78j3M4P8Vb/ia8BfIejXxKd5XtULDccxwyHdLZPYWOiM1Z96Jxjc0aAW8Vuk7SpW1pRWl4Vvk+2u5EULV7LxwHhlVUU7g7k9HnJR6+fhRYH6qIdMFl65o46st6NpGlB9CMVIdVWxRftPxgu808w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346637; c=relaxed/simple;
	bh=zTCAy2MehzCGs+UcioLDPnG/D5PTNaRLCDoVS9Kj2LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JfSRlQIM1+iRDs1geqVZWi4zRGQvm/+FZv+enXJWb3S/xNgxAceWSqTlCekIVccOt8EdsFb8RNj3ir6l/sS1Q+zFEhuC/HZAhvm4af1bGxwOo6ILyREZob4dE/uPWhqznO9oFdU7I6aZ9VZe4HxzJhIWnnSJwBNY6ZDygS6i46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GKP5YPsp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABCkoCT027759;
	Mon, 11 Nov 2024 17:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	spsnP7/d5TGkknZrThW2nWqYvznGB9baSmq00S1T9Rk=; b=GKP5YPspdBB7Aye4
	41OutnnjIhl+6P0RcJ9dzv6rNEy6rmDIOqwI5fkldClwxzB922v/B9to4xurUFvd
	bzp3mAUzhWzcBoLKXt5/Hj+cL3smxf8J4+8RXL6PHPyNXNYVzrb9Fqo2MZawWcB9
	z+n2xscugfNmBa6D4c9uM3pzbMS/paGoMxJ7WUJYsuNyG6u/EG0u5oLN6Ll1qfkS
	zXtafcmQjGld2CXs+Ia2486TBbBMLPd2pGHrZDQ2dwYA5GM84tUtQ6de1t/D8UVm
	3yxaoHeLGkmzDZXd3Qh+w01oDNBHG7l4LHsoOxITqqwK4Qb0Ip0ipAYhKmOVO0BE
	JdnyhA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sxr5vyeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 17:37:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ABHb7gN003194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 17:37:08 GMT
Received: from [10.48.243.207] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 11 Nov
 2024 09:37:07 -0800
Message-ID: <a5503b65-2722-467a-8bee-0130b3807a4a@quicinc.com>
Date: Mon, 11 Nov 2024 09:37:06 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath9k: miscellaneous spelling fixes
To: Dmitry Antipov <dmantipov@yandex.ru>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
References: <87frny5bcl.fsf@toke.dk>
 <20241111104724.484586-1-dmantipov@yandex.ru>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241111104724.484586-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: beMI21aHjpNu1UYFP6TKTwxqVTSmoXyl
X-Proofpoint-GUID: beMI21aHjpNu1UYFP6TKTwxqVTSmoXyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=939 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411110143

On 11/11/2024 2:47 AM, Dmitry Antipov wrote:
> Correct spelling here and there as suggested by codespell.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
...
> @@ -747,7 +747,7 @@ int ar9003_mci_end_reset(struct ath_hw *ah, struct ath9k_channel *chan,
>  	 * BT is sleeping. Check if BT wakes up during
>  	 * WLAN calibration. If BT wakes up during
>  	 * WLAN calibration, need to go through all
> -	 * message exchanges again and recal.
> +	 * message exchanges again and recall.

this one is incorrect. recal in this context is an abbreviation for recalibrate.

I'll s/recall/recalibrate/ in ath/pending

/jeff




