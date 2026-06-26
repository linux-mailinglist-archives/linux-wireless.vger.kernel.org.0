Return-Path: <linux-wireless+bounces-38106-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3TPzDo7ZPWp27AgAu9opvQ
	(envelope-from <linux-wireless+bounces-38106-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 03:44:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF146C987D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 03:44:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=IVQBBfkB;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="PfHI/g+m";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38106-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38106-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F19B303FFA6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 01:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835E1EEA8;
	Fri, 26 Jun 2026 01:43:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DED1ACED5
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 01:43:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438197; cv=none; b=jIiEgnI/4xUHq9ParrsNS0ri7N5W7GjWlI7ATAHHqJPgbepz/abipoE8aH97dtj+rE22bdtK5bMObDa9WnCQaCcWH5XPfPwDq/AOB/uOfBxesjX8AwzoEucjX4TeDQ8Kpy/m+cMD8jy9FANi1zKVcOBCd8Rwm7WLe56geQAZxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438197; c=relaxed/simple;
	bh=Mge6aCyO9gk0xuIyFHM35W6iuf5OT7ie+k/SZ4EZ7I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRCqIxzD5+kSBB/QR/77dy+1kBXDaaZuSN/gCRsbw24F4Wg5WWwh1twqACzKvW8TQ+wwMZ4YUVYzSavGzJZVbm/njOsgE3oJYTIKWAuDi3CV4PiguE5lp4FnJSTZsuS6/ICVEGigxEiubptfMO96aalUEvKAgMljEGcnpWFfnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IVQBBfkB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PfHI/g+m; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PNugrN3890709
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 01:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/fnTORMJ4QuIpYyYVwuCu2i5cmixAmlTRDVih0/eoO8=; b=IVQBBfkBrhnjc5RC
	Oikyg9/YgEqcoA125TXX1n/ql2obGcg8uCAsYn2bg6HujRg70p+Aq6cMkoh81Ngd
	o8eO9nXuahcN8nHorhCG5Yqzw6UOVHqp08ZWWDgziLZsfTdN08wWP4MCQmdnROuC
	Y/MOn0FMbg0bPihs44Se4gwNVkI6jjjQqJYnE4oPtn0UUn7OlSXZr21IUrzwwlOU
	DyiHdmvwxPkCQWySXyXLLxZsCFyEKYZN0/35v0Sc4G7R6XhP6xh7Edqx73+mqfql
	QzK7W/WBckTSTDVjxUZPX3C0F6TA/K2hMzn5tRNKoLgcpvGnTmdqUPV1BhyN03cD
	du25pQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eew8btf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 01:43:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8895156101so242030a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 18:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782438194; x=1783042994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fnTORMJ4QuIpYyYVwuCu2i5cmixAmlTRDVih0/eoO8=;
        b=PfHI/g+m0RagLDXqPiU0y4Mh5aM5XYrumJUG2kEb2IDOTALeOhAG4WzAfYQP18ddhO
         hTpb74tV+y4JOVGmkjra6zCRDyJH9lpNZowZZjSJOYWA4M/vfPYQ+0G8sagcGNaAypTg
         hmg798PUGx43emF40p0C2rsGl0L0SOM9zk1rI91bGl9K9vmSz0mR8CRjxzZDt9TIvS+e
         hOSRU3KUZIO/rUGjHTD6Wnlfk0LNjs1fZcYIjVYG19Xs33SvoT/IiFQG17nUWf3/Lr4o
         pdP+AK/kj6JbURnkGyzTZ5xUYb20IaA0DtNwBrxhma6FdA7Eg1YIv7NHeoKhvxyTb6pP
         xPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782438194; x=1783042994;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fnTORMJ4QuIpYyYVwuCu2i5cmixAmlTRDVih0/eoO8=;
        b=dvA4Kq1JboJIow9Ih13sPFtH6jKNliPMk3FpqQYMEfVGWbcWMdcNGsSjr1pjyXfXPQ
         N4v16ngeF2mjc0xfgbeAoQWidKi4DX7w9e7Nf5D1s1YjO0HLDL05X7wZiPRt/7CpZZ0+
         Rfx3KVOq4UlwGWZHlQI1biE/oCIVBkYs8STIojwmbm4FWbeAWSZSvMxS7mbuDUGNq/CS
         yJxaCQddcaGeBo2sLnapw+4KRPAztbIulajLoMzM/07jO++3zlKvC9p9aLWEC1cblnun
         fVfy7w2uWy319Tb4Fq4uVBwNkQxdbFOCTjHneDbq9QasLsCkiB25Cvr7Fbeev6yZofVq
         deuw==
X-Gm-Message-State: AOJu0Yyw2XTwauJ0R6D+YKCynEhCEYdNZXKPJJ4MlA0Pn958f8td7efq
	uuysMC6zw4vbkknlqqpvDqBgVuLGpKOipYBEq7k29ljTYVxWMvFEWNwx/o2evn+wsNdDnR8jW4o
	7AzOef7hqp2yyDngVSF5g9sw+P/iRdq8ipMZd4E53reG4IMMCFcKfhoHMiaX2xB2OVzlJmA==
X-Gm-Gg: AfdE7cnrrQ1Ng9Sq3srDNXPB2UEKB9s9tYFGB4wZRi3gvf1hy5KiRaaN/sonwSXD8Dx
	GuLGn87yXUGKajCuTQ60rWrlPzmuOcgc1QeCpwV8I0gNfyB2cAW8ig+FlSACq9BRRApH6RpDZC8
	yqHdeHx5z4519vB0i4cRFUhmCZUD6YW+o7h1/WtcLnd1POkY0hVO+Jh5rFg9D9QN+S2uFg4Es3N
	hzMxUw82oeKUb1skZHvylNltlodyQWK2oVls0cu9/FjfPDfT6Ijr/Tw18ELfB1UU5yTpS9PvZAI
	mhnYxA/0MnhHQSBPUXK5jpdd0wbMHF+NYQJnwuLaOZXNmZ705BmYqFR8TLTWKzIw3Z29JCs6YHN
	DDT6xWUd3+I3Lu3uVbHAxMr5Br5cinPZpL1u5ZrA/UAr553NaDhAxtTAUavssH+G9+5rW8HkIIh
	zZ9UcnBRc=
X-Received: by 2002:a05:6a21:4516:b0:3b2:86cb:929e with SMTP id adf61e73a8af0-3bd4b30f107mr5593972637.46.1782438188897;
        Thu, 25 Jun 2026 18:43:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:4516:b0:3b2:86cb:929e with SMTP id adf61e73a8af0-3bd4b30f107mr5593951637.46.1782438188433;
        Thu, 25 Jun 2026 18:43:08 -0700 (PDT)
Received: from [10.133.33.10] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b96ec739sm2522045a12.2.2026.06.25.18.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 18:43:07 -0700 (PDT)
Message-ID: <9077bc04-9117-47ac-a3cb-a17baee4d4e7@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 09:43:02 +0800
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
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623-ieee_link_id-v2-1-8a89d71baf58@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDAxMCBTYWx0ZWRfX2EyHz3dvNC1r
 39sh/EOUgAHfDmuZNrEPdhATZS6bfYgnQgemUYpUs5X6hh9vV8aJIYxIml7QJm/ryuepLd76FSq
 PeY2UsgJre/nq80arJ1qAxhkSv8gW+Y=
X-Proofpoint-GUID: 9gOHzVugn975plcq4xnwmT4xLuazBKzM
X-Proofpoint-ORIG-GUID: 9gOHzVugn975plcq4xnwmT4xLuazBKzM
X-Authority-Analysis: v=2.4 cv=P7UKQCAu c=1 sm=1 tr=0 ts=6a3dd932 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=yCQnc_su61O_ujFCQIoA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDAxMCBTYWx0ZWRfX/ej3LOIz/cuW
 vm+BxKzd6K+WcCX+FjVDr0hG66HZqobneSi7hBP3eNoKpu50lQGyRlW2qi3GCX1ptq6kyfJFYGI
 wSzkVoHf0lKJsswOXQZ3PGaKijvuCnYr6x7ktpSZgqxgUP/iPyiLZkoYNsYsg8hCPCoKaC93C4e
 RZrfjfaJLx0JreflEc55gsaeB/vuRDe1UeIoynm+WqkRiXELK3WpEfX51ztyjtgAjfRH/O0gE2L
 fvgQwQYvLcInEYiwKjVre2UN0rqpzGkmTHTy7ykednlJioTGW248A4cUEWRXzErwpJ58JnUsv1R
 83U+Rq+Fuiqu9rM/n8Eyzi6SQTyaDj5OBqCr2stX3r/oQSWv7ytt/efSx3ejqIlMQSgRMv9Tw8D
 4TgAAtvho0x7+bbnm0gOe2EdZ82A1AS/0We9xEuY58mEkiEkhxwd+TySLXRmFhEeHkZ/W5u3I//
 q6RNCbElWhxu7Hs7xjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260010
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38106-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:manish.dharanenthiran@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:hari.kannan@oss.qualcomm.com,m:karthik.m@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CF146C987D



On 6/23/2026 1:46 PM, Manish Dharanenthiran wrote:
> Firmware builds the AP MLD partner profile from the hw_link_id passed in
> the vdev start parameters. However, hw_link_id is not always the same as
> the logical per-MLD ieee_link_id, since ieee_link_id is assigned per MLD
> and not per pdev.
> 
> This matters in mixed MLO and SLO setups. For example:
> 
>   MLD 1 - 5 GHz + 6 GHz (2-link MLO): ieee_link_id 0 and 1
>   MLD 2 - 6 GHz only    (1-link SLO): ieee_link_id 0
>   MLD 3 - 5 GHz only    (1-link SLO): ieee_link_id 0
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
>   ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID         BIT(18) for the self link
>   ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID_PARTNER BIT(19) for partner links
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
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

