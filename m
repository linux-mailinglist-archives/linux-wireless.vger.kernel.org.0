Return-Path: <linux-wireless+bounces-16423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCF9F37BD
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 18:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C78188DD25
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 17:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BE825634;
	Mon, 16 Dec 2024 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IK6SNdE2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011ACBA49
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370956; cv=none; b=jOV2Ei0nkEYFXeaflC+2nsuv+UPqx11hXimjcU4F2HY2SWZSzcTi086/jOfXUSYVlrI60kmhK32LuHCZf8mvaJUDzKOMArz7gQhEdC2V+7tftytFUPnAILBTVq8WNTzkVGpQFCZqe8J+2hV2bQ0EhcVxio5MVCLrA8jFbGbGWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370956; c=relaxed/simple;
	bh=FzBgXJ2oqftrqGic3ilmm7FupGer4Xx5dLKxqAXHo40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryCFbRxR0vh9N+eOvthdvUQGVzrRl0zn91PzApO/mQaDfa7PxQtOYIp7cLQO/3Ygrf6cbGi3lyWW0r7VlZHzeT/LtPh8OmwYmJtlNY4C6Ms+pmThXTBUXQcU1XZnGnsEbsi8fkN9KlOSAdgtUEFsGFPGNQKzT+YtxzrRMqVTmhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IK6SNdE2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGFgDSN015305
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 17:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HjKOhOtfabRZ5nEO9n/1yOFFRqHnkg/SRrR6pEhJkhw=; b=IK6SNdE279w28Lkt
	9Xx7YTWL4jF2vNdy5Yo9f0CnBUn3rgKvFsg7kxPzf0knDDLWyT2vaIdt4FOtOqeN
	vVAhHyD9kJICC4WfBlHl9/D7ZHPj0j8rr4QoS4oOQVgdPve4NndocuMqoinySLTo
	8HH/ihrWR7F8pRnN02XAGduxTliyPaFZoYUq/x3e3GZzTHu8DNdYtxsknHESJU/Q
	ZvbywaDSNxdLZ8j2kQUbhldqHi5EgZJ3e1fowHCqqvpzcjzmtNSA+IQa7wEB46Z4
	CnBwyVZGEZJnoilsoWSpqyOj2vppOooVmCfBP1ZXzfW51wtaIOWpSVQBY84GotaZ
	hCqgkA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jq350ad3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 17:42:32 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-725d8bdc634so3551208b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 09:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734370951; x=1734975751;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjKOhOtfabRZ5nEO9n/1yOFFRqHnkg/SRrR6pEhJkhw=;
        b=Bd5WMAfIg5uODb9qRRtREgZk7jEg09zcJ7GdAdemH5kVDmy5WxDHKuCw7xMtwvnkrS
         kgELBIFimO8s8kss4UGKiKwFpzVON19vmPNiZPPf+BTZZKTGf7/5NShu8XO/RnFakmnA
         c7c68vx0sVRQnsrVv2iW3ZmIU9xRXVUbztUaBabUUyxD/MzApsVMvdYQTPvFcKkqeP28
         Z/9R2XHt/Q/9mAs/p4rSdABxHoCmqBXV/9ThikHQXcI36z7jItXgP6CcPIQuIX8MFDR6
         14Hg3egiUfYnT+ScaOA9XNqcAZQC17FVxiy1r5evx87ivnreQMVvdDqvEoDuoLOdI+cC
         XdZw==
X-Forwarded-Encrypted: i=1; AJvYcCW6dpH8nIXmKvLHzsNjc8XExvyfHa7g1LOLhPLhVUpNmP0vlx0ZguKhYKw4bNiPuhL4MCn6Az1EGto5uAImQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1n/C0Sm3g5mPVD8wktzsZDUhXm9yP2XBqT4x1qXK+e8jjhE2f
	2FQ6GJ+JvSWpttB7eLcQ3/zjKH7aoC575YXHMuu+WIXVQPlSrumh/z7UZ+VPXR7TfGsHssGNx7Y
	nCdExjzHb7YdTrS88AXtSZEaOeP9mpvR3+9yPz76dKX+o7hqVbutZ0332XAznvyvpXZmegyJqRw
	==
X-Gm-Gg: ASbGncuOvPgsgHj5oFbK1RW5QO9pUf7ACMrKQsIGM04fgq7+Kn24G3Px0rv8zyoD4nh
	7xL4oQJDJg5PrzOcs9RCVd5YjOHEHc8LYHPgkT6xx9emTegxd90nz798JGsrijJJaEN1rwrMKGi
	vCQzi+qTQEjFnPuZzsl/bdhkn8bP5wI6pAV8qARy2zyHWnBL+ZR07QMWlMpcD+EAUn0q/J3dux8
	UaX1gVvqZRVxRQjWL+p8yWVk9yXqe35j+Rup4ui/TFF4rtvtvcmCgN4k8IpXRm66CaCUWWzFafb
	bH9ciU1BVlmfk+CF13p0GdnaEysf6SE69+FmGCRR2I3akpujeg==
X-Received: by 2002:a05:6a21:394a:b0:1e0:c7cf:bc1f with SMTP id adf61e73a8af0-1e1dfbfbcc9mr21344272637.9.1734370951411;
        Mon, 16 Dec 2024 09:42:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9ZShurGJ6psrZg1E607y+KqkVBSLOzZJ4dyp3CDrawBJvh1vBEoz4BBtlBRcyCTb0aJAA4Q==
X-Received: by 2002:a05:6a21:394a:b0:1e0:c7cf:bc1f with SMTP id adf61e73a8af0-1e1dfbfbcc9mr21344239637.9.1734370951037;
        Mon, 16 Dec 2024 09:42:31 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c3297asm4385909a12.70.2024.12.16.09.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 09:42:30 -0800 (PST)
Message-ID: <20eb00d1-5d92-4a88-baca-cc0ccb78bd03@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 09:42:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath9k: simplify internal time management
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20241209155027.636400-1-dmantipov@yandex.ru>
 <20241209155027.636400-3-dmantipov@yandex.ru> <877c877tbf.fsf@toke.dk>
 <8734iqkwae.fsf@toke.dk>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8734iqkwae.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7ndOh7OaxWIF-rT_jXtM9ov4LBF5pTTw
X-Proofpoint-ORIG-GUID: 7ndOh7OaxWIF-rT_jXtM9ov4LBF5pTTw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=895 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160147

On 12/14/2024 9:29 AM, Toke Høiland-Jørgensen wrote:
> Toke Høiland-Jørgensen <toke@toke.dk> writes:
> 
>> Dmitry Antipov <dmantipov@yandex.ru> writes:
>>
>>> Prefer 'ktime_t' over 'struct timespec64' for 'struct ath_chanctx' and
>>> 'struct ath_softc' timestamps, choose standard kernel time API over an
>>> ad-hoc math in 'chanctx_event_delta()' and 'ath9k_hw_get_tsf_offset()',
>>> adjust related users. Compile tested only.
>>>
>>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>>
>> Nice cleanup! Just one formatting nit:
>>
>> [...]
>>> diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
>>> index 2f137856a823..cf664a0dedaa 100644
>>> --- a/drivers/net/wireless/ath/ath9k/main.c
>>> +++ b/drivers/net/wireless/ath/ath9k/main.c
>>> @@ -247,10 +247,8 @@ static bool ath_complete_reset(struct ath_softc *sc, bool start)
>>>  	if (!sc->cur_chan->offchannel && start) {
>>>  		/* restore per chanctx TSF timer */
>>>  		if (sc->cur_chan->tsf_val) {
>>> -			u32 offset;
>>> -
>>> -			offset = ath9k_hw_get_tsf_offset(&sc->cur_chan->tsf_ts,
>>> -							 NULL);
>>> +			u32 offset = ath9k_hw_get_tsf_offset
>>> +				(sc->cur_chan->tsf_ts, 0);
>>
>> This turned into a really odd line break. Let's just keep the variable
>> definition on its own line like it was before, so we can keep the
>> function call the way it is as well...
> 
> And since Jeff has agreed to fix the line break when applying, with that
> fixed:
> 
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> 

Please check:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=d953ce0fcc7ce69edb5a3a39ea3a98ba2347976d

