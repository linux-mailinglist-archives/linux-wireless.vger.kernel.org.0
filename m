Return-Path: <linux-wireless+bounces-33461-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOkYELW8u2mtmwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33461-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:07:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 919152C8587
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC5563040A85
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C0436C9E2;
	Thu, 19 Mar 2026 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SOnVAmL3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Usrvmur0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40436BCD3
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910948; cv=none; b=gGt0/HkqY7sCjbSqWNwRySMZkK6H4MMBIiAxFLftxxEY2fOqfAvNPo9EV9QM9B871OpCeLx32dfROtIz+APl+kypCB07/pszFjUwLK6slA0S+2cB3Oxt0Mq7NaKflFkBIDEHzP8XxKpjPYXn8bwOvNaDzh+SuBtT5LgmUceGG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910948; c=relaxed/simple;
	bh=rFYQ77mBbRdOk2Q3EJ203LJMJt4lPsFrx6TYibicFuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=db0O7hOYfBbjVH34NAbAY2GeQbJR/vEFKMxZoSs3bzlKmlzFstHjxTlytMPJ7BsHkf+gECMrFkOr0JN9PSWSC+WsyJdWD01HTgztj3TECFuTVgfDeH8JkM9IMKXgF7H8yX6wOE8y524efqZWbPKsflwKOTwHTqyCFd2xbPwD+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SOnVAmL3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Usrvmur0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J73xCx3771136
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2PPsdradxDFBmU6By8IXsjXvjxWS/JBBTM4uA6mDm84=; b=SOnVAmL3naEmqvxp
	wCam5A5ffUzxVU1QmNFR4kL3wVfl9kBJLap874hNnZL/A10nu8uG3NpMfPSZKbM2
	tOZefy7xFI7IbFBTZC3+UHFn2G+KuWnvWrGjNSSDg3WTW80omdEH/MQd8BVK1BtD
	WD3+ZiQR7pprQ8lVhbIgczFYijPq3rCfgPvdLMQXhuJwso9ZiGB5a6cgLIBossql
	PmQwNA2RP7CCoZ5Wnc2RXGqkpJHV3PRx4KY7bA2jduYZJnGtIsttRlXveyHJC1Qe
	VRqtCjpEZ1tbDfn/Q/uGHLwfF0hDJSTj25jpJpD3s8rZ4EZdpIkRa8Y9XE4RYli2
	8i55zw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d083r93yh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:02:26 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5ffa63f874aso6741590137.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773910945; x=1774515745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PPsdradxDFBmU6By8IXsjXvjxWS/JBBTM4uA6mDm84=;
        b=Usrvmur0ciM525rP5WBv/EbbkC28XEw/GrwJhejDUcrirKaj5EZymTeVwc3vA6DvJD
         /xQUZIqR+6DVrT0/K9a8JRVY9JbLG61L0awN/FA4lQ5+E0B1qoHNoJW4cio7w7HiZt6A
         V+8WOdaR4FmVIyezOj4VCr9hc+86Vlpz0YGjM4V1PWYWMXo4KCoNjhL5pp+ArliDAf7k
         zM83vrb3CO9bqHQ9ov3eu+8gimOieHZkbZNcGg4k5QoIWrk9rp9l2ijPO82e5PIEbZ8p
         /BORM4d7LL75+R5U+8m/BlJ543Xu1IOkQprykiO7KffWGo0fK6uF4SS7Hr3MKb0ITGEY
         jvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773910945; x=1774515745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PPsdradxDFBmU6By8IXsjXvjxWS/JBBTM4uA6mDm84=;
        b=Z2lYEbcIrakbzbn0+2SVplxgf+38wFqhnMFrwUnHiVpBzu0MXW/oWE1lX1V8TQ/gEb
         uDguJJffHyIEScmhVkI5jAca1EXN2GrscKLriMCKF/Li3k1RGKEE/KWI0d1mAinXbeSy
         zPN6oW+eRVolFBmPVdQP+ZLKYymdX3F4r3l/F+qAwNF5POE753/f+dQMOJ12rI52Xzf1
         9fOI7AxpS4aGnb4+dh6X7hJMeZYpcfW1PamT9tFQBcYUES7QUn4DC82us4F1uOhzEJkC
         PRy39V95jgfvxH/gpHIjdutneg6rLjWWyVrMR6hPPBanplePBQ+IMvuZxdri+UL5MCDD
         H2LA==
X-Forwarded-Encrypted: i=1; AJvYcCX0RZK7t3go8nCbQ6MS4JMvzjNKsIbpqza+tbom3gITghE42+fGjCF0WoUCWmrQPJxsVlaeug2OhYVI8/e/8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7edNaofBmeeHHA73wQF5lITV1+CPsf+Kji2RPTziz4B432DzT
	kjQdDf0T5S15IvbCyyC5XPhZ9iNYHRfpVhunPAq/3agbW9BIMwFvyz2x91jtcOl7wqn+Oo3+H9M
	7gI4qv/+D0taoNlx9xkJQ95v/AwYof1HVaK81WlNZq4ynCEScwBC8T0VOzzh60cp9T4phbA==
X-Gm-Gg: ATEYQzxdiz45ktztPret/Oov88udYtvcYi/vTrVMC+2RLQqNjto+bnAOFiQyzBZjfFH
	COhsLqcJJTuTaUBoKGl16yfrHwmhwbvkzUqncHznEQEnfdMgza8sLAXQoLPcCJTAhiZBwyV4zfB
	kQnS9yNIjrEmnUiRzx+J05i1IZnRE8a9InnIt+KCbHODdfVhARMy+6tVLCT0QfWd4PzA6tHri7C
	HYF08tqJ5znJdkZ7Xu+DfOUnTFQWcQZuoI5D5fkdj+55fAwoKbJL3XE+ewPADvQskN36z+RvHsU
	6AmDMBs6Z12YcZNx2g5s14WaF7SauVFp9EhXCjHwbAkOozwIcd43klzdoDtHsw2wMm6oLP0OeTn
	CAaI1EO39vLoaJ62xKuA0JrVj8xtIULo20huUczs0J4u9x1XIhBfhzxzuWm3G/D7VeelAdXCbWh
	2gVAx8z8yE
X-Received: by 2002:a05:6102:8558:20b0:602:91f2:6afe with SMTP id ada2fe7eead31-60291f28930mr1266997137.24.1773910945441;
        Thu, 19 Mar 2026 02:02:25 -0700 (PDT)
X-Received: by 2002:a05:6102:8558:20b0:602:91f2:6afe with SMTP id ada2fe7eead31-60291f28930mr1266966137.24.1773910944965;
        Thu, 19 Mar 2026 02:02:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b322d9sm48733435e9.8.2026.03.19.02.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 02:02:24 -0700 (PDT)
Message-ID: <c26aad81-ac48-4ba1-987b-ab6c271fc095@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 10:02:22 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v1 4/8] remoteproc: qcom: Use the unified QMI
 service ID instead of defining it locally
To: Bjorn Andersson <andersson@kernel.org>, konradybcio@kernel.org
Cc: linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <20260309230346.3584252-5-daniel.lezcano@oss.qualcomm.com>
 <177362699063.8490.5627616886098038132.b4-ty@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <177362699063.8490.5627616886098038132.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wOdD9aCV6S-B4UY1eD8WbGrt8J7myZfr
X-Proofpoint-ORIG-GUID: wOdD9aCV6S-B4UY1eD8WbGrt8J7myZfr
X-Authority-Analysis: v=2.4 cv=ApTjHe9P c=1 sm=1 tr=0 ts=69bbbba2 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=BdGfMZ6iCwODMfnLSHAA:9
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3MSBTYWx0ZWRfX+tzS2IDKpXL5
 B/2KmwyUXJJ6xYEY2vxusiCrgbGGfnltwVEWdiQcoqLKNywVqGawW061tGtB1X43e3BgPEEYE/u
 CFpIOhsf/rdu/vQAP2zMcLRL8DjBn4EpUKYOW9Xcbhi0Sm7+KZM8Nx5hsTtLf6nLXs4lDqbJh8Z
 T7/W8GHG+tMZs5/Gb4yqJv4tGjSm1xfeQYeEK+oi0JNauTUQRsWdoVr2iY94IebDoi58NrwzG6z
 XS+n3k97W9YqVjyUBhtf+56Adq/h3lcFGaJStfXSjLBwPcVS7ydkHak8+gkODrmWjO8PypDJYuY
 u4VY/srmGe6b+yk8oN7SzKYI+5lmjs8ex3O4u9DU8/kTIyclca2OKhyOA7XsCM3AB26u0Nh0TN8
 cgEiCC763rL5QYpL5ZpsD6GsGDhaAwWa3izj0l33HymkZOpP8bWbBFdRbAXMGGuthQI0zMogmg7
 zaB7Ig27ck3dt9WOpzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190071
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33461-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 919152C8587
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi,

On 3/16/26 03:09, Bjorn Andersson wrote:
> 
> On Tue, 10 Mar 2026 00:03:33 +0100, Daniel Lezcano wrote:
>> Instead of defining a local macro with a custom name for the QMI
>> service identifier, use the one provided in qmi.h and remove the
>> locally defined macro.
>>
>>
> 
> Applied, thanks!
> 
> [4/8] remoteproc: qcom: Use the unified QMI service ID instead of defining it locally
>        commit: 95b6c029e56e4d75e2957ce7ac795da29415865b

Just a head up I'm not seeing it in qcom/for-next

