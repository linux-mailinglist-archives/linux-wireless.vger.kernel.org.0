Return-Path: <linux-wireless+bounces-38049-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id caNZIT2fO2rsaQgAu9opvQ
	(envelope-from <linux-wireless+bounces-38049-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 11:11:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E83876BCD5D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 11:11:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=TXtPqNuv;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="gM/ivqCe";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38049-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38049-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB0673025A45
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F02F8EA5;
	Wed, 24 Jun 2026 09:11:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A42F5474
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 09:11:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292282; cv=none; b=dUYhrdKJ8NbnD1o0jOCnShLyEbjXPyAGpA30gXSD7J1TMe73W8+ADxmElPLrIOIMnMjA7boPRNv2QIs/Dm84abWcclWIZn80F039bgJr0VEb0QnfonChx3erf6yVrlzWGFFZ6YNAiieKWIM3tIAiHqo9fSYfsqAMySuZKUpQchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292282; c=relaxed/simple;
	bh=vh8bpCuFE/72J9nCp4JgTuEMbzM4JtfccH19rH9RkQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmADDcvpf+ZPpiIPNbh+lJEY0JhOAQ0c9S5cSQ2X//rC88a5wniguazyN5H+VU3YOcJPe6LuMGm64rgdskozYVAUr+2z9CA9tcV28vPMDyqmuCa2vJpQQEjuljTlmu1VQPpljYE9M2Fq4lunc9EvRu+yulhUpjR6x1pyj403kTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TXtPqNuv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gM/ivqCe; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5tw4m1976573
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 09:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LnKPMbaEz8S6AzH18qjrZcejfBYDxVuJNEStVWJFljo=; b=TXtPqNuvEOUvv/KV
	Mr4MDh9QVHOixqNFc8erdieGIfi5wb6CKxtRtQLxqd2s0PTEx6nsSt5Nd5Xt46CG
	8UzyALNviUZ9uArwLlu+aWKwX4cP1GIubAXiHZP222l0X2h6RpTTPAMaLJ6g7WiU
	k9lcve8FfNgivLM1kcNeh8GTangMeaTfTuHCoJC4YdVAucLNmDcrCbDgwSm0dw/8
	oX5KaG6I4+6ri5yUhPWP5mLK/AhjasHf3usFECavn1smLGqErtKurZKSpyCguexz
	rrDQx6dSGsjaAYCjR+xDEXBYzfPg4z2mVcGzjAZv2RKFKDhq9uz64RSsOxSIMqSE
	CJOtaQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05aq9dds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 09:11:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8422f987f2eso1362232b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782292276; x=1782897076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnKPMbaEz8S6AzH18qjrZcejfBYDxVuJNEStVWJFljo=;
        b=gM/ivqCeezmo9HKvbmLu7hdWL3+qsnam4DxUhgn8+Lb8PFVyJf6iUzJ9RInkM5NiVB
         pWOHFDITcG4P0pkyMlRWnkvIG9VTXdXBLgahUZ/ZzTqEDyG3uoy36vCXkCSEy86V3PRt
         qz9uwGaMBudfy6TeFso2Ja6UMznA3eCZnQp+kgG8RO49QFx1BWoC1uKs2s26+j+RJGXc
         SfDU7Gp35Y0llHTJ4s8ocXbuvQSBfDldIX177h1LU80yngu8+rdrh/0NGh9vpxlQcICb
         5Q13egHbSisl/iAk/DFWRLSEtFO7UPNW8sg6fHcGvZYUBYYHxlWJapWxyd+J8tKzwEQp
         HO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782292276; x=1782897076;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnKPMbaEz8S6AzH18qjrZcejfBYDxVuJNEStVWJFljo=;
        b=eMN9dwyN64bAEx0npSadSpy0QiG0CSkJQ83QqwEho9fec8IgRIn8DljtHebvJCL4Wn
         euEIfAxtbW7bH0SrXd/d2GVdZcaHROQ+J/4sxV/X4XBOVl2xaIFb40wN5HWI20Fw+Qnx
         nFOwGlNr7uJ3B8AvWzN7k1uc+Gj9NUpWYb4ZO70j8hlbvLbUCqZlGreU5gFgc/F8QtAD
         pMutF9IJ4dnEYL50B9RMAK/rjMTY9wg8VYgNjBVMYNJOmzcxfhiSahQN0rKPJ5rKXNM9
         wCJlW1qYUsPpH7dQZfu3p1+f64Mea7jwXzbmAMFKvhLxp5qOgZKFBPOSvvrPpfwvNstN
         mcHQ==
X-Gm-Message-State: AOJu0YwJTeOyStnBFk+pit5QtvDWv8JXdcUP1jR1JIoqaCI4kD/9rHdX
	tuEVEVYS/qBA1p9FCkwOBHgHilOUt60txfr5d2tN+YEYfZSO2Lnpsyqqa8dCQnOSK4wWW4AgdhO
	ggatHl+buDkMGgllP1EQAfT9XV+uFKb9TRj+SGsfFafcGBgRFpLZ7/nHcrd7p73H7okB9unVpSU
	7v4g==
X-Gm-Gg: AfdE7cmchWzcMD+PwNJsuK6mEZaraUKfzHj4uIN2tZyS1R8r6OkBGOhcqqKnIG2i9/d
	JlU1lJLGiXF2o5zlsgSkmoA94i7/feCRQLSL1h9tlR9FALta3xGpJfRO3fXWNSIxHEV7qb5Bf/y
	nRfsPLrFMdCRZTlfCQIGGWijoQTm2ULKgfkREotuS17uHzwJxmbj7jl7vk39t+sn69uJOqX0x77
	PV+ZRC4Dcq+Z/4+D+RNkPHu29XlRERi1R3udabOURkNpkKfZc6hc/PP/xeNDcwfBa8UUfk2b6eQ
	XoCCp+cS8qYCbDti4G7g2Ft3qY8VVLugIwBgXmr49QgL31+dUPRURLKBXsocKOhj9FEVR7E/Rms
	Dl/4EPKa4g66m7C5zny+al0t81KHN+/CYdWxpNfN0pLJxYt+GqDAuxJOU2A==
X-Received: by 2002:a05:6a00:3e15:b0:842:38d2:a35f with SMTP id d2e1a72fcca58-845952d836dmr8374291b3a.31.1782292275708;
        Wed, 24 Jun 2026 02:11:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e15:b0:842:38d2:a35f with SMTP id d2e1a72fcca58-845952d836dmr8374248b3a.31.1782292275215;
        Wed, 24 Jun 2026 02:11:15 -0700 (PDT)
Received: from [192.168.106.30] ([157.50.13.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fcd1fbsm1565426b3a.3.2026.06.24.02.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 02:11:14 -0700 (PDT)
Message-ID: <dde0f81b-eb62-43bf-87b5-ecb2249b0226@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 14:41:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: advertise ieee_link_id in vdev
 start MLO params
To: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>,
        Karthik M <karthik.m@oss.qualcomm.com>
References: <20260623-ieee_link_id-v2-1-8a89d71baf58@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623-ieee_link_id-v2-1-8a89d71baf58@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA3NSBTYWx0ZWRfX7Y+0FG3j0DOe
 7sQG+Km/9X0gh38tx4n8R4INadXFVjGEDHz251JymT50qEB5Pm234zPfK/NBphzDxfdVydrDv5n
 u5NsHhWIvMBh2DlCxhAPDZoDoaI8LF0=
X-Proofpoint-GUID: eU9lSLFgVPxeipeIacREuazBKmax9ZzC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA3NSBTYWx0ZWRfX/0fiSOotLpad
 NSq/p0JjozO3OOJVUTUURei0jPatZzPNhJz5VZiXYFUqdKkIGtUYzgAZHsUw+74qxVJNvavbZhz
 JW6M++ygv3QQAxkgZhbjCTVB2mvwfqcRDTnfR87jw8kqKYF6TcAU9gA1pYaLShVwxq3fYPgp8RB
 Fz5JE0cv1YQgq+0nKB2zrQitXGPlr2uof5rgKGbdQBsykbeXmWzFXD4Ij8Sb5RUwoKZcUxK3e9v
 zQtMSKbBxjRjnUVK3GX9t73hPajJH8lzc5PZ8ne53jjLi4sfkRxzgsQQgV1GtDAWg0Gy8u9A/3W
 L6d/TO4iIh45r+pIje5RGnmw+O4NEL5mCoP5xD2vZok460rJ9sDXgfZsR2+zhp9ONq7qbVZf5Mr
 Bnldps1ZgeBWXURoSXDEXgLujUsIdw==
X-Authority-Analysis: v=2.4 cv=UphT8ewB c=1 sm=1 tr=0 ts=6a3b9f34 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=DysFi5wBN3dAxe50r5uYmQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=yCQnc_su61O_ujFCQIoA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: eU9lSLFgVPxeipeIacREuazBKmax9ZzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240075
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38049-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:manish.dharanenthiran@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:hari.kannan@oss.qualcomm.com,m:karthik.m@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E83876BCD5D

On 6/23/2026 11:16 AM, Manish Dharanenthiran wrote:
> Firmware builds the AP MLD partner profile from the hw_link_id passed in
> the vdev start parameters. However, hw_link_id is not always the same as
> the logical per-MLD ieee_link_id, since ieee_link_id is assigned per MLD
> and not per pdev.
> 
> This matters in mixed MLO and SLO setups. For example:
> 
>    MLD 1 - 5 GHz + 6 GHz (2-link MLO): ieee_link_id 0 and 1
>    MLD 2 - 6 GHz only    (1-link SLO): ieee_link_id 0
>    MLD 3 - 5 GHz only    (1-link SLO): ieee_link_id 0
> 
> The same physical 6 GHz radio can use ieee_link_id 1 for one
> MLD and ieee_link_id 0 for another. Pass the correct ieee_link_id to
> firmware so it can build accurate per-STA profile elements.
> 
> Add ieee_link_id to wmi_vdev_start_mlo_params for the self link and to
> wmi_partner_link_info for each partner link. Populate these fields in
> ath12k_mac_mlo_get_vdev_args() from the corresponding vdev link_id
> before encoding the WMI command.
> 
> Introduce two new flags in ML params to indicate to firmware when
> the new fields are valid:
> 
>    ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID         BIT(18) for the self link
>    ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID_PARTNER BIT(19) for partner links
> 
> Firmware parses ieee_link_id only when the matching flag is set.
> 
> Also fix the debug message by using correct format specifiers and host-endian
> values instead of __le32 values.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>
> Signed-off-by: Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>
> Co-developed-by: Karthik M <karthik.m@oss.qualcomm.com>
> Signed-off-by: Karthik M <karthik.m@oss.qualcomm.com>
> Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
-- 
--
Ramesh


