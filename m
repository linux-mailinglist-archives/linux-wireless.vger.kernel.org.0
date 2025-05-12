Return-Path: <linux-wireless+bounces-22878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B16AAB46D4
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 23:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62B48C1292
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E5D299A80;
	Mon, 12 May 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlfFWoqH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356124EF6D
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086960; cv=none; b=rgVQ9QBOo3FLe+VLi8MJWYGTIR/ycITYTTQ1S4MAV/WeAvFP9nCGZ7Cd9avxELUShz3FK+pqUJN1w9k0PL3d7tAMWE3fpN7uJqToHBMVe4ykgA9dV2Yhg7WbmBPayvZfN9cR9dcdeJsSYAIc81cLO4gDB//8w5yQa7o5yX8xqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086960; c=relaxed/simple;
	bh=o+Y172pPlc6yb/o4c9woIWc3ABoulDszVb7hP8rcNyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MadsoJqt+c08xmp7VB50DEEpKKBQ6uMpKE2TT7qCQGkNVAVcvXLUrGaAz41slZcFzCjj3lC1DB+ZmszOQvcOcn684+eIesKBbV7TEe3OTRk5yJNtPl54CeJva+vQqQkpQqtu6Q2e3dr620dfgzHzhIDNDj5Qhm31030HysYdJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlfFWoqH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CIXetW016839
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 21:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KbjFbDL9z6EXyAD+gv+b+dQagMxqs55xDaA2iKBmiuo=; b=hlfFWoqHiFp39aYY
	hY9d4bNQoD9790zQnCn6qBQsB+ThgaOdBzupnpPcKtjMjzIBh/SwfbueqGeLuWsp
	SLj8RpSjsGjDXFENQtEuxHz3THDkRS33N7vcM7D4/qa3pNlET6IpQpZbVzF5NZDi
	0JU5Vh9u11rT2JhezlWiHqw4xjUVf/SxeDcOC51K6dMxcFHAyzQBLuSDFijYT8cN
	CSYuugRgdsOZsaDcL+B1EAZxjTzmFIQdwlkq6xzuYkTiiL90OMY7eQY4Ci8rhtXm
	Q26xYsZjTO2F6mQjURdr/nRW6b4/o+zEZJpIlgi7tOmL72MGRzlDCeNp3h8h/cC2
	celPhA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hyynwk6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 21:55:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30a80fe759bso6611080a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 14:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747086956; x=1747691756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbjFbDL9z6EXyAD+gv+b+dQagMxqs55xDaA2iKBmiuo=;
        b=boVYu2xuaAuHyI+bH3fDph8PBZKJ0StzS9TXO0JBGILvRbmK2donqPs971/ncbwNLA
         SGXfataNBYlktBwQsaABR0yTJ/1iLro5Zyngojy3dTPbMLVG/lfI921H1qChItq7Xm6x
         iKUdNqr2vAHeYz0A/Kjx5fmYX7woSIQOytqrGHxcvpI/Ocvax/retqsEQdZH9UxzqGsC
         cZPfACIl7/k/UfkAWkfKHT9TvzYqX64niDMZmHFK1bnaCvKE4JIZqjjXu9501W6N5fjh
         v6LetyDslk/n1vw3ziICGUm6pzoJVioak+0fBdfM6opZHVVEQ5CCmXYHaf4azi4OFERN
         p6Qw==
X-Gm-Message-State: AOJu0YzrJ5AcPg5h9ew9tQS4HwMXmHqrAYD7yr//NpCgu4cKzRqd1kid
	eUowzz4QkcqCKd9Nt9087ujatgGZZ9PK8YNrfgfx6u7d9tQcyWB5tsfs1tzwabskmKNY/Qmgg4K
	5EUhyZAx+c+uHfj4k2SvgMZs/gevB0IKWPXeIaUmOPRLiUnwe2MBXY1mKVRqHsfXf7w==
X-Gm-Gg: ASbGnctjjd9NbYbDH3EI4FP6zzcM3SVyB+kjYuEhBAzgFv8WKmsLap5okMActV/Hzy3
	s/bf/Af1slQxwFmkd0mjycZteMwODHkA4msgmcWUjJb16ilA6g9z82Zm2TnTQjw/R43yDKHdB/C
	oRaVl8DyuCEJDrCajRbZ0RV1MUnCvRV1LPAfjpdsfMseKq79SVqi9FZBDh6osRmS9tnZrBrVNEX
	5Ee7rpp7QKoa0126azTI7Y/7h59Xy0EHzBFqfbNfspWNz8SGcoAwbE7Kk59QfDc5bGsY/DoaeMS
	4UbNPpl5GlWB7nZP8y1A3JrF4+Wm8i/G7dVJa3WRdoBalQ0rlIVsZpiebq1YbjsrCrAKcYDE7D+
	1Ka0G
X-Received: by 2002:a17:90b:1d81:b0:30a:4f0d:a6e7 with SMTP id 98e67ed59e1d1-30c3d0eac82mr25944872a91.14.1747086956401;
        Mon, 12 May 2025 14:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJE6X2htOph09O3lnEiVt0+I0PpYcgKxpjL9LlU76n0IU0An4p0s0Uio5RdewmKUz54ZlqVw==
X-Received: by 2002:a17:90b:1d81:b0:30a:4f0d:a6e7 with SMTP id 98e67ed59e1d1-30c3d0eac82mr25944842a91.14.1747086956025;
        Mon, 12 May 2025 14:55:56 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dd4b87sm7245003a91.19.2025.05.12.14.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 14:55:55 -0700 (PDT)
Message-ID: <52ff43fc-160c-4efe-ba9e-42a0c838fb3d@oss.qualcomm.com>
Date: Mon, 12 May 2025 14:55:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix scan initiation failure
 handling
To: Vignesh C <quic_vignc@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250512065849.2833232-1-quic_vignc@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20250512065849.2833232-1-quic_vignc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDIyNiBTYWx0ZWRfX6nfdFVRQ0LJM
 0xJKLDVAhNXUth/lGwG/3jJG0q2/RnUAetJUp448RY81h7cL+NRbDJJ/Tf1REVAm15nZIWHQoWS
 qgw+i76lG5YKApnB1rw1neecKp7sjfxjgQuIOyduPXnfeGp0x5B4o34B+iMn9TMM0AIFfXchXmE
 vzyQtpU2t9FRWHLi2XTHcf1kjjs4cvLRUlfwNeRPJYzmP8ze8AqMMDzF3kF+3SSSUkRrSx/XSTg
 6R4RB0VNjSMbbI7e+eLBEtxvBaLmj8UO5iApM3LVccO12pC3MUN+n6kT0tsa2W94FCdVrpYoQkS
 ivRkJsFSNuy7aF7CSWLTq6zLs8LEbiGiEfY4sYxhgkIqpusFg1IQoKG3dcs4U/JiOh1xUfpnNl+
 jIgzezKCBut57o2ssANB9zKmRptVoDmIohGAz9pZnEw6nza4B+OVoXGGEMKo5uzrGFo19HoN
X-Proofpoint-ORIG-GUID: bOyXImzaOPmO_ezDKkBd2pmWsr4MLjzf
X-Authority-Analysis: v=2.4 cv=Uo9jN/wB c=1 sm=1 tr=0 ts=68226e6d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=Llbn9g8lkstppoHvQ9cA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bOyXImzaOPmO_ezDKkBd2pmWsr4MLjzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505120226

On 5/11/2025 11:58 PM, Vignesh C wrote:
> During a code review, it is observed that in the scenario
> where scan initiation fails, the current code schedules the
> ar->scan.timeout workqueue which is not necessary.

Are there any user-visible effects?

> 
> In the scan initiation failure scenario, exit the code instead
> of scheduling the ar->scan.timeout workqueue.
> 
> Compile tested only.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

If there are no user-visible effects then I'll drop the Fixes tag since there
is no reason to backport this to stable kernel versions.

> Signed-off-by: Vignesh C <quic_vignc@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 4dae941c9615..0cf2b3d06c3b 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4647,6 +4647,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
>  		spin_lock_bh(&ar->data_lock);
>  		ar->scan.state = ATH12K_SCAN_IDLE;
>  		spin_unlock_bh(&ar->data_lock);
> +		goto exit;
>  	}
>  
>  	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac scan started");
> 
> base-commit: 3a64d6def8733e75909abcfab983efae92dc4102


