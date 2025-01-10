Return-Path: <linux-wireless+bounces-17342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6046A09C2F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 21:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7847A188F254
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 20:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5864D158DC4;
	Fri, 10 Jan 2025 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MO43gHM7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CEBA50
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736539699; cv=none; b=dDXwDupiM3oIWhjLifi4fRzkLY6eSALfTZX8oNeTl01z1nQCV9tZ2F7Qck9hFkBRSyic7pYxC+HbX2ZU8BzEr42J+A1Zu59bh02DAcL6DpvHQZsbquOVlchjRlJBiZmjKDZmTeYoSsLe0ZUMeKfdMJvOiSf+R3RLDVnRHjPj81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736539699; c=relaxed/simple;
	bh=QZMhUer2LyoAlS7yeyGqaBuvSG+AbEXKTzsJ24PKQVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2jtUj/MTeURxCoJD36neCHiHYcxID2+rYwRNFT/u4o8EBH5Im7z3tlUG1fccJ6H+Y2zTLDmiMbpD5HfzW23Rmo+rgSivC8JC0n91nx0luTvY33f7xluqn0RdThf81jwUb5cWcZxL/rjGPRGZwbYe5wZLGgDki2FNKxPiPSTlzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MO43gHM7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AFFDaP004642
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 20:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sF7gexX3j8oIJVpcpEigxvZYGq7MjRbFVfqVXfLEDrE=; b=MO43gHM7HYv7SNV3
	oyFw2C0J9LVI+Kp6ct5OeEauoWts23kOAeoSeAGS42DdfrqreDye9WJxDNjcb/LX
	Ppqmf0Of8wRAFfd1YstG7p1nz9tJC6a0ONgjYh8WDUDvrdRGtobP61tsPGMh4NuJ
	XdxGiBa9xrxbIIplKBWGPyvE7S9cCpa+jmr2mVS7A8R/h0M2NwmnEwsm1PdsEtyR
	6FA4LmaxCOASG7fpZZyyC2t4FfYSZHawSXBacPOuh1uYB/Izd5BJu6PKek6oQq1H
	eLxiBPJmY8oYqXXKAeS19dF9BWE5ia0EfPxTKgOpMn+PPSCF5WtSxBxmUAdElnJ4
	bk62IA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4436188pfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 20:08:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216728b170cso47061165ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 12:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736539695; x=1737144495;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sF7gexX3j8oIJVpcpEigxvZYGq7MjRbFVfqVXfLEDrE=;
        b=soYZLslLlm8nQNDUBvx6DxRYFFRVsC/xI5qF6WeZixaziD0w2cpCDxaZUs8Y6CjdwJ
         bTyCcm635GKTqOcnRzqb2McY67NCUgOOGt3TrxHl3smf2VsGwLvYF/i6VZdRDy5mDvW0
         FyLdDgDX3TqAL4e7bYwrQD3ECkh6wrzYyawjY5JGL7Q1/mW6libYrE87MoV5lcXtyejh
         o05XtGRylJXC/QJzqEo8WOkXI2Llv45u+98e/km9uB1rPeG/WWUoax3zzvjBQIcwfVnb
         bH2w3dgczq8mKtKLY9us2TiknVuVutLg8S+NPNQUubbF1NWfzFqAAbAhxxkM2R7dlAo1
         hduQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgjC+xpTVaKrafloPszRpREw9s9HNw5in97psZ8BwKkTSj/ZsabRV4CYspO6gW1glI7hjdi9qpKzTJRryS9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8b+xjIIzbUiMSbHsszJFOpGZtM5AmN0eL0MfZOziF/WOnI/wy
	wbvmzCcXeK9LW8JjglmGMc5UOjHrKu7ktIktHAlA9zTul29lpbgPOLGe76zqPgMGE5D5E0wVUji
	EdV8FMojvXweSzqd+/Mg1ZAJfswq8okoKiCERF0/gUQh1IuTvkFsyuoDZd3Oom3D+wA==
X-Gm-Gg: ASbGnctnRps3sd6JxOZnTACDIQWChDOuJ3C2zH8n5uo4we4hzVJzirQKzhPienvYBHb
	yk7k3h+JW80PqpFg0UbIYME3DeF+U735ZDnIiHHJtw5oWxNnZ5wwtb5n4rGE1kPDkNdtnkZw0Hm
	NTnldsyjRxk6ehdiRrpmYFHTn6tB6sugd5q5OxZdRmtFpWAD0Og1uTjqZEkCO5xjsodWRVHccCg
	hNjRJJX2EPLS3nkd78pmB9XyISWxV3v5zrWMEpoUZT4Sst4aHTLTX5W4u/venCI8dKR8zTtE25a
	LyPXhUxh4tRQxhHCOG8kCH6ophUj9NMPg0j+Rd74k6Ga1WfYnw==
X-Received: by 2002:a17:902:d552:b0:215:96bc:b670 with SMTP id d9443c01a7336-21a83f4c0b2mr153536065ad.18.1736539694669;
        Fri, 10 Jan 2025 12:08:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFaHkvldrBPu+zvovOGOpXeuXA3jKfM6OoiGi91XLmLHzYBU6GvrCYFkaoLCC1ciQV/LZayg==
X-Received: by 2002:a17:902:d552:b0:215:96bc:b670 with SMTP id d9443c01a7336-21a83f4c0b2mr153535665ad.18.1736539694238;
        Fri, 10 Jan 2025 12:08:14 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d22bsm17117895ad.189.2025.01.10.12.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 12:08:13 -0800 (PST)
Message-ID: <e6ae2b06-0cb5-4453-aa40-881a5e18e207@oss.qualcomm.com>
Date: Fri, 10 Jan 2025 12:08:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Support Transmit Buffer OFDMA Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
References: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
 <20241128110949.3672364-3-quic_rdevanat@quicinc.com>
 <87jzb6flwz.fsf@kernel.org>
 <c776b5ee-0e25-4d21-be21-dd318ae33d1e@oss.qualcomm.com>
 <c022493b-d009-4a1d-9fbd-219a3ecf84b6@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c022493b-d009-4a1d-9fbd-219a3ecf84b6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8wWAtxIPfsq3tGNR-uADwB7iKWinRnZe
X-Proofpoint-GUID: 8wWAtxIPfsq3tGNR-uADwB7iKWinRnZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=960 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100155

On 1/8/2025 9:38 PM, Roopni Devanathan wrote:
> 
> 
> On 1/8/2025 5:08 AM, Jeff Johnson wrote:
>> On 1/7/2025 11:45 AM, Kalle Valo wrote:
>>> Roopni Devanathan <quic_rdevanat@quicinc.com> writes:
>>>> From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>>>> +	len--;
>>>> +	*(buf + len) = '\0';
>>>
>>> Please avoid pointer arithmetic, this is simpler:
>>>
>>> buf[len] = '\0';
>>>
>>> Or should it be just 0 instead of '\0'? Don't know which one is
>>> preferred.
>>>
>>
>> well my take on this is we have a lot of similar pointer arithmetic already in
>> this and other debugfs files, including all of the scnprintf(buf + len, ...)
>> calls which could be scnprintf(&buf[len], ...). And we have existing instances
>> of trailing comma suppression in:
>> print_array_to_buf_index()
>> ath12k_htt_print_txbf_ofdma_ax_ndpa_stats_tlv()
>> ath12k_htt_print_txbf_ofdma_ax_ndp_stats_tlv()
>> and others, all of which assign '\0'
>>
>> so this code looks ok to me.
>>
>> that said, while i've been reviewing the debugfs implementations I thought the
>> code would look much cleaner if we had a wrapper function (or macro).
>>
>> Note that the input to the current debugfs functions includes a struct
>> debug_htt_stats_req *stats_req that maintains the buffer pointer and filled
>> length. what if we had a wrapper that took just that, the format string, and
>> the optional arguments, and all of the pointer arithmetic is encapsulated in
>> that function, rather than being open coded?
>>
>> so instead of:
>> 	len += scnprintf(buf + len, buf_len - len, "some string"");
>> have simply:
>> 	ath12k_scnprintf(stats_req, "some string");
>>
>> that function would extract the buffer pointer and current filled length from
>> stats_req, calculate where to write the next string, call scnprintf() or
>> vscnprintf() to write the string, and then update the current filled length in
>> the stats_req. That would eliminate all of this housekeeping from the callers:
>> buf + len
>> buf_len - len
>> len += scnprintf(..)
>>
>> /jeff
>>
> 
> Since there are a lot of instances where this change is needed, can we raise a
> separate patch for this? If that is okay, we can go ahead with the current
> implementation in this patch.

Yes, I'm taking the current implementation to ath-next

/jeff

