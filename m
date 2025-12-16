Return-Path: <linux-wireless+bounces-29812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2ACC3DA2
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 16:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0971A30ECB7B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D94334D917;
	Tue, 16 Dec 2025 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K8Uj7qtW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AvC6VWdQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C932D7D3
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897695; cv=none; b=qXYgDctkYjPuSH2Z83rCyxfq4vZD/HEgI0tX1Od1knVQAhqpFOMe0FnL6PK78vsTpty7KkaOH1PqL+mBWtm62gE79ED9IGK6cFddV1CcMyrpW+D/gIlGR2dNRnuCUFxXC2VLYLHXx3xU3rEXLaoicrwnj1Rt9z+N1R3gjjPJclQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897695; c=relaxed/simple;
	bh=ds/tetK83vg0a7m/Rby7VbzL49eQltPd9m1osiOqy3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHg1P8/EEK/ystY+px42gLcWCBkoKE3DGbO4BGs8goyB0N4CwtQnR5r77/LIN2IQ9ngLLsRuE9EoTGVfOxPqOSbPE8nwxpzO8nF/DOYNwD6hiN2N7LRlmDigcRjGk0mY5AqI5NKFyGR1RssxAzPB0Dk9VAUH0dXNkVDzMx+rbtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K8Uj7qtW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AvC6VWdQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGDRCH13745892
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ds/tetK83vg0a7m/Rby7VbzL49eQltPd9m1osiOqy3s=; b=K8Uj7qtW2RLZYfhK
	FJW1CmUMlSQVlOsgZTdyrQGVmv1rel1obOzCE+Ownvn+qSqNnbDkIUl42shyRQdw
	3vW211vtJ1UqaugViAzzU+IiVrf91E6z1C5OtfAo1nKq8RT52V70rS66dQ5Azmr4
	AU21BGK5GHouG2TFn/qmtmOZnQoICGYcdc3QmG1e0ASlvEev/fKaGQxl45hI9WUE
	e97rEwed8hskcpbNsY3hsqQ5D7IHj0oocH8AjPwrzwRFlR5LC0u9ip0j2SDTldjo
	I+Feq7QkNa6DiSKdYrZpzQjjjt+YjGbk7+S4k+6oY6Qaa1pe2DPzMIiyW0oiMnFR
	DglkqA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b33xj1g0k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:08:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b96038aa68so4366227b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 07:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765897691; x=1766502491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ds/tetK83vg0a7m/Rby7VbzL49eQltPd9m1osiOqy3s=;
        b=AvC6VWdQOwMjbgm3/nvAPMqoy2jKjCMjL5xzjOkhsvG3mTHaj78y/kjh06VvSAlogs
         6GBnyEx20N6r8btleKKzflB1VCPTghEsP+OxUdOtPw+MAKXzPotBqR2rlWY9buimm08j
         0LXNrAr+z3pHF2CPNlDtgCeEpOI93AwKMZ+OqV+eVoJSM74nkyLxEDwQZYCGVMHw4kjS
         PPdu7Stj/BWDR5w7BoY1Yy3HZR12sKRxJl51I+9uMFse2eHUZv34yDGah6JtqbPqKM6r
         y7S+hzf3RmTqZZiRO+LkMEIAeZVEl5Y0NyiY/DlLZEZE0W6wHoH2XW6LyvD2e41b8uIW
         x5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765897691; x=1766502491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ds/tetK83vg0a7m/Rby7VbzL49eQltPd9m1osiOqy3s=;
        b=J+bY4k2qJlz1OXIIA5OEuI6BPQavJfAZ7mgqHDjFGNfgou5ccB8DmoOZ/JmJyNJSZj
         qzbdkwJu/XUHbKtf8URexsc/9tfFBWcrod+Gc+Msbo86jFbPdwT01s3+cA1VO79px4aA
         v3gee6kFgWykJ/pokZTVT78q2v6XHjCXxNnyo3jBkN4a7QRI59GIsyCOxo+Ei8Z/2hvP
         91qK4TTClLOJoNbeFRSlSNvMoyLairknctDS+2fvfj9+gN7uxeRXV3fafzPfc3phy/Dl
         ES+L/Hi13IPDsGWmclD44FB7L3LBRfmIP3HEtBBsY7SlUzPZWaV6QyjzSO+3gnhZGq02
         c6Bw==
X-Gm-Message-State: AOJu0Yxt7TC9ribMtXTY52uSlDGQrHuZ+TaBcXpTNOU6iMwyZn9lGu4Q
	pUkUiy9PdYtJE+rNckUCVc2E059DmDzUlZXuEwaBUlEKX0U3EOHVUHlSn0Nz/cyYlnnLHwex+8J
	8tR/lxNuuXJ7Kmn+xpvQmndH+MxFokiRQGNO4FlG/fl7xcNtVWE792Av1Eb3dhVvr4qMhiFsPCx
	CBzA==
X-Gm-Gg: AY/fxX6KEyyZIowSgGXntdzMSL0b/K+VJ5CyAzsT0kj2yEAeW2KPCoffSLiQ2YvBjgs
	6EFk6A9T52wvfLWZ8HrQbHh2/3CeBxlbycTfCWpM6aOKKnYVuwuE/0Dg+83Rl84QcTlUdZoN9Ja
	ZtszOBSdqKbTXoJTW+RgE3iuk5GbD769Vb69dedwsYq1O4+OpJFrlEBBZLfkChDqrcP80HYHAUc
	ZcglQcVYqBQ3wkuXB/iMcdbyNfZmECiAan1x43rqzMwzQ/PjYSoVKDoE0TAREX0psSGwKO8RNWv
	AKwvUEXqyEnkk1PjsLybs7yEOel0PnjGRwudrFjsLKBLar1Wy4nEaI4Sbr1T8kOPYgUs7yffJaQ
	bHv6w65CjPX6LYqYjzoK+QQHXmX9OujAJYRGGTSJBSU8=
X-Received: by 2002:aa7:8144:0:b0:7f6:f92d:77e7 with SMTP id d2e1a72fcca58-7f6f92d7804mr9058229b3a.9.1765897691424;
        Tue, 16 Dec 2025 07:08:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLJJWPYlcq+RlzuM5GqYMmJIbgKU2VijK1QiEJ2xANAYHs3z4NRFzItspM419IHzzed0iE1Q==
X-Received: by 2002:aa7:8144:0:b0:7f6:f92d:77e7 with SMTP id d2e1a72fcca58-7f6f92d7804mr9058197b3a.9.1765897690806;
        Tue, 16 Dec 2025 07:08:10 -0800 (PST)
Received: from [192.168.1.10] ([122.177.242.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c2773749sm15857572b3a.19.2025.12.16.07.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 07:08:10 -0800 (PST)
Message-ID: <fd13e358-55e8-4860-ac1d-187c14b15fb7@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 20:38:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 04/14] wifi: cfg80211: add support for key
 configuration before association
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com,
        sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
 <20251211124051.3094878-5-kavita.kavita@oss.qualcomm.com>
 <b2c6a526c7d0d30a00713ac7e760d9e2e12fc7fe.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <b2c6a526c7d0d30a00713ac7e760d9e2e12fc7fe.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Wjhre9ucbRuNn6llNTrq1AnhG8sOKjP3
X-Proofpoint-GUID: Wjhre9ucbRuNn6llNTrq1AnhG8sOKjP3
X-Authority-Analysis: v=2.4 cv=KtNAGGWN c=1 sm=1 tr=0 ts=694175dc cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=vaJ6/3d+63OnhzhRW74whA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=lDaCBmqFNLTCSFWRv9kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEyOSBTYWx0ZWRfXz5skzAGq+604
 fMlJ1cuP7wifbNxcdKtyNXAO//78g5VLFzOSkNatGQYPTSSfdW6G66/qSaF5ugahYkpuT8nwPos
 EyoT3UGy8VDhML5uPYTZoACfNR6tjhFiKxakjCavq2jNUtkeE+xIlfgA0dhqCP9l3Fb41um20FO
 pndspz+FydxQRP3p/e94iZtgrMmoNpzsqNXTRk2MGBurpxFgUXrwCy7086wicNF1u6ttdwHAKu0
 UxgQxZaBzm6ScxOChZ+q6QdJ9xhEM7JgJLSJlQnuk0qBvsl+9Thx5NcC2yR/eg+JUS62xVPljOd
 LqoBSXOfIMIXyK0BVnZtGbGSLrPYZNc3UR34f6zAkA1oakvVctX6/DLSNzWaiTOju27aREMlzkb
 PPEPrqjtYu6iqpVOR/dB3ES/yW8S1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160129


On 12/12/2025 5:57 PM, Johannes Berg wrote:
> On Thu, 2025-12-11 at 18:10 +0530, Kavita Kavita wrote:
>> Currently, cfg80211 does not allow key installation, removal, or
>> modification prior to association in non‑AP STA mode. However,
>> Enhanced Privacy Protection Key Exchange (EPPKE) requires encryption
>> keys to be managed before association.
>>
>> Introduce a new netlink attribute NL80211_ATTR_KEY_PREASSOC for
>> NL80211_CMD_NEW_KEY, NL80211_CMD_DEL_KEY, and NL80211_CMD_SET_KEY to
>> indicate that key installation, removal, or modification is permitted
>> before association in non‑AP STA mode.
> If userspace is allowed to do it then it can just do it, no? Why should
> it opt in as well? Do you think there's (older) userspace that relies on
> the initial key installation getting rejected?


I don’t see any cases where userspace depends on the initial key
installation being rejected.

So I agree, NL80211_ATTR_KEY_PREASSOC is not really necessary here,
since userspace can simply perform the key installation directly
without needing to opt in. Thanks.


>
> johannes

