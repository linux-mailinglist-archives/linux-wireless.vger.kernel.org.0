Return-Path: <linux-wireless+bounces-18097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61EBA2155F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 01:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE25166ACB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 00:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2A97FD;
	Wed, 29 Jan 2025 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AhvNtyAy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B184EAE7
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738109321; cv=none; b=IsLCj3O9thumiK3qaJCg05vG8Q7At8ZB6duKyToHAYYXri37kelbavUf08sagLscOR+7wKThmjbILOjRawWBkE3G7JP3fBRvQa2XkRqU9t6AMC8SEPdVUvPLyIok+NhKFYfIoV5PD7fDahUyJMRGMcypSdeAchDcD2omrINxQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738109321; c=relaxed/simple;
	bh=Wx2Bg4KPObwcMTKH9fbzSmDa3IwbpTMBonKLI8EaLI0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qsoMj/W2ys0KIDQ66UTaO8U3CmpTgXQZXltlfN9cdDMpSyx2/pLYvqxc8uRTvv4W0iWzpDaKckTHoUfn9RvY1LkSWn+UP3fFOcfkj7AvYXfyVEx63Deq+XTQyM/5O+wqNbLiY5KSlwLdNRcYK5Ifq5QceEwa7MLT7OFgNs9jFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AhvNtyAy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SJ7dTM009789
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 00:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	033Ruz6Xk8VtjPYFE47BYVz/7jmWnDI3NRw25DafCzo=; b=AhvNtyAyrQ2fGvra
	TOqgkdTBHWGIdhtT974EGCsTL+tH4QtZpHSIsRfPn7IrSUtx0SaTX+BCvP2rC9bD
	a1uo/JyoA884mZnahPLLd/2ImLtk+R6gAkDNLcD8gx3+ssE6aIXd0fEKwRGfuaHk
	0Igsf44A+5cA3XSZrtyyLVJO4AAKFafJUhIxhi2mswQ4qp4lDimbiXffBHGyr3g8
	VE1/x7Y7yykOCA9neZzLWLU00k7BSarkVwxj6wYxfKjHw2VMj9QE3D0fURjVgDrN
	Z5O/5qa6mLogQuvvlYKnVt+DYe5P9Yym7xVt4k/uGJdJnVfZLZwb/ttKDB3XRMSI
	mm5+ww==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44f54dghdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 00:08:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21a7cbe3b56so94018795ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 16:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738109312; x=1738714112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=033Ruz6Xk8VtjPYFE47BYVz/7jmWnDI3NRw25DafCzo=;
        b=qd1Gqzfry9b2gvd3QXDE6/ccK0VCONf1M19YhzV284Ys4VDKZSJd+w7Ktm8WUAMbL7
         qeV9kjdjMZZwXTDZseXH5qEkFynFDcyVNH/dUpAtcnGNbmSClfXJXeWBBUuvU9MP4/9o
         oQO9New5P1CCOt2WXXyLYDPVL7nMo0vJn7iYLORtdQJNS4aK4tpIJkfwsRRp1WiGG0U6
         TN8NsABNc4SaU3CpKhpb8dcXP7f3FVMmsEVv2nQ7aj8KxwUvcc2N7yet+l0MPuGE/os6
         wQqTjrRFV8AbdSnBXr1NM6JAuZd4X/alzM3oF70wBxmZyeaMvk3yp1jEoS3kSkXed7oj
         jvRQ==
X-Gm-Message-State: AOJu0Yx26vbm/Kz3cHKET15u57bL33tqxFa2b1CXe/5Koo8gTDaP/noZ
	E/Bt/Vv+E06sdH+w7ohC9D9VKUj2nfZZEwsGz/KxRMMES+Qyw1zVM7C3H5J3Eugle9hGI5IuJzA
	Rt1YARZONEZYUht6/dWrQyl/f2C1lBrrUvHwYAS4AHKd3aBOcKeOb/w/lwJ7tC+q7pLhWHE8vyQ
	==
X-Gm-Gg: ASbGncsIwV+X+r9Zbox43Y/Mta6P4nBwYxwN94Y278GxnImB3PPbFTnxQzGo6TnvmfN
	6rbRMSxsYHlPcwDXKpA1mZSP6PyHTF8oLX8SFfZ0reJDq9CnbuuQ2sVz8yLMIuyoR47cCfqdogL
	Vk6ibSU69RsLsMa4KLi1q0vxH0kJirSq7zsv5XmtpoXkn03VmnueJXkEXkA7w/pY2RyeNK/nRg+
	ogu9rCWJVChphqHPjgYFP3wT9i68fGvTuSVc3hgY7SinX7KknSxnZ2fie/qJ2fQUWiHOGOMm6xf
	q8FmNPWXnBktMDCcY/2uN0iAkZ5MpsCE6d8+UjSSnddds5vDn98y/CTczNXBNpSQXZlUMTaGWQ=
	=
X-Received: by 2002:a17:903:1c7:b0:215:6cb2:7877 with SMTP id d9443c01a7336-21dd7c3c5ecmr17798585ad.4.1738109311836;
        Tue, 28 Jan 2025 16:08:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsMCW+yllDbo55XAp2kTIbQ1pr2fr8i1lRySB+813CdSyCWvnlAZDIokyDUH6qR7AVhf/qvg==
X-Received: by 2002:a17:903:1c7:b0:215:6cb2:7877 with SMTP id d9443c01a7336-21dd7c3c5ecmr17798175ad.4.1738109311430;
        Tue, 28 Jan 2025 16:08:31 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424aee6sm87221725ad.215.2025.01.28.16.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 16:08:31 -0800 (PST)
Message-ID: <dd5d8193-3b35-4eac-b551-4dce5e82c3f9@oss.qualcomm.com>
Date: Tue, 28 Jan 2025 16:08:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: remove peer extra rssi update
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Nicolas Escande <nico.escande@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250117181953.3375273-1-nico.escande@gmail.com>
 <d5eda793-c7e9-453f-9dbc-07e5df73c47d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d5eda793-c7e9-453f-9dbc-07e5df73c47d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YK_Wm8sdUxVKUHejvP8eMxJ3ZYFj1MZs
X-Proofpoint-ORIG-GUID: YK_Wm8sdUxVKUHejvP8eMxJ3ZYFj1MZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=923
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280175

On 1/28/2025 2:29 PM, Jeff Johnson wrote:
> On 1/17/2025 10:19 AM, Nicolas Escande wrote:
>> Commit b205ce4c266c (ath11k: support avg signal in station dump) added an
> 
> I'll fixup this reference to address the checkpatch error:
> ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'Commit b205ce4c266c ("ath11k: support avg signal in station dump")'
> total: 1 errors, 0 warnings, 0 checks, 8 lines checked
> 
>> extra assignment of arsta->rssi_comb in ath11k_dp_rx_update_peer_stats
>> when it added the average rssi support. So lets keeps only one by removing
>> the legacy assignment so the two statements about rssi stay next to each
>> other. Compile tested only.

I actually made three fixups, please check:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=7946ec554fbea5db9a3aedb7087f0eb9e3749abc

1) commit reference
2) add () to function name
3) lets => let's


