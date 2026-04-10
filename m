Return-Path: <linux-wireless+bounces-34561-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMjiDA5h2GnScggAu9opvQ
	(envelope-from <linux-wireless+bounces-34561-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 04:31:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC843D16B9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 04:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 522303040957
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 02:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CDE2D1F40;
	Fri, 10 Apr 2026 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+eDiDjA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZukViwAa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C722F1FED
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788238; cv=none; b=NcBYu6VxSCQ6+aFTv67ASicrf/Cw28s/G5jrTd0kRxVNMZ6qqFGmPueFhtM1Mro1L+SA2S7pdD35rKQ8m+SZl1ky+/y0y3TWAg+/gp/mL3KoJpdvU74iw4dkltqEd/U5gUBsBqyoXZlmtRV4fTOeTmAZ7Nz1IdaOHvnC/OQzHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788238; c=relaxed/simple;
	bh=tm3RJCpZIgK9C2KWjhOKKOAYDliWfc4fdVEtxT4yfGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiJFhDSFzIFxMpGwmRTYGhjgaCrUYFkpJd6KhrpwUhTslvDZgqBqelLyXSVB/xZgWETbRfWMs1FxKcng8m7YOCoZFBzbSWbzB2asFTolPg8HDkXUEz39c+7u5A36g5bgVTj63YF1+kVJWAvBO/hvFFYb15aFeqDceiMkfUV38Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H+eDiDjA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZukViwAa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639JFOf22866294
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 02:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bv09rG3fANuVpGBkjHtt7All7i36la4x+57OM6mjhWw=; b=H+eDiDjAu3Uktml8
	C6WkWrJDfAbQNDj7Q8EQltBTiRE/JLoH9n48o36hDYSIscYaVQf/NUlo9D1+9ebx
	H7I9RBbjeYtyx8bkkcgClzARdYpKRX12X/7Sm3fxDE9FUSPL1/jVZHyoLT7WeN99
	Qwhy7UZwZddHPuKWuu+thwkhBQOzifXkT4tiDw8OzzYTBBu7Ixu+pkF+H5nAxeAz
	AYee66WUwucJTejrygfd/t3JR9SvM0OrZuaRaBnIQqxKOAiLCc6zOQUmtvkxRAYV
	qhG+fWlySyXz0h10ytcC9bGY9Y8sH1WD/OJhvNBS9OMT+NyP/HYOxl+f+rC+HJm0
	LS7LTQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decayjh0c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 02:30:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35c0cbe0f64so3142034a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 19:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775788236; x=1776393036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bv09rG3fANuVpGBkjHtt7All7i36la4x+57OM6mjhWw=;
        b=ZukViwAaoxca/FFxd9bzqRilijnD/jpt0C8q7bs+lIvXs9egXAbaJA0rJnSu+Evjlw
         0fhHUbWKXk5J1yo908QddIOikn50Nw9e22bcS70RRK/3ollVN2kunsVgyozZCn0uf0wL
         gfQtyMqK1GyGAcRC0nRzqy1dqkRTq0q6o+kglSDA46Sna6JI6XfIU2SJgSwvJaUK0+7V
         Z9rsRvrG9t6b9l6AGmq3LP2G2nyojSgKoQ3fOWN4VJQ27QnPCL+jsXPtsigCSb6Ztpnq
         rXF3UdoZvvyoLQSlWq2rNw0i+/MESNceXpKxksRJ+8wH39YtphuJesNwCKbsMfRouT4I
         8iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775788236; x=1776393036;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bv09rG3fANuVpGBkjHtt7All7i36la4x+57OM6mjhWw=;
        b=JfBGXLLuC1kbQ4zZ7OvOb/kcDo8zBEFSz2oY54iAoS6OjTlw+wpdzuY7GP7FROWR/K
         A9uDJLoLy/csuZV4uUMpaE/4I9hsyrFz4NSMdAUamPBB4zHL1hVdJ47t43KZ8q6AnFGg
         PJ8eHyU2l7FLwgUOwexUjRToeUZGy90tJHCHCFb/LMldm745Ad0MOiFvNY1ZrqMYItAM
         w6JXgsYkHBeNrPADP7PTDqBmBWYWI2q4i+WyrfYlsH7pMhA460s6XW6wWqWMwjU4lVq+
         gGXklktigRRWnKjxrW2romGS5YpTllrNh4Jl74R71FCuHPFq2K1W1i51FlmICmXf3lYN
         r2jg==
X-Gm-Message-State: AOJu0YwB37mcz3AgW2MNUQLKC+qPYPfcjj9BaqUV69ptW6ejObyNLdGj
	OpuUI9EJthy8Lqc05Mjwca+tP8bpMv78gSQ/YbQRVZN58x1oano8PHim36eGk47XmfxFbNmfvDX
	oMhLqk1v4XqjIwQR3QU/xAmJUoubGzd2YymcTVVd3wTvVLdEZ6+LCKzadQhj9kEn4LvLUUg==
X-Gm-Gg: AeBDiesiI98wScyaM/th3JiF7/YFkPLDofc6tHb3HZryuo0uI+OP7YVk5/X9CtKsvVh
	krfzOYcyieACQf1TUzsAxh1v+CR+qvSjDaF4V0zgqsUr2HFfeckXSks41UgtMx21eSVBWbrOTks
	fkrbJ1Z50vGk6SkrJQzq6j3d9/fl67uVWsTz5/DL84JLqvUDU5yF5INSttQzYHBF7xNTEvfZl1u
	r+g8RU+2241Sp9Dsaj9eXpDMDYjVsja7ztK1O0wtSEHTzOLxELU32UcfCD7M9KA0xumkDH6zZ6j
	U9OQ/+jD2idT1UP3/V+V6nv0nYM4gCnYpKHFPW5qXlYjobs2+YhtDzKcNV/6pjFq3DaOfcn9GcL
	4rserg54oMFXn75/CUAYHnDAI7kZf0zb8TCGD95jYJxzd5e/Xmzag651CCZUB8aF/hpoJQrKTjo
	e+VzWurLxVFcU9Bg9EHlw=
X-Received: by 2002:a17:90b:3dcb:b0:35d:997c:8ec0 with SMTP id 98e67ed59e1d1-35e4282bdb6mr1425019a91.18.1775788235512;
        Thu, 09 Apr 2026 19:30:35 -0700 (PDT)
X-Received: by 2002:a17:90b:3dcb:b0:35d:997c:8ec0 with SMTP id 98e67ed59e1d1-35e4282bdb6mr1424996a91.18.1775788234996;
        Thu, 09 Apr 2026 19:30:34 -0700 (PDT)
Received: from [10.133.33.204] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e410b17e4sm1209774a91.0.2026.04.09.19.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 19:30:34 -0700 (PDT)
Message-ID: <91c03b6c-f31c-44bc-8640-1aa16d538e54@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 10:30:31 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v7] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260407095426.3285574-1-nico.escande@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260407095426.3285574-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=69d860cc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=2fhWZu5mPpoZkjORUEUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDAyMSBTYWx0ZWRfX/BZc+RzPhZfT
 QxSdxE2MS7zOuELWjitKpDlKGUokSxZETrI35Oc4gAmeBAgJNDjTT2eRjbUB8uKm0pvfJOEzS84
 xwaT9ar/U4mfC1OpbIlKhOwU/F2QEbYp/nGCYHKHcqzzS6Z/oPn7BzL70Zwq65his5hSkYdgnfd
 P8nTn6uvecJ6FjW1CgYMjbxiF/9noRn+dBNgXFP7mBWs3zegs/vpQeKt2nMVoDs3Fxyu3jeYnNi
 xcC0JgNKjZx5n9OfyUjKXvJzxfe4oi3SQ6f5p9vWGgQhHWbdDTXdZMgdaEpN6MWW6V2wZYzTcsH
 nKPW7vXcQAd7deBM55WgtIYvRkbzcIVuQrV1EbL7jCxpxY2lOpZNiVK634/frdjo3kbUmsNegPP
 rqijIBf3qDsdnNhbrCdn6K39CbxhGsQtXSmZrOGudtMzdEZHEW4XGo8eJEBp4Yfv/ND1TJ7iK7M
 sPzR26CkNKpCo8CrYmA==
X-Proofpoint-GUID: HPniFseeSPXYMCCKpsONkR0jeHrz4gUm
X-Proofpoint-ORIG-GUID: HPniFseeSPXYMCCKpsONkR0jeHrz4gUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100021
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34561-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9BC843D16B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/7/2026 5:54 PM, Nicolas Escande wrote:
> On each WMI message received from the hardware, we alloc a temporary array
> of WMI_TAG_MAX entries of type void *. This array is then populated with
> pointers of parsed structs depending on the WMI type, and then freed. This
> alloc can fail when memory pressure in the system is high enough.
> 
> Given the fact that it is scheduled in softirq with the system_bh_wq, we
> should not be able to parse more than one WMI message per CPU at any time.
> 
> So instead lets move to a per cpu allocated array, that is reused across
> calls. This memory is allocated as needed and refcounted to exist only
> as long as one struct ath12k_base lives.
> 
> ath12k_wmi_tlv_parse_alloc() and ath12k_wmi_tlv_parse() are merged
> together as it no longer allocs mem but returns the existing per-cpu one.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


