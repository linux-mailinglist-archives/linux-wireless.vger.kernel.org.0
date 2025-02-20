Return-Path: <linux-wireless+bounces-19218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E08FA3DF3B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 16:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F93F189EE9C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112501F460B;
	Thu, 20 Feb 2025 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q2xTXwhf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355041DE3D9
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066423; cv=none; b=IQ10zUMrMskhb0esg1S9W7XtevVPHVExYNwGmUNDWdTG1UtrJp07qPtenHStfoxK4rdguPtSh7huLmaSbD6VfUwEoSYFd8xZFbuZB2lknWCAFmOU/ZErVkD4K05ANsyKm+pj64k99ELFhZV+a1KGTM60Nuenyxx0ayOqL9Mjvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066423; c=relaxed/simple;
	bh=BFSptAgzQL4dapfC7BVP2+OG/jXDMI3N4O8cN5ZicTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3hSt8QAVd/RqesVhYOkAOw+tzIO7qPSTMg/A9C8lG4z8HWKRpZQ93cLwFQxJs4AGnhO0JlO16GWJqj4z9OAhx3mmyNUZ8IAeZexJKnNby2MyPucLLwS2JGaEf//JSCa+QDorFS8WGYuwcGMJbrCL5W6tqfxLsJeIVaNYkgYXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q2xTXwhf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFZImW031803
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 15:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k6t17zJoyzi/MYtv7YnDTb5dXnKB3dpwV2Y+J7LFw/8=; b=Q2xTXwhfjSdYxCbI
	a2rq2V2q2zVyg1eSuSD70WMwnkb0VR/3/UIbixENlunH6GD/VHlh3t1yLfbyeEOF
	2QzuWmmxN97rtdE9Z9gqzZ7xFJKDyUxUqIOOOlXKFY0PacwJfJ4A/hDzdOTVeWLT
	MMuDyQb2MMQtBSqNmjrJAM6QHcana+UZ3YYS2ITpYKTav1S1XzwzPPAJGnXHTwar
	W5rIiFU1nG0fuege4HvXvT9Vj1vFe1/cQoj51kzRxH7iAYloR2zhyrBFChldUbxi
	8lkkKLMC/iJgkcuajnFxu8O10/QunuyEFa+f1mm600pcxOtaHiqLO7b7DS/OSuMA
	oAItCA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy5ek8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 15:47:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220e7d654acso27850455ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 07:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066419; x=1740671219;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6t17zJoyzi/MYtv7YnDTb5dXnKB3dpwV2Y+J7LFw/8=;
        b=PlMl69f+uLBkI96WrFW2dTjfi6fsZ0AOwUfANnZ9YjuwzRWDhJfae6Oe2nzcKfJcb1
         rDwuPo8b0YHTdJ2ihgMquByi0ZNFkp7VCUVdR/j1mDeEuIW97M0FzZHoBMRo8iImF8ho
         XJuq5zJsd1Wes84xauhIKMvelT3AS8dzr0Ja5T+GLClmIBaLFTTUvN+e9PIkBXrhqvRz
         4ZKPVknt4VqpAm+V6Qqpt4gqwGLofykeYESFFNaua3MADXjpFDn2+Gdz2VhZepqlpJQq
         Rb/y47+Hd0XP4g9bBMW2qsK84SRSAO/CNjGfIImtgxiPfenW7l7Nem7cC7F8PkMgQsu5
         s12Q==
X-Gm-Message-State: AOJu0YxD2D4jgG5DXmFqp6GlK3husL1q30VwkmSA8B+7XoJQMMD2tza+
	Ac5JxZ1o+ACG5KowA9knGd4E04VSak0Pkw3XhL8XFraF8Xlq1EcJRsGqJWk9oEUsEJEYEAJTWku
	NVyiJ5Zd9taTdlaNxk+MsNL5vsw0A7/MhghCpKX6Rhv7UNlYpjj7lhwMEsaUqyOSbBw==
X-Gm-Gg: ASbGncvoH0c1uTfuNJY5agsn7FPTq+7ZCmGFrmhLQYlZHnM9F7YewlrLQ1q44T5AmfI
	kiIwRSKmIcSFNLFjmAz6Ei8IfvuWjm6H1YyS43jA2wVhPfqH/IIc82x3A8b1JLlS/W7sHUpnzEK
	liEuq+ItSvDXFPnh/CkoEg3p/XmJlJxmMn+S74eNNsPUjPG9XL/c7VG9pKnkgQpo4W8680XKhaK
	/a8NnOnfAFgGetvPY8iDWoZ1lPC7OgPK6KAt8AbmGald7WY2cH62ZOluHz5uz4OA4uw2sE8oS2d
	Ka2EraZ0HQLglxL5r8c6gkdU8qnrv0NbSTiuTh+HYWF11E23Kftgl84c2mFaw1rxVQIfj9A59g=
	=
X-Received: by 2002:a17:903:2301:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-2218c546f7amr72253805ad.25.1740066419236;
        Thu, 20 Feb 2025 07:46:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhZuienlMC+FiI9oeBoMDi4nayiLfAduqOYeqfUcAKqXiHdP5lNX3kFBEMvffwWkdr7b8wxg==
X-Received: by 2002:a17:903:2301:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-2218c546f7amr72253415ad.25.1740066418801;
        Thu, 20 Feb 2025 07:46:58 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53643e8sm122730155ad.71.2025.02.20.07.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 07:46:58 -0800 (PST)
Message-ID: <80a13b18-01f0-4f52-853f-bc8e3f84e91b@oss.qualcomm.com>
Date: Thu, 20 Feb 2025 07:46:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fbx: Add missing htt_metadata flag in
 ath12k_dp_tx()
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250124113331.93476-1-nico.escande@gmail.com>
 <7e120d90-bbe6-47f5-bf72-c1ee681c97a0@oss.qualcomm.com>
 <D7WMZ4TCZKPB.2GBOWXBN8WKF9@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <D7WMZ4TCZKPB.2GBOWXBN8WKF9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kmtJj6Ru32jQLLUKBcK_DAZBtRH-TxYS
X-Proofpoint-GUID: kmtJj6Ru32jQLLUKBcK_DAZBtRH-TxYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200112

On 2/19/2025 10:33 AM, Nicolas Escande wrote:
> On Wed Feb 19, 2025 at 6:58 PM CET, Jeff Johnson wrote:
>>
>> checkpatch complains:
>> WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '5e8a373c8699', maybe rebased or not pulled?
>>
>> And I don't see such a change in kernel.org
>>
>> Perhaps this is an out-of-tree change that should be referenced in a different
>> way?
>>
>> /jeff
> 
> Indeed I didn't realize that was not mainline, but just in our internal tree.
> My bad. Honestly surprised this has never been pushed upstream.
> 
> So the corresponding patch I was refering to is this one:
> https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.wlan_host_opensource.3.0.r24/patches/ath11k/207-ath11k-Add-support-for-dynamic-vlan.patch
> 
> How would you like to proceed ? I can respin it without this wrong reference if
> need be. But if one of you guys has a better fix or something we can drop it too
> 
> Thanks

Fixed the subject and description in pending, please check:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=e5c718f0c65701ec941ab3121266f33f83ee9803

