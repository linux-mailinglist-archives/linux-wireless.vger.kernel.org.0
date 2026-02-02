Return-Path: <linux-wireless+bounces-31473-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wANgMfDegGleCAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31473-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 18:29:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EEDCF9AF
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 18:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E0493007AD9
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 17:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47DF387341;
	Mon,  2 Feb 2026 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9ZFnHAd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AXdp1eOG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305B385EE6
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052939; cv=none; b=poQ00PkR7yt2SqAYsAqcn4yLfaij1O6Wru2ItY5JSLLJhGfFsj9JbQJADAKcwBzvhCNv4HcqZYYGx2Ic+FZjYXvAJfJF01iEvImsa9LaN7KymrqBGrb8DcIOOQKs2+Y0cdmndlgkzwc0dZjlmbbH8EcFYywaU52yqop0nRdIWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052939; c=relaxed/simple;
	bh=rquMsehpSYSAOR3Gg3KDdpdIadkQZ//E3bMlITQub3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzlnNCRfXN7mB2eT/pJtL/erBBAgFuQrpYziP2T55YDt7gmWh/Kk+RHaFJfFrMqXSSWWl8hU6P7vNx+xWSWhXChZjCjI0mz/gTsg2MNHONq7l16f0m/8LaWY2iVOv/gPpaja4aFJ4dtRTnYBvoaGXUplhAgiIxiVps5X18j3FD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9ZFnHAd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AXdp1eOG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612E718Y1642240
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 17:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7AR5LVVN/Omfv6smD6kCPeEqdPp2W6NMcMKzZNBHpz8=; b=E9ZFnHAdAlhagwg6
	y3i0kvn97ioXmH5xc/y0QXdHCP8QthZPvOVwKPT70nkRmASpm0BVxhm0NSvMI4Et
	3CusLHZJjOeQ4ooyAnojLFcFgpY5f53Ygl2OZ3nK6IAgk+Gs1kVMPeoxfAlBs8aA
	aUt4xHfImofU9qL+aBAi2oSnQALcXeoadk6pRLYqHr1XHCzSzlS8U0JvsBDFSMvy
	1cqGLG0k10LniMrpllKUxG7guIlGoWy1DLwR6ewed2Z4X3cOu/hRGcbpfapOO/eT
	1Bp6HxmFH9pOApmayFs8q0LMOHCyqSFShrRWl3O7YGxC0BKv9CIRpq4b/jEQNo2z
	lh2xQw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c23h1m0uq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 17:22:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a13cd9a784so41451705ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 09:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770052937; x=1770657737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AR5LVVN/Omfv6smD6kCPeEqdPp2W6NMcMKzZNBHpz8=;
        b=AXdp1eOGgcE8Dw2YLvqIEU2RaQD3v+4FuJe3QNVEXKPaI0W7iSxkseUwVQRqguTBa9
         9K5qoM9TL8njkHHGz+zHmiOlIxMPUAe6wDF8s19F3dMUJRkPtyHvTWbGF39auv4vEsr5
         xfpo6gZEJt4C9cBbdE4q5Pf6MLwkeS2UD/GPaDi99ftcwtGzZMfmvAbRK8uWV/laHZtR
         SDUArF5sUWek2ski7xz9kXH9rYCdJk5R4dewy4a8aEVw6UF+lAeHvSMDxM7OOqLWI9eP
         TDKpFwR6p7NEUx18fqwNn+UUiFgYeoarB7Wk18lB0toPDwnJd2W86wvw/WlkkYpZRLTd
         Aa1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770052937; x=1770657737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AR5LVVN/Omfv6smD6kCPeEqdPp2W6NMcMKzZNBHpz8=;
        b=OZrxKJ9b9nvsPkd15hgjsUY24QCTWA0qrocey0rbJB6CJM00nikorq1mFuvhRlVZaF
         CV0Tjy42RtFUP3HN6F+Ur84OCfJmlyuC51p4u+bmbIhaP7bXKWCnAzEpiUU1XM5qrCrA
         6DCljZ01gchMF6aRkKHu66ouVfyVnxdOuH07pS9cAY+MuXYIB8LvxcSEqJ5q2n0M9+Wd
         kAzUVsPJM8C5/4eBboSMsurAkjzbQAJYdUXjVz4qxPB0t4tlzJQh9mZBOjLrtT64f7k9
         aU5dN1zBwt2Ou+9k1yegzilhuquINpfo/nP9c0goeMPOozr8GeNsZpQvmFqErPYyVaSR
         AhAA==
X-Gm-Message-State: AOJu0YxFae3GKWyBbwzuXHTEYDvYIMEI7AYybBylBuUmAfgbhe5iX4Va
	K5L/AsewxOQVSDX1rwiilHcxf0Paa1Yqbryrsj3q7DXAeKusH+jfq324UctYuwApso8kPdj7mBc
	he6Kw9OPuObfYr65Y1BK4acGPSw1lrmy3QNGtugfSZs9znxZ8AUfuekPEnEa24Ut+EDHaOQ==
X-Gm-Gg: AZuq6aL2YMMPVnkEAxWurgCHpH1SYBeNPIbpopo3yEvkHIyLJPtVAXobQNyLohu+icu
	h6E18c6fi+ad9QgDEwvpNV/lp9DV4WkWk+2pOMbJhUJUtuc7RBE/1ZbuP1Sa6hMRTNpnQ3fpWxT
	7E/6ZeyVUaGippuSGLkPvVpZwkB/zDXOO57csJK3wxxygMESRJO7FvSKmtY0VH4sf6tk2fHviJP
	3LWi9b2mcaSd6uX58JYcxaGqK/p1Ixy96fI58vKl3tHi9zXCaI+uOwc8ZjrnLgp1DGJntDB4Ama
	XGIOIvMzc6h04BJNj4QZdxOV760qN0XMk1iYk7DJutdtnNLyRoEfNFk2ZaiCoJ3Dj47Hkrh9LL5
	Pt4sKZ/3PjN1euU3MfNL2f1SksiHn/7e602UheF9rH1y67S+H91xnh0wTiBqM
X-Received: by 2002:a17:903:a8f:b0:2a7:bd4e:db8c with SMTP id d9443c01a7336-2a8d9928986mr116706425ad.40.1770052936639;
        Mon, 02 Feb 2026 09:22:16 -0800 (PST)
X-Received: by 2002:a17:903:a8f:b0:2a7:bd4e:db8c with SMTP id d9443c01a7336-2a8d9928986mr116706145ad.40.1770052935980;
        Mon, 02 Feb 2026 09:22:15 -0800 (PST)
Received: from [192.168.225.142] ([157.49.220.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642aaf1308sm15918505a12.30.2026.02.02.09.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 09:22:15 -0800 (PST)
Message-ID: <9d457e79-0649-400b-8dd5-89d1ab00ebc9@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 22:52:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] wifi: nl80211/cfg80211: add role-based PD peer
 limits
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <20260130160039.2823409-7-peddolla.reddy@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260130160039.2823409-7-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Qj-7ok6bhrR9QuAl6t8YsMgCsfjD9ux9
X-Proofpoint-ORIG-GUID: Qj-7ok6bhrR9QuAl6t8YsMgCsfjD9ux9
X-Authority-Analysis: v=2.4 cv=Fu8IPmrq c=1 sm=1 tr=0 ts=6980dd49 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=QJnItKZWF5a8ZOS8l1mWfA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zC1egOS4pZa-INc8pIYA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEzNyBTYWx0ZWRfX4/VkWVInLL57
 Gx5nwd9AHdgtrD17ZaLe9BpnYgSThRibLPvSlIeo4YcKELfq5xQxQmi6R0pIlD5kE+7AXatlucn
 FxAcK+MphKxmq9LP1wIgAr3moSCBFM5JpuNv33LvBfmuA7BNRrrlqhYfVRVgL667X3d3z88/dEp
 PIksbUNWuA7hCM2M8E6Sa1RwchNBUoYtOwk6A0RNS0ckFs/nnVgVvSQX3p3QEBB2oT68F4r0ZPE
 gQ+RjcHzRc9eK0c9gdk4FaOryseZl1G7SDvFgwiclIrg0a+TBHBDz/NzZ58IRc5qCHO8sdqqmJh
 pMaKiCs5Hz3ViInv+UH8dXu3XqUxHnUqZocB9tJevJaeinKFRBG68IztcKBx6Djy+kHIKfHiJkz
 bqq1dmJQ1uBvFzkc5e8g1AgTl/jCGxPTKd8+6fGPN3WJbTjXq/yWMauTjyocJsy5U7EAqWKavNU
 8BQPM+aVPm/eXzkKiAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020137
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31473-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D4EEDCF9AF
X-Rspamd-Action: no action



On 1/30/2026 9:30 PM, Peddolla Harshavardhan Reddy wrote:
> Currently, proximity detection capabilities only advertise a
> single maximum peer count that applies regardless of whether
> the request is of PD type. However, some devices may support
> different numbers of simultaneous peers depending on whether
> the request is of PD type or not.
> 
> Introduce separate capability fields to allow drivers to
> specify distinct peer limits for each request type. When a
> device operates as a PD initiator, it can now advertise how
> many responder peers it can measure simultaneously.
> Similarly, when operating as a PD responder, it can indicate
> how many initiator peers it can serve concurrently.
> 
> In scenarios where a device supports concurrent operation
> as both PD initiator and PD responder, the enforcement logic
> considers the sum of both role-specific limits to determine
> the total number of peers allowed in a single measurement
> request.
> 
> Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
> ---
>   include/net/cfg80211.h       | 12 ++++++++++++
>   include/uapi/linux/nl80211.h | 16 ++++++++++++++++
>   net/wireless/nl80211.c       | 13 +++++++++++++
>   net/wireless/pmsr.c          | 32 ++++++++++++++++++++++++++++----
>   4 files changed, 69 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index a82d1606345a..ae63a3ead165 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -5716,6 +5716,16 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
>    *	multi-peer request this will indicate if the device can act
>    *	simultaneously as initiator and a responder. Only valid if @pd_support
>    *	is set.
> + * @pd_max_peer_ista_role: Maximum number of peers allowed for a device
> + *	operating in the ISTA role under proximity detection. Only valid if
> + *	@pd_support is set. Sum of both @pd_max_peer_ista_role and
> + *	@pd_max_peer_rsta_role is considered to enforce the max peers supported
> + *	in case the request is of peer-to-peer PD type.
> + * @pd_max_peer_rsta_role: Maximum number of peers allowed for a device
> + *	operating in the RSTA role under proximity detection. Only valid if
> + *	@pd_support is set. Sum of both @pd_max_peer_ista_role and
> + *	@pd_max_peer_rsta_role is considered to enforce the max peers supported
> + *	in case the request is of peer-to-peer PD type
>    * @ftm: FTM measurement data
>    * @ftm.supported: FTM measurement is supported
>    * @ftm.asap: ASAP-mode is supported
> @@ -5760,6 +5770,8 @@ struct cfg80211_pmsr_capabilities {
>   	   randomize_mac_addr:1,
>   	   pd_support:1,
>   	   pd_concurrent_ista_rsta_support:1;
> +	u32 pd_max_peer_ista_role;
> +	u32 pd_max_peer_rsta_role;
>   
>   	struct {
>   		u32 preambles;
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index b2410d4f572c..b6c28c75e141 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -7762,6 +7762,20 @@ enum nl80211_peer_measurement_peer_attrs {
>    *	multi-peer request, the device can act simultaneously as initiator and
>    *	a responder, where the multiple requests are being processed
>    *	simultaneously
> + * @NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE: u32 attribute indicating the
> + *	maximum number of peers allowed for a device operating in the ISTA
> + *	(Initiator STA) role under proximity detection. Only valid if
> + *	NL80211_PMSR_ATTR_PD_SUPPORT is set. Sum of both
> + *	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
> + *	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the
> + *	max peers supported in case the request is of peer-to-peer PD type
> + * @NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE: u32 attribute indicating the
> + *	maximum number of peers allowed for a device operating in the RSTA
> + *	(Responder STA) role under proximity detection. Only valid if
> + *	NL80211_PMSR_ATTR_PD_SUPPORT is set. Sum of both
> + *	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
> + *	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the

need to add % kernel-doc markup for enums.

Vasanth

