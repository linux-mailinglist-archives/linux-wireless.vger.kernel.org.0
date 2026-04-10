Return-Path: <linux-wireless+bounces-34566-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH4ZGJ6b2GkgfggAu9opvQ
	(envelope-from <linux-wireless+bounces-34566-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 08:41:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 656CF3D2DE7
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 08:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D0F7300AD59
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 06:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C40C1A304A;
	Fri, 10 Apr 2026 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jymZOp4m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PnKy+iRe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C827CB02
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803288; cv=none; b=bJLjCMofGlS5ntB+iMRZDkPbdxpx4IDZhi1YOfG+M0BYgTPMQcy95w+fYqdDg1GHC8i+uqm/PMWRbgbvDxxAoN9sWDFgLIfNznDCOTpzVXSsV9qmBALC0pNHuynJqdbo9Z6XIG895vXi5eTJ0U1qs9xRxA6QVMW1imb5FLwBs3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803288; c=relaxed/simple;
	bh=BOS0kOa1maCT5RrLBRGJhUIXoHgb0n9n/iHi25QodEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzLoEZ1xgRnfCHE6eicYwiRLUv3dxKYxdEZtmJyNIvbC21SL9BeFyp4ttgfmzILBrWNv4k3hPcc52QWyR7JzRPepT/1CZM2FTlFR6xRr9pwrBQU5rgHYIRcz5/22kpaqKxm1PR462jr++Gdm+WVL1+/zWxz7QPEeg2nGUc+n8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jymZOp4m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PnKy+iRe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639LER2w2624692
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 06:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	boT1DzvUzerPpvXV9ma/L9IhxRQ0oL6ngv+tCq2aFVU=; b=jymZOp4moS4HyhXt
	O/wb7UZhQWIttn1vJ+SfmkWCJAE0WjqpTo/6nzNd3IyqmgTCBkl0yA0Rsp+cvUsY
	2SlPeg2A61VbqsMx/bs5GwZtpssdQQM+pDIMqNjbL9ICUovHt1rRiMuXxh8PEISn
	y/CtgE5EaiuVLxf9zNdBBdFV+vMibXPqcW+TCCJcFDUCzTRABzg0Uqfj8deQlVa0
	OwCGvL9r2WSHH94gAbvTF9aeKI2D83yDeHqE2ZPbbvtBc9PdJMuTbIjbM6XyftQn
	hBiKzKkPOuAehLCIEkJFsoT233SGEUCMR6DQBLeLhugTZ7lQ3ph03auaoRMrimpD
	rjveCw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decmu30md-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 06:41:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso3884701a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775803284; x=1776408084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boT1DzvUzerPpvXV9ma/L9IhxRQ0oL6ngv+tCq2aFVU=;
        b=PnKy+iRe9GzoGgf8fzkokTgMulDLuCwo+4GBnj/yujBhf6OvWzgxfN2rwz4uxglU6+
         1cZwfxr9Ejt2r8Ua6iVsEYigj558lmpLcHCz5JkYeJbou4z+IJAw59xsiXsMYDZrdsYi
         aT0FiQJPZs/AGRSZGYxPX01bKHi8XFXCBaBCxLNCxGzJvQ7EzWqi6qDgSDL98iD2hjp/
         9BjyJ8fvl02/nbLwUAaGe6IT/k+M/jj392aeqsTqLXKF+/h7XqVl0E1WwaJbrRThNUGF
         e2qYLh2kOMTbBQ+tE22SNRsWZWIOwb/EKrlWzQ49KSMMGeo+xiTkKHq30U7ppVkJEvz7
         M/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775803284; x=1776408084;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boT1DzvUzerPpvXV9ma/L9IhxRQ0oL6ngv+tCq2aFVU=;
        b=jWzG697zFNUq+8Qu2qXeflwND+qrWqH9LGSurFEe8TgdSoOBA4zqdOZL5fEQEgveYH
         bxC7aTIXnoln5w74cpKdVDmfWLADj7fgCSpQfjrMrGXZGXEJGkLu9mysdC4VKiBSI0i+
         IZykgjUrLwArI+mdqQcQ9B1XjBjrrIWG++gUelwp902qqSg0tjnse5MDOARUdkRdHCCb
         jS6+jC3NdqevuoO1wM+Sw70X49dPzWV2GULjfKQPb123F1I87Gp/90S5+rI3AXI/eh/1
         q2NXS8B9ln6kJ7rF5gjkLzFqvlVCwtkQdrpTwLeQeh3YyfjQ/68vz0FwPRSK3pKNY+VQ
         lQRA==
X-Gm-Message-State: AOJu0YwBqtmv29IwBsLQt1ISQyDTbn3QFN3wq/9acaPJCZ5Z2H9rznBO
	1pCEpcZ1TkogvymHOl+X74rDFUXsecQOpJOArTSMFgDYf9Oy4S5brbsNctWbJQddNU7D53lZP7w
	KYacME44GNCzpH8b8lKeRUdiI89EBnE+jW4gPpAK+EvmDSk6u+afXaXm/UGrEib44JKFlaQ==
X-Gm-Gg: AeBDievDdonkrnLO73iI1nfSsJQAnb+Wstafgrvorx+xTIu8MEumUDSAc8cL3c0PPGb
	CaUel8B3w+aASMWHO+RSPtLWY60U9oxK96L6lp+Lfv+QlgLhtXfPgOnGLvbUaWxAZqf0GMMYZ8Z
	WOemqpLIwrSQJ2nEOZm6YzzJkifuMrKbl/t+gv4wAUlVGVlLNJ3djX5tULl/IX8HjTwyIJFkpYX
	TB9cp6xvGV0irGqtARMoYFGitu0luhxzJC0z5Ok/o//fnoINmnfXMHBBExluYL2Dm05fVnGgAAk
	r/u1F6TjGqtdTQBb/NL2GtYh0hWSV7qD8YcGb4cOKQPvHiS9AUtxyKQsw7IrUCm03X1DG6h2o1l
	6bxfML9vl7HAhmQKbK0xe+cQJHC6jzW8WnYx8T5CNYxv3PsqGslMyY4HqW2buxid+HnnQEV1MFB
	oExZbXX6GZ2iZcB4NLYB4=
X-Received: by 2002:a17:902:b193:b0:2b2:501c:bc0 with SMTP id d9443c01a7336-2b2d595b609mr17481825ad.7.1775803284465;
        Thu, 09 Apr 2026 23:41:24 -0700 (PDT)
X-Received: by 2002:a17:902:b193:b0:2b2:501c:bc0 with SMTP id d9443c01a7336-2b2d595b609mr17481655ad.7.1775803284030;
        Thu, 09 Apr 2026 23:41:24 -0700 (PDT)
Received: from [10.133.33.254] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4ddb462sm17255465ad.24.2026.04.09.23.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 23:41:23 -0700 (PDT)
Message-ID: <d6ffa7eb-a589-44b0-ab94-5b4f8f21fd44@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 14:41:20 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Consistently name struct
 ath12k_base pointers
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260409-ath12k-htc-proto-v1-0-cda86d6355f1@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260409-ath12k-htc-proto-v1-0-cda86d6355f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jNZxNeE-FFKQvLTJj9zbLx4NSL-4pY5B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA2MCBTYWx0ZWRfX5OPN/eg5KpFS
 C+JB7vmILQHtRAF/jtjG//ngeOecGI18J4MqDbhI0kSLK/SZsmHeUEw6YpFH0JxyqNU749sHC80
 jEb55bpuSaDinTF1DPcv1EHvetylNGmeMzh6N9Er3u731xIN3YWAtvINAfgCfngOwQn9UuTYHe2
 NyWkBlak9W65lIOXEQgRM5M0Ycz4M0ctIe6X5nPLPNSATq6U0X/BBHHKjFw4T3WOTVEOZcbi/WJ
 qSjc0Zwh4QcYZ5Tur69g+VADFVTcYMegkLjztW00kOUKKrelJWDrGSjYUreu4px1aCyfEZvXqny
 ZhUIrJclORtWQ4a1maVDmi3Rwj2bpfExhQf7Ck7ilty9Kh0ORkJkKq4kvGom5EIHzj444c3e0ju
 AeTKOrgyidfOu2swKzbejhieOJF3mF5JkyS22RpHJfdKO28any6B3rFEtwNzKDd9UP5ZkS2Nsn4
 mZiqUFeyJnrQwJ+uRYA==
X-Proofpoint-ORIG-GUID: jNZxNeE-FFKQvLTJj9zbLx4NSL-4pY5B
X-Authority-Analysis: v=2.4 cv=DslmPm/+ c=1 sm=1 tr=0 ts=69d89b95 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=YBKe9LgOGv_X2R6aZv8A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100060
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34566-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 656CF3D2DE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/10/2026 2:44 AM, Jeff Johnson wrote:
> Per ath12k convention, a pointer to struct ath12k_base should be named
> 'ab', but there are a few places it is named 'ar', so fix them.
> 
> Note that one instance in ath12k_wmi_tlv_parse() is not modified since
> that instance is being removed as part of:
> 
> https://patch.msgid.link/20260407095426.3285574-1-nico.escande@gmail.com/
> 
> ---
> Jeff Johnson (2):
>       wifi: ath12k: Fix HTC prototype ath12k_base parameters
>       wifi: ath12k: Fix ath12k_dp_htt_tlv_iter()'s iter() signature
> 
>  drivers/net/wireless/ath/ath12k/dp_htt.c | 2 +-
>  drivers/net/wireless/ath/ath12k/dp_htt.h | 2 +-
>  drivers/net/wireless/ath/ath12k/htc.h    | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> ---
> base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
> change-id: 20260403-ath12k-htc-proto-9cdc961f39dc
> 
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


