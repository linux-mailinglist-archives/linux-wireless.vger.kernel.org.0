Return-Path: <linux-wireless+bounces-16150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723269EA9FF
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 08:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E745169493
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF3D22D4EF;
	Tue, 10 Dec 2024 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LJgYH1oN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC2B22D4CC;
	Tue, 10 Dec 2024 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816650; cv=none; b=FS4HHdpVtMVyYfzHqavpEPClWl76ksY1xNxpp7qB3gp6vtIwQ3YkbxZKCAXAkENwc1agS+JDtxnfUP2BH8WCHxrF1r9NBqgoCmGkGhkL0bFr6myXr9r+39o6n8FVLgKEPXHAhdYpCJk4N65p4syzujkZNXcZHxAPZoIPh5QLBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816650; c=relaxed/simple;
	bh=x1B+56OzNF1Et1otShBVMsgiqmUcBQKPI+IO++J80dI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WOS9qC/btxfiKj8dG+M0RUzzQH0ii11MfZwU7k+o9x1Wm+w/Rs7BbUBKAEo4iZEiPAyqAJFqusuWNWghmBXNP7VfA+7PFv89rdiqUwDrIh6X/NBoQcY2Y683fTPDNq0EP7YqjvPPCQTRehXo/n0NpbCinPcm1IUCgPye35Ujr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LJgYH1oN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA3ovTr014620;
	Tue, 10 Dec 2024 07:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	az1rJ6tiz65SEHje3OiybSenn4f7/wTaCG7Qyj18s24=; b=LJgYH1oNGtU9+Fte
	AwlqVQvoJRnFlAQUI7asXN+VE+kV0pxKZggsgChjfzNgUKYJ28VejCtRtOEKfySq
	dIfWnjHAIJjIaURLfPyUvUNf8DlMWcM7kAtj6KY45o2N+Ldj/1YQrcOv8hbGGkTp
	T6VHUy1lb0dpYnnEw1lUwj5pCDzviRmpPnhhyvY2sfGTr1u2IRHFWEEvgjZYSabK
	4jlp9UpLimREKL+XXuBrEaUOjnFJos5Q3fBJSqJPw14Qt1QLta+kLmWHY4uU9BB6
	yx22R53LsM0WyDg9vq/uVIQ5oLzQFC6zY0rVrHPnSNe8UsmUD7AF6xwktD4HW/qH
	tViS6Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ee3n8gss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 07:44:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA7i3H4001706
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 07:44:03 GMT
Received: from [10.151.40.239] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 23:44:00 -0800
Message-ID: <13722d17-bfbd-4fd8-b9a0-457a8193bb5e@quicinc.com>
Date: Tue, 10 Dec 2024 13:13:57 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241209165644.1680167-1-quic_rajkbhag@quicinc.com>
 <20241209165644.1680167-2-quic_rajkbhag@quicinc.com>
 <a522df49-5628-4ec1-8ea7-d27cb7fa3bff@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <a522df49-5628-4ec1-8ea7-d27cb7fa3bff@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p56w4NTSt7X2VQbkbqYEo4K1C6N6Q5rX
X-Proofpoint-ORIG-GUID: p56w4NTSt7X2VQbkbqYEo4K1C6N6Q5rX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=704 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412100057

On 12/10/2024 12:48 PM, Krzysztof Kozlowski wrote:
> On 09/12/2024 17:56, Raj Kumar Bhagat wrote:
>> Add device-tree bindings for the ATH12K AHB module found in the IPQ5332
>> device.
> 
> 
> Please start using b4... Not tested, so no review.
> 
> 
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
> 
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
> 

Missed to include "devicetree@vger.kernel.org". I have now sent v4 with all
the list as per - scripts/get_maintainer.pl


