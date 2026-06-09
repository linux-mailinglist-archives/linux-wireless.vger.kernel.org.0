Return-Path: <linux-wireless+bounces-37596-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PqWnKdE2KGotAQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37596-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 17:52:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C066204C
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 17:52:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=D39SZ7a8;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HZhSzPiF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37596-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37596-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 048D8309722D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEF248AE22;
	Tue,  9 Jun 2026 15:42:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86382481653
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 15:42:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019777; cv=none; b=knrQDOZ63rPImIqhjb8GlyWV4TxiTxC2JutWtebxMj/nSrNYg2Lkf07x3zDVB5IPAuEwWnP4tSU2qxYH89iqYwOabrBE9UD56vNI/7JlN5jJjp1MsGu57JaQjsVPgkatLWJiEYO9sQcEAKYsDJ0xx3EpOl74+yUUiSvnzEVr6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019777; c=relaxed/simple;
	bh=gqr5ohazsZyTasddooxt15i9sIDUHi6ZxT2bvwDtjME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pk4Nx7bUlbGjRjm0yiH8i97/y5G0VQU69pPww8pH0xFJMwoEKH9knHlyjj9FJwDh1jeJt9ZFs+2YrNf2TzTCO4nR0NsvDtUaXllqESPlxRNvnE4i7ATcnnmhXpI/DXDQzzG1k1EPa9Xkd0d1M0cajSqwACF02CYOSPiGC5/A0e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D39SZ7a8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HZhSzPiF; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClJWI2249317
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 15:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8cHJxOBc5Xe8d7YrcCfFV5AL9qZw+skq3zLnjeLTEDs=; b=D39SZ7a8IjOskgri
	S9RCiOP/R1kujtUpFKg2zm/nyS6LoKlIHQVf7mDN332toLJm+U40U6uK/R143VBD
	3eBsqTnEIkyiIPv6pZ6j46q4N53+1pQdxLAxDKdou4ShDBg+UF1M+ljfxSS0BwF3
	Lol4Le8d1s4KEX1PKIFizOZPDlgBetoRyQ7u10R6u+V/TF1RF35G4bNDeKAQ5n70
	1Egg+LIt68GjvbjWtmQP1OD12cUm7KDcX8kB+HzsjUdM243t6NtJAT0q9WjgkkIn
	x4TD+IPgtYzob9ZMs0w9VdfYJnI+/qJae1HtNtnv39HO9vmrv+RcR60iGbB/p5WD
	v4H/9A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wht48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 15:42:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304ed777a96so3684216eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781019773; x=1781624573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8cHJxOBc5Xe8d7YrcCfFV5AL9qZw+skq3zLnjeLTEDs=;
        b=HZhSzPiF03w+nzTTaTezEPcoJGYJUadkrbMLbG0PIWF55fSbnFxtnGVyaTia1ngXWp
         /i7fZlCrfo5XnNHR3kTN7RQnq7NT5JAisCFTMMCOH2C+7uBFjpxE0DOCYH/QXp2cfpbw
         fxvFEfZ36fFE3iugRTaESfFaAnR62CmwtG1aB1rRjYsBs24XPS+Rvf/pfP5hzuxaqqZV
         /dEbcFxntfmVVdkeM5jZO+GN6VNzgTiYI4jJpPadjIBxyfDB5l/4exeYJbhFKv2E0d/B
         3T4JL9DJaeHjz0QNx6ZbpdAdRrO2lWO9XD0rA83Rl4DRMOfGUh0OzcaCq5F9q9lYDtNL
         Etfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019773; x=1781624573;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cHJxOBc5Xe8d7YrcCfFV5AL9qZw+skq3zLnjeLTEDs=;
        b=PvyxPWLBmBMgtOJzQFH3ymQHxY/WvJonYJjIyR+KZtKuxE49ek80Rvvi5paYFqkR0U
         VihJg2b5CUeyiQm+0KbfhazyW21aspK9b9JIjZnLtNaJyGIgR0qolV4LRicsT8T/nJaE
         mlD33X+igNmi/4hT3sh0SUQt7kePP5KKEUv5ekcALWmh+4DwX8CNkH5MvWOuIhE5YhOG
         2Y1QiS1nyiCzvJme2MEdm6zk8wz3rJ8An3qehvZ2OBaLvqygT7elhQ4jQy25RU9pugdm
         VimGsHhJpq8BsAzVOS80F1ylrACMgqY+mCKLWJ8mm8UtLriAX1a3g0JxKB/3PBDlKQ/L
         31dw==
X-Forwarded-Encrypted: i=1; AFNElJ+yqiYtSlUqZL2qNHxtp1FaODhKet4zuE63vjeCPhXNemzCFk3eZTzeO9hYhmKpDGKvYWWwh6TsHflwv6GQKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRh0DsACqgKTHv4v1+WX4dtJU7MVyNhTBgA5fG+g450JK+fInU
	xrVXrTGVB/5rHxFf2Tu97f0lUh34rh9DNno/mxnzDBXEzvuoc5602mLme47sjWRv6CwySSRa0xt
	P/TQIY/b4p9IlqfKoneKGLM8DJ+H7KmoxzRDW5sTFeqssMs1EX0YrcN4/A3Md7X+NzA+p8w==
X-Gm-Gg: Acq92OEvwvqfRwP9mnOnyGZWrujOYSbEwYyEhwG6oBB9GZ+WpLgJaU6w05OQbU/VDxa
	2rzhorla6zwGInjfN+TKOEnbBVRZOxVm2PgndP04D5S2COEUeFrkS8iKLeVZRMBWB5QcC95HowO
	onEbALS5mbuj9qzJPTxn918+sZrA/vDeALMfURpZZHPCRt+e+Vq4HbEUzMSaI1LiLbG7mjnnA5E
	R8FElbhAJkgMnQG5a8WrYbzFLugcWDiviwVy9zmdk+f8i+cBHPb9qccPziFD7tgKwRa/Vh3VIkq
	g8zMzhoPxAfyQ/Lm9Nh1EmM+UwV7Jtq0vLqwnA3lfQ0DsvjdkBDZMgSOnhvuNaGCXCQM29MnQNk
	4VB96ahJ51OvvsqLRkODHBOzqG6YgtfB9lBrC6rFA9a8OzkE4ZagO1RSlT4DFXaBtdFBWLS6T/H
	sRHJWZpXY56h4FdRXx
X-Received: by 2002:a05:7022:3d03:b0:123:3c24:b15 with SMTP id a92af1059eb24-13807d94f3bmr9505290c88.19.1781019772993;
        Tue, 09 Jun 2026 08:42:52 -0700 (PDT)
X-Received: by 2002:a05:7022:3d03:b0:123:3c24:b15 with SMTP id a92af1059eb24-13807d94f3bmr9505263c88.19.1781019772510;
        Tue, 09 Jun 2026 08:42:52 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85f60sm26793961eec.8.2026.06.09.08.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 08:42:51 -0700 (PDT)
Message-ID: <dc655263-99d1-4dc5-a5b8-f2d64af36421@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 08:42:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] remoteproc: qcom_wcnss_iris: Add support for
 WCN3610
To: Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Kerigan Creighton <kerigancreighton@gmail.com>,
        linux-wireless@vger.kernel.org, loic.poulain@oss.qualcomm.com,
        wcn36xx@lists.infradead.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260306004344.10968-1-kerigancreighton@gmail.com>
 <20260306004344.10968-3-kerigancreighton@gmail.com>
 <4f94c20c-d06f-48e5-95fb-5380c84a1b99@kernel.org>
 <ecad737b-ea4c-4f32-b519-f338cfd6d48e@oss.qualcomm.com>
 <aieCcYXkmDqfb0Bj@baldur>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aieCcYXkmDqfb0Bj@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0OCBTYWx0ZWRfX71ao2yV5laG0
 q22gBzCROO3xZmGhJM91a6IgA0PyJr9nLdR1TVmlFkzQ0iOdwDEU18BFGWs1UZz2VCuke8u5yiO
 p33i1cLSbb05kIzKzSUzn3RW0TyW0hAdEqq5FeZHmnDgSKA0zNS6GNtsex8h4bHoXNlEp8hPQ8q
 IiMWIWJdcu5ihiJhWN1mYSDn4nEbE/GnUzGF/9Au2STiMZGgWBV6VB+EL5RJuECwmQWBkPdjF9v
 TCIqMCdfykawP6JBBuvQzAtAugUFU7hp6rydlQ/PieXQwnW0oP/Ci55r4iOMFQBIgEy58zQgiSw
 XMV9gnd6RZzjlmqLm4knR8kiBC+Efk9rTo+kl+2tITVVcJ06+yeX0cicd4PQZsjcsf8oIMk3Ryc
 XQt4iUq4tBIKQHeZfVfIqccYC57kleNrb1KmUq1lu4Bjsh63Abo4aLj7wIV5xwoWB6wmXSAdkjb
 guoO7cVwxEvJWCGN+Jg==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a28347d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=P-IC7800AAAA:8 a=kV-QE96C91QsJRX880IA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: XZAnOE9vrGWct7r4haIxexP6HDRouXRX
X-Proofpoint-ORIG-GUID: XZAnOE9vrGWct7r4haIxexP6HDRouXRX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090148
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-37596-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:krzk@kernel.org,m:kerigancreighton@gmail.com,m:linux-wireless@vger.kernel.org,m:loic.poulain@oss.qualcomm.com,m:wcn36xx@lists.infradead.org,m:mathieu.poirier@linaro.org,m:linux-remoteproc@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,oss.qualcomm.com,lists.infradead.org,linaro.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:url,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A9C066204C

On 6/8/2026 8:04 PM, Bjorn Andersson wrote:
> On Fri, Jun 05, 2026 at 05:33:22PM -0700, Jeff Johnson wrote:
>> On 3/5/2026 11:25 PM, Krzysztof Kozlowski wrote:
>>> On 06/03/2026 01:43, Kerigan Creighton wrote:
>>>> WCN3610 has the same regulator requirements as
>>>> WCN3620, so in qcom_wcnss_iris, we can use wcn3620_data.
>>>>
>>>> A separate compatible is needed for WCN3610 because the
>>>> wcn36xx driver uses it for chip-specific configuration.
>>>> Specifically, it sets BTC (Bluetooth Coexistence) CFGs,
>>>> disables ENABLE_DYNAMIC_RA_START_RATE, and disables
>>>> STA_POWERSAVE for this specific chip for stable
>>>> functionality.
>>>
>>> This goes to the binding description where you describe the hardware,
>>> how I asked.
>>>
>>> Please wrap commit message according to Linux coding style / submission
>>> process (neither too early nor over the limit):
>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>> This series is sitting in my patchwork queue.
>> Based upon Krzysztof's comments there should be a v4 that moves some
>> descriptive text from 2/3 to 1/3.
>>
>> Bjorn: Once v4 lands, do you want to take this series or should I?
>> (Need to know if I should wait for ACK of 2/3 or give ACK for 3/3).
>>
> 
> I don't see any build-time dependencies between patch {1,2} and {3}. So
> I'd suggest that I pick the two remoteproc patches and you pick the WiFi
> patch.
ACK

