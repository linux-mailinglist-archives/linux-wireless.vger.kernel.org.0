Return-Path: <linux-wireless+bounces-18438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3EDA27835
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08BDE7A2CCB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F1621638B;
	Tue,  4 Feb 2025 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QgLzQUSc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FD21516C
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689599; cv=none; b=qBEV8Zpvqj4LemrG95CrrTB19Xjr8Z6LeRJVZ5+uZ8/AlnvVjo8/LL2hroXhI6VPof2q7MetftQxVA6P+27Q4sBpG2ySTwEO9GjhszJ+GlfJ5u9JEjCTJhaosA6I3iRQJALrn9fu8i1QjntfjpOu2X7Y0YPOcbFA7xTIP1cqBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689599; c=relaxed/simple;
	bh=LYHa0ZqS+rDG48w6uCcln6I0sX+37b6giliOCCSaqx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXJYr7JxKSR/mEI0V3gQ7j6O8Mm6YRlR1WjSBL+4qCPKywozQcWdFY85KCZm2xlGIr3+3pG3if2qWb+0K0uZx9Xn74k16E3Jf7XyPL4K9mf/c+KhOWzQu6j10nij4k+ZQqPIDKf3n2xoJTS2lAmH7X9+1oZR9vAE9Aroo4MN7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QgLzQUSc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5148WtLi011051
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 17:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2UqvzkOspButWcUaJ64/oBpdNehxKDeLYx4iVQVNtYY=; b=QgLzQUSc10dfprXn
	77rhDeDSF3fPecjTy7sFRFnzZ6mw3fWtdBcwalsk7sjH3A73/O9pL6AKRwIaAbSr
	MvBbx2ihk8naNZftpTN8sn5AEmQ8KEcmjVcc9D1l8esnX9MQhqWRAexLDfbakf6T
	yNfdCpxNm9PZjYPD+UCXzcGjMfTJoLR+SS68JjnK09IVxBSbevZSzWbTM4Wzuduo
	CVLtoQj4d8ayTIVo/apFuibwW0d9bDtoG3zCqF3s8erWvTOScCAN3PM7DoiTHmKz
	ffDteUWMUZDLBqLB1xWYkxn2g5vOR/ZLMPu/BFIl1MT9Ra43EwJ+1BWHvBnLrWoq
	ior4Zg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kffnha1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 17:19:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f09fa389fso11957025ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 09:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738689596; x=1739294396;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UqvzkOspButWcUaJ64/oBpdNehxKDeLYx4iVQVNtYY=;
        b=p9R59oi/I6g/HGPZTuTzN6oBwvMYjUaaSc7JiUy14AQAjPnIlW65xtXAuFdy2vraq8
         B868um28iCCq0PJ3XggUF49tWzgoa7LdeBjZWyIy7FJxFwgziLrAZaMLZVHpTiKSC0d7
         izITGIVdRcJETpvJKOkEUHxSvG7/cij0ggzuF6BHBIKIAzXACdAb2ZV4PGddZecZUilq
         jM6ZE8OxcofFEIAn6mifW8HkPNy5ZmmbpP766beYZxkxnSAF+6IrkX86zvbVpMW1zFpZ
         wltOlytJ2LO5MAOPXHTi7B/t8ruSUovkheQwavbxx4evuiqyDwZsI//46A0HaggTenx1
         nIQA==
X-Gm-Message-State: AOJu0Yxx6DDGcH7qMVHhMGondEES8sLG0lBP1YRDIoW9eyMWqFC+1T1u
	CQGcdGG6GvZ+MKlxwrJ/DUmPTDQ4C3O6h7z+gI9HdCoQIZUyJtDKQu+chmDYlfT7K4hf3Vwou/d
	HMSZJrNqRp7to2ulTcvnzunB2MkNe6HmpQCLeRowz1Xr9cs1g3vxfdeQo5666/yOi4ywcTTNVlw
	==
X-Gm-Gg: ASbGncuRGI6lnoXB8wD3E68fx/KJxB4AfWuB5BzbWjE7V5LYgUspE443JWK4C0XkMXJ
	a5Qp4Vd9JbFhJt8gVnEV7oetkZkBtYsWXJjjkAbiXxozfgQBBH3wOx91I/Z85cuHXQO3lDfJiD/
	5T4qjVC8jey+TirCJ4ZXlX88/8LuLARefxKfkBlKuDYre8jyr2G1pIOOSqhBWlPkilb/4gNmw51
	0auR0hiillR2p4k2Xa+VlH5a67AquTk9eV1RBKKzMnBUAAbEMU/zutjstVMAdiTk7o8JbmGCJ1x
	WV4qNCb6ys2nfNhTqblzGVGMOzR5af7v7orH4IKKIg==
X-Received: by 2002:a17:902:fc48:b0:215:58be:334e with SMTP id d9443c01a7336-21f01c4eb89mr55640555ad.10.1738689596255;
        Tue, 04 Feb 2025 09:19:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRaCeaMYXzsJO4HcrPp6hyYPtN3U/0bZWJ5AtJlfpWHpm9+wpQl9q/SqVGNSCZ/EY68GmdAA==
X-Received: by 2002:a17:902:fc48:b0:215:58be:334e with SMTP id d9443c01a7336-21f01c4eb89mr55640205ad.10.1738689595879;
        Tue, 04 Feb 2025 09:19:55 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f7020sm98411245ad.76.2025.02.04.09.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 09:19:55 -0800 (PST)
Message-ID: <c032881a-153e-496f-bea2-0eb8452ad495@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 22:49:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] wifi: ath12k: handle change_vif_links() callback
To: Nicolas Escande <nico.escande@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
 <D7JKQ60C6EZA.24H639LLIG2U7@gmail.com>
 <076014d2-eaaa-44be-81fc-a8f1eb0c2ac9@oss.qualcomm.com>
 <D7JLLQ79FP2Z.2Z7VYLSC52A2U@gmail.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <D7JLLQ79FP2Z.2Z7VYLSC52A2U@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QelcYRh-bCkFm9QEZLim5rpoDU6MNsVo
X-Proofpoint-ORIG-GUID: QelcYRh-bCkFm9QEZLim5rpoDU6MNsVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxlogscore=928 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040133

On 2/4/25 16:14, Nicolas Escande wrote:
> On Tue Feb 4, 2025 at 11:23 AM CET, Aditya Kumar Singh wrote:
>> On 2/4/25 15:32, Nicolas Escande wrote:
>>> Hello,
>>>
>>> When applying this series I am no longer able to start an AP on a DFS channel.
>>> (I don't know specifically which patch though)
>>>
>>
>> Thanks for reporting this. I think non-DFS channel should be working
>> fine right?
> Right non DFS channels are ok, only DFS ones, and not from the get go but after
> the initial CAC, when they switch to operational mode.
>>
>> Anyways, I'm able to repro the issue locally. Let me investigate further
>> and come back.
> I'll happily test what you can throw at me.

:)

I have posted v2 [1] fixing the reported DFS issue as well. When you 
have time, could you test and confirm? Locally I'm able to see 
DFS/non-DFS working fine now.

[1]: 
https://lore.kernel.org/linux-wireless/20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com/

-- 
Aditya

