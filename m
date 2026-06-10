Return-Path: <linux-wireless+bounces-37615-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dlKmMGD6KGqfOQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37615-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 07:47:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26266665FFA
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 07:47:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=IxVJhcc1;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="WK/k3ak7";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37615-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37615-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 252EF3019FC6
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 05:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45542F6596;
	Wed, 10 Jun 2026 05:47:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA631F99B
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 05:47:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781070428; cv=none; b=j8OJoXrvTp0a8HhWnuLf1V9u2A9aFB+8VZH3DF2aUbLzA0nnRms5pJ74bWDLTyJzmYS7HYVZLEMmos+gb32wC+QvJJ3yMEMD9DHcPE5IArCx2WKaT3NP87nEqpaX3Y8/Y/GMNk8hsjq60YrZh1tRttlgy2V01HLbLkqsYHWddCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781070428; c=relaxed/simple;
	bh=ddHwpidLLnf7q9kplehLX4kwlBACPJoSIPP4b/6CqhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPy+6xO+q2cuhxkl39OK2UtKcD/7RgYSXwgUWsS5Ita13WbNevq2F/29hVX7PcIDNl4OlMnUq7QiZZesKnWacbh7lWD29lwUJ7lRODyMpGwhSsuZJ/Ho1gH6kGASTJ/I8rX9yN9b3E5hr0vhft8XP8c5tFIx0HG3j4prK4We4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IxVJhcc1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WK/k3ak7; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A45QuR387966
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 05:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ilf9Gb5vywUQDri0aR7Jt3+ZugqsWowi/LJkwrMVpbM=; b=IxVJhcc16SDq3vWb
	AooClzy1YkDqGWsUdXQPISn/pAG+pv2jDjRlrAPG1vtJCNb/CbA5bV3lZiPWQS+I
	HAJCGSQgaLk46oWBPSaweyoB8GJMLF7vaf21eqHMftcdiICNYrc5DZc0MPk0ka3S
	ZSivCAhhp7M9dIeLDvmX5Mjrj7itQUqnAocd/skkzot9kAbZboZPbxpdMVLhoJDn
	JRIPai81kOdlXHXCej5FMbBrZecCWt3gjgLohgRiUCwFpOnQP34HveacwUHpMGne
	nP/cp60m1D1PfTDB3kPURRb99iVlvbdXVPxmDY8PmliWNyic66RAnmc5yLjR32Vp
	H8HOLQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0kd89ej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 05:47:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36bba9b849dso6085115a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 22:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781070425; x=1781675225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ilf9Gb5vywUQDri0aR7Jt3+ZugqsWowi/LJkwrMVpbM=;
        b=WK/k3ak7gZJ71AHigX9VNo+QAOwJRY5VkwATvZ004dHZ/LL+lPCFvuEGBAFD1qprdh
         Io8AjTErx95Q/rlikwn0krBuvORdS94hdibKRNVCkOT6kNwedUP7qxN8mcjcIr/rEdwd
         a68uKZDG+k5tEADHhB3F+9ytrnMoHFAAYWy4/cJAPe80HCMUFvuMBG9wxDIKMR+c8s6J
         +NM6rFu8VWXD7XvzrXd6kBny8cvQKXMC+XHzLx3AAtrPtaP3m05GKm3lto+VxClup1g5
         5FhIljpuLO0eltDNfEf5gvGU+Zgx4bcipkrY502ZYEksJTIjLa3yeDaFhaeV12CMeP4x
         p36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781070425; x=1781675225;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ilf9Gb5vywUQDri0aR7Jt3+ZugqsWowi/LJkwrMVpbM=;
        b=JsNXPNJrreVto5tXuZ1YkFd/xjTu0p1mHyHQXzTngB0yWPWy794n52bVRVfwwMBpoO
         +dKM6sHsisbFNC/aQxptgCLQuwcQi7SD1H1QJhZnFNxkgJB/UPi34eL+fNM2oo9FrmUw
         Q291f8SrcQKwN4Q7QreQkXi37o86e7I/5fp4nxElPbqFajySeZb39oemnfDsUaKJGok+
         GK/CxP7KjOHwfRooK5p1Xlp+8ReFC1aJDISfJ8o9M4/sg4m2e00wm2jEtbWv3yFYiFTN
         5hJqbxVwyS0IRkb3vakd46n/OBgM7shhlBlW3USdSrNJkdFLymwaa7asWhhKtHJwcrCs
         e6mA==
X-Forwarded-Encrypted: i=1; AFNElJ9oGoJIb9m2rXU0cLU3qWzEeM1qDFbT/UVeAKkTsYJpyf36uyX1UOoiFppq+LxLmlLPUmmNe354ovfr1iv4ow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+DdVMxppQ7uOpWQnEBbPudM8kf8eR3ZkFN7KVkHlm0fjIFVMt
	UijDy940GVjHpYmnjtNsWPoNoW5jm9xm3R8A86SJ2QjiwaCEHWnFvQ7PqoIdTDpp04R/gjtqHOT
	nlNa9e6dqW70ONuK3pSJumFAn4Nx6he7H8jDidc5L/u65ZZUU2AN6zxed5gKWeUn2Qg1wJaPaCe
	gxdA==
X-Gm-Gg: Acq92OGxSiPs1SDLiiC0PKvBcEtxoQpGxsqMRe0u4OWB1Qeh4D6Ems2eLQsIgU1SKSJ
	/19Ov5Ua3Qji8P7RvlTACnCcMK77iOIqeE1zGeo1kGHAgEQ1/pw9/3CSRb6zmWbfBMh0JicfWYT
	Uk9aT3S4ibvTK1M69Vbh4q2QTb8M2jsjDOcKnu9MzrkIpW5MNFtxigswYB149ZP+iws5mc3Wcqo
	bY0ZGKT8fDWa2e0c/3UsF1uVJ3LHU0weGfbZX00CVYSUewVGqcnQKJcrKA8GWHlOvfzjehberib
	RkVlFzHfQWo0Vj6aWtuOLgG2Y6Fm4i7/vrSn7MG5KerNqoILzQKDe/pQdD9H2CsKxZ7hNDFPfrQ
	NkHlqjwt/6yctfQNtGqwn1Js31kU8OWeDyvh1w1faeAz1pFFwbDA5CXjhB7Z6Pd41nEvUC5RO
X-Received: by 2002:a17:90b:3f88:b0:36d:e051:7b6a with SMTP id 98e67ed59e1d1-370ef1f3c52mr24237144a91.12.1781070424197;
        Tue, 09 Jun 2026 22:47:04 -0700 (PDT)
X-Received: by 2002:a17:90b:3f88:b0:36d:e051:7b6a with SMTP id 98e67ed59e1d1-370ef1f3c52mr24237088a91.12.1781070423364;
        Tue, 09 Jun 2026 22:47:03 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37621852b31sm1387776a91.6.2026.06.09.22.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 22:47:03 -0700 (PDT)
Message-ID: <cc9185b4-741b-4232-8907-a85872c3cf59@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:16:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ath-current] wifi: ath11k: fix NULL pointer dereference in
 ath11k_hal_srng_access_begin
To: Gaole Zhang <gaole.zhang@oss.qualcomm.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: miaoqing.pan@oss.qualcomm.com, hangtian.zhu@oss.qualcomm.com
References: <20260609090609.4041009-1-gaole.zhang@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260609090609.4041009-1-gaole.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a28fa59 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=E4ruc0QeprPoJUAD4lkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: oNQu1YoC7zf0jTTjwJKJESbXmFWYphVF
X-Proofpoint-ORIG-GUID: oNQu1YoC7zf0jTTjwJKJESbXmFWYphVF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1MSBTYWx0ZWRfX55WPMw5fAdty
 65st24FBUUqoBlKZ6xVgjp9OtvJU5paDZN7r9bxsQogjMsxVKQG8dQJ6b7OsQLkb5pclN22Dn7m
 6LdBSqzEibCf1v9kEWCEOjX1Xso3VnF73i4e+i0HufUUHd+KyBYpU036CkVP4jBhme0ypEbGbZU
 mjiU8sT6UISb8EMwVSCdPB9YBrlwXTgLuTLOdTVauatENS13aPp04F7+VEC4Ujb7FAoRss+7hi/
 IjIQY2SFYMOYQ2ou3sXq/0DYX46ah+Kw7JxfMWA+6/nS9bsIp6iPlO55BAHX24g7zKz14lf21ae
 QZaxS1VNjRw3UQhtW42O6glOYcCyJIwf/GT1PbDuE1uvMg+Q/VxGOqbG8BuPO6xQbToMAWs+oK3
 bTbBgBEAakw+nYFSs5WaX+Heqw3VMU9au7pUyGpLU1GnO8+fLUvaEyDP73HUipfxNcG38t3uPAq
 CZltyde6mcLa0voGcSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37615-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gaole.zhang@oss.qualcomm.com,m:ath11k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:miaoqing.pan@oss.qualcomm.com,m:hangtian.zhu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: 26266665FFA

On 6/9/2026 2:36 PM, Gaole Zhang wrote:
> In ATH11K_QMI_EVENT_FW_READY, ATH11K_FLAG_REGISTERED is set
> unconditionally even when ath11k_core_qmi_firmware_ready() fails.
> This leaves the driver in an inconsistent state where
> initialization is considered complete although the firmware ready
> handling did not finish successfully. During the subsequent SSR,
> the driver enters the restart path based on this incorrect state
> and dereferences uninitialized srng members, resulting in a NULL
> pointer dereference.
> 
> Call trace:
>    ath11k_hal_srng_access_begin+0xc/0x60 [ath11k] (P)
>    ath11k_ce_cleanup_pipes+0x17c/0x180 [ath11k]
>    ath11k_core_restart+0x40/0x168 [ath11k]
> 
> Fix this by:
> - skipping firmware_ready if ATH11K_FLAG_REGISTERED is already set
> - setting ATH11K_FLAG_REGISTERED only when firmware_ready succeeds
> - setting ATH11K_FLAG_QMI_FAIL and aborting the FW_READY handling
> on error
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.2.0.c2-00204-QCAMSLSWPLZ-1
> 
> Fixes: 6fe62a8cec51c ("wifi: ath11k: Add cold boot calibration support on WCN6750")
> Signed-off-by: Gaole Zhang <gaole.zhang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

