Return-Path: <linux-wireless+bounces-35585-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFqUB3LR8WlrkgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35585-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:37:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FCD492137
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13019312B437
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 09:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643793932DA;
	Wed, 29 Apr 2026 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GYEMryoF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UxVcAZMR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F313A2553
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455082; cv=none; b=ez2T1bQ5NTgR/Sugh6CF1Uon6xs2mKk1NrMqxqTzNwMNpDzeIvhkpW576bmz/+RET7H1P8wZnD4g7mCxR14FKcB4dcxA1RKH9IPcYyAN7C+rpdyJeDTvkfikQZAm3mzzqKIGyP6TMunOzrITLwVLBssJopWqazaIlLp8sJvK/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455082; c=relaxed/simple;
	bh=dm+dFwxdW3sm7O8MhecoTv5j4K6D1iGc6ODb47RC1e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sd0uvSZ0X26poSs5yvPVV8vxvcjLdrucKNfrm/5Se2PwAdR2CDLdaVjz5EzmkuDEoCMYx80f94cxZ0+PekQ9tb3n13QmuK8k4Xs7GcU/Bkt35E/hGV0uzSFhj1GKUXE/w5sVRaeWq2PL8Nrj1GSJlAp0v2s8VfKBY3hnK3p2Ii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GYEMryoF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UxVcAZMR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8q0Ca963237
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 09:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nnlJIbBYZuUBdNgE4J4nsbuVUbF37SJm8P3L06tNvnk=; b=GYEMryoFXAFAlD/r
	JQitAg82qq4PHjoHkSE55CsuTKzpGQUiy7rQ4Om3REMbKJz5QB7BFnkvoO1pnfSP
	D7SaZE4jl6GkEvVnOb3lLu1B1h3Olq1gHBW/DB6dHat1v7r6hb4jGKY7Bc133C1n
	9Fq8uy8EKP/D0F/UZNBc2d8iJSVSLLUGDsiyeVZPa8hPSrVFSxzecAzI9Rq8wyWw
	7w1OojyVxAHVt9MWsToAYKpb3NHdrefL/9F/gSkLvemplm6pCGe74AUsIpt0yJ+Z
	1CxRYMd0VjerRP4J9xDaJOwDdhjBcDs+/YT5Irq8WWFF868FngTnJ426wPF29Bxi
	J++cXQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4tqsw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 09:31:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8d45ebdbc9fso252043385a.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777455079; x=1778059879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnlJIbBYZuUBdNgE4J4nsbuVUbF37SJm8P3L06tNvnk=;
        b=UxVcAZMRoxQFFUSoaNJKcxm6IoRSu13yEDXjb+2JiSkk6atr+Ij0jAqwkLDf4UJCUR
         YtfvpNvsIU450ihHmyerBupVG3g/E5dHjnjnnpm+SlcSEMiJ1z1V/OoVppFcVkffOmA8
         D8sl46UdArSC7uYibdsY5diuNDMbeLoGp7yttlQooc+RqXzt0bnnr6Dfrf7NcwQWPRRy
         IVFSc32tFRKuSeHR63tN5qAJZQ71/3ZV8sCM6OneIrrc+rIZAYzFzzWft87KEhnGbXli
         M7PPgUogDa/elhlA3M8BWxksr2UGEbcorvZDuNeBS8t7Qm7xXx8xMtF11iiJdf9q//Sa
         1uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455079; x=1778059879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnlJIbBYZuUBdNgE4J4nsbuVUbF37SJm8P3L06tNvnk=;
        b=O7DArYzrT4FMbgBpwDU6TDPQW87ZcYWQ0/VPY/z8HkBu+P0aPP1Qjjm1DvK7kBTxM8
         nksXOY/QkoLZQFTVI/STp+It0p2KKNmU8B6equCgaLzJYmu4DJQxKuFOhu3J+qvvz3Bv
         ADfnBzo8NWlDR8cRJCMHyO63WPN420jxhc8cLA/Rh2iaKc7dysqrzyqkDQy5kxUg0zZw
         o1jrjhYB1HzUCtXhtmPdnRC2zvvBtfJx04/9Tu0jmyeQOPq10nMUrMUloNaIkSSQp8at
         RS5agB965mJPTf/XzxxjQ8jMBs/65liN1KtF650T4VVKoqHn+mTKgBAyku3te5znZQa9
         L/qg==
X-Forwarded-Encrypted: i=1; AFNElJ9T/qcY+ZXD3vWIXKJ01WMqtE3oJ+P6A/0i/4nSaSP1VJMqIgkyCRdOCfmlYtfK/ffZMXihSgtzZDKaAPDDRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdk3tTfbVn+GF8EIbFQHSWbIUwpqLCSHdsDqqoykw+h4EAZyzz
	fe70vOH1mLsxlNveo8mt/u7gyhA/8lz2CD8I8TZPiTRxU4KzzXKjgp2YRgcPeOo4HEWoaywEIda
	nmz8k5pz0NADHVDfVG4Zuz0T19myzQzW/wTjIgNk9n8vfr2CjNTt7d+5CH6rt2GVm3Nblow==
X-Gm-Gg: AeBDiesHUuX5SeB9kqblf5b+Ghc67B66ZaCM3gBB2SdMnZHrs62ZRe/edfU+YSKGPbg
	HYFXZ1ZtUjrgIjqrXn78epDGFRth7WGdzjQWwAyF36n8QODAmlp6toDGJHp2hLGEKahNU7t3GPt
	vUKXHiXLcjVF6a1jVmtErwpdWnmvxW4XSaHpXg/zhvrVdBvdmLxbk23J8kISdwRPIrZ076TYTOT
	uKJX6K1Jh13cgvNJhzIPWnsQNLBTRwPkKGh8DhCUNykOxlbsAt+wBk8eCn+DtdQ683v+XATkxny
	lBnTIL4jbyu9+++lC43XGUvN/DtV4Q6e+X8dx17R0u2BB1iNEr8MfWfOdTHycv7zll5nNN48FGZ
	fgp0KjS7YTqSo5+DrSKqL+qS7emCuSdqXXueUgvoQZUPt/c7Lh+CfebL+Pq1jzif7UnmzxQMw0V
	rvt2amgtSR60DAdA==
X-Received: by 2002:a05:620a:2692:b0:8f8:6b36:fad3 with SMTP id af79cd13be357-8f86b36fd47mr469939585a.8.1777455079095;
        Wed, 29 Apr 2026 02:31:19 -0700 (PDT)
X-Received: by 2002:a05:620a:2692:b0:8f8:6b36:fad3 with SMTP id af79cd13be357-8f86b36fd47mr469935785a.8.1777455078612;
        Wed, 29 Apr 2026 02:31:18 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22154e9csm478955a12.15.2026.04.29.02.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:31:17 -0700 (PDT)
Message-ID: <3c6308f9-3758-4bbd-ae24-d9a02f0aa241@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:31:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] dt-bindings: net: wireless: qcom,ath10k: Add NVMEM
 MAC address cell
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-4-6ad23e75190a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-4-6ad23e75190a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5NSBTYWx0ZWRfX9OzcJEdHDL3L
 qkZjOnaWGpZNPehQo4aU8s3FSzzq34Y4jQqf3gwB+DWwSfMSSHp8NAP4S91vCqdKhj/lyqK+l1v
 2F5xP5OyIcRgItdejYGz5r72WobCOCF0JcQc+0qU8cL/H7SJXcs6xSo8FggQShOMhznmHslPN0s
 LxpXVbW4+iBb0x7Mb9Cp8juMo8ZGW8OTNgkdPwnSKIN3sXRZxM5OQf9/p+7zKU/ge3Mwac/AbpU
 nka07ZHd+8ezkUzgcyJujXWPVPDEW2cq59dQ8EUta4HyQ+5Au2zCtMzj6fLHxjaVS6TrY9+SwV7
 L1kiCInL0H91hIOWex4TO+I+nX4IRqCYJwzKV5nZxHgoHop61VyQz2T/eEvvnM30cI8zTJQjxxM
 vcBMyYSTryBkMjBiPpcWUuTIoliflvap8zbHMv4YLW8Aai/TKC46caRGH6x5OBR83Es0OwFTfFE
 HWv5/jzGblMiNUuQr2g==
X-Proofpoint-GUID: MdybtorX4gefvVAu2fhs8R6p1FN7Yipn
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f1cfe7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=jzu5v5LO8FXgj-oZCtwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: MdybtorX4gefvVAu2fhs8R6p1FN7Yipn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290095
X-Rspamd-Queue-Id: 69FCD492137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35585-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/28/26 4:23 PM, Loic Poulain wrote:
> Add support for an NVMEM cell provider with the standard "mac-address"
> cell name. This allows the ath10k device to retrieve its MAC address
> from non-volatile storage such as an EEPROM or an eMMC partition.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> index c21d66c7cd558ab792524be9afec8b79272d1c87..7155d8b15cc145c3a7d703db0c9c3e056a54c07e 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> @@ -92,6 +92,16 @@ properties:
>  
>    ieee80211-freq-limit: true
>  
> +  nvmem-cells:
> +    maxItems: 1
> +    description:
> +      Nvmem data cell that contains a 6 byte MAC address with the most
> +      significant byte first (big-endian).
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: mac-address

This can just be "const: mac-address" if you don't expect any additional
entries

Konrad

