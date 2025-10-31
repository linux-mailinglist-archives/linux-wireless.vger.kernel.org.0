Return-Path: <linux-wireless+bounces-28449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1BBC25C6D
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 16:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091D41A63788
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD4271479;
	Fri, 31 Oct 2025 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OhaZr3mj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KL/RCdfX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C70A2820A4
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922832; cv=none; b=OegI6xwk7ic81VjfKw1MeB41zE7jxpeAGiCyh8dpx4dQs4ZjGE6+BSeigkF1nK0blsZodAeTjmKimCRdkCOZNngxUwbOimc0vXZX0izfK7JDKqrk2V9n9tQXuXcRukm1C/NZHq9KnAyulLbL8Nw/wGCjgA9Xkfs3pZL4+VIYILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922832; c=relaxed/simple;
	bh=/hdd5AdlyqhlrueEU5Lqqj8lDkZ0EpfGrWh6YhqyV3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgPq4iuU98jg54bW/zSav8NE+f3RnsQ7O3ONyJEXLWRFROCSNMo9W+YOnHjSkYf15xQP9kNgjGRwYhPJathpIGD9olewRes8lJdBIcJeYOSJekU9zIYXpavcL1z94H1iUOZ3UkswKNYcanHPq5Uk9pgSJMGm5L34PlZQj+SSnAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OhaZr3mj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KL/RCdfX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9qGR91513952
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 15:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/hdd5AdlyqhlrueEU5Lqqj8lDkZ0EpfGrWh6YhqyV3g=; b=OhaZr3mjgOMhQ3KA
	i5IsPrjX+fJxfY0ns55gYzZtnI13PISV02vWSBtY2vnqE2h4FONrqMG5VJ4Iuf5Z
	Kk3ZPdwBosznitWu0NonYGLky0phEUb1C2KQgDQKv+Q7ZoCvQj/pLBALVFw9t/xV
	8vQaVvcCJSQ21ytPP8VzP3HoFnkfqUM9V0tlDBEhFRSYHdfORRUc+lQ2A0/7t4dA
	A+jO6T4NyIX3NmQDf0j36AADRO/f2McTAL9RUhmPE6VGwSYcTMvUIMRRdQkTY+Pz
	s14GLgaZKQSfr7to3kBqGnjg8EX7rVGY4pcylqLZRGDISrUtXQy/dHGfpuSr8zAT
	eJqedA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69j229-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 15:00:29 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b60992e3b27so1890859a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 08:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761922829; x=1762527629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hdd5AdlyqhlrueEU5Lqqj8lDkZ0EpfGrWh6YhqyV3g=;
        b=KL/RCdfXHk6lrkmDz1ixEIRQINgIiE1ZgWiPpng7T9jD9CQI63o9Mou9T+5SNzJvyL
         xVwS0zN6iRajVG0irksS82aLRmnBjIpWaBlKq099RmONlTpiaox0jkBXViKmua5F/zHQ
         wVSzVPbzsOXSvk3eIiNavRwKE/1wQ7MF8+YXWINc/8gLE777yCO6SMisgQduLUGlgulO
         ED42BcES8HUsTlRemycOS2qlf0q7eDJcQygDpbeicPZBe91xITgBgAiGbTk61wJB1b7o
         4QpR+Oy6IYcl/hETwaJX/eVG5GRw296/eJTmDwAyLA/7ameMt4Wd9hOnxsJitIF6h0D3
         P1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761922829; x=1762527629;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hdd5AdlyqhlrueEU5Lqqj8lDkZ0EpfGrWh6YhqyV3g=;
        b=o6S90M/k7ElFP28RwhI1EV8h/Hq9MvtTDkFhytfvGpwASa+595+82uQboR78WGkR5P
         0o45+w9cesbj0jnMLsKt7DbDKsp1D29XHgZfj4Z4ffszTYRLiCnFh9ZSgtwrsJvm0oaM
         6g5o7VSCNjHRe2JQUBw8XrpmJS0Zx5D0+eTAV5VlX8P0RXwlMlGyottx61xeM5imU3F6
         mCYk0AGEoVDcQ1fGtn20YHqLJ0UHHRfwEquhmjNj2sWe9c3Bb3p6+RxW0tiEmfEP1NzH
         gLUadsQ2KAf6QuUqA6DeB9U6uT6zhK6zTVKzpAmDZA83ay4SpO0gaWR992NYJZc9MVDu
         76qA==
X-Forwarded-Encrypted: i=1; AJvYcCUu67WJSEubkNq0eKoIDnVdMY73LhS79P1aDhUdUwCqd/M7OyfXorVo13sjcG1U4pIfpDNzzDHCdR2KX0Cf2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYLGma8IqoC9SDjUf8cXAB1wql444GaTZbXNAiMQUA6PVIvJju
	sgSRfXmk5kFsey88mYCl6CuEu0mcu8b8wem8M583pnGUcaVCOS4mt+BCOK/vmOE7C7kBkJsFC8h
	BZahi7Y6mBmr2mq8AnDYKcPGpLmP4hEqYgElbMC1oCZ4q3Ky9TOlHPf/NeBlLU+jTc3zInw==
X-Gm-Gg: ASbGncsmJ0lOMThYnfGJgG4iSbQBl5hcIWzPRRixx7yL64Rq2mYWU6L7SZc6Qo3k1Jw
	rSSAuxDzjA+UAJOt4QwEHi5BJTiFjPPikrk/Zddrdn4c5dCSkLo+yLsJvP5FwK9MNTTelHwdPXb
	IvO9v2zZgDhl0/kAHINJbOLJx6JhAKYF0nY8eXdE7Q3N/bmghJ9mdFkYZAE7Kf65Mu3FvhuAb2c
	EGuLfJ6fGTbebRjUtVF3tRQlBR57Kx06xzIKNa2sGzXYWwQfDaUXeC6VdUTns7Q4DsGqVZsgLkF
	S0OrfFPmxewiu3WhkggVR5XjJLd1qrP1mCfFnNHmVlu/a/wP2RMFvkaBmtaPR/wjA+HlybQQuY6
	U0yBY1At9xkEamhC3kkSCmd9lvzsvZHvZFz9xc4DEYvdU7r5Q4y9waru5bHc=
X-Received: by 2002:a05:6a21:328b:b0:334:a784:304a with SMTP id adf61e73a8af0-348cbda98damr4637297637.33.1761922827117;
        Fri, 31 Oct 2025 08:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJpt0ufWO9x3SKiQY56jt/fiq8lIxVlKFj/qtUdM1lTLD8M7JszPy/2s5xZsXeb4DmTiz34w==
X-Received: by 2002:a05:6a21:328b:b0:334:a784:304a with SMTP id adf61e73a8af0-348cbda98damr4637032637.33.1761922824816;
        Fri, 31 Oct 2025 08:00:24 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be5ed9e6sm2385181a12.27.2025.10.31.08.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 08:00:24 -0700 (PDT)
Message-ID: <6de0a467-14f3-43e1-952c-b8cc7eb4801c@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 08:00:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath10k: simplify
 ath10k_htt_tx_mgmt_inc_pending
To: Zhi-Jun You <hujy652@gmail.com>, jjohnson@kernel.org
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20251031111639.406873-1-hujy652@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251031111639.406873-1-hujy652@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PClckpDulNhMmasC_M-E1cDLJWlmiXjw
X-Proofpoint-GUID: PClckpDulNhMmasC_M-E1cDLJWlmiXjw
X-Authority-Analysis: v=2.4 cv=OYaVzxTY c=1 sm=1 tr=0 ts=6904cf0d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=2MrtifnGaRrmffXHbPQA:9
 a=QEXdDO2ut3YA:10 a=D0TqAXdIGyEA:10 a=xa8LZTUigIcA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzNSBTYWx0ZWRfX2Tt0o+ZDvq4y
 6Tw6c4ymlQdypm0laSoeB2wO9inT4TfYqIJKGXoeT53DcQassU9ePaVSYeMQUep4cLfTpl1ro0m
 g1HYtY1Cs2/e4Fc1/FJhxaODB08P3ztHtdHW45PCyLo5kah/XAVoCX0ZFbmEuw0u4rT3QQcoJjA
 OZ4LodNzSkiDBadbK8NQAqfYI0GCF80SttCCFmuSiTcKyKZJWNqVufs57zZkFsbfbN1JlE2usMk
 McziumPE+fC0uPY92twZhKVfhP9zptCcIsnAKRPwnO2VIAiITIgC8gXUPQcg47iAhbB+QnnPo0H
 v7OvTb2PW4cXgaZbF6aU1IkDpEikIaDTH57d7ewXGc/PbpfK5xPFuUKtT8MlnpKOnrXsTwlC5X/
 S+MLguy4Cz59Rp5/sfZy8BIdI5YmcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310135

On 10/31/2025 4:16 AM, Zhi-Jun You wrote:
> Remove is_mgmt from ath10k_htt_tx_mgmt_inc_pending and make sure we only
> call it when it's a mgmt frame.

This fails to describe WHY the patch is needed

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

