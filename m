Return-Path: <linux-wireless+bounces-37928-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TkoeDEmKNWqdzAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37928-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 20:28:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 909196A75CB
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 20:28:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=RcFqebM4;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=WXyJXUmt;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37928-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37928-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95E74302C78C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2DF322DAF;
	Fri, 19 Jun 2026 18:28:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E42AD03
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 18:28:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893701; cv=none; b=P9u130h0jzRoo9vOWx7S1wmA1Y8fSENFyyaAdfHUzCLN+lm8goHkFg82t5Ro4YUsoRsTEsOa3Tic6eMc+oPJ1U16xp58whuXZVYEtrMLvzFJU4SHf+se+O+RbYHw5Wcx8oCNBAGdpvsqnq0LGHdLUPUdCnm6HVHFrN2WL1+fIJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893701; c=relaxed/simple;
	bh=tAfgiXjRlJ4nY2NO+jzI5HVo4D47Nm7dFj8B9vFuAJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMnXmSFuizbUX6g4JCU0kLijT1AfznCVV38Zjxu9auN34DAuwyYPRCswPBsq51eRyrzhhvUv21zwItFDdDve6oZN1MopbBJPkRnS84eeGBWLy6llSUfjg4RRmqbG+LWqsFz/d40N/4LsrncBGJ7qlU1ue6BUR7qKqErPRqt45Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RcFqebM4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WXyJXUmt; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHVMig1155189
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 18:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SvV4yIxaCHiXp08Y1cQIj1hDP306eANdh7HRG2sQqZo=; b=RcFqebM4SivsXGHn
	8wG5nVZSA2+Vvm+SCRa29tE5EOv0sseJm0pLeWRDuRcfnlRNLL5SYRMwVn1d4SYv
	HN4oXSvK1Q/Ha5ZYUuwAtu7MSlA63EfCMsC+nIurYCxoXZKGYmoKLwJ2yB69Ksf1
	4WY01h/c7035gKEYx5fXzLQLbMYNyszJk/wNuUlMYFyWvXlZRfg7co57QsF2O0/G
	NlfwA3mQ/4zXQxG3Hne5vPbZ/5Qzj3KJZd3MtJF6HNzlFjUUUJJXEv8ZPRSQOdxn
	8fvpnDuOJ+JMG5ZTsPSDVvmDOFTqdm66IfgtP3WiZmA5wVvPBtYoK1TTqs4O66XO
	dm03KA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6scgcp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 18:28:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0532a6588so21940505ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781893698; x=1782498498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvV4yIxaCHiXp08Y1cQIj1hDP306eANdh7HRG2sQqZo=;
        b=WXyJXUmtfTrN8TNrEww8AiDOBDvoQMOUCX5OtgOnemEP2SzaZaRMEtkB5eoILV1rZu
         E7dEmEfyHIqWNdxcZG4legyQC2fuNLLSonJMbCWMN59F3VedhDGmit3e4He7D3TdpF/w
         X8IH/5vtJ/l0LUxtp6CJP0p5dnEhRwKGZ/EoIiUIlxmnID8Xl2tT9TAxoggU/IRm9oHz
         frMgnC6gLxfl+JmNiyKHy+Q1dxXiE6Gv4itsVnPr90s1bMhqBnbSbogOjHxSmFk0tGzE
         6Yhh70sDd+Zr7q0cbsjFHcrOZbSg7Re+mjejobL3EoKDv5hVJuqIu/LEdBM/ZXG+5qGH
         wetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781893698; x=1782498498;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvV4yIxaCHiXp08Y1cQIj1hDP306eANdh7HRG2sQqZo=;
        b=ckxpftBrLHHLdt2YSf4PViYOk7bpxdwtJ7GdqnkVQnVMSGD5MgX/hMYTyNEkx05wPU
         hhGLMEvK8b5D1wno6ehBc1Rxz0p/FvOAXfeViXloSRl/23DlPcAWXF8TmzbvQw0FoTgG
         4u6GNEFlnFED7ku0UxdBBpMoRCfsUQNRTde1sgqdN6V1MUyApuFvrlr4B1vDyP9Z3Y+I
         BXAVKQ5sZPq6N/wEX0XBUr10brsYZ2fxY1axkLyPkYIQmUgtcoaB/QF0e4UchD5oOwhr
         odKlwk48BS+BVml7T9RiSB9p/q7PdhVhiW61geoJW8mpqe6m9VOWPOCygWuYxNXMPskW
         i2NA==
X-Gm-Message-State: AOJu0YwzxKclrwuODvYyD4/UD+NLortAOz6hN/YJWYbYl+PQFZnb6zvV
	JVRBlKephw9TdfIWew9gEhz5D2RoWRSLyazXZk/Ntedv1oWhG+4V7BBgX5Oi1Avq8uTqcVKUp1z
	US9VrF6ElC6TqzMhkS7FYsn81a3BaRSgq7pRFZ//oESJRXaveLsdxyJFcnfsdhUtT726Z9g==
X-Gm-Gg: AfdE7ckIT4q/kc3tLbmZOID+Mtd0MJX6c0lHyWdD6MNyyInnEkglKav6w8sgt6Izksb
	sqv+sqO8c3BTUJavR+6dBA9YLo0nhqsPJMK1V2SAIB1AFzfALctN94Le1LZbR7J8VCOzReUAHdL
	M2+1idRCHAFArNlvWYgMeiLwzfFALIrP+JSvIXPXCJ5fFb7S4gLDE4HW+YRVizP9P3lz1OwIlyn
	L9G1ezECB50rA4vYu77pQ+rgoOTXPebU51MJXn34yQ+hdYN4undRrlp2cnDM9JQxf3wgj8xAv/t
	PVWzczFr9Umq5+XUKvvbAYvhok4mcK5r84INS1GpKdigfCAR/TWWKL3efDw0v8c4RknJ0y7xWyh
	s4R17KFN95vYjONcUU9D66rw/NAgf6pITkVu/3033No4r2ZkLD+3qEAI=
X-Received: by 2002:a17:902:e80c:b0:2be:fefc:d5b9 with SMTP id d9443c01a7336-2c718f1f1fcmr52163945ad.5.1781893697611;
        Fri, 19 Jun 2026 11:28:17 -0700 (PDT)
X-Received: by 2002:a17:902:e80c:b0:2be:fefc:d5b9 with SMTP id d9443c01a7336-2c718f1f1fcmr52163695ad.5.1781893697093;
        Fri, 19 Jun 2026 11:28:17 -0700 (PDT)
Received: from [192.168.11.106] ([124.123.80.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c742fdd411sm1484765ad.0.2026.06.19.11.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 11:28:16 -0700 (PDT)
Message-ID: <c5feff91-9303-492c-a031-1b2a1e7f3b7c@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 23:58:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: advertise ieee_link_id in vdev
 start MLO params
To: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>,
        Karthik M <karthik.m@oss.qualcomm.com>
References: <20260619-ieee_link_id-v1-1-36cf573cb81d@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260619-ieee_link_id-v1-1-36cf573cb81d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bODbtVo9CtfGKVUlVr98rcOpC8VFQKNl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE3NSBTYWx0ZWRfX6/DGU0C4pqsk
 5uH2VQkkX2RWpk/HNjtViaa8BjlOpvuqH33RLcnVnBHHfh4ECUh3wWso9rNaWR7Vbc4gFQU/YDL
 c3lXvTaSFrrZtaliD1T0PjKT+2rx8r1JXf8itt9qYvRa3WACrO9FcDlhfqaCSQSzy97HHX3cUN2
 Xq3C5abtUL5d/7yTLJ9BxfLCzhvV9D5wnmC15W0Im0bToJT8W60VCmaMC1bw/y/7VU9sFSfCAR1
 neAJUDd0bUQjtfpnbCCvpLDnwU+SjXt9r4K8vXBsNpfQOjkpxlm7w86cZPnbK4NX8CFFlD2bdLP
 pBdRPsfDHALaTo5i3jV6BiSJvmU1MCp61kzPJBys5mmh+D8F1H4quUGfovL/8+vdQXANo0YGmRx
 vk7RcGahyySp100u1s+rGc/Ezca4/DP2uN+/HJeY19eaz47G/lzAE73kmUbIafva2lPeyM/Za8J
 gZWRyhdlacVIFb9OAAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE3NSBTYWx0ZWRfX+CrpsXOnTwff
 K9XpDsCXcmlTkZxTXdhVdQtkBAxFgXnCCqM/GGEjkLgvT4MjkgHenndWGme7pXxr8NdXW6WkcmC
 aX5tHJaIe3wQBPDXTgc0G6olRIcPsA4=
X-Proofpoint-ORIG-GUID: bODbtVo9CtfGKVUlVr98rcOpC8VFQKNl
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a358a42 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=kllYWVK2JqQtNyhMtAlpJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=uAiA4dPe5keY1A96IBkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37928-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:manish.dharanenthiran@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:hari.kannan@oss.qualcomm.com,m:karthik.m@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 909196A75CB

On 6/19/2026 11:25 AM, Manish Dharanenthiran wrote:
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
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>
> Signed-off-by: Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>
> Co-developed-by: Karthik M <karthik.m@oss.qualcomm.com>
> Signed-off-by: Karthik M <karthik.m@oss.qualcomm.com>
> Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c |  3 +++
>   drivers/net/wireless/ath/ath12k/wmi.c | 32 ++++++++++++++++++++------------
>   drivers/net/wireless/ath/ath12k/wmi.h |  7 +++++++
>   3 files changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index af354bef5c0d..773ecd6da8e5 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -11253,6 +11253,8 @@ ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
>   
>   	ml_arg->assoc_link = arvif->is_sta_assoc_link;
>   
> +	ml_arg->ieee_link_id = arvif->link_id;
> +
>   	partner_info = ml_arg->partner_info;
>   
>   	links = ahvif->links_map;
> @@ -11276,6 +11278,7 @@ ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
>   
>   		partner_info->vdev_id = arvif_p->vdev_id;
>   		partner_info->hw_link_id = arvif_p->ar->pdev->hw_link_id;
> +		partner_info->ieee_link_id = arvif_p->link_id;
>   		ether_addr_copy(partner_info->addr, link_conf->addr);
>   		ml_arg->num_partner_links++;
>   		partner_info++;
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 84a31b953db8..a0e8b5678ae3 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -1228,10 +1228,14 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
>   				   le32_encode_bits(arg->ml.mcast_link,
>   						    ATH12K_WMI_FLAG_MLO_MCAST_VDEV) |
>   				   le32_encode_bits(arg->ml.link_add,
> -						    ATH12K_WMI_FLAG_MLO_LINK_ADD);
> +						    ATH12K_WMI_FLAG_MLO_LINK_ADD) |
> +				   cpu_to_le32(ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID);
>   
> -		ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "vdev %d start ml flags 0x%x\n",
> -			   arg->vdev_id, ml_params->flags);
> +		ml_params->ieee_link_id = cpu_to_le32(arg->ml.ieee_link_id);
> +
> +		ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "vdev %d start link_id %d ml flags 0x%x\n",

%u for vdev and link_id ?
Also this part of change is not describe in commit text.

> +			   arg->vdev_id, arg->ml.ieee_link_id,
> +			   le32_to_cpu(ml_params->flags));
>   
>   		ptr += sizeof(*ml_params);
>   
> @@ -1244,19 +1248,23 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
>   		partner_info = ptr;
>   
>   		for (i = 0; i < arg->ml.num_partner_links; i++) {
> +			struct wmi_ml_partner_info *pinfo = &arg->ml.partner_info[i];
> +
>   			partner_info->tlv_header =
>   				ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PARTNER_LINK_PARAMS,
>   						       sizeof(*partner_info));
> -			partner_info->vdev_id =
> -				cpu_to_le32(arg->ml.partner_info[i].vdev_id);
> -			partner_info->hw_link_id =
> -				cpu_to_le32(arg->ml.partner_info[i].hw_link_id);
> +			partner_info->vdev_id = cpu_to_le32(pinfo->vdev_id);
> +			partner_info->hw_link_id = cpu_to_le32(pinfo->hw_link_id);
>   			ether_addr_copy(partner_info->vdev_addr.addr,
> -					arg->ml.partner_info[i].addr);
> -
> -			ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "partner vdev %d hw_link_id %d macaddr%pM\n",
> -				   partner_info->vdev_id, partner_info->hw_link_id,
> -				   partner_info->vdev_addr.addr);
> +					pinfo->addr);
> +			partner_info->flags =
> +				cpu_to_le32(ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID_PARTNER);
> +			partner_info->ieee_link_id = cpu_to_le32(pinfo->ieee_link_id);
> +
> +			ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "partner vdev %d hw_link_id %d macaddr %pM link_id %d ml flags 0x%x\n",

%u for vdev_id, hw_link_id  and ieee_link_id ?

> +				   pinfo->vdev_id, pinfo->hw_link_id,
> +				   pinfo->addr, pinfo->ieee_link_id,
> +				   le32_to_cpu(partner_info->flags));
>   
>   			partner_info++;
>   		}
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index c452e3d57a29..51f3426e1fcd 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -2954,10 +2954,13 @@ struct wmi_vdev_create_mlo_params {
>   #define ATH12K_WMI_FLAG_MLO_EMLSR_SUPPORT		BIT(6)
>   #define ATH12K_WMI_FLAG_MLO_FORCED_INACTIVE		BIT(7)
>   #define ATH12K_WMI_FLAG_MLO_LINK_ADD			BIT(8)
> +#define ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID		BIT(18)
> +#define ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID_PARTNER	BIT(19)
>   
>   struct wmi_vdev_start_mlo_params {
>   	__le32 tlv_header;
>   	__le32 flags;
> +	__le32 ieee_link_id;
>   } __packed;
>   
>   struct wmi_partner_link_info {
> @@ -2965,6 +2968,8 @@ struct wmi_partner_link_info {
>   	__le32 vdev_id;
>   	__le32 hw_link_id;
>   	struct ath12k_wmi_mac_addr_params vdev_addr;
> +	__le32 flags;
> +	__le32 ieee_link_id;
>   } __packed;
>   
>   struct wmi_vdev_delete_cmd {
> @@ -3120,6 +3125,7 @@ struct wmi_ml_partner_info {
>   	bool primary_umac;
>   	bool logical_link_idx_valid;
>   	u32 logical_link_idx;
> +	u32 ieee_link_id;
>   };
>   
>   struct wmi_ml_arg {
> @@ -3127,6 +3133,7 @@ struct wmi_ml_arg {
>   	bool assoc_link;
>   	bool mcast_link;
>   	bool link_add;
> +	u32 ieee_link_id;
>   	u8 num_partner_links;
>   	struct wmi_ml_partner_info partner_info[ATH12K_WMI_MLO_MAX_LINKS];
>   };
> 
> ---
> base-commit: 63abe299b12b317dfee5bcd09037da4668a4431a
> change-id: 20260610-ieee_link_id-3424c332b216
> 
> 



--
Ramesh

