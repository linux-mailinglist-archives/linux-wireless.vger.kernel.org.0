Return-Path: <linux-wireless+bounces-24777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D738AF5FEC
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 19:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2263B1886B22
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 17:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1372FC3AE;
	Wed,  2 Jul 2025 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QI7URzgI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BFA301123
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477114; cv=none; b=J5CQyPpFjMxW5Hw7sqMgto5gurRF1ks2z+SHR4Nan/nojiuVO/NRwaPGJQsPl50PseabSk1RqeIMnuLfLjMa7gTc8WfoBgzivG7XupX91v4w5kXKzupfIfn47fAjLY1utZCZf62/Y0prze6Q4sgLqkpBLE4fg74Lv4wipVtJKzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477114; c=relaxed/simple;
	bh=WZyYTlWdSGjfbQpzDv1VK2XsfyDqeUoKt+82ACxQjtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3g/ozlIF8e4kxO+CaDzwQpVt0jhMgEJtipRZ2z8nAguJvEENUnxYAA2H1ZfKJL106zfprIdYWSvhpPvzE1SIIsnEmNrWJHktSBAmPH7yaa5NyaIXpQpzIUlX78p6Qo9dQanKFQX6imvxMNJvqJ+U0roon9IlxotDZVWHTK6zKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QI7URzgI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562AG866022671
	for <linux-wireless@vger.kernel.org>; Wed, 2 Jul 2025 17:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WZyYTlWdSGjfbQpzDv1VK2XsfyDqeUoKt+82ACxQjtA=; b=QI7URzgIoK97WDeU
	W7XfEdAkMALd2S9JLF7oFTq42JWw60Uf4B7wVXDym1R04OBPUAMbW69dS+/XPfFW
	ymM0Pe6IVAethNd43a2dPwLwJEAQIY0MRZyvMgfhwLnAKRsn7OaJcq+VI9fKWGgX
	6zANcbxt51nX1fS32u1P0Ej3xEXbVn1rJbKtEYtCTu3/HvsKjXJF8T8TZrYUehUa
	jaJ0w6/QcNm1fAe9gGJjnL1MLFehJlGVbzBtLd5/V1eIEnsoaL7l3cAVvT/U+T+b
	05e6ySKYb4RO1/vHqevrVNWv6rrbeqemzKR6ZVlflSFhrNcL/5Ck4bQpBGL1KxTv
	o+cwug==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47mhxn44n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 17:25:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74ae13e99d6so88170b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 10:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477110; x=1752081910;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZyYTlWdSGjfbQpzDv1VK2XsfyDqeUoKt+82ACxQjtA=;
        b=hIqjA1M+AaVvTozNRbFxxAlEplE1fblFXYtmgen0QVEdNko7vDGQKfuHnWWpATmJhF
         F/IiU3vzVYOh08nqxm14RRWBOjkjOKEgYtamWYSG8vhQkSco3G4bh3UnQIS3DSrE2YvR
         b/fLKikhiL9xpFZ6x58vRJGfe3tF3r70/9xRBv0AdszetNBQOreCmMZt/N1SS+koKTCt
         bUwOuSbSh1g3oubpD4qx7lAgxlKfYAGYugcDgyOM8SKa3xsQUseWlxyOoiGWkynOO1lR
         j5fc1XmLwzT/LX421yd+VX9QNVupr1BDmXMbDHCGkgeV9qzbKZmAaMSLeYhhccIR/a/B
         GH6g==
X-Forwarded-Encrypted: i=1; AJvYcCUKWdQSYUf1sB8pVbzetQRqKfAopRLQlO6jCY+E4FhbZsnLPyK/Of9bFySucF0E6kSILE63+SqWrBfYAKz1uA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9tupVxH6icSMUyPqtUDPZSBJc7rWafmpX2Yi+H+M7LIQdisF
	uyYwo7/yo+Y6IWiOk84XyXv9QTb0g/b10fzGEspPwYlYxchSTDQdmPC3PegCUI7OSykyg2Rn7Kr
	U3XX/xsIAEZ8oZJLt5LGVlgk+MtdRvmtmNvEIQtcapK3HSgXhAKA9JTVmz/ElrtTlHFE+NA==
X-Gm-Gg: ASbGncvk0ugyZiRgY5w2+pFuYu/wdR+g47c/YaUCIF7gPar5lNrO2qaxJcgGhjV/40a
	Qc/LLjSJfdxoBl99jXR093TfxJ2XygW7DyjT6mQBfsA0C5xQnczjKF/jOickIFeRRjuZTYUbcU9
	FBMewb90cGOBpn5XzfNVdSluBNpamdho91js6BoG0yzGAnGwK1IDTeadr16MdyQPGJrIdI+DQt4
	9uiVsGNHZ4I1g6RGaIXCqrkvWdSpwX8YvPJpPZmqtj+4zeMS2pE8SswOZh/K9iWk70qlrrLYXdQ
	4725vOxEAl6PISNnXyyjEdxjzZsu8FBGg4yjjQbQJDBJJ+MMBvRlnZw8BUCnBBApTF92mECcvmT
	dUncoWrVZ8iQHZ0I=
X-Received: by 2002:a05:6a00:1488:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-74c998b115bmr395800b3a.11.1751477110471;
        Wed, 02 Jul 2025 10:25:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNL+mjpubj8oTFu+kPvG+vg07PpxKV0Dl1sFm81HYHH53fukGuY5jdbk7k4o7/GpFwTLHvZg==
X-Received: by 2002:a05:6a00:1488:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-74c998b115bmr395756b3a.11.1751477109849;
        Wed, 02 Jul 2025 10:25:09 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74b548a1fbbsm2105715b3a.81.2025.07.02.10.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 10:25:09 -0700 (PDT)
Message-ID: <e38dc5db-7c7b-413d-9ef8-8dfae7feeb2e@oss.qualcomm.com>
Date: Wed, 2 Jul 2025 10:25:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bus: mhi: don't deinitialize and re-initialize again
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Sujeev Dias <sdias@codeaurora.org>,
        Julia Lawall <julia.lawall@lip6.fr>, John Crispin <john@phrozen.org>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc: kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-3-usama.anjum@collabora.com>
 <855ae20a-3675-4cce-b87d-6f25fb69e0a8@oss.qualcomm.com>
 <defad9df-e248-48d2-a3b6-3f057c6f0b76@collabora.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <defad9df-e248-48d2-a3b6-3f057c6f0b76@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MyBTYWx0ZWRfX15x6LffPXIr1
 27EY/Qr48S28dqecxTut3DDb3nS73szTfxvxqcKKgEuZ1LKbq/wAIbAzfTSnR8fO6JTaEzJNGCq
 9ydOqrsw9al11nkWEoVDajgS5Z0YOnUR1aCW4gP1Hvtj8N/0WgneMIooig90e3PSNLOITXD/Xmz
 XAxo28MijjHyppBw5kr32APkqTl83w30O5x8gA1Jn+tboVCb6k6Qx+z5LYl9naJ+lSYShHFkBmd
 eJzl4MkVYE6ulIn52UfbdW7yhu0a9zLRSDBaTvX7LGaNfArwv2A+yMvkcuzih+NEIVYVajnDLw8
 Kiec9jRx6coc5rK2Bc3nNeMsgOtGXVh8EEhaWU1sTf58I37RsLrQGAUhqzxvNNjOGbep/YLnHe5
 xktWqa726Vs1oVF7Ef6gjShKw1QEZ9z5axzIzTu+x6snGx/tH99zqcWI2h10uALbE97cr8/A
X-Authority-Analysis: v=2.4 cv=EbvIQOmC c=1 sm=1 tr=0 ts=68656b77 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=7FD9jUKyMsHjXuVnl2EA:9
 a=QEXdDO2ut3YA:10 a=Sn0URPYyO7IA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: LSfD_WWXJw5ySVn5LQQ4yBIMjdBkNWH4
X-Proofpoint-GUID: LSfD_WWXJw5ySVn5LQQ4yBIMjdBkNWH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=737 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020143

On 7/2/2025 8:28 AM, Muhammad Usama Anjum wrote:
> On 7/1/25 7:49 PM, Jeff Johnson wrote:
>> On 6/30/2025 12:43 AM, Muhammad Usama Anjum wrote:
>>> the same memory allocated from dma when there is high memory pressure.
>>>
>>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>
>> not quite the right format since it is missing hw version and bus
> I've been using the same tag from last accepted patches. How to construct the
> correct patch?

https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath12k/submittingpatches.html#tested-on-tag


