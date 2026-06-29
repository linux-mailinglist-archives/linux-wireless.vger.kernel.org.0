Return-Path: <linux-wireless+bounces-38243-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NJSiLzjxQWowwgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38243-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:14:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B72326D5CF9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:14:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=FZvNBSZE;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=kg7IXyZ5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38243-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38243-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6860D300E27D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA80F3563EB;
	Mon, 29 Jun 2026 04:14:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817C33343B
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:14:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782706484; cv=none; b=Pl87bl77P2VYi9Ur4PCvIc+fGL1vEnUpHfMrc+5o3xbDMJ2ZWn0CupTwt/4HkxWTK0kQUYC3LfFEIPRoVPyhLzG+RIWdLJ+k7jxMNczMwRJzrEtgAxi5jP3Ibz2Rra8Oy0PfU+gXslNxKgENTxftb4R5/mpalzJxRWvAQParbYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782706484; c=relaxed/simple;
	bh=D4ASTnTzhXeUQsU+e9+6EqTB4ctGnZ9db+IBpMBt/G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rkj/d2cWOpCFxdpJnDDZBcxfSt69jlq9IpbI69fjQkbuDgXFnXvVqSmeD2+36kDWqU0dWVrxmPCXkNnXue0dWLZdHzUVED7D2KRM+GlmF4qNVK3tB0s2NtK8ar3yavPLYhCb6Pe2IAsCUAKUFiMtGbDYrwpIVOiZv9I0yCXjz3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FZvNBSZE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kg7IXyZ5; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T2cw5X1545761
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AKGHalJjL8+CmSeiutqbwRLhL5D4YU5/vZSAJ0iuwr0=; b=FZvNBSZEKQqUmnpB
	caqreg6x2FuUa8Qp1oFH1NfNIUzhGZTB5MjYjTt3KO+W+id4zvnEhZ1boLJM0L4b
	+q/8rnJyENrTWfDncm2c0s9JAz4jhpHIHP0kN/IhrYU53srzkJbsyLMmYwwYZuIM
	wIadVu6eYBVe9CNr5ZOktJkVVJA8VL59vcDi32z3tXw3EAwlMrsJVeGgD0XnCVMF
	wWYmTDVnZVg0EX3TSxOTAFnokeVch2VGG6u5qRQbbn4uTkOfDY7nWvqA20AehDOH
	TxO01c1V3SLf4yHYxIQo1DyApi7FiSFc/YGtf5TZB9S8dPFOIi3UiVr3zmSOjMsG
	aKVdGQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27084caw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:14:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30e773699d6so1546092eec.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 21:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782706482; x=1783311282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKGHalJjL8+CmSeiutqbwRLhL5D4YU5/vZSAJ0iuwr0=;
        b=kg7IXyZ5VVuTAD12jr06zTWNezttqWRdFdt2zCZdhVzd0G+500pGibsCIhHT2f4APR
         7+PAKMfOoOPc8FX7h4OcavjhhvJ5PT/yybk5il4nt+9KBeMim3SNXzbN1t9Cm0nxFUbL
         f8u51gp7eQGIyhSuOimR6Bpv7LvLN1TGvN3lt2BWuRZKF3lsN/DqjrQEad0ZZG9jFcnP
         j/IrDRo+ntLpAqYpRG+BwdOfn8JjSUQMy8K4+k5Ks92O0GwRMC1Zke0kTxsljLp8WJnG
         ziy9wGZClPF2F4gYGgXq76bSUWw0KCeRXkTp9E4W4tBH3u81H8SzQJlMuvYUVLOTWn4v
         pf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782706482; x=1783311282;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKGHalJjL8+CmSeiutqbwRLhL5D4YU5/vZSAJ0iuwr0=;
        b=JcxjiZt6VHHYETv3kbhff1+DezGA1pTXYa5errWUr+sBPvAL/GzKslvQGu0fUi0JMW
         OUt/Vu8plQuLQ/iFdm5zFqA8K0nKFXYFZ40ns9RJXiZLcYJHlsgbRDZCSHF5CQrmUSbk
         1Aliz0mXcgu6XHP/Bmjxen3VQajWmPJWtly6nSQhXfIEXfjNOARH5sH5pUpiLj3838ps
         vjWEZgMwd99APo4i5+l8WItZXHZjpwDd21ZgSEf548tvi5l51wQBltJMbKGFVU79vSWB
         d1VqPWRj8M/j1zJB1Mho8S+7ibzrk8p3LGZkcKZS9FsKa53grvZctB06kbJ8cHnyzVRR
         Nkbw==
X-Gm-Message-State: AOJu0YxENGiEVtRFW9jklpPUb/cebfFAKcx4eTxN54Jj9fjuMilQMMXh
	Txihb7K9J6a44A+KbmPYFNwkazgHlzuMejgjTZPnKRVo3xU1U4GEaSJQNgfQPBXdFaYaAobhf2X
	XW+k5CFnzGC2Gi7UGXJ4RMS9ZyJ7A0E97C82bLGcR/iUFIZxg+LkpljuyFJaaPJgyirS2fA==
X-Gm-Gg: AfdE7cmW3OVNavxeoKx0DV0YfwmlzS7pu5c8KIpsy46wvKEWtVufUq+qxjTkf232SXW
	ZJQR3wJii4ZGqLn1IgROev2C4+XV7pUAQ5BxpLZRd9qFTQ4if/EU8EcNDwihkd38V+g7UHwz53g
	75f9olhDdxMTAPp8LvwaiuIk7+mQrjxzrQQGDVicWvy4SLKHCMRFOh4586f1DOzuc6kfaDKeIb0
	O1iatuGuOkBsGPcJvEm97GGCsZ6bmcLX32sjInVsgEdo1zAgvwNBhiDfBCz3ndWVMmt+w3y28e8
	ViAZPkQ5MS39cEBCYP/+E5swJcYtIw8Joq4JmxpVOSFeLMdDbD7qPxEJ0kHBiGNiA5pTWNWNcap
	NWRO6jboGL4zS4ee2LSsmRFbhny1d6IuMXYj+Ke1mZjzaMdoRgLI=
X-Received: by 2002:a05:7300:3256:b0:304:997c:d4b6 with SMTP id 5a478bee46e88-30c84eba0d2mr14876884eec.17.1782706482234;
        Sun, 28 Jun 2026 21:14:42 -0700 (PDT)
X-Received: by 2002:a05:7300:3256:b0:304:997c:d4b6 with SMTP id 5a478bee46e88-30c84eba0d2mr14876866eec.17.1782706481719;
        Sun, 28 Jun 2026 21:14:41 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ec3e400a2sm11566769eec.28.2026.06.28.21.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 21:14:41 -0700 (PDT)
Message-ID: <af592fed-313a-4bc0-a4b3-f04ca0ffa6fe@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 09:44:37 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: correct monitor-mode RX
 metadata handling
To: Sushant Butta <sushant.butta@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260609064856.547032-1-sushant.butta@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260609064856.547032-1-sushant.butta@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ObKoyBTY c=1 sm=1 tr=0 ts=6a41f132 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=pBvdREmwWComYNwZb9IA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMyBTYWx0ZWRfXyqJHZos/KPVr
 ZsQUINhf/kCty+yre+PMY5ZZPzJGMOEh2oyG3MJNWznjisoyUHEj2kHTx9H+N41hKosE4SAAakQ
 iTno9I42DLeR78dIEPSODfhRqyiEUjAMIaqtsHwEQ4HdTSktlDiIIPaCb2hlyBGN96Bl/egRxZT
 ppWcyvJ9ltUhaVgF9i0gNA7HFyAsfkwwClJeswegy7/GCmxlVQUL+lRvnCospeR8RHUq6T0SahX
 vU1s5UsEkWCTGONzj/regxH6b3/MVCT5/UrpNFFMEp+yduxC5e+iVn08KuzdrkkYdwluM18uopa
 4nn4jzzUMPs3AHD7iNNIXtiDNo16bSqgjx5zS4TEC/QkqzcVg1KYrkS7OO8QvYLnwN6BYUKWFH6
 KWDO1TNSjToed++axa9AcmnV9vEpJWfmQTcIf4zVspSSFTgzB7615u/vsPVBtz9v47CC70/eh0H
 Q5Gja+EWdcdqMzVRmFw==
X-Proofpoint-ORIG-GUID: KQegf5eJpTf3zLCYw62WZ4wBvr2i3E22
X-Proofpoint-GUID: KQegf5eJpTf3zLCYw62WZ4wBvr2i3E22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMyBTYWx0ZWRfX/uZSKlyu2fKV
 YcEgu2CCl6E5Y7hihr3IhACy4yBsRJTJgyJkLq/E4Zy4su4o0eBE+6usGwcXWUfUBNmgFcKvvj3
 3rlJhLsfxta6zISSTnE6kKYZb0T5tNs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290033
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38243-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sushant.butta@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B72326D5CF9

On 6/9/2026 12:18 PM, Sushant Butta wrote:
> This series fixes monitor-mode meta data handling in ath12k and trims dead code:
> 
> Monitor mode delivers raw 802.11 frames should not set RX_FLAG_8023 flag,
> and populate peer/link metadata in ieee80211_rx_status for monitor MSDUs.
> 
> Sushant Butta (2):
>    wifi: ath12k: Skip setting RX_FLAG_8023 for Ethernet-II (DIX) frames
>      in monitor mode
>    wifi: ath12k: Skip peer link info update in rx_status for monitor
>      MSDUs
> 
>   drivers/net/wireless/ath/ath12k/dp_mon.c      | 70 +------------------
>   drivers/net/wireless/ath/ath12k/dp_mon.h      |  4 +-
>   .../net/wireless/ath/ath12k/wifi7/dp_mon.c    |  7 +-
>   3 files changed, 4 insertions(+), 77 deletions(-)
> 
> 

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

