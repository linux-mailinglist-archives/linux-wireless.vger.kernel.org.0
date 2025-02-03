Return-Path: <linux-wireless+bounces-18323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E37BA265FD
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCAB1885847
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 21:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A851FF612;
	Mon,  3 Feb 2025 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ao25kZIw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD7D1FF602
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619126; cv=none; b=MS7alG409lQ1gNV5WwRXE/P76XdsjNPvGenyUG4pxci/iEGoAzBo1aQLWgWJOXraq90qpXc68dHSkEkNLqGH/qfTkP2nmt5U5eY4LIsVGgb6VNxIbvq2HPoEZCF4GgF5XfbUoCpi6qtnqne3IxRoHTJdB7zaXKdPPn0GFK4qXbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619126; c=relaxed/simple;
	bh=ASBMccnXTedJX9xJIvc9fkZs5OakglzHKw2wbH2NI8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gGI/DqKHPLwR/8XSYdLq7cf3sfy/icW53014l03iJF+ErNtQ3dBnnkr37WUOE8xQ2xaL9llHD5WT+0zRqjkqQUuaawZnLpuOPvycLtrL8uZrJC1DV21dfn+yRen2KdofhIXm71kNm4l7YoorPJZksSkMqEiODz0POaajrWwUMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ao25kZIw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513HfSmi017297
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 21:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rjELfiAmCQgwiqAvDegJKttQUaw5DEdDCiINGH38xmM=; b=ao25kZIwZjLs2pjh
	4NBdTPkQ/7F7t4XmCTnpc6QdHWjtV1hLeb/xk7iNVZUsBysGb1r6zdnKof8TAK62
	enAe8FZCaMPQIyGntkCYMuLqRaJOiWF664uO08zk4MUh3q5/Y9o9aSSdAJHwrm5Y
	KD2EDeOq13U9YJN/yMI5sNLFKRZSkxopuw2ZDaHnciENS4sY0eI7f//KDtPsskAC
	zz837CF6mzUf4BGc1XYTzA8RlrPf/dgBbVWFNrEA5tS7jRPLC5L0v/bQe1LUf+Pc
	VofC7YuGSYwL5WdNp0iwazJhLOswybY55M26pSeOZ1ZJQHp6fiSEFrMWk4ebxJCm
	rqRDFQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k2e1ggm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 21:45:23 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8f94518c9so47655016d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 13:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738619122; x=1739223922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjELfiAmCQgwiqAvDegJKttQUaw5DEdDCiINGH38xmM=;
        b=axDu9QJjCPCPVDS5aMYzaI60Ds9S9f9rlQ5lopsaZnWpXQQ1FxAk+vd5FWzPcm4JNi
         Lg3VlYSPMGa/ijtOdxRIanpWhECI+YrMXnFIr82l/WycU/t+UqTnCvpWplC8jw0hsVnQ
         uBRUSN/mIpuK3qRURz8ngpBGtO6sN2Eir6yTI8CHXPfwE9WdzvS6TZ6skX80NatR34wm
         FZesUf5PPu+55+WBL00pZFQubf+dCKaJ3RHSLEvcyX7kiE5n7a1RPclTYx0xg0iHHPYD
         WFd1bWUk7AWqMn2ntV3yt5iHlFJgLNF4Fofb3QG410QCxQ2zNjcUBjAgI1I/3T9Hr2Kh
         gwGg==
X-Forwarded-Encrypted: i=1; AJvYcCU7k4TVQbA6trfI8aOYmNfoAvvoKLrZbub8SEgt4m62402zNM/WrD4wol74T/hOuT2Q+eWNQZ5ggutDKstn1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhRBRy4+WOD1TvZXAigsEPcmAJSBW2QoXW6OWDsVZlWbWjl179
	/MpoT2uwHLLwj80lktU2xoYe92mHJ5LO0K5eOUUe5Cq+Y/1tbuchO/UiMIrf2IjaNou7UP3Exh2
	IkgtEcjyTrVGKUlFlvSHsNov9J/DCUXJMcbVYDIiY3K8Xp+tpT3G+gx/2cK9U9tTdxQ==
X-Gm-Gg: ASbGncs8CePWJnMUYzpT0xI9YzVDcxdEHEimdalxBzuGY/iGzUpGxcsNF7OAY5yuQcM
	FPcdxD5zvYlcoSK5OjenpMg6nOFk7/x0QV72JvTNSkBmltacOg6my6IaNdBC4WvNjbQ6YxOZ3nd
	koZrCL6GAJzhAVWaIVFlEjunpRKBOFgHpu3deHSJGQe4TYR4AOLtM67bX16RpySDX40iUfN9txy
	a17PZ4dGcQzrL2xaB6YrTw7g42s7Ilu3CrvBuE8HvsNsVk7/mXFJ8YIVi2W7yNk00PLodANZz/N
	4R89rxbRZ9DSmfULeOjLYCBrogpssX3Y7U+Wi1hAluX5j+POkvo2DB8opbbG0QkQWvdfdg==
X-Received: by 2002:a05:6214:2582:b0:6df:97ba:4f7a with SMTP id 6a1803df08f44-6e243c5eb6fmr356188476d6.33.1738619122471;
        Mon, 03 Feb 2025 13:45:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsmBzsmgdRkq8eVXMMj0bpeU5v/kZdOpIpOcKaA1HWVK8jC+a6W1T/M0aEB7RsoK+yrG/e2Q==
X-Received: by 2002:a05:6214:2582:b0:6df:97ba:4f7a with SMTP id 6a1803df08f44-6e243c5eb6fmr356188066d6.33.1738619122059;
        Mon, 03 Feb 2025 13:45:22 -0800 (PST)
Received: from [192.168.69.158] (c-98-35-147-9.hsd1.ca.comcast.net. [98.35.147.9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254922475sm54640666d6.70.2025.02.03.13.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 13:45:21 -0800 (PST)
Message-ID: <a612fb4c-ba9c-41ef-99df-6c26039d86ef@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 13:45:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] wifi: ath11k: refactor transmitted arvif retrieval
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20250119052250.3488343-1-aloka.dixit@oss.qualcomm.com>
 <20250119052250.3488343-2-aloka.dixit@oss.qualcomm.com>
 <85216244-8348-4fc0-957d-6ffbcbcdb28b@oss.qualcomm.com>
Content-Language: en-US
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
In-Reply-To: <85216244-8348-4fc0-957d-6ffbcbcdb28b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UiXcVTXOPOTDTEQ3n6U9GEs8stfMEIq8
X-Proofpoint-ORIG-GUID: UiXcVTXOPOTDTEQ3n6U9GEs8stfMEIq8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=977 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030158

On 1/29/2025 3:52 PM, Jeff Johnson wrote:
> On 1/18/2025 9:22 PM, aloka.dixit@oss.qualcomm.com wrote:
> 
> ...
> 
>> @@ -1538,7 +1546,7 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
>>   	u32 params = 0;
>>   	u8 i = 0;
>>   
>> -	tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
>> +	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
>>   
>>   	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
>>   							 tx_arvif->vif, 0);
>> @@ -1597,7 +1605,7 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
>>   	int ret;
>>   
>>   	if (vif->mbssid_tx_vif) {
> 
> can/should we remove this test since ath11k_mac_get_tx_arvif() already does
> this test? note ath11k_control_beaconing() removes the test

Sure, sent v3 now.
Thanks.

