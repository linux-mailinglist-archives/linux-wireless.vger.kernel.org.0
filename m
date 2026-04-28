Return-Path: <linux-wireless+bounces-35432-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOTWMrEd8GlYOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35432-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:38:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6877D47CD48
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B2D43044F09
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 02:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EAB3921ED;
	Tue, 28 Apr 2026 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XkULG0TN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i9kNPgvf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A50392829
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777343845; cv=none; b=ooJLDy+nuZBWsyIBMLjYrGE7b7tufA5GuoTPXSkFFZ0Km9uMsUdI47VjLth7AQdaQKx60uuaBF0bF2UnfOGNjrhmC4B5WbowOTaHX6SydFKILY653nN7qg7AYTgiS+uxFHbl3LrUoqGx9iOYHplyL+enRUMYAH4lkG39Lgihwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777343845; c=relaxed/simple;
	bh=vMLFJPMIZIbXRHwQOU/8SMObup79xP/4+Md3wrYjyqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttyDPvgfjXz89XpNxjRsyDHkFxIlD0psdyEiV4oXWNvrKirOyRfNAnZiJcW1SZc0B2KiRGYDNYRxP/wshvmEsjj2zTb4A0b0TKnelAgGpimYSlOFBxLySAeBzHREsC8Br0f78rUNAfkqngaGOA48n9B98X0tEPSNvg3LyLnd+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XkULG0TN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i9kNPgvf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RLpSFc241606
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5XLBDj/bqWKMsmb8JuJKdh5tlBW1FdM5yrjutqkC2sA=; b=XkULG0TNT66bFe5Y
	9T1dh5bDWjkdat+p02yP3NsQR59f3kSgcxIienWVHATMlG3UmcDioZKhTHpYzYtv
	3ZEfiB4RP+Be/1nneZfygxRx4/MNHEpDlfgq390aOUs8c8Bdr5qxbDqg1n/U/45K
	6udtQWUxf/QqAgeCsOfjyAiLDdLNtbi/u83aNCBwNn55TG2vx9WgvemiNjGdlEHC
	AwR2Wy7m1tfbaDLXxn/QzrwL4kLjdBg0EtmGOA3gWNp9PCmsXOBxaY7/RC7O3ejZ
	coBXbU2zR2xxR4NB+PWC1T737LFsOPpSmcR5G/ExYubxdp+eYimq+QxAYgpGO0Xq
	2PW1Qg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt946tj5w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:37:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da86144daso10403757a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 19:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777343842; x=1777948642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XLBDj/bqWKMsmb8JuJKdh5tlBW1FdM5yrjutqkC2sA=;
        b=i9kNPgvfim4Gebkq+scpmK5nguVQhBDhfdiuMwLNTk7wc2EmuKnlQ2J7ht9Em7seHV
         qqG8CUoeeUhxuCyDUO8+R7cYyLgsGlCrQDeNixPjs43jEao/kj2twVAfEamqtwUVvjil
         WebMN+S3zvmLQhYyuAkd4P2myylvNFf9DTcwZXbKRKfSKuuA/gN3K4PhFniDo45ntYXU
         c97yikWThDH4N2qhUPJl5Mm7UTH7SWlYjtK3XmUnvPm+9GfZYFJ58rsDe3e0nVTz6cIk
         fJTacMRWLhBRRKuEe3qnAFAJzuiQTGMPMQkcKrLk7xOmEchQ7vam2RMZN5flGEhZCP3e
         aEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777343842; x=1777948642;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XLBDj/bqWKMsmb8JuJKdh5tlBW1FdM5yrjutqkC2sA=;
        b=gqeRqZR4RU7e6Fb+r/xU/ngZt3UJ8couLkh3ktZ7iFbTEvrrQ8vYxQ8lCwKtjCbxHW
         iHz8vCqFLFj3Sn28vLRmT12gXK1rwb0SqCakqpPqPrNRRKu9G/u3L5y44/lMagarbKaq
         AqSXu3kta5R9nJK9iiidEQ7FmSVqRWL1CfzYeB+LE61f8wAA/1yZJXiB2oS2y5FlfXvP
         r9mxbiGuQv/aMG/RcxBA4Ws4/ftHn8ULLGcse3Ix7k5E6+SZcI+o1vcQGiAhOB9y/p5/
         gqN4IQ42NyLMVD9wGmlmRXSrkdnl5wNzEJ5zJF8hS8k9FCbDP7tnfwlYk9SSA22vTcqe
         AObQ==
X-Forwarded-Encrypted: i=1; AFNElJ++ioy1jfbPBjDP/QnJqdvw35ZP9p3oZCLaXUUkn+xMmuYQpDL1Sv+t9tFoA2KMstdLglMuGw21+zlLElcvIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jqee8ze7neTlDX9nXR4U7n4lmZNbUjd97/9rOuQTRkcZKskd
	DDDUEIeC73UJYwNwTMqv2zKYFJa/6jBPoqottB1WoEg8M3aOLV5F8NHTblxGU2OJBGXhbTQsMOO
	iGVOQjwDWhsT0zFo2z1/iUQRAnvO9lvHHH+oSmOLKmBBVa5jBECAgZizHOElVT1eMRDV7d2Xjbp
	kOI57J
X-Gm-Gg: AeBDieswPwaLDJbbcedfxztLFwBEfyrOLSrgEtAcZ6xmYD4KWucuq7GQRSPwtva7BrL
	jbinzGLKW0tYbGdR/UYyvhamvdrF6S7FR8RpsGxejmMufNpZN7RN7lHKSrCqejLuLscR36EVxkw
	3Aryuac8L1WhYeVE3MViRgdoZJj6SoyEchqzJ2Wwtxql76V5VcL6+MRlqpvjzlOJEXbV7b9MX+c
	QVtoRLVqQr+l+EzzjU9BIjxZnJkgwfRkYp3ae3/uO1iv+nXIwJhsBlUM/0O/KauH0z9JNYRLfeu
	zlUwDO5K6QU70i60qCEleBoLcS7MMGzNB69V52RIwpQ12TZh2W6bRm3J4SUfhl/rrCDgumDBvxf
	kTv8nvTmvNCbfRyp9Ed89K4iQmgy8PBF/2njwN5PEqrVGS3vuppFEq92ykmz8nQOhgE+OWiqzCj
	QoNskr/uedsris8NOuX3vmIcFqPDJF1w==
X-Received: by 2002:a17:90b:4f91:b0:35e:5051:fb18 with SMTP id 98e67ed59e1d1-3649206916emr1071937a91.26.1777343842120;
        Mon, 27 Apr 2026 19:37:22 -0700 (PDT)
X-Received: by 2002:a17:90b:4f91:b0:35e:5051:fb18 with SMTP id 98e67ed59e1d1-3649206916emr1071908a91.26.1777343841595;
        Mon, 27 Apr 2026 19:37:21 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490cb3f98sm328583a91.13.2026.04.27.19.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 19:37:21 -0700 (PDT)
Message-ID: <263f598b-93e8-483e-95b6-3ba9b19ee8f9@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 10:37:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 ath-next] wifi: ath11k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260421231205.77361-1-rosenp@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421231205.77361-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YcWNIQRf c=1 sm=1 tr=0 ts=69f01d63 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: NidN74s3-mpqoQME-XTqucst_4B-7n7W
X-Proofpoint-ORIG-GUID: NidN74s3-mpqoQME-XTqucst_4B-7n7W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAyMyBTYWx0ZWRfX1uFyqRJa+Tvc
 0rY+zjvl43wA2pYbIalDPOVX2GTwgUO5Zae+HLdVaU2pFPyMHb2qJCcy2IHoTpC6MiTYV4wHdfD
 v2o47yR7S3CRT4WPG+j1e+zSFWQMX6mb550aZopDPJcUBs9d4f9vRAHRPJ5fBEAzBC+JnnEHqjF
 Ug16Y4mOLs319Fa3aOWb5mDM7qYR7Ouxx2KSU/pGSLP1qNA7uKvwXAxER4Km3ygUHY+h1grG8ct
 kgie/qCUtMwUr5vXvu8lgaKORqRiyXp3OskWwoUnoJP0YxdiHr6tUlCOmsGkSc8E3e4K+jMXAdm
 2qQt6KHthuBssG5sY7T3SBdz+bTW6BcRv/J3rHBraagRQDMhs+bnBGGKWNJLziplHGmbBg/c8Qa
 bA9Bb8sMuWP6MWaNez5LUXHrUQZ2SLyTxV+Q0DOImtayESuJkUeksWhmh+ouu8kEHWKqTNPqh+7
 U98l1H322gXPJS8SiGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280023
X-Rspamd-Queue-Id: 6877D47CD48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35432-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/22/2026 7:12 AM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


