Return-Path: <linux-wireless+bounces-37167-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD02C3QpGmrQ1wgAu9opvQ
	(envelope-from <linux-wireless+bounces-37167-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 02:04:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 867FC60A03F
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 02:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA403035245
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 00:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4307C1DE8BF;
	Sat, 30 May 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SPjJSPV+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WnkT8HOy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B413635E
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099274; cv=none; b=LZi8W8TrPwh1jKmCyZX+60hChEaAQQ/IhV1YI+RgKBn5lfwY2EtEWnpZSJ8LbGsOTvAPFGbxXGcKku922fwUbZ2vcxrQhePnMTwHrmU3f+qKI72aak/HtxDbHJl558GtZZPPztxbi2Inf4tOM1/KEK+BOYAqPcT5sRf/yOOTDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099274; c=relaxed/simple;
	bh=UagpOC7gFmND7+vIy3Ut00Mk3Or7YtH3/4V9U4a1Erg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdpQYOKDnNFRu4Ul6rrx8GPuAe17KRSq+Eg8GtS/TfH5eAzr3Kqtibjn3Ya1sD/owKRTPI5IFhPIaZaUVhq27kwti43awOHgvNbUZWi+VNSbYOe9qYooCfbZpA+76AeHTxU4168vLNzs19J4c36xYHwHV19YLJo2428yHcJwpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SPjJSPV+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WnkT8HOy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TIQWhv876851
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 00:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UpywO6SkDOjlP3BMRqeWEdeabYg7GdsoNqQc655h+qs=; b=SPjJSPV+ZNlrAoQn
	ZHxh7mmtcvDOm1MYocHyO1ZEIhJMunDrcUhCqbHQLdAuI1BDF0Ql+/oIxZZmLhic
	FMywCJ1j1ahva4KoZ/rxXJd9C6M2ukZJnKaGcjwlFY+lmggD1+zjUQEK3OhXBnik
	Vgp86RjtLCvAfK3PMeDe9To2Pd3DVU4F8TpzWHeU1v6zbLRjefpWtPbnu7PZrNLc
	wMOA8NTRrBZ1eYh0tygVzbxKYMzbVKSKu++zKen9u+LT9KSbwllVS6868krliWEj
	GtjURwWxPyZUkGTvu1MFVmLMZSMfK1LE8CERJZbpk0eeMIlgTqk3HlXB9YAQJI7T
	8R/e3g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg3416sq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 00:01:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304f23c55b2so1121068eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 17:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780099272; x=1780704072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpywO6SkDOjlP3BMRqeWEdeabYg7GdsoNqQc655h+qs=;
        b=WnkT8HOyA0GecyHNyl642NI4qhMl4SDkqLC1uGxjj2rX07j/w9V0m8U3DTkYPYPJeO
         2lPInEnp6XdRzkCX8xr41A4qqN0Xbi4AoCw3BgiSmlypn1+4zgZL6zH5xStDV363tQkP
         uP1hfzvbTfuRkm1iUSK2ZKYw0cik0ZgfRS+xNRB5KcToH+JttNjj6zoBoszGzhe4+8aJ
         xg/M/Y/xfjvm7m/ovWSXiqRAX4114p+Ea12DyUUeBW+AAqHJnJqT/SYJuEB/o6pl96bF
         QdpaZ89EKO4D54iznnYbvXsAubJ0l0bUrUTHzUztYR1ZOdj5XWuw1WT0q1N0AEdRvZsu
         zR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780099272; x=1780704072;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpywO6SkDOjlP3BMRqeWEdeabYg7GdsoNqQc655h+qs=;
        b=nOnxw55vfHw85qkhP1DAefMVc8ohHgZ/I9995YON2+nge/d3SeDVuCB7Roj3OpvM2j
         EJ4lYEVLPol804Y2NJCC8sEx0psmCqXaRpTS0wgTo17h2Fy+8QaADZkepHWbmmIKCPQK
         4xhYk1xSYroMPbdvwECCxW4uHEBQPogAH1YWo8DdDk36xztfQ9Hil+Yu22r3Xlqbd1bt
         OyRQZR4rAk/RPWe7iUUPc+ExQIDjOKP1gO5r0/dsMSJIbYdELgR1uBmERmDI7WCyIHjK
         PXFhYi6JDDwxI0eBmHjbWkLrl5tMuzEOnsXCIK8Ndbjp9ucJwj/Dns/dbRqbv1wRx3dT
         hohQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QzB/WDH9D+GNdZGx60v0fwudzgOCvGzhPcCeE6yJgxNrPvMFJmc6+6BSGvDOKaX8c7B7GScau0IinuRonlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXdDYfVSslpQ9TbUFrLvxjX28rzw1IAnd5wYlslVV4IOzDuSx
	zKe0Syi8t7yPN8mdMqBo1ISrO02F7xreseiub32zYlnuwEiVBZT0XKV+gNMM9HuqiSXMPYsiqNx
	aV/vbFt7kHiIk0fnBvEaTHE6BUJx6zqEHJmGLaA78n5C7pdlM16ghENwD3JTeuv7gpAAEMw==
X-Gm-Gg: Acq92OGqz1/74V8L9WGitNbH4Qcq2kdMJD5R6GDC2Xnaa6j9v75JZiCuxKYYXNwSawW
	rySNAPBho6atQtDg3AlZAQxrS3ttldg116w7Y7B95W2Yc335x4AJKAMgYRvqmvrOhW7h+wCLI2c
	keL0Gsu5UJGNQqOuanJ6DgPnKnmfc8I0E6G1lAk+XpJuQqsDRMhlw9VCIdlMwC7aVVoMF7qii8I
	mPwM2hC+KzKslGIMSyNoSga1H31g1YNQt+uh1LDdSa7UsOvj1RKp5+H84scDa0Mg661K/d8F1u0
	EDQIdXDNFHUHoHJSavwlgdnjYsfH2U79Pf/Ao3MNGJjxoFqemGK3n35voyqvKNqXic8IiRdzBEi
	4PxquxWf/BYHblCcLZprS+g6Uvj+IXtl5rtNCX1ExFCcWcqmyqU5aaPJqiUMvzA+xGpoUy458N9
	CUKiLCMXg6R2Q9Wq6KRrikjMWH
X-Received: by 2002:a05:7300:5729:b0:2ed:e14:e954 with SMTP id 5a478bee46e88-304fa6dccefmr962723eec.30.1780099271394;
        Fri, 29 May 2026 17:01:11 -0700 (PDT)
X-Received: by 2002:a05:7300:5729:b0:2ed:e14:e954 with SMTP id 5a478bee46e88-304fa6dccefmr962652eec.30.1780099270745;
        Fri, 29 May 2026 17:01:10 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d5385sm2693818eec.28.2026.05.29.17.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 17:01:09 -0700 (PDT)
Message-ID: <4bf20c0b-f153-44cc-ab83-cd0251dabaff@oss.qualcomm.com>
Date: Fri, 29 May 2026 17:01:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] bus: mhi: Drop controller runtime PM callback
 indirection
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Loic Poulain
 <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        vivek.pernamitta@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
 <20260522-mhi_runtimepm-v2-2-fbebf41a82bb@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260522-mhi_runtimepm-v2-2-fbebf41a82bb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1Eh1d5fmg3nXnyUmInrj-U0ufEyrxJG1
X-Authority-Analysis: v=2.4 cv=EOI2FVZC c=1 sm=1 tr=0 ts=6a1a28c8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Q7cftjHEbLmqyJcuSDAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 1Eh1d5fmg3nXnyUmInrj-U0ufEyrxJG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIzOSBTYWx0ZWRfX0fXssD/xwfiz
 A3tcLOsfYXf/qWcdneOl7txdw5wPYUkpfrpUxyRhqJ3I668BAKFjfZornhrquM0EOpi1MrTQspO
 FCRaTVYbvDWt6vc+VBpbKKt16Ya8ciXf7TQQaCjLhiToXgGYmEI0qCLPGRGHTcwGMDOk5XwPMBf
 EuZ/ex2VWLBH2aagoYOUZlFg8kKrXWmx7hzGp7jAM20TzFW0aa/bQT3V2HsjOyW3e6sSrjSCZue
 hKswh2zDsFpSZtuk3805eCtrZBQ1mJhuD8mMMMP/hacIcmf51sm8bad4wBUVAO6axS1j+Sr5qGe
 y4sBtaSREx3ocQ8gnAgi4rWsf2CzSIa6eZ+A2f4U4nGApufkGAFHRRiy2Iwyi9Cy8nzdNvVrafn
 u5NxeJD1dbN/tTySV92/WOZIyDCx7QiMvGbqigLjfd55bDP2dL26PMhoAOFMC/X6TTxXM/+oNr0
 R7o0cbEa30rYejUDQGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290239
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37167-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 867FC60A03F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/2026 3:00 AM, Krishna Chaitanya Chundru wrote:
> The MHI controller interface exposes runtime_get and runtime_put callbacks
> to abstract runtime PM handling from the MHI core. This indirection is
> unnecessary since the MHI core can directly use the generic pm_runtime_*
> APIs, and the existing implementations are either no-ops or trivial
> wrappers around those same APIs.
> 
> Remove the runtime_get and runtime_put function pointers from struct
> mhi_controller and update all users in the MHI host stack to call the
> standard runtime PM helpers directly.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---

>  drivers/net/wireless/ath/ath11k/mhi.c | 10 ----------
>  drivers/net/wireless/ath/ath12k/mhi.c | 11 -----------

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


