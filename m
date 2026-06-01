Return-Path: <linux-wireless+bounces-37267-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJcgE3SsHWoLdAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37267-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 17:59:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30B62230C
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 17:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44B1530138B9
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 15:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D423330F548;
	Mon,  1 Jun 2026 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="auEqehJE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Px1RCl2O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4BB3A451E
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329170; cv=none; b=sWyZStzicK+WSLPZDL1eFsE6UsHHIa+pS0TqEbBYiaJ10nq5zm+xiDdILpkt1KS320O76p/E3VTSX3r23Y4m9mJ833+VPcbPx/dXrhe6+CdyQ30q/un5fPvO24nWrAYNw9ZA3Gn2qapTDL4fH2e4YyN/Tq1ZddThh8L7LMBGwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329170; c=relaxed/simple;
	bh=cE+du1x9SVMbelcKzxLPLJjQ/raii+B2cOjDmRm6A2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQ/jAO6/uDH115Pd0RXPGcc6/G6LnsI0pftNo4PbLWJ2fl72ealoeWdt5Jne/WMcE6qXcNiCOGk8u1MWcpV+QQ+GUUIV3iz9H65WTJREU9pBw+XHnR+GLjx3WvZa5gDf9VaenRMYEvceMML8PJ51VryTaALXZPK4IKenOaShzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=auEqehJE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Px1RCl2O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651FFoa24110371
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 15:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C6FNzWGs4Z8LyHUZwseIEFziLsC8jN2t9jRwmXdWlBc=; b=auEqehJE5iU8qMIB
	4iQ+eya2g6UuqIuXhl3jot8nkvpMgZ13Lpg9dU5hAbiYtLgDCzfIml/ib5hzlX2X
	5o0CxP1llqOO4LmBrSMVsjCLhv1yxuFlUDxXpWPMx3rSUVJIwte4eP4w5rz3yP3e
	YqY3Oa7tFxvXXcU+xNcxdAYzQt05mA8Va3tOA7IgKK1PzFhFKuQ8V75xTzLRT8ja
	CHCPnwLNaM/NlQoW+N1K6n2PWbif3/cblJsCWkXPQVKpWXVvMPb7vK3lJBKDoDmm
	2LzUEPTrglE81TvrqYrq9bclw8l42MSqu40IwZR9zY9itCa/jumjAiJAs11Wk4A2
	6H0HHQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s3srtm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 15:52:48 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84240b58211so1189662b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780329168; x=1780933968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6FNzWGs4Z8LyHUZwseIEFziLsC8jN2t9jRwmXdWlBc=;
        b=Px1RCl2OHsoT35/cOa5D4k1fzwrtXQgl2BWzkd99McyPTQluZKONLaF95j5a6sw461
         AgwSaZsfTNaF2IRkyRNINBVIxI3dNE9dUpAHEAe5N3zUtUep7JdcpRv5JXPbOZg7qYjx
         03yzwPJe3/RRBs2Qa4d/wJ1k5ERsZfgf1BWWJ6glnuqHi4jVyUrG2uAfNsAGqZtnn9Tm
         7HvMwwr8JafrpVpBGs/FtTdTloqjUrNIGdaLIvoXvMlrtYb04PmmjsakGfmaFZ+QRR1Z
         MKl6ts5WKu60lMuInAZFcXxQ1MsbqIU87gcofMLINCLl2TnBO4zqPasoW3GsNv7yjLXe
         D8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780329168; x=1780933968;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6FNzWGs4Z8LyHUZwseIEFziLsC8jN2t9jRwmXdWlBc=;
        b=dG6HJOrGjkhfnHS5iel/ubBoFIO0FZchXm7tQwsXeaQBvDXy9iH1zzXJERP8b2vUeb
         7T0I3kXv7LS2Hl/kd1b/axjKw1zh5cbQVZKXjvxl3B+d4m7Qp41Bo++C3d4zuZ8Ks0hC
         /Nk/8W1RbpmmF6CzdZZX7ILFp707WnipAD3SH7qqSf7rK5CUoBwD+USWBbBm7Oew5YEl
         evuYeVCQ1MyrlE4Tzvw1+ViIt2yiYcW7XxtvPK/cHDtCTnbxdRpb4v1HE6JUUAjP6g1C
         DthWA5iWbZvxVeHzy/JzYmTtGt4tRgkNoI+07PsSbK3QhQekpBKAm7q9Bo7mXUPxPAoz
         hLRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NJVwAWDYN+BZNRmJiJBcA4E03Xt0dBnqVM0jRMLuxhPRAV5zfeIg3w77cLLPFK8JskufMasWSrbuywM94wA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WK1t2Gt1a/8VLWs9pi8HzKrv3sKxCAYEPTgU6M6xod+FMoYX
	SuOtvnL2bZti7QzuumSROxYl+6BtbRftWe3TZeJEYgkLK3nwBQbvjNZlu95AgO2TRxuK/+SX8cL
	9DGySkRXgZrKTZ0wlc+HWHsDCZdrH21k7xFjvKActaEdSh0+Tg85RrGEb7BQ9B0qFnWcGNQ==
X-Gm-Gg: Acq92OEfJ8c6Ddc5vcHK9fQBZwWTrJYdm+WPA0uSbnLjb+grI3kwiz3pMvUHgIfevMz
	F9YVo2SgKI14kVYhrHsL6xvTPfN079oyCfoD4uQicZE99U5+iw/S5+cWUvuE5NfkfjoRFN/R9WZ
	++Cn8T989hnqsxzymdKYpy/SCCOC6aiNsScbeINbVoIhpoPplP3/hQJBDBPQzOm3zzCUygbtcQQ
	pTsVHbB7nJBpwtZ4t2muNyNww7Lx7Dq3SBPAX9BjD4RIsNDYN99BU/vfavvT75rvGJpSRrBTfD4
	YMwf8Omap6z+MRlAK0T9orTOsfOJsOK0FG7Ul5Fa8kB7Yk9HRbbuS0AaD5npCu6NIYGfrOEq0HM
	/lN6i9gIVQ3h2t8nPzjYnhRMyNdmT2pu7v0VMqtnEok2OiI6ffBD8XWivKjaAVKiHOHsQP1/6uR
	jh
X-Received: by 2002:a05:6a00:12e1:b0:841:dcb5:e6f9 with SMTP id d2e1a72fcca58-8422535b96bmr10349461b3a.11.1780329168316;
        Mon, 01 Jun 2026 08:52:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:12e1:b0:841:dcb5:e6f9 with SMTP id d2e1a72fcca58-8422535b96bmr10349436b3a.11.1780329167784;
        Mon, 01 Jun 2026 08:52:47 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214ce9cebsm10503378b3a.52.2026.06.01.08.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 08:52:47 -0700 (PDT)
Message-ID: <98eb4355-1e4a-4389-a272-1c2277554fbb@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 21:22:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath11k: raise max vdevs to 4 on hardware
 with P2P and dual-station support
To: Wei Zhang <wei.zhang@oss.qualcomm.com>, jeff.johnson@oss.qualcomm.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260525020711.2590815-1-wei.zhang@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260525020711.2590815-1-wei.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AP3YypGC c=1 sm=1 tr=0 ts=6a1daad1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=DLlhXEFHjEEqyZQXiqAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1OCBTYWx0ZWRfXxNPfVGfxNS4Y
 2mLs+3r4r3j1INB96QRf0Yk/hUdqs8BOyNCHTPy0xqa+LjQf9R0kz+m1zXp6xgk/Qh7Njgrq9ra
 PzdMpWIZeG60VMEPIJpNzgsveTtGxs65zTcf0k0k+vGRsENi57Z1DuyG8imwQHcKEyE/CfitMzS
 o1VaeFfC+UQb2Nwbpo37QIHqYO3wtlruPnqB9u2TwAAeK4RHoaIG/3a2xVY+EdlxysR6ff3PkMa
 Hnz13FS8a8pqIOG/z6FIErhzjvvhCJL+e1+juSkkMa+3xPFnV6RFkmiXuwS6/aJ+Pg7BCDK0sc1
 KC7Igbl9lgs8QHl99DLGvILH3WYiwt020kW897+ufWVmudsgJeem1MbdG+Sd+64LO9ipioB5P2+
 dIN/8oWqpZRf2PbXOqzNiXgY3CEHPxDHoSfgZDU2nIy/1LytOJCmre8kGG5oNxRdWSIRM/fTOf9
 8HnJi+XkUbRDjArfgMQ==
X-Proofpoint-GUID: ATScwev-T2YreXBgG2J2lAMtdClu3qp3
X-Proofpoint-ORIG-GUID: ATScwev-T2YreXBgG2J2lAMtdClu3qp3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010158
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37267-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BE30B62230C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/2026 7:37 AM, Wei Zhang wrote:
> When P2P support is enabled, wpa_supplicant creates a p2p-device
> interface by default, which implicitly consumes one vdev. On systems
> managed by NetworkManager, this interface cannot be reliably disabled,
> leaving only two usable interfaces for user configurations.
> 
> Increase num_vdevs to four for QCA6390 hw2.0, WCN6855 hw2.0/hw2.1,
> QCA2066 hw2.1, and QCA6698AQ hw2.1 to account for the implicit
> p2p-device and enable common concurrency scenarios such as AP + AP + STA.
> 
> This change increases interface concurrency in the two-channel scenario
> by raising the maximum vdev limit, while keeping other combination rules
> unchanged.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.9
> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

