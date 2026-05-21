Return-Path: <linux-wireless+bounces-36743-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAlmKb+mDmr6AwYAu9opvQ
	(envelope-from <linux-wireless+bounces-36743-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:31:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A7D59F691
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C695300A744
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 06:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E92394E8A;
	Thu, 21 May 2026 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g7k0N3xx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fpDQDErk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996AD39280A
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345029; cv=none; b=rDYgy/YsAezlGpb979jCKltWE9seeYiFiPzKuAwHGqQXFbkNQwViwNJ+rYSv6OkSoZX7IeCcOOkfphnsExgC5kkQXRnZSJ63f78UfwitEOKRVsVSb1uUSEr2bx01kHzQ9NgotJDvQSah+MAS/8SZoiONcAf+emXCqM/v1DD2pPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345029; c=relaxed/simple;
	bh=fq3D+X3q7ZbEaR+KGlXHcg5ZzcIxpXF+jpXKklId51Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUzXFf0LLc4g6RU8YRMJuhWsUvlFBTPTlBsxZjlYznfTjI5OBnUyQ27jk0AB1OzZSyG/t9ZBl6cfw3h/KqMsWxEROajBl+M1rT4I1pbPLP6svig7akxcRXKnac24vIf1D2JYgXawqJKO4c6xeay68cgHlsEeLF1NmAwUTkY2Bd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g7k0N3xx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fpDQDErk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KKljm92158077
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 06:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EcFnBmlGXUBnGQMannLvnZzhlvDc+81ZD8yCnd/foBU=; b=g7k0N3xxmtSzuTP5
	5D5t/X8ZeozBD6m1DF16BcKLvbd8VFULNoVRu3uRU43O+y7D1vZNfucCYlLcKJFc
	vl8fgFjDHUizBRQxRNmKP9rssOaKgSyHgpZh8HHzK+rTyzCjDzMwwK1kWDdqnGGr
	RZI7xXViQQI/bw1w8wH+Pm3wj8bhhdrR9zkLFFEE0g1Y3FXaID+SiKVJeDeihTsU
	n7YL2XKftFfGTCJSwgkijIzC05xOMpqTZr0mTHTaXR6UpEGEdecBbazHnwENBMoP
	qEe+rHKVfhZhbu85Ju9OiX5jOjVCKaDdoTrdDSJIggA/Mmr5UBtvw5l/STBp1VWl
	QsWIYQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma41r4k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 06:30:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso101950705ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 23:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779345026; x=1779949826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcFnBmlGXUBnGQMannLvnZzhlvDc+81ZD8yCnd/foBU=;
        b=fpDQDErk954TcX/yljyxsujGFt4aNcwgp/2G+HlauCh15AGvwjgqmkMPk4lbfV5qCV
         4bPNSR3kAZBVD+M7ajuSufey0k2eI/0QvQI/43HaB94WSCWfgzYCO9goj92C4Kv1jKVa
         bnthsYoB7hWqBs/JmMyRWFBvyI2rJy3A5hqdv2dOTF/g2v53YY0XqPG/3JSJsKKf9aqj
         +xdkfsRd5sRBiBhyFlW+++h0Km0qREaY8mna/EqZPm0Sp5Umee0pP8qooPyc+Aj5dzYn
         V1s9bliqM9xsjQHGPOY64Xc/Y6LIgVIH0lINmQDaPXyTgYK7U/eOPIpLR3UXk7/M4XGf
         r+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779345026; x=1779949826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcFnBmlGXUBnGQMannLvnZzhlvDc+81ZD8yCnd/foBU=;
        b=QZGpXXOyPpQDCZG6wy9y2XikUKWe076PukYwbPI3JdnTaSEAe1r+cTE4iXKdkTge1M
         NjaH3SSrepdZkZcwGjKRbtcHcq8QPp5LHHVfv7yo0jpnyTZly0DLM/G8p7LvqY+3cwH+
         IByltq/vqcNAP3/A1Ry5X/kOzRJWI0yWuQCVFrb+iJ+pYJcf8aVzqYv31lQaLBTWOCoY
         SUOcrTkP4wLFDmko50G8tUvYSDUIJPodomwY8g7g6fiJZt9meoIFswYB28seFZcXs2E7
         9aWdidSQM4TWBB6V85qP+0Hej9J5wNJFG+jL+iT4LTl7zKFlXqGQnZdcGo+Qjgylg4uA
         jChg==
X-Forwarded-Encrypted: i=1; AFNElJ8/PUr8YKm/dPYfSoI7haTI6VETZPkGPCfcyH4M9xmd2hBuPp9CCv6ibklUMmAMr2IBwC6idoKX+YQhWuBZwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzmmq/2VFNSMIETbiXp10odmPmx2MX6kK/IiFObEYLHWUQYr3y
	9ArKxuZfHkEErmmQ418bSNWPCgvP7B2s0NQk+1070jqN2RwQRFT0KXldTtWyKEAlqyOZlClo18O
	kidFzejyylNZG9EVbZS06jeYOs/PGUSX+mM4a26OhwpSVWEfA4OBRDiPkLwKrgaYSMdMbuA==
X-Gm-Gg: Acq92OGbKreYeK/DUcIhB16up5xrYAidwgPyynjt0185A5YCfouaK6OKt9DIwqkAQ5g
	LCrCBkHmaIcIe3v9V1ICq1lYbJS59BEBQ48U9xLkfPYpRrd5yVLwj0VW4a09afFzlDh4yf4FJTq
	sXMrvI5zDdUQTb36r20Xqrr4esjR3PN21a906CXZcXdvpQnK5IpohNFa3pwtJkD1tSU2kKebklQ
	9NQvQVi4itBBJpYeTqIqYxrHXZEPaNdB7KEiEGdPXQTOnMy4mvUHFyfPgLJpEQRthdy0n8OxNC/
	2+U+s1LIwKdbm8BrvO+o6tXDhM7Jd7lCQsBlIo7dhir+WKE0BKR5S98qTzDcDQlri0GDdJ9ZhA3
	zbtndYXmYyx/XIKFlxlWw8f1+JljxCfZ8X0WGALTMtA9rs2aYWkYGHWiG
X-Received: by 2002:a17:903:1a27:b0:2bd:ef12:14d6 with SMTP id d9443c01a7336-2bea33e5a0cmr16912145ad.34.1779345026170;
        Wed, 20 May 2026 23:30:26 -0700 (PDT)
X-Received: by 2002:a17:903:1a27:b0:2bd:ef12:14d6 with SMTP id d9443c01a7336-2bea33e5a0cmr16910625ad.34.1779345024887;
        Wed, 20 May 2026 23:30:24 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.250.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c263a0fsm241748305ad.37.2026.05.20.23.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 23:30:24 -0700 (PDT)
Message-ID: <b62c2a16-9e73-47a5-8bf7-3878e21c3da7@oss.qualcomm.com>
Date: Thu, 21 May 2026 12:00:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/16] media: qcom: Pass proper PAS ID to
 set_remote_state API
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, dikshita.agarwal@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260518072856.22790-1-sumit.garg@kernel.org>
 <20260518072856.22790-13-sumit.garg@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260518072856.22790-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ea682 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=X+kW/DRse7pI7A4riirJBw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Reuo-bjlSNWgIop-ackA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: My9vPYjRoY363pQAbB96Q0iQZeTB302q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2MCBTYWx0ZWRfX+Q4eGfs+pw1r
 vM7SMIYvsrh4unPSLwGTyj76G2PjE9/2Ip+1iXm0wVLSLFKLqPc5MxVQ2CrkttFU/VmYq+aLwn0
 +GsY/XfEvq/hqnNFPkFgGX8PO70RSiwb0alpCDVN8D0Lj3jHfS2RcnimMCB3ZwY5HuuaEPCdnRu
 7oobqSmuRLpvApxOXmu2i/ju15fZaoV587Coqwx8kUqCwfXG+TihIXUzOkLlAjkXAyOhw1Rym/V
 W/0qqFKMppZ59EmX4G0e5AF3wOG2SnkMjF2Fgqufc4oaevzq6HjwgqpunjM/kMiMxNLWnef5rnc
 uFJqBXniADx30brzVpSa6iDOfyFxaVeqDEYxz68Q696p+SKgH/eQKZBzMa0GPppCSzKSb4IcVoI
 BEEFvDZdGIYesN44dgZ6HswFpQouFoSHGFZfc12W53x3nz8xx4cvL1uxxWhbDS1ZhbA0aaB+7U1
 u2v0s/sduBndrfSgJ6w==
X-Proofpoint-ORIG-GUID: My9vPYjRoY363pQAbB96Q0iQZeTB302q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210060
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-36743-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikash.garodia@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 53A7D59F691
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/18/2026 12:58 PM, Sumit Garg wrote:
> From: Sumit Garg<sumit.garg@oss.qualcomm.com>
> 
> As per testing the SCM backend just ignores it while OP-TEE makes
> use of it to for proper book keeping purpose.
> 
> Reviewed-by: Mukesh Ojha<mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha<mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg<sumit.garg@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_firmware.c | 2 +-
>   drivers/media/platform/qcom/venus/firmware.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

