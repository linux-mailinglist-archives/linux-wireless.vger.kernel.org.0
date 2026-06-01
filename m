Return-Path: <linux-wireless+bounces-37224-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HGfKBH1HGrxUQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37224-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 04:57:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3A9618F8D
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 04:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10AF73001FA1
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 02:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0500113959D;
	Mon,  1 Jun 2026 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XE+R3HVj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LqAxsSrD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B5233932
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282574; cv=none; b=fDm2XCzAMoGbmYk0TV32AipwktkJpOSSPhtEsyNlIRDaktvYI9w+9uC+miuRpd8i0/R81fSIps4ys4M/x9GjNLtYYOCjDBVaOu+2ulydMv5icatleY7CGv45YTeNY6Ol5ktPDrqK6e6LXasVe4G2LuwL/M6cu7Ir0/j+6ABf3j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282574; c=relaxed/simple;
	bh=S63ah3d1k1AvOZ4GGP5J9CSSn3Ma++QVa/6BLbaRGwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGTKXFzq0Ie9PJczlizrG6nB/fPwvaJf/yBRGqWh1Xy0WGYyPfyafZpr1ZXfGl2G9XryxR/bIH3U+UTSJQtcDlMRroOCCmDa9e8vBaBKk6ubu9YDWjkU6ZyQk5/uO3i0Kgde9gN49kMrrusMQnBIroNEA2wPnUREbRP0gGAQGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XE+R3HVj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LqAxsSrD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6511UPBV540706
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 02:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FScdfpqO3IaIfAtuZmXNQ0IdFjaWTAtehJV3qDW9OTo=; b=XE+R3HVjXK8L+Q4E
	Ibf19pbAe6WFh+c+jFwBkbhaK77o2cXtIi5yIJWX/YftYkSzWa4uh/onjdXOZnVH
	YKPtvOEmUIG//2NejwnabjdIJ+54xcNmN9kE32XthYnHskLYVQN9jNF3rbj5GhR0
	qCBW00dHo4yv93vJ4emLVzVjrvlKCuduXe6D0vQZgYSi2oVeqDFJoNtGPrCyDOsA
	QswE9aoSO5s58SuIPM0ZIa8HNJNY6Khe4knFzSRcYF2YIUom+yeTfs/+FVTvYI9O
	S9gRSm+WbppLQ62sjw6vH5PaxApbMNXt9rawLQGWDzUnb8ka/zflHusK6gLnm123
	8IyqfA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efxy7vm7f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 02:56:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36ba24fcd46so2617645a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 19:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780282572; x=1780887372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FScdfpqO3IaIfAtuZmXNQ0IdFjaWTAtehJV3qDW9OTo=;
        b=LqAxsSrDup9AHJ+bNlBxf+ALuaUmSQG1K2sOHVaFBSkUrUEosuNUrNiO2cmqZS3/Dj
         eKexAuUMMBOKMuueGFbIBsT9Luz3ola36HM3TEBeGmcE/hc96OASI7BhsOYSSg0RLYC0
         wP81baQfTp+7dpMWPUvwTDirh6bQFHprEM9u/AfX8+URQ+ah4ko/ivmu9U9SIL5/vw4J
         yB0/kmWqD5F+ahyVpKlmZTtKt+0n9XPFxY9VY/FscquR1KHnlGUuQ+L9zo8xp+UeKame
         zb8d8B7XjzgEh6+Thfl4UggevJWZMMgoYm+JjpkCW0muRTsLJUFXFkN0kKFyg5AZO1jX
         7Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780282572; x=1780887372;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FScdfpqO3IaIfAtuZmXNQ0IdFjaWTAtehJV3qDW9OTo=;
        b=Qcp+lHWPHMvP3mN4ArZA9XfzNmpyeSZz8fEnkPZo1GECLTGbfQCl7HkZ8qF4p3E8pH
         LmeXudyT1YanC5xuR4Nw5XJoKZ1lKJUgrioAeN+NfvertvdH0WgUcH0+HCTkuCqfqmMx
         StFQJHBT2UPBEnzW3fTACtUAmFbBC6w62pSs4cAeaLWwQYwQpWUtjJIgmmn3bkwfdokw
         BpnShU6/kAU8r2HA/T/z/NUZbl+Y8qOUfkUIhMW/MBMfWzEmGdYq6tyySwmlRzkjxomb
         dwBM0Mu/cZwsaiY10BTNmtz+atcvpErmNDPJUdug+1m58gHm2GRDNhSV9LvQKtduaWeW
         vjWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9lr8eCDgxJjYCqoVUbrsiEXHevDhgjRthi54IvqcelDmAs8zOESS/5K6qlqfPyNZAIYo97ZZtYxhAjoJyiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6j8fXyOmMVBoi/jgBSddblrqd4gsJsRP4Qw1n1YKFrZn6smy
	E8xBItp14eoWeVAYBR5owYDWHwgukv1YqVGXseaiuWvT35X3RaCWAKv/wHOuKnkIXTuPGBP0Wt1
	C0hDKcBZPRz8ckQPP1Z0LZ67jB9EoML5uXWYRneGAus7dM4y8y0Q3Eqsy92Z9WkJA0RLt4A==
X-Gm-Gg: Acq92OG+MlKvRtzvBmgqlIwrhCRSU0K9p/jb84b8y7yb0bMFt2tf+Wdjafa+mCBggCo
	0JEuN4TNueXB2AvFVRos5k7u/pNbcPY8DFCKWIaSxyibT9GCJLHnLW8Q4+4zYxns37adsBWBjZb
	Q0U9aELEz5ba7PxJZWN5as11n9cW5DbptgQ2r7/LZ8v97zx1YoajaNlHmGVuR1YLrCvNtyHwTO6
	Mh0I7f2L/9+wETMlrQN3Qd8MW0+VUU0amqxENtKGw7Gh9i9Z3wr9IMaF+L2PfL9Y2KfC3TnfFOU
	ikw1eekHE4vU31VfbjGpK7moqXRZcgMqVe5KV8a0KmeyzF1S+kqvIAvQ70dTSi0qDFVNAl4JxcN
	gLZ4lnL9ki2fY3l6/CyptRo/y7vfYvXN4CB+hKx0vOO+I0bJBJArc5gORA/XXvsloZC3NTNthkr
	xLn09MYx7HzdDugPor1EajpMWxDfwQ
X-Received: by 2002:a17:90b:578c:b0:369:1dcf:4a46 with SMTP id 98e67ed59e1d1-36c68485445mr7996433a91.25.1780282572526;
        Sun, 31 May 2026 19:56:12 -0700 (PDT)
X-Received: by 2002:a17:90b:578c:b0:369:1dcf:4a46 with SMTP id 98e67ed59e1d1-36c68485445mr7996406a91.25.1780282572092;
        Sun, 31 May 2026 19:56:12 -0700 (PDT)
Received: from [10.133.33.22] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc5f6b9f5sm9066905a91.0.2026.05.31.19.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 19:56:11 -0700 (PDT)
Message-ID: <eb631b60-aab0-40c4-a99a-2ba721c862a2@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 10:56:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: fix NULL deref when MLO link
 activation fails
To: Wei Zhang <wei.zhang@oss.qualcomm.com>, jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260512044906.1735821-1-wei.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260512044906.1735821-1-wei.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POg/P/qC c=1 sm=1 tr=0 ts=6a1cf4cd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=CYK_csWaTfdBfrBFt_cA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAyNyBTYWx0ZWRfXyQmghuQDm5Lb
 nprDH+Bq8cd/vUXlTGeD+WvmuxskX9qep8CJ+G0zT7gqaQEtATA54T0B0HMvHUlwivGtAHSYuHW
 Y7Cbam3M0crx2ubKpIzp8gbhdebmchj4oShDfJjbQ7rWeo5CKlQsQKvQbyPq3+Bi6AHuRu2V4Jw
 Ex6aDb20BB/EM/gSymgItDcdM5YbYxmyJz2Du6qVeSAhuJ+okLwcsgR0BHQgd5O3H9E2W8Z0Pax
 YRJqxbR/1ke8pBkGwDix/Az+Jx1wOUCHMivHjrU+HmxPzgPOvRec2jUa6rYI5wxacwRBBhtzZmZ
 pKIey4khSQ1dCjxfs34HH+bHCYcRx/U9lJqVnK9UBhVdPWql2z4BkmvmoBhqL2r5Bu54v3fPUo8
 CYHdjWElZJVmD1SornOHuPJVYwxgsPei7Pmlw55Tsp+52gbN/wqXEb6rDwU58CVKzWSHJT0itwL
 HgXRhQouwxBHMRliuQw==
X-Proofpoint-ORIG-GUID: 0xS1TTNwJ7z7EDHxAmF1BRC_Ba8odSJm
X-Proofpoint-GUID: 0xS1TTNwJ7z7EDHxAmF1BRC_Ba8odSJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010027
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37224-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9F3A9618F8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/12/2026 12:49 PM, Wei Zhang wrote:
> ath12k_mac_op_change_sta_links() adds a link to ahsta->links_map
> before verifying that the link's vdev is ready, allowing broken links
> to be processed by subsequent operations and causing NULL dereferences.
> 
> Patch 1 fixes three error path inconsistencies in ath12k_mac_vdev_create()
> that leave arvif state or vdev resources inconsistent: a direct return on
> wmi_vdev_create failure bypasses err: which clears arvif->ar; and both
> failure paths in err_peer_del skip the DP peer cleanup and vdev rollback.
> 
> Patch 2 uses arvif->is_created (made reliable by patch 1) to guard
> against links with no vdev before allocating a link station, preventing
> broken links from entering links_map.
> 
> Wei Zhang (2):
>   wifi: ath12k: fix inconsistent arvif state in vdev_create error paths
>   wifi: ath12k: fix NULL deref in change_sta_links for unready link
> 
>  drivers/net/wireless/ath/ath12k/mac.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> base-commit: 7b25796f571fc09a7aa6fe7efb23edccd326917d

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


