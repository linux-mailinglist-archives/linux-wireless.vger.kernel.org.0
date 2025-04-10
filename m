Return-Path: <linux-wireless+bounces-21402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F699A84AE2
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 19:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC707A865F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F931F151E;
	Thu, 10 Apr 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e7ejBOia"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230971F09A5
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305795; cv=none; b=MfOOhdM4JfGhDJMV+M7qYM6AQzFLh4Q0QiV6trsYdl6aRUDn1bPyqgx2XGugcm9hZUMEa90gdtrE8Bsk8x3YdwWEfrIpLax1tRglopfIL8KM8OFmDz/2zStMOEblY9d8OtEFQ5vcuDaPRMR3pgBZyKzyxmdVNCfAknblwdBHPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305795; c=relaxed/simple;
	bh=R5ybdCkyTddUlOPMRaGg48hM8Ao1y152Ju0ZZh/a96Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUlJ/wuOH9gq48JGm3YI51HUCZLm/rrrto6pvU5wvEjUkCLSB0CrLlxMiD9LzlV0qN3n62SrOYfvSRlWhgWeX0BuysU1pfO5RJ4A5NPeghhNk9gD4HtvukAoarq70ocwd46X+gfY/PJKw8W8NM1sXAh2YKyKdLalLUFvV9ipT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e7ejBOia; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AG1GBk032521
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 17:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z3P5K8qIo++EOiyUEYlbHQXKSiyqq7I06DkfJB4A9SY=; b=e7ejBOiaL/xNwWLp
	VZOLe3WCzQY1MSDHQNqzKapEAntXx4ei//4KdJZUToV2SWi3IKd+3Y5F4khnbI4z
	iT+eagahFJhNg9ljUozGWBX+TlFVghLfUhlov2vUcsDnElXi6lNb5V8TyrFxg5II
	ACJ630wwSYlgGE5Ogap3BM9bfUw3NsPtjLlq72JSyr1WPYV54uLuMVGg0g58DxkK
	4IDOCy2yKvrooKKvp6plMIntdOU7Ef7xfLaddL6A4tWy4XfzfKRmqYdQr5ItxBSe
	/JDuGBZokpFMPKc0A1hv0XbehapPV26g9rP9m4UKw2hEpHxXpbvhvpw1H+RroBQz
	JNTtcA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfkqmnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 17:23:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2255ae39f8fso20045225ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744305791; x=1744910591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3P5K8qIo++EOiyUEYlbHQXKSiyqq7I06DkfJB4A9SY=;
        b=CuQBif01/HMpv+HOiyt+tN4Cku9LRYqLWFW7IyaPZ4XQixjDsP/eSxjtr5n52sI+QS
         XlddOAdW2B59TNDZs+pvvUXBqiN5eboIMzP6uoGt3KxAQoeeVvExIK+zrYjAhOOfaMJX
         FjdRWNdVlcRA0tofHWSs3qNKvPkQvIMEZTUYhtTQOZa5j/wU/JAhPRjB0rdA0fCRSDGr
         wSg4eRg2r1ACQR2TmRI7G4u0mFLhdb1hIpKDrmSsbTaPTbXB4CnBgFdfDJfFxs9B7xy2
         zh4ZwiSKJxJK9iRzxImhPku8pyXGRj7VslTBUp9/H9Ji1Lh83ibo7G5PUfLUlcavTxjX
         gQsA==
X-Forwarded-Encrypted: i=1; AJvYcCUdbrHU5UvqaAbWNcPuhvk7/AqkIwaspjhO5IndSBaCfCFJxJEmu+i5YNigU0HPjzUveqXeibLHh6FQqJuvVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOanit2uZns3Jymx+6t98EBU2jUIOtqBsRPC8HCzDLDaLoqPN7
	r+ZRNOdBM+kkU5sRYvF7RVYqZK5jbfFFPm4d/GXHlfQHsLNWndiqafBuLMic0DD81YQwydw8nCF
	q6VB6oP4/z+SnEYJsTdeNhUb1pXkze2uIbNmsRXu92qoQfLcfYeKKsoni+jr3GhCoyA==
X-Gm-Gg: ASbGncsCGNRjIEUAERmucDH79XCxQUJUaYFUfjE4vbfwfWzX4+PeC3i3iHnoclnr1hm
	M2PA6Y2lyuEgF5LLalOnq5kE/ItEgmKeuQqkRmxLqdVXHzUOd2V6EBH0DVffXaduph7hsFjEvKY
	4amJwqKNxSL/gcWe6Zak3ev3znLbYuOOh9J6He9wd+HmfFtG61d3bdhi8S/SE8wF8nvsauHeBoo
	85mCPGq9vp0XaE3hdFlng0JOeP2ENvC0pPcD91SmLLMLWeA47olhZfKjRhgLMxGugRwY2QaYzJB
	O09U3cAi4SN8qLzxE9YIbLQn5XGeL0P0exokZI7plvRe3nUYZlGv51f2i9aL
X-Received: by 2002:a17:903:19cb:b0:21f:6dcf:fd2b with SMTP id d9443c01a7336-22b69430257mr54475975ad.1.1744305791360;
        Thu, 10 Apr 2025 10:23:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsOm6QHNFoIQoa9xAcmypmP2o9HLNTmyw9hqlhL3OGHmNMXVDtTazPYIXiQbNPMKCZ+GHi1A==
X-Received: by 2002:a17:903:19cb:b0:21f:6dcf:fd2b with SMTP id d9443c01a7336-22b69430257mr54475625ad.1.1744305790913;
        Thu, 10 Apr 2025 10:23:10 -0700 (PDT)
Received: from [192.168.225.142] ([157.51.199.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccafa4sm33459025ad.235.2025.04.10.10.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 10:23:10 -0700 (PDT)
Message-ID: <bb5a6a55-14f9-a854-c8fd-e059d34e309f@oss.qualcomm.com>
Date: Thu, 10 Apr 2025 22:53:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath12k: Fix buffer overflow in debugfs
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <35daefbd-d493-41d9-b192-96177d521b40@stanley.mountain>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <35daefbd-d493-41d9-b192-96177d521b40@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rirZ0ld0gfLYNDF9NrYPh2DWX-TUNYbG
X-Proofpoint-ORIG-GUID: rirZ0ld0gfLYNDF9NrYPh2DWX-TUNYbG
X-Authority-Analysis: v=2.4 cv=b7Oy4sGx c=1 sm=1 tr=0 ts=67f7fe80 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=wh/sLrVJ8DShde116VVCZg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=gMk---j7fasVHRGPvsQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=669 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100125



On 4/9/2025 4:31 PM, Dan Carpenter wrote:
> If the user tries to write more than 32 bytes then it results in memory
> corruption.  Fortunately, this is debugfs so it's limitted to root users.
> 
> Fixes: 3f73c24f28b3 ("wifi: ath12k: Add support to enable debugfs_htt_stats")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks for the fix!

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

