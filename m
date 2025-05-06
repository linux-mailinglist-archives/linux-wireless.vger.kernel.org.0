Return-Path: <linux-wireless+bounces-22668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C5AAC837
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 16:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE191C43692
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37411862;
	Tue,  6 May 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FKeAzIjF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9326C3AC
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542238; cv=none; b=O6+bob+0V1TI6inC1uRR9BQGqnesolduHZIIU7E2UrCEG2kYIqxw2fcjnlTtOJE2y7GlU6cDYE381AwFGQJojI3vao6YfsenYsV1JBVqM+A7HQqd9srgwwEJTgLrrmTjJatD5Vv3YA38nrlyxq+KM6+YrLtx9zB2BnwkSvzUZTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542238; c=relaxed/simple;
	bh=gAp27/Ze9e2YYINIy6xUzVwvaYKKwzKkfB71FlkQexs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVPZrQ371Gvl5cv+6Wxoqejtn79QTsxW3+/VkWwQe5RuVC4+54CyrSm+b1sXXOOwpf63rCwc8xG5a0RXOdN7bVpk+YIRgc8IOhjSZIvf0ErRkRdzuDjwey04aao0AIokApqy9YyJftcC350K53V79iIv2UMLBksrhhVAmmoo+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FKeAzIjF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54684nml019171
	for <linux-wireless@vger.kernel.org>; Tue, 6 May 2025 14:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w9LpjmrGsa6KX7k5o+XqftqcUhIlGQqLrDOSXLFqivg=; b=FKeAzIjFZSe8hmlV
	Ag0PCJhlwM9BmaFqKV924BjtHgi71yLZlu8S9bMkQm+EhAZTVig1ZOYpY/itFboq
	AhEli06XAm47ojMr2Zzfa67OFOxozoMgMwkqYRoatbXAK066ddIvxCxQbf+QQscD
	fkDUT+F3xapbdjZVnFbLjnrDH78unaZ9iy28Ns1K6kL52Nr8NqeDVwq7hYesJH5V
	daCBhleLPDSnReNRb4QjDgMFjKiZFCbR88cRNnWHntdJil1lSdhIlJnjeTIJ4PjQ
	6qSsdEByiu0seq7cZ5DOzdfUTzI9LBbsJxyUES6FveA6nGfL/Wkcu0iZKMys3qSY
	bSDuhQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dbwfqtsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 14:37:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso6471129a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 07:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746542234; x=1747147034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9LpjmrGsa6KX7k5o+XqftqcUhIlGQqLrDOSXLFqivg=;
        b=U4FTpcQY+zlhR8Ik0UeopcqwHFlLxuK7AtNxNiIFRHaIch41K/JFT0rs+X5kb3TgoQ
         wqijPQZucnNiFpkzuVqEFoJqqXyLe9bWufRUIN9gG3EkfTzOphkbdV+R6T0pWa/ygrDy
         521a5NWHdfGpADTgNDh/AydR/ZGDft4G1Jf3Na36wVLYe7wOqJ/fCKkMxld9URxG/JA5
         Ug6IYqV25J0AcFd2TGhuofVsK9ypaIJbKXWkgzOGFEWcHC0VNdBuxD/bZ2mLbbLgQB3o
         AXB+rwxhspaQTERfYmAldxR1OOyZVOe4PwhtWF1qyQVC+nTRea3mkrjTt5vanYFDW7xl
         UHsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz38lTL8icMGrQr12M3IiB14vLuQG9DQl8/Ljbyzrq3cZfiY5rS5H83gbQFEUX1PcnKHwK1l/AYLv8tUdzDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFakp7z9JSILa0rkoGMw2k9E37HYY6mUUKUyShBqJgAcTgkaV
	9YmbOk+PgqQZxaRuMa7Ai1AEcMA/bp3XAzrYkSEWVsOPe6FmZibP26rbTOerA3vAWenflk2nxEp
	o4X9rDJvST3rjlDMoMbhO4jM6Jc0uXQq9lO305Tg5I00ddF31LLhGOaOb6/4sPtqMJw==
X-Gm-Gg: ASbGncvLV0i6+8LCr8TXwqsSwFLhySq8DKixaIyzBhjLnzCJwfgdmIY7NlyALEMuCPy
	hOIoqyJQm36jZEisqo0khaieQPpg88gUr6f1x3xQQUTN1Y+6hVPwy10jz85BJJ0CQoRaWiOFUSN
	HxOQgXXvo3CKKi+aGRttnnbdW8mnoStu7d4PFFZP1ElvXwQpfaUo1pkfnurAOKkOEI1xPePb6Bb
	OVJICP23soF4U1WZXMQGQ1bZmn0O033RXPIxpXM7J2y8uT5Pm8Sp0dtyRyCYbjpklwB5GGIlFpV
	/pHKy77gYAvxdtqd6APcXhaAkrqZPY1NtuFyciQof/oxSYiNPxtfu4AWjraJhB850R4=
X-Received: by 2002:a17:90b:5748:b0:2ff:592d:23bc with SMTP id 98e67ed59e1d1-30a6196eed0mr17318774a91.4.1746542234558;
        Tue, 06 May 2025 07:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkwRQ3DLQif47yvq8WNL5KJa0f603vHTBjUKMr03pjsCSwYyfE0Y34FL2epgwqjP8ZEZIHlw==
X-Received: by 2002:a17:90b:5748:b0:2ff:592d:23bc with SMTP id 98e67ed59e1d1-30a6196eed0mr17318740a91.4.1746542234093;
        Tue, 06 May 2025 07:37:14 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a47477a3fsm11334008a91.20.2025.05.06.07.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 07:37:13 -0700 (PDT)
Message-ID: <b21ced75-b239-43ad-b4a1-293300b00eb4@oss.qualcomm.com>
Date: Tue, 6 May 2025 07:37:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] wifi: ath11k: Fix memory reuse logic
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, quic_bqiang@quicinc.com,
        Jeff Johnson <jjohnson@kernel.org>
Cc: kernel@collabora.com, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250428080242.466901-1-usama.anjum@collabora.com>
 <f58075f7-f643-4e47-b774-dc529aaa01e5@oss.qualcomm.com>
 <ec0bb100-4a70-4827-86b1-e4a7e8867a2d@collabora.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <ec0bb100-4a70-4827-86b1-e4a7e8867a2d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4YVIa3rTQXmzjD5oxJXP7NqZULxm50eU
X-Proofpoint-GUID: 4YVIa3rTQXmzjD5oxJXP7NqZULxm50eU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEzOSBTYWx0ZWRfXza70FcwMiXW/
 ywcK+DDtRuWNiroMKeZwOWujzcdNsfslyYXuuB7yLdctaoN72Dc9V7qBmE0hN+92AOfcnahDugf
 s4ClNRJ7aRqOsqVuaZ9+7xO3C7XRFQf4oOT0GFnbt2YbAg1CNNwORYpbe36HxKPsdn6H/sDJQWH
 GQfTtJTNb/IovY5OY6gzveLvfMDvNXpmQGyXSOFLJKnKUmaOf+7JdwQo7DdHXpy5oQYin0oLBq6
 bg0hkp/fN0W+tQPizDT644mMj230evI/FTUFVXyoZoTnTrYO3VLtV8eohODPGcd/g1WSAnKU5Kt
 OA8oAZD5AfjlWl3Y+EzIwiwnVU4qKv6no69gSzcF+WQTnMiM6ODNxtOJsSIdF+edn/gldS67381
 zjx7rGaUxWhaD/hqAjm/TQkWRfqsePw1wtTyl+Cms16ikhcIau6+B0iZFULe7/Dy2yKRJykU
X-Authority-Analysis: v=2.4 cv=AfqxH2XG c=1 sm=1 tr=0 ts=681a1e9c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=SFZV7YdHstKF1boNYpMA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060139

On 5/6/2025 6:10 AM, Muhammad Usama Anjum wrote:
> On 5/6/25 12:17 AM, Jeff Johnson wrote:
>> v2 feedback was not incorporated:
>> For starters, can we make the subject a bit more specific, i.e.
>> Fix MHI target memory reuse logic
>>
>> But don't repost for this -- I'll make that change in ath/pending
> I'd changed again on the request of another reviewer. Please feel free
> to change as you like. I don't have any opinion on it.
> 
>>
>> However, does ath12k need the same fix?
> Looking at ath12k, there is similar code structure in
> ath12k_qmi_alloc_chunk(). By adding some logging, we can confirm if
> ath12k requires the fix or not. As a lot of code is similar in both
> drivers, ath12k may require the same fix.
> 
> I don't have access to ath12k. So I cannot test on it.

Baochen, do you want to propagate the change to ath12k?

