Return-Path: <linux-wireless+bounces-32648-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JfMJCb5qmmcZAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32648-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 16:56:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4C72245CC
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 16:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C02B3128DB3
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 15:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34747366569;
	Fri,  6 Mar 2026 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cEnu/OnA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kSKvvwhe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537236C0DE
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812154; cv=none; b=aI4Hquh3nnebP/M29VYfhuQIQ18vijGddbssN8B088Pzq0psCf4jPia864lZryHV4w6cUS2hm5Zfg2hbyllFa2vwsPmpMTvai18oBCeyG+jsxDp8lfzPkAtHEU2xII4ZoguBB2Y63Vi/iTr38+dT/8VmXBSyqgcKe1c2v4w7vmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812154; c=relaxed/simple;
	bh=HltvsgB/V32MMRgrH+wmQKGVLrI+i/tqgjQTY4Hm9Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JewjYtlZscnFZP9/bMq4uSqSl7eYGOGmARQY73D6UEPE9f0isSb1VLt6RENDrk12qj7JFnewIPL5c5onBQhBYkAXzg8KzTR5cNdZoTbTBeCUKxoXF5OJacANTQ0RC/iVG5H+Z8sDi8ANqjqUPH4SWpvCmN0fdtL2nslzanNCSas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cEnu/OnA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kSKvvwhe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626FT74C027794
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 15:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0/756cthtUIgOJKo1UJZNjKGTLA8f8YYmW1bpSBDIWY=; b=cEnu/OnAC1cBRLNl
	4oQ9YSwsZrvBAX9vdKjIs9IzdOxhYHFFQ0EAkTpagLjsb1DfxR5yMosUQ3mz5pDo
	S0lStsQEKOV0jFVu6gcYfnTboyaow+s2cJOaGYaQfpvaYF+RmDLZPh/Ec3Q4HHzL
	Z4ms2RHS4O9mHg1ZDJsSdiKGKAVEjPMiGp0rVjpjmHAvTmzI7XmKLHrZcEGy0R4O
	1Pn0H6H086qujpi/XmdmZdKzDTWEaQZJn0ctv0+8fOqWxpWuTHXaPT4sSIpbZi5c
	jEt096fLWsPp3uPV3vFuKCWSlMp0pyiUXcI3mQVepsO1b163WXom9joVA8/cXTl/
	cA1vHw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqv98h5td-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:49:11 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1275c6fc58aso17579836c88.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772812151; x=1773416951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/756cthtUIgOJKo1UJZNjKGTLA8f8YYmW1bpSBDIWY=;
        b=kSKvvwheaYCL5qs3+i5/BvfecewIjzCRavjPYMdGGQmXchcsbabCeuCIug4SFzfhPb
         Aud6seKfQKmfhB9N4mNo6/1aq3P+hcCJVOhXi9TROOZ1IWGxBL3c+bqzJwSajPlakodt
         qV5sQ1377h7TDQx8cAQrYQBLXnDPTM5D9Q5ObtQWH/XDgEmwz3xi7jjs+Q3p3pgf6xEF
         pQXAtlCgRc1fdac43qr1VFguXWsisLs7sw/XwowqDeXu3/i0O9ZQwgFNmCl8jEeqCdOr
         IETAKnCN19M6ZypPuQvOS9BI6laD1a52vU+VTcL2QPgZqd5yl8/vC5b1VMdPwe8Ev59/
         bU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812151; x=1773416951;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/756cthtUIgOJKo1UJZNjKGTLA8f8YYmW1bpSBDIWY=;
        b=RH7ap0wj8R0UyduaAc8xdQ8W+aEBxS8eH7PUk5BGaTo4x6PJ+hj546YRb3vLU3TRKC
         iYxiz81NlUUHV9ulm3wWm+XEs+Nq8Ok710T3bLWOeJqUBKURL1BUXSjJRrvYbDCmLFVo
         ZDJCL7XaPhNRML6QH5cXvb0Gl54w+TnvXjhrrGcRgdeXrcEoyVMZ5O+i9NKWKxBs5AG3
         M/54HrgRsYq5jekjPWuNkkUYC8Aq9uOhrgJPF7t5HAPJpGxvSx5FqRuRaonHOW5TIJGZ
         QEgN/4i7aCBibHu7CLiPZz0Dfi4cf9eHJGOfkBdX6GSvSKlrC9kMa96iYxJDUQXXUNHj
         JMxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgubAPWB1FjyPGF8joRrzBH2rip2AvFsRCjllwArpfdVjvMcpF5pIDFAoogbDOvW+o67ZQ/sfLBWNMIC4Hjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJ+ECaxU74l68qNvpDqrw6TvCK5hlUKgpIA/tT8mAmrQZ/QtP
	7a1m5dL3e5GeaxBl6onBYXkXGUE19ZBwNFGSH+v3wcVpeIc3Zt9rXL+8FAErtNe83cREJMvLn6G
	6/0bqvigABqFw2UlzW1EDngQWYSPjr9lQWUG1zlUYdrzD7HnmI+5RRoZqAYXcEwc1k5ej7g==
X-Gm-Gg: ATEYQzz5kEOQTRYroohSBr4Iu1uABV97HzFv3cohqU+Ks1+oEnGn0+kpSAMvhfKzH0P
	PSfsoxCLO8yw6j2L5qjouL5g+h68RMrGJQwpDxZ4HBmVflmYQarkK9FUldQDfdslYtb9DJEzh18
	WE/XdoK4PrIiBQp1FNHYUcMWt5/VsXeNTBfytVzGeWmmZePKZgyRtipyifsT53V7DbahxBKMyG+
	husFa9GNTI34nrHGvXOe3aCi8sSF2UPb2m4oqOSz3JyyVskIDY4JVmewHWoxY1ENAU8JNQXVxrf
	QV2qwekdw/LVWj74H4bB/GxqxX7AOBZpEOk0+mjlklrxcRm40D25MQkjVHUcKzkK2qkHayFe1iT
	LdUwfiugs6+YFyMGXPSwK44cmcvaHulnl+8CgysIka395tLHqfyq6NSXq8/JH1Xfjs9cXgHmWTc
	AENvC1Kl9jurA1FQ==
X-Received: by 2002:a05:7022:6898:b0:11b:e21e:5653 with SMTP id a92af1059eb24-128c2e0c967mr1056279c88.19.1772812150840;
        Fri, 06 Mar 2026 07:49:10 -0800 (PST)
X-Received: by 2002:a05:7022:6898:b0:11b:e21e:5653 with SMTP id a92af1059eb24-128c2e0c967mr1056220c88.19.1772812150163;
        Fri, 06 Mar 2026 07:49:10 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3f58d24sm1497977c88.12.2026.03.06.07.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 07:49:09 -0800 (PST)
Message-ID: <00a7e65d-aad3-4029-af51-ff0870e65595@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 07:49:07 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
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
        skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260306105027.290375-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: x_tayd2wGLiPaDzVpfWtI1iU_6sef5-0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0NiBTYWx0ZWRfX8Rc6S0XpXwSn
 RateQI0udBihSkALxHAEQHaMtvxU1Plk2ivBFkz6jDlzlYsb8fD+Nghhu71sH/qffatjENvnbYU
 MFUs4Hb4aZTw46fovf3RLxOEcFC6YGPWRfm15CBqlyWn1n9atrZR4Tf6cfftfxp3UfUo+cZCeK7
 MHs3Nv8dQv78Bc2LBuVHvWLmgxwZp9UG21a3fW+0UjXSNyJnVvAhWJzfcxpoBHRSeHW68aJLfWJ
 d/OKHZdD/hYp03uG0wdPIwaVWLXUtdiuhnAnQINWjp4+8nm7Cbsc3QsLX2io2h4XECiYEZR4fR6
 8SXkgAvNmK82grGxmohmW5f4iQq+DoULZ4ygCa+XGeO/xamJGvnDIJS/2oHo/06RrU8/Pq/1lU+
 URUwhOoKJeHq5sI9ocfRHEV1pRq1T7u+ikWqdvEeL4UQZYrVMjPBnfn6GPfKX6WZU6k77dO0y7U
 esc6TKSpEei2tzVZzeg==
X-Authority-Analysis: v=2.4 cv=LbcxKzfi c=1 sm=1 tr=0 ts=69aaf777 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=PJDN-9afRshu8rMoDvAA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: x_tayd2wGLiPaDzVpfWtI1iU_6sef5-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060146
X-Rspamd-Queue-Id: ED4C72245CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-32648-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/6/2026 2:50 AM, Sumit Garg wrote:

I missed one k-doc warning...

> +/**
> + * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware

s/scm_//

Warning: drivers/firmware/qcom/qcom_pas.c:173 expecting prototype for
qcom_scm_pas_auth_and_reset(). Prototype was for qcom_pas_auth_and_reset() instead

> + *				   and reset the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return 0 on success.
> + */
> +int qcom_pas_auth_and_reset(u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
> +
> +	return -ENODEV;
> +}

