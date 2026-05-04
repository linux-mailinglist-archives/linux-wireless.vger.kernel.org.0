Return-Path: <linux-wireless+bounces-35830-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHUdC+9u+GnkugIAu9opvQ
	(envelope-from <linux-wireless+bounces-35830-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 12:03:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBC4BB626
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 12:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 215213013872
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 10:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C574138D011;
	Mon,  4 May 2026 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="blFGahv9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNueDgTT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41338C407
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889003; cv=none; b=utVkj4wwpw/MvnrFjbgkAV/q0DhDzm50JjHFp3wLJ7t/D+evJbj8813Dt7HnlH72BA2CsnZypvkQ3Q0vL7KPukF1nCxN97dGjj3f7AhigrmZfb9LQZtCqbgWsQjjs1EYhHc8TjLGzRaFCpl8ZCag+Ej9JYs2zortMBfDbK84F3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889003; c=relaxed/simple;
	bh=27a4ZBAh2T3+ZHmlpGLT6Yc8QyhrRE74iT7Nbf3wzro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeHbnFZHNVj4fze9IgeYkXIFZjvsUeWt/3ETT2hCiSsB0yNKwbznam8Dwp2BXgReokMIrUll6XPyIynTUmUhpvqaU8qQA+BPAecBP23L8bhWb8gPIEpmkSsnSBleEA4C719Lq82tAHzFh9AO1tA5+UwRxPQogeNdJcyUGobLVeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=blFGahv9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UNueDgTT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6448fDsg3845844
	for <linux-wireless@vger.kernel.org>; Mon, 4 May 2026 10:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dIOaP3I+69NIYahYhn7ZP8dTcKbC+Rx4d1eqqv57oN4=; b=blFGahv92s0HUYjT
	Ihj7OOX/CnOH7LuU5MlrBldveiHSlAs8JLotz5yKAVYzJHzUZNj7s+B7yxCABZQr
	MIeuOap/tRS5v53jzGhONjBC3KV+HTbV+7D6vRW/eLiAunSL1Um+B/R9wppgekbr
	MEUqeXNAyibnAYw91s8LSCwst+PaDxQLLi/30M6EKIHKDEoyTMDNR1eh+c3v0CxB
	wFIh6v4C/U9MaZmtQffoPeagpZF0l4N3OH3roV/REe8FlXEloX5t8SMrJggV/FkQ
	3AgBiYK4NzS36r3ZDhDDQ7ItYyL7R5m9fW/5iHrSm0iYokJjo0HQnTlVPGvxZXrJ
	gYLCuw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw6yfdj3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 10:03:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3651991d0bcso3006915a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 03:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777889001; x=1778493801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dIOaP3I+69NIYahYhn7ZP8dTcKbC+Rx4d1eqqv57oN4=;
        b=UNueDgTTtbj4AH2YkZwodrcNhNTVZ4zMXMEJF+rXOP6EwqmQBuQpkok8oO8Ri6AL2H
         pUAhDeaBwcPdur9LtT+l5BIaeM+1Brdq6tUNOjMnZto3WZS4R8QHnbi50i5orSuLdsL8
         vFb0Bv44VjE63//J/5724sJcZKMY7R2LA4bZApNlsyObkq1ChhFFjIqpH8nDfjk4TS7/
         8dnq21r9aAev0d0ahI4YYkNEm/GCIJRQl35ixPGrHx9Tqc/MmaUOQgnR5/5xk5lK4RAJ
         t8gAClJVCgZ+GalIwtQaLbDpIbceplcIjfGYfQ4jdrjPWaxgCDCWjjcLQCRJ1vDA3qaA
         W4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889001; x=1778493801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIOaP3I+69NIYahYhn7ZP8dTcKbC+Rx4d1eqqv57oN4=;
        b=j3EdTYtMRxNbcgbXjaI1u7kChGTppyIAiQJJmQIQFeX9RWuPyfQqQaWifQ4T4/mPUD
         w3+gBrH+8m/U2J/nViOQ8Ln7OhPaRDJMbXv0+/sw9MdTPeGlgu0/iPNVj4jKXZ9W9YZd
         7DWBqtZz1YW+m/9L7yCiB5z4bet2wYg+Q/Xzey7WZGUodhlaOv/xNPONio0xHgUpS5y0
         ONQjOdMX4IskoRMYQKdxsVnP6Bx9wv5yBOfrXiVbM5RL5vNWnV2MzAtCEtX5nHmp9oPl
         xrye9c6tp9q2ciQBoIgxtpKxM5RymuZcsAUKjVHpAw9j0J2XXgBFLgEtkkL8TOFfjGdL
         jvoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Vccl7sJDce5s/r+H6tv1eaKYX7Ks/ICAL1qONLVvbJFUibLEBZzLcjLM2N79HKou7C/Qjwv65aWU1thJnnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9muLoD/44L0fhw6hzetzdO/euNH3b+uvWXWT2SfPDv6VfUm1q
	SDBPEOnPNvbpmNzAmx6ZnZkG4SM/cRU+YMpFpkHLzQai0t1wxC1it4wLYU6FTTR+G5liUnAi9b+
	q3/rF2MdzvMGs82qn4Oi+ncy4An7LSLp7yL/iMF0snP7WY6Vt3anShdKnDwV3nwcya3qoWA==
X-Gm-Gg: AeBDietjxucblKygyN8GlQe2/CtLJ+ZG8gskj9TZvyOqY/2Jv6XX6mw/4bMrp0mge8z
	2t0nFtmNieRsrhn/H9CEhmzlITqJgnkO7vEt3V+fsxHI67+W+Zc2RJKtlYmCOWSkSN876m6Bg3A
	LUFTuyg7P6bHzmKivGRfHlR2pKC8P0z4gvlWi/u4qyjxMO0nxQ3nQggnboCTmTClYNNUdA88wlt
	Ojqf4flSuN1td5ZbfuePWcfYeFHhHgnKgqEkgYfYzyH8KI85WNA9l0USMXLMpn4wN5l9v/cgElD
	UTtJuLtRQv/YdszfBNJw/FjbWo96ZGwU/2FHsHCuUAiBBpLUClZhUqQYaNiO1k9HRNO65t4AB+c
	+d/9ChvvpEBL19C00PmtbHQLjwHo4XjDyla/vXvSJ9IoOfDzN4txtX5MqunoJsg==
X-Received: by 2002:a05:6a20:3d11:b0:3a1:76d3:c1b0 with SMTP id adf61e73a8af0-3a7f1cb3fc7mr9309012637.22.1777889000768;
        Mon, 04 May 2026 03:03:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d11:b0:3a1:76d3:c1b0 with SMTP id adf61e73a8af0-3a7f1cb3fc7mr9308931637.22.1777889000200;
        Mon, 04 May 2026 03:03:20 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbba8fefsm8933909a12.7.2026.05.04.03.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 03:03:19 -0700 (PDT)
Message-ID: <ab4b5257-92df-4201-ab04-436ab77b2fd8@oss.qualcomm.com>
Date: Mon, 4 May 2026 15:33:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] firmware: qcom: Add a PAS TEE service
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org,
        apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-5-sumit.garg@kernel.org>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
In-Reply-To: <20260427095603.1157963-5-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1Jvh9icAgBCOKJE19zCyM2nPhy6sspeU
X-Proofpoint-GUID: 1Jvh9icAgBCOKJE19zCyM2nPhy6sspeU
X-Authority-Analysis: v=2.4 cv=QY5WeMbv c=1 sm=1 tr=0 ts=69f86ee9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=6olnGIjaqZ5DSDVW89IA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwNSBTYWx0ZWRfX0o/anvzEtQl7
 4dC7duDm1iEdgUo70aVGqc/zwJ5AM3fJgn13MMBSGR0LlzX/eeR1oOXzAsXw4zQxvXfZzKHqVqP
 1/Nk63uGcr76Wb7NZX2iLHFymIrfMG0hjgGlq5TvPWN0kZhImM706gkNCB8JGKUj9rJrInKE3Fk
 aKbtXZIHkHJrGzaitQKt8XhPZ3I+uwNroXYjrTYVNqU3snj3CcncwTJVOtsD1l0gHV47PFCAO9L
 PJyjAU0xd0kSfmnA7ECYSgoBZzcx1vpQAGla/VLgXm1A85HWN+pCAUSeDXv9qDvBMIY6kYu7bLh
 R1uwrPG4xPEfUOw3TZcHPVQUcooIwvJZFlD1dSncdXNU1oAEur0QFd0VykohqTLKf3db0Qt7u0M
 dU5GGJMBCzed8hbGlAtWXEWFG840tbgZMWZZYsiAzBZCcIUX/t18v6dU9UkyQaXMMxQ3PmESFnc
 khvCnDYGKBTU/G0Jyag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040105
X-Rspamd-Queue-Id: 94FBC4BB626
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-35830-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshal.dev@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Hi Sumit,

On 4/27/2026 3:25 PM, Sumit Garg via OP-TEE wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Add support for Peripheral Authentication Service (PAS) driver based
> on TEE bus with OP-TEE providing the backend PAS service implementation.
> 
> The TEE PAS service ABI is designed to be extensible with additional API
> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> extensions of the PAS service needed while still maintaining backwards
> compatibility.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig        |  10 +
>  drivers/firmware/qcom/Makefile       |   1 +
>  drivers/firmware/qcom/qcom_pas_tee.c | 479 +++++++++++++++++++++++++++
>  3 files changed, 490 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c

[...]

> diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c

> +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
> +				  phys_addr_t addr, phys_addr_t size)
> +{

[...]

> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS mem setup failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		return ret ?: -EINVAL;

Following the example from qcom_scm_pas_mem_setup() here:
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/firmware/qcom/qcom_scm.c#L778

I think it should be:
return ret ?: inv_arg.ret;

This way the client (say mdt_loader) knows what error OPTEE PAS service returned.
I can see that is tries to print this error:
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/soc/qcom/mdt_loader.c#L286

With that,
Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Regards,
Harshal

